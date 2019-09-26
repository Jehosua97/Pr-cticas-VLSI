library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity prac4 is
    Port ( mclk, boton: in  STD_LOGIC;
           sd, si: 		in  STD_LOGIC;
			  switch:		in  STD_LOGIC_VECTOR(3 downto 0);
           led: 			out STD_LOGIC_VECTOR(1 downto 0);
			  --led: 		out STD_LOGIC_VECTOR(7 downto 0);
			  display: 			out STD_LOGIC_VECTOR(6 downto 0));
end prac4;

architecture Behavioral of prac4 is

signal delay: integer range 0 to 12000000:=0; -- Reloj base 12 MHz, Divisor
signal clk: std_logic:='0';
type estado is (e0, e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11);
signal qt, q: estado :=e0; -- de q+ y q, para estado siguiente y presente, respectivamente.

begin

process(mclk) --frec divisor = Reloj base(mclk) / N => N= (12MHz / 1 Hz)/2 -1 = 5999999
begin
	if rising_edge(mclk) then
		if(delay=5999999) then
			delay<=0;
			clk<=not clk;
		else 
			delay<=delay+1;
		end if;
	end if;
end process;

process(mclk)
begin
	if (rising_edge(mclk)) then
		if (boton='1') then
			case switch is
				when "0000" => q <= e0;
				when "0001" => q <= e1;
				when "0010" => q <= e2;
				when "0011" => q <= e3;
				when "0100" => q <= e4;
				when "0101" => q <= e5;
				when "0110" => q <= e6;
				when "0111" => q <= e7;
				when "1000" => q <= e8;
				when "1001" => q <= e9;
				when "1010" => q <= e10;
				when "1011" => q <= e11;
				when others => q <= qt;
			end case;
		else
			q<=qt;
		end if;
		
	end if;
end process;

process(clk)
begin
	if (rising_edge(clk)) then
		case q is
			when e0 => 	led <= "11";
							display <="1111110";
							
							if (si='0') then
								if (sd='0') then
									qt <= e0;
								else
									qt <= e1;
								end if;
							else
								if (sd='0') then
									qt <= e3;
								else
									qt <= e5;
								end if;
							end if;
			when e1 =>	led <= "00";
							display <="0110000";
							qt <= e2;
			
			when e2 =>	led <= "10";
							display <="1101101";
							qt <= e0;
							
			when e3 =>	led <= "00";
							display <="1111001";
							qt <= e4;
							
			when e4=>	led <= "01";
							display <="0110011";
							qt <= e0;
							
			when e5 =>	led <= "00";
							display <="1011011";
							qt <= e6;
							
			when e6 =>	led <= "10";
							display <="1011111";
							qt <= e7;
							
			when e7 =>	led <= "10";
							display <="1110000";
							qt <= e8;
							
			when e8=>	led <= "11";
							display <="1111111";
							qt <= e9;
							
			when e9 =>	led <= "11";
							display <="1110011";
							qt <= e10;
			
			when e10 =>	led <= "01";
							display <="1110111";
							qt <= e11;
							
			when e11 =>	led <= "01";
							display <="0011111";
							qt <= e0;
		end case;	
	end if;
end process;


--LED DIRECCIÓN
--ADELANTE 	11
--DERECHA 	01
--IZQUIERDA	10
--ATRÁS		00

--led(7) <= switch(3);
--led(6) <= switch(2);
--led(5) <= switch(1);
--led(4) <= switch(0);
--led(3) <= '0';
--led(2) <= '0';
--led(1) <= '0';
--led(0) <= '0';
--ledA	 <= pushA;
--ledR	 <= pushB;
--
--disp<="1010101";

end Behavioral;