----------------------------------------------------------------------------------
-- Engineer: Serkan Kavak
-- Create Date:    14:24:18 29/03/2019 
-- Module Name:    sync_mem - Behavioral 
-- Design Name:    RAM and ROM Units
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sync_mem is
	port(
		clk       : in std_logic;
		r_smem    : in std_logic;
		w_smem    : in std_logic;
		address   : in std_logic_vector(15 downto 0);
		wrdata 	  : in std_logic_vector(31 downto 0);
		rddata 	  : out std_logic_vector(31 downto 0));
end sync_mem;


architecture Behavioral of sync_mem is

component decoder 
    port ( addr 	: in  std_logic_vector(15 downto 0);
           cs_ram 	: out  std_logic;		-- chip select RAM
           cs_rom 	: out  std_logic);		-- chip select ROM
end component;

component rom 
    port ( clk_rom 		: in  std_logic;
           cs_rom 		: in  std_logic;
           read_rom 	: in  std_logic;
           ad_rom 		: in  std_logic_vector (9 downto 0);
           rddata 		: out  std_logic_vector (31 downto 0));
end component;

component ram 
    port ( clk_ram    	: in  std_logic;
		   cs_ram       : in  std_logic;
		   read_ram     : in  std_logic;
		   write_ram    : in  std_logic;
		   ad_ram		: in  std_logic_vector(9 downto 0);
		   wrdata  	    : in  std_logic_vector(31 downto 0);
		   rddata     	: out std_logic_vector(31 downto 0));
end component;

signal cs_ram_s, cs_rom_s 	    : std_logic; 
signal rddata_ram, rddata_rom	: std_logic_vector(31 downto 0);

begin

Decoder_c : decoder 
    Port map( 	
        addr 	=> address,
        cs_ram 	=> cs_ram_s,
        cs_rom	=> cs_rom_s);

Rom_c : rom 
    Port map( 
        clk_rom     => clk,	
        cs_rom  	=> cs_rom_s,
        read_rom	=> r_smem,
        ad_rom 	    => address(9 downto 0),
        rddata  	=> rddata_rom);

Ram_c : ram 
    port map(
		clk_ram		=> clk,
		cs_ram		=> cs_ram_s,
		read_ram  	=> r_smem,
		write_ram  	=> w_smem,
		ad_ram 		=> address(9 downto 0),
		wrdata  	=> wrdata,
		rddata  	=> rddata_ram);
		
rddata <= rddata_ram when cs_ram_s = '1'
          else rddata_rom;

	
end Behavioral;