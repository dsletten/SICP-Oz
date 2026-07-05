%%%
%%%   Name:               ch02.oz
%%%
%%%   Started:            Wed Jul  1 12:28:42 2026
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
fun {MakeRational N D}
   N|D
end
fun {Numerator N|_}
   N
end
fun {Denominator _|D}
   D
end

declare
proc {PrintRational X}
   {System.showInfo {Numerator X}#"/"#{Denominator X}}
end

declare
Half = {MakeRational 1 2}
Third = {MakeRational 1 3}

declare
fun {Add X Y}
   {MakeRational
    ({Numerator X} * {Denominator Y} + {Numerator Y} * {Denominator X})
    ({Denominator X} * {Denominator Y})}
end
fun {Subtract X Y}
   {MakeRational
    ({Numerator X} * {Denominator Y} - {Numerator Y} * {Denominator X})
    ({Denominator X} * {Denominator Y})}
end
fun {Multiply X Y}
   {MakeRational
    ({Numerator X} * {Numerator Y})
    ({Denominator X} * {Denominator Y})}
end
fun {Divide X Y}
   {MakeRational
    ({Numerator X} * {Denominator Y})
    ({Denominator X} * {Numerator Y})}
end
fun {Equal X Y}
   ({Numerator X} * {Denominator Y}) == ({Numerator Y} * {Denominator X})
end


declare
fun {MakeRational N D}
   G = {Lisp.gcd N D}
in
   (N div G)|(D div G)
end

%%%
%%%    2.1
%%%
declare
fun {MakeRational N D}
   if D < 0 then
      {MakeRational ~N ~D}
   else
      G = {Lisp.gcd N D}
   in
      (N div G)|(D div G)
   end
end

%%%
%%%    Abstraction barrier
%%%    
declare
fun {MakeRational N D}
   if D < 0 then
      {MakeRational ~N ~D}
   else
      G = {Lisp.gcd N D}
   in
      rational((N div G) (D div G))
   end
end
fun {Numerator rational(N _)}
   N
end
fun {Denominator rational(_ D)}
   D
end
