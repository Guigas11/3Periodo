module extensor(in, out);

input [2:0] in; 
output [7:0] out;

// preenche com zeros os bits mais significativos
assign out = {5'b0, in};

endmodule
