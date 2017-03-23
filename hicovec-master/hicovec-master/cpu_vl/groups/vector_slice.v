//--------------------------------------------------------------------------------------------
//
// Generated by X-HDL VHDL Translator - Version 2.0.0 Feb. 1, 2011
// Wed Mar 22 2017 21:03:57
//
//      Input file      : 
//      Component name  : vector_slice
//      Author          : 
//      Company         : 
//
//      Description     : 
//
//
//--------------------------------------------------------------------------------------------


module vector_slice(clk, memory_in, scalar_in, shuffle_in, carry_in, rshift_in, v_out, w_out, carry_out, rrrr, vvvv, wwww, k_in, load_r, cc9, c12, valuop, source_sel, carry_sel, mult_source_sel, mult_dest_sel, reg_input_sel, load_lsr, load_other);
   parameter     slicenr = 0;
   input         clk;
   
   input [31:0]  memory_in;
   input [31:0]  scalar_in;
   input [31:0]  shuffle_in;
   input         carry_in;
   input         rshift_in;
   
   output [31:0] v_out;
   output [31:0] w_out;
   output        carry_out;
   
   input [7:0]   rrrr;
   input [7:0]   vvvv;
   input [3:0]   wwww;
   input [31:0]  k_in;
   input         load_r;
   input [1:0]   cc9;
   input         c12;
   
   input [3:0]   valuop;
   input [1:0]   source_sel;
   input [1:0]   carry_sel;
   input [1:0]   mult_source_sel;
   input [1:0]   mult_dest_sel;
   input         reg_input_sel;
   input         load_lsr;
   input         load_other;
   
   
   wire [31:0]   v;
   wire [31:0]   w;
   wire [31:0]   r;
   wire [31:0]   valu_result;
   
   assign v_out = v;
   assign w_out = w;
   
   
   multiplexer4 #(32) vreg_input_mux(.selector(cc9), .data_in_00(valu_result), .data_in_01(scalar_in), .data_in_10(memory_in), .data_in_11(shuffle_in), .data_out(r));
   
   
   vector_register #(n, slicenr) vreg(.clk(clk), .r_in(r), .v_out(v), .w_out(w), .load_r(load_r), .load_select(c12), .k_in(k_in), .select_v(vvvv), .select_w(wwww), .select_r(rrrr));
   
   
   vector_alu_32 valu(.clk(clk), .v_in(v), .w_in(w), .carry_in(carry_in), .rshift_in(rshift_in), .carry_out(carry_out), .valu_out(valu_result), .valuop(valuop), .source_sel(source_sel), .carry_sel(carry_sel), .mult_source_sel(mult_source_sel), .mult_dest_sel(mult_dest_sel), .reg_input_sel(reg_input_sel), .load_lsr(load_lsr), .load_other(load_other));
   
endmodule
