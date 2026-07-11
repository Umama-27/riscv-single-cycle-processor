module tb_top;

  reg clk;
  reg reset;

  // DUT = Device Under Test
  Processor uut (
    .clk(clk),
    .reset(reset)
  );

  // Clock generation (10 time unit period)
  always #5 clk = ~clk;

  initial begin
    // initial values
    clk = 0;
    reset = 1;

    // apply reset
    #10 reset = 0;

    // run simulation
    #300;

    $stop;
  end

endmodule
