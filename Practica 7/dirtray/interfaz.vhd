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

signal estado: STD_LOGIC_VECTOR(2 downto 0); --Registro con estado siguiente.
signal direccion: STD_LOGIC_VECTOR(5 downto 0):="111111"; --Dirección inicial. Al sumársele 1, se vuelve "000000".
begin


entidad: entity work.rom
--Se manda dirección (retroalimentada) y entradas.
--Se recibe estado y salida directo a led.
PORT MAP(addr => direccion, estado => estado, led => led); 	

process(clk)
begin
	if rising_edge(clk) then
		direccion <= estado & switch; --Concatenación de estado y entradas.
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
