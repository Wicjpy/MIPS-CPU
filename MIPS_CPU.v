module MIPS_CPU(clk,nclear,nRST,InsWrEN,InsWrAddr,InsDataIn);
  input clk,nclear,nRST,InsWrEN;
  input [4:0] InsWrAddr;
  input [31:0] InsDataIn;
  
  wire [31:0] Instruction;
  wire [2:0] ALUctr;
  wire RegDst,RegWr,ExtOp,ALUSrc,MemWr,MemtoReg,jump,jumpreg,jumplink,branch;
  
  
  control_unit  CU0(Instruction,RegDst,RegWr,ExtOp,ALUSrc,MemWr,MemtoReg,jump,branch,jumpreg,jumplink);
  
  ALUcontrol AC0(.Instruction(Instruction),.ALUctr(ALUctr));
  
  datapath DP0(RegDst,RegWr,ExtOp,ALUSrc,ALUctr,MemWr,MemtoReg,clk,nclear,nRST,jump,branch,jumpreg,jumplink,InsWrEN,InsWrAddr,InsDataIn,Instruction);
  
endmodule

