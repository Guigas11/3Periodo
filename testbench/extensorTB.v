`include "extensor.v"
module extensorTB;

reg [2:0] in;
wire [7:0] out;
extensor ext(in, out);

initial begin
    $monitor("Tempo: %0t | Entrada: %b (%d) | Saida: %b (%d)", $time, in, in, out, out);
end

initial begin
    $display("Testando extensao de 3 bits para 8 bits (sem sinal)");
    in = 3'b000;
    #10;
    in = 3'b001;
    #10;
    in = 3'b010;
    #10;
    $finish;
end
endmodule