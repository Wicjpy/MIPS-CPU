module ALUcontrol(Instruction,ALUctr);
  input [31:0] Instruction;
  output [2:0] ALUctr;
  
  wire [31:26]op;
  wire [5:0] func;
  
  reg [2:0] ALUctr;
  
  parameter add = 3'b000,
            sub = 3'b001,
            yu = 3'b010,
            huo = 3'b011,
            slt = 3'b100;
            
  
  assign op = Instruction[31:26];
  assign func = Instruction[5:0];
  
  always@(op or func)
  begin
    case(op)
      6'b000000:begin//R_type
                  case(func)
                    6'b100000: ALUctr <= add;
                    6'b100010: ALUctr <= sub;
                    6'b100100: ALUctr <= yu;
                    6'b100101: ALUctr <= huo;
                    6'b101010: ALUctr <= slt;
                    default: ALUctr <= 3'b110;
                  endcase
                end
      6'b100011: ALUctr <= add;//lw
      6'b101011: ALUctr <= add;//sw
      6'b000100: ALUctr <= sub;//beq branch
      default: ALUctr <= 3'b111;
     endcase
  end
endmodule

