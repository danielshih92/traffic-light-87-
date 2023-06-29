`timescale 1ns / 1ps

module state_machine(
    input hold,    
    input clk_1Hz,
    input crazy,
    output reg [2:0] main_st,   
    output reg [2:0] cross_st,   
    output reg [6:0] seg
    );
     
    // Define states
    parameter main_green_cross_red  = 3'b000;
    parameter main_yellow_cross_red = 3'b001;
    parameter main_red_cross_green  = 3'b010;
    parameter main_red_cross_yellow = 3'b011;
    parameter crazying_light = 3'b100;
    parameter crazying_dark = 3'b101;
    
    // The state register
    reg [2:0] state_reg;    // 5 states = 3 bits
    
    // Timer for light changes
    reg [4:0] light_counter = 0;    // main green = 7 seconds
                                    // main yellow = 2 seconds
                                    // cross green = 3 seconds
                                    // cross yellow = 2 seconds
                                    // total seconds = 14 = 5 bits
    
    // Next state logic
    always @(posedge clk_1Hz or posedge hold) begin
        if(hold)begin
            state_reg <= main_green_cross_red;  // reset state
        end
        else if(crazy)begin
            case(light_counter)
                5'd0:
                seg <= 7'b1111111; 
                5'd1:
                seg <= 7'b0000111;
                5'd2: 
                seg <= 7'b1111111;   
                5'd3:
                seg <= 7'b0000111;
                5'd4:
                seg <= 7'b1111111;
                5'd5:
                seg <= 7'b0000111;
                5'd6:
                seg <= 7'b1111111;
                5'd7:
                seg <= 7'b0000111;
                5'd8:
                seg <= 7'b1111111;
                5'd9:
                seg <= 7'b0000111;
                5'd10:
                seg <= 7'b1111111;
                5'd11:
                seg <= 7'b0000111;
                5'd12:
                seg <= 7'b1111111;
                5'd13:
                seg <= 7'b0000111;
                5'd14: 
                seg <= 7'b1111111;
            endcase
            state_reg <= crazying_light;
            case(state_reg)
                crazying_light: if((light_counter%2) == 0) state_reg <=crazying_dark;
                crazying_dark: if((light_counter%2)  == 1) state_reg <=crazying_light;
            endcase
        end   
        else begin
        case(light_counter)
            5'd0:
                seg <= 7'b1100111; 
            5'd1:
                seg = 7'b1111111;
            5'd2: 
                seg = 7'b0000111;    
            5'd3:
                seg = 7'b1111101;
            5'd4:
                seg = 7'b1101101;
            5'd5:
                seg = 7'b1100110;
            5'd6:
                seg = 7'b1001111;
            5'd7:
                seg = 7'b1011011;
            5'd8:
                seg = 7'b0110000;
            5'd9:
                seg = 7'b0111111;
            default:
                seg = 7'b1000000;
            endcase    
            case(state_reg)
                main_green_cross_red  : if(light_counter == 7)     state_reg <= main_yellow_cross_red;
                main_yellow_cross_red : if(light_counter == 9)     state_reg <= main_red_cross_green;
                main_red_cross_green  : if(light_counter == 12)     state_reg <= main_red_cross_yellow;
                main_red_cross_yellow : if(light_counter ==14)     state_reg <= main_green_cross_red;               
                default : state_reg <= main_green_cross_red; 
            endcase
         end
    end
    // Light Counter control
    always @(posedge clk_1Hz or posedge hold) begin
        if(hold)
            light_counter <= 0;
        else
            if(light_counter == 14) 
                light_counter <= 0;
            else
                light_counter <= light_counter + 1;
    end
    
    always @(posedge clk_1Hz) begin
        case(state_reg) 
            main_green_cross_red  : begin
                                        main_st  = 3'b001;  // green
                                        cross_st = 3'b100;  // red
                                    end
            main_yellow_cross_red : begin
                                        main_st  = 3'b010;  // yellow
                                        cross_st = 3'b100;  // red
                                    end
            main_red_cross_green  : begin
                                        main_st  = 3'b100;  // red
                                        cross_st = 3'b001;  // green
                                    end
            main_red_cross_yellow : begin
                                        main_st  = 3'b100;  // red
                                        cross_st = 3'b010;  // yellow
                                    end
            crazying_light: begin
                        main_st = 3'b010; //yellow light
                        cross_st = 3'b010;
                      end
            crazying_dark: begin
                        main_st = 3'b000; //dark
                        cross_st = 3'b000; 
                      end
        endcase
  end

endmodule