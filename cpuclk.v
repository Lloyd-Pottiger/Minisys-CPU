`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/26 10:10:56
// Design Name: 
// Module Name: cpuclk
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


module cpuclk(clk,clkout1);
    input clk;
    output reg clkout1;
    
    cpuclk cc(
    .clk_in1(clk),
    .clk_out1(clkout1)
    );
endmodule
