library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity rom is
	GENERIC( -- Describir estructura de la ROM
		addr_width: integer:=41; -- Num. localidades
		addr_bits:	integer:=6;
		data_width:	integer:=9);
	PORT(
		addr: IN STD_LOGIC_VECTOR(addr_bits-1 downto 0);
		estado: OUT STD_LOGIC_VECTOR(2 downto 0);
		led: OUT STD_LOGIC_VECTOR(5 downto 0));
end rom;

architecture XX of rom is

type rom_type is array(0 to addr_width-1) of STD_LOGIC_VECTOR(data_width-1 downto 0);
signal seg: rom_type:=("000000000", --Valor de dirección inicial (dirige a estado 0 y da salida 0)
								"001011010",
								"001011010",
								"011011100",
								"011011100",
								"001011010",
								"001011010",
								"011011100",
								"011011100",
								"010001001",
								"010001001",
								"010001001",
								"010001001",
								"010001001",
								"010001001",
								"010001001",
								"010001001",
								"001100110",
								"100000110",
								"001100110",
								"100000110",
								"001100110",
								"100000110",
								"001100110",
								"100000110",
								"001000100",
								"001000100",
								"001000100",
								"001000100",
								"100000100",
								"100000100",
								"100000100",
								"100000100",
								"000001010",
								"000001010",
								"000001010",
								"000001010",
								"000001010",
								"000001010",
								"000001010",
								"000001010");
								
begin
estado<=seg(conv_integer(unsigned(addr+1)))(8 downto 6);
led<=seg(conv_integer(unsigned(addr+1)))(5 downto 0);
--seg(0)<="001011010";
end XX;