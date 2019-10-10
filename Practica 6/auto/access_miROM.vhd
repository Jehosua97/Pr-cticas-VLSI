library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity access_miROM is
	PORT(
		mclk: 	IN	 STD_LOGIC;
		display: OUT STD_LOGIC_VECTOR(6 downto 0));
end access_miROM;

architecture X of access_miROM is

signal delay: integer range 0 to 12000000:=0; -- Reloj base 12 MHz, Divisor
signal clk: std_logic:='0';

signal selec:STD_LOGIC_VECTOR(3 downto 0):="0000";
signal data: STD_LOGIC_VECTOR(6 downto 0);
	
begin

process(mclk) --(12MHz / 1 Hz)/2 -1 = 6999999
begin
	if rising_edge(mclk) then
		if(delay=4615383) then
			delay<=0;
			clk<=not clk;
		else 
			delay<=delay+1;
		end if;
	end if;
end process;


process(clk)
begin
	if rising_edge(clk) then
		selec<=selec+1;
	end if;
end process;

seg7_ROM: entity work.miROM
PORT MAP(addr => selec, data => data); 	
	
display<=data;
	
end X;