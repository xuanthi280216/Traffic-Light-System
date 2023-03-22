// Code your testbench here
// or browse Examples
`timescale 1ns/1ps
module testbench;
    reg clk, rst_n;
    wire [2:0] traf_light;
    wire [1:0] ped_light;

    //Call traffic_light_system module
    traffic_light_system dut (
        .clk(clk),
        .rst_n(rst_n),
        .traf_light(traf_light),
        .ped_light(ped_light)
    );
  
    initial begin
        test1 ();
        //$stop;
    end

    //Clock generator
    initial begin
        clk = 0;
        forever #0.0005 clk = ~clk;
    end

    //Waveform Display
    initial begin
        $dumpfile ("dump.vcd");
        $dumpvars (0);
    end

    //Task
    task test1();
        begin
        rst_n = 0;
        #5;
        rst_n = 1;
        #10;
        rst_n = 0;
        #1;
        rst_n = 1;
        #10000;
        end
    endtask

endmodule