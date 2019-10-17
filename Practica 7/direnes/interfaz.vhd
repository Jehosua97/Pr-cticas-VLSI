library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity interfaz is
	PORT(
		mclk: IN STD_LOGIC;
		switch: IN STD_LOGIC_VECTOR(2 downto 0);
		led: OUT STD_LOGIC_VECTOR(5 downto 0);
		ledoff: OUT STD_LOGIC_VECTOR(1 downto 0));
end interfaz;

architecture X of interfaz is

signal delay: integer range 0 to 30000000:=0; -- Reloj base 12 MHz, Divisor
signal clk: std_logic:='0';

signal data:		STD_LOGIC_VECTOR(14 downto 0);
signal addr: 		STD_LOGIC_VECTOR(2 downto 0);
signal prueba:		STD_LOGIC_VECTOR(2 downto 0);

begin


entidad: entity work.rom
PORT MAP(addr => addr, data => data); 	

process(mclk)
begin
	if rising_edge(mclk) then
		prueba <= data(14 downto 12);
		led <= data (5 downto 0);
		if (prueba="000") then
			addr <= data(8 downto 6);
		else
			if (switch = prueba) then
				addr <= data(8 downto 6);
			else
				addr <= data(11 downto 9);
			end if;
		end if;
--		case prueba is
--			when "000" =>
--				direccion <= data(11 downto 9);
--			when "100" =>
--				if (switch = "100") then
--					direccion <= data(8 downto 6);
--				else
--					direccion <= data(11 downto 9);
--				end if;
--			when "010" =>
--				if (switch = "010") then
--					direccion <= data(8 downto 6);
--				else
--					direccion <= data(11 downto 9);
--				end if;
--			when "001" =>
--				if (switch = "001") then
--					direccion <= data(8 downto 6);
--				else
--					direccion <= data(11 downto 9);
--				end if;
--			when others =>
--				direccion <= direccion;
--		end case;
	end if;
end process;

divisor: process(mclk) --frec divisor = Reloj base(mclk) / N => N= (12MHz / 1 Hz)/2 -1 = 5999999
begin
	if rising_edge(mclk) then
		if(delay=30000000) then
			delay<=0;
			clk<=not clk;
		else 
			delay<=delay+1;
		end if;
	end if;
end process;

ledoff <= "00";	

end X;