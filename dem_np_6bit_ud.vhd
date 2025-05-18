----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:43:12 05/06/2025 
-- Design Name: 
-- Module Name:    dem_np_6bit_ud - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dem_np_6bit_ud is
    Port ( ckht : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  ena_db : in STD_LOGIC;
           ena_up : in  STD_LOGIC;
           ena_dw : in  STD_LOGIC;
           q : out  STD_LOGIC_VECTOR (5 downto 0));
end dem_np_6bit_ud;

architecture Behavioral of dem_np_6bit_ud is
signal q_r: std_logic_vector(5 downto 0) := "100011";
signal q_n: std_logic_vector(5 downto 0);
signal ena_u, ena_d: std_logic;
begin
	process(ckht, rst)
	begin 
		if rst = '1' then q_r <= "100011";
		elsif falling_edge(ckht) then q_r <= q_n;
		end if;
	end process;
	
	ena_u <= ena_db and ena_up;
	ena_d <= ena_db and ena_dw;
	
	q_n <= q_r+1 when ena_u = '1' and q_r <"110010" else
			 q_r-1 when ena_d = '1' and q_r >"010100" else
			 q_r;
			 
	q <= q_r;
	
end Behavioral;

