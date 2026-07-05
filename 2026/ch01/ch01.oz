%%%
%%%   Name:               ch01.oz
%%%
%%%   Started:            Sun Feb 15 13:30:59 2026
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

%%%
%%%    1.3
%%%
declare
fun {Square X}
   X * X
end
fun {SumOfSquares X Y}
   {Square X} + {Square Y}
end

declare
fun {SumSquareMax A B C}
   if A < B then
      if A < C then
         {SumOfSquares B C}
      else
         {SumOfSquares A B}
      end
   else
      if B < C then
         {SumOfSquares A C}
      else
         {SumOfSquares A B}
      end
   end
end


{Show 20 == {SumSquareMax 2 4 1}}
{Show 20 == {SumSquareMax 2 4 2}}
{Show 25 == {SumSquareMax 2 4 3}}
{Show 32 == {SumSquareMax 2 4 4}}
{Show 41 == {SumSquareMax 2 4 5}}
{Show 20 == {SumSquareMax 4 2 1}}
{Show 20 == {SumSquareMax 4 2 2}}
{Show 25 == {SumSquareMax 4 2 3}}
{Show 32 == {SumSquareMax 4 2 4}}
{Show 41 == {SumSquareMax 4 2 5}}
{Show 18 == {SumSquareMax 3 3 1}}
{Show 18 == {SumSquareMax 3 3 3}}
{Show 34 == {SumSquareMax 3 3 5}}


declare
fun {SumSquareMax A B C}
   if A < B andthen A < C then {SumOfSquares B C}
   elseif {Not A < B} andthen B < C then {SumOfSquares A C}
   else {SumOfSquares A B}
   end
end

