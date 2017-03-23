//--------------------------------------------------------------------------------------------
//
// Generated by X-HDL VHDL Translator - Version 2.0.0 Feb. 1, 2011
// Wed Mar 22 2017 21:05:11
//
//      Input file      : 
//      Component name  : multiplexer2
//      Author          : 
//      Company         : 
//
//      Description     : 
//
//
//--------------------------------------------------------------------------------------------


module multiplexer2(selector, data_in_0, data_in_1, data_out);
   parameter      w = 0; //positive is treated as a variable
   input          selector;
   input [w-1:0]  data_in_0;
   input [w-1:0]  data_in_1;
   output [w-1:0] data_out;
   
   assign data_out = (selector == 1'b0) ? data_in_0 : 
                     data_in_1;
   
endmodule