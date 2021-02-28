----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:52:49 02/28/2021 
-- Design Name: 
-- Module Name:    counter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- //Solve "found '0' definitions of operator "+" in VHDL error"
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY counter IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        pause : IN STD_LOGIC;
        count_out : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END counter;

ARCHITECTURE Behavioral OF counter IS

    SIGNAL temp_count : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL slow_clk : STD_LOGIC;
    SIGNAL clk_divider : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";

BEGIN
    clk_division : PROCESS (clk, clk_divider)
    BEGIN
        IF clk'event AND clk = '1' THEN
            clk_divider <= clk_divider + 1;
        END IF;
        slow_clk <= clk_divider(1);
    END PROCESS;

    counting : PROCESS (reset, pause, slow_clk, temp_count)
    BEGIN
        IF reset = '1' THEN
            temp_count <= "0000";
        ELSIF pause = '1' THEN
            temp_count <= temp_count;
        ELSE
            IF slow_clk'event AND slow_clk = '1' THEN
                IF temp_count < 9 THEN
                    temp_count <= temp_count + 1;
                ELSE
                    temp_count <= "0000";
                END IF;
            END IF;
        END IF;
        count_out <= temp_count;
    END PROCESS;
	 
	 
END Behavioral;