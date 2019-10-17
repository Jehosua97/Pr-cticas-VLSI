library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity rom is
	GENERIC( -- Describir estructura de la ROM
		addr_width: integer:=8; -- Num. localidades
		addr_bits:	integer:=3;
		data_width:	integer:=15);
	PORT(
		addr: IN STD_LOGIC_VECTOR(addr_bits-1 downto 0);
		data:	OUT STD_LOGIC_VECTOR(data_width-1 downto 0));
end rom;

architecture XX of rom is

type rom_type is array(0 to addr_width-1) of STD_LOGIC_VECTOR(data_width-1 downto 0);
signal seg: rom_type:=("010101111011000",
								"000000000001001",
								"001110100000110",
								"100010100000100",
								"000000000001010",
								"000001001000010",
								"000001001100000",
								"000011011000100");
								
begin
data<=seg(conv_integer(unsigned(addr)));

end XX;