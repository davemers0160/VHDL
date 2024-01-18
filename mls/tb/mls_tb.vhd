-------------------------------------------------------------------------------
-- 13 January 2024
-- Maximal Length Sequence VHDL Code
-- inputs:
--  - CLK_IN
--  - EN
--  
-- outputs:
--  - SR_OUT
-------------------------------------------------------------------------------


LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

----------------------------- ENTITY DECLARATIONS -----------------------------
ENTITY test_bench IS

END ENTITY;

ARCHITECTURE tb OF test_bench IS

--------------------------- COMPONENT DECLARATIONS ----------------------------
COMPONENT maximal_length_sequence IS	

    GENERIC 
    (
        SR_LENGTH:      POSITIVE := 9
    );
    PORT 
    ( 
        CLK_IN:         IN  STD_LOGIC;
        EN:             IN  STD_LOGIC;
        SR_OUT:         OUT STD_LOGIC
    ); 

END COMPONENT;


COMPONENT bpsk_modulator IS
    GENERIC 
    (
        AMPLITUDE:      INTEGER := 2000
    );
    PORT 
    ( 
        CLK_IN:         IN  STD_LOGIC;
        EN:             IN  STD_LOGIC;
        --DATA_IN:        IN  STD_LOGIC;
        BPSK_I:         OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
        BPSK_Q:         OUT STD_LOGIC_VECTOR(11 DOWNTO 0)        
    );
END COMPONENT;

---------------------------- SIGNAL DECLARATIONS ------------------------------
-- Setup clock period definition
CONSTANT TB_clock_period 		: TIME := 1 ns;

-- constant TB_CLOCKS_PER_CHIP		: POSITIVE := 10;
-- constant TB_Data_Size			: POSITIVE := 8;
-- constant TB_Test_Data			: STD_LOGIC_VECTOR(TB_Data_Size-1 DOWNTO 0) := "10110010";

-- CLOCK SIGNALS
SIGNAL TB_sys_clk               : STD_LOGIC := '0';
-- signal TB_data_clk              : STD_LOGIC := '1';


-- CONTROL SIGNALS
signal TB_enable                : STD_LOGIC := '0';

		
-- DATA SIGNALS
-- signal TB_DATA_IN				: STD_LOGIC;		-- 8-bit data in
SIGNAL TB_MLS_OUT				: STD_LOGIC;		-- 32-bit data out
SIGNAL TB_BPSK_I_OUT				: STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL TB_BPSK_Q_OUT				: STD_LOGIC_VECTOR(11 DOWNTO 0);

BEGIN
------------------------- START OF MAIN CODE BODY -----------------------------
-- map the component to the test bench signals
UUT: maximal_length_sequence PORT MAP (TB_sys_clk, TB_enable, TB_MLS_OUT);
BPSK_UUT: bpsk_modulator PORT MAP (TB_sys_clk, TB_enable, TB_BPSK_I_OUT, TB_BPSK_Q_OUT);

-------------------------------------------------------------------------------
-- Test Bench Main System Clock
TB_clk_process : PROCESS
BEGIN
	TB_sys_clk <= '1';
	WAIT FOR TB_clock_period;  -- signal is '1'
			
	TB_sys_clk <= '0';
	WAIT FOR TB_clock_period;  -- signal is '0'
END PROCESS;

-------------------------------------------------------------------------------
-- Test Bench RESET_N process
TB_enable_process : PROCESS(TB_sys_clk)
	VARIABLE tb_count		:	INTEGER RANGE 0 TO 8 := 0;
BEGIN
	IF(rising_edge(TB_sys_clk)) THEN
		IF(tb_count < 4) THEN
			tb_count := tb_count + 1;
		ELSE
			TB_enable <= '1';
		END IF;
	END IF;
END PROCESS;


-------------------------------------------------------------------------------
-- Main Test Bench Simulation
tb_sim	: PROCESS(TB_sys_clk, TB_enable)
	variable tb_count		: integer range 0 to 65535 := 0;
	--variable tb_data_index	: integer range 0 to TB_Data_Size := 0;
BEGIN

	IF(TB_enable = '0') THEN
		tb_count := 0;

	ELSIF(rising_edge(TB_sys_clk)) THEN
        	tb_count := tb_count + 1;
        
	END IF;
	
END PROCESS;

END ARCHITECTURE;
