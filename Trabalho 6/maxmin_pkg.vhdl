library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package maxmin_pkg is
    subtype constrained_unsigned_vector is unsigned(3 downto 0); -- Assuming 4-bit unsigned type for demonstration

    type unsigned_vector is array (natural range <>) of constrained_unsigned_vector;

    procedure encontrar_min_max(
        values : in unsigned_vector;
        Imputs : in positive;
        signal min_value, max_value : out constrained_unsigned_vector
    );
end package maxmin_pkg;

package body maxmin_pkg is
    procedure encontrar_min_max(
        values : in unsigned_vector;
        Imputs : in positive;
        signal min_value, max_value : out constrained_unsigned_vector
    ) is
        variable temp_min, temp_max : constrained_unsigned_vector;
    begin
        temp_min := values(0);
        temp_max := values(0);
        for i in 0 to Imputs - 1 loop
            if values(i) < temp_min then
                temp_min := values(i);
            end if;
            if values(i) > temp_max then
                temp_max := values(i);
            end if;
        end loop;
        min_value <= temp_min;
        max_value <= temp_max;
    end procedure;
end package body maxmin_pkg;
