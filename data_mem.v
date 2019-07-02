module data_mem(addr,outp,data,wEN,clk);//using 1k * 32bit room
  input [31:0] addr,data;
  output [31:0] outp;
  input wEN,clk;
  
  wire [4:0] addren;//1k room  will use 10 bits addr to find
  reg  [31:0] data_mem [31:0];
  assign addren = addr[4:0];
  assign outp = data_mem [addren];
  always@(negedge clk)
  begin
    if(wEN)
      data_mem [addren] <= data;
  end
endmodule

