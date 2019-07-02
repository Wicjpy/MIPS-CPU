module pc_control(pc_out,imm16,target_addr,busA,branch,zero,jump,jumpreg,clk,clrn);
  output [31:0]pc_out;
  input [15:0]imm16;
  input [25:0]target_addr;
  input [31:0]busA;
  input branch,zero,jump,jumpreg,clk,clrn;
  
  reg[31:2]pc,next_pc;
  wire [3:0] control;
  wire [29:0]imm30;
  
  SignExt16to30  SE(.data_in(imm16),.data_out(imm30));
  
  assign pc_out = {pc,2'b00};
  assign control = {branch,zero,jump,jumpreg};
  
  always@(negedge clk)
  begin
    if(!clrn)  //clear sign 
      pc <= 0;
    else
      pc <= next_pc;
  end
  
  always@(posedge clk)
  begin
    case(control)
      4'b0000: next_pc <= pc+1;//
      4'b1100: next_pc <= pc+1+imm30;//when beq=1 and z=1)
      4'b0010: next_pc <= {pc[31:28],target_addr[25:0]};//(jump when j=1)
      4'b0001: next_pc <= busA[31:2];//jumpreg
      default :next_pc <= pc+1;//other op pc+1
    endcase
  end
endmodule

