module async_fifo_tb;

  parameter DATA_WIDTH = 4;
  parameter FIFO_DEPTH = 8;

  reg                    tb_rst_n;
  reg                    tb_wr_clk;
  reg                    tb_wr_en;
  reg  [DATA_WIDTH-1:0]  tb_wr_data;
  reg                    tb_rd_clk;
  reg                    tb_rd_en;
  wire [DATA_WIDTH-1:0]  tb_rd_data;
  wire                   tb_full;
  wire                   tb_empty;

  integer idx;

  async_fifo #(.DATA_WIDTH(DATA_WIDTH), .FIFO_DEPTH(FIFO_DEPTH)) u_tb_fifo (
    .i_rst_n   (tb_rst_n),
    .i_wr_clk  (tb_wr_clk),
    .i_wr_en   (tb_wr_en),
    .i_wr_data (tb_wr_data),
    .i_rd_clk  (tb_rd_clk),
    .i_rd_en   (tb_rd_en),
    .o_rd_data (tb_rd_data),
    .o_full    (tb_full),
    .o_empty   (tb_empty)
  );

initial begin
    forever begin
      #5  tb_rd_clk = ~tb_rd_clk;  
    end
end

initial begin
    forever begin
      #10 tb_wr_clk = ~tb_wr_clk;  
    end
end
  
  initial begin
    tb_wr_clk  = 0;
    tb_rd_clk  = 0;
    tb_rst_n   = 1;
    tb_wr_en   = 0;
    tb_wr_data = 0;
    tb_rd_en   = 0;

    #20 tb_rst_n = 0;
    #20 tb_rst_n = 1;
    #20;

    for (idx = 0; idx < FIFO_DEPTH; idx = idx + 1) begin
      @(negedge tb_wr_clk);
      tb_wr_en   = 1'b1;
      tb_wr_data = idx + 2;
    end

    @(negedge tb_wr_clk) tb_wr_en = 1'b0;
    @(negedge tb_rd_clk) tb_rd_en = 1'b1;

    for (idx = 0; idx < FIFO_DEPTH; idx = idx + 1) begin
      @(negedge tb_rd_clk);
      $display("Read cycle %0d -> Data = %0d", idx, tb_rd_data);
    end

    @(negedge tb_rd_clk) tb_rd_en = 1'b0;
    #50 $stop;
  end



endmodule

