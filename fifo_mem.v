module fifo_mem #(
  parameter MEM_DEPTH = 8,
  parameter MEM_WIDTH = 4
)(
  input  wire                         i_wr_clk,
  input  wire                         i_rst_n,
  input  wire                         i_wr_en,
  input  wire [MEM_WIDTH-1:0]         i_wr_data,
  input  wire [$clog2(MEM_DEPTH)-1:0] i_wr_addr,
  input  wire                         i_rd_clk,
  input  wire                         i_rd_en,
  input  wire [$clog2(MEM_DEPTH)-1:0] i_rd_addr,
  output reg  [MEM_WIDTH-1:0]         o_rd_data
);

  reg [MEM_WIDTH-1:0] fifo_array [0:MEM_DEPTH-1];
  integer idx;

  
  always @(posedge i_rd_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
      o_rd_data <= 'b0;
    end 
    else if (i_rd_en) begin
      o_rd_data <= fifo_array[i_rd_addr];
    end
  end

  
  always @(posedge i_wr_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
      for (idx = 0; idx < MEM_DEPTH; idx = idx + 1) begin
        fifo_array[idx] <= 'b0;
      end
    end 
    else if (i_wr_en) begin
      fifo_array[i_wr_addr] <= i_wr_data;
    end
  end

endmodule
