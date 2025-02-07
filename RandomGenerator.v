module RandomGenerator(
    input clk,               // Clock input
    output reg [4:0] random_number  // 5-bit random number output
);

    wire feedback;  // Feedback wire for LFSR logic

    // Feedback function for 5-bit LFSR, using taps on bits 5 and 3
    assign feedback = random_number[4] ^ random_number[2];  // XOR feedback from bits 4 and 2

    // Initialize the random number outside of the always block (only once)
    initial begin
        random_number = 5'b10101;  // Set initial value to a non-zero value (any value)
    end

    // Always block that generates random values continuously based on the clock
    always @(posedge clk) begin
        // Shift the random number left and insert feedback at LSB
        random_number <= {random_number[3:0], feedback};
        
    end
endmodule