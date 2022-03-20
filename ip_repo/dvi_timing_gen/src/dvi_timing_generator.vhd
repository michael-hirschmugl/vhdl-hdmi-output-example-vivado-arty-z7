----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/19/2022 02:25:36 PM
-- Design Name: 
-- Module Name: hdmi_gen - behave
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity hdmi_gen is
    Port ( clk : in STD_LOGIC;
--           clk_125MHz : out STD_LOGIC;
--           clk_250MHz : out STD_LOGIC;
--           clk_25MHz : out STD_LOGIC;
           data : out STD_LOGIC_VECTOR (23 downto 0);
           hSync : out STD_LOGIC;
           vSync : out STD_LOGIC;
           drawArea : out STD_LOGIC;
           led0 : out STD_LOGIC);
--           led1 : out STD_LOGIC;
--           led2 : out STD_LOGIC);
end hdmi_gen;

architecture behave of hdmi_gen is

    signal clk_gen_cnt0_s : INTEGER := 0;
--    signal clk_gen_cnt1_s : INTEGER := 0;
--    signal clk_gen_cnt2_s : INTEGER := 0;
    signal clk_gen_max_s : INTEGER := 25000000;
    signal led0_out_s : STD_LOGIC := '0';
--    signal led1_out_s : STD_LOGIC := '0';
--    signal led2_out_s : STD_LOGIC := '0';
    signal CounterX_s : INTEGER := 0;  -- counts from 0 to 799
    signal CounterY_s : INTEGER := 0;  -- counts from 0 to 524
    signal hSync_s : STD_LOGIC := '0';
    signal vSync_s : STD_LOGIC := '0';
    signal drawArea_s : STD_LOGIC := '0';
--    signal clk_125MHz_s : STD_LOGIC := '0';
--    signal clk_250MHz_s : STD_LOGIC := '0';
    signal clk_25MHz_s : STD_LOGIC := '0';
--    signal clkFeedback_s : STD_LOGIC := '0';
--    signal clkLocked_s : STD_LOGIC := '0';
--    signal clk3_s : STD_LOGIC := '0';
--    signal clk4_s : STD_LOGIC := '0';
--    signal clk5_s : STD_LOGIC := '0';
    signal red_s : UNSIGNED (7 downto 0) := (others => '0');


begin

--    clk_125MHz <= clk_125MHz_s;
--    clk_250MHz <= clk_250MHz_s;
    clk_25MHz_s <= clk;
    
    data <= std_logic_vector(red_s) & "00000000" & "11111111";
    
    hSync <= hSync_s;
    vSync <= vSync_s;
    drawArea <= drawArea_s;
  
    process(clk_25MHz_s)  -- CounterX_s counts from 0 to 799
    begin
      if (rising_edge (clk_25MHz_s)) then
        if (CounterX_s = 799) then
          CounterX_s <= 0;
        else
          CounterX_s <= CounterX_s + 1;
        end if;
      end if;
    end process;
    
    process(clk_25MHz_s)  -- CounterY_s counts from 0 to 524
    begin
      if (rising_edge (clk_25MHz_s)) then
        if (CounterX_s = 799) then
          if (CounterY_s = 524) then
            CounterY_s <= 0;
            red_s <= (others => '0');
          else
            CounterY_s <= CounterY_s + 1;
            red_s <= red_s + 1;
          end if;
        end if;
      end if;
    end process;
    
    process(clk_25MHz_s)  -- hSync signal
    begin
      if (rising_edge (clk_25MHz_s)) then
        if (CounterX_s >= 656) then
          if (CounterX_s < 752) then
            hSync_s <= '1';
          else
            hSync_s <= '0';
          end if;
        else
          hSync_s <= '0';
        end if;
      end if;
    end process;
    
    process(clk_25MHz_s)  -- vSync signal
    begin
      if (rising_edge (clk_25MHz_s)) then
        if (CounterY_s >= 490) then
          if (CounterY_s < 492) then
            vSync_s <= '1';
          else
            vSync_s <= '0';
          end if;
        else
          vSync_s <= '0';
        end if;
      end if;
    end process;
    
    process(clk_25MHz_s)  -- drawArea signal
    begin
      if (rising_edge (clk_25MHz_s)) then
        if (CounterX_s < 640) then
          if (CounterY_s < 480) then
            drawArea_s <= '1';
          else
            drawArea_s <= '0';
          end if;
        else
          drawArea_s <= '0';
        end if;
      end if;
    end process;

    led0 <= led0_out_s;
--    led1 <= led1_out_s;
--    led2 <= led2_out_s;
    
    process(clk_25MHz_s)  -- toggle led0
    begin
      if (rising_edge (clk_25MHz_s)) then
        if clk_gen_cnt0_s = clk_gen_max_s then
          clk_gen_cnt0_s <= 0;
          if (led0_out_s = '1') then
            led0_out_s <= '0';
          else
            led0_out_s <= '1';
          end if;
        else
          clk_gen_cnt0_s <= clk_gen_cnt0_s + 1;
        end if;
      end if;
    end process;
    
