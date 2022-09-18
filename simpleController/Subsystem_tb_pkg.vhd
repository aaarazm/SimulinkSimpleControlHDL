-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\simpleController\Subsystem_tb_pkg.vhd
-- Created: 2022-09-04 18:05:00
-- 
-- Generated by MATLAB 9.9 and HDL Coder 3.17
-- 
-- -------------------------------------------------------------


LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY IEEE;
USE IEEE.std_logic_textio.ALL;
USE IEEE.float_pkg.ALL;
LIBRARY STD;
USE STD.textio.ALL;

PACKAGE Subsystem_tb_pkg IS
  -- Functions
  FUNCTION to_hex(x : IN std_logic) RETURN string;
  FUNCTION to_hex(x : IN std_logic_vector) RETURN string;
  FUNCTION to_hex(x : IN signed) RETURN string;
  FUNCTION to_hex(x : IN unsigned) RETURN string;
  FUNCTION to_hex(x : IN real) RETURN string;
  FUNCTION isFloatEqual(x : IN std_logic_vector; y : IN std_logic_vector;
                        eps: IN real; exp_len : IN natural; mantissa_len : IN natural) RETURN boolean;
  FUNCTION isFloatSingleEqual(x : IN std_logic_vector; y : IN std_logic_vector; eps: IN real) RETURN boolean;
END Subsystem_tb_pkg;


PACKAGE BODY Subsystem_tb_pkg IS
  FUNCTION to_hex(x : IN std_logic_vector) RETURN string IS
    VARIABLE result : STRING(1 TO 256);
    VARIABLE i      : INTEGER;
    VARIABLE imod   : INTEGER;
    VARIABLE j      : INTEGER;
    VARIABLE jinc   : INTEGER;
    VARIABLE newx   : std_logic_vector(1023 DOWNTO 0);
  BEGIN
    newx := (OTHERS => '0');
    IF x'LEFT > x'RIGHT THEN
      j := x'LENGTH - 1;
      jinc := -1;
    ELSE
      j := 0;
      jinc := 1;
    END IF;
    FOR i IN x'RANGE LOOP
      newx(j) := x(i);
      j := j + jinc;
    END LOOP;
    i := x'LENGTH - 1;
    imod := x'LENGTH MOD 4;
    IF    imod = 1 THEN i := i + 3;
    ELSIF imod = 2 THEN i := i + 2;
    ELSIF imod = 3 THEN i := i + 1;
    END IF;
    j := 1;
    WHILE i >= 3 LOOP
      IF    newx(i DOWNTO (i-3)) = "0000" THEN result(j) := '0';
      ELSIF newx(i DOWNTO (i-3)) = "0001" THEN result(j) := '1';
      ELSIF newx(i DOWNTO (i-3)) = "0010" THEN result(j) := '2';
      ELSIF newx(i DOWNTO (i-3)) = "0011" THEN result(j) := '3';
      ELSIF newx(i DOWNTO (i-3)) = "0100" THEN result(j) := '4';
      ELSIF newx(i DOWNTO (i-3)) = "0101" THEN result(j) := '5';
      ELSIF newx(i DOWNTO (i-3)) = "0110" THEN result(j) := '6';
      ELSIF newx(i DOWNTO (i-3)) = "0111" THEN result(j) := '7';
      ELSIF newx(i DOWNTO (i-3)) = "1000" THEN result(j) := '8';
      ELSIF newx(i DOWNTO (i-3)) = "1001" THEN result(j) := '9';
      ELSIF newx(i DOWNTO (i-3)) = "1010" THEN result(j) := 'A';
      ELSIF newx(i DOWNTO (i-3)) = "1011" THEN result(j) := 'B';
      ELSIF newx(i DOWNTO (i-3)) = "1100" THEN result(j) := 'C';
      ELSIF newx(i DOWNTO (i-3)) = "1101" THEN result(j) := 'D';
      ELSIF newx(i DOWNTO (i-3)) = "1110" THEN result(j) := 'E';
      ELSIF newx(i DOWNTO (i-3)) = "1111" THEN result(j) := 'F';
      ELSE result(j) := 'X';
      END IF;
      i := i - 4;
      j := j + 1;
    END LOOP;
    RETURN result(1 TO j - 1);
  END;

  FUNCTION to_hex(x : IN std_logic) RETURN string IS
  BEGIN
    RETURN std_logic'image(x);
  END;

  FUNCTION to_hex(x : IN signed) RETURN string IS
  BEGIN
    RETURN to_hex(std_logic_vector(x));
  END;

  FUNCTION to_hex(x : IN unsigned) RETURN string IS
  BEGIN
    RETURN to_hex(std_logic_vector(x));
  END;

  FUNCTION to_hex(x : IN real) RETURN string IS
  BEGIN
    RETURN real'image(x);
  END;

  FUNCTION isFloatEqual(x : IN std_logic_vector; y : IN std_logic_vector;
                        eps : IN real; exp_len : IN natural; 
                        mantissa_len : IN natural) RETURN boolean IS
    VARIABLE absdiff : real;
    VARIABLE a : real;
    VARIABLE b : real;
  BEGIN
    a := to_real(to_float(std_ulogic_vector(x), exp_len, mantissa_len));
    b := to_real(to_float(std_ulogic_vector(y), exp_len, mantissa_len));
    absdiff := abs(a - b);
    IF absdiff < eps THEN -- absolute error check
      RETURN TRUE;
    ELSIF a = b THEN -- check infinities
      RETURN TRUE;
    ELSIF a*b = 0.0 THEN -- either is zero
      RETURN absdiff < eps;
    ELSIF (abs(a) < abs(b)) THEN -- relative error check
      RETURN absdiff/abs(b) < eps;
    ELSE 
      RETURN absdiff/abs(a) < eps;
    END IF;
  END;

  FUNCTION isFloatSingleEqual(x : IN std_logic_vector;
                              y : IN std_logic_vector;
                              eps : IN real) RETURN boolean IS
  VARIABLE a : std_logic_vector(31 downto 0);
  VARIABLE b : std_logic_vector(31 downto 0);
  VARIABLE zrEx : std_logic_vector(7 downto 0) := x"FF";
  VARIABLE zrMt : std_logic_vector(22 downto 0) := b"000" & x"00000";
  BEGIN
    a := x;
    b := y;
    IF (a(30 downto 23) = zrEx AND a(22 downto 0) /= zrMt) THEN
      a(31) := '0';
      a(22 downto 0) := x"00000" & b"001";
    END IF;
    IF (b(30 downto 23) = zrEx AND b(22 downto 0) /= zrMt) THEN
      b(31) := '0';
      b(22 downto 0) := x"00000" & b"001";
    END IF;
    RETURN isFloatEqual(a, b, eps, 8, 23);
  END;

END Subsystem_tb_pkg;

