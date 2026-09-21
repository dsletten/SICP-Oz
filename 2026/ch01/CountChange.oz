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
[Lisp] = {Module.link ['/home/slytobias/oz/modules/Lisp.ozf']}
[Core] = {Module.link ['/home/slytobias/oz/modules/Core.ozf']}

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

declare
fun {BuildCoins Coins Values}
   fun {Build Coin Value}
      if Coin == 0 then nil
      else Value|{Build {Core.dec Coin} Value}
      end
   end
in
   case Coins#Values
   of nil#nil then nil
   [] (Coin|Coins)#(Value|Values) then
      {Append {Build Coin Value} {BuildCoins Coins Values}}
   end
end
fun {Exercism Amount Coins}
   fun {PathLength Path}
      {FoldL Path Number.'+' 0}
   end
   fun {IsInvalidPath Path Candidate}
      Path \= nil andthen {PathLength Candidate} >= {PathLength Path}
   end
   fun {MakeChange Coins CandidateCoins CandidateValues Limit Path}
      case Coins
      of nil then
         if Amount == {FoldL CandidateValues Number.'+' 0} then CandidateCoins else Path end
      [] V|Coins then
         {Iterate V (Limit div V) Limit Coins CandidateCoins CandidateValues Path}
      end
   end
   fun {Iterate V N Limit Coins CandidateCoins CandidateValues Path}
      if N < 0 orelse {IsInvalidPath Path N|CandidateCoins} then Path
      else Value = N * V in
         {Iterate V {Core.dec N} Limit Coins CandidateCoins CandidateValues
          {MakeChange Coins N|CandidateCoins Value|CandidateValues (Limit - Value) Path}}
      end
   end
   Ascending = {Sort Coins Value.'<'}
   Descending = {Sort Coins Value.'>'}
in
   {BuildCoins {MakeChange Descending nil nil Amount nil} Ascending}
end

{Show {BuildCoins [0 2 1 0 2 1 9] [1 2 5 10 20 50 100]}}

{Show {Exercism 1 [1 5 10 25]}}
{Show {Exercism 25 [1 5 10 25 100]}}
{Show {Exercism 15 [1 5 10 25 100]}}
{Show {Exercism 23 [1 4 15 20 50]}}
{Show {Exercism 63 [1 5 10 21 25]}}
{Show {Exercism 999 [1 2 5 10 20 50 100]}}
{Show {Exercism 21 [2 5 10 20 50]}}
{Show {Exercism 27 [4 5]}}
{Show {Exercism 20 [1 10 11]}}
{Show {Exercism 0 [1 5 10 21 25]}}
{Show {Exercism 3 [5 10]}}
{Show {Exercism 94 [5 10]}}
{Show {Exercism ~5 [1 2 5]}}


         
         