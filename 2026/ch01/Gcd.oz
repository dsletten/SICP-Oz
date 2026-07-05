%%%
%%%   Name:               Gcd.oz
%%%
%%%   Started:            Thu May 21 00:12:02 2026
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

local Gcd in
   fun {Gcd M N}
      if N == 0 then M
      else {Gcd N M mod N}
      end
   end
   {Show {Gcd 206 40}}
end

local Gcd A B D in
   Gcd = proc {$ M N R}
            local T G H in
               G = 0
               H = '=='
               {Value.H N G T}
               if T then
                  R = M
               else
                  local F E in
                     E = 'mod'
                     {Int.E M N F}
                     {Gcd N F R}
                  end
               end
            end
         end
   A = 206
   B = 40
   {Gcd A B D}
   {Show D}
end
