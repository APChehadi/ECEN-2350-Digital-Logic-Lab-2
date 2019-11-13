module clock_divider(
 
    //////////// CLOCK //////////
    input                       clk,
    input                       reset_n,
    output                      slower_clk      //calculate correct size!                
);
 
parameter clk_div = 0;
 
reg [23:0] div_cntr;
reg slw_clk;
 
always @(posedge clk, negedge reset_n)
    begin
        if(reset_n == 0)
            begin
                div_cntr <= 0;
            end
        else if(div_cntr == clk_div - 1)
            begin
                div_cntr <= 0;
                slw_clk <= ~slw_clk;
            end
        else
            begin
                div_cntr <= div_cntr + 1;
            end
    end

assign slower_clk = slw_clk;

endmodule