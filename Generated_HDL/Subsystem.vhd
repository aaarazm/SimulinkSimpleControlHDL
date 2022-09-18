-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\simpleController\Subsystem.vhd
-- Created: 2022-09-04 18:04:56
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
-- Module: Subsystem
-- Source Path: simpleController/Subsystem
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Subsystem IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        In2                               :   IN    std_logic_vector(31 DOWNTO 0);  -- single
        ce_out                            :   OUT   std_logic;
        Out1                              :   OUT   std_logic_vector(31 DOWNTO 0);  -- single
        Out2                              :   OUT   std_logic_vector(31 DOWNTO 0)  -- single
        );
END Subsystem;


ARCHITECTURE rtl OF Subsystem IS

  -- Component Declarations
  COMPONENT nfp_sub_single
    PORT( nfp_in1                         :   IN    std_logic_vector(31 DOWNTO 0);  -- single
          nfp_in2                         :   IN    std_logic_vector(31 DOWNTO 0);  -- single
          nfp_out                         :   OUT   std_logic_vector(31 DOWNTO 0)  -- single
          );
  END COMPONENT;

  COMPONENT PI_Transfer_Function
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          In1                             :   IN    std_logic_vector(31 DOWNTO 0);  -- single
          Out1                            :   OUT   std_logic_vector(31 DOWNTO 0)  -- single
          );
  END COMPONENT;

  COMPONENT First_Order_System
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          In1                             :   IN    std_logic_vector(31 DOWNTO 0);  -- single
          Out1                            :   OUT   std_logic_vector(31 DOWNTO 0)  -- single
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : nfp_sub_single
    USE ENTITY work.nfp_sub_single(rtl);

  FOR ALL : PI_Transfer_Function
    USE ENTITY work.PI_Transfer_Function(rtl);

  FOR ALL : First_Order_System
    USE ENTITY work.First_Order_System(rtl);

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL First_Order_System_out1          : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Unit_Delay_out1                  : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Add_out1                         : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL PI_Transfer_Function_out1        : std_logic_vector(31 DOWNTO 0);  -- ufix32

BEGIN
  u_nfp_sub_comp : nfp_sub_single
    PORT MAP( nfp_in1 => In2,  -- single
              nfp_in2 => Unit_Delay_out1,  -- single
              nfp_out => Add_out1  -- single
              );

  u_PI_Transfer_Function : PI_Transfer_Function
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              In1 => Add_out1,  -- single
              Out1 => PI_Transfer_Function_out1  -- single
              );

  u_First_Order_System : First_Order_System
    PORT MAP( clk => clk,
              reset => reset,
              enb => clk_enable,
              In1 => PI_Transfer_Function_out1,  -- single
              Out1 => First_Order_System_out1  -- single
              );

  enb <= clk_enable;

  Unit_Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Unit_Delay_out1 <= X"00000000";
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Unit_Delay_out1 <= First_Order_System_out1;
      END IF;
    END IF;
  END PROCESS Unit_Delay_process;


  ce_out <= clk_enable;

  Out1 <= First_Order_System_out1;

  Out2 <= PI_Transfer_Function_out1;

END rtl;
