module mux21(outp,i0,i1,cntr);
  output [31:0] outp;
  input [31:0] i0,i1;
  input cntr;
  assign outp = cntr ? i1 :i0;
endmodule

