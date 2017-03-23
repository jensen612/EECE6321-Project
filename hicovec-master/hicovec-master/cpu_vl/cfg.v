//--------------------------------------------------------------------------------------------
//
// Generated by X-HDL VHDL Translator - Version 2.0.0 Feb. 1, 2011
// Wed Mar 22 2017 21:14:07
//
//      Input file      : 
//      Component name  : cfg
//      Author          : 
//      Company         : 
//
//      Description     : 
//
//
//--------------------------------------------------------------------------------------------
// Need Combined the configuration file with programmable_const.v

`ifndef cfg
`define cfg

parameter  n = 10;
parameter  k = 20;

parameter  use_debugger = 1'b1;

parameter  use_scalar_mult = 1'b1;
parameter  use_vector_mult = 1'b0;

parameter  use_shuffle = 1'b0;
parameter  max_shuffle_width = 0;

parameter  use_vectorshift = 1'b1;
parameter  vectorshift_width = 32;

parameter  sram_size = 4096;

`endif
