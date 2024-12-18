library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.maxmin_pkg.ALL;

entity prog6 is
    generic (
        Bits : positive := 4; -- Default bit size
        Imputs : positive := 4 -- Default number of values
    );
    port (
        entrada1, entrada2, entrada3, entrada4 : in unsigned(Bits - 1 downto 0);
        min_value, max_value : out unsigned(Bits - 1 downto 0)
    );
end entity prog6;

architecture prog6 of prog6 is
    signal values : unsigned_vector(0 to Imputs - 1);
begin
    values <= (entrada1, entrada2, entrada3, entrada4);
    process (values)
    begin
        encontrar_min_max(values, Imputs, min_value, max_value);
    end process;
end architecture prog6;
