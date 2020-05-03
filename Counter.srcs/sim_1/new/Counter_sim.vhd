----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.11.2019 18:18:32
-- Design Name: 
-- Module Name: Counter_sim - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter_sim is
--  Port ( );
end Counter_sim;

architecture Behavioral of Counter_sim is

component Counter_design is
    Port ( clock_100MHz : in STD_LOGIC;
           reset : in std_logic;
           button : in STD_LOGIC;
           C_out : out STD_LOGIC_VECTOR (3 downto 0);
           enable_pulse : out STD_LOGIC);  
end component;
      
     signal enable_pulse_tb : std_logic;
     signal C_out_tb : STD_LOGIC_VECTOR (3 downto 0);
     signal clock_100MHz_tb : STD_LOGIC;
     signal reset_tb : STD_LOGIC;
     signal button_tb : STD_LOGIC;
     
begin

uut: Counter_design
port map( clock_100MHz => clock_100MHz_tb,
          reset => reset_tb,
          button =>button_tb,
          enable_pulse => enable_pulse_tb,
          C_out => C_out_tb);
          
          
clock: process
begin
clock_100MHz_tb <= '0';
wait for 4 ns;
clock_100MHz_tb <= '1';
wait for 4 ns;
end process;

rst: process
begin
reset_tb <= '0';
wait for 1 ns;
reset_tb <= '1';
wait for 10 ns;
reset_tb <= '0';
wait for 300 ns;
end process;
     
     
btn: process
begin
button_tb <= '1';
wait for 10 ns;
button_tb <= '0';
wait for 40 ns;
end process;
             
end Behavioral;