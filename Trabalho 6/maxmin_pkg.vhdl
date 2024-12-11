library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package maxmin_pkg is
    type unsigned_array is array (0 to num_inputs - 1) of unsigned(num_bits - 1 downto 0);

    procedure find_min_max (
        signal data : in unsigned_array;
        signal min_val : out unsigned(num_bits - 1 downto 0);
        signal max_val : out unsigned(num_bits - 1 downto 0)
    );
end package maxmin_pkg;

package body maxmin_pkg is
    procedure find_min_max (
        signal data : in unsigned_array;
        signal min_val : out unsigned(num_bits - 1 downto 0);
        signal max_val : out unsigned(num_bits - 1 downto 0)
    ) is
    variable min, max : unsigned(bits - 1 downto 0);

    begin
        min <= data(0);
        max <= data(0);
        for i in 0 to num_inputs - 1 loop
            if data(i) < min then
                min <= data(i);
            end if;
            if data(i) > max then
                max <= data(i);
            end if;
        end loop;
        min_val <= min;
        max_val <= max;
    end procedure find_min_max;
end package body maxmin_pkg;