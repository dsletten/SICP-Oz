%%%
%%%   Name:               Primes.oz
%%%
%%%   Started:            Wed May 20 14:24:39 2026
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
fun {Square X}
   X * X
end
fun {SmallestDivisor N}
   {FindDivisor N 2}
end
fun {FindDivisor N TestDivisor}
   if {Square TestDivisor} > N then N
   elseif {Divides TestDivisor N} then TestDivisor
   else {FindDivisor N TestDivisor+1}
   end
end
fun {Divides D N}
   N mod D == 0
end
fun {IsPrime N}
   % N > 1 !!
   N == {SmallestDivisor N}
end

declare
fun {ExpMod Base Exp M}
   if Exp == 0 then 1
   elseif {IsEven Exp} then {Square {ExpMod Base (Exp div 2) M}} mod M
   else (Base * {ExpMod Base (Exp - 1) M}) mod M
   end
end
fun {RandomRange A B}
   if A > B then
      {RandomRange B A}
   else
      ({OS.rand} mod (B - A + 1)) + A
   end
end
fun {FermatTest N}
   fun {TryIt A}
      {ExpMod A N N} == A
   end
in
   {TryIt {RandomRange 1 (N - 1)}}
end
fun {FastIsPrime N Times}
   if Times == 0 then true
   elseif {FermatTest N} then {FastIsPrime N (Times - 1)}
   else false
   end
end

{Show {FastIsPrime 2 10}}
{Show {FastIsPrime 4 10}}
{Show {FastIsPrime 99 10}}
{Show {FastIsPrime 1729 10}} % Carmichael Number!!
{Show {FastIsPrime 15485849 10}}

%%%
%%%    1.23
%%%
declare
fun {Square X}
   X * X
end
fun {SmallestDivisor N}
   {FindDivisor N 2}
end
fun {FindDivisor N TestDivisor}
   fun {Next Divisor}
      if Divisor == 2 then 3
      else Divisor + 1
      end
   end
in
   if {Square TestDivisor} > N then N
   elseif {Divides TestDivisor N} then TestDivisor
   else {FindDivisor N {Next TestDivisor}}
   end
end
fun {Divides D N}
   N mod D == 0
end
fun {IsPrime N}
   % N > 1 !!
   N == {SmallestDivisor N}
end

{Show {IsPrime 2}}
{Show {IsPrime 4}}
{Show {IsPrime 99}}
{Show {IsPrime 1729}} % Carmichael Number!!
{Show {IsPrime 15485849}}

declare
fun {SmallestDivisor N}
   {FindDivisor N 2}
end
fun {FindDivisor N TestDivisor}
   if {Square TestDivisor} > N then N
   elseif {Divides TestDivisor N} then TestDivisor
   else {FindDivisor N if TestDivisor == 2 then 3 else TestDivisor + 1 end}
   end
end
fun {IsPrime N}
   % N > 1 !!
   N == {SmallestDivisor N}
end

declare
fun {SmallestDivisor N}
   {FindDivisor N 2}
end
fun {FindDivisor N TestDivisor}
   fun {Find Divisor}
      if {Square Divisor} > N then N
      elseif {Divides Divisor N} then Divisor
      else {FindOdd Divisor + 1}
      end
   end
   fun {FindOdd Divisor}
      if {Square Divisor} > N then N
      elseif {Divides Divisor N} then Divisor
      else {FindOdd Divisor + 2}
      end
   end
in
   {Find TestDivisor}
end
fun {IsPrime N}
   % N > 1 !!
   N == {SmallestDivisor N}
end

%%%
%%%    1.27
%%%
declare
fun {IsCarmichael N}
   fun {Confirm A}
      if A == N then true
      elseif {ExpMod A N N} == A then {Confirm A + 1}
      else false
      end
   end
in
   {Confirm 1} andthen {Not {IsPrime N}}
end

{Show {IsCarmichael 561}} 
{Show {IsCarmichael 1105}} 
{Show {IsCarmichael 1729}} 
{Show {IsCarmichael 2465}} 
{Show {IsCarmichael 2821}} 
{Show {IsCarmichael 6601}} 
{Show {IsCarmichael 41041}} 
{Show {IsCarmichael 41041}} 
{Show {IsCarmichael 62745}} 
{Show {IsCarmichael 63973}} 
{Show {IsCarmichael 75361}} 
{Show {IsCarmichael 101101}} 
{Show {IsCarmichael 126217}} 
{Show {IsCarmichael 172081}} 
{Show {IsCarmichael 188461}} 
{Show {IsCarmichael 278545}} 
{Show {IsCarmichael 340561}} 
{Show {IsCarmichael 825265}}

