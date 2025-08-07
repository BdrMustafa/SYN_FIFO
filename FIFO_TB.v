`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/20/2025 05:29:01 AM
// Design Name: 
// Module Name: FIFO_TB
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


module FIFO_TB( );
  parameter FIFO_WIDTH = 32,
            FIFO_DEPTH = 45 ,
            ADDR_SIZE  = 6 ;
reg [FIFO_WIDTH-1 : 0] din ;
reg clk , rst , wen_a ,ren_b ;
wire [FIFO_WIDTH-1 : 0] dout ;
wire FULL,EMPTY ;

// FIFO f1 (din,clk_a , clk_b , rst , wen_a ,ren_b,dout,FULL,EMPTY);
   FIFO_SYN f2 (din,clk , rst, wen_a ,ren_b,dout,FULL,EMPTY);
integer i ;

initial begin 
  clk=0;
  forever begin
   #1 clk=~clk;
  end
  end
  
  initial begin
      $readmemh ("mem.dat",f2.mem);
                rst = 1; 
             #10;
                rst = 0 ; 
                ren_b =0 ;
   // write operation 
                for ( i =0 ; i<= 100 ; i=i+1)begin
                      din = i ;
                      wen_a =1 ;
                 @(negedge clk);
                end
    // read operation
                wen_a=0 ;
                repeat(3) @(negedge clk); 
                for ( i = 0 ; i <=50 ; i=i+1) begin
                     ren_b = 1;
                     @(negedge clk);
      // Write Operation     
                end
                ren_b =0 ;
                 for ( i =0 ; i<= 100 ; i=i+1)begin
                      din = i ;
                      wen_a =1 ;
                 @(negedge clk);
                end
                
              // READ and WRITE 
              
               for ( i =0 ; i<= 25 ; i=i+1)begin
                      din = i ;
                     wen_a =1;
                       @(negedge clk);
                      
                end
                @(negedge clk);
                
                 for ( i =0 ; i<= 25 ; i=i+1)begin
                     ren_b =1;
                     wen_a =0;
                       @(negedge clk);
                      
                end
                
              
                
                $stop;
                
                
                
                
                                 
   
  
  end
endmodule
