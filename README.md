# TwoCounters
兩顆計數器輪流計數，counter1由0數到9，counter2由253數到79，每個數字只有一個時鐘週期。

使用FSM有限狀態機來控制計數器，為了讓計數器運作完整，起始值也要佔一個clock，否則會出現例如counter1開始計數的第一個輸出是1而不是0的問題，老師特別提到counter1 = 0與counter2 = 253要重疊，所以在兩個原有計數狀態s0、s1再各多加一個等待狀態s0_wait、s1_wait，強制設定輸出。  
  
s0 : counter1計數中(0到9)。  
s1_wait : 準備交給counter2計數，counter1設為起始值0。  
s1 : counter2計數中(253到79)。  
s0_wait : 準備交給counter1計數，counter2設為起始值253。  

模擬結果：  
<img width="1209" height="162" alt="simulation" src="https://github.com/user-attachments/assets/bdda5f89-f51b-4205-b19f-bd31e1e5cf36" />
