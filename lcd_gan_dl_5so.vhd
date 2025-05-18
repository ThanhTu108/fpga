----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:37:24 05/06/2025 
-- Design Name: 
-- Module Name:    lcd_gan_dl_5so - Behavioral 
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

entity lcd_gan_dl_5so is
    Port ( nd_dv : in  STD_LOGIC_VECTOR (3 downto 0);
           nd_ch : in  STD_LOGIC_VECTOR (3 downto 0);
			  nd_tr : in  STD_LOGIC_VECTOR (3 downto 0);
           nd_tp : in  STD_LOGIC_VECTOR (3 downto 0);
           gh_ch : in  STD_LOGIC_VECTOR (3 downto 0);
           gh_dv : in  STD_LOGIC_VECTOR (3 downto 0);
           ds_pre : in  STD_LOGIC;
			  
           lcd_h0 : out  STD_LOGIC_VECTOR (159 downto 0);
           lcd_h1 : out  STD_LOGIC_VECTOR (159 downto 0);
           lcd_h2 : out  STD_LOGIC_VECTOR (159 downto 0);
           lcd_h3 : out  STD_LOGIC_VECTOR (159 downto 0));
end lcd_gan_dl_5so;

architecture Behavioral of lcd_gan_dl_5so is
signal tp: std_logic_vector(3 downto 0);
signal yn2, yn1, yn0: std_logic_vector(7 downto 0);
begin
	process(nd_tp)
	begin
		case nd_tp is
			when "0010" | "0001" => tp <= "0001";
			when "0100" | "0011" => tp <= "0010";
			when "0110" | "0101" => tp <= "0011";
			when "0111"          => tp <= "0100";
			when "1000" | "1001" => tp <= "0101";
			when "1010" | "1011" => tp <= "0110";
			when "1100" | "1101" => tp <= "0111";
			when "1110"          => tp <= "1000";
			when "1111"          => tp <= "1001";
			when others          => tp <= "0000";
		end case;
	end process;
	
	process(ds_pre)
	begin
		if ds_pre = '0' then 
			yn2 <= conv_std_logic_vector(character'pos('Y'),8);
			yn1 <= conv_std_logic_vector(character'pos('E'),8);
			yn0 <= conv_std_logic_vector(character'pos('S'),8);
--			ss0 <= conv_std_logic_vector(character'pos('P'),8);
		else
			yn2 <= conv_std_logic_vector(character'pos(' '),8);
			yn1 <= conv_std_logic_vector(character'pos('N'),8);
			yn0 <= conv_std_logic_vector(character'pos('O'),8);
--			ss0 <= conv_std_logic_vector(character'pos(' '),8);
		end if;
	end process;


	
	
--	lcd_h0(7 downto 0) <= conv_std_logic_vector(character'pos('M'),8);
--	lcd_h0(15 downto 8) <= conv_std_logic_vector(character'pos('a'),8);
--	lcd_h0(23 downto 16) <= conv_std_logic_vector(character'pos('c'),8);
--	lcd_h0(31 downto 24) <= conv_std_logic_vector(character'pos('h'),8);
--	lcd_h0(39 downto 32) <= conv_std_logic_vector(character'pos('D'),8);
--	lcd_h0(47 downto 40) <= conv_std_logic_vector(character'pos('e'),8);
--	lcd_h0(55 downto 48) <= conv_std_logic_vector(character'pos('m'),8);
--	lcd_h0(63 downto 56) <= conv_std_logic_vector(character'pos('N'),8);
--	lcd_h0(71 downto 64) <= conv_std_logic_vector(character'pos('p'),8);
--	lcd_h0(79 downto 72) <= conv_std_logic_vector(character'pos(':'),8);
--	lcd_h0(87 downto 80) <= conv_std_logic_vector(character'pos('1'),8);
--	lcd_h0(95 downto 88) <= conv_std_logic_vector(character'pos('0'),8);
--	lcd_h0(103 downto 96) <= conv_std_logic_vector(character'pos('b'),8);
--	lcd_h0(111 downto 104) <= conv_std_logic_vector(character'pos('i'),8);
--	lcd_h0(119 downto 112) <= conv_std_logic_vector(character'pos('t'),8);
--	lcd_h0(127 downto 120) <= conv_std_logic_vector(character'pos(' '),8);
--	lcd_h0(135 downto 128) <= ngant;
--	
--	
--	lcd_h0(143 downto 136) <= tramt;
--	lcd_h0(151 downto 144) <= chuct;
--	lcd_h0(159 downto 152) <= x"3" & donvi;
--	
--	
--	lcd_h1(7 downto 0) <= ss3;
--	lcd_h1(15 downto 8) <= ss2;
--	lcd_h1(23 downto 16) <= ss1;
--	lcd_h1(31 downto 24) <= ss0;
--	
--	lcd_h1(39 downto 32) <= conv_std_logic_vector(character'pos(' '),8);
--	lcd_h1(47 downto 40) <= ud3;
--	lcd_h1(55 downto 48) <= ud2;
--	lcd_h1(63 downto 56) <= ud1;
--	lcd_h1(71 downto 64) <= ud0;
--	
--	
--	lcd_h1(79 downto 72) <= conv_std_logic_vector(character'pos(' '),8);
--	lcd_h1(87 downto 80) <= conv_std_logic_vector(character'pos('T'),8);
--	lcd_h1(95 downto 88) <= conv_std_logic_vector(character'pos('a'),8);
--	lcd_h1(103 downto 96) <= conv_std_logic_vector(character'pos('n'),8);
--	lcd_h1(111 downto 104) <= conv_std_logic_vector(character'pos(' '),8);
--	lcd_h1(119 downto 112) <= conv_std_logic_vector(character'pos('s'),8);
--	lcd_h1(127 downto 120) <= conv_std_logic_vector(character'pos('o'),8);
--	lcd_h1(135 downto 128) <= conv_std_logic_vector(character'pos(':'),8);
--	lcd_h1(143 downto 136) <= conv_std_logic_vector(character'pos(' '),8);
--	
--	lcd_h1(151 downto 144) <= x"3" & ch_ts;
--	lcd_h1(159 downto 152) <= x"3" & dv_ts;
	
	
	
	
	lcd_h2(7 downto 0) <= conv_std_logic_vector(character'pos('D'),8);
	lcd_h2(15 downto 8) <= conv_std_logic_vector(character'pos('S'),8);
	lcd_h2(23 downto 16) <= conv_std_logic_vector(character'pos('1'),8);
	lcd_h2(31 downto 24) <= conv_std_logic_vector(character'pos('8'),8);
	lcd_h2(39 downto 32) <= conv_std_logic_vector(character'pos('B'),8);
	lcd_h2(47 downto 40) <= conv_std_logic_vector(character'pos('2'),8);
	lcd_h2(55 downto 48) <= conv_std_logic_vector(character'pos('0'),8);
	lcd_h2(63 downto 56) <= conv_std_logic_vector(character'pos(':'),8);
	
	lcd_h2(71 downto 64) <= yn2;
	lcd_h2(79 downto 72) <= yn1;
	lcd_h2(87 downto 80) <= yn0;
	
	lcd_h2(95 downto 88) <= conv_std_logic_vector(character'pos(' '),8);
	lcd_h2(103 downto 96) <= conv_std_logic_vector(character'pos('N'),8);
	lcd_h2(111 downto 104) <= conv_std_logic_vector(character'pos('D'),8);
	lcd_h2(119 downto 112) <= conv_std_logic_vector(character'pos('O'),8);
	
	lcd_h2(127 downto 120) <= x"20" when nd_tr = x"0" else x"3" &nd_tr;
	lcd_h2(135 downto 128) <= x"3" & nd_ch;
	lcd_h2(143 downto 136) <= x"3" & nd_dv;
	lcd_h2(151 downto 144) <= conv_std_logic_vector(character'pos('.'),8);
	lcd_h2(159 downto 152) <= x"3" & tp;
	
	
	lcd_h3(7 downto 0) <= conv_std_logic_vector(character'pos('N'),8);
	lcd_h3(15 downto 8) <= conv_std_logic_vector(character'pos('h'),8);
	lcd_h3(23 downto 16) <= conv_std_logic_vector(character'pos('i'),8);
	lcd_h3(31 downto 24) <= conv_std_logic_vector(character'pos('e'),8);
	lcd_h3(39 downto 32) <= conv_std_logic_vector(character'pos('t'),8);
	lcd_h3(47 downto 40) <= conv_std_logic_vector(character'pos(' '),8);
	lcd_h3(55 downto 48) <= conv_std_logic_vector(character'pos('D'),8);
	lcd_h3(63 downto 56) <= conv_std_logic_vector(character'pos('o'),8);
	lcd_h3(71 downto 64) <= conv_std_logic_vector(character'pos(' '),8);
	lcd_h3(79 downto 72) <= conv_std_logic_vector(character'pos('G'),8);
	lcd_h3(87 downto 80) <= conv_std_logic_vector(character'pos('i'),8);
	lcd_h3(95 downto 88) <= conv_std_logic_vector(character'pos('o'),8);
	lcd_h3(103 downto 96) <= conv_std_logic_vector(character'pos('i'),8);
	lcd_h3(111 downto 104) <= conv_std_logic_vector(character'pos(' '),8);
	lcd_h3(119 downto 112) <= conv_std_logic_vector(character'pos('H'),8);
	lcd_h3(127 downto 120) <= conv_std_logic_vector(character'pos('a'),8);
	lcd_h3(135 downto 128) <= conv_std_logic_vector(character'pos('n'),8);
	lcd_h3(143 downto 136) <= conv_std_logic_vector(character'pos(':'),8);
	
	lcd_h3(151 downto 144) <= x"3" & gh_ch;
	lcd_h3(159 downto 152) <= x"3" & gh_dv;
end Behavioral;

