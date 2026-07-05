%%%
%%%   Name:               CountChange.oz
%%%
%%%   Started:            Thu May  7 00:20:09 2026
%%%   Modifications:
%%%
%%%   Purpose:
%%%
%%%
%%%
%%%   Calling Sequence:
%%%
%%%
%%%   Inputs:
%%%
%%%   Outputs:
%%%
%%%   Example:
%%%
%%%   Notes:
%%%
%%%

declare
fun {Denomination Coin}
   case Coin
   of penny then 1
   [] nickel then 5
   [] dime then 10
   [] quarter then 25
   [] 'half-dollar' then 50
   end
end
fun {DefaultCoins}
   [penny nickel dime quarter 'half-dollar']
end
fun {MakeChange1 Amount Coins}
   if Amount == 0 then 1
   elseif Amount < 0 orelse Coins == nil then 0
   else {MakeChange1 Amount Coins.2} + {MakeChange1 Amount - {Denomination Coins.1} Coins}
   end
end

declare
fun {MakeChange3 Amount Coins}
   fun {FewerCoins Amount Coins}
      {MakeChange3 Amount Coins.2}
   end
   fun {LessMoney Amount Coins}
      {MakeChange3 Amount - {Denomination Coins.1} Coins}
   end
in
   if Amount == 0 then 1
   elseif Amount < 0 orelse Coins == nil then 0
   else {FewerCoins Amount Coins} + {LessMoney Amount Coins}
   end
end

declare
Cache = {NewDictionary}
fun {MakeChangeMemoized Amount Coins}
   fun {CheckCache Amount Coins Fetch}
      Value = {Dictionary.condGet Cache key(amount: Amount coins: Coins) nil}
%      Value = {Dictionary.condGet Cache Amount|Coins nil}
   in
      if Value \= nil then Value
      elseif Fetch then {MakeChangeMemoized Amount Coins}
      else nil
      end
   end
   proc {CacheValue Amount Coins Value}
      {Dictionary.put Cache key(amount: Amount coins: Coins) Value}
%      {Dictionary.put Cache Amount|Coins Value}
   end
in
   if Amount == 0 then 1
   elseif Amount < 0 orelse Coins == nil then 0
   else
      Value = {CheckCache Amount Coins false}
   in
      if Value \= nil then Value
      else
         Value = {CheckCache Amount Coins.2 true} + {CheckCache Amount - {Denomination Coins.1} Coins true}
      in
         {CacheValue Amount Coins Value}
         Value
      end
   end
end

declare
fun {CountChange Amount Coins}
   fun {CountCoins Limit Coins Sum Count}
      if Coins == nil then
         if Amount == Sum then Count+1 else Count end
      else
         V = Coins.1
      in
         {Iterate V Limit div V Limit Coins.2 Sum Count}
      end
   end
   fun {Iterate V I Limit Coins Sum Count}
      if I < 0 then Count
      else
         Value = I*V
      in
         {Iterate V I-1 Limit Coins Sum {CountCoins Limit-Value Coins Value+Sum Count}}
      end
   end
in
   {CountCoins Amount {Sort Coins Value.'<'} 0 0}
end
