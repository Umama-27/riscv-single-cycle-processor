module register_file(clk, reg_write, rs1, rs2, rd, wd, rd1, rd2);
  input clk;              // clock
  input reg_write;        // write enable
  input [4:0] rs1, rs2;   // source registers
  input [4:0] rd;         // destination register
  input [31:0] wd;        // write data
  output [31:0] rd1, rd2; // read data
  reg [31:0] regs[0:31]; // 32 registers
  // read operation (combinational)
  assign rd1 = (rs1 == 0) ? 32'b0 : regs[rs1];
  assign rd2 = (rs2 == 0) ? 32'b0 : regs[rs2];
initial begin
 regs[0]  = 0;
regs[1]  = 1;
regs[2]  = 2;
regs[3]  = 3;
regs[4]  = 4;
regs[5]  = 5;
regs[6]  = 6;
regs[7]  = 7;
regs[8]  = 8;
regs[9]  = 9;
regs[10] = 10;
regs[11] = 11;
regs[12] = 12;
regs[13] = 13;
regs[14] = 14;
regs[15] = 15;
regs[16] = 16;
regs[17] = 17;
regs[18] = 18;
regs[19] = 19;
regs[20] = 20;
regs[21] = 21;
regs[22] = 22;
regs[23] = 23;
regs[24] = 24;
regs[25] = 25;
regs[26] = 26;
regs[27] = 27;
regs[28] = 28;
regs[29] = 29;
regs[30] = 30;
regs[31] = 31;
end
  // write operation (on clock)
  always @(posedge clk) begin
    if (reg_write && rd != 0)
      regs[rd] <= wd;
  end
endmodule
