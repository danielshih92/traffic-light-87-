`timescale 1ns / 1ps

module traffic_controller(
    input hold,
    input crazy,            // button
    input clk_125MHz,       
    output [2:0] main_st,   // LEDs
    output [2:0] cross_st,   // LEDs
    output  [6:0] segment
    );
    wire w_1Hz, w_reset;
    
    state_machine sm(.hold(w_reset), .clk_1Hz(w_1Hz),.crazy(crazy), 
                     .main_st(main_st), .cross_st(cross_st),.seg(segment));
    oneHz_gen uno(.clk_125MHz(clk_125MHz), .hold(w_reset), .clk_1Hz(w_1Hz));
    sw_debounce db(.clk(clk_125MHz), .btn_in(hold), .btn_out(w_reset) );
    
endmodule