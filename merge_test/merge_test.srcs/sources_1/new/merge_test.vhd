----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/09/07 19:45:34
-- Design Name: 
-- Module Name: merge_test - Behavioral
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

entity merge_test is
  Port (
              input:in std_logic_vector(3 downto 0);
--            input_count:in std_logic_vector(1 downto 0);
              shift:in std_logic:='0';
              delete:in std_logic:='0';
              modify:in std_logic:='0';
              clk: in std_logic:='0';
              digit_num:out std_logic_vector(6 downto 0);
              digit_sel:out std_logic_vector(7 downto 0);
              ok:in std_logic:='0';
--              input_code_0:in std_logic_vector(3 downto 0):="0000";--��������
--              input_code_1:in std_logic_vector(3 downto 0):="0000";
--              input_code_2:in std_logic_vector(3 downto 0):="0000";
--              input_code_3:in std_logic_vector(3 downto 0):="0000";   
--              true_code_0:buffer std_logic_vector(3 downto 0):="0011";--��ȷ����
--              true_code_1:buffer std_logic_vector(3 downto 0):="1000";
--              true_code_2:buffer std_logic_vector(3 downto 0):="0100";
--              true_code_3:buffer std_logic_vector(3 downto 0):="0110";
                correct:buffer std_logic:='0';--������ȷ��ʾ
                wrong:buffer std_logic:='0';--���������ʾ
------------------------------------------����������---------------------------------------------------
                reset : in STD_LOGIC:='0';--������������ⲿ���������룬���ܹ��ã�reset���ȼ�����enter--
                admin :in std_logic:='0';--����Ա�����ⲿ���������룬˽��--
                --counter: buffer integer:=0;--������������������������״̬ת��
                state:buffer std_logic_vector(2 downto 0):="001";--�������룬����ʱ�ȸĳ�in
                counter_vec:buffer std_logic_vector(2 downto 0):="000"--����ʱʹ��

                
                

         );
end merge_test;

architecture Behavioral of merge_test is
----------------------------------------������-------------------------------------------------------------------
constant waiting_state:std_logic_vector(2 downto 0):="001";
constant reset_state:std_logic_vector(2 downto 0):="101";
constant input_state:std_logic_vector(2 downto 0):="010";
constant unlock_state:std_logic_vector(2 downto 0):="100";
constant warning_state:std_logic_vector(2 downto 0):="011";
constant invalid_state:std_logic_vector(2 downto 0):="000";
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
----------------------------------------------------------------------------------------------------------------

signal counter:integer:=0;
signal ok_en:std_logic:='0';
signal reset_en:std_logic:='0'; 
signal admin_en:std_logic:='0';
signal correct_en:std_logic:='0';
signal wrong_en:std_logic:='0';
signal shift_en:std_logic:='0';                         
signal delete_en:std_logic:='0';

--signal counter_vec:std_logic_vector(2 downto 0):="000";
----------------------------------------------�����������--------------------------------------------------------
signal input_code_0:std_logic_vector(3 downto 0):="1111";--���������һλ
signal input_code_1:std_logic_vector(3 downto 0):="1111";
signal input_code_2:std_logic_vector(3 downto 0):="1111";
signal input_code_3:std_logic_vector(3 downto 0):="1111";
signal true_code_0: std_logic_vector(3 downto 0):="0000";--��ȷ����
signal true_code_1: std_logic_vector(3 downto 0):="0000";
signal true_code_2: std_logic_vector(3 downto 0):="0000";
signal true_code_3: std_logic_vector(3 downto 0):="0000";

signal input_count:std_logic_vector(1 downto 0):="00";  

