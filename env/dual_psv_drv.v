/* Copyright (c) 2011, Guy Hutchison
   All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

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
