`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:27:23 04/13/2017 
// Design Name: 
// Module Name:    sort_tb 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module sort_tb;

localparam CLK_PERIOD = 20; 

reg Clk_tb; 
reg Reset, Ack, Start;
  
reg [6:0] sorted [0:31];

//wire [223:0] sorted_net;
reg [6:0] b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16,
			 b17, b18, b19, b20, b21, b22, b23, b24, b25, b26, b27, b28, b29, b30, b31;
initial
  begin  : CLK_GENERATOR
    Clk_tb = 0;
    forever
       begin
	      #(CLK_PERIOD/2) Clk_tb = ~Clk_tb;
       end 
  end
  
sort UUT (.clk(Clk_tb), .reset(Reset), .ack(Ack), .start(Start),
			 .a0(7'd30), .a1(7'd22), .a2(7'd23), .a3(7'd21), .a4(7'd13), .a5(7'd14), .a6(7'd16), .a7(7'd12), .a8(7'd20),
			 .a9(7'd19), .a10(7'd28), .a11(7'd17), .a12(7'd27), .a13(7'd24), .a14(7'd18), .a15(7'd25), .a16(7'd26),
			 .a17(7'd16), .a18(7'd9), .a19(7'd11), .a20(7'd6), .a21(7'd12), .a22(7'd31), .a23(7'd7), .a24(7'd8),
			 .a25(7'd10), .a26(7'd5), .a27(7'd4), .a28(7'd3), .a29(7'd2), .a30(7'd1), .a31(7'd0),
			 .b0(b0), .b1(b1), .b2(b2), .b3(b3), .b4(b4), .b5(b5), .b6(b6), .b7(b7), .b8(b8), .b9(b9),
			 .b10(b10), .b11(b11), .b12(b12), .b13(b13), .b14(b14), .b15(b15), .b16(b16), .b17(b17),
			 .b18(b18), .b19(b19), .b20(b20), .b21(b21), .b22(b22), .b23(b23), .b24(b24), .b25(b25),
			 .b26(b26), .b27(b27), .b28(b28), .b29(b29), .b30(b30), .b31(b31));

initial begin
		Reset <= 1;
      Start <= 0;
      Ack   <= 0;
		@(posedge Clk_tb); #(CLK_PERIOD/5); // After waiting for a clock (and a little)
      Reset <= ~Reset; // going out of Reset  
		#30;
		Start <= 1;
		#20;
		Start <= 0;
		
	
end

endmodule
