From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH v2 00/20] dspbridge cleanups
Date: Tue, 1 Dec 2009 12:46:11 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A530426FE2ADE@dlee03.ent.ti.com>
References: <1259618101-8972-1-git-send-email-omar.ramirez@ti.com>
 <5ec8ebd50911302249y125456d4r10eea55fab400dbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49230 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132AbZLASqN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 13:46:13 -0500
In-Reply-To: <5ec8ebd50911302249y125456d4r10eea55fab400dbc@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Artem Bityutskiy <dedekind1@gmail.com>, Felipe Balbi <felipe.balbi@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, "Menon, Nishanth" <nm@ti.com>



>-----Original Message-----
>From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
>Sent: Tuesday, December 01, 2009 12:50 AM
>To: Ramirez Luna, Omar
>Cc: linux-omap; Artem Bityutskiy; Felipe Balbi; Felipe Contreras; Hiro=
shi Doyu; Menon, Nishanth
>Subject: Re: [PATCH v2 00/20] dspbridge cleanups
>
>On Mon, Nov 30, 2009 at 11:54 PM, Omar Ramirez Luna <omar.ramirez@ti.c=
om> wrote:
>
>> =A0arch/arm/plat-omap/include/dspbridge/list.h =A0 =A0 =A0 =A0| =A0 =
36 +-

DSPBRIDGE: trivial file history cleanup for headers

@@ -14,39 +17,6 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */

-
-/*
- *  =3D=3D=3D=3D=3D=3D=3D=3D list.h =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose:
- *      Declarations of list management control structures and definit=
ions
- *      of inline list management functions.
- *
- *  Public Functions:
- *      LST_Create
- *      LST_Delete
- *      LST_Exit
- *      LST_First
- *      LST_GetHead
- *      LST_InitElem
- *      LST_Init
- *      LST_InsertBefore
- *      LST_IsEmpty
- *      LST_Next
- *      LST_PutTail
- *      LST_RemoveElem
- *
- *  Notes:
- *
- *! Revision History
- *! =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- *! 10-Aug-2000 ag:  Added LST_InsertBefore().
- *! 29-Oct-1999 kc:  Cleaned up for code review.
- *! 16-Aug-1997 cr:  added explicit identifiers.
- *! 10-Aug-1996 gp:  Acquired from SMM for WinSPOX v.1.1; renamed iden=
tifiers.
- *! 21-Oct-1994 dh4: Cleaned / commented for code review.
- *! 08-Jun-1994 dh4: Converted to SPM (added extern "C").
- */
-
 #ifndef LIST_
 #define LIST_


>> =A0drivers/dsp/bridge/services/list.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 33 -

DSPBRIDGE: trivial file history cleanup for driver sources

@@ -14,39 +14,6 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */

-
-/*
- *  =3D=3D=3D=3D=3D=3D=3D=3D listce.c =3D=3D=3D=3D=3D=3D=3D=3D
- *  Purpose
- *      Provides standard circular list handling functions.
- *
- *  Public Functions:
- *      LST_Create
- *      LST_Delete
- *      LST_Exit
- *      LST_First
- *      LST_GetHead
- *      LST_Init
- *      LST_InitElem
- *      LST_InsertBefore
- *      LST_Next
- *      LST_PutTail
- *      LST_RemoveElem
- *
- *! Revision History
- *! =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- *! 06-Mar-2002 jeh Don't set element self to NULL in LST_RemoveElem()=
=2E
- *! 10-Aug-2000 ag: Added LST_InsertBefore().
- *! 03-Feb-2000 rr: Module init/exit is handled by SERVICES Init/Exit.
- *!             GT Changes.
- *! 22-Nov-1999 kc: Added changes from code review.
- *! 10-Aug-1999 kc: Based on wsx-c18.
- *! 16-Jun-1997 gp: Removed unnecessary enabling/disabling of interrup=
ts around
- *!                 list manipulation code.
- *! 22-Oct-1996 gp: Added LST_RemoveElem, and LST_First/LST_Next itera=
tors.
- *! 10-Aug-1996 gp: Acquired from SMM for WinSPOX v. 1.1; renamed iden=
tifiers.
- */
-

The original patch is way too big for the list about 250 KB, I just spl=
it those to modify header and sources separately, but they are still bi=
g. They can be found on the *temporary* experimental branch.=20
http://dev.omapzoom.org/?p=3Dtidspbridge/kernel-dspbridge.git;a=3Dshort=
log;h=3Drefs/heads/experimental

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
