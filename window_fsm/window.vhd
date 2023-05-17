library ieee;
use ieee.std_logic_1164.all;

entity window is
    port (
        nreset, clk, press : in std_logic;
        open_cw, close_ccw : out std_logic);
end entity;

architecture window_fsm_arch of window is
    type state_type is (s_open, s_close);
    signal current_state, next_state : state_type;
begin
    state_memory_proc : process (nreset, clk) is
    begin
        if (nreset = '0') then
            current_state <= s_close;
        else
            if (clk'event and clk = '1') then
                current_state <= next_state;
            end if;
        end if;
    end process;

    next_state_proc : process (current_state, press) is
    begin
        next_state <= current_state;
        case(current_state)is
            when s_open =>
            if (press = '1') then
                next_state <= s_close;
            end if;
            when s_close =>
            if (press = '1') then
                next_state <= s_open;
            end if;
            when others =>
            next_state <= s_close;
        end case;
    end process;

    output_logic_proc : process (current_state, press) is
    begin
        case(current_state) is
            when s_open =>
            if (press = '1') then
                open_cw <= '0';
                close_ccw <= '1';
            end if;
            when s_close =>
            if (press = '1') then
                open_cw <= '1';
                close_ccw <= '0';
            end if;
            when others => open_cw <= '0';
            close_ccw <= '0';
        end case;
    end process;
end architecture;