library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity prac2 is
    Port ( mclk : in  STD_LOGIC;
			  dir: in STD_LOGIC;
           reset : in  STD_LOGIC;
           LEDS : out STD_LOGIC_VECTOR (7 downto 0));
end prac2;

architecture Behavioral of prac2 is

signal delay: integer range 0 to 12000000:=0; -- Reloj base 12 MHz, Divisor
signal reloj: std_logic:='0';
signal corrimiento: STD_LOGIC_VECTOR (7 downto 0):=x"99";

begin

divisor: process(mclk) --frec divisor = Reloj base(mclk) / N => N= (12MHz / 1 Hz)/2 -1 = 6999999
begin
	if rising_edge(mclk) then
		if(delay=6999999) then
			delay<=0;
			reloj<=not reloj;
		else 
			delay<=delay+1;
		end if;
	end if;
end process;


registro: process(reloj) --0 derecha, 1 izquierda, dirección.
begin
	if(reset='1') then
		if(rising_edge(reloj))then
			if(dir='0') then
				corrimiento(7)<=corrimiento(0);
				corrimiento(6)<=corrimiento(7);
				corrimiento(5)<=corrimiento(6);
				corrimiento(4)<=corrimiento(5);
				corrimiento(3)<=corrimiento(4);
				corrimiento(2)<=corrimiento(3);
				corrimiento(1)<=corrimiento(2);
				corrimiento(0)<=corrimiento(1);
			else
				corrimiento(0)<=corrimiento(7);
				corrimiento(7)<=corrimiento(6);
				corrimiento(6)<=corrimiento(5);
				corrimiento(5)<=corrimiento(4);
				corrimiento(4)<=corrimiento(3);
				corrimiento(3)<=corrimiento(2);
				corrimiento(2)<=corrimiento(1);
				corrimiento(1)<=corrimiento(0);
			end if;
		end if;
	else
		corrimiento<=x"99";
	end if;
end process;			


LEDS<=corrimiento; -- Se quitó el NOT porque los leds estan conectados en lógica negada

end Behavioral;