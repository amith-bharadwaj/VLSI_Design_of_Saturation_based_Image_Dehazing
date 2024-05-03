`timescale 1ns / 1ps

module Transmission_map(
input clk,
input [11:0] SH,
input [11:0] SD,
input [11:0] N125_KH_in,
output reg [11:0] tran_inv 
    );

wire [11:0] sub_out1;

wire [11:0] shift_out1,shift_out2;
wire [11:0]sub_out2;
wire [23:0] mul_out1;
reg [25:0]mul_out2;
wire [13:0]o_by_sub;

reg [11:0]pr5_sda,pr5_sub;

blk_mem_gen_4 your_instance_name (
  .clka(clk),    // input wire clka
  .ena(1),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(sub_out2),  // input wire [11 : 0] addra
  .dina(dina),    // input wire [11 : 0] dina
  .douta(o_by_sub)  // output wire [11 : 0] douta
);

/// check whr=ether sh is greater than sd is possible

assign sub_out1 = SD-SH;
assign mul_out1 = N125_KH_in * sub_out1;
assign shift_out1 = mul_out1 >> 12;
assign sub_out2 = SD-shift_out1 ;
///lut

always@(posedge clk) begin
pr5_sub<=sub_out2;

pr5_sda<=SD;
end

always@(posedge clk) begin
mul_out2 = o_by_sub * pr5_sda;
end
assign shift_out2 = mul_out2>>13;

always@(posedge clk) begin
if(shift_out2==0)
tran_inv=0;
else
tran_inv = shift_out2;
end

endmodule