LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
ENTITY counter_tb_vhd IS
END counter_tb_vhd;
ARCHITECTURE behavior OF counter_tb_vhd IS
   -- Component Declaration for the Unit Under Test (UUT)
   COMPONENT counter
      PORT (
         clk : IN STD_LOGIC;
         reset : IN STD_LOGIC;
         pause : IN STD_LOGIC;
         count_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
      );
   END COMPONENT;
   --Inputs
   SIGNAL clk : STD_LOGIC := '0';
   SIGNAL reset : STD_LOGIC := '0';
   SIGNAL pause : STD_LOGIC := '0';
   --Outputs
   SIGNAL count_out : STD_LOGIC_VECTOR(3 DOWNTO 0);

   CONSTANT clk_period : TIME := 10 ns;
BEGIN
   -- Instantiate the Unit Under Test (UUT)
   uut : counter PORT MAP(
      clk => clk,
      reset => reset,
      pause => pause,
      count_out => count_out
   );
   clock : PROCESS
   BEGIN
      clk <= NOT clk;
      WAIT FOR clk_period;

   END PROCESS;

   pause_test : PROCESS
   BEGIN

      pause <= '0';
      WAIT FOR clk_period * 74;
      pause <= '1';
      WAIT FOR clk_period * 6;
      

   END PROCESS;

   reset_test : PROCESS
   BEGIN

      reset <= '0';
      WAIT FOR clk_period * 106;
      reset <= '1';
      WAIT FOR clk_period * 2;

   END PROCESS;
END;