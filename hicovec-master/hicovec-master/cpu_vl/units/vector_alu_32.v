//--------------------------------------------------------------------------------------------
//
// Generated by X-HDL VHDL Translator - Version 2.0.0 Feb. 1, 2011
// Wed Mar 22 2017 20:56:15
//
//      Input file      : 
//      Component name  : vector_alu_32
//      Author          : 
//      Company         : 
//
//      Description     : 
//
//
//--------------------------------------------------------------------------------------------
// Vector_alu signal sizes are mess up, need verify and update

module vector_alu_32(clk, v_in, w_in, carry_in, rshift_in, carry_out, valu_out, valuop, source_sel, carry_sel, mult_source_sel, mult_dest_sel, reg_input_sel, load_lsr, load_other);
   input         clk;
   
   input [31:0]  v_in;
   input [31:0]  w_in;
   input         carry_in;
   input         rshift_in;
   
   output        carry_out;
   output [31:0] valu_out;
   
   input [3:0]   valuop;
   input [1:0]   source_sel;
   input [1:0]   carry_sel;
   input [1:0]   mult_source_sel;
   input [1:0]   mult_dest_sel;
   input         reg_input_sel;
   input         load_lsr;
   input         load_other;
   
   
   wire          carry;
   wire          rshift;
   
   wire [3:0]    left;
   wire [3:0]    right;
   wire [3:0]    valu_res;
   
   wire [3:0]    mult_right;
   wire [3:0]    mult_left;
   wire [4:0]    mult_res32;
   wire [2:0]    mult_res8;
   
   reg [32:0]     output_xhdl1;
   wire [8:0]    input_xhdl0;
   
   assign carry = ((carry_sel == 2'b00)) ? carry_in : 
                  ((carry_sel == 2'b01)) ? output_xhdl1[32] : 
                  1'b0;
   
   assign rshift = ((carry_sel == 2'b00)) ? rshift_in : 
                   ((carry_sel == 2'b01)) ? output_xhdl1[32] : 
                   1'b0;
   
   assign left = ((source_sel) == 2'b00) ? ({1'b0, v_in[7:0]}) : 
                 ((source_sel) == 2'b01) ? ({1'b0, v_in[15:8]}) : 
                 ((source_sel) == 2'b10) ? ({1'b0, v_in[23:16]}) : 
                 ({1'b0, v_in[31:24]});
   
   assign right = ((source_sel) == 2'b00) ? ({1'b0, w_in[7:0]}) : 
                  ((source_sel) == 2'b01) ? ({1'b0, w_in[15:8]}) : 
                  ((source_sel) == 2'b10) ? ({1'b0, w_in[23:16]}) : 
                  ({1'b0, w_in[31:24]});
   
   assign valu_res = ((valuop == 4'b0000)) ? left + right + carry : 
                     ((valuop == 4'b0010)) ? left - right - carry : 
                     ((valuop == 4'b1100)) ? {left[7:0], carry} : 
                     ((valuop == 4'b1110)) ? {left[0], rshift, left[7:1]} : 
                     ((valuop == 4'b1000)) ? (left & right) : 
                     ((valuop == 4'b1001)) ? (left | right) : 
                     (left ^ right);
   
   generate
      if (use_vector_mult)
      begin : mult_gen
         assign mult_left = (mult_source_sel == 2'b00) ? ({8'b00000000, v_in[7:0]}) : 
                            (mult_source_sel == 2'b01) ? ({8'b00000000, v_in[23:16]}) : 
                            (v_in[15:0]);
         
         assign mult_right = (mult_source_sel == 2'b00) ? ({8'b00000000, w_in[7:0]}) : 
                             (mult_source_sel == 2'b01) ? ({8'b00000000, w_in[23:16]}) : 
                             (w_in[15:0]);
         
         assign mult_res32 = mult_left * mult_right;
         
         assign mult_res8 = (mult_dest_sel == 2'b00) ? mult_res32[7:0] : 
                            (mult_dest_sel == 2'b01) ? mult_res32[15:8] : 
                            (mult_dest_sel == 2'b10) ? mult_res32[23:16] : 
                            mult_res32[31:24];
      end
   endgenerate
   
   generate
      if (~use_vector_mult)
      begin : not_mult_gen
         assign mult_res8 = 8'b00000000;
      end
   endgenerate
   
   assign input_xhdl0 = (reg_input_sel == 1'b0) ? valu_res : 
                        {1'b0, mult_res8};
   
   
   always
   begin
      @(posedge clk);
      if (load_other == 1'b1)
      begin
         output_xhdl1[32:24] <= input_xhdl0[8:0];
         output_xhdl1[23:0] <= output_xhdl1[31:8];
      end
      else
         if (load_lsr == 1'b1)
         begin
            output_xhdl1[7:0] <= input_xhdl0[7:0];
            output_xhdl1[32] <= input_xhdl0[8];
            output_xhdl1[31:8] <= output_xhdl1[23:0];
         end
         else
            output_xhdl1 <= output_xhdl1;
   end
   
   assign valu_out = (output_xhdl1[31:0]);
   assign carry_out = output_xhdl1[32];
   
endmodule