%%%
%%%    1.28
%%%
declare
fun {ExpMod Base Exp M}
   fun {IsTrivial X}
      if X == 1 orelse X == (M - 1) then 1
      else
         Y = {Square X} mod M
      in
         if Y == 1 then false
         else Y
         end
      end
   end
in
   if Exp == 0 then 1
   elseif {IsEven Exp} then
      Y = {IsTrivial {ExpMod Base (Exp div 2) M}}
   in
      case Y
      of false then 0
      else Y
      end
   else
      (Base * {ExpMod Base (Exp - 1) M}) mod M
   end
end
fun {MillerRabin N}
   fun {TryIt A}
      {ExpMod A (N - 1) N} == 1
   end
in
   {TryIt {RandomRange 2 (N - 2)}}
end
fun {FastIsPrimeMr N Times}
   if Times == 0 then true
   elseif {MillerRabin N} then {FastIsPrimeMr N (Times - 1)}
   else false
   end
end

{Show {FastIsPrimeMr 1729 5}} % Carmichael Number!!
{Show {FastIsPrimeMr 15485849 5}}

%%%
%%%    https://rosettacode.org/wiki/Miller-Rabin_primality_test#Oz
%%%
%--------------------------------------------------------------------------%
% module: Primality
% file: Primality.oz
% version: 17 DEC 2014 @ 6:50AM
%--------------------------------------------------------------------------%

declare
%--------------------------------------------------------------------------%

fun {IsPrime N}			% main interface of module
   if N < 2 then false
   elseif N < 4 then true
   elseif (N mod 2) == 0 then false
   elseif N < 341330071728321 then {IsMRprime N {DetWit N}}
   else {IsMRprime N {ProbWit N 20}}
   end
end
%--------------------------------------------------------------------------%

fun {DetWit N}			% deterministic witnesses
   if N < 1373653 then [2 3]
   elseif N < 9080191 then [31 73]
   elseif N < 25326001 then [2 3 5]
   elseif N < 3215031751 then [2 3 5 7]
   elseif N < 4759123141 then [2 7 61]
   elseif N < 1122004669633 then [2 13 23 1662803]
   elseif N < 2152302898747 then [2 3 5 7 11]
   elseif N < 3474749660383 then [2 3 5 7 11 13]
   elseif N < 341550071728321 then [2 3 5 7 11 13 17]
   else nil
   end
end
%--------------------------------------------------------------------------%

fun {ProbWit N K}		% probabilistic witnesses
   local A B C in
      A = 6364136223846793005
      B = 1442695040888963407
      C = N - 2
      {RWloop N A B C K nil}
   end
end

fun {RWloop N A B C K L}
   local N1 in
      N1 = (((N * A) + B) mod C) + 1
      if K == 0 then L
      else {RWloop N1 A B C (K - 1) N1|L}
      end
   end
end
%--------------------------------------------------------------------------%

fun {IsMRprime N As}	% the Miller-Rabin algorithm	
%   local D S T Ts in
   local D S in
      {FindDS N} = D|S
      {OuterLoop N As D S}
   end
end

fun {OuterLoop N As D S}
   local A At Base C in
      As = A|At
      Base = {Powm A D N}
      C = {InnerLoop Base N 0 S}
      if {Not C} then false 
%      elseif {And C (At == nil)} then true 
      elseif C andthen At == nil then true 
      else {OuterLoop N At D S} 
      end
   end
end
							
fun {InnerLoop Base N Loop S}
   local NextBase NextLoop in
      NextBase = (Base * Base) mod N
      NextLoop = Loop + 1
%      if {And (Loop == 0) (Base == 1)} then true
      if Loop == 0 andthen Base == 1 then true
      elseif Base == (N - 1) then true
      elseif NextLoop == S then false
      else {InnerLoop NextBase N NextLoop S}    
      end
   end
end
%--------------------------------------------------------------------------%
%%%%    N-1 = 2^S * D
fun {FindDS N}
   {FindDS1 (N - 1) 0}
end

fun {FindDS1 D S}
   if (D mod 2 == 0) then {FindDS1 (D div 2) (S + 1)}
   else D|S
   end
end
%--------------------------------------------------------------------------%
%%%    Same as SICP ExpMod (above)	
fun {Powm A D N} 		% returns (A ^ D) mod N
   if D == 0 then 1
   elseif (D mod 2) == 0 then {Pow {Powm A (D div 2) N} 2} mod N
   else (A * {Powm A (D - 1) N}) mod N
   end
end
%--------------------------------------------------------------------------%	
% end_module Primality