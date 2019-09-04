----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/09/02 21:13:30
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
            input:in std_logic_vector(3 downto 0);--输入的那位密码，二进制
            input_count:in std_logic_vector(1 downto 0);--输入的那位密码位于第几位，二进制
            modify:in std_logic;--是否修改，为1时,input管脚对应的数字被送入相应的input_code中，并在数码管上显示
            clk: in std_logic;--时钟信号，频率10Mhz
            digit_num:out std_logic_vector(6 downto 0);--一个数码管显示的管子位置（对应abcdefg）
            digit_sel:out std_logic_vector(7 downto 0);--数字显示的位置（对应1，2，3，4）
            input_code_0:buffer std_logic_vector(3 downto 0):="0000";--第一位密码
            input_code_1:buffer std_logic_vector(3 downto 0):="0000";--第二位
            input_code_2:buffer std_logic_vector(3 downto 0):="0000";
            input_code_3:buffer std_logic_vector(3 downto 0):="0000"

        );
end digit;

architecture Behavioral of digit is

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

begin
process(input,modify,input_count)
begin
    if(clk'event and clk='1')then
        if(modify='1')then
            case input is
                when "0000"=>digit_num<=disp_0;
                              case input_count is
                                  when "00"=>input_code_0<="0000";
                                  when "01"=>input_code_1<="0000";
                                  when "10"=>input_code_2<="0000";
                                  when "11"=>input_code_3<="0000";
                                  when others=>null;
                              end case;
                when "0001"=>digit_num<=disp_1;
                              case input_count is
                              when "00"=>input_code_0<="0001";
                              when "01"=>input_code_1<="0001";
                              when "10"=>input_code_2<="0001";
                              when "11"=>input_code_3<="0001";
                              when others=>null;
                              end case;
                when "0010"=>digit_num<=disp_2;
                              case input_count is
                              when "00"=>input_code_0<="0010";
                              when "01"=>input_code_1<="0010";
                              when "10"=>input_code_2<="0010";
                              when "11"=>input_code_3<="0010";
                              when others=>null;
                              end case;
    
                when "0011"=>digit_num<=disp_3;
                              case input_count is
                               when "00"=>input_code_0<="0011";
                               when "01"=>input_code_1<="0011";
                               when "10"=>input_code_2<="0011";
                               when "11"=>input_code_3<="0011";
                               when others=>null;
                               end case;
    
                when "0100"=>digit_num<=disp_4;
                            case input_count is
                            when "00"=>input_code_0<="0100";
                            when "01"=>input_code_1<="0100";
                            when "10"=>input_code_2<="0100";
                            when "11"=>input_code_3<="0100";
                            when others=>null;
                            end case;   
    
                when "0101"=>digit_num<=disp_5;
                
                              case input_count is
                            when "00"=>input_code_0<="0101";
                            when "01"=>input_code_1<="0101";
                            when "10"=>input_code_2<="0101";
                            when "11"=>input_code_3<="0101";
                            when others=>null;
                            end case;
    
                when "0110"=>digit_num<=disp_6;
                
                              case input_count is
                                when "00"=>input_code_0<="0110";
                                when "01"=>input_code_1<="0110";
                                when "10"=>input_code_2<="0110";
                                when "11"=>input_code_3<="0110";
                                when others=>null;
                                end case;
    
                when "0111"=>digit_num<=disp_7;
                
                              case input_count is
                            when "00"=>input_code_0<="0111";
                            when "01"=>input_code_1<="0111";
                            when "10"=>input_code_2<="0111";
                            when "11"=>input_code_3<="0111";
                            when others=>null;
                            end case;
    
                when "1000"=>digit_num<=disp_8;
                
                              case input_count is
                            when "00"=>input_code_0<="1000";
                            when "01"=>input_code_1<="1000";
                            when "10"=>input_code_2<="1000";
                            when "11"=>input_code_3<="1000";
                            when others=>null;
                            end case;
                
                when "1001"=>digit_num<=disp_9;
                
                              case input_count is
                            when "00"=>input_code_0<="1001";
                            when "01"=>input_code_1<="1001";
                            when "10"=>input_code_2<="1001";
                            when "11"=>input_code_3<="1001";
                            when others=>null;
                            end case;
    
                when others=>digit_num<=disp_void;
        end case;
        elsif(modify='0')then
            case input_count is
            when "00"=>
                case input_code_0 is
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
            when "01"=>
                case input_code_1 is
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

            when "10"=>
                case input_code_2 is
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
            when "11"=>
            case input_code_3 is
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
            when others=>null;
        end case;
        end if;
    end if;
end process;
    
process(input_count)
begin    
    case input_count is
        when "00"=>digit_sel<="11110111";--������λ�ö�Ӧʱ���߶Ըߣ��ͶԵ�
        when "01"=>digit_sel<="11111011";
        when "10"=>digit_sel<="11111101";
        when "11"=>digit_sel<="11111110";
        when others=>digit_sel<="11111111";
    end case;
end process;

end Behavioral;