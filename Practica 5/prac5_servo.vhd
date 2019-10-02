library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity prac5 is
    Port ( mclk	: in  STD_LOGIC;
			  switch:	in  STD_LOGIC_VECTOR(3 downto 0);
           led: 		out STD_LOGIC);
end prac5;

architecture Behavioral of prac5 is

--signal delay: integer range 0 to 12000000:=0; -- Reloj base 12 MHz, Divisor
--signal clk: std_logic:='0';
--signal corrimiento: STD_LOGIC_VECTOR (7 downto 0):=x"99";
--
--signal contador: unsigned (7 downto 0);
--signal pwmi: unsigned (4 downto 0);
--
--begin
--
--divisor: process(mclk) --frec divisor = Reloj base(mclk) / N => N= (12MHz / 1 Hz)/2 -1 = 6999999
--begin
--	if rising_edge(mclk) then
--		if(delay=749) then
--			delay<=0;
--			clk<=not clk;
--		else 
--			delay<=delay+1;
--		end if;
--	end if;
--end process;
--
--pwmi <= unsigned('0' & switch)+4;
--
--counter: process (clk) begin
--	if rising_edge(clk) then
--		if (contador = 160) then
--			 contador <= (others => '0');
--		else
--			 contador <= contador + 1;
--		end if;
--	end if;
--end process;
--
---- Output signal for the servomotor.
--led <= '1' when (contador < pwmi) else '0';

signal delay: integer range 0 to 10:=0; -- Reloj base 260 MHz, Divisor/10000Hz)
signal clk: std_logic:='0';
signal factor : integer;
signal frecuencia: integer := 10;--(10000Hz)


begin

process(mclk)
begin
	if rising_edge(mclk) then
			if(delay< (factor * frecuencia)/10) then
				led <= '1';
			else
				led <= '0';
			end if;
			if(delay>= 9) then
				delay<= 0;
			else
				delay<=delay+1;
			end if;
	end if;
end process;

process(mclk)
begin
	factor <= conv_integer(unsigned(switch));
end process;

end Behavioral;