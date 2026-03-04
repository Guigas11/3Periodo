module processador (CLOCK);

input CLOCK;

// Sinais internos do processador
wire [7:0] pc, pcNovo, instrucao;
wire [7:0] S1, S2, resultadoULA, saidaExtensor, dadoMem, saidaMux;
wire [1:0] R1, R2, MemToReg;
wire ALUOP, Jump, LeMem, EscMem, ALUSrc, EscRegl, EscReg2, Halt;
wire lt, flag, saiFlag;

// Decodificação da instrução
assign R1 = instrucao [4:3];
assign R2 = instrucao [2:1];

// Identifica se a instrução é LOADI ou INC/DEC
wire isLoadi = (instrucao [7:5] == 3'b010);
wire isIncDec = (instrucao [7:5] == 3'b100);

// Extensor para LOADI (imediato 3 bits para 8 bits)
extensor extensor_modulo (
    .in(instrucao [2:0]),
    .out (saidaExtensor)
);

// Mux para entrada 1 da ULA
wire [7:0] entradaULA1 = S1;

// Mux para entrada 2 da ULA (S2 ou valor imediato correto)
wire [7:0] imediatoIncDec = {6'b0, instrucao [2:1]};
wire [7:0] imediatoLoadi = {5'b0, instrucao [2:0]};
wire [7:0] entradaULA2 = isLoadi? imediatoLoadi : isIncDec? imediatoIncDec : S2;

// Mux para dado de escrita no banco de registradores (usa o módulo mux)
mux mux_dado (
    .in1 (resultadoULA),   // 2'b00
    .in2 (saidaExtensor),  // 2'b01 (LOADI)
    .in3 (dadoMem),        // 2'b10
    .in4 (8'b0),           // 2'b11
    .out (saidaMux),
    .sel (MemToReg)
);

assign dadoMem = saidaMux;

// Cálculo do próximo PC (usa regFlag para saltos condicionais)
regFlag regFlag_modulo (
    .CLOCK (CLOCK),
    .flag (lt),
    .saiFlag(saiFlag)
);

assign pcNovo = pc + 1;

// Instanciação dos módulos principais
PC pc_modulo (.HALT (Halt), .pc(pc), .pcNovo (pcNovo), .CLOCK (CLOCK));
memInst memInst_modulo (.endereco (pc), .inst(instrucao), .CLOCK (CLOCK));

controle controle_modulo(
    .instrucao (instrucao), .MemToReg (MemToReg), .LeMem (LeMem),
    .ALUSrc (ALUSrc), .EscMem (EscMem), .ALUOP (ALUOP), .Jump (Jump),
    .EscReg1 (EscReg1), .EscReg2 (EscReg2), .Halt (Halt)
);

bancoDeRegs bancoRegs_modulo (
    .R1 (R1), .R2 (R2), .dado (saidaMux), .escRegl (EscReg1), .escReg2 (EscReg2),
    .S1 (S1), .S2 (S2), .CLOCK (CLOCK)
);

ULA ula_modulo(.rl(entradaULA1), .r2 (entradaULA2), .ALUOP (ALUOP), .resultado (resultadoULA), .lt(lt));

memDados memDados_modulo(
    .endReg (S2), .escMem (EscMem), .leMem (LeMem), .escDado (S1),
    .saiDado (dadoMem), .CLOCK (CLOCK)
);

endmodule