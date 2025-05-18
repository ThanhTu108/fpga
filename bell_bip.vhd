----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:03:37 04/08/2025 
-- Design Name: 
-- Module Name:    bell_bip - Behavioral 
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

entity bell_bip is
    Port ( ckht : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  tg_bip : in STD_LOGIC;
           xk_bell : in  STD_LOGIC;
           bell : out  STD_LOGIC);
end bell_bip;

architecture Behavioral of bell_bip is
signal q_n, q_r: std_logic;
begin
	process(ckht, rst)
	begin
		if rst = '1' then q_r <= '0';
		elsif falling_edge(ckht) then q_r <= q_n;
		end if;
	end process;
	
	process(q_r, tg_bip, xk_bell)
	begin
		q_n <= q_r;
		if xk_bell ='1' then q_n <='1';
		elsif tg_bip = '1' then q_n <= '0';
		end if;
	end process;
	bell <=q_r;
	
	
	
	

end Behavioral;

