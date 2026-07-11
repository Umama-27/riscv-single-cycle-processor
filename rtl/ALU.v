// ALU.v
module ALU(
    input  [31:0] A,        // First operand
    input  [31:0] B,        // Second operand
    input  [2:0]  ALUControl, // Control signal to select operation
    output reg [31:0] Result, // ALU output
    output Zero             // Zero flag for branch
);
    // Combinational logic for ALU
    always @(*) begin
        case(ALUControl)
            3'b000: Result = A + B;    // ADD
            3'b001: Result = A - B;    // SUB
            3'b010: Result = A & B;    // AND
            3'b011: Result = A | B;    // OR
            default: Result = 32'b0;   // Default
        endcase
    end

    // Zero flag (used for BEQ)
    assign Zero = (Result == 32'b0) ? 1'b1 : 1'b0;

endmodule
