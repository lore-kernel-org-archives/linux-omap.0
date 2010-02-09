From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] DSPBRIDGE: Prevent memory corruption in
	DRV_ProcFreeDMMRes
Date: Wed, 10 Feb 2010 01:48:28 +0200
Message-ID: <94a0d4531002091548n18897915kd236f9f7b332c1eb@mail.gmail.com>
References: <441be695a293805f9de42ad5ce5bf6bca21434fc.1265660264.git.ameya.palande@nokia.com>
	 <94a0d4531002090429n77e65230r4cb426e92384595c@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E602AA725BDE@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f183.google.com ([209.85.223.183]:40594 "EHLO
	mail-iw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469Ab0BIXs3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Feb 2010 18:48:29 -0500
Received: by iwn13 with SMTP id 13so9057765iwn.25
        for <linux-omap@vger.kernel.org>; Tue, 09 Feb 2010 15:48:28 -0800 (PST)
In-Reply-To: <496565EC904933469F292DDA3F1663E602AA725BDE@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Menon, Nishanth" <nm@ti.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "ext-phil.2.carmody@nokia.com" <ext-phil.2.carmody@nokia.com>

On Tue, Feb 9, 2010 at 10:22 PM, Guzman Lugo, Fernando <x0095840@ti.com=
> wrote:
> The root problem here is that remove the DMM element should be in PRO=
C_UnMap but in PROC_UnReserveMemory, because apart of the problem your =
are seeing about memory corruption if the application does a PROC_Reser=
veMemory and then it finished unexpectedly the resource cleanup wont be=
 able to unreserved the memory because there is no a DMMres element in =
process context struct, the same applies in the case of application cal=
ls =C2=A0PROC_ReserveMemory, PROC_Map, PROC_UnMap but fails to do the P=
ROC_UnReserveMemory.

No, that's a completely different issue, but also valid.

> So the right solution should be:
>
> 1 .- Remove DRV_InsertDMMResElement function from PROC_Map and put it=
 on PROC_ReserveMemory.
>
> 2.- Keep DRV_UpdateDMMResElement function in PROC_Map.
>
> 3.- Remove DRV_RemoveDMMResElement function from PROC_UnMap and put i=
t on ROC_UnReserveMemory function.
>
> 4.- Clear dmmAllocated flag in PROC_UnMap:
>
> pDMMRes->dmmAllocated =3D 0;

At this point there's an obvious question; what's the point of
reserving a memory region and not mapping it?

I remember the answer from Hari was: some clients prefer to reserve a
big region once, and map parts of it continuously. I have my doubts
that the use-case even works with the current code-base. But assuming
it does work, your proposed changes would break it.

It would be much easier to merge the two functions into one.

Anyway, please re-read Ameya's description carefully.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
