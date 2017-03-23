//--------------------------------------------------------------------------------------------
//
// Generated by X-HDL VHDL Translator - Version 2.0.0 Feb. 1, 2011
// Thu Mar 23 2017 17:05:17
//
//      Input file      : 
//      Component name  : controlunit
//      Author          : 
//      Company         : 
//
//      Description     : 
//
//
//--------------------------------------------------------------------------------------------


module controlunit(clk, ir, reset_cpu, zero, carry, ready, access_type, c0, c1, cc2, cc4, cc5, c6, c7, c8, load_ir, inc_ic, load_ic, load_c, load_z, ir_ready, s_ready, s_fetched, v_ready, v_fetched, v_done, halted);
   input            clk;
   
   input [31:0]     ir;
   
   input            reset_cpu;
   input            zero;
   input            carry;
   input            ready;
   
   output [2:0]     access_type;
   reg [2:0]        access_type;
   output           c0;
   reg              c0;
   output           c1;
   reg              c1;
   output [1:0]     cc2;
   reg [1:0]        cc2;
   output [1:0]     cc4;
   reg [1:0]        cc4;
   output [1:0]     cc5;
   reg [1:0]        cc5;
   output           c6;
   reg              c6;
   output           c7;
   reg              c7;
   output           c8;
   reg              c8;
   output           load_ir;
   reg              load_ir;
   output           inc_ic;
   reg              inc_ic;
   output           load_ic;
   reg              load_ic;
   output           load_c;
   reg              load_c;
   output           load_z;
   reg              load_z;
   
   output           ir_ready;
   reg              ir_ready;
   output           s_ready;
   reg              s_ready;
   output           s_fetched;
   reg              s_fetched;
   
   input            v_ready;
   input            v_fetched;
   input            v_done;
   
   output           halted;
   reg              halted;
   
   parameter [4:0]  statetype_if1 = 0,
                    statetype_if2 = 1,
                    statetype_decode_wait = 2,
                    statetype_ld1 = 3,
                    statetype_ld2 = 4,
                    statetype_vld1 = 5,
                    statetype_vld2 = 6,
                    statetype_vld3 = 7,
                    statetype_vld4 = 8,
                    statetype_st1 = 9,
                    statetype_st2 = 10,
                    statetype_vst1 = 11,
                    statetype_vst2 = 12,
                    statetype_vst3 = 13,
                    statetype_smv1 = 14,
                    statetype_smv2 = 15,
                    statetype_vms1 = 16,
                    statetype_vms2 = 17,
                    statetype_nop = 18,
                    statetype_jal = 19,
                    statetype_jcc = 20,
                    statetype_alu = 21,
                    statetype_flag = 22,
                    statetype_sync = 23,
                    statetype_halt = 24,
                    statetype_mova1 = 25,
                    statetype_mova2 = 26,
                    statetype_reset = 27;
   
   reg [4:0]        state;
   reg [4:0]        nextstate;
   
   
   always
   begin
      @(posedge clk);
      state <= nextstate;
   end
   
   
   always @(state or ready or reset_cpu or ir or carry or zero or v_ready or v_fetched or v_done)
   begin
      access_type <= 3'b000;
      c0 <= 1'b0;
      c1 <= 1'b0;
      cc2 <= 2'b00;
      cc4 <= 2'b00;
      cc5 <= 2'b00;
      c6 <= 1'b0;
      c7 <= 1'b0;
      c8 <= 1'b0;
      load_ir <= 1'b0;
      inc_ic <= 1'b0;
      load_ic <= 1'b0;
      load_c <= 1'b0;
      load_z <= 1'b0;
      ir_ready <= 1'b0;
      s_ready <= 1'b0;
      s_fetched <= 1'b0;
      nextstate <= statetype_reset;
      halted <= 1'b0;
      
      if (reset_cpu == 1'b1)
         nextstate <= statetype_reset;
      else
         case (state)
            statetype_reset :
               begin
                  cc4 <= 2'b10;
                  cc5 <= 2'b10;
                  load_c <= 1'b1;
                  load_z <= 1'b1;
                  nextstate <= statetype_if1;
               end
            
            statetype_if1 :
               begin
                  access_type <= 3'b010;
                  nextstate <= statetype_if2;
               end
            
            statetype_if2 :
               begin
                  access_type <= 3'b010;
                  ir_ready <= 1'b1;
                  load_ir <= 1'b1;
                  
                  if (ready == 1'b0)
                     nextstate <= statetype_if2;
                  else
                     nextstate <= statetype_decode_wait;
               end
            
            statetype_decode_wait :
               if (ir[31:28] == 4'b1000)
               begin
                  if (ready == 1'b1)
                     nextstate <= statetype_ld1;
                  else
                     nextstate <= statetype_decode_wait;
               end
               
               else if (ir[31:28] == 4'b1001)
               begin
                  if (ready == 1'b1)
                     nextstate <= statetype_vld1;
                  else
                     nextstate <= statetype_decode_wait;
               end
               
               else if (ir[31:28] == 4'b1010)
               begin
                  if (ready == 1'b1)
                     nextstate <= statetype_st1;
                  else
                     nextstate <= statetype_decode_wait;
               end
               
               else if (ir[31:26] == 6'b101100)
               begin
                  if (ready == 1'b1 & v_ready == 1'b1)
                     nextstate <= statetype_vst1;
                  else
                     nextstate <= statetype_decode_wait;
               end
               
               else if (ir[31:26] == 6'b101101)
                  nextstate <= statetype_mova1;
               
               else if (ir[31:26] == 6'b101110)
                  nextstate <= statetype_smv1;
               
               else if (ir[31:26] == 6'b101111)
                  nextstate <= statetype_vms1;
               else
                  
                  case (ir[31:30])
                     2'b00 :
                        if (ir[29] == 1'b0)
                           nextstate <= statetype_nop;
                        
                        else if (ir[29:27] == 3'b101)
                        begin
                           $display("HALT");
                           nextstate <= statetype_halt;
                        end
                        
                        else if (ir[29:26] == 4'b1000)
                           nextstate <= statetype_jal;
                        
                        else if (ir[29:28] == 2'b11)
                           nextstate <= statetype_jcc;
                     
                     2'b01 :
                        nextstate <= statetype_alu;
                     
                     2'b11 :
                        nextstate <= statetype_flag;
                     
                     default :
                        nextstate <= statetype_halt;
                  endcase
            
            statetype_ld1 :
               begin
                  access_type <= 3'b010;
                  c1 <= 1'b1;
                  c7 <= 1'b1;
                  nextstate <= statetype_ld2;
               end
            
            statetype_ld2 :
               begin
                  access_type <= 3'b010;
                  $display("LD");
                  c0 <= 1'b1;
                  c6 <= 1'b1;
                  c7 <= 1'b1;
                  c8 <= 1'b1;
                  load_z <= 1'b1;
                  inc_ic <= 1'b1;
                  
                  if (ready == 1'b0)
                     nextstate <= statetype_ld2;
                  else
                     nextstate <= statetype_sync;
               end
            
            statetype_vld1 :
               begin
                  access_type <= 3'b011;
                  c1 <= 1'b1;
                  c7 <= 1'b1;
                  
                  if (ready == 1'b1)
                     nextstate <= statetype_vld1;
                  else
                     nextstate <= statetype_vld2;
               end
            
            statetype_vld2 :
               begin
                  access_type <= 3'b011;
                  c1 <= 1'b1;
                  c7 <= 1'b1;
                  
                  if (ready == 1'b1)
                     nextstate <= statetype_vld3;
                  else
                     nextstate <= statetype_vld2;
               end
            
            statetype_vld3 :
               begin
                  access_type <= 3'b011;
                  c1 <= 1'b1;
                  c7 <= 1'b1;
                  s_ready <= 1'b1;
                  
                  if (v_fetched == 1'b1)
                     nextstate <= statetype_vld4;
                  else
                     nextstate <= statetype_vld3;
               end
            
            statetype_vld4 :
               begin
                  $display("VLD");
                  inc_ic <= 1'b1;
                  nextstate <= statetype_sync;
               end
            
            statetype_st1 :
               begin
                  access_type <= 3'b100;
                  c1 <= 1'b1;
                  c7 <= 1'b1;
                  inc_ic <= 1'b1;
                  
                  nextstate <= statetype_st2;
               end
            
            statetype_st2 :
               begin
                  access_type <= 3'b100;
                  c1 <= 1'b1;
                  c7 <= 1'b1;
                  
                  if (ready == 1'b0)
                     nextstate <= statetype_st2;
                  else
                     nextstate <= statetype_sync;
               end
            
            statetype_vst1 :
               begin
                  access_type <= 3'b101;
                  c1 <= 1'b1;
                  c7 <= 1'b1;
                  
                  if (ready == 1'b1)
                     nextstate <= statetype_vst1;
                  else
                     nextstate <= statetype_vst2;
               end
            
            statetype_vst2 :
               begin
                  access_type <= 3'b101;
                  c1 <= 1'b1;
                  c7 <= 1'b1;
                  
                  if (ready == 1'b1)
                     nextstate <= statetype_vst3;
                  else
                     nextstate <= statetype_vst2;
               end
            
            statetype_vst3 :
               begin
                  $display("VST");
                  s_fetched <= 1'b1;
                  inc_ic <= 1'b1;
                  nextstate <= statetype_sync;
               end
            
            statetype_smv1 :
               begin
                  s_ready <= 1'b1;
                  
                  if (v_fetched == 1'b1)
                     nextstate <= statetype_smv2;
                  else
                     nextstate <= statetype_smv1;
               end
            
            statetype_smv2 :
               begin
                  $display("MOV R(T), S");
                  inc_ic <= 1'b1;
                  nextstate <= statetype_sync;
               end
            
            statetype_mova1 :
               begin
                  s_ready <= 1'b1;
                  
                  if (v_fetched == 1'b1)
                     nextstate <= statetype_mova2;
                  else
                     nextstate <= statetype_mova1;
               end
            
            statetype_mova2 :
               begin
                  $display("MOVA");
                  inc_ic <= 1'b1;
                  nextstate <= statetype_sync;
               end
            
            statetype_vms1 :
               if (v_ready == 1'b1)
                  nextstate <= statetype_vms2;
               else
                  nextstate <= statetype_vms1;
            
            statetype_vms2 :
               begin
                  $display("MOV D, V(T)");
                  cc2 <= 2'b10;
                  c6 <= 1'b1;
                  s_fetched <= 1'b1;
                  inc_ic <= 1'b1;
                  nextstate <= statetype_sync;
               end
            
            statetype_nop :
               begin
                  $display("NOP");
                  inc_ic <= 1'b1;
                  nextstate <= statetype_sync;
               end
            
            statetype_jal :
               begin
                  $display("JMP, JAL");
                  c7 <= 1'b1;
                  load_ic <= 1'b1;
                  cc2 <= 2'b01;
                  c6 <= 1'b1;
                  nextstate <= statetype_sync;
               end
            
            statetype_jcc :
               begin
                  $display("JCC");
                  if ((ir[27] == 1'b0 & ir[26] == carry) | (ir[27] == 1'b1 & ir[26] == zero))
                  begin
                     c7 <= 1'b1;
                     load_ic <= 1'b1;
                  end
                  else
                     inc_ic <= 1'b1;
                  
                  nextstate <= statetype_sync;
               end
            
            statetype_alu :
               begin
                  $display("ALU COMMANDS");
                  load_c <= 1'b1;
                  load_z <= 1'b1;
                  c6 <= 1'b1;
                  inc_ic <= 1'b1;
                  nextstate <= statetype_sync;
               end
            
            statetype_flag :
               begin
                  $display("SET/RESET FLAGS");
                  load_z <= ir[23];
                  load_c <= ir[22];
                  cc4 <= {1'b1, ir[21]};
                  cc5 <= {1'b1, ir[20]};
                  inc_ic <= 1'b1;
                  nextstate <= statetype_sync;
               end
            
            statetype_sync :
               if (v_done == 1'b1)
                  nextstate <= statetype_if1;
               else
                  nextstate <= statetype_sync;
            
            statetype_halt :
               begin
                  $display("halted");
                  halted <= 1'b1;
                  nextstate <= statetype_halt;
               end
         endcase
   end
   
endmodule
