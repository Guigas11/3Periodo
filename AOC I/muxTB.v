`include "mux.v"
module muxTB;

reg [7:0] in1, in2, in3, in4;
reg [1:0] sel;
wire [7:0] out;
mux mux1(in1, in2, in3, in4, out, sel);

initial begin
    $display("Testando multiplexador de 4 entradas de 8 bits");
    in1 = 8'b00000001; // 1
    in2 = 8'b00000010; // 2
    in3 = 8'b00000100; // 4
    in4 = 8'b00001000; // 8
    
    sel = 2'b00; #1;
    $display("SEL=%b, OUT=%b", sel, out);
    sel = 2'b01; #1;
    $display("SEL=%b, OUT=%b", sel, out);
    sel = 2'b10; #1;
    $display("SEL=%b, OUT=%b", sel, out);
    sel = 2'b11; #1;
    $display("SEL=%b, OUT=%b", sel, out);
    
    // Muda valores das entradas
    in1 = 8'b11111111;
    in2 = 8'b10101010;
    in3 = 8'b01010101;
    in4 = 8'b00000000;
    
    sel = 2'b00; #1;
    $display("SEL=%b, OUT=%b", sel, out);
    sel = 2'b01; #1;
    $display("SEL=%b, OUT=%b", sel, out);
    sel = 2'b10; #1;
    $display("SEL=%b, OUT=%b", sel, out);
    sel = 2'b11; #1;
    $display("SEL=%b, OUT=%b", sel, out);
    
    $finish;
end
endmodule