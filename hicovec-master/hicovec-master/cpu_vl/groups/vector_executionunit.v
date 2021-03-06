//--------------------------------------------------------------------------------------------
//
// Generated by X-HDL VHDL Translator - Version 2.0.0 Feb. 1, 2011
// Wed Mar 22 2017 20:55:39
//
//      Input file      : 
//      Component name  : vector_executionunit
//      Author          : 
//      Company         : 
//
//      Description     : 
//
//
//--------------------------------------------------------------------------------------------
// Some unrecognized signal xhdl0 needs to be inspected

module vector_executionunit(clk, memory_in, scalar_in, memory_out, scalar_out, out_valid, shuffle_valid, rrrr, vvvv, wwww, k_in, vn, valuop, vwidth, load_r, cc9, c10, c11, c12, cc13, valu_go, shuffle_go);
   input         clk;
   
   input         memory_in;
   input [31:0]  scalar_in;
   
   output        memory_out;
   output [31:0] scalar_out;
   output        out_valid;
   output        shuffle_valid;
   
   input [3:0]   rrrr;
   input [3:0]   vvvv;
   input [3:0]   wwww;
   input [31:0]  k_in;
   input [7:0]   vn;
   input [3:0]   valuop;
   input [1:0]   vwidth;
   input         load_r;
   input [1:0]   cc9;
   input         c10;
   input         c11;
   input         c12;
   input [1:0]   cc13;
   input         valu_go;
   input         shuffle_go;
   
   
   wire [k-1:0]  carry;
   wire          v_vector;
   wire          w_vector;
   wire          shuffle_out;
   wire [7:0]    select_v;
   wire [7:0]    select_r;
   
   wire [7:0]    sel_r;
   wire [7:0]    sel_v;
   wire [3:0]    sel_w;
   
   wire [7:0]    rrrr_ext;
   wire [7:0]    vvvv_ext;
   
   wire [1:0]    source_sel;
   wire [1:0]    carry_sel;
   wire [1:0]    mult_source_sel;
   wire [1:0]    mult_dest_sel;
   wire          reg_input_sel;
   wire          load_lsr;
   wire          load_other;
   
   assign rrrr_ext = {4'b0000, rrrr};
   assign vvvv_ext = {4'b0000, vvvv};
   
   
   multiplexer2 #(8) rrrr_mux(.selector(c10), .data_in_0(rrrr_ext), .data_in_1(vn), .data_out(select_r));
   
   
   multiplexer2 #(8) vvvv_mux(.selector(c11), .data_in_0(vvvv_ext), .data_in_1(vn), .data_out(select_v));
   
   assign sel_r = ((select_r < n)) ? select_r : 
                  {8{1'b0}};
   assign sel_v = ((select_v < n)) ? select_v : 
                  {8{1'b0}};
   assign sel_w = ((wwww < n)) ? wwww : 
                  {4{1'b0}};
   
   
   selectunit selectunit_impl(.data_in(v_vector), .k_in(k_in), .data_out(scalar_out));
   
   
   shuffle shuffle_impl(.clk(clk), .shuffle_go(shuffle_go), .shuffle_valid(shuffle_valid), .data_in_v(v_vector), .data_in_w(w_vector), .vn(vn), .ssss(valuop), .vwidth(vwidth), .shuffle_out_sel(cc13), .data_out(shuffle_out));
   
   
   valu_controlunit valu_controlunit_impl(.clk(clk), .valu_go(valu_go), .valuop(valuop), .vwidth(vwidth), .source_sel(source_sel), .carry_sel(carry_sel), .mult_source_sel(mult_source_sel), .mult_dest_sel(mult_dest_sel), .reg_input_sel(reg_input_sel), .load_lsr(load_lsr), .load_other(load_other), .out_valid(out_valid));
   
   generate
      begin : xhdl0
         genvar        i;
         for (i = k - 1; i >= 0; i = i - 1)
         begin : vector_slice_impl
            if (i % 2 == 0)
            begin : vector_slice_even
               
               vector_slice #(i) slice_even(.clk(clk), .memory_in(memory_in[i]), .scalar_in(scalar_in), .shuffle_in(shuffle_out[i]), .carry_in(1'b0), .rshift_in(carry[i + 1]), .v_out(v_vector[i]), .w_out(w_vector[i]), .carry_out(carry[i]), .rrrr(sel_r), .vvvv(sel_v), .wwww(sel_w), .k_in(k_in), .load_r(load_r), .cc9(cc9), .c12(c12), .valuop(valuop), .source_sel(source_sel), .carry_sel(carry_sel), .mult_source_sel(mult_source_sel), .mult_dest_sel(mult_dest_sel), .reg_input_sel(reg_input_sel), .load_lsr(load_lsr), .load_other(load_other));
            end
            
            if (i % 2 == 1)
            begin : vector_slice_uneven
               
               vector_slice #(i) slice_uneven(.clk(clk), .memory_in(memory_in[i]), .scalar_in(scalar_in), .shuffle_in(shuffle_out[i]), .carry_in(carry[i - 1]), .rshift_in(1'b0), .v_out(v_vector[i]), .w_out(w_vector[i]), .carry_out(carry[i]), .rrrr(sel_r), .vvvv(sel_v), .wwww(sel_w), .k_in(k_in), .load_r(load_r), .cc9(cc9), .c12(c12), .valuop(valuop), .source_sel(source_sel), .carry_sel(carry_sel), .mult_source_sel(mult_source_sel), .mult_dest_sel(mult_dest_sel), .reg_input_sel(reg_input_sel), .load_lsr(load_lsr), .load_other(load_other));
            end
         end
      end
   endgenerate
   
   assign memory_out = v_vector;
   
endmodule
