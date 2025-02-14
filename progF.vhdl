library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

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
        seg_result : out std_logic_vector (7 downto 0)
    );
end progF;

architecture progF_arch of progF is
    signal a, b : unsigned (3 downto 0);
    signal result : unsigned (7 downto 0);
    signal tens, ones : unsigned (3 downto 0);

    function bin_to_7seg(bin : std_logic_vector (3 downto 0)) return std_logic_vector is
    begin
        case bin is
            when "0000" => return "01000000"; -- 0
            when "0001" => return "01111001"; -- 1
            when "0010" => return "00100100"; -- 2
            when "0011" => return "00110000"; -- 3
            when "0100" => return "00011001"; -- 4
            when "0101" => return "00010010"; -- 5
            when "0110" => return "00000010"; -- 6
            when "0111" => return "01111000"; -- 7
            when "1000" => return "00000000"; -- 8
            when "1001" => return "00010000"; -- 9
            when others => return "11111111"; -- Desligado
        end case;
    end function;

begin
    process(confirm)
        variable temp_result : unsigned(7 downto 0);
        variable temp_tens, temp_ones : unsigned(3 downto 0);
    begin
        if rising_edge(confirm) then
            a <= unsigned(sw_a);
            b <= unsigned(sw_b);
            
            case op_sel is
                when "00" =>  -- Adição
                    temp_result := resize(a + b, 8);
                    seg_singnal <= "01000000"; -- "+" no display
                when "01" =>  -- Subtração
                    if a >= b then
                        temp_result := resize(a - b, 8);
                    else
                        temp_result := resize(b - a, 8);
                    end if;
                    seg_singnal <= "01111001"; -- "-" no display
                when "10" =>  -- Multiplicação
                    temp_result := resize(a * b, 8);
                    seg_singnal <= "00100100"; -- "x" no display
                when "11" =>  -- Divisão
                    if b /= 0 then
                        temp_result := resize(a / b, 8);
                    else
                        temp_result := (others => '0');
                    end if;
                    seg_singnal <= "00110000"; -- "/" no display
                when others =>
                    temp_result := (others => '0');
            end case;

            -- Conversão para BCD
            temp_ones := resize(temp_result mod 10, 4);
            temp_tens := resize((temp_result / 10) mod 10, 4);
            
            -- Atribuir valores aos sinais
            result <= temp_result;
            ones <= temp_ones;
            tens <= temp_tens;
        end if;
    end process;

    -- Atualiza os displays de 7 segmentos
    seg_a <= bin_to_7seg(std_logic_vector(a));
    seg_b <= bin_to_7seg(std_logic_vector(b));
    seg_result1 <= bin_to_7seg(std_logic_vector(ones)); -- Display da unidade
    seg_result <= bin_to_7seg(std_logic_vector(tens)); -- Display da dezena
end progF_arch;
