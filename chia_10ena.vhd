----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:49:43 02/25/2025 
-- Design Name: 
-- Module Name:    chia_10ena - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity chia_10ena is
    Port ( ckht : in  STD_LOGIC;
--           ena1hz: out  STD_LOGIC;
			  ena2hz: out  STD_LOGIC;
			  ena5hz: out  STD_LOGIC
--			  ena10hz: out  STD_LOGIC;
--			  ena20hz: out  STD_LOGIC;
--			  ena25hz: out  STD_LOGIC;
--			  ena50hz: out  STD_LOGIC;
--			  ena100hz: out  STD_LOGIC;
--			  ena1khz: out  STD_LOGIC;
--			  ena1mhz: out  STD_LOGIC);
			);
end chia_10ena;

architecture Behavioral of chia_10ena is
constant n: integer := 50000000;
signal d1hz_r, d1hz_n: integer range 0 to n:=0;
signal d2hz_r, d2hz_n: integer range 0 to n/2:=0;
signal d5hz_r, d5hz_n: integer range 0 to n/5:=0;
signal d10hz_r, d10hz_n: integer range 0 to n/10:=0;
signal d20hz_r, d20hz_n: integer range 0 to n/20:=0;
signal d25hz_r, d25hz_n: integer range 0 to n/25:=0;
signal d50hz_r, d50hz_n: integer range 0 to n/50:=0;
signal d100hz_r, d100hz_n: integer range 0 to n/100:=0;
signal d1khz_r, d1khz_n: integer range 0 to n/1000:=0;
signal d1mhz_r, d1mhz_n: integer range 0 to n/1000000:=0;
begin
	process(ckht)
	begin
		if falling_edge(ckht) then d1hz_r<=d1hz_n;
											d2hz_r<=d2hz_n;
											d5hz_r<=d5hz_n;
											d10hz_r<=d10hz_n;
											d20hz_r<=d20hz_n;
											d25hz_r<=d25hz_n;
											d50hz_r<=d50hz_n;
											d100hz_r<=d100hz_n;
											d1khz_r<=d1khz_n;
											d1mhz_r<=d1mhz_n;
		end if;
	end process;
	d1hz_n <= 0 when  d1hz_r = n-1 else d1hz_r+1;			 
	d2hz_n <= 0 when  d2hz_r = n/2-1 else d2hz_r+1;
	d5hz_n <= 0 when  d5hz_r = n/5-1 else d5hz_r+1;			 
	d10hz_n <= 0 when  d10hz_r = n/10-1 else d10hz_r+1;
	d20hz_n <= 0 when  d20hz_r = n/20-1 else d20hz_r+1;
	d25hz_n <= 0 when  d25hz_r = n/25-1 else d10hz_r+1;
	d50hz_n <= 0 when  d50hz_r = n/50-1 else d20hz_r+1;		
	d100hz_n <= 0 when  d100hz_r = n/100-1 else d10hz_r+1;
	d1khz_n <= 0 when  d1khz_r = n/1000-1 else d20hz_r+1;	
	d1mhz_n <= 0 when  d1mhz_r = n/1000000-1 else d20hz_r+1;	

		
--	ena1hz <='1' when d1hz_r = n/(1*2)	else'0';
	ena2hz <='1' when d2hz_r = n/(2*2)	else'0';
	ena5hz <='1' when d5hz_r = n/(5*2)	else'0';
--	ena10hz <='1' when d10hz_r = n/(10*2)	else'0';
--	ena20hz <='1' when d20hz_r = n/(20*2)	else'0';
--	ena25hz <='1' when d25hz_r = n/(25*2)	else'0';
--	ena50hz <='1' when d50hz_r = n/(50*2)	else'0';
--	ena100hz <='1' when d100hz_r = n/(100*2)	else'0';
--	ena1khz <='1' when d1khz_r = n/(1000*2)	else'0';
--	ena1mhz <='1' when d1mhz_r = n/(1000000*2)	else'0';

end Behavioral;

