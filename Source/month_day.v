module month_day(
    //////////// Counters //////////
    input            [7:0]      counter_tens_p,
    input            [7:0]      counter_ones_p,
 
    //////////// SEG7 //////////
    output           [7:0]      HEX0,
    output           [7:0]      HEX1,
    output           [7:0]      HEX2,
    output           [7:0]      HEX3
);
 
reg [7:0] month;
reg [7:0] day_tens_p;
reg [7:0] day_ones_p;
 
always @(counter_tens_p, counter_ones_p)
    begin
        if(counter_tens_p <= 8'd3 || counter_tens_p == 8'd88)
            begin
                if(counter_tens_p >= 8'd0)
                    begin
                        if(counter_ones_p <= 8'd1)
                            month <= 8'd1;
                    end
                day_tens_p <= counter_tens_p;
                day_ones_p <= counter_ones_p;
            end

        else if(counter_tens_p <= 8'd5)
            begin
                if(counter_tens_p >= 8'd3)
                    begin
                        if(counter_ones_p <= 8'd9)
                            month <= 8'd2;
                    end
            end

        else if(counter_tens_p <= 8'd9)
            begin
                if(counter_tens_p >= 8'd5)
                    begin
                        if(counter_ones_p <= 8'd0)
                            month <= 8'd3;
                    end
            end
    end
 
    SevenSeg SS3(.HEX(HEX3), .NUM(8'd88));
    SevenSeg SS2(.HEX(HEX2), .NUM(month));
    SevenSeg SS1(.HEX(HEX1), .NUM(day_tens_p)); 
    SevenSeg SS0(.HEX(HEX0), .NUM(day_ones_p));


endmodule