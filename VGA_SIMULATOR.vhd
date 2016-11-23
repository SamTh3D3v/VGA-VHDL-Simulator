------------------------------------------------------------
-- VGA Simulator projet VHDL
-- The whole system implementation that holds the three modules 
-- Elhamer Oussama abdelkhalek 
-- Generate a picture, save if on a spesific location on the disk, and generate the corresponding H_Sync and V_Sync
-- the three modules are setted with the 640 * 480 resolution
------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity VGA_SIMULATOR is
    Port ( Reset : in  STD_LOGIC;	        
           H_SYNC : inout  STD_LOGIC;
           V_SYNC : inout  STD_LOGIC );
end VGA_SIMULATOR;

architecture Behavioral of VGA_SIMULATOR is

component VGA is
    generic ( V_SIZE, H_SIZE : integer);
    Port ( Reset : in  STD_LOGIC;
           Pixel_clk : inout  STD_LOGIC;
           H_SYNC : inout  STD_LOGIC;
           V_SYNC : inout  STD_LOGIC);
end component;
component MIRE is
    generic ( V_SIZE, H_SIZE : integer);
    Port ( Reset : in  STD_LOGIC;
           Pixel_clk : in  STD_LOGIC;
           R : out  STD_LOGIC_VECTOR (7 downto 0);
           G : out  STD_LOGIC_VECTOR (7 downto 0);
           B : out  STD_LOGIC_VECTOR (7 downto 0));
end component;
component image_file is
  generic ( V_SIZE, H_SIZE : integer);
  port ( clk, reset : in std_logic;
         r,g,b      : in std_logic_vector);
end component;
signal Pix_sig : std_logic;
signal R_sig : std_logic_vector(7 downto 0) ;
signal G_sig : std_logic_vector(7 downto 0);
signal B_sig : std_logic_vector(7 downto 0);


begin

VGA_Module : VGA generic map (V_SIZE => 480, H_SIZE => 640) port map (Reset, Pix_sig, H_SYNC, V_SYNC);
MIRE_Module : MIRE generic map (V_SIZE => 480, H_SIZE => 640) port map (Reset, Pix_sig, R_sig, G_sig, B_sig);
SAVE_IMAGE_MODULE : image_file generic map (V_SIZE =>480, H_SIZE => 640) port map (Pix_sig, Reset, R_sig, G_sig, B_sig);

end Behavioral;

