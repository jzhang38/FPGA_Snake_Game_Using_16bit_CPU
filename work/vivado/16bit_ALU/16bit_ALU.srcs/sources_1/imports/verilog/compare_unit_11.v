/*
   This file was generated automatically by Alchitry Labs version 1.2.1.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module compare_unit_11 (
    input [5:0] alufn,
    input z,
    input v,
    input n,
    output reg [15:0] out
  );
  
  
  
  reg [15:0] s;
  
  always @* begin
    s = 16'h0000;
    
    case (alufn[1+1-:2])
      2'h1: begin
        s[0+0-:1] = z;
      end
      2'h2: begin
        s[0+0-:1] = n ^ v;
      end
      2'h3: begin
        s[0+0-:1] = z | (n ^ v);
      end
      default: begin
        s[0+0-:1] = 1'h0;
      end
    endcase
    out = s;
  end
endmodule
