-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\simpleController\Subsystem_myTB.vhd
-- Created: 2022-09-04 18:05:00
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: 0.2
-- Target subsystem base rate: 0.2
-- 
-- 
-- Clock Enable  Sample Time
-- -------------------------------------------------------------
-- ce_out        0.2
-- -------------------------------------------------------------
-- 
-- 
-- Output Signal                 Clock Enable  Sample Time
-- -------------------------------------------------------------
-- Out1                          ce_out        0.2
-- Out2                          ce_out        0.2
-- -------------------------------------------------------------
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Subsystem_myTB
-- Source Path: 
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_textio.ALL;
USE IEEE.float_pkg.ALL;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY STD;
USE STD.textio.ALL;
USE work.Subsystem_tb_pkg.ALL;

ENTITY Subsystem_myTB IS
END Subsystem_myTB;


ARCHITECTURE rtl OF Subsystem_myTB IS

  -- Component Declarations
  COMPONENT Subsystem
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic := '0';
          clk_enable                      :   IN    std_logic := '0';
          In2                             :   IN    std_logic_vector(31 DOWNTO 0);  -- single
          ce_out                          :   OUT   std_logic;
          Out1                            :   OUT   std_logic_vector(31 DOWNTO 0);  -- single
          Out2                            :   OUT   std_logic_vector(31 DOWNTO 0)  -- single
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Subsystem
    USE ENTITY work.Subsystem(rtl);

  -- Signals
  SIGNAL clk                              : std_logic;
  SIGNAL reset                            : std_logic;
  SIGNAL clk_enable                       : std_logic;
  SIGNAL In2_1                            : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL ce_out                           : std_logic;
  SIGNAL Out1                             : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Out2                             : std_logic_vector(31 DOWNTO 0);  -- ufix32
  -- SIGNAL rectangular                           : integer := 0;


BEGIN
  u_Subsystem : Subsystem
    PORT MAP( clk => clk,
              reset => reset,
              clk_enable => clk_enable,
              In2 => In2_1,  -- single
              ce_out => ce_out,
              Out1 => Out1,  -- single
              Out2 => Out2  -- single
              );

    process is
    begin
        clk <= '1';
        wait for 5 ns;
        clk <= '0';
        wait for 5 ns;
    end process;

    process is
    begin
        reset <= '0';
        clk_enable <= '0';
        wait for 12 ns;
        reset <= '1';
        clk_enable <= '1';
        wait for 21 ns;
        reset <= '0';
        wait for 11 ns;
        In2_1 <= X"00001100";
        wait for 4000 ns;
        In2_1 <= X"00000000";
        wait for 4000 ns;
        In2_1 <= X"10000000";
        wait for 20000 ns;
        In2_1 <= X"00000000";
        wait for 20000 ns;
        In2_1 <= X"F0000000";
        wait for 20000 ns;
        In2_1 <= X"00000000";
        wait for 20000 ns;
        In2_1 <= X"40400000";
        wait for 20000 ns;
        In2_1 <= X"00000000";
        wait for 20000 ns;
        In2_1 <= X"40400000";
        wait for 20000 ns;
        In2_1 <= X"00000000";

        wait;
    end process;

    -- process is
    -- begin
    --     if rectangular = 1 then
    --         In2_1 <= X"40400000";
    --         wait for 2000 ns;
    --         In2_1 <= X"00000000";
    --         wait for 2000 ns;
    --     end if;
    -- end process;


END rtl;

