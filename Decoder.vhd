library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity Decoder is
port(
    addr 	: in  std_logic_vector(15 downto 0);
    cs_ram 	: out  std_logic;		-- chip select RAM
    cs_rom 	: out  std_logic);		-- chip select ROM
end Decoder;

architecture Behavioral of Decoder is

begin
    cs_rom <= '1' when addr(15 downto 12) = "0000"
              else '0';
              
    cs_ram <= '1' when addr(15 downto 12) = "0001"
              else '0';

end Behavioral;