begin
process(clk)--״̬��״̬ת��������ϵͳ������
begin
        if(clk'event and clk='1')then
            case state is
            when waiting_state=>if(reset_en='1')then state<=reset_state;
                                elsif(ok_en='1')then state<=input_state;
                                end if;
            when input_state=>if(counter>=3)then state<=warning_state;--ȱ��interval
                              elsif(counter<3 and wrong='0' and correct='1')then state<=unlock_state;--������wrong_en,correct_en
                              end if;
            when unlock_state=>if(ok_en='1' )then state<=waiting_state;--����interval��δ����
                               end if;
            when warning_state=>if(admin_en='1')then state<=waiting_state;
                                end if;
            when reset_state=>if(ok_en='1')then state<=waiting_state;
                                end if;
            when others=>state<=waiting_state;--�ݴ�
            end case;
            
        end if;
    
end process;


--����3�����ǰ�������
process(clk)--ok������
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



process(clk)--reset������
    variable count_button:integer:=0;
begin
if(clk'event and clk='1')then
    if(reset='1')then
        if (count_button=N) then 
            count_button:=count_button;
        else
            count_button:=count_button+1;
        end if;
        if(count_button=N-1)then reset_en<='1';
        else 
            reset_en<='0';
        end if;
    else
        reset_en<='0';
    count_button:=0;
    end if;
end if;

end process;



process(clk)--admin������
    variable count_button:integer:=0;
begin
if(clk'event and clk='1')then
    if(admin='1')then
        if (count_button=N) then 
            count_button:=count_button;
        else
            count_button:=count_button+1;
        end if;
        if(count_button=N-1)then admin_en<='1';
        else 
            admin_en<='0';
        end if;
    else
        admin_en<='0';
    count_button:=0;
    end if;
end if;
end process;
-------------------------------------------------------------------------------------------------------------
--������ʾ����
process(input,modify,input_count)--�洢����ʾ���������                                           
begin
    if(clk'event and clk='1')then
    if(state=input_state)then                                                                                                                  
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
    
-------------------------------------------------------------------------------------------------------------    
    
    if(state=reset_state)then                                                                                                                  
    if(modify='1')then                                                  
        case input is                                                   
            when "0000"=>digit_num<=disp_0;                             
                          case input_count is                           
                              when "00"=>true_code_0<="0000";          
                              when "01"=>true_code_1<="0000";          
                              when "10"=>true_code_2<="0000";          
                              when "11"=>true_code_3<="0000";          
                              when others=>null;                        
                          end case;                                     
            when "0001"=>digit_num<=disp_1;                             
                          case input_count is                           
                          when "00"=>true_code_0<="0001";              
                          when "01"=>true_code_1<="0001";              
                          when "10"=>true_code_2<="0001";              
                          when "11"=>true_code_3<="0001";              
                          when others=>null;                            
                          end case;                                     
            when "0010"=>digit_num<=disp_2;                             
                          case input_count is                           
                          when "00"=>true_code_0<="0010";              
                          when "01"=>true_code_1<="0010";              
                          when "10"=>true_code_2<="0010";              
                          when "11"=>true_code_3<="0010";              
                          when others=>null;                            
                          end case;                                     
                                                                        
            when "0011"=>digit_num<=disp_3;                             
                          case input_count is                           
                           when "00"=>true_code_0<="0011";             
                           when "01"=>true_code_1<="0011";             
                           when "10"=>true_code_2<="0011";             
                           when "11"=>true_code_3<="0011";             
                           when others=>null;                           
                           end case;                                    
                                                                        
            when "0100"=>digit_num<=disp_4;                             
                        case input_count is                             
                        when "00"=>true_code_0<="0100";                
                        when "01"=>true_code_1<="0100";                
                        when "10"=>true_code_2<="0100";                
                        when "11"=>true_code_3<="0100";                
                        when others=>null;                              
                        end case;                                       
                                                                        
            when "0101"=>digit_num<=disp_5;                             
                                                                        
                          case input_count is                           
                        when "00"=>true_code_0<="0101";                
                        when "01"=>true_code_1<="0101";                
                        when "10"=>true_code_2<="0101";                
                        when "11"=>true_code_3<="0101";                
                        when others=>null;                              
                        end case;                                       
                                                                        
            when "0110"=>digit_num<=disp_6;                             
                                                                        
                          case input_count is                           
                            when "00"=>true_code_0<="0110";            
                            when "01"=>true_code_1<="0110";            
                            when "10"=>true_code_2<="0110";            
                            when "11"=>true_code_3<="0110";            
                            when others=>null;                          
                            end case;                                   
                                                                        
            when "0111"=>digit_num<=disp_7;                             
                                                                        
                          case input_count is                           
                        when "00"=>true_code_0<="0111";                
                        when "01"=>true_code_1<="0111";                
                        when "10"=>true_code_2<="0111";                
                        when "11"=>true_code_3<="0111";                
                        when others=>null;                              
                        end case;                                       
                                                                        
            when "1000"=>digit_num<=disp_8;                             
                                                                        
                          case input_count is                           
                        when "00"=>true_code_0<="1000";                
                        when "01"=>true_code_1<="1000";                
                        when "10"=>true_code_2<="1000";                
                        when "11"=>true_code_3<="1000";                
                        when others=>null;                              
                        end case;                                       
                                                                        
            when "1001"=>digit_num<=disp_9;                             
                                                                        
                          case input_count is                           
                        when "00"=>true_code_0<="1001";                
                        when "01"=>true_code_1<="1001";                
                        when "10"=>true_code_2<="1001";                
                        when "11"=>true_code_3<="1001";                
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

    
       
    if(state=unlock_state or(state=reset_state and ok_en='1'))then--Ϊ��֤��ȫ��������ȷ����������
        digit_num<=disp_void;
        input_code_0<="1111";
        input_code_1<="1111";
        input_code_2<="1111";
        input_code_3<="1111";
    end if;

    
end if;                                                                 
end process;                                                                




process(input_count,state)--�л���ʾλ                                                      
begin
if(clk'event and clk='1')then
if(state=input_state or state=reset_state)then                                                                      
    case input_count is                                                    
        when "00"=>digit_sel<="11110111";--������λ�ö�Ӧʱ���߶Ըߣ��ͶԵ�                
        when "01"=>digit_sel<="11111011";                                  
        when "10"=>digit_sel<="11111101";                                  
        when "11"=>digit_sel<="11111110";                                  
        when others=>digit_sel<="11111111";                                
    end case;
elsif(state=unlock_state or(state=reset_state and ok_en='1'))then--Ϊ��֤��ȫ��������ȷ�Լ�����������ɺ����ʾλȫ�����
    digit_sel<="11111111";
end if;
end if;
end process;

                                                               
process(shift,delete)--ͨ���������Ƹı���ʾ������λ��                                                      
begin
if(state=input_state or state=reset_state)then                                                                      
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
end if;                                                                
end process;                                                               



process(clk)--shift��������                                          
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

process(clk)--delete��������                                         
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

process(ok)--����ȷ�ϼ���˶�����
begin
if(clk'event and clk='1')then
if(state=input_state)then
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

if(state=warning_state)then--�ɱ���״̬�������ȴ�״̬��֮ǰ���������������ȷ״̬������0
        if(admin_en='1')then
            counter<=0;
            correct<='0';
            wrong<='0';
        end if;
    end if;
    
if(state=unlock_state)then--������ȷ״̬�󷵻����ȴ�״̬��֮ǰ���������������ȷ״̬������0
    if(ok_en='1')then
        counter<=0;
        correct<='0';
        wrong<='0';
    end if;
end if;

end if;
end process;

process(counter)--�����ô��룬����counter�Ƿ���ȷ
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