/*
	Simple counter with a key input and a LED output.
	When the key is pressed, the counter is stopped.
	Can be used as a basic/bad PRNG.
*/

`define LEDS_NR 6

module top (
	input clk,
	input key_i,
	output [`LEDS_NR-1:0] led,
);

reg [`LEDS_NR-1:0] ctr_q;
wire [`LEDS_NR-1:0] ctr_d;

always @(posedge clk) begin
	if (!key_i)
		ctr_q <= ctr_d;
end

assign ctr_d = ctr_q + 1'b1;
assign led = {ctr_q[`LEDS_NR-1:2], | ctr_q[1:0] };

endmodule
