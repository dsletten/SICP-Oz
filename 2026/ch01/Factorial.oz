%%%
%%%   Name:               Factorial.oz
%%%
%%%   Started:            Fri Mar 27 02:04:27 2026
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

local Fact in
   fun {Fact N}
      if N == 1 then 1
      else N*{Fact N-1}
      end
   end
   {Show {Fact 6}}
end

local Fact in
   local G1 in
      local G2 in
         Fact = proc {$ N F}
                   local G3 in
                      local G4 in
                         local G5 in
                            G5 = 1
                            G4 = Value.'=='
                            {G4 N G5 G3}
                            if G3 then
                               F = 1
                            else
                               local G6 in
                                  local G7 in
                                     local G8 in
                                        local G9 in
                                           local G10 in
                                              local G11 in
                                                 G11 = 1
                                                 G10 = Number.'-'
                                                 {G10 N G11 G9}
                                                 {Fact G9 G8}
                                                 G7 = Number.'*'
                                                 {G7 N G8 G6}
                                                 F = G6
                                              end
                                           end
                                        end
                                     end
                                  end
                               end
                            end
                         end
                      end
                   end
                end
         G2 = 6
         {Fact G2 G1}
         {Show G1}
      end
   end
end

local Fact in
   fun {Fact N}
      fun {Iterate I Result}
         if I > N then Result
         else {Iterate I+1 I*Result}
         end
      end
   in
      {Iterate 1 1}
   end
   {Show {Fact 6}}
end

local Fact in
   local G1 in
      local G2 in
         Fact = proc {$ N Result1}
                   local Iterate in
                      local G3 in
                         local G4 in
                            Iterate = proc {$ I Result Result2}
                                         local G5 in
                                            local G6 in
                                               G6 = Value.'>'
                                               {G6 I N G5}
                                               if G5 then
                                                  Result2 = Result
                                               else
                                                  local G7 in
                                                     local G8 in
                                                        local G9 in
                                                           local G10 in
                                                              local G11 in 
                                                                 G8 = 1
                                                                 G10 = Number.'+'
                                                                 {G10 I G8 G7}
                                                                 G11 = Number.'*'
                                                                 {G11 I Result G9}
                                                                 {Iterate G7 G9 Result2}
                                                              end
                                                           end
                                                        end
                                                     end
                                                  end
                                               end
                                            end
                                         end
                                      end
                            G3 = 1
                            G4 = 1
                            {Iterate G3 G4 Result1}
                         end
                      end
                   end
                end
         G2 = 6
         {Fact G2 G1}
         {Show G1}
      end
   end
end
