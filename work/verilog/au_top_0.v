/*
   This file was generated automatically by Alchitry Labs version 1.2.1.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module au_top_0 (
    input clk,
    input rst_n,
    output reg [7:0] led,
    input usb_rx,
    output reg usb_tx,
    output reg [23:0] io_led,
    output reg [7:0] io_seg,
    output reg [3:0] io_sel,
    input [23:0] io_dip,
    input [3:0] button,
    input reset_button,
    output reg red0,
    output reg green0,
    output reg blue0,
    output reg red1,
    output reg green1,
    output reg blue1,
    output reg latch,
    output reg blank,
    output reg sclk_out,
    output reg [3:0] address
  );
  
  
  
  reg rst;
  
  wire [(3'h4+0)-1:0] M_buttoncond_out;
  reg [(3'h4+0)-1:0] M_buttoncond_in;
  
  genvar GEN_buttoncond0;
  generate
  for (GEN_buttoncond0=0;GEN_buttoncond0<3'h4;GEN_buttoncond0=GEN_buttoncond0+1) begin: buttoncond_gen_0
    button_conditioner_1 buttoncond (
      .clk(clk),
      .in(M_buttoncond_in[GEN_buttoncond0*(1)+(1)-1-:(1)]),
      .out(M_buttoncond_out[GEN_buttoncond0*(1)+(1)-1-:(1)])
    );
  end
  endgenerate
  
  wire [(3'h4+0)-1:0] M_buttondetector_out;
  reg [(3'h4+0)-1:0] M_buttondetector_in;
  
  genvar GEN_buttondetector0;
  generate
  for (GEN_buttondetector0=0;GEN_buttondetector0<3'h4;GEN_buttondetector0=GEN_buttondetector0+1) begin: buttondetector_gen_0
    edge_detector_2 buttondetector (
      .clk(clk),
      .in(M_buttondetector_in[GEN_buttondetector0*(1)+(1)-1-:(1)]),
      .out(M_buttondetector_out[GEN_buttondetector0*(1)+(1)-1-:(1)])
    );
  end
  endgenerate
  
  wire [16-1:0] M_beta_ia;
  wire [16-1:0] M_beta_mem_data_address;
  wire [16-1:0] M_beta_mem_data_output;
  wire [1-1:0] M_beta_xwr;
  wire [16-1:0] M_beta_debug;
  reg [1-1:0] M_beta_clk;
  reg [1-1:0] M_beta_slowclk;
  reg [1-1:0] M_beta_interrupt;
  reg [32-1:0] M_beta_instruction;
  reg [16-1:0] M_beta_mem_data_input;
  reg [4-1:0] M_beta_button;
  beta_cpu_3 beta (
    .rst(rst),
    .io_dip(io_dip[16+7-:8]),
    .clk(M_beta_clk),
    .slowclk(M_beta_slowclk),
    .interrupt(M_beta_interrupt),
    .instruction(M_beta_instruction),
    .mem_data_input(M_beta_mem_data_input),
    .button(M_beta_button),
    .ia(M_beta_ia),
    .mem_data_address(M_beta_mem_data_address),
    .mem_data_output(M_beta_mem_data_output),
    .xwr(M_beta_xwr),
    .debug(M_beta_debug)
  );
  
  wire [27-1:0] M_slowclock_value;
  counter_4 slowclock (
    .clk(clk),
    .rst(rst),
    .value(M_slowclock_value)
  );
  
  wire [1-1:0] M_slowclockedge_out;
  reg [1-1:0] M_slowclockedge_in;
  edge_detector_2 slowclockedge (
    .clk(clk),
    .in(M_slowclockedge_in),
    .out(M_slowclockedge_out)
  );
  
  wire [16-1:0] M_memory_unit_data_memory_output;
  wire [32-1:0] M_memory_unit_instruction;
  reg [10-1:0] M_memory_unit_raddr;
  reg [10-1:0] M_memory_unit_waddr;
  reg [16-1:0] M_memory_unit_data_memory_input;
  reg [1-1:0] M_memory_unit_xwr;
  reg [16-1:0] M_memory_unit_ia;
  memoryunit_5 memory_unit (
    .clk(clk),
    .raddr(M_memory_unit_raddr),
    .waddr(M_memory_unit_waddr),
    .data_memory_input(M_memory_unit_data_memory_input),
    .xwr(M_memory_unit_xwr),
    .ia(M_memory_unit_ia),
    .data_memory_output(M_memory_unit_data_memory_output),
    .instruction(M_memory_unit_instruction)
  );
  
  wire [1-1:0] M_reset_cond_out;
  reg [1-1:0] M_reset_cond_in;
  reset_conditioner_6 reset_cond (
    .clk(clk),
    .in(M_reset_cond_in),
    .out(M_reset_cond_out)
  );
  
  wire [6-1:0] M_matrixwriter_col_index;
  wire [4-1:0] M_matrixwriter_row_index;
  wire [1-1:0] M_matrixwriter_red0;
  wire [1-1:0] M_matrixwriter_green0;
  wire [1-1:0] M_matrixwriter_blue0;
  wire [1-1:0] M_matrixwriter_red1;
  wire [1-1:0] M_matrixwriter_green1;
  wire [1-1:0] M_matrixwriter_blue1;
  wire [1-1:0] M_matrixwriter_latch;
  wire [1-1:0] M_matrixwriter_blank;
  wire [1-1:0] M_matrixwriter_sclk_out;
  wire [4-1:0] M_matrixwriter_address;
  wire [16-1:0] M_matrixwriter_debug;
  reg [6-1:0] M_matrixwriter_data;
  matrix_writer_7 matrixwriter (
    .clk(clk),
    .rst(rst),
    .data(M_matrixwriter_data),
    .col_index(M_matrixwriter_col_index),
    .row_index(M_matrixwriter_row_index),
    .red0(M_matrixwriter_red0),
    .green0(M_matrixwriter_green0),
    .blue0(M_matrixwriter_blue0),
    .red1(M_matrixwriter_red1),
    .green1(M_matrixwriter_green1),
    .blue1(M_matrixwriter_blue1),
    .latch(M_matrixwriter_latch),
    .blank(M_matrixwriter_blank),
    .sclk_out(M_matrixwriter_sclk_out),
    .address(M_matrixwriter_address),
    .debug(M_matrixwriter_debug)
  );
  
  always @* begin
    M_buttoncond_in = button;
    M_buttondetector_in = M_buttoncond_out;
    M_beta_clk = clk;
    M_beta_button = M_buttondetector_out;
    M_reset_cond_in = reset_button;
    rst = M_reset_cond_out;
    usb_tx = usb_rx;
    io_led = 24'h000000;
    io_seg = 8'h00;
    io_sel = 4'h0;
    M_slowclockedge_in = M_slowclock_value[26+0-:1];
    M_beta_interrupt = 1'h0;
    M_beta_slowclk = M_slowclockedge_out;
    io_led[0+7-:8] = M_beta_ia[0+7-:8];
    io_led[8+7-:8] = M_beta_mem_data_address[0+7-:8];
    io_led[16+7-:8] = M_beta_debug[0+7-:8];
    led[2+5-:6] = M_memory_unit_instruction[26+5-:6];
    led[0+2-:3] = M_memory_unit_data_memory_output;
    M_beta_instruction = M_memory_unit_instruction;
    M_beta_mem_data_input = M_memory_unit_data_memory_output;
    M_memory_unit_ia = M_beta_ia[0+15-:16];
    M_memory_unit_data_memory_input = M_beta_mem_data_output;
    M_memory_unit_xwr = M_beta_xwr;
    M_memory_unit_waddr = M_beta_mem_data_address[0+15-:16];
    M_memory_unit_raddr = M_beta_mem_data_address[0+15-:16];
    M_memory_unit_raddr = {M_matrixwriter_row_index, M_matrixwriter_col_index};
    M_matrixwriter_data = M_memory_unit_data_memory_output;
    red0 = M_matrixwriter_red0;
    red1 = M_matrixwriter_red1;
    green0 = M_matrixwriter_green0;
    green1 = M_matrixwriter_green1;
    blue0 = M_matrixwriter_blue0;
    blue1 = M_matrixwriter_blue1;
    latch = M_matrixwriter_latch;
    sclk_out = M_matrixwriter_sclk_out;
    blank = M_matrixwriter_blank;
    address = M_matrixwriter_address;
  end
endmodule
