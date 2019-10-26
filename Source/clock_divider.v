module clock_divider(
 
    //////////// CLOCK //////////
    input                       clk,
    output            [23:0]    slower_clk      //calculate correct size!                
);
 
parameter clk_div = 0; //calculate correct size!
 
reg [23:0] div_cntr; //calculate correct size!
 
always @(posedge clk, negedge reset_n)
    begin
        if(reset_n == 0)
            begin
                div_cntr <= 0;
            end
        else if(div_cntr == clk_div - 1)
            begin
                div_cntr <= 0;
                slower_clk <= ~slower_clk;
            end
        else
            begin
                div_cntr <= div_cntr + 1;
            end
    end