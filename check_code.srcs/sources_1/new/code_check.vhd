----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/09/04 18:37:49
-- Design Name: 
-- Module Name: code_check - Behavioral
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

entity code_check is
  Port (
            ok:in std_logic:='0';
            clk: in std_logic:='0';
            input_code_0:in std_logic_vector(3 downto 0):="0000";--��������
            input_code_1:in std_logic_vector(3 downto 0):="0000";
            input_code_2:in std_logic_vector(3 downto 0):="0000";
            input_code_3:in std_logic_vector(3 downto 0):="0000";   
            true_code_0:buffer std_logic_vector(3 downto 0):="0011";--��ȷ����
            true_code_1:buffer std_logic_vector(3 downto 0):="1000";
            true_code_2:buffer std_logic_vector(3 downto 0):="0100";
            true_code_3:buffer std_logic_vector(3 downto 0):="0110";
            correct:buffer std_logic:='0';--������ȷ��ʾ
            wrong:buffer std_logic:='0';--���������ʾ
            counter:buffer integer range 0 to 3:=0--  counter����
--            counter_vec:buffer std_logic_vector(2 downto 0):="000"
         );
end code_check;

architecture Behavioral of code_check is
--signal true_code_0_tmp:std_logic_vector(3 downto 0):="0000";
--signal true_code_1_tmp:std_logic_vector(3 downto 0):="0000";
--signal true_code_2_tmp:std_logic_vector(3 downto 0):="0000";
--signal true_code_3_tmp:std_logic_vector(3 downto 0):="0000";
constant N:integer:=500000;
signal ok_en:std_logic:='0';
--signal counter:integer:=0;����ʱʹ��

begin
    process(ok_en)
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

process(ok)--��������
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

--process(counter)�����ô��룬����counter�Ƿ���ȷ
--begin
--    case counter is
--    when 0=>counter_vec<="000";
--    when 1=>counter_vec<="001";
--    when 2=>counter_vec<="010";
--    when 3=>counter_vec<="011";
--    when 4=>counter_vec<="100";
--    when 5=>counter_vec<="101";
--    when 6=>counter_vec<="110";
--    when 7=>counter_vec<="111";
--    when others=>counter_vec<="000";
--    end case;
--end process;

end Behavioral;
