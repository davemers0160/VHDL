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

-- Convenience types
-- type wlan_sample_t is record
    -- i       :   signed(15 downto 0) ;
    -- q       :   signed(15 downto 0) ;
    -- valid   :   std_logic ;
-- end record ;

-- type sample_array_t is array(natural range <>) of wlan_sample_t ;

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
        --DATA_IN:        IN  STD_LOGIC;
        --BPSK_I:         OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
        --BPSK_Q:         OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
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

--------------------------------------------------------------------------------
-- DATA SIGNALS
SIGNAL mls_data:        STD_LOGIC;		

BEGIN

UUT: maximal_length_sequence PORT MAP (CLK_IN, EN, mls_data);


    bpsk_process : PROCESS (CLK_IN, EN, mls_data)

    BEGIN
        IF (EN = '0') THEN
            BPSK_OUT <= (OTHERS => '0');
	ELSE
            IF (mls_data = '0') THEN
                --BPSK_I <= std_logic_vector(to_signed(-AMPLITUDE, BPSK_I'length));
                BPSK_OUT <= std_logic_vector(to_signed(-AMPLITUDE, 16)) & X"0000";
            ELSE
                BPSK_OUT <= std_logic_vector(to_signed(AMPLITUDE, 16)) & X"0000";
            END IF;
            
        END IF;  

    END PROCESS;
    
END bpsk_mod;

-------------------------------------------------------------------------------
