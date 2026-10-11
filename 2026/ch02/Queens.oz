%%%
%%%   Name:               Queens.oz
%%%
%%%   Started:            Wed Oct  7 11:38:14 2026
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
fun {FlatMap Xs P}
   {FoldR {Map Xs P} Append nil}
end
fun {EnumerateInterval Low High}
   fun {Collect I Result}
      if I > High then {Reverse Result}
      else {Collect {Core.inc I} I|Result}
      end
   end
in
   {Collect Low nil}
end
fun {Permutations S}
   case S
   of nil then [nil]
   else {FlatMap S fun {$ X} {Map {Permutations {List.subtract S X}} {Core.partial Lisp.cons X}} end}
   end
end
fun {BruteForceQueens N}
   {Filter {Permutations {EnumerateInterval 1 N}} IsSafe}
end
fun {IsSafe Positions}
   [Min Max] = {Core.bestWorst Positions Value.'<'}
   fun {CheckDiagonals Up Down Rows}
      if Up < Min then {CheckDown Down Rows}
      elseif Down > Max then {CheckUp Up Rows}
      else
         case Rows
         of nil then true
         [] !Up|_ then false
         [] !Down|_ then false
         [] _|More then {CheckDiagonals (Up - 1) (Down + 1) More}
         end
      end
   end
   fun {CheckDown Down Rows}
      case Rows
      of nil then true
      [] !Down|_ then false
      [] _|More then {CheckDown (Down + 1) More}
      end
   end      
   fun {CheckUp Up Rows}
      case Rows
      of nil then true
      [] !Up|_ then false
      [] _|More then {CheckUp (Up - 1) More}
      end
   end
in
   case Positions
   of nil then true
   [] Current|More then
      {CheckDiagonals (Current - 1) (Current + 1) More}
      andthen
      {IsSafe More}
   end
end
fun {AdjoinPosition Queens Remainder}
   {Map Remainder
    fun {$ NewQueen} {Core.append1 Queens NewQueen} end}
end
fun {SetDifference As Bs}
   {FoldR Bs fun {$ Y Xs} {Remove Xs Y} end As}
end
fun {Queens BoardSize}
   EmptyBoard = nil
   fun {QueenCols K}
      if K == 0 then [EmptyBoard]
      else {Filter {FlatMap {QueenCols K - 1}
                    fun {$ Queens}
                       {AdjoinPosition Queens {SetDifference {EnumerateInterval 1 BoardSize} Queens}}
                    end}
            IsSafe}
      end
   end
in
   {QueenCols BoardSize}
end
                    
{Show {Queens 5}}

declare
fun {Reflection Board}
   {Reverse Board}
end
fun {Rotation Board}
   {Reflection {Map {Sort {List.zip Board {EnumerateInterval 1 {Length Board}} fun {$ X Y} [X Y] end}
                     fun {$ X Y} X.1 < Y.1 end}
                Lisp.second}}
end

declare
fun {Lookup Board Solutions}
   fun {Consult I Board}
      if I == 4 then false
      else
         {Lisp.find Board Solutions} orelse
         {Lisp.find {Reflection Board} Solutions} orelse
         {Consult (I + 1) {Rotation Board}}
      end
   end
in
   {Consult 0 Board}
end
fun {Fundamental Solutions}
   fun {CheckSolutions Unique Ss}
      case Ss
      of nil then Unique
      [] S|Sr then
         if {Lookup S Unique} then {CheckSolutions Unique Sr}
         else {CheckSolutions S|Unique Sr}
         end
      end
   end
in
   {CheckSolutions nil Solutions}
end

{Show {Fundamental {Queens 8}}}
{Show {Length {Queens 8}}}
{Show {Length {Fundamental {Queens 8}}}}

{Core.assertEqual [[3 6 2 5 8 1 7 4] [3 5 8 4 1 7 2 6] [3 5 2 8 1 7 4 6] [2 7 5 8 1 4 6 3]
                   [2 7 3 6 8 5 1 4] [2 6 8 3 1 4 7 5] [2 6 1 7 4 8 3 5] [2 5 7 4 1 8 6 3]
                   [2 5 7 1 3 8 6 4] [2 4 6 8 3 1 7 5] [1 6 8 3 7 4 2 5] [1 5 8 6 3 7 2 4]]
 {Fundamental {Queens 8}}
 "12 fundamental solutions to 8 queens"}