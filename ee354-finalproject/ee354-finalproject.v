`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// VGA verilog template
// Author:  Da Cheng
//////////////////////////////////////////////////////////////////////////////////
module ee354_finalproject(ClkPort, vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b, Sw0, Sw1, btnU, btnD,
	St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar,
	An0, An1, An2, An3, Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp,
	LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7);
	input ClkPort, Sw0, btnU, btnD, Sw0, Sw1;
	output St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar;
	output vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b;
	output An0, An1, An2, An3, Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp;
	output LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7;
	reg vga_r, vga_g, vga_b;
	
	//////////////////////////////////////////////////////////////////////////////////////////
	
	/*  LOCAL SIGNALS */
	wire	reset, start, ClkPort, board_clk, clk, button_clk;
	
	BUF BUF1 (board_clk, ClkPort); 	
	BUF BUF2 (reset, Sw0);
	BUF BUF3 (start, Sw1);
	
	reg [27:0]	DIV_CLK;
	always @ (posedge board_clk, posedge reset)  
	begin : CLOCK_DIVIDER
      if (reset)
			DIV_CLK <= 0;
      else
			DIV_CLK <= DIV_CLK + 1'b1;
	end	

	assign	button_clk = DIV_CLK[18];
	assign	clk = DIV_CLK[1];
	assign 	{St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar} = {5'b11111};
	
	wire inDisplayArea;
	wire [9:0] CounterX;
	wire [9:0] CounterY;

	hvsync_generator syncgen(.clk(clk), .reset(reset),.vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync), .inDisplayArea(inDisplayArea), .CounterX(CounterX), .CounterY(CounterY));
	
	/////////////////////////////////////////////////////////////////
	///////////////		VGA control starts here		/////////////////
	/////////////////////////////////////////////////////////////////
	reg [9:0]ymax = 380;
	reg [6:0]xmin = 34;
	reg [10:0]xmax = 608;
			
	wire [10:0] xfrom [0:31];
		assign xfrom[0] = 34; assign xfrom[1] = 52; assign xfrom[2] =	70; assign xfrom[3] = 88; 
		assign xfrom[4] = 106; assign xfrom[5] = 124; assign xfrom[6] =	142; assign xfrom[7] = 160;
		assign xfrom[8] = 178; assign xfrom[9] = 196; assign xfrom[10] = 214; assign xfrom[11] = 232;
		assign xfrom[12] = 250; assign xfrom[13] = 268; assign xfrom[14] = 286; assign xfrom[15] = 304;
		assign xfrom[16] = 322; assign xfrom[17] = 340; assign xfrom[18] = 358; assign xfrom[19] = 376;
		assign xfrom[20] = 394; assign xfrom[21] = 412; assign xfrom[22] = 430; assign xfrom[23] = 448;
		assign xfrom[24] = 466; assign xfrom[25] = 484; assign xfrom[26] = 502; assign xfrom[27] = 520;
		assign xfrom[28] = 538; assign xfrom[29] = 556; assign xfrom[30] = 574; assign xfrom[31] = 592;
		/*assign xfrom = {34, 52, 70, 88, 106, 124, 142, 160,
								178, 196, 214, 232, 250, 268, 286, 304,
								322, 340, 358, 376, 394, 412, 430, 448,
								466, 484, 502, 520, 538, 556, 574, 592};*/	
	wire [10:0] xto [0:31];
		assign xto[0] = 48; assign xto[1] = 66; assign xto[2] = 84; assign xto[3] = 102; assign xto[4] = 120;
		assign xto[5] = 138; assign xto[6] = 156; assign xto[7] = 174; assign xto[8] = 192; assign xto[9] = 210;
		assign xto[10] = 228; assign xto[11] = 246; assign xto[12] = 264; assign xto[13] = 282; assign xto[14] = 300;
		assign xto[15] = 318; assign xto[16] = 336; assign xto[17] = 354; assign xto[18] = 372; assign xto[19] = 390;
		assign xto[20] = 408; assign xto[21] = 426; assign xto[22] = 444; assign xto[23] = 462; assign xto[24] = 480;
		assign xto[25] = 498; assign xto[26] = 516; assign xto[27] = 534; assign xto[28] = 552; assign xto[29] = 570;
		assign xto[30] = 588; assign xto[31] = 606;
		/*assign xto = {48, 66, 84, 102, 120, 138, 156, 174,
							 192, 210, 228, 246, 264, 282, 300, 318,
							 336, 354, 372, 390, 408, 426, 444, 462,
							 480, 498, 516, 534, 552, 570, 588, 606};*/	
	wire [31:0] col;
		assign col[0] = CounterY>=(ymax-n[0]) & CounterY<=(ymax) & CounterX>=(xfrom[0]) & CounterX<=(xto[0]);
		assign col[1] = CounterY>=(ymax-n[1]) & CounterY<=(ymax) & CounterX>=(xfrom[1]) & CounterX<=(xto[1]);
		assign col[2] = CounterY>=(ymax-n[2]) & CounterY<=(ymax) & CounterX>=(xfrom[2]) & CounterX<=(xto[2]);
		assign col[3] = CounterY>=(ymax-n[3]) & CounterY<=(ymax) & CounterX>=(xfrom[3]) & CounterX<=(xto[3]);
		assign col[4] = CounterY>=(ymax-n[4]) & CounterY<=(ymax) & CounterX>=(xfrom[4]) & CounterX<=(xto[4]);
		assign col[5] = CounterY>=(ymax-n[5]) & CounterY<=(ymax) & CounterX>=(xfrom[5]) & CounterX<=(xto[5]);
		assign col[6] = CounterY>=(ymax-n[6]) & CounterY<=(ymax) & CounterX>=(xfrom[6]) & CounterX<=(xto[6]);
		assign col[7] = CounterY>=(ymax-n[7]) & CounterY<=(ymax) & CounterX>=(xfrom[7]) & CounterX<=(xto[7]);
		assign col[8] = CounterY>=(ymax-n[8]) & CounterY<=(ymax) & CounterX>=(xfrom[8]) & CounterX<=(xto[8]);
		assign col[9] = CounterY>=(ymax-n[9]) & CounterY<=(ymax) & CounterX>=(xfrom[9]) & CounterX<=(xto[9]);
		assign col[10] = CounterY>=(ymax-n[10]) & CounterY<=(ymax) & CounterX>=(xfrom[10]) & CounterX<=(xto[10]);
		assign col[11] = CounterY>=(ymax-n[11]) & CounterY<=(ymax) & CounterX>=(xfrom[11]) & CounterX<=(xto[11]);
		assign col[12] = CounterY>=(ymax-n[12]) & CounterY<=(ymax) & CounterX>=(xfrom[12]) & CounterX<=(xto[12]);
		assign col[13] = CounterY>=(ymax-n[13]) & CounterY<=(ymax) & CounterX>=(xfrom[13]) & CounterX<=(xto[13]);
		assign col[14] = CounterY>=(ymax-n[14]) & CounterY<=(ymax) & CounterX>=(xfrom[14]) & CounterX<=(xto[14]);
		assign col[15] = CounterY>=(ymax-n[15]) & CounterY<=(ymax) & CounterX>=(xfrom[15]) & CounterX<=(xto[15]);
		assign col[16] = CounterY>=(ymax-n[16]) & CounterY<=(ymax) & CounterX>=(xfrom[16]) & CounterX<=(xto[16]);
		assign col[17] = CounterY>=(ymax-n[17]) & CounterY<=(ymax) & CounterX>=(xfrom[17]) & CounterX<=(xto[17]);
		assign col[18] = CounterY>=(ymax-n[18]) & CounterY<=(ymax) & CounterX>=(xfrom[18]) & CounterX<=(xto[18]);
		assign col[19] = CounterY>=(ymax-n[19]) & CounterY<=(ymax) & CounterX>=(xfrom[19]) & CounterX<=(xto[19]);
		assign col[20] = CounterY>=(ymax-n[20]) & CounterY<=(ymax) & CounterX>=(xfrom[20]) & CounterX<=(xto[20]);
		assign col[21] = CounterY>=(ymax-n[21]) & CounterY<=(ymax) & CounterX>=(xfrom[21]) & CounterX<=(xto[21]);
		assign col[22] = CounterY>=(ymax-n[22]) & CounterY<=(ymax) & CounterX>=(xfrom[22]) & CounterX<=(xto[22]);
		assign col[23] = CounterY>=(ymax-n[23]) & CounterY<=(ymax) & CounterX>=(xfrom[23]) & CounterX<=(xto[23]);
		assign col[24] = CounterY>=(ymax-n[24]) & CounterY<=(ymax) & CounterX>=(xfrom[24]) & CounterX<=(xto[24]);
		assign col[25] = CounterY>=(ymax-n[25]) & CounterY<=(ymax) & CounterX>=(xfrom[25]) & CounterX<=(xto[25]);
		assign col[26] = CounterY>=(ymax-n[26]) & CounterY<=(ymax) & CounterX>=(xfrom[26]) & CounterX<=(xto[26]);
		assign col[27] = CounterY>=(ymax-n[27]) & CounterY<=(ymax) & CounterX>=(xfrom[27]) & CounterX<=(xto[27]);
		assign col[28] = CounterY>=(ymax-n[28]) & CounterY<=(ymax) & CounterX>=(xfrom[28]) & CounterX<=(xto[28]);
		assign col[29] = CounterY>=(ymax-n[29]) & CounterY<=(ymax) & CounterX>=(xfrom[29]) & CounterX<=(xto[29]);
		assign col[30] = CounterY>=(ymax-n[30]) & CounterY<=(ymax) & CounterX>=(xfrom[30]) & CounterX<=(xto[30]);
		assign col[31] = CounterY>=(ymax-n[31]) & CounterY<=(ymax) & CounterX>=(xfrom[31]) & CounterX<=(xto[31]);
		
	wire R = col[0] | col[1] | col[2] | col[3] | col[4] | col[5] | col[6] | col[7] | col[8] | col[9] | col[10] | col[11] |
				col[12] | col[13] | col[14] | col[15] | col[16] | col[17] | col[18] | col[19] | col[20] | col[21] | col[22] |
				col[23] | col[24] | col[25] | col[26] | col[27] | col[28] | col[29] | col[30] | col[31];
	wire G = 0;
	wire B = 0;
	
	/*wire G = CounterY>=0 && CounterY<=480 && CounterX>=0 && CounterX<=620;
	wire B = CounterY>=125 && CounterY<=(125+255) && CounterX>=(xmin - 2) && CounterX<=(xmax);*/


	wire [7:0] n [0:31];
		assign n[0] = 255;
		assign n[1] = 247;
		assign n[2] = 239;
		assign n[3] = 231;
		assign n[4] = 223;
		assign n[5] = 215;
		assign n[6] = 207;
		assign n[7] = 199;
		assign n[8] = 191;
		assign n[9] = 183;
		assign n[10] = 175;
		assign n[11] = 167;
		assign n[12] = 159;
		assign n[13] = 151;
		assign n[14] = 143;
		assign n[15] = 135;
		assign n[16] = 127;
		assign n[17] = 119;
		assign n[18] = 111;
		assign n[19] = 103;
		assign n[20] = 95;
		assign n[21] = 87;
		assign n[22] = 79;
		assign n[23] = 71;
		assign n[24] = 63;
		assign n[25] = 55;
		assign n[26] = 47;
		assign n[27] = 39;
		assign n[28] = 31;
		assign n[29] = 23;
		assign n[30] = 15;
		assign n[31] = 7;

	always @(posedge clk)
	begin
		vga_r <= R & inDisplayArea;
		vga_g <= G & inDisplayArea;
		vga_b <= B & inDisplayArea;
	end

	/////////////////////////////////////////////////////////////////
	//////////////  	  VGA control ends here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  LD control starts here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
	`define QI 			2'b00
	`define QGAME_1 	2'b01
	`define QGAME_2 	2'b10
	`define QDONE 		2'b11
	
	reg [3:0] p2_score;
	reg [3:0] p1_score;
	reg [1:0] state;
	wire LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7;
	
	assign LD0 = (p1_score == 4'b1010);
	assign LD1 = (p2_score == 4'b1010);
	
	assign LD2 = start;
	assign LD4 = reset;
	
	assign LD3 = (state == `QI);
	assign LD5 = (state == `QGAME_1);	
	assign LD6 = (state == `QGAME_2);
	assign LD7 = (state == `QDONE);
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  LD control ends here 	 	////////////////////
	/////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  SSD control starts here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
	reg [3:0] position;
	reg 	[3:0]	SSD;
	wire 	[3:0]	SSD0, SSD1, SSD2, SSD3;
	wire 	[1:0] ssdscan_clk;
	
	assign SSD3 = 4'b1111;
	assign SSD2 = 4'b1111;
	assign SSD1 = 4'b1111;
	assign SSD0 = position[3:0];
	
	// need a scan clk for the seven segment display 
	// 191Hz (50MHz / 2^18) works well
	assign ssdscan_clk = DIV_CLK[19:18];	
	assign An0	= !(~(ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when ssdscan_clk = 00
	assign An1	= !(~(ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when ssdscan_clk = 01
	assign An2	= !( (ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when ssdscan_clk = 10
	assign An3	= !( (ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when ssdscan_clk = 11
	
	always @ (ssdscan_clk, SSD0, SSD1, SSD2, SSD3)
	begin : SSD_SCAN_OUT
		case (ssdscan_clk) 
			2'b00:
					SSD = SSD0;
			2'b01:
					SSD = SSD1;
			2'b10:
					SSD = SSD2;
			2'b11:
					SSD = SSD3;
		endcase 
	end	

	// and finally convert SSD_num to ssd
	reg [6:0]  SSD_CATHODES;
	assign {Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp} = {SSD_CATHODES, 1'b1};
	// Following is Hex-to-SSD conversion
	always @ (SSD) 
	begin : HEX_TO_SSD
		case (SSD)		
			4'b1111: SSD_CATHODES = 7'b1111111 ; //Nothing 
			4'b0000: SSD_CATHODES = 7'b0000001 ; //0
			4'b0001: SSD_CATHODES = 7'b1001111 ; //1
			4'b0010: SSD_CATHODES = 7'b0010010 ; //2
			4'b0011: SSD_CATHODES = 7'b0000110 ; //3
			4'b0100: SSD_CATHODES = 7'b1001100 ; //4
			4'b0101: SSD_CATHODES = 7'b0100100 ; //5
			4'b0110: SSD_CATHODES = 7'b0100000 ; //6
			4'b0111: SSD_CATHODES = 7'b0001111 ; //7
			4'b1000: SSD_CATHODES = 7'b0000000 ; //8
			4'b1001: SSD_CATHODES = 7'b0000100 ; //9
			4'b1010: SSD_CATHODES = 7'b0001000 ; //10 or A
			default: SSD_CATHODES = 7'bXXXXXXX ; // default is not needed as we covered all cases
		endcase
	end
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  SSD control ends here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
endmodule
