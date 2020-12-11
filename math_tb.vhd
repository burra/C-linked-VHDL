library ieee;
use ieee.std_logic_1164.all;

library std;
use std.textio.all;

library work;
use work.math.all;

entity math_tb is
end math_tb;

architecture logic of  math_tb is


begin

  process
           variable l : line;
        begin
          write (l, sin(60.0));
          writeline (output, l);
           write (l, divide(4.0, 2.0));
           writeline (output, l);
           wait;
        end process;

end architecture;
