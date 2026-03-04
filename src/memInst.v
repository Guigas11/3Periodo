module memInst (endereco, inst, CLOCK);

input CLOCK;
input [7:0] endereco;

output reg [7:0] inst;

// Declaração da memória de instruções (256 posições de 8 bits)
reg [7:0] mem [0:255];

initial begin
    // Inicializando a memória com zeros
    for (integer i=0; i<256; i++) begin
        mem[i] = 8'b00000000;
    end
    
    // Inicializando a memória com as instruções do programa
    mem[128] = 8'b10010110;
    mem[129] = 8'b10101111;
    mem[130] = 8'b01100011;
    mem[131] = 8'b01100011;
    mem[132] = 8'b01100011;
    mem[133] = 8'b01100011;
    mem[134] = 8'b01100010;
    mem[135] = 8'b01100000;
    mem[136] = 8'b11010110;
    mem[137] = 8'b10010110;
    mem[138] = 8'b10101001;
    mem[139] = 8'b01100001;
    mem[140] = 8'b10001100;
    mem[141] = 8'b01100000;
    mem[142] = 8'b10000010;
    mem[143] = 8'b01011000;
    mem[144] = 8'b01011101;
    mem[145] = 8'b10000100;
    mem[146] = 8'b01110000;
    mem[147] = 8'b11100000;
end

// Lógica de leitura
always @ (negedge CLOCK) begin
    inst <= mem [endereco];
end

endmodule