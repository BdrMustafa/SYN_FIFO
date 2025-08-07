`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2025 12:28:42 PM
// Design Name: 
// Module Name: FIFO_SYN
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


module FIFO_SYN
#(parameter FIFO_WIDTH = 32 ,
            FIFO_DEPTH = 96 ,
            ADDR_SIZE  = 7 )
(
     input [FIFO_WIDTH -1 : 0] din ,
     input clk , rst, wen_a ,ren_b ,
     output reg [FIFO_WIDTH -1 : 0 ]dout ,
     output FULL,EMPTY 

    );
    
    wire clk_b;
    
    clock_divider_5 dut (clk,clk_b);
    
    reg [FIFO_WIDTH -1:0 ] mem [FIFO_DEPTH-1:0] ;
    
    reg [ ADDR_SIZE : 0 ] wr_ptr ,rd_ptr ;
    
    always @ ( posedge clk ) begin
            
        if (rst) wr_ptr <= 0 ;
        else if ( wen_a && ~FULL   ) begin
            if(wr_ptr[6:0] == 7'd95)begin
            wr_ptr <= {~wr_ptr[7], 7'd0};
        end
        else begin
              mem [wr_ptr [ADDR_SIZE-1:0]] <= din ;
              wr_ptr <= wr_ptr + 1 ;   
        end
        end
           
            
        
    end
    
    always @ (posedge clk_b)begin
          if (rst) 
          rd_ptr <=  0 ;
          else if (ren_b && ~EMPTY)begin
           if(rd_ptr[6:0] == 7'd95)begin
            rd_ptr <= {~rd_ptr[7], 7'd0};
            end
            else begin
             dout <= mem [rd_ptr[ADDR_SIZE-1:0]];
             rd_ptr <= rd_ptr + 1 ;  
             end end
      
    end   
    
    assign FULL = (((wr_ptr [ADDR_SIZE] != rd_ptr[ADDR_SIZE]) &&
     (wr_ptr[ADDR_SIZE-1:0] == rd_ptr[ADDR_SIZE-1:0])) ) ? 1:0;
     //  assign FULL = ( (wr_ptr[ADDR_SIZE-1:0] != rd_ptr[ADDR_SIZE-1:0])&& (wr_ptr == 96)) ? 1:0;

    assign EMPTY = (wr_ptr == rd_ptr)? 1:0 ;
endmodule
