`timescale 1 ns / 100 ps

module TB_clock_choice(
);

    reg CLOCK;
    reg RESET;
    wire [7:0] HEX0;
    wire [7:0] HEX1;
    wire [7:0] HEX2;
    wire [7:0] HEX3;
    wire [7:0] HEX4;   
    wire [7:0] HEX5;
    reg [1:0] KEY;
    wire [9:0] LED;
    reg [9:0] SW;
    reg [7:0] feb_day;



    Lab2 L1(.ADC_CLK_10(CLOCK), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5), .KEY(KEY), .LEDR(LED), .SW(SW));

    initial
        begin
            CLOCK = 1'b0;
            KEY[1] = 0;
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
        KEY[1] = ~KEY[1];

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