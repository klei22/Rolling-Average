import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

@cocotb.test()
async def test_7seg(dut):
    dut._log.info("start")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    dut._log.info("reset")
    dut.rst.value = 1
    await ClockCycles(dut.clk, 10)
    dut.rst.value = 0
    await ClockCycles(dut.clk, 10)

    dut._log.info("check all segments")
    assert int(dut.ra_out.value) == 0
    # for i in range(5):
    #     for j in range (5)
    #     dut._log.info("check segment {}".format(i))
    #     await ClockCycles(dut.clk, 100)
        # assert int(dut.segments.value) == segments[i]
