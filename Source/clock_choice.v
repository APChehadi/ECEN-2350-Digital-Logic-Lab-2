module clock_choice(
    input                       select,

    input                       latch,
    output                      s_clk,

	input                       s1,
    input            [0:0]      s2
);

    reg SCLK;
    
    assign s_clk = SCLK;

    always @(select)
        begin
            case(select)
                0: SCLK = s1;
                1: SCLK = s2;
            endcase 
        end

    assign s_clk = SCLK;

endmodule