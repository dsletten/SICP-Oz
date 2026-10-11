%%%
%%%   Name:               Church.oz
%%%
%%%   Started:            Sat Oct 10 08:32:53 2026
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
fun {Zero _}
   fun {$ X} X end
end
fun {Successor N}
   fun {$ F}
      fun {$ X}
         {F {{N F} X}}
      end
   end
end

{Show {{Zero Core.inc} 8}}
{Show {{{Successor Zero} Core.inc} 8}}
{Show {{{Successor {Successor Zero}} Core.inc} 8}}

declare
fun {One F}
   fun {$ X}
      {F X}
   end
end
fun {Two F}
   fun {$ X}
      {F {F X}}
   end
end

{Show {{One Core.inc} 8}}
{Show {{Two Core.inc} 8}}

declare
fun {Add M N}
   fun {$ F}
      fun {$ X}
         {{Core.compose {M F} {N F}} X}
      end
   end
end

{Show {{{Add One Zero} Core.inc} 8}}
{Show {{{Add Two One} Core.inc} 8}}
{Show {{{Add Two Two} Core.inc} 8}}

declare
fun {Mul M N}
   fun {$ F}
      fun {$ X}
         {{{Core.compose M N} F} X}
      end
   end
end

{Show {{{Mul One Zero} Core.inc} 8}}
{Show {{{Mul One One} Core.inc} 8}}
{Show {{{Mul Two One} Core.inc} 8}}
{Show {{{Mul {Mul Two Two} Two} Core.inc} 8}}

{Show {{{Mul One One} {Core.partial Number.'*' 3}} 8}}
{Show {{{Mul Two One} {Core.partial Number.'*' 3}} 8}}
{Show {{{Mul Two Two} {Core.partial Number.'*' 3}} 8}}
{Show {{{Mul {Mul Two Two} Two} {Core.partial Number.'*' 3}} 8}}

