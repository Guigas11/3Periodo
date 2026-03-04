`include "regFlag.v"
module regFlagTB;

reg CLOCK;
reg flag;
wire saiFlag;

// Instanciação do modulo
regFlag regFlag_inst(CLOCK, flag, saiFlag);

// Geração do clock
initial begin
    CLOCK = 0;
    forever #25 CLOCK = ~CLOCK;
end

initial begin
    // Inicialização
    flag = 0;
    #10;
    $display("saiFlag inicial: %b", saiFlag);

    // Seta flag para 1 e espera borda de subida
    flag = 1;
    #10;
    $display("saiFlag apos flag=1: %b", saiFlag);

    // Seta flag para 0 e espera borda de subida
    flag = 0;
    #10;
    $display("saiFlag apos flag=0: %b", saiFlag);
    
    $finish;
end
endmodule