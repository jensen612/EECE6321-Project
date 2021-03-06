//--------------------------------------------------------------------------------------------
//
// Generated by X-HDL VHDL Translator - Version 2.0.0 Feb. 1, 2011
// Thu Mar 23 2017 17:05:10
//
//      Input file      : 
//      Component name  : alu
//      Author          : 
//      Company         : 
//
//      Description     : 
//
//
//--------------------------------------------------------------------------------------------


module alu(a_in, b_in, carry_in, aluop, op_select, zero_out, carry_out, alu_out);
   input [31:0]  a_in;
   input [31:0]  b_in;
   input         carry_in;
   input [3:0]   aluop;
   input         op_select;
   output        zero_out;
   reg           zero_out;
   output        carry_out;
   reg           carry_out;
   output [31:0] alu_out;
   reg [31:0]    alu_out;
   
   
   wire [3:0]    aluop_multiplexed;
   
   wire [5:0]    left;
   wire [5:0]    right;
   wire [4:0]    mult_res;
   wire          carry;
   
   
   multiplexer2 #(4) mux(.selector(op_select), .data_in_0(aluop), .data_in_1(4'b0000), .data_out(aluop_multiplexed));
   
   
   always @(a_in or b_in or carry or left or right or aluop_multiplexed or mult_res)
   begin: xhdl0
      reg [5:0]     alu_out_buffer;
      case (aluop_multiplexed)
         4'b0000, 4'b0001, 4'b0100 :
            alu_out_buffer = left + right + carry;
         
         4'b0010, 4'b0011, 4'b0110 :
            alu_out_buffer = left - right - carry;
         
         4'b1000 :
            alu_out_buffer = {1'b0, (a_in & b_in)};
         
         4'b1001 :
            alu_out_buffer = {1'b0, (a_in | b_in)};
         
         4'b1010 :
            alu_out_buffer = {1'b0, (a_in ^ b_in)};
         
         4'b1011 :
            alu_out_buffer = {1'b0, mult_res};
         
         4'b1100 :
            begin
               alu_out_buffer[32:1] = left[31:0];
               alu_out_buffer[0] = 1'b0;
            end
         
         4'b1110 :
            begin
               alu_out_buffer[32] = left[0];
               alu_out_buffer[30:0] = left[31:1];
               alu_out_buffer[31] = 1'b0;
            end
         
         4'b1101 :
            begin
               alu_out_buffer[32:1] = left[31:0];
               alu_out_buffer[0] = carry;
            end
         
         4'b1111 :
            begin
               alu_out_buffer[32] = left[0];
               alu_out_buffer[30:0] = left[31:1];
               alu_out_buffer[31] = carry;
            end
         
         default :
            alu_out_buffer = {33{1'b0}};
      endcase
      
      alu_out <= (alu_out_buffer[31:0]);
      carry_out <= alu_out_buffer[32];
      
      if (alu_out_buffer[31:0] == 0)
         zero_out <= 1'b1;
      else
         zero_out <= 1'b0;
   end
   
   assign left = ({1'b0, a_in});
   
   assign right = ((aluop_multiplexed == 4'b0100 | aluop_multiplexed == 4'b0110)) ? {33{1'b0}} : 
                  ({1'b0, b_in});
   
   assign carry = ((aluop_multiplexed == 4'b0000 | aluop_multiplexed == 4'b0010)) ? 1'b0 : 
                  ((aluop_multiplexed == 4'b0100 | aluop_multiplexed == 4'b0110)) ? 1'b1 : 
                  carry_in;
   
   generate
      if (use_scalar_mult)
      begin : mult_gen
         assign mult_res = left[15:0] * right[15:0];
      end
   endgenerate
   
   generate
      if (~use_scalar_mult)
      begin : not_mult_gen
         assign mult_res = {32{1'b0}};
      end
   endgenerate
   
endmodule
