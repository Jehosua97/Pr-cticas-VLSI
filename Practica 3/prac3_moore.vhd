library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity prac3 is
    Port ( mclk, h : in  STD_LOGIC;
           a, b: out STD_LOGIC;
			  led: out STD_LOGIC_VECTOR(5 downto 0));
end prac3;

architecture Behavioral of prac3 is

type estado is (e0, e1, e2, e3);
signal qt: estado;

begin

process(clk)
	begin
		if rising_edge(clk) then
			case qt is
				when e0 => a <='0';
							  b <='0';
							  if (h='0') then qt<=e1;
							  else qt<=e0;
							  end if;
							  
				when e1 => a <='1';
							  b <='0';
							  if (h='0') then qt<=e1;
							  else qt<=e2;
							  end if;
							  
				when e2 => a <='0';
							  b <='0';
							  if (h='0') then qt<=e3;
							  else qt<=e2;
							  end if;
							  
				when e3 => a <='0';
							  b <='1';
							  if (h='0') then qt<=e3;
							  else qt<=e0;
							  end if;

			end case;
		end if;
end process;

led<="000000";

end Behavioral;