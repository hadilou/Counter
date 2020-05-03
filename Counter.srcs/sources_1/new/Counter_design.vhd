----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.11.2019 18:12:46
-- Design Name: 
-- Module Name: Counter_design - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter_design is
    Port ( clock_100MHz : in STD_LOGIC;
           reset : in STD_LOGIC;
           button : in STD_LOGIC;
           enable_pulse : out STD_LOGIC;
           C_out : out STD_LOGIC_VECTOR (3 downto 0));
end Counter_design;

architecture Behavioral of Counter_design is

    signal Q: std_logic_vector(3 downto 0); 
    signal button_buf1 : std_logic;
    signal button_buf2 : std_logic;
    signal button_pulse : std_logic;

begin

    button_buf1 <= button when rising_edge(clock_100MHz);
    button_buf2 <= button_buf1 when rising_edge(clock_100MHz);
    button_pulse <= button_buf1 and not button_buf2;
    enable_pulse <= button_pulse;

process (clock_100MHz,reset,Q)

 begin
    if clock_100MHz'event and clock_100MHz = '1' then
       if reset = '1' then
         Q <= (others => '0');
       elsif button_pulse = '1' then
         Q <= std_logic_vector(unsigned(Q) + 1);
       end if;
    end if;
    C_out <= Q;
end process;

end Behavioral;
