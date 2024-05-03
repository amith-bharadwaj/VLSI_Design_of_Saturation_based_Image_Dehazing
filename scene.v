`timescale 1ns / 1ps

module scene_restoration(
input clk,
input [7:0] hr,hb,hg,
input [7:0] ar,ab,ag,
input [11:0] t_inv,
output [7:0] dr,dg,db
    );

wire [7:0]sub_r,check_r,check_b,check_g;
wire [7:0]sub_b;
wire [7:0]sub_g;
  
reg [7:0]temp_r,temp_b,temp_g,temp1r,temp1g,temp1b,temp2r,temp2g,temp2b,temp3r,temp3g,temp3b,temp4r,temp4g,temp4b,temp5r,temp5g,temp5b;

reg [11:0] temp_t;

    wire [7:0]s_r;
    wire [7:0]s_b;
    wire [7:0]s_g;
    
    
wire [7:0] sub_out1;    
reg [7:0] PR1,PR2,PR3,shift_out1,shift_out2,shift_out3;
wire [17:0] mul_r,mul_b,mul_g;


always@(posedge clk)
begin
        temp_t<=t_inv;
        temp_r<=ar;
        temp1r <= hr;
        temp2r <= temp1r;
        temp3r <= temp2r;
        temp4r <= temp3r;
        temp5r <= temp4r;
        
        
        temp_b<=ab;
        temp1b <=hb;
        temp2b <= temp1b;
        temp3b <= temp2b;
        temp4b <= temp3b;
        temp5b <= temp4b;
        
        
        
        
        temp_g<=ag; 
        temp1g<=hg;
        temp2g<= temp1g;
        temp3g<= temp2g;
        temp4g<= temp3g;
        temp5g<= temp4g;
        
        
        
        
 end
 
assign sub_r = (temp5r - temp_r);
assign sub_g = (temp5g - temp_g);
assign sub_b = (temp5b - temp_b);

 assign check_r = (sub_r[7]==0)?(sub_r):(-sub_r);
       assign check_g = (sub_g[7]==0)?(sub_g):(-sub_g);
        assign check_b = (sub_b[7]==0)?(sub_b):(-sub_b);
    
        

    assign  mul_r = temp_t*check_r;
    assign mul_b = temp_t*check_b;
     assign mul_g = temp_t*check_g;
     
        
        
       assign s_r = mul_r[7:0];
       assign s_b = mul_b[7:0];
       assign s_g = mul_g[7:0];
       
       
       
assign  dr=(sub_r[7]==0)?((s_r+temp_r>=255)?255:(s_r+temp_r)):((s_r>=temp_r)?0:(-s_r+temp_r));
assign  dg= (sub_g[7]==0)?((s_g+temp_g>=255)?255:(s_g+temp_g)):((s_g>=temp_g)?0:(-s_g+temp_g));
assign  db= (sub_b[7]==0)?((s_b+temp_b>=255)?255:(s_b+temp_b)):((s_b>=temp_b)?0:(-s_b+temp_b));
      
endmodule
