module BeatTheClockBinary(
    input clk,                // 50 MHz clock
    input button_reset,       // Reset button (active-low)

    input [4:0] in1,          // 5-bit input for player 1
	 input [4:0] in2,          // 5-bit input for player 2

    output [6:0] HEX0,        // Display for winner or units of Timer 1
    output [6:0] HEX1,        // Display for tens of Timer 1

    output [6:0] HEX4,        // Display for units of Timer 2
    output [6:0] HEX5,        // Display for tens of Timer 2

    output [6:0] HEX2,        // Display for units of Random Number
    output [6:0] HEX3         // Display for tens of Random Number
);

    reg [4:0] counter1 = 5'd30;  // Timer 1: 5-bit counter for up to 30 seconds
    reg [4:0] counter2 = 5'd30;  // Timer 2: 5-bit counter for up to 30 seconds

    reg active_timer = 0;        // 0 for Timer 1, 1 for Timer 2
    wire clk_1hz;                // 1 Hz clock from divider
    reg button_reset_prev;       // Register to store previous reset button state

    wire [4:0] new_counter1, new_counter2;  // Subtracted counters
    wire cout1, cout2;                      // Carry-out for subtraction

    // Random number generation
    wire [4:0] random_value;    // Wire for the random number
    reg [4:0] displayed_random; // Register to hold the displayed random number

    // Game state variables
    reg game_over = 0;          // Indicates if the game has ended
    reg winner = 0;             // 0 for Player 1, 1 for Player 2

    // Instantiate the RandomGenerator
    RandomGenerator rng (.clk(clk), .random_number(random_value));

    // Clock divider for 1 Hz clock
    clk_div cd (.clk_in(clk), .clk_out(clk_1hz));

    // Subtraction modules
    Subtractor5Bit subtractor1 (.val1(counter1), .val2(5'd1), .finalSub(new_counter1), .coutSub(cout1));
    Subtractor5Bit subtractor2 (.val1(counter2), .val2(5'd1), .finalSub(new_counter2), .coutSub(cout2));

    // Edge detection for reset and pause buttons
    wire reset_edge = button_reset && !button_reset_prev;
    always @(posedge clk) begin
        button_reset_prev <= button_reset;
    end

    // Random number update logic
    always @(posedge clk) begin
        if (reset_edge || (in1 == displayed_random) || (in2 == displayed_random)) begin
            // Update displayed random number when reset, pause, or match occurs
            displayed_random <= random_value;
        end
    end

    // Toggle active timer on pause button press or input match
    always @(posedge clk) begin
        if (!game_over && ((in1 == displayed_random) || (in2 == displayed_random))) begin
            active_timer <= ~active_timer;  // Switch between Timer 1 and Timer 2
        end
    end

    // Main countdown logic
    always @(posedge clk_1hz or posedge reset_edge) begin
        if (reset_edge) begin
            // Reset both timers to 30 seconds and clear game state
            counter1 <= 5'd30;
            counter2 <= 5'd30;
            game_over <= 0;
            winner <= 0;
        end else if (!game_over) begin
            if (!active_timer && counter1 > 0) begin
                // Decrement Timer 1 if active and not zero
                counter1 <= new_counter1;
            end else if (active_timer && counter2 > 0) begin
                // Decrement Timer 2 if active and not zero
                counter2 <= new_counter2;
            end

            // Check win conditions
            if (counter1 == 0) begin
                game_over <= 1;  // Game over, Player 2 wins
                winner <= 1;
            end else if (counter2 == 0) begin
                game_over <= 1;  // Game over, Player 1 wins
                winner <= 0;
            end
        end
    end

    // Display logic
    wire [6:0] hex_default = 7'b1111111; // Blank display for unused HEX segments
    wire [3:0] display_winner = (winner) ? 4'd1 : 4'd2; // Winner display: 1 for Player 1, 2 for Player 2

    // Use the 'show' module for all displays, especially for the winner
    show u1 (.in((game_over) ? display_winner : (counter1 % 10)), .out(HEX0));   // Units digit for Timer 1
    show u2 (.in((game_over) ? hex_default : (counter1 / 10)), .out(HEX1));   // Tens digit for Timer 1

    show u3 (.in((game_over) ? hex_default : (counter2 % 10)), .out(HEX4));   // Units digit for Timer 2
    show u4 (.in((game_over) ? hex_default : (counter2 / 10)), .out(HEX5));   // Tens digit for Timer 2

    show u5 (.in((game_over) ? hex_default : (displayed_random % 10)), .out(HEX2));  // Units digit for Random Number
    show u6 (.in((game_over) ? hex_default : (displayed_random / 10)), .out(HEX3));  // Tens digit for Random Number

endmodule
