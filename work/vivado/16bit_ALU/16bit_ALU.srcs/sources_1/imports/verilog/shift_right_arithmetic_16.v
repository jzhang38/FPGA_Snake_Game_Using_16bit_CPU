/*
   This file was generated automatically by Alchitry Labs version 1.2.1.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module shift_right_arithmetic_16 (
    input [15:0] a,
    input [15:0] b,
    output reg [15:0] out
  );
  
  
  
  reg [15:0] x;
  
  reg [15:0] y;
  
  reg [15:0] z;
  
  reg [15:0] s;
  
  always @* begin
    x = a;
    y = x;
    z = y;
    s = z;
    if (b[3+0-:1]) begin
      x[0+7-:8] = a[8+7-:8];
      x[8+7-:8] = {4'h8{a[15+0-:1]}};
    end else begin
      x = a;
    end
    if (b[2+0-:1]) begin
      y[0+11-:12] = x[4+11-:12];
      y[12+3-:4] = {3'h4{x[15+0-:1]}};
    end else begin
      y = x;
    end
    if (b[1+0-:1]) begin
      z[0+13-:14] = y[2+13-:14];
      z[14+1-:2] = {2'h2{y[15+0-:1]}};
    end else begin
      z = y;
    end
    if (b[0+0-:1]) begin
      s[0+14-:15] = z[1+14-:15];
      s[15+0-:1] = z[15+0-:1];
    end else begin
      s = z;
    end
    out = s;
  end
endmodule
