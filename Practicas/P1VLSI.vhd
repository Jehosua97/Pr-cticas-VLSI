library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cont8b is
    Port ( mclk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           ip : in  STD_LOGIC;
           LEDS : out STD_LOGIC_VECTOR (7 downto 0));
end cont8b;

architecture Behavioral of cont8b is
signal delay: integer range 0 to 12000000:=0; -- Reloj base 12 MHz
signal div, temp: std_logic:='0';
signal cont: STD_LOGIC_VECTOR (7 downto 0):="00000000";

begin

divisor: process(mclk) --frec divisor = Reloj base(mclk) / N => N= (12MHz / 1 Hz)/2 -1 = 6999999
begin
	if rising_edge(mclk) then
		if(delay=6999999) then
			delay<=0;
			div<=not div;
		else 
			delay<=delay+1;
		end if;
	end if;
end process;

boton: process(mclk)
variable edoanterior: std_logic;
begin
	if rising_edge(mclk) then
		if ip='0' and edoanterior='1' then
			temp<=not(temp);
		end if;
		edoanterior:=ip;
	end if;
end process;

contador: process(mclk,cont, temp)
begin
	if rising_edge(mclk) then
		if(cont="11111111" or reset='1') then 
			cont<="00000000";
		elsif (temp='0') then
			cont<=cont+0;
		else
			cont<=cont+1;
		end if;
		
	end if;
end process;



LEDS<=cont; -- Se quitó el NOT porque los leds estan conectados en lógica negada

end Behavioral;