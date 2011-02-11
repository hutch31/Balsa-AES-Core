// generic monitor for dual-rail active output

module dual_act_mon
  (/*AUTOARG*/
  // Outputs
  ack,
  // Inputs
  req_d0, req_d1
  );

  parameter width=8;

  input [width-1:0] req_d0;
  input [width-1:0] req_d1;
  output 	    ack;
  reg 		    ack;

  initial
    ack = 0;

  always
    begin
      wait ( (req_d0 | req_d1) === {width{1'b1}} );
      #1;
      $display ("%m: Received %x", req_d1);
      ack = 1;
      wait ( (req_d0 | req_d1) === {width{1'b0}} );
      #1;
      ack = 0;
    end

endmodule // dual_act_mon
