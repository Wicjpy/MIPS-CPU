module mux31(outp,i0,i1,i2,cntr1,cntr2);
  output [31:0] outp;
  input [31:0] i0,i1,i2;
  input cntr1,cntr2;
  reg [31:0]outp;

  always@(i0 or i1 or i2 or cntr1 or cntr2)begin
   if(cntr2)
     outp = i2; 
   else if(cntr1)
     outp = i1;
   else
     outp = i0;
   end
endmodule

