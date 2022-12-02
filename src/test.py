import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

moving_average_vals = []
for i in range(10):
    moving_average_vals.append((i*5) >> 3)

@cocotb.test()
async def test_7seg(dut):
    dut._log.info("start")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    dut._log.info("reset")
    dut.rst.value = 1
    await ClockCycles(dut.clk, 10)
    dut.rst.value = 0
    dut.i_data_clk.value = 0
    await ClockCycles(dut.clk, 10)

    dut._log.info("check all segments")
    dut.i_value.value = 5
    for i in range(10):
        dut._log.info("ra value is: {}".format(dut.ra_out.value))
        assert int(dut.ra_out.value) == moving_average_vals[i]
        dut.i_data_clk.value = 0
        await ClockCycles(dut.clk, 5)
        dut.i_data_clk.value = 1
        await ClockCycles(dut.clk, 5)
