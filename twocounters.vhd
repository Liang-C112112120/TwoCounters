library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity twocounters is --筿隔块籔块
    Port ( rst      : in STD_LOGIC;
           clk      : in STD_LOGIC;
           count1_o : out STD_LOGIC_VECTOR (7 downto 0);
           count2_o : out STD_LOGIC_VECTOR (7 downto 0));
end twocounters;

architecture Behavioral of twocounters is

signal count1 : STD_LOGIC_VECTOR (7 downto 0); --筿隔┮Τず场癟腹
signal count2 : STD_LOGIC_VECTOR (7 downto 0);
type FSM_STATE is (s0, s1, s0_wait, s1_wait);
signal state : FSM_STATE;

begin

count1_o <= count1; --р筿隔ず场output癟腹籔场output硈钡
count2_o <= count2;

FSM: process(clk, rst, count1, count2) --0924揭祇瞷wait篈いセ块穦1clock┮рFSMい琌秈wait篈耞ㄧΑ计秸俱计Ν计计计
begin
    if rst <= '0' then
        state <= s0;
    elsif clk'event and clk = '1' then
        case state is
            when s0 => --counter1璸计い
                if count1 = "00001000" then --狦counter1计8碞秈篈单篈(s1_wait)
                    state <= s1_wait;
                end if;
            when s1_wait => --秈s1パcounter2秨﹍璸计ぇ玡氨痙clock眏琵counter1块琌0
                state <= s1;               
            when s1 => --counter2璸计い
                if count2 = "01010000" then --狦counter2计80碞秈篈单篈(s0_wait)
                    state <= s0_wait;
                end if;
            when s0_wait => --秈s0パcounter1秨﹍璸计ぇ玡氨痙clock眏琵counter2块琌253
                state <= s0;                  
            when others =>
                null;
            end case;
        end if;
end process FSM;

counter1: process(clk, rst, state) --0~9
begin
    if rst = '0' then
        count1 <= "00000000"; --癬﹍0
    elsif clk'event and clk = '1' then
        case state is
            when s0 => --counter1璸计い
                if count1 < "00001001" then --狦counter1块9
                    count1 <= count1 + 1; --秨﹍暗0~9璸计
                end if;
            when s1_wait => --counter2非称秨﹍璸计counter1块0
                count1 <= "00000000";
            when s1 => --counter2璸计いcounter1块玂0
                count1 <= "00000000";
            when s0_wait => --counter1非称秨﹍璸计counter1块砞癬﹍0
                count1 <= "00000000";
            when others =>
                null;
        end case;
    end if;
end process counter1;

counter2: process(clk, rst, state) --253~79
begin
    if rst = '0' then
        count2 <= "11111101"; --癬﹍253
    elsif clk'event and clk = '1' then
        case state is
            when s0 => --counter1璸计いcounter2块氨253
                count2 <= "11111101";
            when s1_wait => --counter2非称秨﹍璸计counter2块砞癬﹍253
                count2 <= "11111101";  
            when s1 => --counter2璸计い
                if count2 > "01001111" then --狦counter2块79
                    count2 <= count2 - 1; --秨﹍暗253~79璸计
                end if;
            when s0_wait => --counter1非称秨﹍璸计counter2块253
                count2 <= "11111101";           
            when others =>
                null;
        end case;
    end if;
end process counter2;

end Behavioral;