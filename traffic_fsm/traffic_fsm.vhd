library ieee;
use ieee.std_logic_1164.all;

entity traffic is
    port (
        t, clk, nReset : in std_logic;
        lr, ly, lg : out std_logic);
end traffic;

architecture traffic_arch of traffic is
    type state_type is (sr, sy, sg);
    signal current_state, next_state : state_type;
begin

    next_state_proc : process (current_state, t) is
    begin
        case(current_state) is
            when(sr) => if (t = '1') then
            next_state <= sy;
        end if;
        when(sy) => if (t = '1') then
        next_state <= sg;
    end if;
    when(sg) => if (t = '1') then
    next_state <= sr;
end if;
when others => next_state <= current_state;
end case;
end process;

memory_state_proc : process (nReset, clk) is
begin
    if (nReset = '1') then
        current_state <= sr;
    else
        if (clk'event and clk = '1') then
            current_state <= next_state;
        end if;
    end if;
end process;

output_state_proc : process (current_state, t)is
begin
    case(current_state)is
        when(sr) => if (t = '0') then
        lr <= '1';
        ly <= '0';
        lg <= '0';
    end if;
    when(sy) => if (t = '0') then
        lr <= '0';
        ly <= '1';
        lg <= '0';
        end if;
    when(sg) => if (t = '0') then
        lr <= '0';
        ly <= '0';
        lg <= '1';
    end if;
    when others=> 
        lr <= '0';
        ly <= '0';
        lg <= '0';
end case;
end process;
end architecture;