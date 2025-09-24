library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity twocounters is --�q������J�P��X
    Port ( rst      : in STD_LOGIC;
           clk      : in STD_LOGIC;
           count1_o : out STD_LOGIC_VECTOR (7 downto 0);
           count2_o : out STD_LOGIC_VECTOR (7 downto 0));
end twocounters;

architecture Behavioral of twocounters is

signal count1 : STD_LOGIC_VECTOR (7 downto 0); --�q�����Ҧ������T��
signal count2 : STD_LOGIC_VECTOR (7 downto 0);
type FSM_STATE is (s0, s1, s0_wait, s1_wait);
signal state : FSM_STATE;

begin

count1_o <= count1; --��q��������output�T���P�~��output�s��
count2_o <= count2;

FSM: process(clk, rst, count1, count2) --0924�W�ҵo�{�bwait���A���쥻����X�|�h1��clock�A�ҥH��FSM���O�_�iwait���A���P�_�禡�ƭȽվ�@�U�A�W�Ʀ��@�ӼƦr�A�U�Ʀh�@�ӼƦr
begin
    if rst <= '0' then
        state <= s0;
    elsif clk'event and clk = '1' then
        case state is
            when s0 => --counter1�p�Ƥ�
                if count1 = "00001000" then --�p�Gcounter1�ƨ�8�N�i�U�@�Ӫ��A�����ݪ��A(s1_wait)
                    state <= s1_wait;
                end if;
            when s1_wait => --�is1��counter2�}�l�p�Ƥ��e�����d�@��clock�A�j����counter1����X�O0
                state <= s1;               
            when s1 => --counter2�p�Ƥ�
                if count2 = "01010000" then --�p�Gcounter2�ƨ�80�N�i�U�@�Ӫ��A�����ݪ��A(s0_wait)
                    state <= s0_wait;
                end if;
            when s0_wait => --�is0��counter1�}�l�p�Ƥ��e�����d�@��clock�A�j����counter2����X�O253
                state <= s0;                  
            when others =>
                null;
            end case;
        end if;
end process FSM;

counter1: process(clk, rst, state) --0~9
begin
    if rst = '0' then
        count1 <= "00000000"; --�^��_�l��0
    elsif clk'event and clk = '1' then
        case state is
            when s0 => --counter1�p�Ƥ�
                if count1 < "00001001" then --�p�Gcounter1��X�p��9
                    count1 <= count1 + 1; --�}�l��0~9���p��
                end if;
            when s1_wait => --counter2�ǳƶ}�l�p�ơAcounter1����X�^��0
                count1 <= "00000000";
            when s1 => --counter2�p�Ƥ��Acounter1����X�O��0
                count1 <= "00000000";
            when s0_wait => --counter1�ǳƶ}�l�p�ơAcounter1����X�]���_�l��0
                count1 <= "00000000";
            when others =>
                null;
        end case;
    end if;
end process counter1;

counter2: process(clk, rst, state) --253~79
begin
    if rst = '0' then
        count2 <= "11111101"; --�^��_�l��253
    elsif clk'event and clk = '1' then
        case state is
            when s0 => --counter1�p�Ƥ��Acounter2����X���b253
                count2 <= "11111101";
            when s1_wait => --counter2�ǳƶ}�l�p�ơAcounter2����X�]���_�l��253
                count2 <= "11111101";  
            when s1 => --counter2�p�Ƥ�
                if count2 > "01001111" then --�p�Gcounter2��X�j��79
                    count2 <= count2 - 1; --�}�l��253~79���p��
                end if;
            when s0_wait => --counter1�ǳƶ}�l�p�ơAcounter2����X�^��253
                count2 <= "11111101";           
            when others =>
                null;
        end case;
    end if;
end process counter2;

end Behavioral;