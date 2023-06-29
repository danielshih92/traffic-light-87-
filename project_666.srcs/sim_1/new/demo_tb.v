`timescale 1s/1ns
module traffic_light_tb();
    reg hold = 0;
    reg crazy = 0;
    reg clk_125MHz = 0;
    wire main_st, cross_st, segment;

    traffic_controller test(.hold(hold), .crazy(crazy), .clk_125MHz(clk_125MHz), .main_st(main_st),
                                 .cross_st(cross_st),.segment(segment));
always #4 clk_125MHz = ~clk_125MHz;//4ps toggle
initial begin
	hold = 0;
	crazy = 0;
    #1600000000 //16s
    #1600000000
    #1600000000
    #1600000000
    #1600000000
    #1600000000
    #1600000000
    #1600000000
    #1600000000
    #1600000000
	crazy = 1;
	#400000000
	#400000000
	#400000000
	#400000000
	#400000000
	#400000000
	#400000000
	#400000000
	#400000000
	#400000000
	crazy = 0;
	#100000000
	#100000000
	#100000000
	#100000000
	#100000000
	#100000000
	#100000000
	#100000000
	#100000000
	#100000000
	hold = 1;
	#300000000
	#300000000
	#300000000
	#300000000
	#300000000
	#300000000
	#300000000
	#300000000
	#300000000
	#300000000
	hold = 0;
	#500000000
        $finish;
    end
endmodule