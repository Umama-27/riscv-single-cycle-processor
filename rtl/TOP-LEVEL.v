// Processor.v
module Processor(
    input clk,
    input reset
);
    // Wires
    wire [31:0] PC_current, PC_next;
    wire [31:0] Instr;
    wire [31:0] ReadData1, ReadData2, Imm;
    wire [31:0] ALU_input2, ALUResult, MemReadData;
    wire [2:0] ALUControlSignal;
    wire Zero;
    wire ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch;
    wire [2:0] ALUOp;

    // -------------------
    // Program Counter
    // -------------------
    pc pc_module(
        .clk(clk),
        .reset(reset),
        .pc_next(PC_next),
        .pc(PC_current)
    );

    // -------------------
    // Instruction Memory
    // -------------------
    instruction_memory im(
        .addr(PC_current),
        .instr(Instr)
    );

    // -------------------
    // Control Unit
    // -------------------
    ControlUnit cu(
        .opcode(Instr[6:0]),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUOp(ALUOp)
    );

    // -------------------
    // Immediate Generator
    // -------------------
    immediate_generator imm_gen(
        .instr(Instr),
        .imm(Imm)
    );

    // -------------------
    // Register File
    // -------------------
    register_file rf(
        .clk(clk),
        .reg_write(RegWrite),
        .rs1(Instr[19:15]),
        .rs2(Instr[24:20]),
        .rd(Instr[11:7]),
        .wd(MemtoReg ? MemReadData : ALUResult),
        .rd1(ReadData1),
        .rd2(ReadData2)
    );

    // -------------------
    // ALU Control
    // -------------------
    ALUControl alu_c(
        .ALUOp(ALUOp),
        .funct3(Instr[14:12]),
        .funct7(Instr[31:25]),
        .ALUControl(ALUControlSignal)
    );

    // -------------------
    // ALU Input Selection
    // -------------------
    assign ALU_input2 = ALUSrc ? Imm : ReadData2;

    // -------------------
    // ALU
    // -------------------
    ALU alu(
        .A(ReadData1),
        .B(ALU_input2),
        .ALUControl(ALUControlSignal),
        .Result(ALUResult),
        .Zero(Zero)
    );

    // -------------------
    // Data Memory
    // -------------------
    DataMemory dm(
        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Address(ALUResult),
        .WriteData(ReadData2),
        .ReadData(MemReadData)
    );

    // -------------------
    // PC Update Logic
    // -------------------
    assign PC_next = (Branch & Zero) ? (PC_current + Imm) : (PC_current + 4);

endmodule
