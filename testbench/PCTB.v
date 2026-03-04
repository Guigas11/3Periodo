`include "PC.v"
module PCTB;

reg CLOCK;
reg HALT;
reg [7:0] pcNovo;
wire [7:0] pc;

// Instanciação do modulo PC
PC pc_inst (HALT, pc, pcNovo, CLOCK);

// Geração do clock
initial begin
    CLOCK = 0;
    forever #5 CLOCK = ~CLOCK;
end

initial begin
    // Inicialização
    HALT = 0;
    pcNovo = 8'b10000001; // 129
    #10;
    $display("PC atualizado: %d", pc);

    // Avança PC para 130
    pcNovo = 8'b10000010;
    #10;
    $display("PC atualizado: %d", pc);

    // HALT ativado (PC deve parar de mudar)
    HALT = 1;
    pcNovo = 8'b10000011;
    #10;
    $display("Tentativa de atualizar PC com HALT ativado: %d", pc);

    // HALT desativado (PC volta a avançar)
    HALT = 0;
    #10;
    $display("PC atualizado (agora com HALT desativado): %d", pc);
    
    $finish;
end
endmodule