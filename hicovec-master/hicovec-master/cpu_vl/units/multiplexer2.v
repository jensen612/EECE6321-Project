//--------------------------------------------------------------------------------------------
// Wed Mar 22 2017 21:05:11
//
//      Component name  : multiplexer2
//      Author          : 
//      Company         : 
//
//      Description     : Input/Output size of the mux is controllable through knob parameter w
//      Validity        : Modelsim Verified 
//
//--------------------------------------------------------------------------------------------


module multiplexer2(selector, data_in_0, data_in_1, data_out);
   parameter      w = 0;   // w can be modified during module instantiation
   input          selector; 
   input [w-1:0]  data_in_0;
   input [w-1:0]  data_in_1;
   output [w-1:0] data_out;
   
   assign data_out = (selector == 1'b0) ? data_in_0 : 
                     data_in_1;
   
endmodule
