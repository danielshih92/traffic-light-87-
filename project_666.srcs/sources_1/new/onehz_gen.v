`timescale 1ns / 1ps

module oneHz_gen(
    input clk_125MHz,   
    input hold,        
    output clk_1Hz
    );
    
    reg clk_1Hz_reg = 0;
    reg [25:0] counter_reg;
    
    always @(posedge clk_125MHz or posedge hold) begin
        if(hold)
            counter_reg <= 0;
        else
            if(counter_reg == 62_499_999) begin
                counter_reg <= 0;
                clk_1Hz_reg <= ~clk_1Hz_reg;
            end    
            else
                counter_reg <= counter_reg + 1;
    end
    assign clk_1Hz = clk_1Hz_reg;
    
endmodule