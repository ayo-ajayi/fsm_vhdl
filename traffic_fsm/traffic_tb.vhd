library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity traffic_tb is
end;

architecture bench of traffic_tb is

  component traffic
      port (
      t : in std_logic;
      clk : in std_logic;
      nReset : in std_logic;
      lr : out std_logic;
      ly : out std_logic;
      lg : out std_logic
    );
  end component;

  -- Clock period
  constant clk_period : time := 5 ns;
  -- Generics

  -- Ports
  signal t : std_logic;
  signal clk : std_logic;
  signal nReset : std_logic;
  signal lr : std_logic;
  signal ly : std_logic;
  signal lg : std_logic;

begin

  traffic_inst : traffic
    port map (
      t => t,
      clk => clk,
      nReset => nReset,
      lr => lr,
      ly => ly,
      lg => lg
    );

--   clk_process : process
--   begin
--   clk <= '1';
--   wait for clk_period/2;
--   clk <= '0';
--   wait for clk_period/2;
--   end process clk_process;

end;
