------------------------------------------------------------
-- VGA Simulator projet VHDL
-- Generate the Pixel-clk, H_SYNC and V_SYNC clock signals 
-- Elhamer Oussama abdelkhalek 
-- Generate sync signals if Reset = '0'
-- No control uppon the amount of pixel_clk edges received
------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity VGA is    
    generic ( V_SIZE, H_SIZE : integer);
    Port ( Reset : in  STD_LOGIC;
           Pixel_clk : inout  STD_LOGIC;
           H_SYNC : inout  STD_LOGIC;
           V_SYNC : inout  STD_LOGIC);
end VGA;

architecture Behavioral of VGA is

begin

 Pixel_horloge: PROCESS (Reset, Pixel_clk) 
 variable counter : integer :=0;
 BEGIN    
  if(Reset='1') then
    Pixel_clk <='0' ;
  elsif (falling_edge(Reset)) and (Reset = '0') then
    Pixel_clk <= '1' after 8.2 us;
	 counter :=1;
  else 
   if (counter = (H_SIZE * 2)) and (Pixel_clk = '0') then
      Pixel_clk <= '1' after 8.2 us ;
		counter :=1;
	elsif (counter < (H_SIZE * 2)) then
	  Pixel_clk <= NOT Pixel_clk AFTER 20 ns; 
	  counter := counter + 1;
	end if;
 end if;
	 	  	
 END PROCESS Pixel_horloge; 
 
HSYNC: PROCESS (H_SYNC, Reset)   
 BEGIN 
 if (Reset = '1') then
  H_SYNC <= '0' ;  
 elsif falling_edge(Reset) and (Reset = '0') then
  H_SYNC <= '1' ;
 elsif(H_SYNC = '1') then
  H_SYNC <= '0' AFTER 4 us;  
 elsif(H_SYNC = '0') then
  H_SYNC <= '1' AFTER 29.8 us;  
 end if;
 END PROCESS HSYNC;
 
 VSYNC: PROCESS (V_SYNC, Reset)   
 BEGIN  
  if (Reset = '1') then
  V_SYNC <= '0' ;  
 elsif falling_edge(Reset) and (Reset = '0') then
  V_SYNC <= '1';
 elsif(V_SYNC = '1') then
  V_SYNC <= '0' AFTER 316 us;  
 elsif(V_SYNC = '0') then
  V_SYNC <= '1' AFTER 15.908 ms;  
 end if;
 END PROCESS VSYNC;
 

end Behavioral;

