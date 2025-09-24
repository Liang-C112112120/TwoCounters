# TwoCounters
兩顆計數器輪流計數，1號由0數到9，2號由253數到79，每個數字只有一個時鐘週期。

使用FSM有限狀態機來控制計數器，為了讓計數器運作完整，counter1 = 0與counter2 = 253要重疊，所以在兩個原有計數狀態s0、s1再各多加一個等待狀態s0_wait、s1_wait，強制設定輸出。  
s0: counter1計數中(0~9)。  
s1_wait: 準備交給counter2計數，counter1設為起始值0。  
s1: counter2計數中(253~79)。  
sO_wait: 準備交給counter1計數，counter2設為起始值253。  
