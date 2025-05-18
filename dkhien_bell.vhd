----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:17:20 05/13/2025 
-- Design Name: 
-- Module Name:    dkhien_bell - Behavioral 
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

entity dkhien_bell is
    Port ( ckht : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           ena5hz : in  STD_LOGIC;
           xk_bell : in  STD_LOGIC;
			  sw : in  STD_LOGIC;
           ndo_ng : in  STD_LOGIC_VECTOR (7 downto 0);
           ndo_ss : in  STD_LOGIC_VECTOR (7 downto 0);
           bell : out  STD_LOGIC);
end dkhien_bell;

architecture Behavioral of dkhien_bell is
signal bell_1, bell_2: std_logic;
begin
	bell_2 <= '1' when ndo_ng > ndo_ss and sw = '1' else '0';
	bell <= bell_1 or bell_2;
	
	u0: entity work. bell_bip
		port map(ckht => ckht,
					rst => rst,
					tg_bip => ena5hz,
					xk_bell => xk_bell,
					bell => bell_1);

end Behavioral;

