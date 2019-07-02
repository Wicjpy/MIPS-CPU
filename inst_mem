module inst_mem(addr,outp,data,wEN,clk,w_addr);//using 1k * 32bit room
  input [31:0] addr,data;
  output [31:0] outp;
  input [4:0] w_addr;
  wire [6:2] addren;//pc[1:0] is not control signal,so start at addr[2]
  input wEN,clk;
  reg  [31:0] inst_mem [31:0];
  assign addren = addr[6:2];
  assign outp = inst_mem[addren];
  always@(negedge clk)
  begin
    if(wEN)
      inst_mem[w_addr] <= data;
  end
endmodule
