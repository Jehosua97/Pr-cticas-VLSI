library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity miROM is
	GENERIC( -- Describir estructura de la ROM
		addr_width: integer:=16; -- Num. localidades
		addr_bits:	integer:=4;
		data_width:	integer:=7);
	PORT(
		addr: IN STD_LOGIC_VECTOR(addr_bits-1 downto 0);
		data: OUT STD_LOGIC_VECTOR(data_width-1 downto 0));
end miROM;

architecture XX of miROM is

type rom_type is array(0 to addr_width-1) of STD_LOGIC_VECTOR(data_width-1 downto 0);
signal seg: rom_type:=("0111111", --MSB --> LSB (gfedcba)
								"0000110",
								"1011011",
								"1001111",
								"1100110",
								"1101101",
								"1111101",
								"0000111",
								"1111111",
								"1101111",
								"1110111",
								"1111100",
								"0111001",
								"1011110",
								"1111001",
								"1110001");
								
begin
data<=seg(conv_integer(unsigned(addr)));
end XX;