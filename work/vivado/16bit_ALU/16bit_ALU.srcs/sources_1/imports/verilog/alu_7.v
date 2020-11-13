/*
   This file was generated automatically by Alchitry Labs version 1.2.1.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module alu_7 (
    input [5:0] alufn,
    input [15:0] a,
    input [15:0] b,
    output reg [15:0] out,
    output reg z,
    output reg v,
    output reg n
  );
  
  
  
  wire [16-1:0] M_booleanUnit_out;
  reg [6-1:0] M_booleanUnit_alufn;
  reg [16-1:0] M_booleanUnit_a;
  reg [16-1:0] M_booleanUnit_b;
  boolean_unit_10 booleanUnit (
    .alufn(M_booleanUnit_alufn),
    .a(M_booleanUnit_a),
    .b(M_booleanUnit_b),
    .out(M_booleanUnit_out)
  );
  
  wire [16-1:0] M_compareUnit_out;
  reg [6-1:0] M_compareUnit_alufn;
  reg [1-1:0] M_compareUnit_z;
  reg [1-1:0] M_compareUnit_v;
  reg [1-1:0] M_compareUnit_n;
  compare_unit_11 compareUnit (
    .alufn(M_compareUnit_alufn),
    .z(M_compareUnit_z),
    .v(M_compareUnit_v),
    .n(M_compareUnit_n),
    .out(M_compareUnit_out)
  );
  
  wire [16-1:0] M_shifterUnit_out;
  reg [6-1:0] M_shifterUnit_alufn;
  reg [16-1:0] M_shifterUnit_a;
  reg [16-1:0] M_shifterUnit_b;
  shifter_12 shifterUnit (
    .alufn(M_shifterUnit_alufn),
    .a(M_shifterUnit_a),
    .b(M_shifterUnit_b),
    .out(M_shifterUnit_out)
  );
  
  wire [16-1:0] M_addUnit_out;
  wire [1-1:0] M_addUnit_z;
  wire [1-1:0] M_addUnit_v;
  wire [1-1:0] M_addUnit_n;
  reg [6-1:0] M_addUnit_alufn;
  reg [16-1:0] M_addUnit_a;
  reg [16-1:0] M_addUnit_b;
  sixteen_bit_adder_13 addUnit (
    .alufn(M_addUnit_alufn),
    .a(M_addUnit_a),
    .b(M_addUnit_b),
    .out(M_addUnit_out),
    .z(M_addUnit_z),
    .v(M_addUnit_v),
    .n(M_addUnit_n)
  );
  
  always @* begin
    M_booleanUnit_alufn = alufn;
    M_compareUnit_alufn = alufn;
    M_shifterUnit_alufn = alufn;
    M_addUnit_alufn = alufn;
    M_booleanUnit_a = a;
    M_booleanUnit_b = b;
    M_shifterUnit_a = a;
    M_shifterUnit_b = b;
    M_addUnit_a = a;
    M_addUnit_b = b;
    M_compareUnit_z = M_addUnit_z;
    M_compareUnit_v = M_addUnit_v;
    M_compareUnit_n = M_addUnit_n;
    
    case (alufn[4+1-:2])
      2'h0: begin
        out = M_addUnit_out;
      end
      2'h1: begin
        out = M_booleanUnit_out;
      end
      2'h2: begin
        out = M_shifterUnit_out;
      end
      2'h3: begin
        out = M_compareUnit_out;
      end
      default: begin
        out = 16'h0000;
      end
    endcase
    z = M_addUnit_z;
    v = M_addUnit_v;
    n = M_addUnit_n;
  end
endmodule