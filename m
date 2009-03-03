From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [OMAPZOOM][PATCH 5/5] DSPBRIDGE: Remove unnecessary checks in
 	HW_MBOX_IsFull
Date: Tue, 3 Mar 2009 10:41:41 -0600
Message-ID: <496565EC904933469F292DDA3F1663E60287B84F1D@dlee06.ent.ti.com>
References: <496565EC904933469F292DDA3F1663E60287B84DFA@dlee06.ent.ti.com>
 <94a0d4530903022322mad6ff40v806c3be7f897939f@mail.gmail.com>
 <496565EC904933469F292DDA3F1663E60287B84F0E@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42544 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757114AbZCCQlt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Mar 2009 11:41:49 -0500
In-Reply-To: <496565EC904933469F292DDA3F1663E60287B84F0E@dlee06.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Aguilar Pena, Leed" <leed.aguilar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


=46elipe,

	This patch also remove some check no needed; this part

-	/* Check input parameters */
-	CHECK_INPUT_PARAM(baseAddress, 0, RET_BAD_NULL_PARAM, RES_MBOX_BASE +
-			RES_INVALID_INPUT_PARAM);
-	CHECK_INPUT_PARAM(pIsFull,  NULL, RET_BAD_NULL_PARAM, RES_MBOX_BASE +
-			RES_INVALID_INPUT_PARAM);
-	CHECK_INPUT_RANGE_MIN0(mailBoxId, HW_MBOX_ID_MAX, RET_INVALID_ID,
-			RES_MBOX_BASE + RES_INVALID_INPUT_PARAM);
-

And change the function to inline.

Please let me know if you thing it needs something else.

Regards,
=46ernando.

-----Original Message-----
=46rom: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.=
kernel.org] On Behalf Of Guzman Lugo, Fernando
Sent: Tuesday, March 03, 2009 10:35 AM
To: Felipe Contreras
Cc: Pandita, Vikram; Kanigeri, Hari; Aguilar Pena, Leed; linux-omap@vge=
r.kernel.org
Subject: RE: [OMAPZOOM][PATCH 5/5] DSPBRIDGE: Remove unnecessary checks=
 in HW_MBOX_IsFull


Hi Felipe,

	This patch is base on your patch about increase the performance waitin=
g less and checking more the mail box.

Regards,
=46ernando.

-----Original Message-----
=46rom: Felipe Contreras [mailto:felipe.contreras@gmail.com]=20
Sent: Tuesday, March 03, 2009 1:22 AM
To: Guzman Lugo, Fernando
Cc: Pandita, Vikram; Kanigeri, Hari; Aguilar Pena, Leed; linux-omap@vge=
r.kernel.org
Subject: Re: [OMAPZOOM][PATCH 5/5] DSPBRIDGE: Remove unnecessary checks=
 in HW_MBOX_IsFull

On Tue, Mar 3, 2009 at 3:35 AM, Guzman Lugo, Fernando <x0095840@ti.com>=
 wrote:
> From db89674b7316d7490e71c131091758eb7ef0eca2 Mon Sep 17 00:00:00 200=
1
> From: Fernando Guzman Lugo <x0095840@ti.com>
> Date: Wed, 25 Feb 2009 19:27:41 -0600
> Subject: [PATCH] DSPBRIDGE: Remove unnecessary checks in HW_MBOX_IsFu=
ll function
>
> This patch removes some unnecesarry checks in HW_MBOX_IsFull
> function

Is that all this patch is doing?

> - =A0 =A0 =A0 u16 cnt =3D 10;
> + =A0 =A0 =A0 u16 cnt =3D 1000;

> - =A0 =A0 =A0 while (--cnt) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 hwStatus =3D HW_MBOX_IsFull(resources.d=
wMboxBase,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0MBOX_ARM2DSP, &mbxFull);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mbxFull)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 UTIL_Wait(1000); =A0 =A0=
 =A0 =A0/* wait for 1 ms) =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 while (--cnt && HW_MBOX_IsFull(resources.dwMboxBase, MB=
OX_ARM2DSP))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
> +

--=20
=46elipe Contreras

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
