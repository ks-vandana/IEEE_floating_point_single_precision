`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.01.2023 09:20:56
// Design Name: 
// Module Name: fadd_single_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fadd_single_tb();
reg [31:0]a1,b1;
wire [31:0]c;

fadd_single DUT(a1,b1,c);
initial begin
a1=32'b01000000000100000000000000000111;
b1=32'b01000001111100000000000000000011;
#250 $finish;
end
endmodule
