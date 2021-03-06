/* Copyright (c) 2011, Guy Hutchison
   All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

`timescale 1ns/1ps

module dual_env;

  reg activate_0r;

  /*AUTOWIRE*/
  // Beginning of automatic wires (for undeclared instantiated-module outputs)
  wire			activate_0a;		// From basicenc of Balsa_basicenc.v
  wire [127:0]		data__in_0a0d;		// From data_drv of dual_psv_drv.v
  wire [127:0]		data__in_0a1d;		// From data_drv of dual_psv_drv.v
  wire			data__in_0r;		// From basicenc of Balsa_basicenc.v
  wire			data__out_0a;		// From data_mon of dual_act_mon.v
  wire [127:0]		data__out_0r0d;		// From basicenc of Balsa_basicenc.v
  wire [127:0]		data__out_0r1d;		// From basicenc of Balsa_basicenc.v
  wire [127:0]		key__in_0a0d;		// From key_drv of dual_psv_drv.v
  wire [127:0]		key__in_0a1d;		// From key_drv of dual_psv_drv.v
  wire			key__in_0r;		// From basicenc of Balsa_basicenc.v
  // End of automatics

  initial
    begin
      $dumpfile ("enc.vcd");
      $dumpvars;
      activate_0r = 0;

      #1;
      key_drv.set_resp(0,128'h0f0e0d0c0b0a09080706050403020100);
      data_drv.set_resp(0,128'hffeeddccbbaa99887766554433221100);

      key_drv.set_resp(1,128'h3c4fcf098815f7aba6d2ae2816157e2b);
      data_drv.set_resp(1,128'h340737e0a29831318d305a88a8f64332);

      #50;
      activate_0r = 1;
 
      #10000;
      $finish;
    end // initial begin

  wire initialise = 0;

/* dual_psv_drv AUTO_TEMPLATE
 (
     .ack_d0				(key__in_0a0d[127:0]),
     .ack_d1				(key__in_0a1d[127:0]),
    .req				(key__in_0r),
 );
 */
  dual_psv_drv #(128) key_drv
    (/*AUTOINST*/
     // Outputs
     .ack_d0				(key__in_0a0d[127:0]),	 // Templated
     .ack_d1				(key__in_0a1d[127:0]),	 // Templated
     // Inputs
     .req				(key__in_0r));		 // Templated

/* dual_psv_drv AUTO_TEMPLATE
 (
     .ack_d0				(data__in_0a0d[127:0]),
     .ack_d1				(data__in_0a1d[127:0]),
    .req				(data__in_0r),
 );
 */
  dual_psv_drv #(128) data_drv
    (/*AUTOINST*/
     // Outputs
     .ack_d0				(data__in_0a0d[127:0]),	 // Templated
     .ack_d1				(data__in_0a1d[127:0]),	 // Templated
     // Inputs
     .req				(data__in_0r));		 // Templated

/* dual_act_mon AUTO_TEMPLATE
 (
 .ack (data__out_0a),
 .req_d0 (data__out_0r0d[127:0]),
 .req_d1 (data__out_0r1d[127:0]),
 );
 */
  dual_act_mon #(128) data_mon
    (/*AUTOINST*/
     // Outputs
     .ack				(data__out_0a),		 // Templated
     // Inputs
     .req_d0				(data__out_0r0d[127:0]), // Templated
     .req_d1				(data__out_0r1d[127:0])); // Templated

  Balsa_basicenc basicenc
    (/*AUTOINST*/
     // Outputs
     .activate_0a			(activate_0a),
     .key__in_0r			(key__in_0r),
     .data__in_0r			(data__in_0r),
     .data__out_0r0d			(data__out_0r0d[127:0]),
     .data__out_0r1d			(data__out_0r1d[127:0]),
     // Inputs
     .activate_0r			(activate_0r),
     .key__in_0a0d			(key__in_0a0d[127:0]),
     .key__in_0a1d			(key__in_0a1d[127:0]),
     .data__in_0a0d			(data__in_0a0d[127:0]),
     .data__in_0a1d			(data__in_0a1d[127:0]),
     .data__out_0a			(data__out_0a),
     .initialise			(initialise));

endmodule // basicenv
// Local Variables:
// verilog-library-directories:(".." ".")
// verilog-library-files:("../impl-basicenc-impl3.v")
// End:
