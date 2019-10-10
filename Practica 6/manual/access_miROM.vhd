library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity access_miROM is
	PORT(
		switch: IN STD_LOGIC_VECTOR(3 downto 0);
		display: OUT STD_LOGIC_VECTOR(6 downto 0));
end access_miROM;

architecture X of access_miROM is

signal data: STD_LOGIC_VECTOR(6 downto 0);
	
begin

seg7_ROM: entity work.miROM
PORT MAP(addr => switch, data => data); 	
	
display<=data;
	
end X;