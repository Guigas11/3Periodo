module regFlag (CLOCK, flag, saiFlag);

input CLOCK;
input flag;

output reg saiFlag;

// Inicialização do registrador
initial begin
    saiFlag = 1'b0;
end

// Lógica do registrador armazena o flag na borda de subida do clock
always @(posedge CLOCK) begin
    saiFlag <= flag;
end

endmodule