--    process(clk_250MHz_s)  -- toggle led1
--    begin
--      if (rising_edge (clk_250MHz_s)) then
--        if clk_gen_cnt1_s = clk_gen_max_s then
--          clk_gen_cnt1_s <= 0;
--          if (led1_out_s = '1') then
--            led1_out_s <= '0';
--          else
--            led1_out_s <= '1';
--          end if;
--        else
--          clk_gen_cnt1_s <= clk_gen_cnt1_s + 1;
--        end if;
--      end if;
--    end process;
    
--    process(clk_25MHz_s)  -- toggle led2
--    begin
--      if (rising_edge (clk_25MHz_s)) then
--        if clk_gen_cnt2_s = clk_gen_max_s then
--          clk_gen_cnt2_s <= 0;
--          if (led2_out_s = '1') then
--            led2_out_s <= '0';
--          else
--            led2_out_s <= '1';
--          end if;
--        else
--          clk_gen_cnt2_s <= clk_gen_cnt2_s + 1;
--        end if;
--      end if;
--    end process;
    
--    PLLE2_BASE_inst : PLLE2_BASE
--     generic map (
--        BANDWIDTH => "OPTIMIZED",  -- OPTIMIZED, HIGH, LOW
--        CLKFBOUT_MULT => 10,        -- Multiply value for all CLKOUT, (2-64)
--        CLKFBOUT_PHASE => 0.0,     -- Phase offset in degrees of CLKFB, (-360.000-360.000).
--        CLKIN1_PERIOD => 0.0,      -- Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
--        -- CLKOUT0_DIVIDE - CLKOUT5_DIVIDE: Divide amount for each CLKOUT (1-128)
--        CLKOUT0_DIVIDE => 10,
--        CLKOUT1_DIVIDE => 5,
--        CLKOUT2_DIVIDE => 50,
--        CLKOUT3_DIVIDE => 1,
--        CLKOUT4_DIVIDE => 1,
--        CLKOUT5_DIVIDE => 1,
--        -- CLKOUT0_DUTY_CYCLE - CLKOUT5_DUTY_CYCLE: Duty cycle for each CLKOUT (0.001-0.999).
--        CLKOUT0_DUTY_CYCLE => 0.5,
--        CLKOUT1_DUTY_CYCLE => 0.5,
--        CLKOUT2_DUTY_CYCLE => 0.5,
--        CLKOUT3_DUTY_CYCLE => 0.5,
--        CLKOUT4_DUTY_CYCLE => 0.5,
--        CLKOUT5_DUTY_CYCLE => 0.5,
--        -- CLKOUT0_PHASE - CLKOUT5_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
--        CLKOUT0_PHASE => 0.0,
--        CLKOUT1_PHASE => 0.0,
--        CLKOUT2_PHASE => 0.0,
--        CLKOUT3_PHASE => 0.0,
--        CLKOUT4_PHASE => 0.0,
--        CLKOUT5_PHASE => 0.0,
--        DIVCLK_DIVIDE => 1,        -- Master division value, (1-56)
--        REF_JITTER1 => 0.0,        -- Reference input jitter in UI, (0.000-0.999).
--        STARTUP_WAIT => "FALSE"    -- Delay DONE until PLL Locks, ("TRUE"/"FALSE")
--     )
--     port map (
--        -- Clock Outputs: 1-bit (each) output: User configurable clock outputs
--        CLKOUT0 => clk_125MHz_s,   -- 1-bit output: CLKOUT0
--        CLKOUT1 => clk_250MHz_s,   -- 1-bit output: CLKOUT1
--        CLKOUT2 => clk_25MHz_s,   -- 1-bit output: CLKOUT2
--        CLKOUT3 => clk3_s,   -- 1-bit output: CLKOUT3
--        CLKOUT4 => clk4_s,   -- 1-bit output: CLKOUT4
--        CLKOUT5 => clk5_s,   -- 1-bit output: CLKOUT5
--        -- Feedback Clocks: 1-bit (each) output: Clock feedback ports
--        CLKFBOUT => clkFeedback_s, -- 1-bit output: Feedback clock
--        LOCKED => clkLocked_s,     -- 1-bit output: LOCK
--        CLKIN1 => clk,     -- 1-bit input: Input clock
--        -- Control Ports: 1-bit (each) input: PLL control ports
--        PWRDWN => '0',     -- 1-bit input: Power-down
--        RST => '0',           -- 1-bit input: Reset
--        -- Feedback Clocks: 1-bit (each) input: Clock feedback ports
--        CLKFBIN => clkFeedback_s    -- 1-bit input: Feedback clock
--     );

end behave;
