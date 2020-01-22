-- Model name: <designName> 
-- Description: <description>
-- Authors: Fearghal Morgan, National University of Ireland, Galway 
-- Date: 12/7/2018
-- For viciLogic projects, use FPGA Zynq technology part XC7Z020CLG400-1 (for Digilent PYNQ-Z1 module)
-- 
-- Signal data dictionary (remove all clk, rst signal references if the model is combinational)
--  clk             input   System clock strobe, rising edge active
--  rst             input   Asynchronous clear. Assertion (h) clears all registers  
--  <inSignalNameA> 	input
--  <inSignalNameB>     input
--  <outSignalNameA>    output 

-- use default libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity designEntityName is
    Port ( <inSignalNameA> : in  STD_LOGIC;  
           <inSignalNameB> : in  STD_LOGIC;    
           <outSignalNameA> : out  STD_LOGIC;
           <outSignalNameB> : out  STD_LOGIC   
          );
end designEntityName;

architecture <architectureName> of designEntityName is
-- Component Declaration. An entity and VHDL model/file for this component should exist.
-- Copy/paste the entire ENTITY declaration and replace ENTITY with COMPONENT, and END COMPONENT; 
COMPONENT <componentName) 
PORT(<inSigB0> :   IN  std_logic;
	 <inSigB1> :   IN  std_logic_vector(n downto 0);
	 <outSigB0>:   OUT std_logic
  );
END COMPONENT;

-- Signal declarations
-- If describing a state machine, typically declare enumerated types for CS and NS state signals (as list of state names)
-- The synthesis tool will select the encoding of CS and NS (binary, gray, one-hot, random 
type stateType is (state0, state, ...., stateN); 
signal CS, NS: stateType;  -- current and next state signals

-- Declare any other internal signals

begin

-- if sequential model includes register (stateReg) process, recommend using the following, with signals NS and cS
-- If combination model, delete this process
stateReg: process (clk, rst)
begin
    if rst = '1' then 
        CS <= (others => '0');
    elsif rising_edge(clk) then
        CS <= NS;
    end if;
end process;

<label0:> <outSignalNameA> <= <function of input signals>; 
<label1:> <outSignalNameB> <= <function of input signals>; 

end <architectureName>;