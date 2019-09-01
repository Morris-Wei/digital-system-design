----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/09/01 13:08:17
-- Design Name: 
-- Module Name: unloack_and_warning - Behavioral
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

entity unloack_and_warning is
  Port (
         led : buffer STD_LOGIC_VECTOR (15 downto 0);
         reset : in STD_LOGIC:='0';--重置密码键
         admin :in std_logic:='0';--管理员键
         delete:in std_logic:='0';--删除键
         ok: in std_logic:='0';--确认键
         shift:in std_logic:='0';--右移键
         clk: in std_logic:='0';--时钟信号输入
         input : in std_logic_vector(3 downto 0):="0000";
         counter: out integer:=0;
         disp_place:buffer std_logic_vector(7 downto 0):="11111111";
         disp_number:out std_logic_vector(6 downto 0):="1110111";
-----------------------------------------------------------------------------         
         state:buffer std_logic_vector(2 downto 0);--测试时先改成in
         enter:in std_logic:='0'--进入密码状态开关
         --waiting_state   等待状态         001          
         --input_state      输入密码状态   010          
         --warning_state  警报状态         011          
         --unlock_state    开锁状态         100          
         --reset_state       重置状态         101
         --signal true_code_0:in std_logic_vector(3 downto 0):="0000";---
         --signal true_code_1:in std_logic_vector(3 downto 0):="0000";---
         --signal true_code_2:in std_logic_vector(3 downto 0):="0000";---
         --signal true_code_3:in std_logic_vector(3 downto 0):="0000"---
         --signal input_code_0:in std_logic_vector(3 downto 0):="0000";---
         --signal input_code_1:in std_logic_vector(3 downto 0):="0000";---
         --signal input_code_2:in std_logic_vector(3 downto 0):="0000";---
         --signal input_code_3:in std_logic_vector(3 downto 0):="0000";---
--        signal input_count:buffer integer:=0--输入数字计数

        
        );
end unloack_and_warning;

architecture Behavioral of unloack_and_warning is

---------------------------------------------------------------------------------
signal true_code_0:std_logic_vector(3 downto 0):="0000";
signal true_code_1:std_logic_vector(3 downto 0):="0000";
signal true_code_2:std_logic_vector(3 downto 0):="0000";
signal true_code_3:std_logic_vector(3 downto 0):="0000";
signal input_code_0:std_logic_vector(3 downto 0):="0000";
signal input_code_1:std_logic_vector(3 downto 0):="0000";
signal input_code_2:std_logic_vector(3 downto 0):="0000";
signal input_code_3:std_logic_vector(3 downto 0):="0000";
signal counter_val:integer:=1;--错误计数
signal input_count:integer:=0;--输入数字计数


signal clk_10s:std_logic:='0';
signal clk_20s:std_logic:='0';
signal clk_125ms:std_logic:='0';
signal clik_10ms:std_logic:='0';
signal clik_1ms:std_logic:='0';
signal cnt_10s:std_logic_vector(29 downto 0):="000000000000000000000000000000";
signal cnt_20s:std_logic_vector(30 downto 0):="0000000000000000000000000000000";
signal cnt_125ms:std_logic_vector(24 downto 0):="0000000000000000000000000";
signal cnt_10ms:std_logic_vector(19 downto 0):="00000000000000000000";
signal cnt_1ms:std_logic_vector(16 downto 0):="00000000000000000";
signal reset_state:std_logic:='0';
signal unlock_state:std_logic:='0';
signal warning_state:std_logic:='0';
signal waiting_state:std_logic:='1';
signal input_state:std_logic:='0';
signal reset_button:std_logic:='0';
signal ok_button:std_logic:='0';
signal delete_button:std_logic:='0';
signal open_button:std_logic:='0';
signal admin_button:std_logic:='0';
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
--------------------------------------------------------------------
begin

    --process(enter,ok,state,input_count,admin)
    process(enter,state)
    begin 
        if(state="001")then
            if(enter='1'and reset='0')then
                state<="010";
            end if;
        end if;
    end process;
    
    
    process(ok,state,input_count,admin)
    begin
        if(state="010" and input_count<=3 and counter_val<=3)then--处于输入状态，且未完成一轮输入
            if(input_count=0)then--正在输入第一位密码
                if(shift'event and shift='1')then--如果按下右移键
                    input_code_0<=input;
                    input_count<=input_count+1;
                end if;
            elsif(input_count=3)then--正在输入第四位密码
                if(delete'event and delete='1')then--如果按下删除键
                    input_code_3<="0000";
                    input_count<=input_count-1;                
                elsif(ok'event and ok='1')then--如果按下ok
                    input_count<=input_count+1;--这里仍是将input_count加一，以此作为信号，表示输入一轮密码完毕
                end if;
            elsif(input_count=1)then--正在输入第二位
                if(shift'event and shift='1')then
                    input_code_1<=input;
                    input_count<=input_count+1;
                elsif(delete'event and delete='1')then
                    input_code_1<="0000";
                    input_count<=input_count-1;
                end if;
                
            elsif(input_count=2)then--正在输入第三位
                if(shift'event and shift='1')then
                    input_code_2<=input;
                    input_count<=input_count+1;
                elsif(delete'event and delete='1')then
                    input_code_2<="0000";
                    input_count<=input_count-1;
                end if;
            end if;
            
        elsif(state="010" and input_count>3 and counter_val<=3)then--完成输入四位密码，且没有进入报警状态，检验密码正确性
            if((input_code_0=true_code_0)and (input_code_1=true_code_1)and(input_code_2=true_code_2)and(input_code_3=true_code_3))then
                --密码正确，进入开锁状态
                state<="100";
            else--密码错误
                input_count<=0;
                counter_val<=counter_val+1;
            end if;
            
        elsif(state="010" and counter_val>=3)then--输错三轮密码，进入报错状态
            input_code_0<="0000";
            input_code_1<="0000";
            input_code_2<="0000";
            input_code_3<="0000";
            input_count<=0;
            counter_val<=0;
            state<="011";
        end if;
    end process;
    
    process(state,admin)
    begin
        if(state="100")then--进入开锁状态
            led<="1111111111111111";
        elsif(state="011")then--进入报警状态
            led<="0000011111100000";
            if(admin='1')then
                state<="001";--若按下管理键，进入等待状态
            end if;       
        end if;
    end process;
    
    process(input_code_0,input_code_1,input_code_2,input_code_3)--显示输入的数字
    
    
end Behavioral;
