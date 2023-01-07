`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.01.2023 09:44:36
// Design Name: 
// Module Name: fsub_single_tb
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


module fsub_single_tb();
reg [31:0]a1,b1;
wire [31:0]c;

fsub_single DUT(a1,b1,c);
initial begin
a1=32'b01000000011000000000000000000000;
b1=32'b01000000010000000000000000000000;
#250 $finish;
end
endmodule
