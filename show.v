module show(
    input [6:0] in,   // 7-bit input value to be displayed
    output reg [6:0] out  // 7-bit output for the 7-segment display
);

    always @(*) begin
        if (in == 7'b1111111) begin
            out = 7'b1111111;  // If the input is all ones, blank the display
        end else begin
            // Individual segment assignments for standard 7-segment encoding
            out[0] = (~in[3] & ~in[2] & ~in[1] & in[0]) + (in[3] & in[2] & ~in[1] & in[0]) + (in[3] & ~in[2] & in[1] & in[0]) + (~in[3] & in[2] & ~in[1] & ~in[0]);
            out[1] = (in[3] & in[2] & in[1] & in[0]) + (in[3] & in[2] & ~in[1] & ~in[0]) + (in[3] & in[2] & in[1] & ~in[0]) + (~in[3] & in[2] & ~in[1] & in[0]) + (in[3] & ~in[2] & in[1] & in[0]) + (~in[3] & in[2] & in[1] & ~in[0]);
            out[2] = (in[3] & in[2] & in[1] & in[0]) + (in[3] & in[2] & ~in[1] & ~in[0]) + (in[3] & in[2] & in[1] & ~in[0]) + (~in[3] & ~in[2] & in[1] & ~in[0]);
            out[3] = (~in[3] & ~in[2] & ~in[1] & in[0]) + (~in[3] & in[2] & in[1] & in[0]) + (in[3] & in[2] & in[1] & in[0]) + (in[3] & ~in[2] & in[1] & ~in[0]) + (~in[3] & in[2] & ~in[1] & ~in[0]);
            out[4] = (~in[3] & ~in[2] & ~in[1] & in[0]) + (~in[3] & in[2] & in[1] & in[0]) + (~in[3] & in[2] & ~in[1] & in[0]) + (~in[3] & in[2] & ~in[1] & ~in[0]) + (~in[3] & ~in[2] & in[1] & in[0]) + (in[3] & ~in[2] & ~in[1] & in[0]);
            out[5] = (~in[3] & ~in[2] & ~in[1] & in[0]) + (~in[3] & ~in[2] & in[1] & in[0]) + (~in[3] & in[2] & in[1] & in[0]) + (in[3] & in[2] & ~in[1] & in[0]) + (~in[3] & ~in[2] & in[1] & ~in[0]);
            out[6] = (~in[3] & ~in[2] & ~in[1]) + (~in[3] & in[2] & in[1] & in[0]) + (in[3] & in[2] & ~in[1] & ~in[0]);
        end
    end

endmodule
