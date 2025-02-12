library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Para operações aritméticas

entity progF is
    Port (
        sw_a : in std_logic_vector (3 downto 0); -- Entrada A
        sw_b : in std_logic_vector (3 downto 0); -- Entrada B
        op_sel : in std_logic_vector (1 downto 0); -- Seleção da operação
        confirm : in std_logic; -- Botão de confirmação
        seg_a : out std_logic_vector (7 downto 0); -- Display 7 segmentos para A
        seg_b : out std_logic_vector (7 downto 0); -- Display 7 segmentos para B
        seg_singnal : out std_logic_vector (7 downto 0); -- Display do sinal da operação
        seg_result1 : out std_logic_vector (7 downto 0); -- Display dos 4 bits menos significativos do resultado
        seg_result : out std_logic_vector (7 downto 0) -- Display dos 4 bits mais significativos do resultado
    );
end progF;

architecture progF_arch of progF is
    signal a, b : unsigned (3 downto 0);
    signal result : unsigned (7 downto 0);

    -- Função para converter binário em display de 7 segmentos
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
    begin
        if rising_edge(confirm) then
            a <= unsigned(sw_a);
            b <= unsigned(sw_b);

            case op_sel is
                when "00" =>  -- Adição
                    result <= resize(a + b, 8);
                    seg_singnal <= "01000000"; -- "+" no display

                when "01" =>  -- Subtração
                    if a >= b then
                        result <= resize(a - b, 8);
                    else
                        result <= resize(b - a, 8); -- Mantém resultado positivo
                    end if;
                    seg_singnal <= "01111001"; -- "-" no display

                when "10" =>  -- Multiplicação
                    result <= resize(a * b, 8);
                    seg_singnal <= "00100100"; -- "x" no display

                when "11" =>  -- Divisão
                    if b /= 0 then
                        result <= resize(a / b, 8);
                    else
                        result <= (others => '0'); -- Evitar divisão por zero
                    end if;
                    seg_singnal <= "00110000"; -- "/" no display

                when others =>
                    result <= (others => '0');
            end case;
        end if;
    end process;

    -- Atualiza os displays de 7 segmentos
    seg_a <= bin_to_7seg(std_logic_vector(a));
    seg_b <= bin_to_7seg(std_logic_vector(b));
    seg_result1 <= bin_to_7seg(std_logic_vector(result(3 downto 0))); -- 4 bits menos significativos
    seg_result <= bin_to_7seg(std_logic_vector(result(7 downto 4))); -- 4 bits mais significativos
end progF_arch;
