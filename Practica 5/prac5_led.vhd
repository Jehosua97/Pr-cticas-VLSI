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
signal delay: integer range 0 to 26000:=0; -- Reloj base 260 MHz, Divisor/10000Hz)
signal clk: std_logic:='0';
signal factor : integer;
signal frecuencia: integer := 26000;--(10000Hz)

begin

process(mclk)
begin
	if rising_edge(mclk) then
			if(delay< (factor * frecuencia)/10) then
				led <= '1';
			else
				led <= '0';
			end if;
			if(delay= 25999) then
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