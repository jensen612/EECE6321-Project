//--------------------------------------------------------------------------------------------
//
//      Component name  : selectunit
//      Author          : 
//      Company         : 
//
//      Description     : select a 32b output from vectorized output based on value of k_in
//                        instead of using predefined datatype, we store 32k bit data_in in an array
//      Validity        : Modelsim proven
//
//--------------------------------------------------------------------------------------------

`include "./programmable_const.v"

module selectunit(data_in, k_in, data_out);
   input [32*(`k)-1:0] data_in; //verilog doesn't allow I/O port to be array
   input [31:0] k_in;
   output [31:0] data_out;
   
   
   assign data_out = (k_in<(`k)) ? data_in[32*k_in+31 -: 32] : data_in[31:0];
   
endmodule
