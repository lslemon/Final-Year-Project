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

entity fsm is
    Port ( valid : in  STD_LOGIC;  
           last : in  STD_LOGIC;    
           terminate : in  STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           streamCMD : out  STD_LOGIC;
           ready : out STD_LOGIC;
           mapCMD : out STD_LOGIC   
          );
end fsm;

architecture sequential of fsm is

-- Signal declarations
-- If describing a state machine, typically declare enumerated types for CS and NS state signals (as list of state names)
-- The synthesis tool will select the encoding of CS and NS (binary, gray, one-hot, random 
type stateType is (idle, stream, map_fifo); 
signal CS, NS: stateType;  -- current and next state signals

-- Declare any other internal signals

begin

-- if sequential model includes register (stateReg) process, recommend using the following, with signals NS and cS
-- If combination model, delete this process
stateReg: process (clk, rst)
begin
    if rst = '1' then 
        CS <= IDLE;
    elsif rising_edge(clk) then
        CS <= NS;
    end if;
end process;

NSDecode : process(CS, terminate, last, valid)
begin
    case CS is
      when idle =>
        if valid = '1' then
            NS <= stream;
        end if;
      when stream =>
        if last = '1' then
            NS <= map_fifo;
        end if;
      when map_fifo =>
        if terminate = '1' then
            NS <= idle;
        end if;
      when others =>
     end case;
end process;

--OPDecode :process(CS)
--begin
--    streamCMD <= '0';
--    mapCMD <= '0';
--    ready <='0';
    
--    case CS is
--        when idle =>
--            streamCMD <= '1';
--        when stream =>
            
--        when map_fifo =>
            
--        when others =>
--    end case;
    
--end process;
end sequential;