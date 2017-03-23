//--------------------------------------------------------------------------------------------
//
// Generated by X-HDL VHDL Translator - Version 2.0.0 Feb. 1, 2011
// Thu Mar 23 2017 17:04:07
//
//      Input file      : 
//      Component name  : cpu
//      Author          : 
//      Company         : 
//
//      Description     : 
//
//
//--------------------------------------------------------------------------------------------


module cpu(clk, reset, dbg_a, dbg_x, dbg_y, dbg_ir, dbg_ic, dbg_carry, dbg_zero, dbg_ir_ready, dbg_halted, mem_data_in, mem_data_out, mem_vdata_in, mem_vdata_out, mem_address, mem_access, mem_ready);
   input         clk;
   input         reset;
   
   output [31:0] dbg_a;
   output [31:0] dbg_x;
   output [31:0] dbg_y;
   output [31:0] dbg_ir;
   output [31:0] dbg_ic;
   output        dbg_carry;
   output        dbg_zero;
   output        dbg_ir_ready;
   output        dbg_halted;
   
   input [31:0]  mem_data_in;
   output [31:0] mem_data_out;
   input         mem_vdata_in;
   output        mem_vdata_out;
   output [31:0] mem_address;
   output [2:0]  mem_access;
   input         mem_ready;
   
   
   wire [31:0]   ir;
   wire          zero;
   wire          carry;
   wire          c0;
   wire          c1;
   wire [1:0]    cc2;
   wire [1:0]    cc4;
   wire [1:0]    cc5;
   wire          c6;
   wire          c7;
   wire          c8;
   wire          load_ir;
   wire          inc_ic;
   wire          load_ic;
   wire          load_c;
   wire          load_z;
   wire          ir_ready;
   wire          s_ready;
   wire          s_fetched;
   wire          v_ready;
   wire          v_fetched;
   wire          v_done;
   
   wire [31:0]   x;
   wire [31:0]   y;
   wire [31:0]   a;
   wire [31:0]   k_out;
   wire [31:0]   vector_out;
   wire [31:0]   alu_input_a;
   wire [31:0]   alu_input_b;
   
   wire [3:0]    aluop;
   wire          zero_out;
   wire          carry_out;
   wire [31:0]   alu_out;
   
   wire [31:0]   ic;
   
   wire [31:0]   vector_in;
   
   wire [1:0]    ss;
   wire [1:0]    dd;
   wire [1:0]    tt;
   
   wire          load_r;
   wire [1:0]    cc9;
   wire          c10;
   wire          c11;
   wire          c12;
   wire [1:0]    cc13;
   wire          valu_go;
   wire          out_valid;
   wire          shuffle_go;
   wire          shuffle_valid;
   
   wire [3:0]    rrrr;
   wire [3:0]    vvvv;
   wire [3:0]    wwww;
   wire [7:0]    vn;
   wire [3:0]    valuop;
   wire [1:0]    vwidth;
   
   
   controlunit controlunit_impl(.clk(clk), .ir(ir), .reset_cpu(reset), .zero(zero), .carry(carry), .ready(mem_ready), .access_type(mem_access), .c0(c0), .c1(c1), .cc2(cc2), .cc4(cc4), .cc5(cc5), .c6(c6), .c7(c7), .c8(c8), .load_ir(load_ir), .inc_ic(inc_ic), .load_ic(load_ic), .load_c(load_c), .load_z(load_z), .ir_ready(ir_ready), .s_ready(s_ready), .s_fetched(s_fetched), .v_ready(v_ready), .v_fetched(v_fetched), .v_done(v_done), .halted(dbg_halted));
   
   
   aluinputgroup aluinputgroup_impl(.clk(clk), .memory_in(mem_data_in), .x_in(x), .y_in(y), .a_in(a), .ir_out(ir), .k_out(k_out), .vector_out(vector_out), .a_out(alu_input_a), .b_out(alu_input_b), .sel_a(ss), .sel_b(tt), .sel_source_a(c8), .sel_source_b(c0), .load_ir(load_ir));
   
   
   alu alu_impl(.a_in(alu_input_a), .b_in(alu_input_b), .carry_in(carry), .aluop(aluop), .op_select(c7), .carry_out(carry_out), .zero_out(zero_out), .alu_out(alu_out));
   
   
   addressgroup addressgroup_impl(.clk(clk), .address_in(alu_out), .address_out(mem_address), .ic_out(ic), .sel_source(c1), .inc(inc_ic), .load_ic(load_ic), .reset_ic(reset));
   
   
   registergroup registergroup_impl(.clk(clk), .result_in(alu_out), .vector_in(vector_in), .ic_in(ic), .enable_in(c6), .x_out(x), .y_out(y), .a_out(a), .sel_source(cc2), .sel_dest(dd));
   
   
   flaggroup flaggroup_impl(.clk(clk), .c_in(carry_out), .z_in(zero_out), .c_out(carry), .z_out(zero), .load_c(load_c), .load_z(load_z), .sel_c(cc5), .sel_z(cc4));
   
   
   vector_controlunit vector_controlunit_impl(.clk(clk), .ir(ir), .load_r(load_r), .cc9(cc9), .c10(c10), .c11(c11), .c12(c12), .cc13(cc13), .valu_go(valu_go), .shuffle_go(shuffle_go), .out_valid(out_valid), .shuffle_valid(shuffle_valid), .ir_ready(ir_ready), .s_ready(s_ready), .s_fetched(s_fetched), .v_ready(v_ready), .v_fetched(v_fetched), .v_done(v_done));
   
   
   vector_executionunit vector_executionunit_impl(.clk(clk), .memory_in(mem_vdata_in), .scalar_in(vector_out), .memory_out(mem_vdata_out), .scalar_out(vector_in), .out_valid(out_valid), .shuffle_valid(shuffle_valid), .rrrr(rrrr), .vvvv(vvvv), .wwww(wwww), .k_in(k_out), .vn(vn), .valuop(valuop), .vwidth(vwidth), .load_r(load_r), .cc9(cc9), .c10(c10), .c11(c11), .c12(c12), .cc13(cc13), .valu_go(valu_go), .shuffle_go(shuffle_go));
   
   assign dd = ir[25:24];
   assign ss = ir[23:22];
   assign tt = ir[21:20];
   assign aluop = ir[29:26];
   assign rrrr = ir[11:8];
   assign vvvv = ir[7:4];
   assign wwww = ir[3:0];
   assign vn = ir[27:20];
   assign valuop = ir[15:12];
   assign vwidth = ir[17:16];
   
   assign mem_data_out = a;
   
   assign dbg_a = a;
   assign dbg_x = x;
   assign dbg_y = y;
   assign dbg_ir = ir;
   assign dbg_ic = ic;
   assign dbg_carry = carry;
   assign dbg_zero = zero;
   assign dbg_ir_ready = ir_ready;
   
endmodule
