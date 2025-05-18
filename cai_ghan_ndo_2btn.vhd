----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:07:49 05/13/2025 
-- Design Name: 
-- Module Name:    cai_ghan_ndo_2btn - Behavioral 
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

entity cai_ghan_ndo_2btn is
    Port ( ckht : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           ena2hz : in  STD_LOGIC;
           btn_up : in  STD_LOGIC;
           btn_dw : in  STD_LOGIC;
           xk_bell : out  STD_LOGIC;
           q : out  STD_LOGIC_VECTOR (5 downto 0));
end cai_ghan_ndo_2btn;

architecture Behavioral of cai_ghan_ndo_2btn is
signal xcd_up, xcd_dw, xcd_ud: std_logic;
begin
	u1:entity work.debounce_btn 
		port map(ckht => ckht,
					btn => btn_up,
					db_tick => xcd_up);
	u2:entity work.debounce_btn
		port map(ckht => ckht,
					btn => btn_dw,
					db_tick => xcd_dw);
	u3: entity work. dem_np_6bit_ud
		port map(ckht => ckht,
					rst => rst,
					ena_db => ena2hz,
					ena_up => xcd_up,
					ena_dw => xcd_dw,
					q => q);
	xcd_ud <= xcd_up or xcd_dw;
	u4: entity work. lam_hep_xung
		port map(ckht => ckht,
					d => xcd_ud,
					q => xk_bell);
end Behavioral;

