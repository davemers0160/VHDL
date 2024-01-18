-------------------------------------------------------------------------------
-- 13 January 2024
-- Maximal Length Sequence VHDL Code
-- inputs:
--  - CLK_IN
--  - EN
--  
-- outputs:
--  - SR_OUT
--
-- tap list for 9 bit shift register
-- 2 taps: (1 set) [9, 5] 
-- 4 taps: (8 sets) [9, 8, 7, 2] [9, 8, 6, 5] [9, 8, 5, 4] [9, 8, 5, 1] [9, 8, 4, 2] [9, 7, 6, 4] [9, 7, 5, 2] [9, 6, 5, 3] 
-- 6 taps: (14 sets) [9, 8, 7, 6, 5, 3] [9, 8, 7, 6, 5, 1] [9, 8, 7, 6, 4, 3] [9, 8, 7, 6, 4, 2] [9, 8, 7, 6, 3, 2] [9, 8, 7, 6, 3, 1] [9, 8, 7, 6, 2, 1] 
--                   [9, 8, 7, 5, 4, 3] [9, 8, 7, 5, 4, 2] [9, 8, 6, 5, 4, 1] [9, 8, 6, 5, 3, 2] [9, 8, 6, 5, 3, 1] [9, 7, 6, 5, 4, 3] [9, 7, 6, 5, 4, 2] 
-- 8 taps: (1 sets) [9, 8, 7, 6, 5, 4, 3, 1]
-------------------------------------------------------------------------------


LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

----------------------------- ENTITY DECLARATIONS -----------------------------
ENTITY maximal_length_sequence IS
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
END maximal_length_sequence;


-------------------------- ARCHITECTURE DECLARATIONS --------------------------
ARCHITECTURE mls OF maximal_length_sequence IS

    SIGNAL sr:          STD_LOGIC_VECTOR(SR_LENGTH-1 DOWNTO 0) := "000000001";		--(0 => '1', OTHERS => '0');

BEGIN

    mls_process : PROCESS (CLK_IN, EN)
    	VARIABLE feedback:    STD_LOGIC;

    BEGIN
        IF (EN = '0') THEN
            sr <= "000000001";
        ELSIF(rising_edge(CLK_IN)) THEN
            --sr <= feedback & sr(SR_LENGTH-1 DOWNTO 1);
            sr <= sr(SR_LENGTH-2 DOWNTO 0) & feedback;

            --sr(8) <= sr(0);
--            sr(7) <= sr(6) xor sr(1);
--            sr(6) <= sr(7);
--            sr(5) <= sr(6);
--            sr(4) <= sr(5) xor sr(1);
--            sr(3) <= sr(4);
--            sr(2) <= sr(3);
--            sr(1) <= sr(2);
--            sr(0) <= sr(1);            
        END IF;

    	--feedback := sr(0) XOR sr(4);
        feedback := sr(SR_LENGTH-1) XOR sr(4);

    END PROCESS;
    
    SR_OUT <= sr(0);

END mls;

-------------------------------------------------------------------------------
