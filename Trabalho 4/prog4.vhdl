library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity prog4 is
 generic (
        S : integer := 2; -- Número de bits de seleção
        M : integer := 8  -- Número de bits por entrada
    );
    port (
        entradas : in  std_logic_vector((2**S)*M-1 downto 0); -- Entradas
        selecao  : in  std_logic_vector(S-1 downto 0);        -- Bits de seleção
        saida    : out std_logic_vector(M-1 downto 0)         -- Saída
    );
end prog4;

architecture prog4 of prog4 is
  signal selected_input : std_logic_vector(M-1 downto 0);
begin
    process(selecao)
    begin
        selected_input <= (others => '0');
        for i in 0 to (2**S)-1 loop
            if to_integer(unsigned(selecao)) = i then
                selected_input <= entradas((i+1)*M-1 downto i*M);
            end if;
        end loop;
    end process;

    saida <= selected_input;
end prog4;
