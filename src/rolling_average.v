module rolling_average #(
    BITS_PER_ELEM = 5,
    /* NUM_ELEM = 8, // unused */
    MAX_BITS = 8  // 31 * 8 =7.9 ~ 8; where 31 is largest value for 5 bit elem
) (
    input wire clk,
    input wire rst,
    input wire [BITS_PER_ELEM - 1:0] i_new,  // 5:0
    input wire [BITS_PER_ELEM - 1:0] i_old,  // 5:0
    input wire i_start_calc,
    output wire [BITS_PER_ELEM - 1:0] o_ra
);

  // output goes into ma shift register
  reg [MAX_BITS - 1:0] ra_sum;  // rolling sum
  assign o_ra[BITS_PER_ELEM - 1:0] = ra_sum[(MAX_BITS-1):(MAX_BITS-BITS_PER_ELEM)];  // equiv to right shift 3 times

  always @(posedge clk) begin
    if (rst) begin
      ra_sum <= 0;
    end else begin
      // if new value then update rs
      if (i_start_calc) begin
        ra_sum <= (ra_sum + i_new) - i_old;
      end else begin
        ra_sum <= ra_sum;
      end
    end
  end

endmodule
