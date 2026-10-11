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

%%%
%%%    2.2
%%%
% declare
% fun {MakePoint X Y}
%    if ({IsInt X} andthen {IsInt Y}) orelse ({IsFloat X} andthen {IsFloat Y}) then X|Y
%    else raise error('Incompatible coordinates') end
%    end
% end
% fun {XPoint P} P.1 end
% fun {YPoint P} P.2 end
% fun {IsIntPoint P}
%    {IsInt {XPoint P}} andthen {IsInt {YPoint P}}
% end
% fun {IsFloatPoint P}
%    {IsFloat {XPoint P}} andthen {IsFloat {YPoint P}}
% end
% proc {PrintPoint P}
%    {System.printInfo "("#{XPoint P}#","#{YPoint P}#")"}
% end
% fun {Distance P1 P2}
%    Sum = {Pow ({XPoint P1} - {XPoint P2}) 2} + {Pow ({YPoint P1} - {YPoint P2}) 2}
% in
%    if {IsInt Sum} then {Sqrt {IntToFloat Sum}}
%    else {Sqrt Sum}
%    end
% end

% {PrintPoint {MakePoint 1 2}}
% {Show {Distance {MakePoint 0 0} {MakePoint 5 12}}}

% declare
% fun {MakeSegment Start End}
%    if ({IsIntPoint Start} andthen {IsIntPoint End}) orelse ({IsFloatPoint Start} andthen {IsFloatPoint End}) then Start|End
%    else raise error('Incompatible endpoints') end
%    end
% end
% fun {StartSegment S} S.1 end
% fun {EndSegment S} S.2 end
% proc {PrintSegment S}
%    {System.printInfo "("}
%    {PrintPoint {StartSegment S}}
%    {System.printInfo " -> "}
%    {PrintPoint {EndSegment S}}
%    {System.printInfo ")"}
% end
% fun {LengthSegment S}
%    {Distance {StartSegment S} {EndSegment S}}
% end
% fun {Average X Y}
%    Sum = X + Y
% in
%    if {IsFloat Sum} then Sum / 2.0
%    elseif {IsEven Sum} then Sum div 2
%    else {IntToFloat Sum} / 2.0
%    end
% end
% fun {MidpointSegment S}
%    {MakePoint {Average {XPoint {StartSegment S}} {XPoint {EndSegment S}}}
%               {Average {YPoint {StartSegment S}} {YPoint {EndSegment S}}}}
% end

% {Show {LengthSegment {MakeSegment {MakePoint 3 3} {MakePoint 8 15}}}}
% {PrintPoint {MidpointSegment {MakeSegment {MakePoint 0 0} {MakePoint 0 2}}}}
% {PrintPoint {MidpointSegment {MakeSegment {MakePoint 0.0 0.0} {MakePoint 0.0 2.0}}}}
% {PrintPoint {MidpointSegment {MakeSegment {MakePoint ~1 ~1} {MakePoint 3 3}}}}

% {System.showInfo ""}

% declare
% fun {IsHorizontal S}
%    {YPoint {StartSegment S}} == {YPoint {EndSegment S}}
% end
% fun {IsVertical S}
%    {XPoint {StartSegment S}} == {XPoint {EndSegment S}}
% end
% fun {Slope S}
%    if {IsHorizontal S} then 0
%    elseif {IsVertical S} then infinity
%    else
%       X0 = {XPoint {StartSegment S}}
%       Y0 = {YPoint {StartSegment S}}
%       X1 = {XPoint {EndSegment S}}
%       X1 = {YPoint {EndSegment S}}
%    in
%       if {IsIntPoint {StartSegment S}} then {IntToFloat (Y1 - Y0)} / {IntToFloat (X1 - X0)}
%       else (Y1 - Y0) / (X1 - X0)
%       end
%    end
% end
%%%
%%%    Damn! Just make everything floating-point
%%%    
declare
fun {MakePoint X Y} X|Y end
% fun {XPoint P} P.1 end
% fun {YPoint P} P.2 end
fun {XPoint X|_} X end
fun {YPoint _|Y} Y end
proc {PrintPoint P}
   {System.printInfo "("#{XPoint P}#","#{YPoint P}#")"}
end
fun {AreCoincident P0 P1}
   {XPoint P0} == {XPoint P1} andthen {YPoint P0} == {YPoint P1}
end
fun {AreDistinct P0 P1}
   {Not {AreCoincident P0 P1}}
end
fun {Distance P0 P1}
   {Sqrt {Pow ({XPoint P0} - {XPoint P1}) 2.0} + {Pow ({YPoint P0} - {YPoint P1}) 2.0}}
end

{Show {AreCoincident {MakePoint 3.2 ~1.5} {MakePoint 3.2 ~1.5}}}
{Show {AreCoincident {MakePoint 3.2 ~1.4} {MakePoint 3.2 ~1.5}}}

{PrintPoint {MakePoint 1.0 2.0}}
{Show {Distance {MakePoint 0.0 0.0} {MakePoint 5.0 12.0}}}

declare
fun {MakeSegment Start End} Start|End end
% fun {StartSegment S} S.1 end
% fun {EndSegment S} S.2 end
fun {StartSegment S|_} S end
fun {EndSegment _|E} E end
proc {PrintSegment S}
   {System.printInfo "("}
   {PrintPoint {StartSegment S}}
   {System.printInfo " -> "}
   {PrintPoint {EndSegment S}}
   {System.printInfo ")"}
end
fun {AreSameSegment S0 S1}
   Start0#End0 = {StartSegment S0}#{EndSegment S0}
   Start1#End1 = {StartSegment S1}#{EndSegment S1}
in
   ({AreCoincident Start0 Start1} andthen {AreCoincident End0 End1})
   orelse
   ({AreCoincident Start0 End1} andthen {AreCoincident End0 Start1})
end
fun {AreDistinctSegments S0 S1}
   {Not {AreSameSegment S0 S1}}
end
fun {LengthSegment S}
   {Distance {StartSegment S} {EndSegment S}}
end
fun {Average X Y}
   (X + Y) / 2.0
end
fun {MidpointSegment S}
   {MakePoint {Average {XPoint {StartSegment S}} {XPoint {EndSegment S}}}
              {Average {YPoint {StartSegment S}} {YPoint {EndSegment S}}}}
end

{Show {AreSameSegment {MakeSegment {MakePoint 0.0 4.0} {MakePoint 1.0 8.0}} {MakeSegment {MakePoint 0.0 4.0} {MakePoint 1.0 8.0}}}}
{Show {AreSameSegment {MakeSegment {MakePoint 0.0 4.0} {MakePoint 1.0 8.0}} {MakeSegment {MakePoint 1.0 8.0} {MakePoint 0.0 4.0}}}}


{Show {LengthSegment {MakeSegment {MakePoint 3.0 3.0} {MakePoint 8.0 15.0}}}}
{PrintPoint {MidpointSegment {MakeSegment {MakePoint 0.0 0.0} {MakePoint 0.0 2.0}}}}
{PrintPoint {MidpointSegment {MakeSegment {MakePoint ~1.0 ~1.0} {MakePoint 3.0 3.0}}}}

{System.showInfo ""}

declare
fun {IsHorizontal S}
   {YPoint {StartSegment S}} == {YPoint {EndSegment S}}
end
fun {IsVertical S}
   {XPoint {StartSegment S}} == {XPoint {EndSegment S}}
end
fun {Slope S}
   if {IsHorizontal S} then 0.0
   elseif {IsVertical S} then infinity
   else
      X0 = {XPoint {StartSegment S}}
      Y0 = {YPoint {StartSegment S}}
      X1 = {XPoint {EndSegment S}}
      Y1 = {YPoint {EndSegment S}}
   in
      (Y1 - Y0) / (X1 - X0)
   end
end
fun {AreParallel S1 S2}
   if {IsHorizontal S1} then {IsHorizontal S2}
   elseif {IsVertical S1} then {IsVertical S2}
   elseif {IsVertical S2} then false
   else {Core.approximatelyEqual {Slope S1} {Slope S2} 0.000001}
   end
end
fun {ArePerpendicular S1 S2}
   if {IsHorizontal S1} then {IsVertical S2}
   elseif {IsVertical S1} then {IsHorizontal S2}
   elseif {IsVertical S2} then false
   else {Core.approximatelyEqual ~1.0 ({Slope S1} * {Slope S2}) 0.000001}
   end
end

{Show {AreParallel {MakeSegment {MakePoint 0.0 0.0} {MakePoint 5.0 0.0}} {MakeSegment {MakePoint 3.0 3.0} {MakePoint 8.0 3.0}}}}
{Show {AreParallel {MakeSegment {MakePoint 0.0 0.0} {MakePoint 0.0 5.0}} {MakeSegment {MakePoint 3.0 3.0} {MakePoint 3.0 8.0}}}}
{Show {AreParallel {MakeSegment {MakePoint 0.0 0.0} {MakePoint 5.0 5.0}} {MakeSegment {MakePoint 3.0 3.0} {MakePoint 8.0 8.0}}}}
{Show {Not {AreParallel {MakeSegment {MakePoint 0.0 0.0} {MakePoint 3.0 2.0}} {MakeSegment {MakePoint 1.0 4.0} {MakePoint 1.0 8.0}}}} }

{Show {ArePerpendicular {MakeSegment {MakePoint 2.0 2.0} {MakePoint 3.0 3.0}} {MakeSegment {MakePoint ~2.0 2.0} {MakePoint 3.0 ~3.0}}}}
{Show {ArePerpendicular {MakeSegment {MakePoint 0.0 0.0} {MakePoint 0.0 1.0}} {MakeSegment {MakePoint 0.0 0.0} {MakePoint 1.0 0.0}}}}
{Show {ArePerpendicular {MakeSegment {MakePoint 0.0 0.0} {MakePoint 1.0 0.0}} {MakeSegment {MakePoint 0.0 0.0} {MakePoint 0.0 1.0}}}}
{Show {Not {ArePerpendicular {MakeSegment {MakePoint 0.0 0.0} {MakePoint 1.0 2.0}} {MakeSegment {MakePoint 0.0 0.0} {MakePoint 1.0 0.5}}}} }

declare
fun {SharedEndpoint S0 S1}
   fun {Screen P0 P1 P2 P3}
      if {AreCoincident P0 P1} andthen {AreDistinct P2 P3} then P0
      else false
      end
   end
   Start0#End0 = {StartSegment S0}#{EndSegment S0}
   Start1#End1 = {StartSegment S1}#{EndSegment S1}
   Shared = {Filter [{Screen Start0 Start1 End0 End1} {Screen Start0 End1 End0 Start1} {Screen End0 Start1 Start0 End1} {Screen End0 End1 Start0 Start1}] {Core.compose Not IsBool}}
in
   case Shared
   of nil then false
   [] [Endpoint] then Endpoint
   end
   % {Screen Start0 Start1 End0 End1} orelse
   % {Screen Start0 End1 End0 Start1} orelse
   % {Screen End0 Start1 Start0 End1} orelse
   % {Screen End0 End1 Start0 Start1}
end
fun {Intersection S0 S1}
   if {AreParallel S0 S1} then {SharedEndpoint S0 S1}
   elseif {IsVertical S1} then
      Start0#End0 = {StartSegment S0}#{EndSegment S0}
      Start1#End1 = {StartSegment S1}#{EndSegment S1}
      X0#Y0 = {XPoint Start0}#{YPoint Start0}
      X1 = {XPoint End0}
      X2#Y2 = {XPoint Start1}#{YPoint Start1}
   in
      if {Core.isBetween X2 X0 X1} orelse {Core.isBetween X2 X1 X0} then
         Y3 = {YPoint End1}
         M = {Slope S0}
         B = Y0 - (M * X0)
         Y = (M * X2) + B
      in
         if {Core.isBetween Y Y2 Y3} orelse {Core.isBetween Y Y3 Y2} then {MakePoint X2 Y}
         else false
         end
      else false
      end
   elseif {IsVertical S0} then {Intersection S1 S0}
   else
      Start0#End0 = {StartSegment S0}#{EndSegment S0}
      Start1 = {StartSegment S1}
      X0#Y0 = {XPoint Start0}#{YPoint Start0}
      X1#Y1 = {XPoint Start1}#{YPoint Start1}
      X2 = {XPoint End0}
      M0 = {Slope S0}
      M1 = {Slope S1}
      B0 = Y0 - (M0 * X0)
      B1 = Y1 - (M1 * X1)
      X = (B1 - B0) / (M0 - M1)
      Y = (M0 * X) + B0
   in
      if {Core.isBetween X X0 X2} orelse {Core.isBetween X X2 X0} then {MakePoint X Y}
      else false
      end
   end
end

{Show {AreCoincident {MakePoint 0.0 0.0} {Intersection {MakeSegment {MakePoint ~1.0 ~1.0} {MakePoint 1.0 1.0}} {MakeSegment {MakePoint ~1.0 1.0} {MakePoint 1.0 ~1.0}}}} }
{Show {Not {Intersection {MakeSegment {MakePoint 2.0 2.0} {MakePoint 1.0 1.0}} {MakeSegment {MakePoint ~1.0 1.0} {MakePoint 1.0 ~1.0}}}} } % No intersection
{Show {AreCoincident {MakePoint 1.0 3.0} {Intersection {MakeSegment {MakePoint 0.0 0.0} {MakePoint 1.0 3.0}} {MakeSegment {MakePoint 2.0 0.0} {MakePoint 1.0 3.0}}}} } % Endpoint - not parallel
{Show {Not {Intersection {MakeSegment {MakePoint 0.0 0.0} {MakePoint 1.5 4.5}} {MakeSegment {MakePoint 1.0 3.0} {MakePoint 2.0 6.0}}}} } % Parallel - overlap
{Show {Not {Intersection {MakeSegment {MakePoint 0.0 0.0} {MakePoint 1.0 3.0}} {MakeSegment {MakePoint 1.0 0.0} {MakePoint 2.0 3.0}}}} } % Parallel - no intersection
{Show {AreCoincident {MakePoint 1.0 3.0} {Intersection {MakeSegment {MakePoint 0.0 0.0} {MakePoint 1.0 3.0}} {MakeSegment {MakePoint 1.0 3.0} {MakePoint 3.0 9.0}}}} } % Parallel - endpoint
{Show {Not {Intersection {MakeSegment {MakePoint 0.0 0.0} {MakePoint 1.0 3.0}} {MakeSegment {MakePoint 0.0 0.0} {MakePoint 1.0 3.0}}}} } % Coincident segments
{Show {AreCoincident {MakePoint 2.0 0.0} {Intersection {MakeSegment {MakePoint ~4.0 0.0} {MakePoint 9.0 0.0}} {MakeSegment {MakePoint 2.0 ~3.0} {MakePoint 2.0 5.0}}}} } % Vertical segment ⟂
{Show {AreCoincident {MakePoint 2.0 0.0} {Intersection {MakeSegment {MakePoint 2.0 ~3.0} {MakePoint 2.0 5.0}} {MakeSegment {MakePoint ~4.0 0.0} {MakePoint 9.0 0.0}}}} }  % Vertical segment ⟂
{Show {Not {Intersection {MakeSegment {MakePoint ~4.0 0.0} {MakePoint 9.0 0.0}} {MakeSegment {MakePoint 2.0 3.0} {MakePoint 2.0 5.0}}}} }  % Vertical segment ⟂
{Show {Not {Intersection {MakeSegment {MakePoint 2.0 3.0} {MakePoint 2.0 5.0}} {MakeSegment {MakePoint ~4.0 0.0} {MakePoint 9.0 0.0}}}} } % Vertical segment ⟂
{Show {AreCoincident {MakePoint 2.0 2.0} {Intersection {MakeSegment {MakePoint 2.0 ~3.0} {MakePoint 2.0 5.0}} {MakeSegment {MakePoint 0.0 0.0} {MakePoint 6.0 6.0}}}} }  % Vertical segment not ⟂
{Show {AreCoincident {MakePoint 2.0 2.0} {Intersection {MakeSegment {MakePoint 0.0 0.0} {MakePoint 6.0 6.0}} {MakeSegment {MakePoint 2.0 ~3.0} {MakePoint 2.0 5.0}}}} } % Vertical segment not ⟂
{Show {Not {Intersection {MakeSegment {MakePoint 2.0 ~3.0} {MakePoint 2.0 5.0}} {MakeSegment {MakePoint 0.0 0.0} {MakePoint 1.0 1.0}}}} } % Vertical segment not ⟂
{Show {Not {Intersection {MakeSegment {MakePoint 0.0 0.0} {MakePoint 1.0 1.0}} {MakeSegment {MakePoint 2.0 ~3.0} {MakePoint 2.0 5.0}}}} } % Vertical segment not ⟂
{Show {Not {Intersection {MakeSegment {MakePoint 2.0 ~3.0} {MakePoint 2.0 5.0}} {MakeSegment {MakePoint 0.0 6.0} {MakePoint 6.0 12.0}}}} } % Vertical segment not ⟂
{Show {Not {Intersection {MakeSegment {MakePoint 0.0 6.0} {MakePoint 6.0 12.0}} {MakeSegment {MakePoint 2.0 ~3.0} {MakePoint 2.0 5.0}}}} } % Vertical segment not ⟂
                                
declare
fun {MakeRectangleSegments A B C D}
   fun {Package Top Bottom Left Right}
      (Top|Bottom)|(Left|Right)
   end
   % fun {CheckShared A Bs}
   %    case Bs
   %    of nil then true
   %    [] B|Br then {Not {IsBool {SharedEndpoint A B}}} andthen {CheckShared A Br}
   %    else false
   %    end
   % end
   % fun {Shared As Bs}
   %    case As
   %    of nil then true
   %    [] A|Ar then {CheckShared A Bs} andthen {Shared Ar Bs}
   %    else false
   %    end
   % end
   fun {CheckDistinct Segment Ss}
      case Ss
      of nil then true
      [] S|Sr then {AreDistinctSegments Segment S} andthen {CheckDistinct Segment Sr}
      end
   end
   fun {Distinct Segments}
      case Segments
      of nil then true
      [] S|Sr then {CheckDistinct S Sr} andthen {Distinct Sr}
      end
   end
   fun {DoubleCheck Top Bottom Left Right}
      if {AreParallel Left Right} andthen
         {ArePerpendicular Top Left} andthen
%         {Shared [Top Bottom] [Left Right]} andthen
         {All {Core.cartesian [Top Bottom] [Left Right]} fun {$ Pair} {Not {IsBool {Lisp.apply SharedEndpoint Pair}}} end} andthen
         {Distinct [Top Bottom Left Right]} then
         {Package Top Bottom Left Right}
      else
         nil
      end
   end
   fun {Validate S0 S1 S2 S3}
      if {AreParallel S0 S1} then {DoubleCheck S0 S1 S2 S3}
      elseif {AreParallel S0 S2} then {DoubleCheck S0 S2 S1 S3}
      elseif {AreParallel S0 S3} then {DoubleCheck S0 S3 S1 S2}
      else nil
      end
   end
   Rectangle = {Validate A B C D}
in
   case Rectangle
   of nil then raise 'Bad rectangle.' end
   else Rectangle
   end
end


{Show {MakeRectangleSegments {MakeSegment {MakePoint 0.0 0.0} {MakePoint 5.0 0.0}}
                             {MakeSegment {MakePoint 0.0 7.0} {MakePoint 5.0 7.0}}
                             {MakeSegment {MakePoint 0.0 0.0} {MakePoint 0.0 7.0}}
                             {MakeSegment {MakePoint 5.0 7.0} {MakePoint 5.0 0.0}}}}
{Show {MakeRectangleSegments {MakeSegment {MakePoint 0.0 ~1.0} {MakePoint 1.0 0.0}}
                             {MakeSegment {MakePoint 0.0 1.0} {MakePoint ~1.0 0.0}}
                             {MakeSegment {MakePoint 1.0 0.0} {MakePoint 0.0 1.0}}
                             {MakeSegment {MakePoint ~1.0 0.0} {MakePoint 0.0 ~1.0}}}}
{Show {MakeRectangleSegments {MakeSegment {MakePoint 0.0 0.0} {MakePoint 4.0 0.0}}
                             {MakeSegment {MakePoint 4.0 0.0} {MakePoint 4.0 2.0}}
                             {MakeSegment {MakePoint 4.0 2.0} {MakePoint 0.0 2.0}}
                             {MakeSegment {MakePoint 0.0 2.0} {MakePoint 0.0 0.0}}}}

{Show {MakeRectangleSegments {MakeSegment {MakePoint 0.0 0.0} {MakePoint 5.0 0.0}}
                             {MakeSegment {MakePoint 0.0 0.0} {MakePoint 0.0 7.0}}
                             {MakeSegment {MakePoint 0.0 0.0} {MakePoint 5.0 0.0}}
                             {MakeSegment {MakePoint 0.0 0.0} {MakePoint 0.0 7.0}}}}

{Show {MakeRectangleSegments {MakeSegment {MakePoint 0.0 0.0} {MakePoint 4.0 0.0}}
                             {MakeSegment {MakePoint 4.0 0.0} {MakePoint 5.0 2.0}}
                             {MakeSegment {MakePoint 5.0 2.0} {MakePoint 1.0 2.0}}
                             {MakeSegment {MakePoint 1.0 2.0} {MakePoint 0.0 0.0}}}}

declare
fun {RectangleTop (Top|_)|(_|_)}
   Top
end
fun {RectangleBottom (_|Bottom)|(_|_)}
   Bottom
end
fun {RectangleLeft (_|_)|(Left|_)}
   Left
end
fun {RectangleRight (_|_)|(_|Right)}
   Right
end

local R = {MakeRectangleSegments {MakeSegment {MakePoint 0.0 0.0} {MakePoint 5.0 0.0}}
                                 {MakeSegment {MakePoint 0.0 7.0} {MakePoint 5.0 7.0}}
                                 {MakeSegment {MakePoint 0.0 0.0} {MakePoint 0.0 7.0}}
                                 {MakeSegment {MakePoint 5.0 7.0} {MakePoint 5.0 0.0}}}
in
   {PrintSegment {RectangleTop R}}
   {System.showInfo " "}
   {PrintSegment {RectangleBottom R}}
   {System.showInfo " "}
   {PrintSegment {RectangleLeft R}}
   {System.showInfo " "}
   {PrintSegment {RectangleRight R}}
   {System.showInfo " "}
end

declare
fun {Length R}
   Top = {RectangleTop R}
in
   {Distance {StartSegment Top} {EndSegment Top}}
end
fun {Width R}
   Left = {RectangleLeft R}
in
   {Distance {StartSegment Left} {EndSegment Left}}
end
   
local R = {MakeRectangleSegments {MakeSegment {MakePoint 0.0 0.0} {MakePoint 5.0 0.0}}
                                 {MakeSegment {MakePoint 0.0 7.0} {MakePoint 5.0 7.0}}
                                 {MakeSegment {MakePoint 0.0 0.0} {MakePoint 0.0 7.0}}
                                 {MakeSegment {MakePoint 5.0 7.0} {MakePoint 5.0 0.0}}}
in
   {Show {Length R}}
   {Show {Width R}}
end

%%%
%%%    https://en.wikipedia.org/wiki/Rectangle
%%%    A parallelogram with equal diagonals is a rectangle.
%%%
%%%    p₀-----q₁  Diagonals p₀p₁, q₀q₁
%%%    |      |
%%%    |      |
%%%    q₀-----p₁
%%%
%%%    Input 4 arbitrary points. Determine whether they represent a rectangle.
%%%    By constructing 3 segments from the first point, 2 will be perpendicular. The 3rd segment
%%%    is a diagonal. The other 2 points form the other diagonal.
%%%
%%%    Representation: (P0|P1)|(Q0|Q1)
%%%    Two pairs of diagonal corners.
%%%    
declare
fun {MakeRectanglePoints A B C D}
   fun {Package P0 P1 Q0 Q1}
      (P0|P1)|(Q0|Q1)
   end
   fun {DoubleCheck P0 P1 Q0 Q1}
      S0 = {MakeSegment P0 Q1}
      S1 = {MakeSegment Q0 P1}
      S2 = {MakeSegment P0 Q0}
      S3 = {MakeSegment Q1 P1}
   in
      if {Distance P0 P1} == {Distance Q0 Q1} andthen
         {AreParallel S0 S1} andthen
         {AreParallel S2 S3} then
         {Package P0 P1 Q0 Q1}
      else
         nil
      end
   end
   fun {Validate P0 P1 P2 P3}
      S01 = {MakeSegment P0 P1}
      S02 = {MakeSegment P0 P2}
      S03 = {MakeSegment P0 P3}
   in
      if {ArePerpendicular S02 S03} then {DoubleCheck P0 P1 P2 P3}
      elseif {ArePerpendicular S01 S03} then {DoubleCheck P0 P2 P1 P3}
      elseif {ArePerpendicular S01 S02} then {DoubleCheck P0 P3 P1 P2}
      else nil
      end
   end
   Rectangle = {Validate A B C D}
in
   case Rectangle
   of nil then raise 'Bad rectangle.' end
   else Rectangle
   end
end

{Show {MakeRectanglePoints {MakePoint 0.0 0.0} {MakePoint 4.0 0.0} {MakePoint 4.0 2.0} {MakePoint 0.0 2.0}}}
{Show {MakeRectanglePoints {MakePoint 0.0 0.0} {MakePoint 4.0 0.0} {MakePoint 5.0 2.0} {MakePoint 1.0 2.0}}}

declare
fun {Length (P0|_)|(_|Q1)}
   {Distance P0 Q1}
end
fun {Width (P0|_)|(Q0|_)}
   {Distance P0 Q0}
end

local R = {MakeRectanglePoints {MakePoint 0.0 0.0} {MakePoint 5.0 0.0} {MakePoint 0.0 7.0} {MakePoint 5.0 7.0}}
in
   {Show {Length R}}
   {Show {Width R}}
end

declare
fun {Area R}
   {Length R} * {Width R}
end
fun {Perimeter R}
   (2.0 * {Length R}) + (2.0 * {Width R})
end


{Show 35.0 == {Area {MakeRectangleSegments {MakeSegment {MakePoint 0.0 0.0} {MakePoint 5.0 0.0}}
                                           {MakeSegment {MakePoint 0.0 7.0} {MakePoint 5.0 7.0}}
                                           {MakeSegment {MakePoint 0.0 0.0} {MakePoint 0.0 7.0}}
                                           {MakeSegment {MakePoint 5.0 7.0} {MakePoint 5.0 0.0}}}} }
{Show 2.0000000000000004 == {Area {MakeRectangleSegments {MakeSegment {MakePoint 0.0 ~1.0} {MakePoint 1.0 0.0}}
                                                         {MakeSegment {MakePoint 0.0 1.0} {MakePoint ~1.0 0.0}}
                                                         {MakeSegment {MakePoint 1.0 0.0} {MakePoint 0.0 1.0}}
                                                         {MakeSegment {MakePoint ~1.0 0.0} {MakePoint 0.0 ~1.0}}}} }
{Show 8.0 == {Area {MakeRectangleSegments {MakeSegment {MakePoint 0.0 0.0} {MakePoint 4.0 0.0}}
                                          {MakeSegment {MakePoint 4.0 0.0} {MakePoint 4.0 2.0}}
                                          {MakeSegment {MakePoint 4.0 2.0} {MakePoint 0.0 2.0}}
                                          {MakeSegment {MakePoint 0.0 2.0} {MakePoint 0.0 0.0}}}} }

{Show 24.0 == {Perimeter {MakeRectangleSegments {MakeSegment {MakePoint 0.0 0.0} {MakePoint 5.0 0.0}}
                                                {MakeSegment {MakePoint 0.0 7.0} {MakePoint 5.0 7.0}}
                                                {MakeSegment {MakePoint 0.0 0.0} {MakePoint 0.0 7.0}}
                                                {MakeSegment {MakePoint 5.0 7.0} {MakePoint 5.0 0.0}}}} }
{Show 5.656854249492381 == {Perimeter {MakeRectangleSegments {MakeSegment {MakePoint 0.0 ~1.0} {MakePoint 1.0 0.0}}
                                                             {MakeSegment {MakePoint 0.0 1.0} {MakePoint ~1.0 0.0}}
                                                             {MakeSegment {MakePoint 1.0 0.0} {MakePoint 0.0 1.0}}
                                                             {MakeSegment {MakePoint ~1.0 0.0} {MakePoint 0.0 ~1.0}}}} }
{Show 12.0 == {Perimeter {MakeRectangleSegments {MakeSegment {MakePoint 0.0 0.0} {MakePoint 4.0 0.0}}
                                                {MakeSegment {MakePoint 4.0 0.0} {MakePoint 4.0 2.0}}
                                                {MakeSegment {MakePoint 4.0 2.0} {MakePoint 0.0 2.0}}
                                                {MakeSegment {MakePoint 0.0 2.0} {MakePoint 0.0 0.0}}}} }


{Show 35.0 == {Area {MakeRectanglePoints {MakePoint 0.0 0.0} {MakePoint 5.0 0.0} {MakePoint 0.0 7.0} {MakePoint 5.0 7.0}}}}
{Show 2.0000000000000004 == {Area {MakeRectanglePoints {MakePoint 0.0 ~1.0} {MakePoint 1.0 0.0} {MakePoint 0.0 1.0} {MakePoint ~1.0 0.0}}}}
{Show 8.0 == {Area {MakeRectanglePoints {MakePoint 0.0 0.0} {MakePoint 4.0 0.0} {MakePoint 4.0 2.0} {MakePoint 0.0 2.0}}}}

{Show 24.0 == {Perimeter {MakeRectanglePoints {MakePoint 0.0 0.0} {MakePoint 5.0 0.0} {MakePoint 0.0 7.0} {MakePoint 5.0 7.0}}}}
{Show 5.656854249492381 == {Perimeter {MakeRectanglePoints {MakePoint 0.0 ~1.0} {MakePoint 1.0 0.0} {MakePoint 0.0 1.0} {MakePoint ~1.0 0.0}}}}
{Show 12.0 == {Perimeter {MakeRectanglePoints {MakePoint 0.0 0.0} {MakePoint 4.0 0.0} {MakePoint 4.0 2.0} {MakePoint 0.0 2.0}}}}





%%%
%%%    2.4
%%%
declare
fun {Cons H T}
   cons(H T)
end
fun {Car cons(H _)}
   H
end
fun {Cdr cons(_ T)}
   T
end

{Show {Car {Cons 1 2}}}
{Show {Cdr {Cons 1 2}}}

% proc {Car Formal1 Result2}
%    case Formal1 of cons(H Wildcard1) then
%       H = Result2
%    end
% end

declare
fun {Cons X Y}
   fun {$ M}
      case M
      of 0 then X
      [] 1 then Y
      else raise "Bad input" end
      end
   end
end
fun {Car Z}
   {Z 0}
end
fun {Cdr Z}
   {Z 1}
end

%%%
%%%    Church encoding
%%%    
declare
fun {Cons X Y}
   fun {$ Z}
      {Z X Y}
   end
end
fun {Car P}
   {P fun {$ X _} X end}
end
fun {Cdr P}
   {P fun {$ _ Y} Y end}
end

%%%
%%%    2.5
%%%
declare
CarB = 2
CdrB = 3
fun {IntCons Car Cdr}
   {Pow CarB Car} * {Pow CdrB Cdr}
end
fun {Factor P D N}
   if P mod D == 0 then {Factor (P div D) D (N + 1)}
   else N
   end
end
fun {Decompose X Y}
   {Factor X Y 0}
end
fun {IntCar Cons}
   {Decompose Cons CarB}
end
fun {IntCdr Cons}
   {Decompose Cons CdrB}
end

{Show {IntCons 3 7}}
{Show {IntCar {IntCons 3 7}}}
{Show {IntCdr {IntCons 3 7}}}
      
%%%
%%%    2.17
%%%
declare
fun {LastPair L}
   fun {Final L}
      case L
      of [_] then L
      else {Final L.2}
      end
   end
in
   if L == nil then raise('I don\'t want an empty list.') end
   else {Final L}
   end
end

{Show {LastPair [23 72 149 34]}}
{Show {LastPair [a]}}
{Show {LastPair nil}}

%%%
%%%    2.18
%%%
declare
fun {Reverse Xs}
   fun {Flip Xs Result}
      case Xs
      of nil then Result
      [] X|Xr then {Flip Xr X|Result}
      end
   end
in
   {Flip Xs nil}
end

{Show {Reverse [1 4 9 16 25]}}
{Show {Reverse {Reverse [1 4 9 16 25]}}}
{Show {Reverse nil}}
{Show {Reverse [a]}}

%%%
%%%    2.19
%%%
%%%    Exercise in mixed int/float values...
%%%    
declare
UsCoins = [50 25 10 5 1]
UKCoins = [100.0 50.0 20.0 10.0 5.0 2.0 1.0 0.5]
fun {CC Amount CoinValues}
   fun {NoMore Coins} Coins == nil end
   fun {ExceptFirstDenomination _|Coins} Coins end
   fun {FirstDenomination Coin|_} Coin end
in
   if {Lisp.zerop Amount} then 1
   elseif {Lisp.minusp Amount} orelse {NoMore CoinValues} then 0
   else {CC Amount {ExceptFirstDenomination CoinValues}} +
      {CC (Amount - {FirstDenomination CoinValues}) CoinValues}
   end
end

{Show 292 == {CC 100 UsCoins}}
{Show 104561 == {CC 100.0 UKCoins}}

%%%
%%%    2.20
%%%
declare
fun {SameParity X|Ys}
   fun {Collect X Ys}
      case Ys
      of nil then nil
      [] Y|Yr then
         if (X mod 2) == (Y mod 2) then Y|{Collect X Yr}
         else {Collect X Yr}
         end
      end
   end
in
   X|{Collect X Ys}
end

{Show {SameParity [1 2 3 4 5 6 7]}}
{Show {SameParity [1]}}
{Show {SameParity [2 3 4 5 6 7]}}
{Show {SameParity [2 3 5 7]}}
            
declare
fun {SameParity X|Ys}
   fun {Collect F Ys}
      case Ys
      of nil then nil
      [] Y|Yr then
         if {F Y} then Y|{Collect F Yr}
         else {Collect F Yr}
         end
      end
   end
in
   X|{Collect if {IsEven X} then IsEven else IsOdd end Ys}
end
   
declare
fun {SameParity X|Ys}
   X|{Filter Ys if {IsEven X} then IsEven else IsOdd end}
end

%%%
%%%    2.21
%%%
declare
fun {SquareList Xs}
   case Xs
   of nil then nil
   [] X|Xr then (X*X)|{SquareList Xr}
   end
end

{Show {SquareList [1 2 3 4]}}

{Show Map == List.map}

declare
%fun {Map P Items}
fun {Map Xs P} % Preserve Oz interface!
   case Xs
   of nil then nil
   [] X|Xr then {P X}|{Map Xr P}
   end
end
fun {SquareList Xs}
   {Map Xs fun {$ X} X * X end}
end

%%%
%%%    2.22
%%%    
declare
fun {SquareListBad Xs}
   fun {Iterate Xs Answer}
      case Xs
      of nil then Answer
      [] X|Xr then {Iterate Xr (X*X)|Answer}
      end
   end
in
   {Iterate Xs nil}
end

{Show {SquareListBad [1 2 3 4]}}

declare
fun {SquareListWorse Xs}
   fun {Iterate Xs Answer}
      case Xs
      of nil then Answer
      [] X|Xr then {Iterate Xr Answer|(X*X)}
      end
   end
in
   {Iterate Xs nil}
end

{Show {SquareListWorse [1 2 3 4]}}

%%%
%%%    2.23
%%%
declare
proc {ForEach P Xs}
   case Xs
   of nil then skip
   [] X|Xr then
      {P X}
      {ForEach P Xr}
   end
end

{ForEach Show [1 2 3]}

%%%
%%%    2.27
%%%
declare
fun {DeepReverse Tree}
   fun {Flip L Result}
      if L == nil then Result
      elseif {Not {Lisp.consp L}} then L
      else {Flip L.2 {Flip L.1 nil}|Result}
      end
   end
in
   {Flip Tree nil}
end

{Show nil == {DeepReverse nil}}
{Show [nil] ==  {DeepReverse [nil]}}
{Show [3 2 1] == {DeepReverse [1 2 3]}}
{Show [[4 3] [2 1]] == {DeepReverse [[1 2] [3 4]]}}
{Show [nil a] == {DeepReverse [a nil]}}
{Show [b nil a] == {DeepReverse [a nil b]}}
{Show [[b nil a]] == {DeepReverse [[a nil b]]}}
{Show [[f [e d]] [[c b] a]] == {DeepReverse [[a [b c]] [[d e] f]]}}
{Show [[f [e [d y]]] [[[c x] b] a]] == {DeepReverse [[a [b [x c]]] [[[y d] e] f]]}}
{Show [[a [b [x c]]] [[[y d] e] f]] == {DeepReverse {DeepReverse [[a [b [x c]]] [[[y d] e] f]]}} }

%%%
%%%    2.28
%%%
declare
fun {Fringe Tree}
   fun {Squash Tree Result}
      case Tree
      of nil then {Reverse Result}
      [] H|T then
         if H == nil then {Squash T Result}
         elseif {Lisp.atom H} then {Squash T H|Result}
         else
            H1|T1 = H
         in
            {Squash H1|T1|T Result}
         end
      end
   end
in
   if {Lisp.atom Tree} then Tree
   else {Squash Tree nil}
   end
end

{Show {Fringe [[1 2] [3 4]]}}
{Show {Fringe [[1 2 3 4] [1 2 3 4]]}}
{Show {Fringe [[[0] [1] [2] 3] [[4] [5] [[6] [[7] [8] [9] 10] [11] 12] 13] [14] 15]}}
{Show {Fringe [[[[0] [1] [2] [[3] 4] 5] [6] [[7] [[[8] [9] 10] [[[[11] 12] [[13] 14] [15] 16] [17] 18] 19] 20] 21] [22] 23]}}
{Show {Fringe [[0] [[[1] [[[[[[[[[2] [[[3] [[[4] [[5] [6] 7] 8] [9] [[[10] 11] 12] 13] 14] [15] [16] 17] [18] [19] 20] [[[21] [22] [23] [[24] [[25] [26] 27] 28] 29] 30] 31] 32] 33] [[[34] [35] 36] 37] [[[38] 39] 40] 41] 42] [43] [44] 45] 46] 47] 48] 49]}}

%%%
%%%    Whaaa??
%%%    
local
   fun {DoFlatten Xs ?Start End}
      case Xs
      of X|Xr then S S1
      in
         if {DoFlatten X S S1} then
            Start=S
            {DoFlatten Xr S1 End}
         else S2 in
            Start=X|S2
            {DoFlatten Xr S2 End}
         end
      [] nil then
         Start=End
         true
      else
         false
      end
   end
in
   fun {Flatten X}
      Start
   in
      if {DoFlatten X Start nil} then Start
      else X
      end
   end
end

declare
fun {Squash X}
   fun {DoFlatten Xs ?Start End}
      {Show [xs Xs]}
      {Show [start Start]}
      {Show ['end' End]}
      case Xs
      of X|Xr then S S1
      in
         if {DoFlatten X S S1} then
            Start=S
            {Show [nested Start]}
            {DoFlatten Xr S1 End}
         else S2 in
            Start=X|S2
            {Show [flat Start]}
            {DoFlatten Xr S2 End}
         end
      [] nil then
         Start=End
         true
      else
         false
      end
   end
   Start
in
   if {DoFlatten X Start nil} then Start
   else X
   end
end

{Show {Squash [[a b] c]}}
{Show {Squash [[1 2] [3 4]]}}
{Show {Squash [[1 2 3 4] [1 2 3 4]]}}
{Show {Squash [[[0] [1] [2] 3] [[4] [5] [[6] [[7] [8] [9] 10] [11] 12] 13] [14] 15]}}
{Show {Squash [[[[0] [1] [2] [[3] 4] 5] [6] [[7] [[[8] [9] 10] [[[[11] 12] [[13] 14] [15] 16] [17] 18] 19] 20] 21] [22] 23]}}
{Show {Squash [[0] [[[1] [[[[[[[[[2] [[[3] [[[4] [[5] [6] 7] 8] [9] [[[10] 11] 12] 13] 14] [15] [16] 17] [18] [19] 20] [[[21] [22] [23] [[24] [[25] [26] 27] 28] 29] 30] 31] 32] 33] [[[34] [35] 36] 37] [[[38] 39] 40] 41] 42] [43] [44] 45] 46] 47] 48] 49]}}





%%%
%%%    2.29
%%%
declare
fun {MakeMobile Left Right}
   [Left Right]
end
fun {MakeBranch Length Structure}
   [Length Structure]
end
fun {LeftBranch Mobile}
   {Lisp.first Mobile}
end
fun {RightBranch Mobile}
   {Lisp.second Mobile}
end
fun {BranchLength Branch}
   {Lisp.first Branch}
end
fun {BranchStructure Branch}
   {Lisp.second Branch}
end
fun {IsWeight Mobile}
   {IsNumber Mobile}
end

{Show {MakeMobile {MakeBranch 2.0 3.0} {MakeBranch 3.0 4.0}}}

declare
fun {TotalWeight Mobile}
   if {IsWeight Mobile} then Mobile
   else {TotalWeight {BranchStructure {LeftBranch Mobile}}} + {TotalWeight {BranchStructure {RightBranch Mobile}}}
   end
end

{Show {TotalWeight 9.0}}
{Show {TotalWeight {MakeMobile {MakeBranch 1.0 2.0} {MakeBranch 1.0 2.0}}}}
{Show {TotalWeight {MakeMobile {MakeBranch 1.0 6.0}
                               {MakeBranch 1.0 {MakeMobile {MakeBranch 1.0 3.0}
                                                           {MakeBranch 1.0 3.0}}}} }}
{Show {TotalWeight {MakeMobile {MakeBranch 1.0 24.0}
                               {MakeBranch 1.0 {MakeMobile {MakeBranch 1.0 {MakeMobile {MakeBranch 1.0 6.0}
                                                                                       {MakeBranch 1.0 6.0}}}
                                                           {MakeBranch 1.0 12.0}}}} }}

declare
fun {Torque Branch}
   {BranchLength Branch} * {TotalWeight {BranchStructure Branch}}
end

{Show {Torque {MakeBranch 0.0 99999999999.0}}}
{Show {Torque {MakeBranch 4.0 5.0}}}
{Show {Torque {LeftBranch {MakeMobile {MakeBranch 1.0 3.0} {MakeBranch 1.0 3.0}}}} }
{Show {Torque {RightBranch {MakeMobile {MakeBranch 1.0 1.0} {MakeBranch 1.0/3.0 3.0}}}} }
{Show {Torque {RightBranch {MakeMobile {MakeBranch 7.0 1.0} {MakeBranch 7.0/3.0 3.0}}}} }

declare
fun {IsBalanced Mobile}
   if {IsWeight Mobile} then true
   elseif {Torque {LeftBranch Mobile}} == {Torque {RightBranch Mobile}} then
      {IsBalanced {BranchStructure {LeftBranch Mobile}}} andthen {IsBalanced {BranchStructure {RightBranch Mobile}}}
   else false
   end
end

{Show {IsBalanced {MakeMobile {MakeBranch 1.0 3.0} {MakeBranch 1.0 3.0}}}}
{Show {IsBalanced {MakeMobile {MakeBranch 1.0 3.0} {MakeBranch 3.0 1.0}}}}
{Show {IsBalanced {MakeMobile {MakeBranch 1.0 9.0} {MakeBranch 3.0 3.0}}}}
{Show {IsBalanced {MakeMobile {MakeBranch 1.0 12.0} {MakeBranch 3.0 {MakeMobile {MakeBranch 1.0 2.0} {MakeBranch 1.0 2.0}}}} }}
{Show {IsBalanced {MakeMobile {MakeBranch 1.0 12.0} {MakeBranch 3.0 {MakeMobile {MakeBranch 1.0 1.0} {MakeBranch 1.0/3.0 3.0}}}} }}
{Show {IsBalanced {MakeMobile {MakeBranch 1.0 12.0} {MakeBranch 3.0 {MakeMobile {MakeBranch 2.0 1.0} {MakeBranch 2.0/3.0 3.0}}}} }}
{Show {IsBalanced {MakeMobile {MakeBranch 1.0 12.0} {MakeBranch 3.0 {MakeMobile {MakeBranch 7.0 1.0} {MakeBranch 7.0/3.0 3.0}}}} }}
{Show {IsBalanced {MakeMobile {MakeBranch 6.0 2.0} {MakeBranch 3.0 {MakeMobile {MakeBranch 7.0 1.0} {MakeBranch 7.0/3.0 3.0}}}} }}

declare
fun {MakeMobile Left Right}
   Left|Right
end
fun {MakeBranch Length Structure}
   Length|Structure
end
fun {LeftBranch Mobile}
   Mobile.1
end
fun {RightBranch Mobile}
   Mobile.2
end
fun {BranchLength Branch}
   Branch.1
end
fun {BranchStructure Branch}
   Branch.2
end


declare
fun {ScaleList Factor Items}
   case Items
   of nil then nil
   [] H|T then (H * Factor)|{ScaleList Factor T}
   end
end

{Show {ScaleList 2 [1 2 3 4]}}

declare
fun {ScaleList Factor Items}
   {List.map Items fun {$ X} X * Factor end}
end

declare
fun {ScaleTree Factor Tree}
   if Tree == nil then nil
   elseif {IsNumber Tree} then Factor * Tree
   else {ScaleTree Factor Tree.1}|{ScaleTree Factor Tree.2}
   end
end

{Show {ScaleTree 3 [1 [2 [3] 4] [5]]}}

%%%
%%%    SICP-style
%%%
declare
fun {ScaleTree Factor Tree}
   {List.map Tree fun {$ SubTree}
                     if {Lisp.consp SubTree} then {ScaleTree Factor SubTree}
                     else Factor * SubTree end
                  end}
end

%%%
%%%    Graham-style
%%%
declare
fun {ScaleTree Factor Tree}
   if {IsNumber Tree} then Factor * Tree
   else {List.map Tree fun {$ SubTree} {ScaleTree Factor SubTree} end}
   end
end

%%%
%%%    2.30
%%%
declare
fun {SquareTree Tree}
   fun {Square X} X * X end
in
   if Tree == nil then nil
   elseif {IsNumber Tree} then {Square Tree}
   else {SquareTree Tree.1}|{SquareTree Tree.2}
   end
end

{Show {SquareTree [1 2 [[3] 4] [5 [6]]]}}

%%%
%%%    SICP-style
%%%
declare
fun {SquareTree Tree}
   {List.map Tree fun {$ SubTree}
                     if {Lisp.consp SubTree} then {SquareTree SubTree}
                     else SubTree * SubTree
                     end
                  end}
end

%%%
%%%    Graham-style
%%%
declare
fun {SquareTree Tree}
   if {IsNumber Tree} then Tree * Tree
   else {List.map Tree SquareTree}
   end
end

%%%
%%%    2.31
%%%
declare
fun {TreeMap Tree F}
   if Tree == nil then nil
   elseif {Lisp.atom Tree} then {F Tree}
   else {TreeMap Tree.1 F}|{TreeMap Tree.2 F}
   end
end

{Show {Lisp.atom "asdf"}} % Problems with strings...

%{Show [2 [5 [4 [3 7 8]]]] == {TreeMap ["Ça" ["plane" ["pour" ["moi" "Plastic" "Bertrand"]]]] List.length}}
{Show [[2 3] [4 5]] == {TreeMap [[1 2] [3 4]] Core.inc}}
{Show [2 3 [4 5 [6] 7] 8 [9 10]] == {TreeMap [1 2 [3 4 [5] 6] 7 [8 9]] Core.inc}}
{Show [7 6 5 4 3] == {TreeMap [5 4 3 2 1] {Core.compose Core.inc Core.inc}}}
{Show [4 5 [6 [7 [8] 9] [10]] 11 [12]] == {TreeMap [1 2 [3 [4 [5] 6] [7]] 8 [9]] fun {$ X} X + 3 end}}
{Show [[[[ [6] ]]]] == {TreeMap [[[[ [1]]]] ] fun {$ X} X + 5 end}}

declare
fun {SquareTree Tree}
   {TreeMap Tree fun {$ X} X * X end}
end

{Show [1 [4 [9 16] 25] [36 49]] == {SquareTree [1 [2 [3 4] 5] [6 7]]}}

declare
fun {ScaleTree Factor Tree}
   {TreeMap Tree {Core.partial Number.'*' Factor}}
end

%%%
%%%    2.32
%%%
declare
fun {PowerSet Set}
   fun {AddElt Elt Set}
      case Set
      of nil then nil
      [] H|T then (Elt|H)|H|{AddElt Elt T}
      end
   end
in
   case Set
   of nil then [nil]
   [] H|T then {AddElt H {PowerSet T}}
   end
end

{Show {PowerSet nil}}
{Show {PowerSet [a]}}
{Show {PowerSet [a b]}}
{Show {PowerSet [a b c]}}
{Show {PowerSet [a b c d]}}
{Show {PowerSet [a b c d e f g]}}

{ForEach Show {PowerSet [a b c d]}}

%%%
%%%    §2.2.3
%%%
declare
fun {SumOddSquares Tree}
   fun {Square X} X * X end
in
   if Tree == nil then 0
   elseif {IsNumber Tree} then
      if {IsOdd Tree} then {Square Tree}
      else 0
      end
   else
      {SumOddSquares Tree.1} + {SumOddSquares Tree.2}
   end
end

{Show 10 == {SumOddSquares [1 2 3]}}
{Show 10 == {SumOddSquares [[1 [2 [3]]]]}}
{Show 84 == {SumOddSquares [[1 [2 [3 4 [5] [6 7]]]] ]}}

declare
fun {EvenFibs N}
   fun {Next K}
      if K > N then nil
      else F = {FastFibIter K}
      in
         if {IsEven F} then F|{Next K+1}
         else {Next K+1}
         end
      end
   end
in
   {Next 0}
end

{Show [0] == {EvenFibs 0}}
{Show [0] == {EvenFibs 1}}
{Show [0 2 8] == {EvenFibs 8}}
{Show [0 2 8 34 144 610 2584] == {EvenFibs 20}}

%%%
%%%    List.filter
%%%    
% fun {Filter Xs F}
%    case Xs of nil then nil
%    [] X|Xr then if {F X} then X|{Filter Xr F} else {Filter Xr F} end
%    end
% end

%%%
%%%    `Accumulate'
%%%    
% fun {FoldR Xs P Z}
%    case Xs of nil then Z
%    [] X|Xr then {P X {FoldR Xr P Z}}
%    end
% end

{Show {FoldR [1 2 3 4 5] Number.'+' 0}}
{Show {FoldR [1 2 3 4 5] Number.'*' 1}}
{Show {FoldR [1 2 3 4 5] fun {$ X Y} X|Y end nil}}
{Show {FoldR [1 2 3 4 5] Lisp.cons nil}}

% fun {FoldL Xs P Z}
%    case Xs of nil then Z
%    [] X|Xr then {FoldL Xr P {P Z X}}
%    end
% end

declare
fun {EnumerateInterval Low High}
   fun {Collect I Result}
      if I > High then {Reverse Result}
      else {Collect {Core.inc I} I|Result}
      end
   end
in
   {Collect Low nil}
end

{Show {EnumerateInterval 2 9}}

declare
fun {EnumerateTree Tree}
   {Flatten Tree}
end
fun {Square X} X * X end

declare
fun {SumOddSquares Tree}
   {FoldR {Map {Filter {EnumerateTree Tree} IsOdd} Square} Number.'+' 0}
end

declare
fun {SumOddSquares Tree}
   {FoldL {Map {Filter {EnumerateTree Tree} IsOdd} Square} Number.'+' 0}
end

declare
fun {EvenFibs N}
   {FoldR {Filter {Map {EnumerateInterval 0 N} FastFibIter} IsEven} Lisp.cons nil}
end

declare
fun {ListFibSquares N}
   {Map {EnumerateInterval 0 N} {Core.compose Square FastFibIter}}
end

{Show {ListFibSquares 10}}

declare
fun {ProductOfSquaresOfOddElements Sequence}
   {FoldR {Map {Filter Sequence IsOdd} Square} Number.'*' 1}
end

{Show {ProductOfSquaresOfOddElements {EnumerateInterval 1 5}}}

%%%
%%%    2.33
%%%
declare
fun {Map Sequence P}
   {FoldR Sequence fun {$ Elt Result} {P Elt}|Result end nil}
end

{Show {Map nil Core.inc}}
{Show {Map {EnumerateInterval 1 10} Core.inc}}
{Show {Map {EnumerateInterval 1 10} Square}}
{Show {Map {EnumerateInterval 1 10} FastFibIter}}

declare
fun {Filter Sequence P}
   {FoldR Sequence fun {$ Elt Result} if {P Elt} then Elt|Result else Result end end nil}
end

{Show {Filter nil IsOdd}}
{Show {Filter {EnumerateInterval 1 10} IsOdd}}

declare
fun {CopyList L}
   {FoldR L Lisp.cons nil}
end

{Show {CopyList nil}}
{Show {CopyList [a b c]}}

declare
fun {Append L1 L2}
   {FoldR L1 Lisp.cons L2}
end

{Show {Append nil nil}}
{Show {Append nil [a]}}
{Show {Append [a] nil}}
{Show {Append [a b] [c d e]}}

declare
fun {CopyList L}
   {Append L nil}
end

declare
fun {CopyList L}
   {Map L Core.identity}
end

declare
fun {Length Sequence}
   {FoldR Sequence fun {$ _ Count} {Core.inc Count} end 0}
end

{Show {Length nil}}
{Show {Length [a]}}
{Show {Length [a b c d e]}}

declare
fun {Length Sequence}
   {FoldL Sequence fun {$ Count _} {Core.inc Count} end 0}
end

%%%
%%%    2.34 The book has a strange specification of Horner's due to the use of
%%%         a right fold--the coefficients are given in ascending order...
%%%
declare
fun {Horners X Coefficients}
   {FoldR Coefficients fun {$ B A} (A * X) + B end if {IsInt X} then 0 else 0.0 end}
end

{Show {Horners 10 [8 4 3 2]}} % Represent an integer as a list of digits.
{Show {Horners 8 [7 7 3]}} % 0377
{Show {Horners 2 [1 1 0 1 0 1 1 1]}}
{Show {Horners 8 [~9 3 5]}} % Evaluate polynomial: 5x² + 3x ~ 9
{Show {Horners 12 [~9 3 5]}}
{Show {Horners 0.1 [~9.0 3.0 5.0]}}
{Show {Horners 2 [1 3 0 5 0 1]}}
{Show {Horners 0 [1 3 0 5 0 1]}}

%%%
%%%    2.35
%%%
declare
fun {CountLeaves Tree}
   case Tree
   of nil then 0
   [] H|T then
      {CountLeaves H} + {CountLeaves T}
   else 1
   end
end

{Show {CountLeaves [1 2 [3 [4 [5] 6] [7]] 8 [9]]}}

declare
fun {CountLeaves Tree}
   {FoldR {Map {EnumerateTree Tree} {Core.constantly 1}} Number.'+' 0}
end

declare
fun {CountLeaves Tree}
   {FoldR {EnumerateTree Tree} fun {$ _ Count} {Core.inc Count} end 0}
end

declare
fun {CountLeaves Tree}
   {Length {EnumerateTree Tree}}
end

%%%
%%%    2.36
%%%
declare
fun {AccumulateN Op Init Seqs}
   case Seqs
   of nil|_ then nil
   else {FoldR {Map Seqs Lisp.car} Op Init}|{AccumulateN Op Init {Map Seqs Lisp.cdr}}
   end
end

{Show {Map [[1 2 3] [4 5 6] [7 8 9] [10 11 12]] Lisp.cdr}}
{Show {AccumulateN Number.'+' 0 [[1 2 3] [4 5 6] [7 8 9] [10 11 12]]}}

% Map grabs N args. Can't do arbitrary LIST call (no &REST params!)
% Above version
declare
fun {AccumulateN Op Init Seqs}
%   {Lisp.apply fun {$ F Xs} {MapN Xs F} end {Core.compose {Core.partial {Core.partial FoldR Op} Init}} Seqs}
   {{Core.partial fun {$ F Xs} {MapN Xs F} end {Core.partial {Core.partial FoldR Op} Init}} Seqs}
end

%%%
%%%    2.37
%%%
declare
fun {Map2 Xs Ys F}
   {List.zip Xs Ys F}
end

declare
fun {DotProduct U V} % Must be same length!
   {FoldR {Map2 U V Number.'*'} Number.'+' 0}
end

{Show {Map2 [1 2 3] [4 5 6] Number.'*'}}
{Show {DotProduct [1 2 3] [4 5 6]}}

{Show 110 == {DotProduct [10 20] [3 4]}}
%{Show 110 == {DotProduct [10 20 8] [3 4]}}
%{Show 110 {DotProduct [10 20] [3 4 6]}}
{Show 3 == {DotProduct [1 3 ~5] [4 ~2 ~1]}}

declare
fun {MapN Seqs F}
   if Seqs == nil then nil % Edge case. More significant for Lisp &REST param...
   elseif {Some Seqs Lisp.null} then nil
   else {Lisp.apply F {Map Seqs Lisp.car}}|{MapN {Map Seqs Lisp.cdr} F}
   end
end

%%%
%%%    Pointless. MapN already handles...
%%%    
% declare
% fun {MapN2 Seqs F}
%    if {Some Seqs Lisp.null} then nil
%    else {Lisp.apply F {Map Seqs Lisp.car}}|{MapN2 {Map Seqs Lisp.cdr} F}
%    end
% end

%%%
%%%    This is a more tolerant Zip. 2 seqs need not be same length.
%%%    
declare
fun {MapN2 Xs Ys F}
   if {Some [Xs Ys] Lisp.null} then nil
   else {F Xs.1 Ys.1}|{MapN2 Xs.2 Ys.2 F}
   end
end

{Show {MapN [[1 2] [3 4] [5 6]] fun {$ X Y Z} X + Y + Z end}}
{Show {MapN [[1 2] [3 4] [5]] fun {$ X Y Z} X + Y + Z end}}

{Show {MapN [[1 2] [3 4]] fun {$ X Y} X + Y end}}
{Show {MapN [[1 2] [3]] fun {$ X Y} X + Y end}}

{Show {MapN2 [1 2] [3 4] fun {$ X Y} X + Y end}}
{Show {MapN2 [1 2] [3] fun {$ X Y} X + Y end}}


% fun {Map Xs P}
%    case Xs of nil then nil
%    [] X|Xr then {P X}|{Map Xr P}
%    end
% end

% fun {Zip Xs Ys P}
%    case Xs
%    of nil then
%       case Ys
%       of nil then nil
%       end
%    [] X|Xr then
%       case Ys
%       of Y|Yr then {P X Y}|{Zip Xr Yr P}
%       end
%    end
% end

%%%
%%%    matrix x vector -> vector
%%%
declare
fun {MatrixXVector M V}
   {Map M fun {$ U} {DotProduct V U} end}
end

{Show [16 17] == {MatrixXVector [[3 1 4] [0 2 5]] [2 6 1]}}
{Show [9 ~6 4 ~1] == {MatrixXVector [[1 4 0] [4 2 0] [1 5 ~2] [~1 4 ~4]] [~3 3 4]}}
{Show [0 ~3 ~6 ~9] == {MatrixXVector [[1 2 3] [4 5 6] [7 8 9] [10 11 12]] [~2 1 0]}}
{Show [1 ~3] == {MatrixXVector [[1 ~1 2] [0 ~3 1]] [2 1 0]}}

declare
fun {MatrixXVector M V}
   {Map M {Core.partial DotProduct V}}
end

declare
fun {Transpose M}
   {AccumulateN Lisp.cons nil M}
end

{Show [[1 3] [2 4]] == {Transpose [[1 2] [3 4]]}}

declare
fun {MatrixXMatrix M N}
   Cols = {Transpose N}
in
   {Map M fun {$ Row} {Map Cols fun {$ Col} {DotProduct Col Row} end} end}
end

{Show [[31 19] [85 55]] == {MatrixXMatrix [[1 2 3] [4 5 6]] [[7 8] [9 1] [2 3]]}}


%%%
%%%    2.38 (见 Accumulate above)
%%%
% fun {FoldR Xs P Z}
%    case Xs of nil then Z
%    [] X|Xr then {P X {FoldR Xr P Z}}
%    end
% end

% fun {FoldL Xs P Z}
%    case Xs of nil then Z
%    [] X|Xr then {FoldL Xr P {P Z X}}
%    end
% end

%%%
%%%    2.39
%%%
declare
fun {Reverse L}
   {FoldR L fun {$ Elt Result} {Append Result [Elt]} end nil}
end

{Show {Reverse nil}}
{Show {Reverse [a]}}
{Show {Reverse [a b c d]}}

declare
fun {Reverse L}
   {FoldL L fun {$ Result Elt} Elt|Result end nil}
end

%%%
%%%    Nested mappings
%%%
declare
fun {FlatMap Xs P}
   {FoldR {Map Xs P} Append nil}
end

{Show {FlatMap [1 2 3] fun {$ X} [X] end}}

declare
fun {IsPrimeSum [M N]}
   {IsPrime M + N}
end

{Show {IsPrimeSum [2 3]}} % Not possible for this exercise!
{Show {IsPrimeSum [2 1]}}
{Show {IsPrimeSum [3 2]}}
{Show {IsPrimeSum [9 4]}}
{Show {IsPrimeSum [10 9]}}
{Show {Not {IsPrimeSum [3 1]}}}
{Show {Not {IsPrimeSum [10 6]}}}

declare
fun {MakeTriple Pair}
   {Append Pair [{FoldL Pair Number.'+' 0}]}
end

{Show {MakeTriple [1 2]}}

declare
fun {PrimeSumPairs N}
   {Map {Filter {FlatMap {EnumerateInterval 1 N}
                 fun {$ I}
                    {Map {EnumerateInterval 1 {Core.dec I}} fun {$ J} [I J] end}
                 end}
         IsPrimeSum}
    MakeTriple}
end

{Show nil == {PrimeSumPairs 1}}
{Show [[2 1 3]] == {PrimeSumPairs 2}}
{Show [[2 1 3] [3 2 5]] == {PrimeSumPairs 3}}
{Show [[2 1 3] [3 2 5] [4 1 5] [4 3 7]] == {PrimeSumPairs 4}}
{Show [[2 1 3] [3 2 5] [4 1 5] [4 3 7] [5 2 7]] == {PrimeSumPairs 5}}
{Show [[2 1 3] [3 2 5] [4 1 5] [4 3 7] [5 2 7] [6 1 7] [6 5 11]] == {PrimeSumPairs 6}}
{Show [[2 1 3] [3 2 5] [4 1 5] [4 3 7] [5 2 7] [6 1 7] [6 5 11] [7 4 11] [7 6 13]] == {PrimeSumPairs 7}}
{Show [[2 1 3] [3 2 5] [4 1 5] [4 3 7] [5 2 7] [6 1 7] [6 5 11] [7 4 11] [7 6 13] [8 3 11] [8 5 13]] ==
 {PrimeSumPairs 8}}
{Show [[2 1 3] [3 2 5] [4 1 5] [4 3 7] [5 2 7] [6 1 7] [6 5 11] [7 4 11] [7 6 13] [8 3 11] [8 5 13]
       [9 2 11] [9 4 13] [9 8 17]] ==
 {PrimeSumPairs 9}}
{Show [[2 1 3] [3 2 5] [4 1 5] [4 3 7] [5 2 7] [6 1 7] [6 5 11] [7 4 11] [7 6 13] [8 3 11] [8 5 13]
       [9 2 11] [9 4 13] [9 8 17] [10 1 11] [10 3 13] [10 7 17] [10 9 19]] ==
 {PrimeSumPairs 10}}

%%%
%%%    另见 List.subtract
%%%    
declare
fun {Remove Xs Y}
   {Filter Xs fun {$ Elt} Elt \= Y end}
end

declare
fun {Remove Xs Y}
   {Filter Xs {Core.partial {Core.complement Value.'=='} Y}}
end

{Show {Remove [a b c a d e] a}}
{Show {Remove [a b c a d e] x}}
{Show {Remove nil a}}

declare
fun {Permutations S}
   case S
   of nil then [nil]
   else {FlatMap S fun {$ X} {Map {Permutations {List.subtract S X}} {Core.partial Lisp.cons X}} end}
   end
end

{Show {Permutations nil}}
{Show {Permutations [a]}}
{Show {Permutations [a b]}}
{Show {Permutations [a b c]}}
{Show {Permutations [a b c d]}}
{Show {Permutations [a b c d e]}}







%%%
%%%    2.40
%%%
declare
fun {UniquePairs N}
   {FlatMap {EnumerateInterval 1 N}
    fun {$ I}
       {Map {EnumerateInterval 1 {Core.dec I}} fun {$ J} [I J] end}
    end}
end

{Show {UniquePairs 6}}

declare
fun {PrimeSumPairs N}
   {Map {Filter {UniquePairs N} IsPrimeSum} MakeTriple}
end

%%%
%%%    2.41
%%%
declare
fun {TripleSums N S}
   {Filter {FlatMap {EnumerateInterval 1 N}
            fun {$ I}
               {FlatMap {EnumerateInterval 1 {Core.dec I}}
                fun {$ J}
                   {Map {EnumerateInterval 1 {Core.dec J}} fun {$ K} [I J K] end}
                end}
            end}
    fun {$ Elt}
       {FoldL Elt Number.'+' 0} == S
    end}
end

{Show {TripleSums 6 10}}
{Show {TripleSums 6 11}}
{Show {TripleSums 10 10}}
{Show {TripleSums 10 20}}

declare
fun {UniqueTriples N}
   {FlatMap {EnumerateInterval 1 N}
    fun {$ I}
       {FlatMap {EnumerateInterval 1 {Core.dec I}}
        fun {$ J}
           {Map {EnumerateInterval 1 {Core.dec J}} fun {$ K} [I J K] end}
        end}
    end}
end

{Show {UniquePairs 6}}
{Show {UniqueTriples 6}}

declare
fun {TripleSums N S}
   {Filter {UniqueTriples N} {Core.partial Lisp.apply fun {$ A B C} A + B + C == S end}}
end
