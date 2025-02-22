library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Bin7seg.ALL;

entity progF is
    Port (
        sw_a : in std_logic_vector (3 downto 0);
        sw_b : in std_logic_vector (3 downto 0);
        op_sel : in std_logic_vector (1 downto 0);
        confirm : in std_logic;
        seg_a : out std_logic_vector (7 downto 0);
        seg_b : out std_logic_vector (7 downto 0);
        seg_singnal : out std_logic_vector (7 downto 0);
        seg_result1 : out std_logic_vector (7 downto 0);
        seg_result : out std_logic_vector (7 downto 0);
        seg_result2 : out std_logic_vector (7 downto 0)
    );
end progF;

architecture progF of progF is
    signal a, b : unsigned (3 downto 0);
    signal result : unsigned (7 downto 0);
    signal tens, ones : unsigned (3 downto 0);

begin
    process(confirm)
        variable temp_result : unsigned(7 downto 0);
        variable temp_tens, temp_ones : unsigned(3 downto 0);
    begin
        if rising_edge(confirm) then
            a <= unsigned(sw_a);
            b <= unsigned(sw_b);
            
            case op_sel is
                when "00" =>  -- add
                    temp_result := resize(a + b, 8);
                    seg_singnal <= "11000000"; -- "+" no display
                    seg_result2 <= "11111111";
                when "01" =>  -- Sub
                    if a >= b then
                        temp_result := resize(a - b, 8);
                        seg_result2 <= "11111111";
                    else
                        temp_result := resize(b - a, 8);
                        seg_result2 <= "10111111";
                    end if;
                    seg_singnal <= "11111001"; -- "-" no display
                when "10" =>  -- Mult
                    temp_result := resize(a * b, 8);
                    seg_singnal <= "00100100"; -- "x" no display
                    seg_result2 <= "11111111";
                when "11" =>  -- Div
                    if b /= 0 then
                        temp_result := resize(a / b, 8);
                    else
                        temp_result := (others => '0');
                    end if;
                    seg_singnal <= "00110000"; -- "/" no display
                    seg_result2 <= "11111111";
                when others =>
                    temp_result := (others => '0');
            end case;

            -- Conversao para BCD
            temp_ones := resize(temp_result mod 10, 4);
            temp_tens := resize((temp_result / 10), 4);
            
            -- Atribuir valores aos sinais
            ones <= temp_ones;
            tens <= temp_tens;
        end if;
    end process;

    -- Atualiza os displays de 7 segmentos
    seg_a <= bin_to_7seg(std_logic_vector(a));
    seg_b <= bin_to_7seg(std_logic_vector(b));
    seg_result1 <= bin_to_7seg(std_logic_vector(ones)); -- unidade
    seg_result <= bin_to_7seg(std_logic_vector(tens)); -- dezena
end progF;
