library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity twocounters_tb is
end twocounters_tb;

architecture Behavioral of twocounters_tb is

component twocounters
    Port ( rst      : in STD_LOGIC;
           clk      : in STD_LOGIC;
           count1_o : out STD_LOGIC_VECTOR (7 downto 0);
           count2_o : out STD_LOGIC_VECTOR (7 downto 0));
end component;
signal reset,clk: std_logic;
signal count1_o, count2_o : std_logic_vector(7 downto 0);

begin
dut: twocounters port map (clk => clk, rst => reset, count1_o => count1_o, count2_o => count2_o);
   -- Clock process definitions
clock_process :process
begin
     clk <= '0';
     wait for 10 ns;
     clk <= '1';
     wait for 10 ns;
end process;


-- Stimulus process
stim_proc: process
begin        
   -- hold reset state for 100 ns.
     reset <= '0';
   wait for 20 ns;    
    reset <= '1';
   wait;
end process;
end Behavioral;