// generic driver for dual-rail passive input

module dual_psv_drv
  (/*AUTOARG*/
  // Outputs
  ack_d0, ack_d1,
  // Inputs
  req
  );

  parameter width = 8;
  parameter nvec = 8;

  input req;
  output [width-1:0] ack_d0;
  reg [width-1:0] ack_d0;
  output [width-1:0] ack_d1;
  reg [width-1:0] ack_d1;

  integer 	     i, cur;
  reg [width-1:0]    resp [0:nvec-1];

  initial
    begin
      ack_d0 = 0;
      ack_d1 = 0;
      for (i=0; i<nvec; i=i+1)
	resp[i] = {$random};
      cur = 0;
    end

  task set_resp;
    input [7:0] rnum;
    input [width-1:0] data;
    begin
      resp[rnum] = data;
    end
  endtask // set_resp

  always
    begin
      wait (req === 1);
      #1;
      ack_d0 = ~resp[cur];
      ack_d1 = resp[cur];
      wait (req === 0);
      #1;
      ack_d0 = 0;
      ack_d1 = 0;
      cur = cur + 1;
    end
      

endmodule // dual_psv_drv
