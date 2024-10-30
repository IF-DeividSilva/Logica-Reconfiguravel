 library ieee ; −− Importando a biblioteca ieee
 use ieee.std logic1164.all ;
 −− −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
 entity projeto1 is −− entidade do projeto
 port (
 a , b: in bit ; −− declaracao das entradas
 z , h, k, w, v,m,p,x: out bit −− declaracao das saidas
 ) ;
 end entity ;
 −− −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
 architecture projeto1 of projeto1 is −− codigo do programa
 begin
 −−z esta recebendo a saida da operacao ”a” and ”b”
 z <= a and b;
 −−v esta recebendo a saida da operacao negacao ”a”
 v <= not a;
 −−p esta recebendo a saida da operacao negacao ”b”
 p <= not b;
 −−x esta recebendo a saida da operacao ”a” or ”b”
 x <= a or b;
 −−w esta recebendo a saida da operacao ”a” negacao and ”b”
 w <= a nand b;
 −−h esta recebendo a saida da operacao ”a” negacao or ”b”
 h <= a nor b;
 −−m esta recebendo a saida da operacao ”a” or exclusivo ”b”
 m<= a xor b;
 1
−−k esta recebendo a saida da operacao ”a” or exclusivo negado ”b”
 k <= a xnor b;
 end architecture ;
 −− −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
