------------------------------------------------------------
-- VGA SimuLator projet VHDL
-- Save a picture to a spesific location on the disk
-- S. Rubini, septembre 2015 
-- save one picture after the Reset is seted using the sun raster format
-- no control uppon the count of pixels
------------------------------------------------------------

library ieee;
library std;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use std.all;

entity image_file is
  generic ( V_SIZE, H_SIZE : integer);
  port ( clk, reset : in std_logic;
         r,g,b      : in std_logic_vector(7 downto 0));
end image_file;

architecture test of image_file is
type IntegerFileType is file of character ;
file data_out : IntegerFileType;
signal byte_count : integer :=0;
signal wr, wb, wg : std_logic_vector(31 downto 0) := X"00000000";

function byte_reverse(w : in integer) return integer is
variable w_in, w_out : std_logic_vector(31 downto 0);
begin
        w_in := conv_std_logic_vector(w, 32);
        w_out(31 downto 24) := w_in(7 downto 0);
        w_out(23 downto 16) := w_in(15 downto 8);
        w_out(15 downto 8) := w_in(23 downto 16);
        w_out(7 downto 0) := w_in(31 downto 24);
        return conv_integer(w_out);
end byte_reverse;

begin

entete : process(reset)
variable status: FILE_OPEN_STATUS;
variable c : character;
variable w : std_logic_vector(31 downto 0);
begin
  if reset='1' then
  FILE_OPEN(status, data_out, "MireResultante.im8", write_mode);
  w := X"59a66a95";
  c := character'val(conv_integer(unsigned(w(31 downto 24))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(23 downto 16))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(15 downto 8))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(7 downto 0))));
  write(data_out, c); 

  w := conv_std_logic_vector(H_SIZE,32);
  c := character'val(conv_integer(unsigned(w(31 downto 24))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(23 downto 16))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(15 downto 8))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(7 downto 0))));
  write(data_out, c); 

  w := conv_std_logic_vector(V_SIZE,32);
  c := character'val(conv_integer(unsigned(w(31 downto 24))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(23 downto 16))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(15 downto 8))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(7 downto 0))));
  write(data_out, c); 

  w := conv_std_logic_vector(24,32);
  c := character'val(conv_integer(unsigned(w(31 downto 24))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(23 downto 16))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(15 downto 8))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(7 downto 0))));
  write(data_out, c); 

  w := conv_std_logic_vector(H_SIZE*V_SIZE*3,32);
  c := character'val(conv_integer(unsigned(w(31 downto 24))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(23 downto 16))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(15 downto 8))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(7 downto 0))));
  write(data_out, c); 

  w := conv_std_logic_vector(1,32);
  c := character'val(conv_integer(unsigned(w(31 downto 24))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(23 downto 16))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(15 downto 8))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(7 downto 0))));
  write(data_out, c); 

  w := conv_std_logic_vector(0,32);
  c := character'val(conv_integer(unsigned(w(31 downto 24))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(23 downto 16))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(15 downto 8))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(7 downto 0))));
  write(data_out, c); 

  w := conv_std_logic_vector(0,32);
  c := character'val(conv_integer(unsigned(w(31 downto 24))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(23 downto 16))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(15 downto 8))));
  write(data_out, c); 
  c := character'val(conv_integer(unsigned(w(7 downto 0))));
  write(data_out, c); 

  end if;
end process;

process(clk)
variable c : character;
begin
	if reset= '0' and falling_edge(clk) then
			c := character'val(conv_integer(unsigned(r)));
			write(data_out, c); 
			c := character'val(conv_integer(unsigned(g)));
			write(data_out, c); 
			c := character'val(conv_integer(unsigned(b)));
			write(data_out, c); 
	end if;
end process;
end test;


