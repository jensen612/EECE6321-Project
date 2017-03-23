//--------------------------------------------------------------------------------------------
//
// Generated by X-HDL VHDL Translator - Version 2.0.0 Feb. 1, 2011
// Thu Mar 23 2017 17:05:51
//
//      Input file      : 
//      Component name  : instructioncounter
//      Author          : 
//      Company         : 
//
//      Description     : 
//
//
//--------------------------------------------------------------------------------------------


module instructioncounter(clk, load, inc, reset, data_in, data_out);
   input         clk;
   input         load;
   input         inc;
   input         reset;
   input [31:0]  data_in;
   output [31:0] data_out;
   
   reg [4:0]     data_out_buffer;
   
   always
   begin
      @(posedge clk);
      if (reset == 1'b1)
         data_out_buffer <= 32'b00000000000000000000000000000000;
      else
      begin
         if (load == 1'b1 & inc == 1'b0)
            data_out_buffer <= data_in;
         
         if (load == 1'b0 & inc == 1'b1)
            data_out_buffer <= data_out_buffer + inc;
         
         if (load == inc)
            data_out_buffer <= data_out_buffer;
      end
   end
   
   assign data_out = data_out_buffer;
   
endmodule

