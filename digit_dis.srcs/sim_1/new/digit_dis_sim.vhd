----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/09/02 09:21:20
-- Design Name: 
-- Module Name: digit_dis_sim - Behavioral
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity digit_dis_sim is
--  Port ( );
end digit_dis_sim;

architecture Behavioral of digit_dis_sim is
    component digit
    port(
            input:in std_logic_vector(3 downto 0);
            input_count:in std_logic_vector(1 downto 0);
            digit_num:out std_logic_vector(6 downto 0);
            digit_sel:out std_logic_vector(7 downto 0)
        );
    end component;
    signal input:std_logic_vector(3 downto 0):="0000";
    signal input_count:std_logic_vector(1 downto 0):="00";
    signal digit_num:std_logic_vector(6 downto 0):="0000000";
    signal digit_sel:std_logic_vector(3 downto 0):="00000000";
    constant period:time := 20 ns;
begin
    instant:digit port map
    (
        input=>input,
        input_count=>input_count,
        digit_num=>digit_num,
        digit_sel=>digit_sel
    );
    
    vec_gen:process
    begin
        wait for 25 ns;
            input(0)<='0';
        wait for 25 ns;
            input(0)<='1';
        wait for 30 ns;
            input(1)<='0';
        wait for 30 ns;
            input(1)<='1';
        wait for 35 ns;
            input(2)<='0';
        wait for 35 ns;
            input(2)<='1';
        wait for 40 ns;
            input(3)<='0';
        wait for 40 ns;
            input(3)<='1';
    end process;
    
    process
    begin
        wait for 45 ns;
            input_count(0)<='0';
        wait for 45 ns;
            input_count(0)<='1';
        wait for 50 ns;
            input_count(1)<='0';
        wait for 50 ns;
            input_count(1)<='1';                                                         
    end process;

end Behavioral;
