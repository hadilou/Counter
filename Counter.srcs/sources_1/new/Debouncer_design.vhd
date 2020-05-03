----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.11.2019 18:25:03
-- Design Name: 
-- Module Name: Debouncer_design - Behavioral
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

entity Debouncer_design is
    Port ( clock_100MHz : in STD_LOGIC;
           reset : in STD_LOGIC;
           button : in STD_LOGIC;
           enable_pulse : out STD_LOGIC;
           C_out : out STD_LOGIC_VECTOR (3 downto 0));
end Debouncer_design;

architecture Behavioral of Debouncer_design is

    signal Q: std_logic_vector(3 downto 0); 
    signal button_buf1 : std_logic;
    signal button_buf2 : std_logic;
    signal button_pulse : std_logic;
    signal clock_1MHz: std_logic;
    signal counter: integer range 0 to 999999;
    signal filtered_button,delay1,delay2,delay3,delay4 : std_logic;
    signal cnt_shift: std_logic_vector(3 downto 0);

begin

-- clock division
process (clock_100MHz)
begin
   if clock_100MHz'event and clock_100MHz = '1' then 
      if counter < 999999 then
         counter <= counter + 1;
         clock_1MHz <= '0';
      else
         counter <= 0;
         clock_1MHz <= '1';
      end if;
      
   end if;
end process;

button_debouncing:process(clock_100MHz)
begin
  if reset ='1' then
     delay1 <= '0';
     delay2 <= '0';
     delay3 <= '0';
     delay4 <= '0';
  elsif clock_100MHz'event and clock_100MHz = '1' then
    if clock_1MHz = '1' then
     delay1<=button;
     delay2<=delay1;
     delay3<=delay2;
     delay4<=delay3;
    end if;
  end if;  
end process;

filtered_button<=delay1 and delay2 and delay3 and delay4; 

-- button pulse detection
button_buf1 <= filtered_button when rising_edge(clock_100MHz);
button_buf2 <= button_buf1 when rising_edge(clock_100MHz);
button_pulse <= button_buf1 and not button_buf2;

enable_pulse <= button_pulse;

---- button pressed detection and counting section
process (clock_100MHz)

 begin
    if clock_100MHz'event and clock_100MHz = '1' then
      if reset = '1' then
        Q <= "0000";
       elsif button_pulse = '1' then 
         Q <= std_logic_vector(unsigned(Q) + 1);
       end if;
    end if;
end process;
 C_out <= Q;
end Behavioral;