library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.maxmin_pkg.all;

entity prog6 is
    generic (
        imputs : integer := 4;
        bits : integer := 8
    );
    port (
        entrada1, entrada2, entrada3, entrada4 : in unsigned(bits - 1 downto 0);
        min_val, max_val : out unsigned(bits - 1 downto 0)
    );
end entity prog6;

architecture prog6 of prog6 is
    signal x : unsigned_array(0 to  imputs - 1)(bits - 1 downto 0);
begin
    x <= (entrada1, entrada2, entrada3, entrada4);
    find_min_max(x, min_val, max_val);

end architecture prog6;
