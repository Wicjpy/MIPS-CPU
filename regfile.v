module regfile(addr_a,addr_b,w_addr,wEN,clk,clrn,busA,busB,busW);  
input [4:0] addr_a,addr_b,w_addr;  
input [31:0] busW;  
input wEN,clk,clrn;  
output [31:0] busA,busB; 
integer i; 
reg  [31:0] register [31:0];
//2 read port    
assign busA = register[addr_a];// read port A   
assign busB = register[addr_b];// read port B  
 

always @ (negedge clk)         
if (clrn == 0) 
  begin
    for(i = 0;i < 32;i = i + 1)
    begin 
       register[i] = 0;
    end

   register[1]=32'h0001;
   register[2]=32'h0001;
   register[10]=32'h003c;

  end
  else if (wEN)                 
  register[w_addr] = busW;
endmodule


