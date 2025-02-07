module clk_div(
    input clk_in,          // 50 MHz input clock
    output reg clk_out     // 1 Hz output clock
);

    reg [25:0] counter;    // 26-bit counter to divide 50 million cycles

    // Initialize counter and clk_out
    initial begin
        counter = 0;
        clk_out = 0;
    end

    always @(posedge clk_in) begin
        if (counter == 25_000_000) begin
            clk_out <= ~clk_out;   // Toggle clk_out every 25 million cycles (0.5 seconds)
            counter <= 0;          // Reset counter
        end else begin
            counter <= counter + 1;
        end
    end
endmodule