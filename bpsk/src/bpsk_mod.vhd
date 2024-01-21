-------------------------------------------------------------------------------
-- 13 January 2024
-- BPSK VHDL Code
-- inputs:
--  - CLK_IN
--  - EN
--  
-- outputs:
--  - BPSK_OUT
-------------------------------------------------------------------------------


LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

----------------------------- ENTITY DECLARATIONS -----------------------------
ENTITY bpsk_modulator IS
    GENERIC 
    (
        AMPLITUDE:      INTEGER := 2000
    );
    PORT 
    ( 
        CLK_IN:         IN  STD_LOGIC;
        EN:             IN  STD_LOGIC;
        BPSK_OUT:       OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END bpsk_modulator;

-------------------------- ARCHITECTURE DECLARATIONS --------------------------
ARCHITECTURE bpsk_mod OF bpsk_modulator IS

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

--------------------------------DATA SIGNALS-----------------------------------
    SIGNAL mls_data:        STD_LOGIC;		

BEGIN

    MLS: maximal_length_sequence PORT MAP (CLK_IN, EN, mls_data);


    bpsk_process : PROCESS (CLK_IN, EN)

    BEGIN
        IF (EN = '0') THEN
            BPSK_OUT <= (OTHERS => '0');
         ELSE
             -- data get read QI, QI, QI,...
            IF (mls_data = '0') THEN
                --BPSK_I <= std_logic_vector(to_signed(-AMPLITUDE, BPSK_I'length));
                BPSK_OUT <= X"0000" & std_logic_vector(to_signed(-AMPLITUDE, 16));
            ELSE
                BPSK_OUT <= X"0000" & std_logic_vector(to_signed(AMPLITUDE, 16));
            END IF;
                
        END IF;  

    END PROCESS;
    
END bpsk_mod;

-------------------------------------------------------------------------------
