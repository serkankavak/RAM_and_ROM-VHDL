library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rom is
Port ( clk_rom 		: in  std_logic;
       cs_rom 		: in  std_logic;
       read_rom 	: in  std_logic;
       ad_rom 		: in  std_logic_vector (9 downto 0);
       rddata 		: out  std_logic_vector (31 downto 0));
end rom;

architecture Behavioral of rom is

type reg_type is array (0 to 1023) of std_logic_vector (31 downto 0);
signal reg: reg_type := ( X"0000_0001", X"0000_0002", X"0000_0003", X"0000_0004", X"0000_0005", X"0000_0006", X"0000_0007", X"0000_0008",
                          X"0000_0009", X"0000_000A", X"0000_000B", X"0000_000C", X"0000_000D", X"0000_000E", X"0000_0010", X"0000_0011",
                          X"0000_0012", X"0000_0013", X"0000_0014", X"0000_0015", X"0000_0016", X"0000_0017", X"0000_0018", X"0000_0019",
                          others => X"0000_1111");

begin

--rddata <= reg(to_integer(unsigned(ad_rom)));

process(clk_rom)
begin
    if(clk_rom'event and clk_rom ='1') then
        if (cs_rom = '1' and read_rom = '1') then
            rddata <= reg(to_integer(unsigned(ad_rom)));
        end if;
    end if;
end process;

end Behavioral;
