----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:31:57 05/06/2025 
-- Design Name: 
-- Module Name:    lcd_ktao_ht - Behavioral 
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

entity lcd_ktao_ht is
    Port ( ckht : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           lcd_db : out  STD_LOGIC_VECTOR (7 downto 0);
           lcd_rs : out  STD_LOGIC;
           lcd_e : out  STD_LOGIC;
			  
           lcd_h0 : in  STD_LOGIC_VECTOR (159 downto 0);
           lcd_h1 : in  STD_LOGIC_VECTOR (159 downto 0);
           lcd_h2 : in  STD_LOGIC_VECTOR (159 downto 0);
           lcd_h3 : in  STD_LOGIC_VECTOR (159 downto 0));
end lcd_ktao_ht;

architecture Behavioral of lcd_ktao_ht is
type lcd_machine is (
	lcd_initial,
	lcd_addr_10,
	lcd_data_10,
	lcd_addr_11,
	lcd_data_11,
	lcd_addr_12,
	lcd_data_12,
	lcd_addr_13,
	lcd_data_13,
	lcd_stop
);
signal lcd_state: lcd_machine:= lcd_initial;
type lcd_cmd_tb is array(integer range 0 to 5) of
	std_logic_vector(7 downto 0);
constant lcd_cmd: lcd_cmd_tb:= (
								0 => x"00",
								1 => x"3c",	--function set
								2 => x"0c",	--control diplay
								3 => x"01",	--clear
								4 => x"02", --return home
								5 => x"06"	--entry mode set
								);
type lcd_dis_10 is array(integer range 0 to 19) of std_logic_vector(7 downto 0);
type lcd_dis_11 is array(integer range 0 to 19) of std_logic_vector(7 downto 0);
type lcd_dis_12 is array(integer range 0 to 19) of std_logic_vector(7 downto 0);
type lcd_dis_13 is array(integer range 0 to 19) of std_logic_vector(7 downto 0);

signal lcd_dis0: lcd_dis_10;
signal lcd_dis1: lcd_dis_11;
signal lcd_dis2: lcd_dis_12;
signal lcd_dis3: lcd_dis_13;

signal ptr: integer range 0 to 19:=0;
signal slx: integer range 0 to 1000000:=0;

begin

	process(lcd_h0, lcd_h1, lcd_h2, lcd_h3)
	begin
		for i in 0 to 19
		loop
			lcd_dis0(i) <= lcd_h0((i*8+7) downto i*8);
			lcd_dis1(i) <= lcd_h1((i*8+7) downto i*8);
			lcd_dis2(i) <= lcd_h2((i*8+7) downto i*8);
			lcd_dis3(i) <= lcd_h3((i*8+7) downto i*8);
		end loop;
	end process;
	
	process(ckht, slx, rst)
	begin
		if rst = '1' then lcd_state <= lcd_initial;
								slx <=0;
								ptr <=0;
		elsif falling_edge(ckht) then
			case lcd_state is
				when lcd_initial =>
							lcd_rs <= '0';
							lcd_db <= lcd_cmd(ptr);
							slx <= slx + 1;
							if slx = 10 then lcd_e <= '1';
							elsif slx = 30 then lcd_e <= '0';
							elsif slx = 16400 then slx <= 0;
								if ptr = 5 then lcd_state <= lcd_addr_10;
								else ptr <= ptr + 1;
								end if;
							end if;
--hang 0
				when lcd_addr_10 =>
								lcd_rs <= '0';
								lcd_db <= x"80";
								slx <= slx + 1;
								if slx = 10 then lcd_e <= '1';
								elsif slx = 30 then lcd_e <= '0';
								elsif slx = 2000 then 
													slx <= 0;
													lcd_state <= lcd_data_10;
													ptr <= 0;
								end if;
				
				when lcd_data_10 =>
							lcd_rs <= '1';
							lcd_db <= lcd_dis0(ptr);
							slx <= slx + 1;
							if slx = 10 then lcd_e <= '1';
							elsif slx = 30 then lcd_e <= '0';
							elsif slx = 2000 then slx <= 0;
								if ptr = 19 then lcd_state <= lcd_addr_11;
								else ptr <= ptr + 1;
								end if;
							end if;
				
				when lcd_addr_11 =>
							lcd_rs <= '0';
							lcd_db <= x"c0";
							slx <= slx + 1;
							if slx = 10 then lcd_e <= '1';
							elsif slx = 30 then lcd_e <= '0';
							elsif slx = 2000 then
									slx <= 0;
									lcd_state <= lcd_data_11;
									ptr <= 0;
							end if;
				
				when lcd_data_11 =>
							lcd_rs <= '1';
							lcd_db <= lcd_dis1(ptr);
							slx <= slx + 1;
							if slx = 10 then lcd_e <= '1';
							elsif slx = 30 then lcd_e <= '0';
							elsif slx = 2000 then slx <= 0;
								if ptr = 19 then lcd_state <= lcd_addr_12;
								else ptr <= ptr + 1;
								end if;
							end if;
				
				when lcd_addr_12 =>
							lcd_rs <= '0';
							lcd_db <= x"94";
							slx <= slx + 1;
							if slx = 10 then lcd_e <= '1';
							elsif slx = 30 then lcd_e <= '0';
							elsif slx = 2000 then
									slx <= 0;
									lcd_state <= lcd_data_12;
									ptr <= 0;
							end if;
				when lcd_data_12 =>
							lcd_rs <= '1';
							lcd_db <= lcd_dis2(ptr);
							slx <= slx + 1;
							if slx = 10 then lcd_e <= '1';
							elsif slx = 30 then lcd_e <= '0';
							elsif slx = 2000 then slx <= 0;
								if ptr = 19 then lcd_state <= lcd_addr_13;
								else ptr <= ptr + 1;
								end if;
							end if;			
				
				
				when lcd_addr_13 =>
							lcd_rs <= '0';
							lcd_db <= x"d4";
							slx <= slx + 1;
							if slx = 10 then lcd_e <= '1';
							elsif slx = 30 then lcd_e <= '0';
							elsif slx = 2000 then
									slx <= 0;
									lcd_state <= lcd_data_13;
									ptr <= 0;
							end if;
				when lcd_data_13 =>
							lcd_rs <= '1';
							lcd_db <= lcd_dis3(ptr);
							slx <= slx + 1;
							if slx = 10 then lcd_e <= '1';
							elsif slx = 30 then lcd_e <= '0';
							elsif slx = 2000 then slx <= 0;
								if ptr = 19 then lcd_state <= lcd_stop;
								else ptr <= ptr + 1;
								end if;
							end if;		
				when lcd_stop =>
							slx <= slx + 1;
							if slx = 1000000 then slx <= 0;
								lcd_state <= lcd_addr_10;
							end if;
			end case;
		end if;
	end process;


end Behavioral;

