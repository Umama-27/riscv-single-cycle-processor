// ALUControl.v
module ALUControl(
    input  [2:0] ALUOp,    // From Control Unit
    input  [2:0] funct3,   // From instruction
    input  [6:0] funct7,   // From instruction (R-type)
    output reg [2:0] ALUControl // Signal to ALU
);
    always @(*) begin
        case(ALUOp)
            3'b000: ALUControl = 3'b000; // For LW, SW, ADDI ? ADD
            3'b001: ALUControl = 3'b001; // For BEQ ? SUB
            3'b010: begin // R-Type ? check funct3/funct7
                case(funct3)
                    3'b000: ALUControl = (funct7 == 7'b0100000) ? 3'b001 : 3'b000; // SUB : ADD
                    3'b111: ALUControl = 3'b010; // AND
                    3'b110: ALUControl = 3'b011; // OR
                    default: ALUControl = 3'b000;
                endcase
            end
            3'b011: begin // I-Type (ADDI, ANDI)
                case(funct3)
                    3'b000: ALUControl = 3'b000; // ADDI
                    3'b111: ALUControl = 3'b010; // ANDI
                    default: ALUControl = 3'b000;
                endcase
            end
            default: ALUControl = 3'b000;
        endcase
    end
endmodule
