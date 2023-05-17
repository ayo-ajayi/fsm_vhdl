-- author: ayomide ajayi

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity traffic is
    port (
        nReset,  clk : in std_logic;
        lr, ly, lg : out std_logic);
end traffic;

architecture traffic_arch of traffic is
    type state_type is (sr, sy, sg);
    signal current_state, next_state : state_type;
    signal cnt_int: integer:=0;
    signal t: std_logic:='0';
begin
    time_proc: process(cnt_int, clk) is
        begin
            if(clk'event and clk = '1')then
                if(cnt_int=0 or cnt_int=5 or cnt_int=10)then 
                        t<='1';
                        else
                        t<='0';
                    end if;
                    cnt_int<= cnt_int+1;
                    if(cnt_int=16)then
                        cnt_int<=0;
                    end if;
                end if;
        end process;
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