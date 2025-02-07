-- ------------------------------------
library ieee;   -- Importando a biblioteca ieee
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- ------------------------------------
entity prog3 is
    port (
        a: in std_logic_vector(3 downto 0);
		  b: in std_logic_vector(3 downto 0);
        z1: out std_logic_vector(7 downto 0);
        z2: out std_logic_vector(7 downto 0)
    );
end entity;
-- ------------------------------------
architecture prog3 of prog3 is
begin
    z1 <= "01000000" when a = "0000" else -- 0
			 "01111001" when a = "0001" else -- 1
"00100100" when a = "0010" else -- 2
"00110000" when a = "0011" else -- 3
"00011001" when a = "0100" else -- 4
"00010010" when a = "0101" else -- 5
"00000010" when a = "0110" else -- 6
"01111000" when a = "0111" else -- 7
"00000000" when a = "1000" else -- 8
"00010000" when a = "1001" else -- 9
"00000110";                     -- ERRO

    z2 <= "01000000" when b = "0000" else -- 0
			 "01111001" when b = "0001" else -- 1
			"00100100" when  b= "0010" else -- 2
			"00110000" when b = "0011" else -- 3
			"00011001" when b = "0100" else -- 4
			"00010010" when b = "0101" else -- 5
			"00000010" when b = "0110" else -- 6
			"01111000" when b = "0111" else -- 7
			"00000000" when b = "1000" else -- 8
			"00010000" when b = "1001" else -- 9
          "00000110";                     -- ERRO
end architecture;
-- ------------------------------------
