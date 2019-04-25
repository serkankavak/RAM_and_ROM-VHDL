library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Ram is
port(
    clk_ram    	: in  std_logic;
    cs_ram      : in  std_logic;
    read_ram    : in  std_logic;
    write_ram   : in  std_logic;
    ad_ram		: in  std_logic_vector(9 downto 0);
    wrdata  	: in  std_logic_vector(31 downto 0);
    rddata  	: out std_logic_vector(31 downto 0));
end Ram;

architecture Behavioral of Ram is

type reg_type is array (0 to 1023) of std_logic_vector (31 downto 0);
signal reg: reg_type;

begin

process (clk_ram)
    begin
        if (clk_ram'event and clk_ram = '1') then
            if (cs_ram = '1' and read_ram = '1') then
                rddata <= reg(to_integer(unsigned(ad_ram)));
            end if;
            if (cs_ram = '1' and write_ram = '1') then
                reg(to_integer(unsigned(ad_ram))) <= wrdata;
            end if;
        end if;
end process;
                
    

end Behavioral;
