----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/08/31 21:30:09
-- Design Name: 
-- Module Name: digit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity digit is
  Port ( 
            input:in std_logic_vector(3 downto 0);
            input_count:in std_logic_vector(1 downto 0);
            digit_num:out std_logic_vector(6 downto 0);
            digit_sel:out std_logic_vector(7 downto 0)
        );
end digit;

architecture Behavioral of digit is

-------------------------常量表----------------------------
constant disp_0:std_logic_vector(6 downto 0):="0000001";
constant disp_1:std_logic_vector(6 downto 0):="1001111";
constant disp_2:std_logic_vector(6 downto 0):="0010010";
constant disp_3:std_logic_vector(6 downto 0):="0000110";
constant disp_4:std_logic_vector(6 downto 0):="1001100";
constant disp_5:std_logic_vector(6 downto 0):="0100100";
constant disp_6:std_logic_vector(6 downto 0):="0100000";
constant disp_7:std_logic_vector(6 downto 0):="0001111";
constant disp_8:std_logic_vector(6 downto 0):="0000000";
constant disp_9:std_logic_vector(6 downto 0):="0000100";
constant disp_void:std_logic_vector(6 downto 0):="1110111";
-------------------------------------------------------------
begin
    process(input)
    begin
        case input is
            when "0000"=>digit_num<=disp_0;
            when "0001"=>digit_num<=disp_1;
            when "0010"=>digit_num<=disp_2;
            when "0011"=>digit_num<=disp_3;
            when "0100"=>digit_num<=disp_4;
            when "0101"=>digit_num<=disp_5;
            when "0110"=>digit_num<=disp_6;
            when "0111"=>digit_num<=disp_7;
            when "1000"=>digit_num<=disp_8;
            when "1001"=>digit_num<=disp_9;
            when others=>digit_num<=disp_void;
        end case;
    end process;
    
    process(input_count)
    begin
        case input_count is
            when "00"=>digit_sel<="11111110";--与数码位置对应时，高对高，低对低
            when "01"=>digit_sel<="11111101";
            when "10"=>digit_sel<="11111011";
            when "11"=>digit_sel<="11110111";
            when others=>digit_sel<="11111111";
        end case;
    end process;
    
end Behavioral;
