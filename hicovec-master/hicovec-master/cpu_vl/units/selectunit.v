//--------------------------------------------------------------------------------------------
//
//      Component name  : selectunit
//      Author          : 
//      Company         : 
//
//      Description     : select a 32b output from vectorized output based on value of k_in
//
//
//--------------------------------------------------------------------------------------------

`include "./programmable_const.v"

module selectunit(data_in, k_in, data_out);
   input [`k-1:0] data_in [0:31];
   input [31:0] k_in;
   output [31:0] data_out;
   integer index;
   
   assign index = k_in;
   assign data_out = (k_in<(`k)) ? data_in[index] : data_in[0];
   
endmodule
