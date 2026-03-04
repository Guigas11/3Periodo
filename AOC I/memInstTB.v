`include "memInst.v"
module memInstTB;

reg CLOCK;
reg [7:0] endereco;
wire [7:0] inst;

// Instanciação do módulo
memInst memoria (endereco, inst, CLOCK);

// Geração do clock
initial begin
    CLOCK = 0;
    forever #5 CLOCK = ~CLOCK;
end

initial begin
    // Inicialização
    endereco = 8'b10000000; // 128
    #10;
    $display("Lendo instrucoes da memoria de instrucoes (enderecos em binario): ");
    
    endereco = 8'b10000000; #10; // 128
    $display("Endereco %b: inst = %b", endereco, inst);
    
    endereco = 8'b10000001; #10; // 129
    $display("Endereco %b: inst = %b", endereco, inst);
    
    endereco = 8'b10000010; #10; // 130
    $display("Endereco %b: inst = %b", endereco, inst);
    
    endereco = 8'b10000011; #10; // 131
    $display("Endereco %b: inst = %b", endereco, inst);
    
    endereco = 8'b10000100; #10; // 132
    $display("Endereco %b: inst = %b", endereco, inst);
    
    $finish;
end
endmodule