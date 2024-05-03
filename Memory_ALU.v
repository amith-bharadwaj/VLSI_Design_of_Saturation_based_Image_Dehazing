`timescale 1ns / 1ps
module Memory_ALU(
input clk
    );
    parameter N=204755;
    reg [7:0] Atmos_R,Atmos_G,Atmos_B;
    reg [7:0] min_temp;
    reg [7:0] min_valueR,min_valueG,min_valueB;
    wire [7:0] min_valueRGB;
    wire [7:0] img_R;
    wire [7:0] img_G;
    wire [7:0] img_B;
    reg [19:0] addr_R,addr_G,addr_B;
reg [14:0] pix_cnt;
reg [6:0] cntr1,cntr2,cntr3,cntr4;
reg [7:0] min_3R1R,min_3R2R,min_3R3R,min_9R,minR;
reg [7:0] lb0R [0:N-1];
reg [7:0] lb1R [0:N-1];
reg [7:0] lb2R [0:N-1];
reg [7:0] lb3R [0:N-1];
reg [7:0] lb4R [0:N-1];
reg [7:0] lb5R [0:N-1];
reg [7:0] lb6R [0:N-1];
reg [7:0] lb7R [0:N-1];
reg [7:0] lb_min9R [0:N-1];
reg [7:0] min_3R1G,min_3R2G,min_3R3G,min_9G,minG;
reg [7:0] lb0G [0:N-1];
reg [7:0] lb1G [0:N-1];
reg [7:0] lb2G [0:N-1];
reg [7:0] lb3G [0:N-1];
reg [7:0] lb4G [0:N-1];
reg [7:0] lb5G [0:N-1];
reg [7:0] lb6G [0:N-1];
reg [7:0] lb7G [0:N-1];
reg [7:0] lb_min9G [0:N-1];

reg [7:0] min_3R1B,min_3R2B,min_3R3B,min_9B,minB;
reg [7:0] lb0B [0:N-1];
reg [7:0] lb1B [0:N-1];
reg [7:0] lb2B  [0:N-1];
reg [7:0] lb3B [0:N-1];
reg [7:0] lb4B [0:N-1];
reg [7:0] lb5B [0:N-1];
reg [7:0] lb6B [0:N-1];
reg [7:0] lb7B [0:N-1];
reg [7:0] lb_min9B [0:N-1];




reg flag1;
reg data_valid;
        
assign min_valueRGB = ( min_valueR < min_valueG && min_valueR < min_valueB) ? min_valueR : (min_valueG < min_valueR && min_valueG < min_valueB) ? min_valueG : min_valueB;
         
blk_mem_gen_0 IMG_R (
  .clka(clk),    // input wire clka
  .ena(1),      // input wire ena
  .wea(0),      // input wire [0 : 0] wea
  .addra(addr_R),  // input wire [13 : 0] addra
  .dina(dina),    // input wire [7 : 0] dina
  .douta(img_R)  // output wire [7 : 0] douta
);  

blk_mem_gen_1 IMG_G (
  .clka(clk),    // input wire clka
  .ena(1),      // input wire ena
  .wea(0),      // input wire [0 : 0] wea
  .addra(addr_G),  // input wire [13 : 0] addra
  .dina(dina),    // input wire [7 : 0] dina
  .douta(img_G)  // output wire [7 : 0] douta
);

blk_mem_gen_2 IMG_B (
  .clka(clk),    // input wire clka
  .ena(1),      // input wire ena
  .wea(0),      // input wire [0 : 0] wea
  .addra(addr_B),  // input wire [13 : 0] addra
  .dina(dina),    // input wire [7 : 0] dina
  .douta(img_B)  // output wire [7 : 0] douta
);

initial begin
addr_R <= 0;
addr_G <= 0;
addr_B <= 0;
pix_cnt <= 0;
#410 flag1 <=1;
cntr1<=0;
cntr2<=0;
cntr3<=0;
cntr4<=0;
min_temp <= 0;
#20002;
#500
$finish;
end

always@(posedge clk)
begin
#6
if(cntr3 == N-1)
cntr3 <= 0;
else
begin
cntr3 <= cntr3 + 3;
end
end
 

always@(posedge clk)
begin
#6
if(cntr4 == N-1)
cntr4 <= 0;
else if(flag1)
begin
cntr4 <= cntr4 + 1;
end
end 
 
always@(posedge clk)
begin
addr_R <= addr_R + 1;
addr_G <= addr_R + 1;
addr_B <= addr_R + 1;
pix_cnt <= pix_cnt + 1;

if(cntr1 < N-1)
cntr1 <= cntr1 + 1;
else
begin
cntr1 <= 0;
if(cntr2 == 7)
    cntr2 <=0;
else    
cntr2 <= cntr2 + 1;
end
end  
  
always@(posedge clk)
begin
case(cntr2)
    0: lb0R[cntr1] = img_R;
    1: lb1R[cntr1] = img_R;
    2: lb2R[cntr1] = img_R;
    3: lb3R[cntr1] = img_R;
    4: lb4R[cntr1] = img_R;
    5: lb5R[cntr1] = img_R;
    6: lb6R[cntr1] = img_R;
    7: lb7R[cntr1] = img_R;
endcase   
end 

always@(posedge clk)
begin
case(cntr2)
    0: lb0G[cntr1] = img_G;
    1: lb1G[cntr1] = img_G;
    2: lb2G[cntr1] = img_G;
    3: lb3G[cntr1] = img_G;
    4: lb4G[cntr1] = img_G;
    5: lb5G[cntr1] = img_G;
    6: lb6G[cntr1] = img_G;
    7: lb7G[cntr1] = img_G;
endcase   
end 

always@(posedge clk)
begin
case(cntr2)
    0: lb0B[cntr1] = img_B;
    1: lb1B[cntr1] = img_B;
    2: lb2B[cntr1] = img_B;
    3: lb3B[cntr1] = img_B;
    4: lb4B[cntr1] = img_B;
    5: lb5B[cntr1] = img_B;
    6: lb6B[cntr1] = img_B;
    7: lb7B[cntr1] = img_B;
endcase   
end 








always@(posedge clk)
begin
if(flag1)
lb_min9G[cntr4] = min_9G;
end

always@(posedge clk)
begin
if(flag1)
lb_min9R[cntr4] = min_9R;
end

always@(posedge clk)
begin
if(flag1)
lb_min9B[cntr4] = min_9B;
end




always@(posedge clk)
begin
 min_3R1R = ( lb0R[cntr3] < lb0R[cntr3+1] && lb0R[cntr3] < lb0R[cntr3+2]) ? lb0R[cntr3] : (lb0R[cntr3+1] < lb0R[cntr3] && lb0R[cntr3+1] < lb0R[cntr3+2]) ? 
 lb0R[cntr3+1] : lb0R[cntr3+2];
min_3R2R = ( lb1R[cntr3] < lb1R[cntr3+1] && lb1R[cntr3] < lb1R[cntr3+2]) ? lb1R[cntr3] : (lb1R[cntr3+1] < lb1R[cntr3] && lb1R[cntr3+1] < lb1R[cntr3+2]) ? 
 lb1R[cntr3+1] : lb1R[cntr3+2];
min_3R3R = ( lb2R[cntr3] < lb2R[cntr3+1] && lb2R[cntr3] < lb2R[cntr3+2]) ? lb2R[cntr3] : (lb2R[cntr3+1] < lb2R[cntr3] && lb2R[cntr3+1] < lb2R[cntr3+2]) ? 
 lb2R[cntr3+1] : lb2R[cntr3+2];
min_9R =  (min_3R1R < min_3R2R && min_3R1R< min_3R3R) ? min_3R1R : (min_3R2R < min_3R1R && min_3R2R < min_3R3R) ? min_3R2R : min_3R3R;
end


always@(posedge clk)
begin
 min_3R1G = ( lb0G[cntr3] < lb0G[cntr3+1] && lb0G[cntr3] < lb0G[cntr3+2]) ? lb0G[cntr3] : (lb0G[cntr3+1] < lb0G[cntr3] && lb0G[cntr3+1] < lb0G[cntr3+2]) ? 
 lb0G[cntr3+1] : lb0G[cntr3+2];
min_3R2G = ( lb1G[cntr3] < lb1G[cntr3+1] && lb1G[cntr3] < lb1G[cntr3+2]) ? lb1G[cntr3] : (lb1G[cntr3+1] < lb1G[cntr3] && lb1G[cntr3+1] < lb1G[cntr3+2]) ? 
 lb1G[cntr3+1] : lb1G[cntr3+2];
min_3R3G = ( lb2G[cntr3] < lb2G[cntr3+1] && lb2G[cntr3] < lb2G[cntr3+2]) ? lb2G[cntr3] : (lb2G[cntr3+1] < lb2G[cntr3] && lb2G[cntr3+1] < lb2G[cntr3+2]) ? 
 lb2G[cntr3+1] : lb2G[cntr3+2];
min_9G =  (min_3R1G < min_3R2G && min_3R1G< min_3R3G) ? min_3R1G : (min_3R2G < min_3R1G && min_3R2G < min_3R3G) ? min_3R2G : min_3R3G;
end


always@(posedge clk)
begin
 min_3R1B = ( lb0B[cntr3] < lb0B[cntr3+1] && lb0B[cntr3] < lb0B[cntr3+2]) ? lb0B[cntr3] : (lb0B[cntr3+1] < lb0B[cntr3] && lb0B[cntr3+1] < lb0B[cntr3+2]) ? 
 lb0B[cntr3+1] : lb0B[cntr3+2];
min_3R2B = ( lb1B[cntr3] < lb1B[cntr3+1] && lb1B[cntr3] < lb1B[cntr3+2]) ? lb1B[cntr3] : (lb1B[cntr3+1] < lb1B[cntr3] && lb1B[cntr3+1] < lb1B[cntr3+2]) ? 
 lb1B[cntr3+1] : lb1B[cntr3+2];
min_3R3B = ( lb2B[cntr3] < lb2B[cntr3+1] && lb2B[cntr3] < lb2B[cntr3+2]) ? lb2B[cntr3] : (lb2B[cntr3+1] < lb2B[cntr3] && lb2B[cntr3+1] < lb2B[cntr3+2]) ? 
 lb2B[cntr3+1] : lb2B[cntr3+2];
min_9B =  (min_3R1B < min_3R2B && min_3R1B< min_3R3B) ? min_3R1B : (min_3R2B < min_3R1B && min_3R2B < min_3R3B) ? min_3R2B : min_3R3B;
end


always @(posedge clk) begin
    min_valueR = lb_min9R[cntr4];
    
    if (lb_min9R[cntr4+1] < min_valueR) min_valueR = lb_min9R[cntr4+1];
    if (lb_min9R[cntr4+2] < min_valueR) min_valueR = lb_min9R[cntr4+2];
    if (lb_min9R[cntr4+3] < min_valueR) min_valueR = lb_min9R[cntr4+3];
    if (lb_min9R[cntr4+4] < min_valueR) min_valueR = lb_min9R[cntr4+4];
    if (lb_min9R[cntr4+5] < min_valueR) min_valueR = lb_min9R[cntr4+5];
    if (lb_min9R[cntr4+6] < min_valueR) min_valueR = lb_min9R[cntr4+6];
    if (lb_min9R[cntr4+7] < min_valueR) min_valueR = lb_min9R[cntr4+7];
    if (lb_min9R[cntr4+8] < min_valueR) min_valueR = lb_min9R[cntr4+8];
end

always @(posedge clk) begin
    min_valueG = lb_min9G[cntr4];
    
    if (lb_min9G[cntr4+1] < min_valueG) min_valueG = lb_min9G[cntr4+1];
    if (lb_min9G[cntr4+2] < min_valueG) min_valueG = lb_min9G[cntr4+2];
    if (lb_min9G[cntr4+3] < min_valueG) min_valueG = lb_min9G[cntr4+3];
    if (lb_min9G[cntr4+4] < min_valueG) min_valueG = lb_min9G[cntr4+4];
    if (lb_min9G[cntr4+5] < min_valueG) min_valueG = lb_min9G[cntr4+5];
    if (lb_min9G[cntr4+6] < min_valueG) min_valueG = lb_min9G[cntr4+6];
    if (lb_min9G[cntr4+7] < min_valueG) min_valueG = lb_min9G[cntr4+7];
    if (lb_min9G[cntr4+8] < min_valueG) min_valueG = lb_min9G[cntr4+8];
end

always @(posedge clk) begin
    min_valueB = lb_min9B[cntr4];
    
    if (lb_min9B[cntr4+1] < min_valueB) min_valueB = lb_min9B[cntr4+1];
    if (lb_min9B[cntr4+2] < min_valueB) min_valueB = lb_min9B[cntr4+2];
    if (lb_min9B[cntr4+3] < min_valueB) min_valueB = lb_min9B[cntr4+3];
    if (lb_min9B[cntr4+4] < min_valueB) min_valueB = lb_min9B[cntr4+4];
    if (lb_min9B[cntr4+5] < min_valueB) min_valueB = lb_min9B[cntr4+5];
    if (lb_min9B[cntr4+6] < min_valueB) min_valueB = lb_min9B[cntr4+6];
    if (lb_min9B[cntr4+7] < min_valueB) min_valueB = lb_min9B[cntr4+7];
    if (lb_min9B[cntr4+8] < min_valueB) min_valueB = lb_min9B[cntr4+8];
end


always@(posedge clk)
begin
if(min_temp < min_valueRGB)
begin
min_temp = min_valueRGB;
Atmos_R = min_valueR; 
Atmos_G = min_valueG;
Atmos_B = min_valueB;
end
else
min_temp = min_temp;
end


endmodule



