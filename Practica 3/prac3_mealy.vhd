library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity prac3mealy is
    Port ( mclk, reset, h : in  STD_LOGIC;
           a, b: out STD_LOGIC;
			  led: out STD_LOGIC_VECTOR(5 downto 0));
end prac3mealy;

architecture Behavioral of prac3mealy is

type estado is (e0, e1, e2, e3);
signal qt, q: estado; -- de q+ y q, para estado siguiente y presente, respectivamente.

begin

process(mclk, reset)
	begin
		if (reset='0') then
			q <= e0;
		elsif (rising_edge(mclk)) then
			q <= qt;
		end if;
end process;

process(mclk, q, h)
	begin
		case q is
			when e0 => if (h='0') then
								a <='1';
								b <='0';
								qt <= e1;
							else
								a <='0';
								b <='0';
								qt <= e0;
							end if;
			
			when e1 => if (h='0') then
								a <='1';
								b <='0';
								qt <= e1;
							else
								a <='0';
								b <='0';
								qt <= e2;
							end if;
							
			when e2 => if (h='0') then
								a <='0';
								b <='1';
								qt <= e3;
							else
								a <='0';
								b <='0';
								qt <= e2;
							end if;
							
			when e3 => if (h='0') then
								a <='0';
								b <='1';
								qt <= e3;
							else
								a <='0';
								b <='0';
								qt <= e0;
							end if;
		end case;
end process;

led<="000000";

end Behavioral;