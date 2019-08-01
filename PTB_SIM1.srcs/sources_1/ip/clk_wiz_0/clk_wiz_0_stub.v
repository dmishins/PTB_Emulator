// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (lin64) Build 2552052 Fri May 24 14:47:09 MDT 2019
// Date        : Thu Jul 25 13:35:34 2019
// Host        : HP-Laptop running 64-bit Linux Mint 19.1 Tessa
// Command     : write_verilog -force -mode synth_stub
//               /media/dmishins/1AD0BEB7D0BE9909/Users/Daniel/Desktop/Research/FPGA/DEV_BOARD/PROJECTS/PTB_SIM1/PTB_SIM1.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.v
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(CLK10MHZ, resetn, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="CLK10MHZ,resetn,locked,clk_in1" */;
  output CLK10MHZ;
  input resetn;
  output locked;
  input clk_in1;
endmodule
