`timescale 1 ns / 1 ps

module sort (clk, reset, ack, start, to_sort);/* a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11,
				 a12, a13, a14, a15, a16, a17, a18, a19, a20, a21, a22, a23, a24, a25, a26,
				 a27, a28, a29, a30, a31, b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11,
				 b12, b13, b14, b15, b16, b17, b18, b19, b20, b21, b22, b23, b24, b25, b26,
				 b27, b28, b29, b30, b31, a);*/

	input clk, ack, reset, start;
	/*input [6:0] a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, 
					a17, a18, a19, a20, a21, a22, a23, a24, a25, a26, a27, a28, a29, a30, a31;
	output reg [6:0] b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16, 
					b17, b18, b19, b20, b21, b22, b23, b24, b25, b26, b27, b28, b29, b30, b31;
	reg [6:0] c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16,
				 c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31;*/
	output reg [7:0] to_sort [0:31];

	reg	[2:0] state;
	//reg	[5:0] c1;
	//reg	[5:0] c2;
	integer count1;
	integer count2;

	
	localparam
	 INITIAL = 3'b001,
	 SORT    = 3'b010,
	 DONE  	 = 3'b100,
	 UNKN  	 = 3'bxxx;
	
	
/*	
	assign b0 = c0;
	assign b1 = c1;
	assign b2 = c2;
	assign b3 = c3;
	assign b4 = c4;
	assign b5 = c5;
	assign b6 = c6;
	assign b7 = c7;
	assign b8 = c8;
	assign b9 = c9;
	assign b10 = c10;
	assign b11 = c11;
	assign b12 = c12;
	assign b13 = c13;
	assign b14 = c14;
	assign b15 = c15;
	assign b16 = c16;
	assign b17 = c17;
	assign b18 = c18;
	assign b19 = c19;
	assign b20 = c20;
	assign b21 = c21;
	assign b22 = c22;
	assign b23 = c23;
	assign b24 = c24;
	assign b25 = c25;
	assign b26 = c26;
	assign b27 = c27;
	assign b28 = c28;
	assign b29 = c29;
	assign b30 = c30;
	assign b31 = c31;
	
*/
	
	always @(posedge clk, posedge reset)
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
									/*to_sort[0] <= a0;
									to_sort[1] <= a1;
									to_sort[2] <= a2;
									to_sort[3] <= a3;
									to_sort[4] <= a4;
									to_sort[5] <= a5;
									to_sort[6] <= a6;
									to_sort[7] <= a7;
									to_sort[8] <= a8;
									to_sort[9] <= a9;
									to_sort[10] <= a10;
									to_sort[11] <= a11;
									to_sort[12] <= a12;
									to_sort[13] <= a13;
									to_sort[14] <= a14;
									to_sort[15] <= a15;
									to_sort[16] <= a16;
									to_sort[17] <= a17;
									to_sort[18] <= a18;
									to_sort[19] <= a19;
									to_sort[20] <= a20;
									to_sort[21] <= a21;
									to_sort[22] <= a22;
									to_sort[23] <= a23;
									to_sort[24] <= a24;
									to_sort[25] <= a25;
									to_sort[26] <= a26;
									to_sort[27] <= a27;
									to_sort[28] <= a28;
									to_sort[29] <= a29;
									to_sort[30] <= a30;
									to_sort[31] <= a31;*/
									
							end	
						SORT:
							begin
								if (to_sort[count1] > to_sort[count1 + 1]) begin
									to_sort[count1] <= to_sort[count1 + 1];
									to_sort[count1 + 1] <= to_sort[count1];
									count1 <= count1 + 1;
								end else begin
									if (count1 + 1 == count2 && count2 == 1) begin
										state <= DONE;
									end else if (count1 + 1 == count2 && count2 != 1) begin
										count1 <= 0;
										count2 <= count2 - 1;
									end else if (count1 + 1 != count2) begin
										count1 <= count1 + 1;
									end
								end 
								/*
								b0 <= to_sort[0];
								b1 <= to_sort[1];
								b2 <= to_sort[2];
								b3 <= to_sort[3];
								b4 <= to_sort[4];
								b5 <= to_sort[5];
								b6 <= to_sort[6];
								b7 <= to_sort[7];
								b8 <= to_sort[8];
								b9 <= to_sort[9];
								b10 <= to_sort[10];
								b11 <= to_sort[11];
								b12 <= to_sort[12];
								b13 <= to_sort[13];
								b14 <= to_sort[14];
								b15 <= to_sort[15];
								b16 <= to_sort[16];
								b17 <= to_sort[17];
								b18 <= to_sort[18];
								b19 <= to_sort[19];
								b20 <= to_sort[20];
								b21 <= to_sort[21];
								b22 <= to_sort[22];
								b23 <= to_sort[23];
								b24 <= to_sort[24];
								b25 <= to_sort[25];
								b26 <= to_sort[26];
								b27 <= to_sort[27];
								b28 <= to_sort[28];
								b29 <= to_sort[29];
								b30 <= to_sort[30];
								b31 <= to_sort[31];*/
								/*
								c0 <= to_sort[0];
								c1 <= to_sort[1];
								c2 <= to_sort[2];
								c3 <= to_sort[3];
								c4 <= to_sort[4];
								c5 <= to_sort[5];
								c6 <= to_sort[6];
								c7 <= to_sort[7];
								c8 <= to_sort[8];
								c9 <= to_sort[9];
								c10 <= to_sort[10];
								c11 <= to_sort[11];
								c12 <= to_sort[12];
								c13 <= to_sort[13];
								c14 <= to_sort[14];
								c15 <= to_sort[15];
								c16 <= to_sort[16];
								c17 <= to_sort[17];
								c18 <= to_sort[18];
								c19 <= to_sort[19];
								c20 <= to_sort[20];
								c21 <= to_sort[21];
								c22 <= to_sort[22];
								c23 <= to_sort[23];
								c24 <= to_sort[24];
								c25 <= to_sort[25];
								c26 <= to_sort[26];
								c27 <= to_sort[27];
								c28 <= to_sort[28];
								c29 <= to_sort[29];
								c30 <= to_sort[30];
								c31 <= to_sort[31];
								*/
						end
						DONE:
							begin
								if (ack) begin
									state <= INITIAL;
								end
								/*b0 <= to_sort[0];
								b1 <= to_sort[1];
								b2 <= to_sort[2];
								b3 <= to_sort[3];
								b4 <= to_sort[4];
								b5 <= to_sort[5];
								b6 <= to_sort[6];
								b7 <= to_sort[7];
								b8 <= to_sort[8];
								b9 <= to_sort[9];
								b10 <= to_sort[10];
								b11 <= to_sort[11];
								b12 <= to_sort[12];
								b13 <= to_sort[13];
								b14 <= to_sort[14];
								b15 <= to_sort[15];
								b16 <= to_sort[16];
								b17 <= to_sort[17];
								b18 <= to_sort[18];
								b19 <= to_sort[19];
								b20 <= to_sort[20];
								b21 <= to_sort[21];
								b22 <= to_sort[22];
								b23 <= to_sort[23];
								b24 <= to_sort[24];
								b25 <= to_sort[25];
								b26 <= to_sort[26];
								b27 <= to_sort[27];
								b28 <= to_sort[28];
								b29 <= to_sort[29];
								b30 <= to_sort[30];
								b31 <= to_sort[31];*/
								/*
								c0 <= to_sort[0];
								c1 <= to_sort[1];
								c2 <= to_sort[2];
								c3 <= to_sort[3];
								c4 <= to_sort[4];
								c5 <= to_sort[5];
								c6 <= to_sort[6];
								c7 <= to_sort[7];
								c8 <= to_sort[8];
								c9 <= to_sort[9];
								c10 <= to_sort[10];
								c11 <= to_sort[11];
								c12 <= to_sort[12];
								c13 <= to_sort[13];
								c14 <= to_sort[14];
								c15 <= to_sort[15];
								c16 <= to_sort[16];
								c17 <= to_sort[17];
								c18 <= to_sort[18];
								c19 <= to_sort[19];
								c20 <= to_sort[20];
								c21 <= to_sort[21];
								c22 <= to_sort[22];
								c23 <= to_sort[23];
								c24 <= to_sort[24];
								c25 <= to_sort[25];
								c26 <= to_sort[26];
								c27 <= to_sort[27];
								c28 <= to_sort[28];
								c29 <= to_sort[29];
								c30 <= to_sort[30];
								c31 <= to_sort[31];
								*/
							end
					endcase
				end
		end
endmodule  

