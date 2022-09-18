-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\simpleController\First_Order_System.vhd
-- Created: 2022-09-04 18:04:56
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: First_Order_System
-- Source Path: simpleController/Subsystem/First_Order_System
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY First_Order_System IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        In1                               :   IN    std_logic_vector(31 DOWNTO 0);  -- single
        Out1                              :   OUT   std_logic_vector(31 DOWNTO 0)  -- single
        );
END First_Order_System;


ARCHITECTURE rtl OF First_Order_System IS

  -- Component Declarations
  COMPONENT nfp_mul_single
    PORT( nfp_in1                         :   IN    std_logic_vector(31 DOWNTO 0);  -- single
          nfp_in2                         :   IN    std_logic_vector(31 DOWNTO 0);  -- single
          nfp_out                         :   OUT   std_logic_vector(31 DOWNTO 0)  -- single
          );
  END COMPONENT;

  COMPONENT nfp_add_single
    PORT( nfp_in1                         :   IN    std_logic_vector(31 DOWNTO 0);  -- single
          nfp_in2                         :   IN    std_logic_vector(31 DOWNTO 0);  -- single
          nfp_out                         :   OUT   std_logic_vector(31 DOWNTO 0)  -- single
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : nfp_mul_single
    USE ENTITY work.nfp_mul_single(rtl);

  FOR ALL : nfp_add_single
    USE ENTITY work.nfp_add_single(rtl);

  -- Signals
  SIGNAL kconst                           : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Gain1_out1                       : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL kconst_1                         : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Add_out1                         : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Gain_out1                        : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL Unit_Delay_out1                  : std_logic_vector(31 DOWNTO 0);  -- ufix32

BEGIN
  u_nfp_mul_comp : nfp_mul_single
    PORT MAP( nfp_in1 => kconst,  -- single
              nfp_in2 => In1,  -- single
              nfp_out => Gain1_out1  -- single
              );

  u_nfp_mul_comp_1 : nfp_mul_single
    PORT MAP( nfp_in1 => kconst_1,  -- single
              nfp_in2 => Add_out1,  -- single
              nfp_out => Gain_out1  -- single
              );

  u_nfp_add_comp : nfp_add_single
    PORT MAP( nfp_in1 => Gain1_out1,  -- single
              nfp_in2 => Unit_Delay_out1,  -- single
              nfp_out => Add_out1  -- single
              );

  kconst <= X"3c2237c3";

  kconst_1 <= X"3f7d7721";

  Unit_Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Unit_Delay_out1 <= X"00000000";
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Unit_Delay_out1 <= Gain_out1;
      END IF;
    END IF;
  END PROCESS Unit_Delay_process;


  Out1 <= Add_out1;

END rtl;
