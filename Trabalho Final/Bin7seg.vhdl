library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package Bin7seg is
    function bin_to_7seg(bin : std_logic_vector (3 downto 0)) ...
    ...return std_logic_vector;
end package Bin7seg ;

package body Bin7seg is
    function bin_to_7seg(bin : std_logic_vector (3 downto 0)) ...
    ...return std_logic_vector is
    begin
        case bin is
            when "0000" => return "11000000"; -- 0
            when "0001" => return "11111001"; -- 1
            when "0010" => return "10100100"; -- 2
            when "0011" => return "10110000"; -- 3
            when "0100" => return "10011001"; -- 4
            when "0101" => return "10010010"; -- 5
            when "0110" => return "10000010"; -- 6
            when "0111" => return "11111000"; -- 7
            when "1000" => return "10000000"; -- 8
            when "1001" => return "10010000"; -- 9
            when others => return "11111111"; -- Desligado
        end case;
    end function;
end package body Bin7seg ;
