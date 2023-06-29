`timescale 1ns / 1ps
module segment(input clk,input reset,output reg  segment);
    reg [5:0]second=14;
    always @ (posedge clk or negedge reset) begin
       if (~reset)
         second<=14;
       else
         second <= second - 1;  
       if(second==0)
          second<=14;
    end
    
    always@(*)begin
    case (second)
      6'd5: segment = 7'b1000000;  
      6'd6: segment = 7'b1111001;  
      6'd7: segment = 7'b0100100;  
      6'd8: segment = 7'b0110000;  
      6'd9: segment = 7'b0011001;  
      6'd10: segment = 7'b0010010;  
      6'd11: segment = 7'b0000010;  
      6'd12: segment = 7'b1111000;  
      6'd13: segment = 7'b0000000;  
      6'd14: segment = 7'b0010000;  
      default: segment = 7'b1111111;  
    endcase
    end
    
endmodule
    



