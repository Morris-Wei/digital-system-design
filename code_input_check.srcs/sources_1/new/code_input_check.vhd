----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/09/05 19:25:35
-- Design Name: 
-- Module Name: code_input_check - Behavioral
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

entity code_input_check is
  Port ( 
              input:in std_logic_vector(3 downto 0);
--            input_count:in std_logic_vector(1 downto 0);
              shift:in std_logic:='0';
              delete:in std_logic:='0';
              modify:in std_logic;
              clk: in std_logic;
              digit_num:out std_logic_vector(6 downto 0);
              digit_sel:out std_logic_vector(7 downto 0);
--              input_code_0:buffer std_logic_vector(3 downto 0):="0000";--输入密码第一位,外部给顶层给入
--              input_code_1:buffer std_logic_vector(3 downto 0):="0000";
--              input_code_2:buffer std_logic_vector(3 downto 0):="0000";
--              input_code_3:buffer std_logic_vector(3 downto 0):="0000";
              ok:in std_logic:='0';
-----------------------------------------------------------------------------------------------------------------
--              clk: in std_logic:='0';
--              input_code_0:in std_logic_vector(3 downto 0):="0000";--输入密码
--              input_code_1:in std_logic_vector(3 downto 0):="0000";
--              input_code_2:in std_logic_vector(3 downto 0):="0000";
--              input_code_3:in std_logic_vector(3 downto 0):="0000";   
--              true_code_0:buffer std_logic_vector(3 downto 0):="0011";--正确密码
--              true_code_1:buffer std_logic_vector(3 downto 0):="1000";
--              true_code_2:buffer std_logic_vector(3 downto 0):="0100";
--              true_code_3:buffer std_logic_vector(3 downto 0):="0110";
              correct:buffer std_logic:='0';--输入正确提示
              wrong:buffer std_logic:='0';--输入错误提示
  --            counter:buffer integer range 0 to 3:=0--  counter清零
              counter_vec:buffer std_logic_vector(2 downto 0):="000"


        );
end code_input_check;

architecture Behavioral of code_input_check is

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
constant N:integer:=500000;
---------------------------------------------------------------------------------------------------

signal input_code_0:std_logic_vector(3 downto 0):="0000";--输入密码第一位,外部给顶层给入
signal input_code_1:std_logic_vector(3 downto 0):="0000";
signal input_code_2:std_logic_vector(3 downto 0):="0000";
signal input_code_3:std_logic_vector(3 downto 0):="0000";
signal true_code_0: std_logic_vector(3 downto 0):="0011";--正确密码
signal true_code_1: std_logic_vector(3 downto 0):="1000";
signal true_code_2: std_logic_vector(3 downto 0):="0100";
signal true_code_3: std_logic_vector(3 downto 0):="0110";



             
signal input_count:std_logic_vector(1 downto 0):="00";  
signal shift_en:std_logic:='0';                         
signal delete_en:std_logic:='0';

signal ok_en:std_logic:='0';
signal counter:integer:=0;--测试时使用
                        
begin
process(input,modify,input_count)--存储并显示输入的数字                                           
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
        when "00"=>digit_sel<="11110111";--与数码位置对应时，高对高，低对低                
        when "01"=>digit_sel<="11111011";                                  
        when "10"=>digit_sel<="11111101";                                  
        when "11"=>digit_sel<="11111110";                                  
        when others=>digit_sel<="11111111";                                
    end case;                                                              
end process;                                                               
process(shift,delete)--通过左移右移改变显示及输入位数                                                      
begin                                                                      
    if(clk'event and clk='1')then                                          
        if(shift_en='1')then                                               
            case input_count is                                            
            when "00"=>input_count<="01";                                  
            when "01"=>input_count<="10";                                  
            when "10"=>input_count<="11";                                  
            when "11"=>input_count<="11";                                  
            when others=>null;                                             
            end case;                                                      
         elsif(delete_en='1')then                                          
            case input_count is                                            
             when "00"=>input_count<="00";                                 
             when "01"=>input_count<="00";                                 
             when "10"=>input_count<="01";                                 
             when "11"=>input_count<="10";                                 
             when others=>null;                                            
             end case;                                                     
        end if;                                                            
                                                                           
    end if;                                                                
end process;                                                               

process(clk)--shift按键消抖                                          
variable count_button:integer:=0;                     
                                                      
begin                                                 
    if(clk'event and clk='1')then                     
        if(shift='1')then                             
            if (count_button=N) then                  
                count_button:=count_button;           
            else                                      
                count_button:=count_button+1;         
            end if;                                   
            if(count_button=N-1)then shift_en<='1';   
            else                                      
                shift_en<='0';                        
            end if;                                   
        else                                          
            shift_en<='0';                            
        count_button:=0;                              
        end if;                                       
    end if;                                           
end process;                                          

process(clk)--delete按键消抖                                         
    variable count_button:integer:=0;                
                                                     
begin                                                
if(clk'event and clk='1')then                        
    if(delete='1')then                               
        if (count_button=N) then                     
            count_button:=count_button;              
        else                                         
            count_button:=count_button+1;            
        end if;                                      
        if(count_button=N-1)then delete_en<='1';     
        else                                         
            delete_en<='0';                          
        end if;                                      
    else                                             
        delete_en<='0';                              
    count_button:=0;                                 
    end if;                                          
end if;                                              
end process;                                         

process(ok_en)--按下确认键后核对密码
begin
    if(clk'event and clk='1')then
        if(ok_en='1')then
            if((true_code_0 = input_code_0)and(true_code_1 = input_code_1)and(true_code_2 = input_code_2)and(true_code_3 = input_code_3))then
                correct<='1';
                wrong<='0';
                counter<=0;
            else
                correct<='0';
                wrong<='1';
                counter<=counter+1;
            end if;
        end if;
    end if;
end process;

process(ok)--按键消抖
variable count_button:integer:=0;
begin
if(clk'event and clk='1')then
    if(ok='1')then
        if (count_button=N) then 
            count_button:=count_button;
        else
            count_button:=count_button+1;
        end if;
        if(count_button=N-1)then ok_en<='1';
        else 
            ok_en<='0';
        end if;
    else
        ok_en<='0';
    count_button:=0;
    end if;
end if;
end process;

process(counter)--测试用代码，检验counter是否正确
begin
    case counter is
    when 0=>counter_vec<="000";
    when 1=>counter_vec<="001";
    when 2=>counter_vec<="010";
    when 3=>counter_vec<="011";
    when 4=>counter_vec<="100";
    when 5=>counter_vec<="101";
    when 6=>counter_vec<="110";
    when 7=>counter_vec<="111";
    when others=>counter_vec<="000";
    end case;
end process;


end Behavioral;
