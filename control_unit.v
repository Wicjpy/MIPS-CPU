module control_unit(Instruction,RegDst,RegWr,ExtOp,ALUSrc,MemWr,MemtoReg,jump,branch,jumpreg,jumplink);
  input [31:0] Instruction;
  output RegDst,RegWr,ExtOp,ALUSrc,MemWr,MemtoReg;
  output jump,branch,jumplink,jumpreg;
  
  wire [5:0] op, func;
  
  reg RegDst,RegWr,ExtOp,ALUSrc,MemWr,MemtoReg,jump,branch,jumplink,jumpreg;
  
  assign op = Instruction[31:26];
  assign func = Instruction[5:0];

  always@(op)
  begin
  jumpreg <= 0;
  jumplink <= 0;
    case(op)
      6'b000000:begin//R_type
                  RegDst <= 1;//write in rd
                  ALUSrc <= 0;
                  MemtoReg <= 0;
                  RegWr <= 1;//write enable
                  MemWr <= 0;
                  branch <= 0;
                  jump <= 0;
                  // ExtOp = x;
                  case(func)
                        6'b001000:jumpreg <= 1;//pc_control<=busA
                        default:jumpreg <= 0; 
                  endcase                  

                end
      6'b100011:begin//lw
                  RegDst <= 0;//write in rt
                  ALUSrc <= 1;
                  MemtoReg <= 1;
                  RegWr <= 1;
                  MemWr <= 0;
                  branch <= 0;
                  jump <= 0;
                  ExtOp <= 1;
                end
      6'b101011:begin//sw
                  //RegDst = x;
                  ALUSrc <= 1;
                  //MemtoReg = x;
                  RegWr <= 0;
                  MemWr <= 1;
                  branch <= 0;
                  jump <= 0;
                  ExtOp <= 1;
                end
      6'b000100:begin//beq branch
                  //RegDst = x;
                  ALUSrc <= 0;
                  //MemtoReg = x;
                  RegWr <= 0;
                  MemWr <= 0;
                  branch <= 1;
                  jump <= 0;
                  //ExtOp = x;
                end
      6'b000010:begin//jump
                  //RegDst = x;
                  //ALUSrc = x;
                  //MemtoReg = x;
                  RegWr <= 0;
                  MemWr <= 0;
                  branch <= 0;
                  jump <= 1;
                  //ExtOp = x;
                end
      6'b000011:begin//jump and link
                  //RegDst = x;
                  //ALUSrc = x;
                  //MemtoReg = x;
                  RegWr <= 1;//target_adder write in
                  MemWr <= 0;
                  branch <= 0;
                  jump <= 1;
                  ExtOp <= 0;
                  jumplink <= 1;//write in reg31 and write pc
                end
          default: begin
                 // RegDst <= 0;
                  RegDst <= RegDst;//存在时序问题，本周期初的选择取决于上个周期末的变量。
                  ALUSrc <= 0;
                  MemtoReg <= 0;
                  RegWr <= 0;
                  MemWr <= 0;
                  branch <= 0;
                  jump <= 0;
                  ExtOp <= 0;
                end
      endcase
  end
endmodule

