module instruction_memory(addr, instr);
  input [31:0] addr;     // address from PC
  output [31:0] instr;   // instruction output
  reg [31:0] mem[0:255]; // ROM memory
  assign instr = mem[addr[9:2]]; // word aligned access
  initial begin
//    $readmemh("program.mem", mem);
    mem[0] = 32'h00500093;   // I-Type  : addi x1, x0, 5
    mem[1] = 32'h00500113;   // I-Type  : addi x2, x0, 5
   mem[2] = 32'h002081B3;   // R-Type  : add  x3, x1, x2
    mem[3] = 32'h40110433;   // R-Type  : sub  x8, x2, x1
  mem[4] = 32'h0020F333;   // R-Type  : and  x6, x1, x2
    mem[5] = 32'h0020E3B3;   // R-Type  : or   x7, x1, x2
    mem[6] = 32'h00302023;   // S-Type  : sw   x3, 0(x0)
    mem[7] = 32'h00002203;   // I-Type  : lw   x4, 0(x0)
    mem[8] = 32'h00320263;   // B-Type  : beq  x4, x3, +4
  end
endmodule
