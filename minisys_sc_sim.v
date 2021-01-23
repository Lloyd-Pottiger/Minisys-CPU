`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/26 11:00:37
// Design Name: 
// Module Name: CPU_sim
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


module CPU_sim( );
    reg clk = 0;
    reg rst = 1;
    reg  [23:0]switch2N4 = 24'b0010_0000_0000_0000_1010_1100;
    wire [23:0]led2N4;
    
    minisys_sc u(
        .clk(clk),
        .rst(rst),
        .led(led2N4),
        .switch(switch2N4)
    );
    
    initial begin
        $display("display rst:%b @ %t", rst,$time);
        #7000 rst = 0;
        $display("display switch:%h led:%h @ %0t", switch2N4, led2N4, $time);
        #2000 switch2N4 = 24'b0010_0000_0000_0000_0101_1100;
        $display("display switch:%h led:%h @ %0t", switch2N4, led2N4, $time);
        #2000 switch2N4 = 24'b0100_0000_0000_0000_0101_1100;
        $display("display switch:%h led:%h @ %0t", switch2N4, led2N4, $time);
        #2000 switch2N4 = 24'b0110_0000_0000_0000_0101_1100;
        $display("display switch:%h led:%h @ %0t", switch2N4, led2N4, $time);
        #2000 switch2N4 = 24'b1010_0000_0000_1101_0000_0000;
        $display("display switch:%h led:%h @ %0t", switch2N4, led2N4, $time);
        #2000 switch2N4 = 24'b1100_0000_0000_1101_0000_0000;
        $display("display switch:%h led:%h @ %0t", switch2N4, led2N4, $time);
        #2000 switch2N4 = 24'b1110_0000_0000_1101_0000_0000;
        $display("display switch:%h led:%h @ %0t", switch2N4, led2N4, $time);
        #2000 switch2N4 = 24'b0000_0000_0000_1101_0000_0000;
        $display("display switch:%h led:%h @ %0t", switch2N4, led2N4, $time);
    end
    always #5 clk = ~clk;
endmodule
