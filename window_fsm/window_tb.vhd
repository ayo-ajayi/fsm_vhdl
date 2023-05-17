library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity window_tb is
end;

architecture bench of window_tb is

  component window
      port (
      nreset : in std_logic;
      clk : in std_logic;
      press : in std_logic;
      open_cw : out std_logic;
      close_ccw : out std_logic
    );
  end component;

  -- Clock period
  constant clk_period : time := 5 ns;
  -- Generics

  -- Ports
  signal nreset : std_logic;
  signal clk : std_logic;
  signal press : std_logic;
  signal open_cw : std_logic;
  signal close_ccw : std_logic;

begin

  window_inst : window
    port map (
      nreset => nreset,
      clk => clk,
      press => press,
      open_cw => open_cw,
      close_ccw => close_ccw
    );

--   clk_process : process
--   begin
--   clk <= '1';
--   wait for clk_period/2;
--   clk <= '0';
--   wait for clk_period/2;
--   end process clk_process;

end;
