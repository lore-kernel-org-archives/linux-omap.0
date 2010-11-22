From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCHv4 6/14] OMAP4: dmtimer: add hwmod database
Date: Mon, 22 Nov 2010 11:32:11 +0530
Message-ID: <AANLkTikvUzdo9XN-WxoLoyimDi+j6wwTh+T9veF7_H9P@mail.gmail.com>
References: <1290220778-22244-1-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-2-git-send-email-tarun.kanti@ti.com> <1290220778-22244-3-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-4-git-send-email-tarun.kanti@ti.com> <1290220778-22244-5-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-6-git-send-email-tarun.kanti@ti.com> <1290220778-22244-7-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:50826 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750792Ab0KVGIY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 01:08:24 -0500
Received: by mail-iw0-f177.google.com with SMTP id 8so7699018iwn.8
        for <linux-omap@vger.kernel.org>; Sun, 21 Nov 2010 22:08:23 -0800 (PST)
In-Reply-To: <1290220778-22244-7-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, "Cousson, Benoit" <b-cousson@ti.com>

These comments are from other hwmod reviews.

On Sat, Nov 20, 2010 at 08:09, Tarun Kanti DebBarma <tarun.kanti@ti.com=
> wrote:
> From: Cousson, Benoit <b-cousson@ti.com>

Subject should be something like: ( See [1] )
OMAP4: hwmod data: add dmtimer

Same is applicable to other hwmod DB patches for OMAP2420, OMAP2430
& OMAP3 to add dmtimer data

>
> Add hwmod database for OMAP4.
>
> Signed-off-by: Cousson, Benoit <b-cousson@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0622 ++++++++++++++=
++++++++++++++

<<snip>>

> + =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP44=
30),
> +};
> +
> +/*
> =A0* 'wd_timer' class
> =A0* 32-bit watchdog upward counter that generates a pulse on the res=
et pin on
> =A0* overflow condition
> @@ -1068,6 +1678,18 @@ static __initdata struct omap_hwmod *omap44xx_=
hwmods[] =3D {
>
> =A0 =A0 =A0 =A0/* mpu class */
> =A0 =A0 =A0 =A0&omap44xx_mpu_hwmod,
> + =A0 =A0 =A0 /* timer class */
> + =A0 =A0 =A0 &omap44xx_timer1_hwmod,
> + =A0 =A0 =A0 &omap44xx_timer2_hwmod,
> + =A0 =A0 =A0 &omap44xx_timer3_hwmod,
> + =A0 =A0 =A0 &omap44xx_timer4_hwmod,
> + =A0 =A0 =A0 &omap44xx_timer5_hwmod,
> + =A0 =A0 =A0 &omap44xx_timer6_hwmod,
> + =A0 =A0 =A0 &omap44xx_timer7_hwmod,
> + =A0 =A0 =A0 &omap44xx_timer8_hwmod,
> + =A0 =A0 =A0 &omap44xx_timer9_hwmod,
> + =A0 =A0 =A0 &omap44xx_timer10_hwmod,
> + =A0 =A0 =A0 &omap44xx_timer11_hwmod,

Add a blank line between each class. See [2]
Same is applicable to other hwmod DB patches for OMAP2420, OMAP2430
& OMAP3 to add dmtimer data

[1] https://patchwork.kernel.org/patch/282472/
[2] https://patchwork.kernel.org/patch/308422/

> =A0 =A0 =A0 =A0/* wd_timer class */
> =A0 =A0 =A0 =A0&omap44xx_wd_timer2_hwmod,
> =A0 =A0 =A0 =A0&omap44xx_wd_timer3_hwmod,
> --
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
