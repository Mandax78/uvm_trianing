module top_th;

  timeunit      1ns;
  timeprecision 1ps;


  logic clk = 0;
  logic rstn;

  always #10 clk = ~clk;

  initial
  begin
    rstn = 0;
    #75 rstn = 1;
  end

  handshake_if handshake_master_if();
  handshake_if handshake_slave_if();

  assign handshake_master_if.clk = clk;
  assign handshake_slave_if.clk = clk;

  dut dut(
    .clk (clk),
    .rstn (rstn),
    .data (handshake_master_if.data),
    .vld (handshake_master_if.vld),
    .rdy (handshake_master_if.rdy),
    .data (handshake_slave_if.data),
    .vld (handshake_slave_if.vld),
    .rdy (handshake_slave_if.rdy)
  );

endmodule
