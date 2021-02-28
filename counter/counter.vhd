LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY counter IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        pause : IN STD_LOGIC;
        count_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END counter;
ARCHITECTURE Behavioral OF counter IS
    SIGNAL temp_count : STD_LOGIC_VECTOR(3 DOWNTO 0) := x"0";
    SIGNAL slow_clk : STD_LOGIC;
    -- Clock divider can be changed to suit application.
    -- Clock (clk) is normally 50 MHz, so each clock cycle
    -- is 20 ns. A clock divider of 'n' bits will make 1
    -- slow_clk cycle equal 2^n clk cycles.
    SIGNAL clk_divider : STD_LOGIC_VECTOR(23 DOWNTO 0) := x"000000";
BEGIN
    -- Process that makes slow clock go high only when MSB of
    -- clk_divider goes high.
    clk_division : PROCESS (clk, clk_divider)
    BEGIN
        IF (clk = '1' AND clk'event) THEN
            clk_divider <= clk_divider + 1;
        END IF;

        slow_clk <= clk_divider(23);
    END PROCESS;
    counting : PROCESS (reset, pause, slow_clk, temp_count)
    BEGIN
        IF reset = '1' THEN
            temp_count <= "0000"; -- Asynchronous reset.
        ELSIF pause = '1' THEN
            temp_count <= temp_count; -- Asynchronous count pause.
        ELSE

            IF slow_clk'event AND slow_clk = '1' THEN -- Counting state
                IF temp_count < 9 THEN
                    temp_count <= temp_count + 1; -- Counter increase
                ELSE
                    temp_count <= "0000"; -- Rollover to zero 

                END IF;
            END IF;
        END IF;
        count_out <= temp_count; -- Output
    END PROCESS;
END Behavioral; -- End module.