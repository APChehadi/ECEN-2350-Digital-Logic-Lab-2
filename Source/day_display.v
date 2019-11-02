module day_display(
    //////////// Counters //////////
    input            [7:0]      day_full,
 
    //////////// SEG7 //////////
    output           [7:0]      HEX0,
    output           [7:0]      HEX1
);
 
reg [7:0] counter_tens_p;
reg [7:0] counter_ones_p;

always @(day_full)
    begin
        if(day_full <= 8'd9)
            begin
                counter_tens_p <= 8'd88;
                counter_ones_p <= day_full;
            end
        else if(day_full <= 8'd19)
            begin
                counter_tens_p <= 8'd1;
                counter_ones_p <= day_full - 10;
            end
        else if(day_full <= 8'd29)
            begin
                counter_tens_p <= 8'd2;
                counter_ones_p <= day_full - 20;
            end
        else if(day_full <= 8'd39)
            begin
                counter_tens_p <= 8'd3;
                counter_ones_p <= day_full - 30;
            end
        else
            begin
                counter_tens_p <= 8'd88;
                counter_tens_p <= 8'd88;
            end
    end
 
SevenSeg SS1(.HEX(HEX1), .NUM(counter_tens_p)); 
SevenSeg SS0(.HEX(HEX0), .NUM(counter_ones_p));

endmodule