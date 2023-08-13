`timescale 1ns / 1ps
module single_port_ram(data_in , ram_address,write_enable,clk,data_out);
input [7:0]data_in;
input [5:0] ram_address;
input write_enable;
input clk;
output [7:0]data_out;

reg [7:0] ram_memory[31:0]; // a 32 byte ( 32*8 bit)  RAM  
reg [5:0] address_register;

always @(posedge clk)
begin
if (write_enable)  // write operation
  ram_memory[ram_address] <= data_in;
else 
  address_register <= ram_address;
end

assign data_out = ram_memory[address_register];

endmodule

module single_port_ram_testbench;
reg [7:0]data_in;
reg [5:0] ram_address;
reg write_enable;
reg clk;
wire [7:0]data_out;

single_port_ram  ram1(data_in , ram_address,write_enable,clk,data_out);

initial begin // clock initialization
clk =1'b1;
forever #10 clk=~clk;
end

initial
begin
// writing data into the memory
write_enable =1'b1;
#20;
ram_address=5'd0;
data_in = 8'h10;
#20;

ram_address=5'd2;
data_in = 8'h11;
#20;

ram_address=5'd7;
data_in = 8'haf;
#20;

//reading data from the memory
write_enable = 1'b0;

ram_address=5'd0;
#20;

ram_address=5'd2;
#20;

ram_address=5'd7;
#20;

$finish;
end
endmodule