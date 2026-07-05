%%%
%%%   Name:               ch01.oz
%%%
%%%   Started:            Sat Feb  2 22:52:40 2013
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
fun {SumSquareMax A B C}
   if A =< B andthen B =< C then {SumOfSquares B C}
   elseif A =< C andthen C =< B then {SumOfSquares B C}
   elseif B =< A andthen A =< C then {SumOfSquares A C}
   elseif B =< C andthen C =< A then {SumOfSquares A C}
   elseif C =< A andthen A =< B then {SumOfSquares A B}
   elseif C =< B andthen B =< A then {SumOfSquares A B}
   end
end

declare
proc {TestSumSquareMax}
   {Browse {SumSquareMax 2 4 1} == 20}
   {Browse {SumSquareMax 2 4 2} == 20}
   {Browse {SumSquareMax 2 4 3} == 25}
   {Browse {SumSquareMax 2 4 4} == 32}
   {Browse {SumSquareMax 2 4 5} == 41}
   {Browse {SumSquareMax 3 3 1} == 18}
   {Browse {SumSquareMax 3 3 3} == 18}
   {Browse {SumSquareMax 3 3 5} == 34}
   {Browse {SumSquareMax 4 2 1} == 20}
   {Browse {SumSquareMax 4 2 2} == 20}
   {Browse {SumSquareMax 4 2 3} == 25}
   {Browse {SumSquareMax 4 2 4} == 32}
   {Browse {SumSquareMax 4 2 5} == 41}
end

{TestSumSquareMax}

declare
fun {SumSquareMax A B C}
   if A =< B then
      if A =< C then {SumOfSquares B C}
      else {SumOfSquares A B}
      end
   else
      if B =< C then {SumOfSquares A C}
      else {SumOfSquares A B}
      end
   end
end
         
declare
fun {Max2 A B C}
   if A < B then
      if A < C then [B C]
      else [A B]
      end
   else
      if B < C then [A C]
      else [A B]
      end
   end
end

{Browse {Max2 2 4 1}}
{Browse {Max2 2 4 5}}
{Browse {Max2 3 3 5}}
{Browse {Max2 4 2 3}}

declare
fun {Max2 Min Mid Max}
   if Mid < Min then {Max2 Mid Min Max}
   elseif Max < Min then {Max2 Max Mid Min}
   elseif Max < Mid then {Max2 Min Max Mid}
   else [Mid Max]
   end
end
      
declare
fun {Max2 A B C}
   [{Max A B} {Max {Min A B} C}]
end

declare
fun {Median A B C}
   {Min {Max {Min A B} C} {Max A B}}
end

declare
proc {TestMedian}
   {Browse {Median 2 4 1} == 2}
   {Browse {Median 2 4 2} == 2}
   {Browse {Median 2 4 3} == 3}
   {Browse {Median 2 4 4} == 4}
   {Browse {Median 2 4 5} == 4}
   {Browse {Median 3 3 1} == 3}
   {Browse {Median 3 3 3} == 3}
   {Browse {Median 3 3 5} == 3}
   {Browse {Median 4 2 1} == 2}
   {Browse {Median 4 2 2} == 2}
   {Browse {Median 4 2 3} == 3}
   {Browse {Median 4 2 4} == 4}
   {Browse {Median 4 2 5} == 4}
end

{TestMedian}

%%%
%%%    1.10
%%%
declare
fun {Ackermann X Y}
   if Y == 0 then 0
   elseif X == 0 then 2 * Y
   elseif Y == 1 then 2
   else {Ackermann X-1 {Ackermann X Y-1}}
   end
end

{Browse {Ackermann 0 4}}
{Browse {Ackermann 1 4}}
{Browse {Ackermann 2 5}}

%%%
%%%    1.13
%%%    
declare
fun {Fibonacci N}
   fun {Fib A B Count}
      if Count == 0 then B
      else {Fib A+B A Count-1}
      end
   end
in
   {Fib 1 0 N}
end

declare
proc {TestFibonacci}
   {Browse {Fibonacci 0} == 0}
   {Browse {Fibonacci 1} == 1}
   {Browse {Fibonacci 2} == 1}
   {Browse {Fibonacci 3} == 2}
   {Browse {Fibonacci 4} == 3}
   {Browse {Fibonacci 5} == 5}
   {Browse {Fibonacci 6} == 8}
   {Browse {Fibonacci 100} == 354224848179261915075}
end

{TestFibonacci}

%%%
%%%    1.15
%%%
declare
fun {Cube X}
   X * X * X
end
fun {Transform X}
   3.0*X - 4.0*{Cube X}
end
fun {IsSufficientlySmall Angle}
   {Abs Angle} =< 0.1
end
fun {Sine Angle}
   if {IsSufficientlySmall Angle} then Angle
   else {Transform {Sine Angle/3.0}}
   end
end

{Browse {Sine 1.8}}
{Browse {Sin 1.8}}

      
   