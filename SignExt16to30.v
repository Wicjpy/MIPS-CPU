module SignExt16to30 (data_in,data_out);
  input [15:0]data_in;
  output [29:0]data_out;
  
  assign data_out = data_in[15]?{14'b1111_1111_1111_11,data_in}:{14'b0000_0000_0000_00,data_in};
  
endmodule

