`default_nettype none
`timescale 1ns/1ps

/*
this testbench just instantiates the module and makes some convenient wires
that can be driven / tested by the cocotb test.py
*/

module tb (
    // testbench is controlled by test.py
    input clk,
    input rst,
    input i_data_clk,
    input [4:0] i_value,
    output [7:0] ra_out
   );

    // this part dumps the trace to a vcd file that can be viewed with GTKWave
    initial begin
        $dumpfile ("tb.vcd");
        $dumpvars (0, tb);
        #1;
    end

    // wire up the inputs and outputs
    wire [7:0] inputs = {i_value[4:0], i_data_clk, rst, clk};
    wire [7:0] outputs;
    assign ra_out[7:0] = {3'b000, outputs[4:0]}; // NOTE: ra_out in place of segments, replace in test.py

    // instantiate the DUT
    klei22_ra  #(.RA_SIZE(8), .BITS_PER_ELEM(5)) klei22_ra_1 (
        .io_in  (inputs),
        .io_out (outputs)
        );

endmodule
