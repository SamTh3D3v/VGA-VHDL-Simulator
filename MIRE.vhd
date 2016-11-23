------------------------------------------------------------
-- VGA SimuLator projet VHDL
-- Generate RGB colors based on the Pixel-clk
-- Elhamer Oussama abdelkhalek 
-- Generate a Pixel color at each Pixel-clk rising edge
-- No control on the count of received Pixel-clk edges
------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;


entity MIRE is
    generic ( V_SIZE, H_SIZE : integer);
    Port ( Reset : in  STD_LOGIC;
           Pixel_clk : in  STD_LOGIC;
           R : out  STD_LOGIC_VECTOR (7 downto 0);
           G : out  STD_LOGIC_VECTOR (7 downto 0);
           B : out  STD_LOGIC_VECTOR (7 downto 0));
end MIRE;

architecture Behavioral of MIRE is

begin

colors: process (Pixel_clk, Reset)   
variable vcount : integer :=0;
variable  hcount : integer :=0;   
begin      
if Reset='1'          
 then 
  R <= "11111111" ; 
  G <= "11111111" ;
  B <= "11111111" ;
  vcount := 0;
  hcount := 0;  
elsif (rising_edge(Pixel_clk) and Pixel_clk='1')     
then 
   if(vcount >=0 and vcount < (V_SIZE / 3))
   then 
	      if (hcount >=0 and hcount < (H_SIZE /3) )
				then 
				R <= "11111111";
				G <= "00000000";
				B <= "00000000";	 
		   elsif (hcount >=(H_SIZE /3) and hcount <(2 * H_SIZE /3) )
				then 
				R <= "00000000";
				G <= "11111111";
				B <= "00000000";	
			elsif (hcount >=(2 * H_SIZE /3) and hcount < H_SIZE )
			   then
				R <= "00000000";
				G <= "00000000";
				B <= "11111111";	
		    end if;
	
	elsif (vcount >=( V_SIZE / 3) and vcount <( 2 * (V_SIZE / 3)))
	then
				R <= conv_std_logic_vector((hcount MOD 255),8); 
				G <= conv_std_logic_vector((hcount MOD 255),8);
				B <= conv_std_logic_vector((hcount MOD 255),8);
   elsif(vcount >=( 2 * (V_SIZE / 3)) and vcount < V_SIZE)	
   then	
		     if ((hcount / 5) MOD 2 = 0 and (vcount / 5) MOD 2 = 0 ) or
			     ((hcount / 5) MOD 2 = 1 and (vcount / 5) MOD 2 = 1 )
				then
				 R <= "11111111";
				else
				 R <= "00000000" ;
				end if;
				
				if ((hcount / 5) MOD 2 = 0 and (vcount / 5) MOD 2 = 0 ) or
			     ((hcount / 5) MOD 2 = 1 and (vcount / 5) MOD 2 = 1 )
				then
				 G <= "11111111" ;
				else
				 G <= "00000000" ;
				end if;
				
				if ((hcount / 5) MOD 2 = 0 and (vcount / 5) MOD 2 = 0 ) or
			     ((hcount / 5) MOD 2 = 1 and (vcount / 5) MOD 2 = 1 )
				then
				 B <= "11111111" ;
				else
				 B <= "00000000" ;
				end if;				 
   end if;
	if(hcount = (H_SIZE - 1)) then
      vcount := (vcount +1) MOD V_SIZE;
   end if;
   hcount := (hcount +1) MOD H_SIZE;		
end if;      
end process;

end Behavioral;

