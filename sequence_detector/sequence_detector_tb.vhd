library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sq_detector_tb is
end;

architecture bench of sq_detector_tb is

  component sq_detector
      port (
      err : out std_logic;
      din : in std_logic;
      clk : in std_logic;
      nReset : in std_logic
    );
  end component;

  -- Clock period
  constant clk_period : time := 5 ns;
  -- Generics

  -- Ports
  signal err : std_logic;
  signal din : std_logic;
  signal clk : std_logic;
  signal nReset : std_logic;

begin

  sq_detector_inst : sq_detector
    port map (
      err => err,
      din => din,
      clk => clk,
      nReset => nReset
    );

--   clk_process : process
--   begin
--   clk <= '1';
--   wait for clk_period/2;
--   clk <= '0';
--   wait for clk_period/2;
--   end process clk_process;

end;
