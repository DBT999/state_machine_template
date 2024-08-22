`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2024 10:44:57 AM
// Design Name: 
// Module Name: mux_interface
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


module mux_interface #(
    parameter   SYS_CLK_FREQ = 50_000_000,
    parameter   SPI_CLK_FREQ = 10_000_000   )
    (
    
    input               clk_i,
    input               rst_i,
    
    input               en_i,
    output              done_o,
    
    input logic [3:0]   TX1_addr_i,
    input logic [3:0]   TX2_addr_i,
    input logic [3:0]   RX1_addr_i,
    input logic [3:0]   RX2_addr_i,
    
    output              latch_o,
    output              sclk_o,
    output              TX1_data_o,
    output              TX2_data_o,
    output              RX1_data_o,
    output              RX2_data_o

    );
    
    typedef enum
        {   Idle,
            Done    }   state_e;
    state_e state, next;
    
    always_comb
        case(state)
            Idle:       if(en_i)        next = ;
            Done:                       next = Idle;
            default:                    next = Idle;
        endcase
    
    
    assign done_o = state == Done;
    
    always_ff @(posedge clk_i)
        if(rst_i)   state <= Idle;
        else        state <= next;      
    
endmodule
