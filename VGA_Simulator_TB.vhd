------------------------------------------------------------
-- mini-projet VHDL
-- Le testBench du systemE de simulation d'un VGA 
-- Elhamer Oussama abdelkhalek 
-- après 1 ms le système declanche en mettant Reset a '0'
------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY VGA_Simulator_TB IS
END VGA_Simulator_TB;
 
ARCHITECTURE behavior OF VGA_Simulator_TB IS     
 
    COMPONENT VGA_SIMULATOR
    PORT(
         Reset : IN  std_logic;         
         H_SYNC : INOUT  std_logic;
         V_SYNC : INOUT  std_logic
        );
    END COMPONENT;
    
   
   signal Reset : std_logic := '1' ;   
	
   signal H_SYNC : std_logic := '0';
   signal V_SYNC : std_logic := '0';   
 
BEGIN
	
   uut: VGA_SIMULATOR PORT MAP (
          Reset => Reset,          
          H_SYNC => H_SYNC,
          V_SYNC => V_SYNC
        );

   -- Processus de simulation
   proc_simulation: process (Reset)
   begin		                  				 
      Reset <= '0' after 1ms ;		
		--Reset <= '1' after 16.223ms;  -- the time to get one picture    
   end process;

END;
