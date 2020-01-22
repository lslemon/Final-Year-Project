-- Model name: <designName>_TB 
-- Description: Testbench for <design name> VHDL model
-- Authors: Fearghal Morgan
--    National University of Ireland, Galway 
-- Date: 13/7/2018

-- use default libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
-- testbench has no inputs or outputs
ENTITY <designName>_TB IS END <designName>_TB; 
 
ARCHITECTURE <architectureName> OF <desigName>_TB IS -- TB <architectureName> is typically behavior

-- Component Declaration (component to be tested). An entity and VHDL model/file for this component should exist.
-- Copy/paste the entire ENTITY declaration and replace ENTITY with COMPONENT, and END COMPONENT; 
COMPONENT designEntityName is
    Port ( <inSignalNameA> : in  STD_LOGIC;  
           <inSignalNameB> : in  STD_LOGIC;    
           <outSignalNameA> : out  STD_LOGIC;
           <outSignalNameB> : out  STD_LOGIC   
          );
END COMPONENT;

-- declare signals connecting stimuli to the 
-- Unit Under Test (UUT)
signal <inSignalNameA>  : std_logic; 
signal <inSignalNameB>  : STD_LOGIC; 
signal <outSignalNameA>  : STD_LOGIC; 

-- If combinational model, delete references to clk and rst signals, and period
-- Declare testbench-level signals. May be different from component signal names
SIGNAL clk : std_logic := '1'; -- initialise clk to '1' since std_logic default state is 'u' (undefined). 
signal rst : std_logic;
constant period   : time := 20 ns;-- Declare clock period, 50MHz clk


-- Test nums 0-5. Aids browsing of sim waveform 
signal testNo   : integer range 0 to 5; 
-- assert to highlight end of simulation
signal endOfSim : boolean := false;     
 
BEGIN

-- If combinational model, delete clk stimulus process 
-- clk stimulus continuing until simulation stimulus is no longer applied
clkStim : process (clk)
begin
  if endOfSim = false then
     clk <= not clk after period/2;
  end if;
end process;


-- Instantiate the Unit Under Test (UUT)
-- syntax is internal signal => connecting signal
uut: <desigName> PORT MAP 
			-- left side is user design entity signal, right side is signal declared in testbench
			(<inSignalNameA>  => <inSignalNameA, 
			(<inSignalNameB>  => <inSignalNameB, 
			(<outSignalNameA> => <outSignalNameA);

stim_i: process -- Stimulus process
-- variable value change immediately on assignment in process  
-- Use tempVec to define the TB i/p signal vector 
variable tempVec : std_logic_vector(1 downto 0); 
begin
   report "%N : Simulation start";

   -- Define default input signals and flags
	endOfSim <= false;
    testNo <= 0; 

    -- If combinational model, delete the following lines referring to signal rst 
    rst    <= '1';		 -- assert/deassert rst signal sequence
	wait for period*1.2; -- 0.2*period after active clk edge
    rst    <= '0';
    wait for period;	 -- can now use 'wait for period' through TB, always aligned to 0.2*period after active clk edge

    <inSignalNameA> <= '1'; -- assert both inputs (logic 1)
    <inSignalNameB> <= '1';
    wait for 10 ns; 

    testNo <= 1; -- useful in browsing simulation waveform for particular test
    for i in 0 to 3 loop
       tempVec := std_logic_vector(to_unsigned(i,2));
       <inSignalNameA>  <= tempVec(1);
       <inSignalNameB>  <= tempVec(0);
       wait for 10 ns; 
    end loop;
    
    testNo <= 2;
    <inSignalNameA> <= '1'; -- deassert both inputs (logic 0)
    <inSignalNameB> <= '1';
    wait for 10 ns; 

    report "%N : Simulation Done.";
	endOfSim <= true;
    wait; -- wait forever. Do not rerun the stimulus process (which has no sensitivity list)
end process;

END;