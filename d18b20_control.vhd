----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:24:54 04/29/2025 
-- Design Name: 
-- Module Name:    d18b20_control - Behavioral 
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

entity d18b20_control is
    Port ( ckht : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           ds18b20 : inout  STD_LOGIC;
           ds_pre : out  STD_LOGIC;
           nhietdo : out  STD_LOGIC_VECTOR (11 downto 0));
end d18b20_control;

architecture Behavioral of d18b20_control is
constant m1_skip_rom: std_logic_vector(7 downto 0):=x"cc";
constant m1_convert: std_logic_vector(7 downto 0):=x"44";
constant m1_read_ram: std_logic_vector(7 downto 0):=x"be";
signal ds_in, ds_out, ds_ena: std_logic;
signal dlg: std_logic_vector(7 downto 0):= x"00";
signal dln: std_logic_vector(11 downto 0);
type state_type is (
	reset,
	skip_rom,
	write_byte,
	write_bit0,
	write_bit1,
	read_bit,
	convert_t,
	read_scrat,
	get_temp,
	wait_4ms);
signal state: state_type:= reset;
signal j: integer range 0 to 200001:=0;
signal k: integer range 0 to 13:=0;

signal tt: integer range 0 to 4:=0;
signal tt_rst: integer range 0 to 3:=0;

signal tt_wr_b0: integer range 0 to 1:=0;
signal tt_wr_b1: integer range 0 to 1:=0;
signal tt_rd_b: integer range 0 to 3:=0;


begin
	ds18b20 <= ds_out when ds_ena = '1' else 'Z';
	
	process(state, ckht, rst)
	begin
		if rst = '1' then state <= reset;
								tt <= 0;
								tt_wr_b0 <= 0;
								tt_wr_b1 <= 0;
								k <= 0;
								tt_rd_b <= 0;
								dlg <= "00000001";
		elsif rising_edge(ckht) then
			case state is
				when reset => 
					case tt_rst is
						when 0 => ds_out <= '0';
									 ds_ena <= '1';
									 if j < 25000 then j <= j+1;
									 else j <= 0;
											tt_rst <=1;
									 end if;
						when 1 => ds_ena <= '0';
									 if j < 500 then j <= j+ 1;
									 else j <= 0;
											tt_rst <= 2;
									 end if;
						when 2 => ds_ena <= '0';
									 if j < 12000 then j <= j+1;
									 else j <= 0;
											tt_rst <= 3;
									 end if;
									 if j = 3000 then ds_pre <= ds18b20;
															ds_in <= ds18b20;
									 end if;
						when 3 => tt_rst <= 0;
									 if ds_in = '0' then state <= skip_rom;
									 else state <= reset;
									 end if;
					end case;
				when skip_rom => dlg <= m1_skip_rom;
									  state <= write_byte;
				when write_byte =>
					case k is
						when 0 to 7 => if dlg(k) = '0' then 
												state <= write_bit0;
											else state <= write_bit1;
											end if;
											k <= k+1;
						when 8 => 		if tt = 0 then tt <= 1;
												state <= convert_t;
											elsif tt = 1 then tt <=2;
												state <= reset;
											elsif tt = 2 then tt <= 3;
												state <= read_scrat;
											elsif tt = 3 then tt <= 0;
												state <= get_temp;
											end if;
											k <= 0;
						when others => state <= reset;
					end case;
				when write_bit0 =>
					case tt_wr_b0 is
						when 0 => ds_out <= '0';
									 ds_ena <= '1';
									 if j < 3500 then j <= j + 1;
									 else j<=0;
											tt_wr_b0 <= 1;
									 end if;
						when 1 => ds_ena <= '0';
									 if j < 250 then j <= j + 1;
									 else j <= 0;
											tt_wr_b0 <= 0;
											state <= write_byte;
									 end if;
						end case;
				when write_bit1 =>
					case tt_wr_b1 is 
						when 0 => ds_out <= '0';
									 ds_ena <= '1';
									 if j < 400 then j <= j + 1;
									 else j <= 0;
											tt_wr_b1 <= 1;
									 end if;
						when 1 => ds_ena <= '0';
									 if j < 3600 then j <= j + 1;
									 else j <= 0;
											tt_wr_b1 <= 0;
											state <= write_byte;
									 end if;
						end case;
				when convert_t => dlg <= m1_convert;
										state <= write_byte;
				when read_scrat => dlg <= m1_read_ram;
										 state <= write_byte;
				when read_bit =>
					case tt_rd_b is
						when 0 => ds_out <= '0';
									 ds_ena <= '1';
									 if j < 200 then j <= j + 1;
									 else j <= 0;
											tt_rd_b <= 1;
									 end if;
						when 1 => ds_ena <= '0';
									 if j < 200 then j <= j+ 1;
									 else j <= 0;
											tt_rd_b <= 2;
									 end if;
						when 2 => ds_ena <= '0';
									 ds_in <= ds18b20;
									 if j < 50 then j <= j + 1;
									 else j <= 0;
											tt_rd_b <= 3;
									 end if;
						when 3 => ds_ena <= '0';
									 if j < 2750 then j <= j+1;
									 else j <= 0;
											tt_rd_b <= 0;
											state <= get_temp;
									 end if;
					end case;
				
				when get_temp => 
					case k is
						when 0 => state <= read_bit;
									 k <= k + 1;
						when 1 to 12 => state <= read_bit;
											 dln(k-1) <= ds_in;
											 k <= k + 1;
						when 13 => k <= 0;
									  state <= wait_4ms;
					end case;
				
				when wait_4ms => if j < 200000 then 
											j <= j + 1;
											state <= wait_4ms;
									  else j <= 0;
											state <= reset;
									  end if;
			end case;
		end if;
	end process;
	
	nhietdo <= dln;
						

end Behavioral;

