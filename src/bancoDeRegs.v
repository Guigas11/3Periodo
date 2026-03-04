module bancoDeRegs (R1, R2, dado, escReg1, escReg2, S1, S2, CLOCK);

input CLOCK;
input [7:0] dado;
input escReg1, escReg2;
input [1:0] R1, R2;

output reg [7:0] S1, S2;

reg [7:0] r0, r1, r2, r3;
reg [7:0] aux1, aux2;

// Borda de subida para escrita
always@(posedge CLOCK) begin
    // Troca de valores entre registradores
    if (escReg1 && escReg2) begin
        // Salva os valores atuais
        case (R1)
            2'b00: aux1 = r0;
            2'b01: aux1 = r1;
            2'b10: aux1 = r2;
            2'b11: aux1 = r3;
        endcase
        case (R2)
            2'b00: aux2 = r0;
            2'b01: aux2 = r1;
            2'b10: aux2 = r2;
            2'b11: aux2 = r3;
        endcase
        // Troca os valores
        case (R1)
            2'b00: r0 <= aux2;
            2'b01: r1 <= aux2;
            2'b10: r2 <= aux2;
            2'b11: r3 <= aux2;
        endcase
        case (R2)
            2'b00: r0 <= aux1;
            2'b01: r1 <= aux1;
            2'b10: r2 <= aux1;
            2'b11: r3 <= aux1;
        endcase
    end
    // Escrita padrão
    else if (escReg2) begin
        case (R2)
            2'b00: r0 <= dado;
            2'b01: r1 <= dado;
            2'b10: r2 <= dado;
            2'b11: r3 <= dado;
        endcase
    end
end

// Borda de descida para leitura
always@(negedge CLOCK) begin
    case (R1)
        2'b00: S1 <= r0;
        2'b01: S1 <= r1;
        2'b10: S1 <= r2;
        2'b11: S1 <= r3;
    endcase
    case (R2)
        2'b00: S2 <= r0;
        2'b01: S2 <= r1;
        2'b10: S2 <= r2;
        2'b11: S2 <= r3;
    endcase
end
endmodule