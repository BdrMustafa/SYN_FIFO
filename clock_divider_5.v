`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2025 03:21:36 PM
// Design Name: 
// Module Name: clock_divider_5
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


module clock_divider_5(
        input clk ,
        output Q
    );
    
    wire q0,q1,q2,d0,d1,d2;
    
    assign d0 = ~(q0|q1|q2);
    assign d1 = (~(q2) & (q0^q1));
    assign d2 = q1 ;
    
    D_FF d11 (clk,d0,q0);
    D_FF d12 (clk,d1,q1);
    D_FF d13 (clk,d2,q2);
    
    assign Q = q2;
endmodule
