module Subtractor5Bit(
    input [4:0] val1,          // First 5-bit input
    input [4:0] val2,          // Second 5-bit input
    output [4:0] finalSub,     // 5-bit subtraction result
    output coutSub             // Final carry-out
);

    // Intermediate wires
    wire [4:0] resultSub, nresultSub, twosComplementVal2;
    wire complementCout;

    // Carry wires for generating the two's complement of val2
    wire carryA, carryB, carryC, carryD;

    // Generate two's complement of val2 (invert and add 1)
    adder addOne1(.a(~val2[0]), .b(1), .cin(0), .r(twosComplementVal2[0]), .co(carryA));
    adder addOne2(.a(~val2[1]), .b(0), .cin(carryA), .r(twosComplementVal2[1]), .co(carryB));
    adder addOne3(.a(~val2[2]), .b(0), .cin(carryB), .r(twosComplementVal2[2]), .co(carryC));
    adder addOne4(.a(~val2[3]), .b(0), .cin(carryC), .r(twosComplementVal2[3]), .co(carryD));
    adder addOne5(.a(~val2[4]), .b(0), .cin(carryD), .r(twosComplementVal2[4]), .co(complementCout));

    // Carry wires for the final addition (val1 + two's complement of val2)
    wire carry4, carry5, carry6, carry7;

    // Perform the subtraction
    adder addFinal1(.a(twosComplementVal2[0]), .b(val1[0]), .cin(0),     .r(resultSub[0]), .co(carry4));
    adder addFinal2(.a(twosComplementVal2[1]), .b(val1[1]), .cin(carry4), .r(resultSub[1]), .co(carry5));
    adder addFinal3(.a(twosComplementVal2[2]), .b(val1[2]), .cin(carry5), .r(resultSub[2]), .co(carry6));
    adder addFinal4(.a(twosComplementVal2[3]), .b(val1[3]), .cin(carry6), .r(resultSub[3]), .co(carry7));
    adder addFinal5(.a(twosComplementVal2[4]), .b(val1[4]), .cin(carry7), .r(resultSub[4]), .co(coutSub));

    // If coutSub is 0, compute the negative result by finding the two's complement of resultSub
    wire carryE, carryF, carryG, carryH;
    adder addOne6(.a(~resultSub[0]), .b(1), .cin(0),     .r(nresultSub[0]), .co(carryE));
    adder addOne7(.a(~resultSub[1]), .b(0), .cin(carryE), .r(nresultSub[1]), .co(carryF));
    adder addOne8(.a(~resultSub[2]), .b(0), .cin(carryF), .r(nresultSub[2]), .co(carryG));
    adder addOne9(.a(~resultSub[3]), .b(0), .cin(carryG), .r(nresultSub[3]), .co(carryH));
    adder addOne10(.a(~resultSub[4]), .b(0), .cin(carryH), .r(nresultSub[4]), .co());

    // Select the final output based on coutSub
    assign finalSub = (coutSub == 1) ? resultSub : nresultSub;

endmodule