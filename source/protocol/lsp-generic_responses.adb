------------------------------------------------------------------------------
--                         Language Server Protocol                         --
--                                                                          --
--                     Copyright (C) 2018-2019, AdaCore                     --
--                                                                          --
-- This is free software;  you can redistribute it  and/or modify it  under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  This software is distributed in the hope  that it will be useful, --
-- but WITHOUT ANY WARRANTY;  without even the implied warranty of MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public --
-- License for  more details.  You should have  received  a copy of the GNU --
-- General  Public  License  distributed  with  this  software;   see  file --
-- COPYING3.  If not, go to http://www.gnu.org/licenses for a complete copy --
-- of the license.                                                          --
------------------------------------------------------------------------------

with LSP.JSON_Streams;

package body LSP.Generic_Responses is

   procedure Read
     (S : access Ada.Streams.Root_Stream_Type'Class;
      V : out Response)
   is
      JS : LSP.JSON_Streams.JSON_Stream'Class renames
        LSP.JSON_Streams.JSON_Stream'Class (S.all);
   begin
      JS.Start_Object;
      LSP.Messages.Read_Response_Prefix (S, V);

      if not V.Is_Error then
         JS.Key ("result");
         T'Read (S, V.result);
      end if;

      JS.End_Object;
   end Read;

   -----------
   -- Write --
   -----------

   procedure Write
     (S : not null access Ada.Streams.Root_Stream_Type'Class;
      V : Response)
   is
      JS : LSP.JSON_Streams.JSON_Stream'Class renames
        LSP.JSON_Streams.JSON_Stream'Class (S.all);
   begin
      JS.Start_Object;
      LSP.Messages.Write_Response_Prefix (S, V);

      if not V.Is_Error then
         JS.Key ("result");
         T'Write (S, V.result);
      end if;

      JS.End_Object;
   end Write;

end LSP.Generic_Responses;
