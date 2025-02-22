library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity prog8 is
    generic (
        FrequenciaClockHz : integer := 50_000_000 
    );
    Port (
        clk : in STD_LOGIC; 
        reset : in STD_LOGIC; 
        pause : in STD_LOGIC; 
        teste : in STD_LOGIC; 
        semaforo_1 : out STD_LOGIC_VECTOR(2 downto 0); 
        semaforo_2 : out STD_LOGIC_VECTOR(2 downto 0) 
    );
end prog8;

architecture prog8 of prog8 is
    type EstadoSemaforo is (Vermelho, Amarelo, Verde, AmareloOff, AmareloOn);
    signal estado_atual_1, proximo_estado_1 : EstadoSemaforo;  
    signal estado_atual_2, proximo_estado_2 : EstadoSemaforo; 
    constant FrequenciaMaquinaEstadoHz : integer := 1;
begin
    process(clk, reset)
        variable contador : integer := 0; 
        variable contadorTempo : integer := 0; 
        variable PassosMaquinaEstado : integer := FrequenciaClockHz / 2; 
    begin
        if teste = '0' then
            PassosMaquinaEstado := FrequenciaClockHz;
            contadorTempo := 0;
        else
            contadorTempo := 3;
            PassosMaquinaEstado := FrequenciaClockHz / 2;
        end if;

        if reset = '0' then
            estado_atual_1 <= Vermelho;
            estado_atual_2 <= Verde;
            contador := 0;
        elsif rising_edge(clk) then
            if contador < PassosMaquinaEstado then
                contador := contador + 1;
            else
                estado_atual_1 <= proximo_estado_1;
                estado_atual_2 <= proximo_estado_2;
                contador := 0;
            end if;
        end if;
    end process;

    process(estado_atual_1, estado_atual_2)
        variable flag_1 : integer := 1; 
        variable flag_2 : integer := 0; 
    begin
        if pause = '0' then
            case estado_atual_1 is
                when Vermelho =>
                    if flag_1 = 1 then
                        proximo_estado_1 <= Verde;
                    else
                        proximo_estado_1 <= Vermelho;
                    end if;
                when Verde =>
                    proximo_estado_1 <= Amarelo;
                    flag_2 := 0;
                when Amarelo =>
                    proximo_estado_1 <= Vermelho;
                    flag_2 := 1;
                when others =>
                    proximo_estado_1 <= Vermelho;
            end case;

            case estado_atual_2 is
                when Vermelho =>
                    if flag_2 = 1 then
                        proximo_estado_2 <= Verde;
                    else
                        proximo_estado_2 <= Vermelho;
                    end if;
                when Verde =>
                    proximo_estado_2 <= Amarelo;
                    flag_1 := 0;
                when Amarelo =>
                    proximo_estado_2 <= Vermelho;
                    flag_1 := 1;
                when others =>
                    proximo_estado_2 <= Verde;
            end case;
        else
            case estado_atual_1 is
                when AmareloOff =>
                    proximo_estado_1 <= AmareloOn;
                when others =>
                    proximo_estado_1 <= AmareloOff;
            end case;

            case estado_atual_2 is
                when AmareloOff =>
                    proximo_estado_2 <= AmareloOn;
                when others =>
                    proximo_estado_2 <= AmareloOff;
            end case;
        end if;
    end process;

    process(estado_atual_1)
    begin
        case estado_atual_1 is
            when Vermelho =>
                semaforo_1 <= "001";
            when Verde =>
                semaforo_1 <= "100";
            when Amarelo =>
                semaforo_1 <= "010";
            when AmareloOff =>
                semaforo_1 <= "000";
            when AmareloOn =>
                semaforo_1 <= "010";
        end case;
    end process;

    process(estado_atual_2)
    begin
        case estado_atual_2 is
            when Vermelho =>
                semaforo_2 <= "001";
            when Verde =>
                semaforo_2 <= "100";
            when Amarelo =>
                semaforo_2 <= "010";
            when AmareloOff =>
                semaforo_2 <= "000";
            when AmareloOn =>
                semaforo_2 <= "010";
        end case;
    end process;
end prog8;
