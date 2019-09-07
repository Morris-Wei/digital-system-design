----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/09/05 21:29:49
-- Design Name: 
-- Module Name: controler - Behavioral
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

entity controler is
  Port (    
            clk:in std_logic:='0';--
            reset : in STD_LOGIC:='0';--重置密码键，外部给顶层输入，和周共用，reset优先级高于enter--
            admin :in std_logic:='0';--管理员键，外部给顶层输入，私有--
            correct :in std_logic:='0';
            wrong:in std_logic:='0';
            ok:in std_logic:='0';--进入密码状态开关，外部给顶层输--
            counter: buffer integer:=0;--错误计数，给顶层输出，用于状态转换
            state:buffer std_logic_vector(2 downto 0):="001"--顶层输入，测试时先改成in
            --counter_vec:buffer std_logic_vector(2 downto 0):="000"测试时使用

            
            );
end controler;

architecture Behavioral of controler is
constant waiting_state:std_logic_vector(2 downto 0):="001";
constant reset_state:std_logic_vector(2 downto 0):="101";
constant input_state:std_logic_vector(2 downto 0):="010";
constant unlock_state:std_logic_vector(2 downto 0):="100";
constant warning_state:std_logic_vector(2 downto 0):="011";
constant invalid_state:std_logic_vector(2 downto 0):="000";
constant N:integer:=500000;

--signal counter:integer:=0;
signal ok_en:std_logic:='0';
signal reset_en:std_logic:='0'; 
signal admin_en:std_logic:='0';
signal correct_en:std_logic:='0';
signal wrong_en:std_logic:='0';
--signal counter_vec:std_logic_vector(2 downto 0):="000";
begin
    process(clk)--状态转换
    begin
        if(clk'event and clk='1')then
            case state is
            when waiting_state=>if(reset_en='1')then state<=reset_state;
                                elsif(ok_en='1')then state<=input_state;
                                end if;
            when input_state=>if(counter>=3)then state<=warning_state;--缺个interval
                              elsif(counter<3 and wrong='0' and correct='1')then state<=unlock_state;--测试用wrong_en,correct_en
                              elsif(counter<3 and wrong='1' and correct='0')then counter<=counter+1;--测试用wrong_en,correct_en
                              end if;
            when unlock_state=>if(ok_en='1' )then state<=waiting_state;--还有interval尚未加入
                               end if;
            when warning_state=>if(admin_en='1')then state<=waiting_state;
                                end if;
            when reset_state=>if(ok_en='1')then state<=waiting_state;
                                end if;
            when others=>state<=waiting_state;--容错
            end case;
            
        end if;
    
end process;

--process(counter)
--begin 
--    case counter is
--    when 0=>counter_vec<="000";
--    when 1=>counter_vec<="001";
--    when 2=>counter_vec<="010";
--    when 3=>counter_vec<="011";
--    when 4=>counter_vec<="100";
--    when others=>counter_vec<="111";
--    end case;
--end process;

process(clk)--ok键消抖
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

process(clk)--reset键消抖
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


process(clk)--admin键消抖
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


--process(clk)--correct键消抖
--    variable count_button:integer:=0;
--begin
--if(clk'event and clk='1')then
--    if(correct='1')then
--        if (count_button=N) then 
--            count_button:=count_button;
--        else
--            count_button:=count_button+1;
--        end if;
--        if(count_button=N-1)then correct_en<='1';
--        else 
--            correct_en<='0';
--        end if;
--    else
--        correct_en<='0';
--    count_button:=0;
--    end if;
--end if;
--end process; 


--process(clk)--wrong键消抖
--    variable count_button:integer:=0;
--begin
--if(clk'event and clk='1')then
--    if(wrong='1')then
--        if (count_button=N) then 
--            count_button:=count_button;
--        else
--            count_button:=count_button+1;
--        end if;
--        if(count_button=N-1)then wrong_en<='1';
--        else 
--            wrong_en<='0';
--        end if;
--    else
--        wrong_en<='0';
--    count_button:=0;
--    end if;
--end if;
--end process; 


end Behavioral;
