----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/25/2019 01:32:17 PM
-- Design Name: 
-- Module Name: main - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    Port ( CLK100MHZ : in STD_LOGIC;
           RESET : in STD_LOGIC;
           BTNL : in STD_LOGIC;
           BTNR : in STD_LOGIC;
           JB: out STD_LOGIC_VECTOR(4 downto 1);
           LED: out std_logic_vector(1 downto 0):= "00"
           --CLKOUT : out STD_LOGIC;
           --TRIGOUT : out STD_LOGIC;
           --PPS : out STD_LOGIC
           );
end main;

architecture Behavioral of main is
component debouncer is
    Generic ( DEBNC_CLOCKS : INTEGER range 2 to 50000 := 1024;
              PORT_WIDTH : INTEGER range 1 to 200 := 5);
    Port ( SIGNAL_I : in  STD_LOGIC_VECTOR ((PORT_WIDTH - 1) downto 0);
           CLK_I : in  STD_LOGIC;
           SIGNAL_O : out  STD_LOGIC_VECTOR ((PORT_WIDTH - 1) downto 0));
end component;

component clk_wiz_0 is
PORT ( resetn : in std_logic;
       clk_in1 : in std_logic;
       CLK10MHZ: out std_logic;
       locked : out std_logic
       );
end component;
SIGNAL CLKOUT, TRIGOUT, PPS: STD_LOGIC;
SIGNAL DBNBTN : STD_LOGIC_VECTOR(1 downto 0);
SIGNAL DBNOLD : STD_LOGIC_VECTOR(1 downto 0);
SIGNAL LEDSig : STD_LOGIC_VECTOR(1 downto 0):="00";
SIGNAL TRIG : STD_LOGIC_VECTOR(4 downto 0);
SIGNAL CLK10MHZ : STD_LOGIC;
begin
DBNCR: debouncer generic map(PORT_WIDTH => 2)
port map(SIGNAL_I(0) => BTNL, SIGNAL_I(1) => BTNR, CLK_I => CLK10MHZ, SIGNAL_O => DBNBTN);

CLKWIZ : clk_wiz_0
port map(clk_in1 => CLK100MHZ, resetn => RESET, CLK10MHZ => CLK10MHZ);
LED <= LEDSig;
JB(1) <= CLKOUT;
JB(2) <= LEDSig(0);
JB(3) <= TRIGOUT;
JB(4) <= PPS;
CLKOUT <= CLK10MHZ;
TRIGOUT <= '0' when TRIG /= "00000" else '1';

process (CLK10MHZ) is
VARIABLE COUNTER : INTEGER range 0 to 10000000;
begin
if rising_edge(CLK10MHZ) then   
DBNOLD <= DBNBTN;
    if DBNBTN = "01" and DBNOLD = "00" then
        TRIG <= "00101";
    elsif DBNBTN = "10" and DBNOLD = "00" then
        TRIG <= "01010";
    else
        if TRIG /= "00000" then
            TRIG <= STD_LOGIC_VECTOR(unsigned(TRIG) - 1);
        else
            TRIG <= "00000";
        end if;
    end if;

    if COUNTER /= 9999999 then
        COUNTER := COUNTER + 1;
        PPS <= '0';
    else
        COUNTER := 0;
        PPS <= '1';
        LEDsig(0) <= not LEDsig(0);
    end if;
end if;
end process;
end Behavioral;
