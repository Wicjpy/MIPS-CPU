module TestBanch;
  reg clk,nclear,nRST;
  reg InsWrEN;
  reg [31:0] InsDataIn;
  reg [4:0] InsWrAddr;
  
  MIPS_CPU cpu(clk,nclear,nRST,InsWrEN,InsWrAddr,InsDataIn);
  
  initial
  begin
    clk = 1;
    forever #10 clk = ~clk;
  end
  
  initial
  begin
    nclear = 0;
    nRST = 0;  //regfile[31:0] = 0;
    //test instruction
    #20 InsWrEN = 1;
        //InsWrAddr = 5'b0_0000;
        //InsDataIn = 32'b001101_00000_00001_0000_0000_1010_0101;//R[1] <= R[0] or 0000_0000_1010_0101  
    #20 InsWrAddr = 5'b0_0001;//                        add  
        InsDataIn = 32'b000000_00001_00001_00010_00000_100000;//add R[2] <= R[1] + R[1]=2  

    #20 InsWrAddr = 5'b0_0010;//                        add 
        InsDataIn = 32'b000000_00001_00010_00011_00000_100000;//R[3] <= R[1] + R[2]=3  
    
    #20 InsWrAddr = 5'b0_0011;//                        sub 
        InsDataIn = 32'b000000_00011_00010_00100_00000_100010;//R[4] <= R[3] - R[2] = 1 
    
    #20 InsWrAddr = 5'b0_0100;//                        slt 
        InsDataIn = 32'b000000_00010_00011_01001_00000_101010;//R[3]<R[2]? R[9] =1:R[9]=0 =0
    
    #20 InsWrAddr = 5'b0_0101;//                        and
        InsDataIn = 32'b000000_00001_00100_00110_00000_100100;//R[6] <= R[1] & R[4] =1 
     
    #20 InsWrAddr = 5'b0_0110;//                        or
        InsDataIn = 32'b000000_00011_00100_00111_00000_100101;//R[7] <= R[3] | R[4] =3
     
    #20 InsWrAddr = 5'b0_0111;//                        sw
        InsDataIn = 32'b101011_00000_00111_0000_0000_0000_0001;//Addr <= R[0] + 1;mem[Addr] <= R[7] =3 
              
    #20 InsWrAddr = 5'b0_1000;//                        lw
        InsDataIn = 32'b100011_00000_01000_0000_0000_0000_0001;//Addr <= R[0] + 1;R[8] <= mem[Addr] =3
                        
    #20 InsWrAddr = 5'b0_1001;//                        beq                         
        InsDataIn = 32'b000100_00111_01000_0000_0000_0000_0011;//Cond <= R[7] - R[8]; if ture, next_ins <= 1110     
              
    #20 InsWrAddr = 5'b0_1101;//                        jr
        InsDataIn = 32'b000000_01010_00000_00000_00000_001000;//jump to the address value equals to R10 =15         

    #20 InsWrAddr = 5'b0_1111;//                        jal
        InsDataIn = 32'b000011_00_0000_0000_0000_0000_0001_0001;//jump to where next_ins = 10001 
        
    #20 InsWrAddr = 5'b1_0001;//                        j
        InsDataIn = 32'b000010_00_0000_0000_0000_0000_0000_1001;//jump to where next_ins = 1001 
        
    #20 nclear = 1;
        nRST = 1; //start test
  end
endmodule