% (defun discard-min (xs)
%   "Remove the smallest value from list."
%   (labels ((discard (target l result)
%              (cond ((endp l) result)
%                    ((< (first l) target) (discard (first l) (rest l) (cons target result)))
%                    (t (discard target (rest l) (cons (first l) result)))) ))
%     (if (null xs)
%         '()
%         (discard (first xs) (rest xs) '()))) )

% (defun sum-square-max (a b c)
%   (apply #'sum-of-squares (discard-min (list a b c))))

%%%
%%%    "Bubblesort"
%%%
declare
fun {SumSquareMax A B C}
   if B < A then {SumSquareMax B A C}
   elseif C < B then {SumSquareMax A C B}
   else {SumOfSquares B C}
   end
end

declare
fun {Median A B C}
   {Min {Max A B}
    {Max {Min A B} C}}
end

declare
fun {Median A B C}
   if B < A then {Median B A C}
   elseif C < B then {Median A C B}
   else B
   end
end

%%%
%%%    1.6
%%%
declare
fun {SqrtIter Guess X}
   if {IsGoodEnough Guess X} then Guess
   else {SqrtIter {Improve Guess X} X}
   end
end
fun {Improve Guess X}
   {Average Guess X/Guess}
end
fun {Average X Y}
   (X+Y)/2.0
end
fun {IsGoodEnough Guess X}
   {Abs {Square Guess} - X} < 0.001
end
fun {Sqrt X}
   {SqrtIter 1.0 X}
end

   
%%%
%%%    1.8
%%%
declare
fun {CbrtIter Guess X}
   if {IsGoodEnoughCbrt Guess X} then Guess
   else {CbrtIter {ImproveCbrt Guess X} X}
   end
end
fun {ImproveCbrt Guess X}
   (2.0 * Guess + X / {Square Guess}) / 3.0
end
fun {Cube X}
   X * X * X
end
fun {IsGoodEnoughCbrt Guess X}
   {Abs ({Cube Guess} - X) / X} < 0.001
end
fun {Cbrt X}
   {CbrtIter 1.0 X}
end



declare
fun {Factorial N}
   if N == 1 then 1
   else N*{Factorial N-1}
   end
end


%%%
%%%    1.9
%%%
declare
fun {Inc X} X + 1 end
fun {Dec X} X - 1 end
fun {Add A B}
   if A == 0 then B
   else {Inc {Add {Dec A} B}}
   end
end
fun {Add_ A B}
   if A == 0 then B
   else {Add_ {Dec A} {Inc B}}
   end
end

{Show {Add 4 5}}
{Show {Add_ 4 5}}

%%%
%%%    1.10
%%%
declare
fun {A X Y}
   if Y == 0 then 0
   elseif X == 0 then 2 * Y
   elseif Y == 1 then 2
   else {A X-1 {A X Y-1}}
   end
end
fun {F N} {A 0 N} end
fun {G N} {A 1 N} end
fun {H N} {A 2 N} end

for I in 1..10 do {Show {F I}} end

for I in 1..10 do {Show {G I}} end

for I in 1..4 do {Show {H I}} end

%%%
%%%    1.11
%%%
declare
fun {Fibonacci N}
   fun {Iterate Current Next I}
      if I == N then Current
      else {Iterate Next Current+Next I+1}
      end
   end
in
   {Iterate 0 1 0}
end

{Show {Fibonacci 0}}
{Show {Fibonacci 1}}
{Show {Fibonacci 2}}
{Show {Fibonacci 3}}
{Show {Fibonacci 30}}
{Show {Fibonacci 100}}

declare
fun {Sicponacci N}
   if N < 3 then N
   else {Sicponacci N-1} + 2*{Sicponacci N-2} + 3*{Sicponacci N-3}
   end
end

{Show {Sicponacci 0}}
{Show {Sicponacci 1}}
{Show {Sicponacci 2}}
{Show {Sicponacci 3}}
{Show {Sicponacci 4}}
{Show {Sicponacci 10}}
{Show {Sicponacci 20}}
{Show {Sicponacci 30}}

declare
fun {SicponacciIter N}
   fun {Iterate Current Next Subsequent I}
      if I == N then Current
      else {Iterate Next Subsequent (Subsequent + 2*Next + 3*Current) I+1}
      end
   end
in
   {Iterate 0 1 2 0}
end

{Show {SicponacciIter 0}}
{Show {SicponacciIter 1}}
{Show {SicponacciIter 2}}
{Show {SicponacciIter 3}}
{Show {SicponacciIter 4}}
{Show {SicponacciIter 10}}
{Show {SicponacciIter 20}}
{Show {SicponacciIter 30}}
{Show {SicponacciIter 100}}

%%%
%%%    1.15
%%%
declare
fun {BadSine Theta}
   fun {IsSufficientlySmall Theta}
      {Abs Theta} =< 0.001
   end
in
   if {IsSufficientlySmall Theta} then Theta
   else 3.0 * {BadSine Theta/3.0} - 4.0 * {Cube {BadSine Theta/3.0}}
   end
end
fun {ReduceSine X}
   3.0 * X - 4.0 * {Cube X}
end
fun {Sine Theta}
   fun {IsSufficientlySmall Theta}
      {Abs Theta} =< 0.001
   end
in
   if {IsSufficientlySmall Theta} then Theta
   else {ReduceSine {Sine Theta / 3.0}}
   end
end

%%%
%%%    1.16
%%%
declare
fun {Multiply X Y} X * Y end
fun {SlowExpt B N}
   if N == 0 then 1
   else {Multiply B {SlowExpt B N-1}}
   end
end
fun {SlowExptIter B N}
   fun {Iterate Counter Product}
      if Counter == 0 then Product
      else {Iterate Counter-1 {Multiply B Product}}
      end
   end
in
   {Iterate N 1}
end
fun {Square X} {Multiply X X} end
fun {FastExpt B N}
   if N == 0 then 1
   elseif {IsEven N} then {Square {FastExpt B N div 2}}
   else {Multiply B {FastExpt B N-1}}
   end
end
fun {FastExptIter B N}
   fun {Iterate A B N}
      if N == 0 then A
      elseif {IsEven N} then {Iterate A {Square B} N div 2}
      else {Iterate {Multiply A B} B N-1}
      end
   end
in
   {Iterate 1 B N}
end

{Show {SlowExpt 7 9}}
{Show {SlowExptIter 7 9}}
{Show {FastExpt 7 9}}
{Show {FastExptIter 7 9}}

%%%
%%%    1.17/1.18
%%%
declare
fun {Add X Y} X + Y end
fun {SlowTimes A B}
   if B == 0 then 0
   else {Add A {SlowTimes A B-1}}
   end
end
fun {SlowTimesIter A B}
   fun {Iterate Counter Sum}
      if Counter == 0 then Sum
      else {Iterate Counter-1 {Add A Sum}}
      end
   end
in
   {Iterate B 0}
end
fun {Halve X} X div 2 end
fun {Double X} {Add X X} end
fun {FastTimes A B}
   if B == 0 then 0
   elseif {IsEven B} then {Double {FastTimes A {Halve B}}}
   else {Add A {FastTimes A B-1}}
   end
end
fun {FastTimesIter A B}
   fun {Iterate S A B}
      if B == 0 then S
      elseif {IsEven B} then {Iterate S {Double A} {Halve B}}
      else {Iterate {Add S A} A B-1}
      end
   end
in
   {Iterate 0 A B}
end

{Show {SlowTimes 6 7}}
{Show {SlowTimesIter 6 7}}
{Show {FastTimes 6 7}}
{Show {FastTimesIter 6 7}}

%%%
%%%    1.19
%%%
declare
fun {FastFibIter N}
   fun {Iterate A B P Q Count}
      if Count == 0 then B
      elseif {IsEven Count} then {Iterate A B (P*P + Q*Q) (Q*Q + 2*P*Q) Count div 2}
      else {Iterate (B*Q + A*Q + A*P) (B*P + A*Q) P Q Count-1}
      end
   end
in
   {Iterate 1 0 0 1 N}
end

{Show {FastFibIter 1000}}

%%%
%%%    H.O. Functions
%%%
declare
fun {SumIntegers A B}
   if A > B then 0
   else A + {SumIntegers (A + 1) B}
   end
end

{Show {SumIntegers 1 10}}
{Show {SumIntegers 1 20} - {SumIntegers 1 9} == {SumIntegers 10 20}}

declare
fun {SumIntegers A B}
   for I in A..B sum:S do
      {S I}
   end
end

%%%
%%%    D'oh!
%%%    
% declare SumIntegers in
% proc {SumIntegers A B Result1}
%    local ForIntVarLo1 ForIntVarHi1 ForAccu1 S ForProc1 in
%       A = ForIntVarLo1
%       B = ForIntVarHi1
%       {`For.mksum` ForAccu1}
%       proc {S V1}
% 	 {`For.sum` ForAccu1 V1}
%       end
%       proc {ForProc1 I}
% 	 local IfArbiter1 in
% 	    IfArbiter1 = I =< ForIntVarHi1
% 	    if IfArbiter1 then
% 	       local UnnestApply1 UnnestApply2 in
% 		  {S I}
% 		  UnnestApply2 = 1
% 		  UnnestApply1 = I + UnnestApply2
% 		  {ForProc1 UnnestApply1}
% 	       end
% 	    else
% 	       skip skip
% 	    end
% 	 end
%       end
%       {ForProc1 ForIntVarLo1}
%       {`For.retint` ForAccu1 Result1}
%    end
% end

declare
fun {SumCubes A B}
   if A > B then 0
   else {Cube A} + {SumCubes (A + 1) B}
   end
end

declare
fun {SumCubes A B}
   for I in A..B sum:S do
      {S {Cube I}}
   end
end

{Show {SumCubes 1 3}}
{Show {SumCubes 1 10}}
{Show {SumCubes 1 100}}
{Show {SumCubes 8 15}}

declare
fun {PiSum A B}
   if A > B then 0.0
   else (1.0 / (A * (A + 2.0))) + {PiSum (A + 4.0) B}
   end
end

{Show {PiSum 1.0 12.0} * 8.0}
{Show {PiSum 1.0 100.0} * 8.0}
{Show {PiSum 1.0 1000.0} * 8.0}
{Show {PiSum 1.0 10000.0} * 8.0}

% declare
% fun {PiSum A B}
%    for I in A..B sum:S do
%       {S (1.0 / ({IntToFloat I} * ({IntToFloat I} + 2.0)))}  % Can only sum integers!
%    end
% end

% {Show {PiSum 1 12} * 8.0}
% {Show {PiSum 1 100} * 8.0}
% {Show {PiSum 1 1000} * 8.0}
% {Show {PiSum 1 10000} * 8.0}

declare
fun {Sum Term Next A B Initial}
   if A > B then Initial
   else {Term A} + {Sum Term Next {Next A} B Initial}
   end
end

declare
fun {Sum Term Next A B Initial}
   fun {Iterate A Result}
      if A > B then Result
      else {Iterate {Next A} (Result + {Term A})}
      end
   end
in
   {Iterate A Initial}
end

declare
fun {SumIntegersHO A B}
   {Sum Lisp.identity Core.inc A B 0}
end
fun {PiSumHO A B}
   {Sum fun {$ X} (1.0 / (X * (X + 2.0))) end
        fun {$ X} X + 4.0 end 
        A
        B
        0.0}
end

{Show {SumIntegersHO 1 10}}
{Show {SumIntegersHO 1 20} - {SumIntegersHO 1 9} == {SumIntegersHO 10 20}}

{Show {PiSumHO 1.0 12.0} * 8.0}
{Show {PiSumHO 1.0 100.0} * 8.0}
{Show {PiSumHO 1.0 1000.0} * 8.0}
{Show {PiSumHO 1.0 10000.0} * 8.0}


%%%
%%%    1.29
%%%
declare
fun {Simpsons F A B N}
   H = (B - A) / {IntToFloat N}
   fun {X K} A + {IntToFloat K} * H end
   fun {SumElements}
      {Odd 1 {F A}}
   end
   fun {Even K Sum}
      if K == N then Sum + {F B}
      else {Odd (K + 1) (Sum + (2.0 * {F {X K}}))}
      end
   end
   fun {Odd K Sum}
      {Even (K + 1) (Sum + (4.0 * {F {X K}}))}
   end
in
   H * {SumElements} / 3.0
end

{Show {Simpsons Cube 0.0 1.0 10}}
{Show {Simpsons Cos 0.0 Lisp.pi 10}}
{Show {Simpsons Cos 0.0 (Lisp.pi / 2.0) 10}}
{Show {Simpsons fun {$ X} X end 0.0 1.0 10}}
{Show {Simpsons fun {$ X} 2.0 * X + 3.0 end 0.0 1.0 10}}

declare
fun {Simpsons F A B N}
   H = (B - A) / {IntToFloat N}
   fun {X K} A + {IntToFloat K} * H end
   fun {Element K}
      if {IsEven K} then 2.0 * {F {X K}}
      else 4.0 * {F {X K}}
      end
   end
   fun {SumElements}
      {F A} + {Sum Element Core.inc 1 (N - 1) 0.0} + {F B}
   end
in
   H * {SumElements} / 3.0
end

%%%
%%%    1.31
%%%
declare
fun {Product Term Next A B Initial}
   if A > B then Initial
   else {Term A} * {Product Term Next {Next A} B Initial}
   end
end

declare
fun {Product Term Next A B Initial}
   fun {Iterate A Result}
      if A > B then Result
      else {Iterate {Next A} (Result * {Term A})}
      end
   end
in
   {Iterate A Initial}
end
fun {FactorialProduct N}
   {Product Lisp.identity Core.inc 1 N 1}
end
% fun {PiProduct A B}
%    fun {Term I}
%       (2.0 * {IntToFloat (I div 2) + 1}) /
%       (2.0 * {IntToFloat (I + 1) div 2} + 1.0)
%    end
% in
%    {Product Term Core.inc A B 1.0}
% end
fun {PiProduct A B}
   fun {Term I}
      X = {IntToFloat I}
   in
      (2.0 * ({Floor X / 2.0} + 1.0)) /
      ((2.0 * {Ceil X / 2.0}) + 1.0)
   end
in
   {Product Term Core.inc A B 1.0}
end

{Show {FactorialProduct 3}}      
{Show {FactorialProduct 10}}

{Show {PiProduct 1 10} * 4.0}
{Show {PiProduct 1 100} * 4.0}
{Show {PiProduct 1 1000} * 4.0}
{Show {PiProduct 1 10000} * 4.0}
{Show {PiProduct 1 100000} * 4.0}
{Show {PiProduct 1 1000000} * 4.0}

%%%
%%%    1.32
%%%
declare
fun {Accumulate Combiner NullValue Term Next A B}
   if A > B then NullValue
   else {Combiner {Term A} {Accumulate Combiner NullValue Term Next {Next A} B}}
   end
end
fun {AccumulateSum Term Next A B}
   {Accumulate Number.'+' 0 Term Next A B} % Float??
end
fun {AccumulateProduct Term Next A B}
   {Accumulate Number.'*' 1 Term Next A B}
end

{Show {AccumulateSum Lisp.identity Core.inc 1 100}}
{Show {AccumulateProduct Lisp.identity Core.inc 1 10}}

declare
fun {Accumulate Combiner NullValue Term Next A B}
   fun {Iterate A Result}
      if A > B then Result
      else {Iterate {Next A} {Combiner Result {Term A}}}
      end
   end
in
   {Iterate A NullValue}
end
fun {AccumulateSum Term Next A B}
   {Accumulate Number.'+' 0 Term Next A B} % Float??
end
fun {AccumulateProduct Term Next A B}
   {Accumulate Number.'*' 1 Term Next A B}
end

%%%
%%%    1.33
%%%
declare
fun {FilteredAccumulate Pred Combiner NullValue Term Next A B}
   if A > B then NullValue
   elseif {Pred A} then {Combiner {Term A} {FilteredAccumulate Pred Combiner NullValue Term Next {Next A} B}}
   else {FilteredAccumulate Pred Combiner NullValue Term Next {Next A} B}
   end
end
fun {FilteredAccumulateFactorial N}
   {FilteredAccumulate {Lisp.constantly true} Number.'*' 1 Lisp.identity Core.inc 1 N}
end
fun {SumPrimeSquares A B}
   {FilteredAccumulate fun {$ N} N > 1 andthen {IsPrime N} end Number.'+' 0 Square Core.inc A B}
end

{Show {FilteredAccumulateFactorial 10}}
{Show {SumPrimeSquares 1 5}}

declare
fun {FilteredAccumulate Pred Combiner NullValue Term Next A B}
   fun {Iterate A Result}
      if A > B then Result
      elseif {Pred A} then {Iterate {Next A} {Combiner Result {Term A}}}
      else {Iterate {Next A} Result}
      end
   end
in
   {Iterate A NullValue}
end
fun {FilteredAccumulateFactorial N}
   {FilteredAccumulate {Lisp.constantly true} Number.'*' 1 Lisp.identity Core.inc 1 N}
end
fun {SumPrimeSquares A B}
   {FilteredAccumulate fun {$ N} N > 1 andthen {IsPrime N} end Number.'+' 0 Square Core.inc A B}
end
fun {RelativePrimeProduct N}
   {FilteredAccumulate fun {$ M} {Lisp.gcd M N} == 1 end Number.'*' 1 Lisp.identity Core.inc 1 (N - 1)}
end

{Show {RelativePrimeProduct 1}}
{Show {RelativePrimeProduct 2}}
{Show {RelativePrimeProduct 3}}
{Show {RelativePrimeProduct 4}}
{Show {RelativePrimeProduct 5}}
{Show {RelativePrimeProduct 6}}

declare
fun {Search F A B}
   fun {IsCloseEnough X Y}
      {Abs X - Y} < 0.001
   end
   Midpoint = {Average A B}
in
   if {IsCloseEnough A B} then Midpoint
   else
      Y = {F Midpoint}
   in
      if {Lisp.plusp Y} then {Search F A Midpoint}
      elseif {Lisp.minusp Y} then {Search F Midpoint B}
      else Midpoint
      end
   end
end
fun {HalfIntervalMethod F A B}
   AVal = {F A}
   BVal = {F B}
in
   if {Core.enclosedBy 0.0 AVal BVal} then {Search F A B}
   elseif {Core.enclosedBy 0.0 BVal AVal} then {Search F B A}
   else raise "Values are not of opposite sign ("#A#" "#B#")" end
   end
end

{Show {HalfIntervalMethod Sin 2.0 4.0}}
{Show {HalfIntervalMethod fun {$ X} {Cube X} - (2.0 * X) - 3.0 end 1.0 2.0}}
      
declare
fun {FixedPoint F Initial}
   Tolerance = 0.00001
   fun {IsCloseEnough X0 X1}
      {Abs X0 - X1} < Tolerance
   end
   fun {Try Guess}
      Next = {F Guess}
   in
      if {IsCloseEnough Guess Next} then Next
      else {Try Next}
      end
   end
in
   {Try Initial}
end

{Show {FixedPoint Cos 1.0}}
{Show {FixedPoint fun {$ X} {Sin X} + {Cos X} end 1.0}}

%%%
%%%    1.35
%%%
declare
fun {GoldenRatio}
   {FixedPoint fun {$ X} 1.0 + 1.0 / X end 1.0}
end

{Show {GoldenRatio}}

%%%
%%%    1.36
%%%
declare
fun {FixedPointVerbose F Initial}
   Tolerance = 0.00001
   fun {IsCloseEnough X0 X1}
      {Abs X0 - X1} < Tolerance
   end
   fun {Try Guess}
      Next = {F Guess}
   in
      {System.showInfo "Guess: "#Guess#" Next: "#Next}
      if {IsCloseEnough Guess Next} then Next
      else {Try Next}
      end
   end
in
   {Try Initial}
end
fun {XX Initial}
   {FixedPointVerbose fun {$ X} {Log 1000.0} / {Log X} end Initial}
end
fun {XXAverage Initial}
   {FixedPointVerbose fun {$ X} {Average X ({Log 1000.0} / {Log X})} end Initial}
end

{Show {XX 2.0}}
{Show {XXAverage 2.0}}

%%%
%%%    1.37
%%%
declare
fun {ContFrac N D K}
   fun {Recur I}
      if I > K then 0.0
      else {N I} / ({D I} + {Recur I + 1})
      end
   end
in
   {Recur 1}
end
fun {ContFracIter N D K}
   fun {Iterate I Result}
      if {Lisp.zerop I} then Result
      else {Iterate (I - 1) {N I} / ({D I} + Result)}
      end
   end
in
   {Iterate K 0.0}
end

{Show 1.0 / {ContFrac {Lisp.constantly 1.0} {Lisp.constantly 1.0} 1000000}}
{Show 1.0 / {ContFracIter {Lisp.constantly 1.0} {Lisp.constantly 1.0} 1000000}}

%%%
%%%    1.38
%%%
declare
fun {Eminus2 K}
   {ContFrac {Lisp.constantly 1.0}
    fun {$ I}
       case I mod 3
       of 2 then 2.0 * {Ceil {IntToFloat I} / 3.0}
       else 1.0
       end
    end
    K}
end
fun {Eminus2Clever K}
   {ContFrac {Lisp.constantly 1.0}
    fun {$ I}
       1.0 + (1.0 + (2.0 * {Floor {IntToFloat I} / 3.0})) *
             {Floor ({IntToFloat I mod 3} + 1.0) / 3.0}
    end
    K}
end

{Show {Eminus2 100}}
{Show {Eminus2Clever 100}}

%%%
%%%    1.39
%%%
declare
fun {TanCF X K}
   {ContFrac
    fun {$ I}
       if I == 1 then X
       else ~(X * X)
       end
    end
    fun {$ I}
       2.0 * {IntToFloat I} - 1.0
    end
    K}
end

{Show {TanCF Lisp.pi / 4.0 10}}
{Show {Tan Lisp.pi / 4.0}}

declare
fun {AverageDamp F}
   fun {$ X}
      {Average X {F X}}
   end
end
fun {SqrtAd X}
   {FixedPoint {AverageDamp fun {$ Y} X / Y end} 1.0}
end

{Show {SqrtAd 16.0}}
{Show {SqrtAd 15.0}}

declare
fun {CbrtAd X}
   {FixedPoint {AverageDamp fun {$ Y} X / {Square Y} end} 1.0}
end

{Show {CbrtAd 8.0}}
{Show {CbrtAd 9.0}}

declare
fun {Deriv G}
   Dx = 0.00001
in
   fun {$ X}
      ({G X + Dx} - {G X}) / Dx
   end
end

{Show {fun {$ X} (6.0 * X) + 9.0 end 6.01}}
{Show {{Deriv fun {$ X} (3.0 * X * X) + (9.0 * X) end} 6.01}}

declare
fun {NewtonTransform G}
   GPrime = {Deriv G}
in
   fun {$ X}
      X - ({G X} / {GPrime X})
   end
end
fun {NewtonsMethod G Guess}
   {FixedPoint {NewtonTransform G} Guess}
end
fun {SqrtNewton X}
   {NewtonsMethod fun {$ Y} {Square Y} - X end 1.0}
end

{Show {SqrtNewton 8.0}}
{Show {SqrtNewton 9.0}}
{Show {SqrtNewton 19.0}}

declare
fun {FixedPointOfTransform G Transform Guess}
   {FixedPoint {Transform G} Guess}
end
fun {SqrtAdXform X}
   {FixedPointOfTransform fun {$ Y} X / Y end AverageDamp 1.0}
end
fun {SqrtNewtonXform X}
   {FixedPointOfTransform fun {$ Y} {Square Y} - X end NewtonTransform 1.0}
end

{Show {SqrtAdXform 8.0}}
{Show {SqrtAdXform 9.0}}
{Show {SqrtAdXform 19.0}}

{Show {SqrtNewtonXform 8.0}}
{Show {SqrtNewtonXform 9.0}}
{Show {SqrtNewtonXform 19.0}}

%%%
%%%    1.40
%%%
declare
fun {Cubic A B C}
   fun {$ X}
      {Cube X} + (A * {Square X}) + (B * X) + C
   end
end

{Show {NewtonsMethod {Cubic ~9.0 26.0 ~24.0} 2.0}}
{Show {NewtonsMethod {Cubic ~9.0 26.0 ~24.0} 3.0}}
{Show {NewtonsMethod {Cubic ~9.0 26.0 ~24.0} 4.0}}

%%%
%%%    1.41
%%%
declare
fun {Double F}
   fun {$ X}
      {F {F X}}
   end
end

{Show {{Double Inc} 5}}

{Show {{Double {Double Inc}} 5}}
{Show {{{Double Double} Inc} 5}}

{Show {{Double {Double {Double Inc}}} 5}}
{Show {{Double {{Double Double} Inc}} 5}}
{Show {{{Double Double} {Double Inc}} 5}}

{Show {{Double {Double {Double {Double Inc}}}} 5}}
{Show {{{Double {Double Double}} Inc} 5}}
{Show {{{{Double Double} Double} Inc} 5}}

%%%
%%%    1.42
%%%
%%%    Denys Duchier
%%%
declare
fun {Compose L}
   case L
   of [F] then F
   [] F|L then G={Compose L} in
      fun {$ X} {F {G X}} end
   end
end

declare
fun {Compose Fs}
   case Fs
   of nil then Lisp.identity
   [] F|Fr then {FoldL Fr fun {$ F G} fun {$ X} {F {G X}} end end F}
   end
end

%%%
%%%    1.43
%%%
declare
fun {Repeated F N}
   if N == 0 then Lisp.identity
   elseif N == 1 then F
   else {Compose [F {Repeated F (N - 1)}]}
   end
end
fun {RepeatedIter F N}
   fun {Repeat N Result}
      if N == 0 then Result
      else {Repeat (N - 1) fun {$ X} {F {Result X}} end}
      end
   end
in
   if N == 0 then Lisp.identity
   else {Repeat (N - 1) F}
   end
end

{Show {{Repeated Square 2} 5}}
{Show {{RepeatedIter Square 0} 5}}
{Show {{RepeatedIter Square 1} 5}}
{Show {{RepeatedIter Square 2} 5}}

%%%
%%%    1.44
%%%
declare
fun {Smooth F}
   Dx = 0.00001
in
   fun {$ X}
      ({F (X - Dx)} + {F X} + {F (X + Dx)}) / 3.0
   end
end

{Show {{Smooth Square} 4.0}}

%%%
%%%    1.45
%%%
declare
fun {NthRoot N}
   fun {$ X}
      {FixedPoint {{Repeated AverageDamp {FloatToInt {Floor {Lisp.log2 {IntToFloat N} 2.0}}}}
                   fun {$ Y} X / {Pow Y {IntToFloat N - 1}} end}
       1.0}
   end
end

{Show {{NthRoot 3} 8.0}}