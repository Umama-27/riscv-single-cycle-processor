// ControlUnit.v
module ControlUnit(
    input  [6:0] opcode,      // 7-bit opcode from instruction
    output reg ALUSrc,        // 1 = use immediate, 0 = use reg
    output reg MemtoReg,      // 1 = write back from memory, 0 = ALU
    output reg RegWrite,      // 1 = write to register file
    output reg MemRead,       // 1 = read memory
    output reg MemWrite,      // 1 = write memory
    output reg Branch,        // 1 = BEQ
    output reg [2:0] ALUOp   // ALU operation code
);
    always @(*) begin
        // Default signals
        ALUSrc   = 0;
        MemtoReg = 0;
        RegWrite = 0;
        MemRead  = 0;
        MemWrite = 0;
        Branch   = 0;
        ALUOp    = 3'b000;

        case(opcode)
            7'b0110011: begin // R-Type (ADD, SUB, AND, OR)
                ALUSrc   = 0;
                MemtoReg = 0;
                RegWrite = 1;
                ALUOp    = 3'b010; // We'll later refine based on funct3/funct7 in ALU Control
                //ALUOp    = 3'b000; // We'll later refine based on funct3/funct7 in ALU Control
            end
            7'b0010011: begin // I-Type (ADDI, ANDI)
                ALUSrc   = 1;
                MemtoReg = 0;
                RegWrite = 1;
                ALUOp    = 3'b011; // Will refine in ALU Control
                //ALUOp    = 3'b000; // Will refine in ALU Control
            end
            7'b0000011: begin // LW
                ALUSrc   = 1;
                MemtoReg = 1;
                RegWrite = 1;
                MemRead  = 1;
                ALUOp    = 3'b000; // ADD for address
            end
            7'b0100011: begin // SW
                ALUSrc   = 1;
                MemWrite = 1;
                ALUOp    = 3'b000; // ADD for address
            end
            7'b1100011: begin // BEQ
                ALUSrc = 0;
                Branch = 1;
                ALUOp  = 3'b001; // SUB to compare
            end
        endcase
    end
endmodule
