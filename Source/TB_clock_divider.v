`timescale 1 ns / 100 ps

module TB_clock_divider();

    reg clk;
    reg Rn;
    wire SCLK;

    clock_divider #(5) CD0 (
        .clk(clk),
        .reset_n(Rn),
        .slower_clk(SCLK)
    );

    initial
        begin
            clk = 1'b0;
            Rn = 1'b0;
        #10 Rn = 1'b1;
        end

    always
        #5 clk = ~clk;

    initial
        begin
            $dumpfile("output.vcd");
            $dumpvars;
            $display("Starting simulation");
        end   

    initial
        begin
            $monitor("%d,\t%b,\t%b", $time, clk, Rn, SCLK);        
        end

        initial
            begin
                $display("Simulation ended.");
                #1000 $finish;
            end
        
endmodule