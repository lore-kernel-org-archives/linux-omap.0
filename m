From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [OMAPZOOM][PATCH 5/5] DSPBRIDGE: Remove unnecessary checks in
	HW_MBOX_IsFull
Date: Tue, 3 Mar 2009 09:22:03 +0200
Message-ID: <94a0d4530903022322mad6ff40v806c3be7f897939f@mail.gmail.com>
References: <496565EC904933469F292DDA3F1663E60287B84DFA@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:58119 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbZCCHWG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Mar 2009 02:22:06 -0500
Received: by fg-out-1718.google.com with SMTP id 16so33737fgg.17
        for <linux-omap@vger.kernel.org>; Mon, 02 Mar 2009 23:22:03 -0800 (PST)
In-Reply-To: <496565EC904933469F292DDA3F1663E60287B84DFA@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Aguilar Pena, Leed" <leed.aguilar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

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

> - =C2=A0 =C2=A0 =C2=A0 u16 cnt =3D 10;
> + =C2=A0 =C2=A0 =C2=A0 u16 cnt =3D 1000;

> - =C2=A0 =C2=A0 =C2=A0 while (--cnt) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hwStatus =3D HW_MB=
OX_IsFull(resources.dwMboxBase,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0MBOX_ARM2DSP, &mbxFull);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mbxFull)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 UTIL_Wait(1000); =C2=A0 =C2=A0 =C2=A0 =C2=A0/* wait for 1 ms) =C2=
=A0 =C2=A0 =C2=A0*/
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 break;
> - =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 while (--cnt && HW_MBOX_IsFull(resources.dwMbo=
xBase, MBOX_ARM2DSP))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 udelay(1);
> +

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
