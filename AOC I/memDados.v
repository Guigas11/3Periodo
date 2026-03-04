module memDados (endReg, escMem, leMem, escDado, saiDado, CLOCK);

input CLOCK, escMem, leMem;
input [7:0] endReg, escDado;

output reg [7:0] saiDado;

// Declaração da memória de dados (256 posições de 8 bits)
reg [7:0] mem [0:255];

initial begin
    // Inicializando a memória com zeros
    for (integer i=0; i<256; i++) begin
        mem[i] = 8'b00000000;
    end
end

// Lógica de escrita
always @(posedge CLOCK) begin
    if (escMem) begin
        mem [endReg] <= escDado;
    end
end

// Lógica de leitura
always @ (negedge CLOCK) begin
    if (leMem) begin
        saiDado <= mem [endReg];
    end
end

endmodule