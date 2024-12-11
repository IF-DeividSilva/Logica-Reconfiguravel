library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity prog4 is
generic (
        seletor : integer := 2; --Numero de bits seletor
        imput : integer := 2  -- Número de bits por entrada
    );
    port (
        Selector : in STD_LOGIC_VECTOR(seletor-1 downto 0); -- Seletor
        X : in STD_LOGIC_VECTOR(imput*2**seletor-1 downto 0); -- Entradas do multiplexador
        Y : out STD_LOGIC_VECTOR(imput-1 downto 0); -- Saída do multiplexador
  LED: out STD_LOGIC_VECTOR(9-seletor downto 0) -- Saída do multiplexador
    );
end prog4;

architecture prog4 of prog4 is
begin
    
    Y <= X((to_integer(unsigned(Seletor)) * imput) + imput - 1 downto to_integer(unsigned(Selector)) * imput);
 LED <= (others=>'0');
end prog4;
