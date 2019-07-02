module extender(extop,i,outp);
output [31:0] outp;
input [15:0] i;
input extop;
reg [31:0] outp;

always @(extop or i)
begin
if (extop == 1) begin 
  if (i[15]==0) 
      outp <= {16'b0000_0000_0000_0000,i};
  else 
      outp <= {16'b1111_1111_1111_1111,i};
  end 
else
    outp <= {16'b0000_0000_0000_0000,i};
end
endmodule

