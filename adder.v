module adder(a, b, cin, r, co);

	// Declaring inputs and outputs
	input a, b, cin;
	output r, co;
	
	// Formula for getting the result from adding
	assign r = (cin & ~a & ~b) + (~cin & ~a & b) + (cin & a & b) + (~cin & a & ~b);
	
	// Formula for getting the carryout from addition
	assign co = (cin & b) + (cin & a) + (a & b);
	
endmodule