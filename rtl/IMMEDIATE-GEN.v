module immediate_generator(instr, imm);
  input [31:0] instr;   // full instruction
  output reg [31:0] imm; // immediate value
  always @(*) begin
    case (instr[6:0])   // opcode check
      // I-type: ADDI, ANDI, LW
      7'b0010011,
      7'b0000011:
        imm = {{20{instr[31]}}, instr[31:20]};
      // S-type: SW
      7'b0100011:
        imm = {{20{instr[31]}}, instr[31:25], instr[11:7]};
      // B-type: BEQ
      7'b1100011:
        imm = {{19{instr[31]}}, instr[31], instr[7],
               instr[30:25], instr[11:8], 1'b0};
      default:
        imm = 32'b0;
    endcase
  end
endmodule
