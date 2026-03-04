`include "memDados.v"
module memDadosTB;

// Sinais de teste
reg CLOCK;
reg [7:0] endReg, escDado;
reg escMem, leMem;
wire [7:0] saiDado;

// Instanciação do módulo
memDados memoria (endReg, escMem, leMem, escDado, saiDado, CLOCK);

//Clock simples
initial begin
    CLOCK = 0;
    forever #5 CLOCK = ~CLOCK;
end

// Teste principal
initial begin
    // Inicialização
    endReg = 8'b00000000;
    escDado = 8'b00000000;
    escMem = 0;
    leMem = 0;
    #10;

    // Teste 1: Escrever valores na memória
    escDado = 8'b00000001; endReg = 8'b00000000; escMem = 1; #10; escMem = 0; #10;
    escDado = 8'b00000010; endReg = 8'b00000001; escMem = 1; #10; escMem = 0; #10;
    escDado = 8'b00000011; endReg = 8'b00000010; escMem = 1; #10; escMem = 0; #10;
    escDado = 8'b00000100; endReg = 8'b00000011; escMem = 1; #10; escMem = 0;

    $display("Lendo valores da memoria...");
    // Teste 2: Ler valores da memória
    endReg = 8'b00000000; leMem = 1; #10; leMem = 0;
    $display("Endereco 0 = %d", saiDado);
    endReg = 8'b00000001; leMem = 1; #10; leMem = 0;
    $display("Endereco 1 = %d", saiDado);
    endReg = 8'b00000010; leMem = 1; #10; leMem = 0;
    $display("Endereco 2 = %d", saiDado);
    endReg = 8'b00000011; leMem = 1; #10; leMem = 0;
    $display("Endereco 3 = %d", saiDado);
    $display("-------------------");

    // Teste 3: Tentar escrever com escMem desativado
    $display("Testando escrita com escMem desativado...");
    escMem = 0; endReg = 8'b00000000; escDado = 8'b11111111; #10;
    endReg = 8'b00000000; leMem = 1; #10; leMem = 0;
    $display("Apos tentativa de escrita Endereco 0 = %d", saiDado);
    $display("-------------------");

    // Teste 4: Tentar ler com leMem desativado
    $display("Testando leitura com leMem desativado...");
    leMem = 0; endReg = 8'b00000001; #10;
    $display("Com leMem = 0, saiDado = %d", saiDado);
    leMem = 1; #10; leMem = 0;
    $display("Com leMem=1, saiDado = %d", saiDado);
    $display("-------------------");

    // Teste 5: Escrever em endereço diferente
    $display("Escrevendo em endereco 100...");
    escDado = 8'b00001010; endReg = 8'b01100100; escMem = 1; #10; escMem = 0;
    endReg = 8'b01100100; leMem = 1; #10; leMem = 0;
    $display("Endereco 100 = %d", saiDado);
    $display("-------------------");
    
    $display("Teste concluido!");
    $finish;
end
endmodule