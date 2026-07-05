%%%
%%%   Name:               change.oz
%%%
%%%   Started:            Sat Feb  2 12:22:37 2013
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

declare CountChange CC FirstDenomination
fun {CountChange Amount}
   {CC Amount 5}
end
fun {CC Amount KindsOfCoins}
   if Amount == 0 then 1
   elseif Amount < 0 orelse KindsOfCoins == 0 then 0
   else {CC Amount KindsOfCoins-1} + {CC Amount-{FirstDenomination KindsOfCoins} KindsOfCoins}
   end
end      
fun {FirstDenomination KindsOfCoins}
   case KindsOfCoins
   of 1 then 1
   [] 2 then 5
   [] 3 then 10
   [] 4 then 25
   [] 5 then 50
   end
end

{Browse {CountChange 100}}

declare
fun {Denomination Coin}
   case Coin
   of penny then 1
   [] nickel then 5
   [] dime then 10
   [] quarter then 25
   [] halfDollar then 50
   end
end

{Browse {Denomination penny}}
{Browse {Denomination dime}}

declare
fun {MakeChange Amount Coins}
   if Amount == 0 then 1
   elseif Amount < 0 orelse Coins == nil then 0
   else
      Coin|Rest = Coins
   in
      {MakeChange Amount Rest} + {MakeChange Amount-{Denomination Coin} Coins}
   end
end

{Browse {MakeChange 100 [quarter penny nickel halfDollar dime]}}

declare MakeChange FewerCoins LessMoney
fun {MakeChange Amount Coins}
   First|Rest = Coins
in
   {FewerCoins Amount Rest} + {LessMoney Amount-{Denomination First} Coins}
end
fun {FewerCoins Amount Coins}
   if Coins == nil then 0
   else {MakeChange Amount Coins}
   end
end
fun {LessMoney Amount Coins}
   if Amount == 0 then 1
   elseif Amount < 0 then 0
   else {MakeChange Amount Coins}
   end
end