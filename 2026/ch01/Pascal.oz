%%%
%%%   Name:               Pascal.oz
%%%
%%%   Started:            Sun May 10 02:57:22 2026
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
fun {Pascal R C}
   if C == 0 orelse R == C then 1
   else {Pascal R-1 C-1} + {Pascal R-1 C}
   end
end
fun {Triangle Row}
   fun {Collect C}
      if C > Row then nil
      else {Pascal Row C}|{Collect C+1}
      end
   end
in
   {Collect 0}
end

declare
fun {Pascal R C}
   fun {Iterate I0 I1 V}
      if I0 == C then V
      else {Iterate I1 I1+1 V*(R-I0) div I1}
      end
   end
in
   {Iterate 0 1 1}
end

%%%
%%%    Numerator decreases. Denominator increases.
%%%    
declare
fun {Pascal R C}
   Cm = {Min C R-C}
   fun {Iterate I N D V}
      if I == Cm then V
      else {Iterate I+1 N-1 D+1 (V*N) div D}
      end
   end
in
   {Iterate 0 R 1 1}
end
