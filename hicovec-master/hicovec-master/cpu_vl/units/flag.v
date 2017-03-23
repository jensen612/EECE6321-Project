//--------------------------------------------------------------------------------------------
//
// Generated by X-HDL VHDL Translator - Version 2.0.0 Feb. 1, 2011
// Thu Mar 23 2017 17:05:43
//
//      Input file      : 
//      Component name  : flag
//      Author          : 
//      Company         : 
//
//      Description     : 
//
//
//--------------------------------------------------------------------------------------------


module flag(clk, load, data_in, data_out);
   input   clk;
   input   load;
   input   data_in;
   output  data_out;
   
   reg     q;
   
   always
   begin
      @(posedge clk);
      
      if (load == 1'b1)
         q <= data_in;
      else
         q <= q;
   end
   
   assign data_out = q;
   
endmodule