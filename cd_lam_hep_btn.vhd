----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:55:50 03/04/2025 
-- Design Name: 
-- Module Name:    cd_lam_hep_btn - Behavioral 
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

entity cd_lam_hep_btn is
    Port ( btn : in  STD_LOGIC;
           ckht : in  STD_LOGIC;
           xcdlh : out  STD_LOGIC);
end cd_lam_hep_btn;

architecture Behavioral of cd_lam_hep_btn is
signal xcd: std_logic;
begin
	u1: entity work. debounce_btn
		port map(btn => btn,
					ckht => ckht,
					db_tick => xcd);
	u2: entity work. lam_hep_xung
		port map(d => xcd,
					ckht => ckht,
					q => xcdlh);

end Behavioral;

