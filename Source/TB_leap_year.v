`timescale 1 ns / 100 ps

module TB_leap_year(
);

    reg CLOCK;
    reg RESET;
    wire [7:0] HEX0;
    wire [7:0] HEX1;
    wire [7:0] HEX2;
    wire [7:0] HEX3;
    wire [7:0] HEX4;   
    wire [7:0] HEX5;
    wire [1:0] KEY;
    wire [9:0] LEDR;
    reg [9:0] SW;
    reg [7:0] feb_day;



    Lab2 L0(.ADC_CLK_10(CLOCK), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5), .KEY(KEY), .LEDR(LEDR), .SW(SW));

    initial
        begin
            CLOCK = 1'b0;
            SW[9] = 9'b000000000;
        end

    initial
        begin
            $dumpfile("output.vcd");
            $dumpvars;
            $display("Starting simulation");
        end   


    always
        #5 CLOCK = ~CLOCK;

    always @(posedge CLOCK)
        SW[9] = ~SW[9];

    initial
        begin
        $monitor("%d,\t%b", $time, SW[9]);        
        end

        initial
            begin
            $display("Simulation ended.");
            #50 $finish;
            end

endmodule