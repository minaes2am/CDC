module top(clk1 ,clk2 ,rst ,in ,out);
input clk1 ,clk2 ,rst ,in;
output out;
wire out1 ,in2 ,out2 ,in3 ,out3 ,in4 ,out4;

DFF F1(.clk(clk1),.rst(rst),.D(in),.Q(out1));
DFF F2(.clk(clk2),.rst(rst),.D(in2),.Q(out2));
DFF F3(.clk(clk2),.rst(rst),.D(in3),.Q(out3));
DFF F4(.clk(clk2),.rst(rst),.D(in4),.Q(out4));

assign in2 = out1;
assign in3 = out2;
assign in4 = out3;
assign out = (out3 & ~out4);

endmodule
