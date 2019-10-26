//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================
 
module Lab2(
 
    //////////// CLOCK //////////
    input                       ADC_CLK_10,
    input                       MAX10_CLK1_50,
    input                       MAX10_CLK2_50,
 
    //////////// SEG7 //////////
    output           [7:0]      HEX0,
    output           [7:0]      HEX1,
    output           [7:0]      HEX2,
    output           [7:0]      HEX3,
    output           [7:0]      HEX4,
    output           [7:0]      HEX5,
 
    //////////// KEY //////////
    input            [1:0]      KEY,
 
    //////////// LED //////////
    output           [9:0]      LEDR,
 
    //////////// SW //////////
    input            [9:0]      SW
);
 
wire s_clk; //calculate correct size
reg latch_out = 1'b0;
wire latch; 

always @(negedge KEY[0])
	begin
    	latch_out <= ~latch_out;
	end
 
assign latch = latch_out;
// assign LEDR[0] = ~latch_out;
    
clock_divider #(1_000_000) U0(.clk(ADC_CLK_10), .reset_n(latch), .slower_clk(s_clk));
 
// assign LEDR[1] = s_clk;
 
Counters U1(.clk(s_clk), .reset_n(latch), .HEX4(HEX4), .HEX5(HEX5), .KEY(KEY), .LEDR(LEDR), .SW(SW));
 
 
 
endmodule
