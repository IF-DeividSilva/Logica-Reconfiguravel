−−-−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
library ieee ; −− Importando a bibliotecaieee
use ieee.stdlogic1164.all ;
−− −−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
entity testis
port (
a , b , c , d : in bit ;
z : out bit
) ;
end entity ;
−−-−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
architecture test of testis
begin
z <= (not c and not d ) or (not a and not c ) or (not b and not d ) or (not a and not b ) or (not b and not c ) ;
end architecture ;
−−-−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
