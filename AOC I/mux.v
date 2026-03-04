module mux(in1, in2, in3, in4, out, sel);

// Mux de 4 entradas pois temos um mux de 3 e um de 2 

input [7:0] in1, in2, in3, in4;
input [1:0] sel;

output reg [7:0] out;

always @(*)begin
    case (sel)
        2'b00: out = in1;
        2'b01: out = in1;
        2'b10: out = in1;
        2'b11: out = in1;
        default: out = 8'b00000000
    endcase
end

endmodule