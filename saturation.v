module saturation(



input i_clk,
input [7:0]red_pixel,blue_pixel,green_pixel,
input [7:0]ar,ab,ag,
output reg [11:0]pr4_sda,
output reg [11:0]pr4_kha,
output  reg [11:0]shaf
);






reg [23:0]sha;
wire [11:0]sha_s;
reg [11:0]sha1;
reg [11:0]sha2;


reg [5:0]o_by_red,o_by_green,o_by_blue;

wire [14:0]red_mul,green_mul,blue_mul;
reg [9:0]blue_mul_temp;
wire [10:0]add_rg;
wire [9:0]min;

wire [9:0]sr,sb,sg;

wire [11:0]mul_a;
wire [11:0]add_rgb;
reg [11:0]add_rgb1,add_rgb2,sub1;
wire [11:0]sub,argb;

reg [10:0]pr2_add;
reg [9:0] pr2_blue;
reg [9:0] pr2_min;
wire [11:0]one_by_kh;


reg [11:0]pr3_sha;
reg [10:0]pr3_kha;
wire [12:0]sha_sub;

wire [11:0]sda;
reg [11:0]sda1;
reg [11:0]kha1;
reg [11:0]kha2;
reg [11:0]kha3;
wire [11:0]khaf;

wire [23:0]sda_mul;
parameter CLK_PERIOD = 10;
/*
blk_mem_gen_0 red_lut (
  .clka(i_clk),    // input wire clka
  .ena(1'b1),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(ar),  // input wire [7 : 0] addra
  .dina(dina),    // input wire [9 : 0] dina
  .douta(o_by_red)  // output wire [9 : 0] douta
);


blk_mem_gen_1 green_lut (
  .clka(i_clk),    // input wire clka
  .ena(1'b1),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(ag),  // input wire [7 : 0] addra
  .dina(dina),    // input wire [5 : 0] dina
  .douta(o_by_green)  // output wire [5 : 0] douta
);

blk_mem_gen_2 blue_lut (
  .clka(i_clk),    // input wire clka
  .ena(1),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(ab),  // input wire [7 : 0] addra
  .dina(dina),    // input wire [7 : 0] dina
  .douta(o_by_blue)  // output wire [7 : 0] douta
);
*/


blk_mem_gen_3 lut_kha (
  .clka(i_clk),    // input wire clka
  .ena(1),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(argb),  // input wire [11 : 0] addra
  .dina(dina),    // input wire [11 : 0] dina
  .douta(one_by_kh)  // output wire [11 : 0] douta
);
initial begin
o_by_red=18;
o_by_green=19;
o_by_blue=19;
end


assign red_mul=o_by_red*red_pixel;
assign green_mul=o_by_green*green_pixel;
assign blue_mul=o_by_blue*blue_pixel;

assign sr= red_mul>>4;
assign sg= green_mul>>4;
assign sb= blue_mul>>4;

assign min = (sr < sg) ? ((sr < sb) ? sr : sb) : ((sg < sb) ? sg : sb);
assign add_rg=sr+sg;


always@(posedge i_clk) begin
pr2_add<=add_rg;
pr2_blue<=sb;
pr2_min<=min;
end

assign mul_a=pr2_min*3;
assign add_rgb=pr2_add+pr2_blue;

////checkadd_rgb subraction
assign sub = (add_rgb >= mul_a) ? (add_rgb - mul_a) : 0;

always@(posedge i_clk)begin
sub1<=sub;
sha<= (one_by_kh * sub1);
end

assign argb = (add_rgb > 0) ? (add_rgb - 1) : 0;


assign sha_s=sha[11:0];

always@(posedge i_clk) begin
pr3_sha<=sha_s;
add_rgb1<=add_rgb;
add_rgb2<=add_rgb1;
pr3_kha<=add_rgb2;
end

assign sha_sub=13'd8191-pr3_sha;
assign sda_mul=pr3_sha*sha_sub;
assign sda=sda_mul>>12;

assign khaf=pr3_kha+(pr3_kha>>2);

always@(posedge i_clk)begin
sha1<=sha;
shaf<=sha1;
pr4_sda<=sda;
pr4_kha<=khaf;
end
endmodule
