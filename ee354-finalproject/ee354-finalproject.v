`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// EE354 Final Project - Bubble Sort with VGA Representation
// Authors: Alan Coon
//				Carolinne M. Mesquita
//////////////////////////////////////////////////////////////////////////////////
module ee354_finalproject(ClkPort, vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b, btnU, btnD, btnC, btnR,
	St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar,
	An0, An1, An2, An3, Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp,
	LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7);
	input ClkPort, btnU, btnD, btnC, btnR;
	output St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar;
	output vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b;
	output An0, An1, An2, An3, Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp;
	output LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7;
	reg vga_r, vga_g, vga_b;
	
	//////////////////////////////////////////////////////////////////////////////////////////
	
	/*  LOCAL SIGNALS */
	wire	reset, start, step, ClkPort, board_clk, clk, button_clk;
	wire sstep, cstep;
	assign step = sstep || cstep;
	BUF BUF1 (board_clk, ClkPort); 	
	ee201_debouncer c0 (.CLK(button_clk), .RESET(reset), .PB(btnR), .DPB(), .SCEN(start), .MCEN(), .CCEN());
	ee201_debouncer c1 (.CLK(button_clk), .RESET(reset), .PB(btnC), .DPB(), .SCEN(reset), .MCEN(), .CCEN());
	ee201_debouncer c2 (.CLK(button_clk), .RESET(reset), .PB(btnU), .DPB(), .SCEN(sstep),  .MCEN(cstep), .CCEN());
	ee201_debouncer c3 (.CLK(button_clk), .RESET(reset), .PB(btnD), .DPB(), .SCEN(ack),   .MCEN(), .CCEN());
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
	wire [10:0] xto [0:31];
		assign xto[0] = 48; assign xto[1] = 66; assign xto[2] = 84; assign xto[3] = 102; assign xto[4] = 120;
		assign xto[5] = 138; assign xto[6] = 156; assign xto[7] = 174; assign xto[8] = 192; assign xto[9] = 210;
		assign xto[10] = 228; assign xto[11] = 246; assign xto[12] = 264; assign xto[13] = 282; assign xto[14] = 300;
		assign xto[15] = 318; assign xto[16] = 336; assign xto[17] = 354; assign xto[18] = 372; assign xto[19] = 390;
		assign xto[20] = 408; assign xto[21] = 426; assign xto[22] = 444; assign xto[23] = 462; assign xto[24] = 480;
		assign xto[25] = 498; assign xto[26] = 516; assign xto[27] = 534; assign xto[28] = 552; assign xto[29] = 570;
		assign xto[30] = 588; assign xto[31] = 606;
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
	
	wire checking;
		assign checking = CounterY>=(ymax-n[count1]) & CounterY<=(ymax) & CounterX>=(xfrom[count1]) & CounterX<=(xto[count1]);
	
	wire R = (checking && ((state == SORT) || (state == SWAP))) || (columns && (state == INITIAL));
	wire G = (columns && (state == DONE));
	wire B = (((state == SORT) || (state == SWAP)) & columns);
	
	
	//wire R = checking;	
	wire columns = col[0] | col[1] | col[2] | col[3] | col[4] | col[5] | col[6] | col[7] | col[8] | col[9] | col[10] | col[11] |
				col[12] | col[13] | col[14] | col[15] | col[16] | col[17] | col[18] | col[19] | col[20] | col[21] | col[22] |
				col[23] | col[24] | col[25] | col[26] | col[27] | col[28] | col[29] | col[30] | col[31];
	//wire G = columns;
	//wire B = (state == DONE) & columns;


	reg [7:0] n [0:31];
	
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
	wire LD0, LD1, LD2, LD3;
	
	assign LD0 = (state == INITIAL);
	assign LD1 = (state == SORT);
	assign LD2 = (state == SWAP);
	assign LD3 = (state == DONE);
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
	
	assign SSD3 = 4'b1111; //{1'b0, 1'b0, 1'b0, count2[4]};
	assign SSD2 = 4'b1111; //count2[3:0];
	assign SSD1 = 4'b1111; //{1'b0, 1'b0, 1'b0, count1[4]};
	assign SSD0 = 4'b1111; //count1[3:0];
	
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
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  SORTING starts here 	 //////////////////////
	/////////////////////////////////////////////////////////////////
	//assign step = btnU;
	reg	[3:0] state;
	reg [4:0] count1;
	reg [4:0] count2;
	//reg start = 1;
	localparam
	 INITIAL = 4'b0001,
	 SORT    = 4'b0010,
	 SWAP 	= 4'b0100,
	 DONE  	= 4'b1000,
	 UNKN  	= 4'bxxxx;
	
	always @(posedge button_clk, posedge reset)
		begin
			if (reset)
				state <= INITIAL;
			else 
				begin
					case (state)
						INITIAL:
							begin
								if (start) begin
									state <= SORT;	
								end
									count1 <= 5'b00000;
									count2 <= 5'b11111;
									// Generate the following values using rand_gen.py:
									n[0] <= 143;
									n[1] <= 103;
									n[2] <= 252;
									n[3] <= 87;
									n[4] <= 24;
									n[5] <= 23;
									n[6] <= 65;
									n[7] <= 89;
									n[8] <= 60;
									n[9] <= 29;
									n[10] <= 64;
									n[11] <= 254;
									n[12] <= 42;
									n[13] <= 110;
									n[14] <= 167;
									n[15] <= 9;
									n[16] <= 181;
									n[17] <= 105;
									n[18] <= 75;
									n[19] <= 95;
									n[20] <= 21;
									n[21] <= 75;
									n[22] <= 44;
									n[23] <= 19;
									n[24] <= 101;
									n[25] <= 26;
									n[26] <= 103;
									n[27] <= 204;
									n[28] <= 123;
									n[29] <= 178;
									n[30] <= 126;
									n[31] <= 9;
							end	
						SORT:
							begin
								if (step && (count1 < 31) && (n[count1] > n[count1 + 1])) begin
									/* We should swap because current bar is larger than next bar. */
									state <= SWAP;
								end else begin
									/* We shouldn't swap because the next one is larger. */
									if (step && (count1 + 1 == count2) && (count2 == 1)) begin
										state <= DONE;
									end else if (step && (count1 + 1 == count2) && (count2 != 1)) begin
										count1 <= 0;
										count2 <= count2 - 1;
									end else if (step && ((count1 + 1) != count2)) begin
										count1 <= count1 + 1;
									end
								end 
						end
						SWAP:
							begin
							n[count1] <= n[count1 + 1];
							n[count1 + 1] <= n[count1];
							
							if (count1 < 31)
								count1 <= count1 + 1;
							else if (count1 == 31) begin
								count1 <= 0;
								count2 <= count2 - 1;
							end
							state <= SORT;
						end
						DONE:
							begin
								if (ack) begin
									state <= INITIAL;
								end

							end
					endcase
				end
		end
	/////////////////////////////////////////////////////////////////
	//////////////  	  SORTING control ends here 	 ////////////////
	/////////////////////////////////////////////////////////////////
endmodule
