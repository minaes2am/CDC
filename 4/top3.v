module top(clk1 ,clk2 ,rst ,pulse ,out);
input clk1 ,clk2 ,rst ,pulse;
output out;
wire out1 ,in2 ,out2 ,in3 ,out3 
,in4 ,out4 ,in5 ,out5 ,in6 ,out6
,mux_out1 ,mux_out2;

DFF F1(.clk(clk1),.rst(rst),.D(mux_out2),.Q(out1));
DFF F2(.clk(clk2),.rst(rst),.D(in2),.Q(out2));
DFF F3(.clk(clk2),.rst(rst),.D(in3),.Q(out3));
DFF F4(.clk(clk2),.rst(rst),.D(in4),.Q(out4));
DFF F5(.clk(clk1),.rst(rst),.D(in5),.Q(out5));
DFF F6(.clk(clk1),.rst(rst),.D(in6),.Q(out6));

assign in2 = out1;
assign in3 = out2;
assign in4 = out3;
assign in5 = out4;
assign in6 = out5;
assign mux_out1 = (out6)? 1'b0 : out1;
assign mux_out2 = (pulse)? 1'b1 : mux_out1;
assign out = (out3 & ~out4);

endmodule
