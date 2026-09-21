%%%
%%%   Name:               Interval.oz
%%%
%%%   Started:            Sat Aug 29 11:36:58 2026
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
%%%   All endpoints are floats!
%%%
%%%

declare
[Lisp] = {Module.link ['/home/slytobias/oz/modules/Lisp.ozf']}
[Core] = {Module.link ['/home/slytobias/oz/modules/Core.ozf']}

%%%
%%%    2.7
%%%
declare
fun {MakeInterval L U}
   if L =< U then interval(L U)
   else raise "Inverted bounds." end
   end
end
fun {LowerBound interval(L _)} L end
fun {UpperBound interval(_ U)} U end
proc {PrintInterval X}
   {System.showInfo "["#{LowerBound X}#", "#{UpperBound X}#"]"}
end
fun {EqualInterval X Y}
   Tolerance = 0.00001
in
   case {LowerBound X}#{UpperBound X}
   of L0#U0 then
      case {LowerBound Y}#{UpperBound Y}
      of L1#U1 then
%         L0 == L1 andthen U0 == U1
         {Core.approximatelyEqual L0 L1 Tolerance} andthen {Core.approximatelyEqual U0 U1 Tolerance}
      end
   end
end
fun {AddInterval X Y}
   case {LowerBound X}#{UpperBound X}
   of L0#U0 then
      case {LowerBound Y}#{UpperBound Y}
      of L1#U1 then
         {MakeInterval (L0 + L1) (U0 + U1)}
      end
   end
end



   
{Show {EqualInterval {MakeInterval 4.0 6.0} {AddInterval {MakeInterval 1.0 2.0} {MakeInterval 3.0 4.0}}}}
{Show {EqualInterval {MakeInterval ~7.0 ~3.0} {AddInterval {MakeInterval ~5.0 ~2.0} {MakeInterval ~2.0 ~1.0}}}}
{Show {EqualInterval {MakeInterval 0.0 2.0} {AddInterval {MakeInterval ~6.0 ~5.0} {MakeInterval 6.0 7.0}}}}
%%% Commutative
{Show {EqualInterval {AddInterval {MakeInterval 1.0 9.0} {MakeInterval 2.0 4.0}} {AddInterval {MakeInterval 2.0 4.0} {MakeInterval 1.0 9.0}}}}
%%% Associative
{Show {EqualInterval {AddInterval {MakeInterval 4.0 6.0} {AddInterval {MakeInterval 1.0 2.0} {MakeInterval 3.0 5.0}}} {AddInterval {AddInterval {MakeInterval 4.0 6.0} {MakeInterval 1.0 2.0}} {MakeInterval 3.0 5.0}}}}
%%% Singleton behaves like real number
{Show {EqualInterval {MakeInterval 2.0 2.0} {AddInterval {MakeInterval 1.0 1.0} {MakeInterval 1.0 1.0}}}}
%%% Identity elt
{Show {EqualInterval {MakeInterval ~6.0 ~1.0} {AddInterval {MakeInterval ~6.0 ~1.0} {MakeInterval 0.0 0.0}}}}
{Show {EqualInterval {MakeInterval 0.0 0.0} {AddInterval {MakeInterval 1.0 1.0} {MakeInterval ~1.0 ~1.0}}}}
{Show {EqualInterval {MakeInterval 0.0 0.0} {AddInterval {MakeInterval 1.0 1.0} {Opposite {MakeInterval 1.0 1.0}}}}}

declare
fun {MulInterval X Y}
   case {LowerBound X}#{UpperBound X}
   of L0#U0 then
      case {LowerBound Y}#{UpperBound Y}
      of L1#U1 then
         local
            P0 = L0 * L1
            P1 = L0 * U1
            P2 = U0 * L1
            P3 = U0 * U1
         in
%            {MakeInterval {FoldL [P1 P2 P3] Min P0} {FoldL [P1 P2 P3] Max P0}
            {MakeInterval {Core.minimum [P0 P1 P2 P3]} {Core.maximum [P0 P1 P2 P3]}}
         end
      end
   end
end

declare
fun {MulInterval X Y}
   case {LowerBound X}#{UpperBound X}
   of L0#U0 then
      case {LowerBound Y}#{UpperBound Y}
      of L1#U1 then
         Products = {Map {Core.cartesian [L0 U0] [L1 U1]} {Core.partial Lisp.apply Number.'*'}}
      in
         {MakeInterval {Core.minimum Products} {Core.maximum Products}}
      end
   end
end

{Show {EqualInterval {MakeInterval 6.0 20.0} {MulInterval {MakeInterval 2.0 4.0} {MakeInterval 3.0 5.0}}}}
%%% Commutative
{Show {EqualInterval {MulInterval {MakeInterval 7.0 11.0} {MakeInterval 3.0 6.0}} {MulInterval {MakeInterval 3.0 6.0} {MakeInterval 7.0 11.0}}}}
%%% Associative
{Show {EqualInterval {MulInterval {MakeInterval 4.0 6.0} {MulInterval {MakeInterval 1.0 2.0} {MakeInterval 3.0 5.0}}} {MulInterval {MulInterval {MakeInterval 4.0 6.0} {MakeInterval 1.0 2.0}} {MakeInterval 3.0 5.0}}}}
%%% Distributive
{Show {EqualInterval {MulInterval {MakeInterval 0.0 2.0} {AddInterval {MakeInterval 9.0 12.0} {MakeInterval 6.0 8.0}}} {AddInterval {MulInterval {MakeInterval 0.0 2.0} {MakeInterval 9.0 12.0}} {MulInterval {MakeInterval 0.0 2.0} {MakeInterval 6.0 8.0}}}}}
%%% Singleton behaves like real number
{Show {EqualInterval {MakeInterval 12.0 12.0} {MulInterval {MakeInterval 4.0 4.0} {MakeInterval 3.0 3.0}}}}
{Show {EqualInterval {MakeInterval ~10.0 ~10.0} {MulInterval {MakeInterval ~2.0 ~2.0} {MakeInterval 5.0 5.0}}}}
%%%  Identity elt
{Show {EqualInterval {MakeInterval 3.0 17.0} {MulInterval {MakeInterval 1.0 1.0} {MakeInterval 3.0 17.0}}}}
{Show {EqualInterval {MakeInterval 1.0 1.0} {MulInterval {MakeInterval 5.0 5.0} {MakeInterval 1.0/5.0 1.0/5.0}}}}
{Show {EqualInterval {MakeInterval 1.0 1.0} {MulInterval {MakeInterval 5.0 5.0} {Reciprocal {MakeInterval 5.0 5.0}}}} }

%%%
%%%    2.11
%%%
declare
fun {MulInterval X Y}
   case {LowerBound X}#{UpperBound X}
   of L0#U0 then
      case {LowerBound Y}#{UpperBound Y}
      of L1#U1 then
         if {Not {Lisp.minusp L0}} then
            if {Not {Lisp.minusp L1}} then {MakeInterval (L0 * L1) (U0 * U1)}
            elseif {Not {Lisp.plusp U1}} then {MakeInterval (U0 * L1) (L0 * U1)}
            else {MakeInterval (U0 * L1) (U0 * U1)}
            end
         elseif {Not {Lisp.plusp U0}} then
            if {Not {Lisp.minusp L1}} then {MakeInterval (L0 * U1) (U0 * L1)}
            elseif {Not {Lisp.plusp U1}} then {MakeInterval (U0 * U1) (L0 * L1)}
            else {MakeInterval (L0 * U1) (L0 * L1)}
            end
         else
            if {Not {Lisp.minusp L1}} then {MakeInterval (L0 * U1) (U0 * U1)}
            elseif {Not {Lisp.plusp U1}} then {MakeInterval (U0 * L1) (L0 * L1)}
            else {MakeInterval {Min (L0 * U1) (U0 * L1)}
                  {Max (L0 * L1) (U0 * U1)}}
            end
         end
      end
   end
end

%%%
%%%    2.10
%%%
declare
fun {SpansZero X}
   case {LowerBound X}#{UpperBound X}
   of L#U then
      {Core.isBetween 0.0 L U}
   end
end

{Show {Not {SpansZero {MakeInterval 1.0 9.0}}}}
{Show {Not {SpansZero {MakeInterval ~3.0 ~2.0}}}}
{Show {SpansZero {MakeInterval 0.0 1.0}}}
{Show {SpansZero {MakeInterval ~2.0 0.0}}}
{Show {SpansZero {MakeInterval 0.0 0.0}}}
{Show {SpansZero {MakeInterval ~2.0 4.0}}}
{Show {SpansZero {MakeInterval ~2.0 4.0}}}

declare
fun {Reciprocal X}
   if {SpansZero X} then
      raise "Interval cannot span zero." end
   else
      case {LowerBound X}#{UpperBound X}
      of L#U then
         {MakeInterval (1.0 / U) (1.0 / L)}
      end
   end
end
fun {DivInterval X Y}
   {MulInterval X {Reciprocal Y}}
end

{Show {DivInterval {MakeInterval 6.0 20.0} {MakeInterval 1.0 10.0}}}
{Show {MakeInterval 3.0/5.0 20.0}}
{Show {EqualInterval {MakeInterval 3.0/5.0 20.0} {DivInterval {MakeInterval 6.0 20.0} {MakeInterval 1.0 10.0}}}}

{Show {EqualInterval {MakeInterval 1.0/20.0 5.0/3.0} {DivInterval {MakeInterval 1.0 10.0} {MakeInterval 6.0 20.0}}}}
{Show {EqualInterval {MakeInterval 7.0/8.0 8.0/7.0} {DivInterval {MakeInterval 7.0 8.0} {MakeInterval 7.0 8.0}}}}
%%% Not commutative
{Show {Not {EqualInterval {DivInterval {MakeInterval 7.0 11.0} {MakeInterval 3.0 6.0}} {DivInterval {MakeInterval 3.0 6.0} {MakeInterval 7.0 11.0}}}}}
%%% Not associative
{Show {Not {EqualInterval {DivInterval {MakeInterval 4.0 6.0} {DivInterval {MakeInterval 1.0 2.0} {MakeInterval 3.0 5.0}}} {DivInterval {DivInterval {MakeInterval 4.0 6.0} {MakeInterval 1.0 2.0}} {MakeInterval 3.0 5.0}}}}}
try
   {Show {DivInterval {MakeInterval 1.0 1.0} {MakeInterval 0.0 1.0}}}
   raise "Cannot contain 0." end
catch _ then
   {System.showInfo "Correct"}
end
try
   {Show {DivInterval {MakeInterval 1.0 1.0} {MakeInterval ~3.0 0.0}}}
   raise "Cannot contain 0." end
catch _ then
   {System.showInfo "Correct"}
end
try
   {Show {DivInterval {MakeInterval 1.0 1.0} {MakeInterval ~2.0 8.0}}}
   raise "Cannot contain 0." end
catch _ then
   {System.showInfo "Correct"}
end
%%% Singleton behaves like real number
{Show {EqualInterval {MakeInterval 4.0 4.0} {DivInterval {MakeInterval 32.0 32.0 } {MakeInterval 8.0 8.0}}}}
{Show {EqualInterval {MakeInterval 1.0 1.0} {DivInterval {MakeInterval 7.0 7.0} {MakeInterval 7.0 7.0}}}}

%%%
%%%    2.8
%%%
declare
fun {Opposite X}
   case {LowerBound X}#{UpperBound X}
   of L#U then
      {MakeInterval ~U ~L}
   end
end
fun {SubInterval X Y}
   case {LowerBound X}#{UpperBound X}
   of L0#U0 then
      case {LowerBound Y}#{UpperBound Y}
      of L1#U1 then
         {MakeInterval (L0 - U1) (U0 - L1)}
      end
   end
end

{Show {EqualInterval {MakeInterval ~2.0 2.0} {SubInterval {MakeInterval 3.0 5.0} {MakeInterval 3.0 5.0}}}}
%%% Not commutative
{Show {Not {EqualInterval {SubInterval {MakeInterval 7.0 11.0} {MakeInterval 3.0 6.0}} {SubInterval {MakeInterval 3.0 6.0} {MakeInterval 7.0 11.0}}}}}
%%% Not associative
{Show {Not {EqualInterval {SubInterval {MakeInterval 4.0 6.0} {SubInterval {MakeInterval 1.0 2.0} {MakeInterval 3.0 5.0}}} {SubInterval {SubInterval {MakeInterval 4.0 6.0} {MakeInterval 1.0 2.0}} {MakeInterval 3.0 5.0}}}}}
%%% Singleton behaves like real number
{Show {EqualInterval {MakeInterval ~2.0 ~2.0} {SubInterval {MakeInterval 2.0 2.0} {MakeInterval 4.0 4.0}}}}
{Show {EqualInterval {MakeInterval 0.0 0.0} {SubInterval {MakeInterval 7.0 7.0} {MakeInterval 7.0 7.0}}}}

declare
fun {SubInterval X Y}
   {AddInterval X {Opposite Y}}
end

%%%
%%%    2.9
%%%
declare
fun {MakeCenterWidth C W}
   {MakeInterval (C - W) (C + W)}
end
fun {Center X}
   case {LowerBound X}#{UpperBound X}
   of L#U then
      (L + U) / 2.0
   end
end
fun {Width X}
   case {LowerBound X}#{UpperBound X}
   of L#U then
      (U - L) / 2.0
   end
end

%%%
%%%    2.12
%%%
declare
fun {MakeCenterPercent C P}
   {MakeInterval (C * (1.0 - P / 100.0)) (C * (1.0 + P / 100.0))}
end

{PrintInterval {MakeCenterPercent 6.8 10.0}}

declare
fun {MakeCenterPercent C P}
   {MakeCenterWidth C (C * P / 100.0)}
end

declare
fun {Percent X}
   ({Width X} / {Center X}) * 100.0
end

{Show {Percent {MakeCenterPercent 6.8 10.0}}}

local
   Resistance1 = 6.8
   Resistance2 = 4.7
   Percent1 = 10.0
   Percent2 = 5.0
   R1 = {MakeCenterPercent Resistance1 Percent1}
   R2 = {MakeCenterPercent Resistance2 Percent2}
   Result = {Reciprocal {AddInterval {Reciprocal R1} {Reciprocal R2}}}
in
   {Show {Core.approximatelyEqual Resistance1 {Center R1} 0.00001} andthen
    {Core.approximatelyEqual Resistance2 {Center R2} 0.00001} andthen
    {Core.approximatelyEqual Percent1 {Percent R1} 0.00001} andthen
    {Core.approximatelyEqual Percent2 {Percent R2} 0.00001} andthen
    {Core.approximatelyEqual 2.581558809636278 {LowerBound Result} 0.00001}  andthen
    {Core.approximatelyEqual 2.97332259363673 {UpperBound Result} 0.00001}}
end

declare
fun {Parallel R1 R2}
   {DivInterval {MulInterval R1 R2}
    {AddInterval R1 R2}}
end

{Show {Parallel {MakeCenterPercent 6.8 10.0} {MakeCenterPercent 4.7 5.0}}}

declare
fun {Parallel R1 R2}
   One = {MakeInterval 1.0 1.0}
in
   {DivInterval One {AddInterval {DivInterval One R1} {DivInterval One R2}}}
end

declare
fun {Parallel R1 R2}
   {Reciprocal {AddInterval {Reciprocal R1} {Reciprocal R2}}}
end

declare
fun {Parallel R1 R2}
   {MulInterval {DivInterval R1 {AddInterval R1 R2}} R2}
end
