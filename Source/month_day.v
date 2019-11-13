module month_day(
    //////////// Counters //////////
    input            [7:0]      total_count,

    //////////// LEAP YEAR //////////
    input           [7:0]       feb_day,
 
    //////////// SEG7 //////////
    output           [7:0]      HEX0,
    output           [7:0]      HEX1,
    output           [7:0]      HEX2,
    output           [7:0]      HEX3
);
 
reg [7:0] disp_month;
reg [7:0] counter_tens_p;
reg [7:0] counter_ones_p;
reg [7:0] day_full;
 
always @(total_count)
    begin
        if(total_count <= 8'd31)
            begin
                disp_month <= 8'd1;
                day_full <= total_count;
            end
        else if(total_count <= (8'd31 + feb_day))
            begin
                disp_month <= 8'd2;
                day_full <= total_count - 8'd31;
            end
        else if(total_count <= (8'd31 + feb_day + 8'd31))
            begin
                disp_month <= 8'd3;
                day_full <= total_count - (8'd31 + feb_day);
            end
        else
            begin
                disp_month <= 8'd4;
                day_full <= total_count - (8'd31 + feb_day + 8'd31);
            end
    end

SevenSeg SS3(.HEX(HEX3), .NUM(8'd88));
SevenSeg SS2(.HEX(HEX2), .NUM(disp_month));

day_display DD(.day_full(day_full), .HEX0(HEX0), .HEX1(HEX1));


endmodule