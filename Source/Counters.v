module Counters(
    input                       clk,
    input                       reset_n,
 
    output           [7:0]      HEX4,
    output           [7:0]      HEX5,
 
    //////////// KEY //////////
    input            [1:0]      KEY,
 
    //////////// LED //////////
    output           [9:0]      LEDR,
 
    //////////// SW //////////
    input            [9:0]      SW
);
 
reg [7:0] counter_tens_p;
reg [7:0] counter_ones_p;
 
always @(posedge clk, negedge reset_n)
    begin
        if(reset_n == 0)
            begin
                counter_tens_p <= 8'd88;
                counter_ones_p <= 8'd1;
            end
        else
            begin
                if(counter_ones_p != 8'd9)
                    counter_ones_p <= counter_ones_p + 1;
                else if(counter_ones_p == 8'd9)
                    begin
                        if(counter_tens_p == 8'd88)
                            counter_tens_p <= 8'd1;
                        else if(counter_tens_p == 8'd9)
                            counter_tens_p <= 8'd88;
                        else
                            counter_tens_p <= counter_tens_p + 1;
                        counter_ones_p <= 8'd0;
                    end
            end
    end
 
    SevenSeg W0(.HEX(HEX5), .NUM(counter_tens_p)); 
    SevenSeg W1(.HEX(HEX4), .NUM(counter_ones_p));


endmodule