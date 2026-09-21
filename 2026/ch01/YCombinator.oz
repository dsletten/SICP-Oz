%%%
%%%   Name:               YCombinator.oz
%%%
%%%   Started:            Thu Jul 16 12:57:57 2026
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

{Show {{fun {$ F} fun {$ N} {F F N} end end
        fun {$ F N}
           if N == 0 then 1
           else N * {F F (N - 1)}
           end
        end}
       6}}

declare
fun {Factorial N}
   {{fun {$ F} fun {$ N} {F F N} end end
     fun {$ F N}
        if N == 0 then 1
        else N * {F F (N - 1)}
        end
     end}
    N}
end

{Show {Factorial 3}}
{Show {Factorial 6}}

{Show {{fun {$ F} fun {$ N Result} {F F N Result} end end
        fun {$ F N Result}
           if N == 0 then Result
           else {F F (N - 1) (Result * N)}
           end
        end}
       6 1}}

declare
fun {FactorialTr N}
   {{fun {$ F} fun {$ N Result} {F F N Result} end end
     fun {$ F N Result}
        if N == 0 then Result
        else {F F (N - 1) (Result * N)}
        end
     end}
    N 1}
end

{Show {FactorialTr 3}}
{Show {FactorialTr 6}}

{Show {{fun {$ F} fun {$ N} {F F N} end end
        fun {$ F N}
           if N == 0 then 5
           else {F F (N - 1)} + 1
           end
        end}
       10}}

declare
fun {Plus5 N}
   {{fun {$ F} fun {$ N} {F F N} end end
     fun {$ F N}
        if N == 0 then 5
        else {F F (N - 1)} + 1
        end
     end}
    N}
end

{Show {Plus5 9}}
{Show {Plus5 2}}

{Show {{fun {$ F} fun {$ N} {F F N} end end
        fun {$ F N}
           if N == 1 then true
           elseif {IsEven N} then {F F (N div 2)}
           else {F F (3 * N + 1)}
           end
        end}
       10}}

declare
fun {Collatz N}
   {{fun {$ F} fun {$ N} {F F N} end end
     fun {$ F N}
        if N == 1 then true
        elseif {IsEven N} then {F F (N div 2)}
        else {F F (3 * N + 1)}
        end
     end}
    N}
end

{Show {Collatz 10}}
{Show {Collatz 9}}
{Show {Collatz 150}}

{Show {{fun {$ F} fun {$ L Result} {F F L Result} end end
        fun {$ F L Result}
           case L
           of nil then Result
           [] H|T then {F F T H|Result}
           end
        end}
       [a b c d] nil}}

declare
fun {Reverse L}
   {{fun {$ F} fun {$ L Result} {F F L Result} end end
     fun {$ F L Result}
        case L
        of nil then Result
        [] H|T then {F F T H|Result}
        end
     end}
    L nil}
end

{Show {Reverse nil}}
{Show {Reverse [1]}}
{Show {Reverse [1 2]}}
{Show {Reverse [1 2 3 4 5 6 7 8 9 10]}}

 