module Counters(
    input                       clk,
    input                       reset_n,

    //////////// LEAP YEAR //////////
    input           [7:0]       feb_day,
 
    //////////// SEG7 //////////
    output           [7:0]      HEX0,
    output           [7:0]      HEX1,
    output           [7:0]      HEX2,
    output           [7:0]      HEX3,
    output           [7:0]      HEX4,
    output           [7:0]      HEX5
);
 
reg [7:0] counter_tens_p;
reg [7:0] counter_ones_p;
reg [7:0] total_count;
 
always @(posedge clk, negedge reset_n)
    begin
        if(reset_n == 0)
            begin
                counter_tens_p <= 8'd88;
                counter_ones_p <= 8'd1;
                total_count <= 8'd1;
            end
        else
            begin
                if(counter_ones_p != 8'd9)
                    begin
                        counter_ones_p <= counter_ones_p + 1;
                        total_count <= total_count + 1;
                    end
                else if(counter_ones_p == 8'd9)
                    begin
                        if(counter_tens_p == 8'd88)
                            begin
                                counter_tens_p <= 8'd1;
                                counter_ones_p <= 8'd0;
                                total_count <= total_count + 1;
                            end
                        else if(counter_tens_p == 8'd9)
                            begin
                                counter_tens_p <= 8'd88;
                                counter_ones_p <= 8'd1;
                                total_count <= 8'd1;
                            end
                        else
                            begin
                                counter_tens_p <= counter_tens_p + 1;
                                counter_ones_p <= 8'd0;
                                total_count <= total_count + 1;
                            end
                    end
            end
    end
 
    SevenSeg W0(.HEX(HEX5), .NUM(counter_tens_p)); 
    SevenSeg W1(.HEX(HEX4), .NUM(counter_ones_p));

    month_day MD0(.total_count(total_count), .feb_day(feb_day), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3));

endmodule