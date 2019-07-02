module ALU(outp,z,i0,i1,cntr);
    
    output [31:0] outp;
    output z;
    input [31:0] i0,i1;
    input [2:0] cntr;
    reg [31:0] outp;
    reg z;

    always@(i0 or i1 or cntr) 
          begin
           z<=0;
            case(cntr)
              
              3'b000: outp<=i0+i1;//add
              3'b001: begin
                      outp<=i0-i1;//sub
                      if (i0==i1)  
                        begin
                          z<=1;
                        end
                      end
              3'b010: outp<=i0&i1;//and
              3'b011: outp<=i0|i1;//or
              3'b100: begin
                      if(i0<i1)
                        outp<=1;
                      else
                        outp<=0;
                      end //slt
              default: outp<= 32'hffff_ffff;
              
              endcase
          end

endmodule

