module Counters(
    input                       clk,
 
    output           [7:0]      H4,
    output           [7:0]      H5,
 
    //////////// KEY //////////
    input            [1:0]      KEY,
 
    //////////// LED //////////
    output           [9:0]      LEDR,
 
    //////////// SW //////////
    input            [9:0]      SW
);
 
reg [7:0] cntr1;
reg [7:0] cntr1_9;
reg [7:0] cntr1_99;
reg [7:0] cntr2;
reg [7:0] cntr2_9;
 
always @(posedge clk, negedge reset_n)
    begin
        if(reset_n == 0)
            begin
                cntr1 <= 8'd1;
                cntr1_9 <= 8'd1;
                cntr1_99 <= 8'd1;
            end
        else if(cntr1 != 9)
            begin
                cntr1 <= cntr1 + 1;
                cntr1_99 <= cntr1_99 + 1;
            end
        else if(cntr1 == 9)
            begin
                if(cntr1_9 != 9)
                begin
                    cntr1_9 <= cntr1_9 + 1;
                    cntr1 <= cntr1;
                    cntr1_99 <= cntr1_99 + 1;
                end
                else if(cntr1_9 == 9)
                    begin
                        if(cntr1_99 != 99)
                        begin
                            cntr1 <= 8'd0;
                            cntr1_9 <= 8'd0;
                            cntr1_99 <= cntr1_99 + 1;
                        end
                        else if(cntr1_99 == 99)
                        begin
                            cntr1 <= 8'd1;
                            cntr1_9 <= 8'd1;
                            cntr1_99 <= 8'd1;
                        end
                    end
            end
    end
 
    SevenSeg W0(.H(H4), .NUM(cntr1));
 
always @(posedge clk, negedge reset_n)
    begin
        if(reset_n == 0)
            begin
                cntr2 <= 8'd88;
                cntr2_9 <= 8'd1;
            end
        else if(cntr2 != 9)
            begin
                if(cntr2_9 != 9)
                    begin
                        cntr2 <= cntr2;
                        cntr2_9 <= cntr2_9 + 1;
                    end
                else if(cntr2_9 == 9)
                    begin
                        cntr2 <= cntr2 + 1;
                        cntr2_9 <= 8'd1;
                    end
            end
        else if(cntr2 == 9)
            begin
                if(cntr2_9 != 9)
                    begin
                        cntr2 <= cntr2;
                        cntr2_9 <= cntr2_9 + 1;
                    end
                else if(cntr2_9 == 9)
                    begin
                        cntr2 <= 8'd88;
                        cntr2_9 <= 8'd1;
                    end
            end
    end
 
    SevenSeg W1(.H(H5), .NUM(cntr2));