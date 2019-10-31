module month_day(
    input                       clk,
    input                       reset_n,
 
    //////////// Counters //////////
    input            [7:0]      total_count,
 
    //////////// SEG7 //////////
    output           [7:0]      HEX0,
    output           [7:0]      HEX1,
    output           [7:0]      HEX2,
    output           [7:0]      HEX3
);
 
wire month_reset;
assign month_reset = reset_n && (total_count != 31) && (total_count != 59) && (total_count != 90); 

reg [7:0] disp_month;
reg [7:0] counter_tens_p;
reg [7:0] counter_ones_p;
 
always @(posedge clk, negedge month_reset)
    begin
        if(month_reset == 0)
            begin
                counter_tens_p <= 8'd88;
                counter_ones_p <= 8'd1;
            end
        else
            begin
                if(counter_ones_p != 8'd9)
                    begin
                        counter_ones_p <= counter_ones_p + 1;
                    end
                else if(counter_ones_p == 8'd9)
                    begin
                        if(counter_tens_p == 8'd88)
                            begin
                                counter_tens_p <= 8'd1;
                                counter_ones_p <= 8'd0;
                            end
                        else if(counter_tens_p == 8'd9)
                            begin
                                counter_tens_p <= 8'd88;
                                counter_ones_p <= 8'd1;
                            end
                        else
                            begin
                                counter_tens_p <= counter_tens_p + 1;
                                counter_ones_p <= 8'd0;
                            end
                    end
            end
    end


always @(total_count)
    begin
        if(total_count <= 8'd31)
            begin
                disp_month <= 8'd1;
            end
        else if(total_count <= 8'd59)
            begin
                disp_month <= 8'd2;
            end
        else if(total_count <= 8'd90)
            begin
                disp_month <= 8'd3;
            end
        else
            begin
                disp_month <= 8'd4;
            end
    end
 
    SevenSeg SS3(.HEX(HEX3), .NUM(8'd88));
    SevenSeg SS2(.HEX(HEX2), .NUM(disp_month));
    SevenSeg SS1(.HEX(HEX1), .NUM(counter_tens_p)); 
    SevenSeg SS0(.HEX(HEX0), .NUM(counter_ones_p));


endmodule