/*
   This file was generated automatically by Alchitry Labs version 1.2.1.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

/*
   Parameters:
     DEPTH = 16
*/
module memoryunit_4 (
    input clk,
    input [5:0] raddr,
    input [5:0] waddr,
    input [15:0] data_memory_input,
    input xwr,
    output reg [15:0] data_memory_output,
    input [5:0] ia,
    input instruction_write_enable,
    input [15:0] instruction_towrite,
    output reg [31:0] instruction
  );
  
  localparam DEPTH = 5'h10;
  
  
  localparam SAMPLE_CODE = 160'h7823fffb607f0020643f002090410800c03f0007;
  
  wire [16-1:0] M_data_memory_read_data;
  reg [4-1:0] M_data_memory_waddr;
  reg [16-1:0] M_data_memory_write_data;
  reg [1-1:0] M_data_memory_write_en;
  reg [4-1:0] M_data_memory_raddr;
  simple_dual_ram_9 #(.SIZE(5'h10), .DEPTH(5'h10)) data_memory (
    .wclk(clk),
    .rclk(clk),
    .waddr(M_data_memory_waddr),
    .write_data(M_data_memory_write_data),
    .write_en(M_data_memory_write_en),
    .raddr(M_data_memory_raddr),
    .read_data(M_data_memory_read_data)
  );
  
  always @* begin
    instruction = SAMPLE_CODE[(ia[2+3-:4])*32+31-:32];
    M_data_memory_raddr = raddr[2+3-:4];
    M_data_memory_waddr = waddr[2+3-:4];
    M_data_memory_write_data = data_memory_input;
    M_data_memory_write_en = xwr;
    data_memory_output = M_data_memory_read_data;
  end
endmodule
