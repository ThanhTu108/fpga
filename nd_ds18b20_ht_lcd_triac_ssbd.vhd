----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:48:29 05/13/2025 
-- Design Name: 
-- Module Name:    nd_ds18b20_ht_lcd_triac_ssbd - Behavioral 
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

entity nd_ds18b20_ht_lcd_triac_ssbd is
	Port (  ckht : in  STD_LOGIC;		  
           btn : in  STD_LOGIC_VECTOR (2 downto 0);
           sw : in  STD_LOGIC_VECTOR (1 downto 0);
           swp : in  STD_LOGIC;
			  
			  ds18b20 : inout  STD_LOGIC;
			  triac : out  STD_LOGIC;
           bell : out  STD_LOGIC;
			  
           lcd_e : out  STD_LOGIC;
           lcd_rs : out  STD_LOGIC;
           lcd_p : out  STD_LOGIC;
			  
           lcd_db : out  STD_LOGIC_VECTOR (7 downto 0));
end nd_ds18b20_ht_lcd_triac_ssbd;

architecture Behavioral of nd_ds18b20_ht_lcd_triac_ssbd is
signal lcd_h0: std_logic_vector(159 downto 0);
signal lcd_h1: std_logic_vector(159 downto 0);
signal lcd_h2: std_logic_vector(159 downto 0);
signal lcd_h3: std_logic_vector(159 downto 0);

signal nhietdo: std_logic_vector(11 downto 0);
signal ndo_ng: std_logic_vector(7 downto 0);
signal nd_tp: std_logic_vector(3 downto 0);

signal nd_dv, nd_ch, nd_tr: std_logic_vector(3 downto 0);
signal ds_pre: std_logic;

signal btn_dw, btn_up: std_logic;
signal ena2hz, ena5hz: std_logic;

signal ndo_ss: std_logic_vector(7 downto 0);
signal gh_nd: std_logic_vector(5 downto 0);
signal gh_dv: std_logic_vector(3 downto 0);
signal gh_ch: std_logic_vector(3 downto 0);
signal xk_bell: std_logic;
signal rst: std_logic;
begin

	lcd_p <= swp;
	rst <= btn(0);
	btn_up <= btn(1);
	btn_dw <= btn(2);
	
	triac <= sw(0);
	ndo_ng <= nhietdo(11 downto 4);
	nd_tp <= nhietdo(3 downto 0);
	
	ndo_ss <="00" &gh_nd;
	
	ic1: entity work.dkhien_bell
		port map(ckht => ckht,
					rst => rst,
					sw => sw(1),
					ndo_ng => ndo_ng,
					ndo_ss => ndo_ss,
					ena5hz => ena5hz,
					xk_bell => xk_bell,
					bell => bell);
	
	ic2: entity work. chia_10ena
		port map(ckht => ckht,
					ena2hz => ena2hz,
					ena5hz => ena5hz);
	
	ic3: entity work. cai_ghan_ndo_2btn
		port map(ckht => ckht,
					rst => rst,
					ena2hz => ena2hz,
					btn_up => btn_up,
					btn_dw => btn_dw,
					xk_bell => xk_bell,
					q => gh_nd);
	ic4: entity work. hextobcd_6bit
		port map(sohex6bit => gh_nd,
					donvi => gh_dv,
					chuc => gh_ch);
					
	ic5: entity work. d18b20_control
		port map(ckht => ckht,
					rst => rst,
					ds18b20 => ds18b20,
					nhietdo => nhietdo,
					ds_pre => ds_pre);
	ic6: entity work. hextobcd_8bit
		port map(sohex8bit => ndo_ng,
					donvi => nd_dv,
					chuc => nd_ch,
					tram => nd_tr);
	ic7: entity work. lcd_gan_dl_5so
		port map(nd_tr => nd_tr,
					nd_ch => nd_ch,
					nd_dv => nd_dv,
					nd_tp => nd_tp,
					ds_pre => ds_pre,
					gh_ch => gh_ch,
					gh_dv => gh_dv,

					lcd_h0 => lcd_h0,
					lcd_h1 => lcd_h1,
					lcd_h2 => lcd_h2,
					lcd_h3 => lcd_h3);
	
	ic8: entity work. lcd_ktao_ht
		port map(rst => rst,
					ckht => ckht,
					lcd_db => lcd_db,
					lcd_rs => lcd_rs,
					lcd_e => lcd_e,
					lcd_h0 => lcd_h0,
					lcd_h1 => lcd_h1,
					lcd_h2 => lcd_h2,
					lcd_h3 => lcd_h3);
	
	
end Behavioral;

