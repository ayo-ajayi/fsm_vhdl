--  3-bit serial sequence detector
-- desc: detects "111" pattern among bit entries
-- author: ayomide ajayi

library ieee;
use ieee.std_logic_1164.all;

entity sq_detector is
port(err: out std_logic;
    din,clk,nReset :in std_logic);
end entity;

architecture sq_detector_arch of sq_detector is
    type  state_type is (s, d0is1,d1is1, d0n1, d1n1);
    signal current_state, next_state: state_type;
    begin
        mem_state_proc: process (clk, nReset)is
        begin
            if(nReset = '1')then
                current_state<=s;
            else
                if(clk'event and clk='1')then
                     current_state <= next_state;
                end if;
	        end if;
        end process;
        next_state_proc: process (current_state, din)is
            begin
                case (current_state) is
                    when (s) =>if(din='1')then
                        next_state<=d0is1;
                        else
                            next_state<=d0n1;
                        end if;
                    when(d0is1)=>if(din='1')then
                        next_state<=d1is1;
                        else
                            next_state<=d1n1;
                        end if;
                    when(d1is1)=>if(din='1' or din='0')then
                        next_state<=s;
                        end if;
                    when(d0n1)=>if(din='1' or din='0')then
                        next_state<=d1n1;
                        end if;
                    when(d1n1)=>if(din='1' or din='0')then
                        next_state<=s;
                        end if;
                    when others =>
                        null;
                end case;
            end process;
        output_state_proc: process (current_state, din)is
        begin
            case(current_state) is
                when(d1is1)=> if(din='1')then
                    err<='1';
                    else
                        err<='0';
			        end if;
                        when others=> err<='0';
                end case;
        end process;
end architecture;