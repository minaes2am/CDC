module tb;
  reg clk1, clk2, rst, in;
  wire out;

  top DUT (
    .clk1(clk1),
    .clk2(clk2),
    .rst(rst),
    .in(in),
    .out(out)
  );

  initial begin
    clk1 = 0;
    forever #5 clk1 = ~clk1;
  end

  initial begin
    clk2 = 0;
    forever #7 clk2 = ~clk2;
  end

  initial begin
    rst = 1; in = 0;
    #12 rst = 0;
    #1 in = 1; @(negedge clk1); repeat(3)@(negedge clk2); 
    #1 in = 0; @(negedge clk1); repeat(3)@(negedge clk2);
    #1 in = 1; @(negedge clk1); repeat(3)@(negedge clk2);
    #1 in = 0; @(negedge clk1); repeat(3)@(negedge clk2);
    #1 in = 1; @(negedge clk1); repeat(3)@(negedge clk2);
    #1 in = 0; @(negedge clk1); repeat(3)@(negedge clk2);
    #1 in = 1; @(negedge clk1); repeat(3)@(negedge clk2);
    #1 in = 0; @(negedge clk1); repeat(3)@(negedge clk2);
    #1 $stop;
  end

  initial begin
    $monitor("T=%0t | rst=%b | in=%b | out=%b",
             $time, rst, in, out);
  end
endmodule

