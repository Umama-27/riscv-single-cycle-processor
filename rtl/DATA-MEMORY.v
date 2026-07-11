// DataMemory.v
module DataMemory(
    input clk,
    input MemRead,
    input MemWrite,
    input [31:0] Address,      // ALUResult
    input [31:0] WriteData,    // From Register File
    output reg [31:0] ReadData
);
    reg [31:0] memory [0:255]; // 256 words of 32-bit memory
    always @(posedge clk) begin
        if (MemWrite)
            memory[Address[9:2]] <= WriteData; // word-aligned
    end
    always @(*) begin
        if (MemRead)
            ReadData = memory[Address[9:2]];  // word-aligned
        else
            ReadData = 32'b0;
    end
endmodule
