module mux31_5bit(outp,i0,i1,i2,cntr1,cntr2);
  output [4:0] outp;
  input [4:0] i0,i1,i2;
  input cntr1,cntr2;
  reg [4:0]outp;

 //always@(cntr1,cntr2)begin
  always@(i0 or i1 or i2 or cntr1 or cntr2) begin
   if(cntr2)
     outp = i2;
   else if(!cntr1)
     outp = i0;
   else
     outp = i1;//让第一条指令的不稳定状态默认为R-type型赋值（给rd赋值）
   end
endmodule
