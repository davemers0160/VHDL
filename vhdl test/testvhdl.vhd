LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

-- entity declaration
entity testvhdl is
port(
	CLOCK_50		: in std_logic;
	LED			: out std_logic_vector(7 downto 0));
end entity;
	
	


	
-- architecture
architecture led_test of testvhdl is


component loader
PORT
	(
		noe_in		: IN STD_LOGIC 
	);
	end component;
	


signal temp_led	: std_logic_vector(7 downto 0) := (others => '0');
signal noe_in_sig	: std_logic := '1';

begin

	process(CLOCK_50)
	variable count	: integer range 0 to 500000 := 0;
	begin
		
		if(rising_edge(CLOCK_50)) then
			if (count < 500000) then
				count := count + 1;
			else
				count := 0;
				temp_led <= not temp_led;

				
			end if;
		end if;
	
	
	end process;

	LED <= temp_led;
	
	loader_inst : loader PORT MAP (noe_in	 => noe_in_sig);
		--noe_in	 => noe_in_sig
	--);
	
end architecture;

