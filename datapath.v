module datapath(RegDst,RegWr,ExtOp,ALUSrc,ALUctr,MemWr,MemtoReg,clk,nclear,nRST,jump,branch,jumpreg,jumplink,InsWrEN,InsWrAddr,InsDataIn,Instruction);
  input RegDst,RegWr,ExtOp,ALUSrc,MemWr,MemtoReg;
  input [2:0] ALUctr;
  input clk,nclear,nRST;
  input jump,branch,jumplink,jumpreg;
  input InsWrEN;
  input [4:0] InsWrAddr;
  input [31:0] InsDataIn;
  output [31:0] Instruction;
  
  wire [25:21]Rs;
  wire [20:16]Rt;
  wire [15:11]Rd;

  wire [15:0]imm16;
  wire [31:0]imm32,alu_inB,alu_out;
  wire [25:0] target_addr;
  wire zero;
  
  wire [31:0]data_out;
  
  wire [4:0]Rw;
  wire [31:0]busA,busB,busW;
  
  wire [31:0]pc_out;
  
  
  
  mux31_5bit M1(.outp(Rw),.i0(Rt),.i1(Rd),.i2(5'b11111),.cntr1(RegDst),.cntr2(jumplink));
  
  regfile RF1(.addr_a(Rs),.addr_b(Rt),.w_addr(Rw),.wEN(RegWr),.clk(clk),.clrn(nclear),.busA(busA),.busB(busB),.busW(busW));
  
  extender Ext16to32(.extop(ExtOp),.i(imm16),.outp(imm32));  
  
  mux21 M2(.outp(alu_inB),.i0(busB),.i1(imm32),.cntr(ALUSrc));
  
  ALU alu(.outp(alu_out),.z(zero),.i0(busA),.i1(alu_inB),.cntr(ALUctr));
  
  data_mem  DM1(.addr(alu_out),.outp(data_out),.data(busB),.wEN(MemWr),.clk(clk));
  
  mux31 M3(.outp(busW),.i0(alu_out),.i1(data_out),.i2(pc_out),.cntr1(MemtoReg),.cntr2(jumplink));
  
  pc_control PC1(.pc_out(pc_out),.imm16(imm16),.target_addr(target_addr),.busA(busA),.branch(branch),.zero(zero),.jump(jump),.jumpreg(jumpreg),.clk(clk),.clrn(nRST));
  
  inst_mem IM1(.addr(pc_out),.outp(Instruction),.data(InsDataIn),.wEN(InsWrEN),.clk(clk),.w_addr(InsWrAddr));

  //assign Rw = RegDst ? Rd : Rt;
  assign Rs[25:21] = Instruction[25:21];
  assign Rd[15:11] = Instruction[15:11];
  assign Rt[20:16] = Instruction[20:16];
  assign imm16[15:0] = Instruction[15:0];
  assign target_addr[25:0] = Instruction[25:0];
  
endmodule

