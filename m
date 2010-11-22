From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCHv4 8/14] OMAP: dmtimer: platform driver
Date: Mon, 22 Nov 2010 12:43:16 +0530
Message-ID: <AANLkTinEafdEmcsc9adZWU=rJ79obz2vDybBZ38SS3bC@mail.gmail.com>
References: <1290220778-22244-1-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-2-git-send-email-tarun.kanti@ti.com> <1290220778-22244-3-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-4-git-send-email-tarun.kanti@ti.com> <1290220778-22244-5-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-6-git-send-email-tarun.kanti@ti.com> <1290220778-22244-7-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-8-git-send-email-tarun.kanti@ti.com> <1290220778-22244-9-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:42578 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750856Ab0KVHN5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 02:13:57 -0500
Received: by mail-iw0-f174.google.com with SMTP id 34so2525573iwn.19
        for <linux-omap@vger.kernel.org>; Sun, 21 Nov 2010 23:13:57 -0800 (PST)
In-Reply-To: <1290220778-22244-9-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

<<snip>>

> +static struct platform_driver omap_dmtimer_driver =3D {
> + =A0 =A0 =A0 .probe =A0=3D omap_dm_timer_probe,
> + =A0 =A0 =A0 .remove =3D omap_dm_timer_remove,
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "omap-timer",

Comment from Benoit on omap devices name ( see [1] ):

"If possible, it will be better to use the "omap_" prefix in order to
start having some consitency in the omap devices name. "

[1] https://patchwork.kernel.org/patch/305082/

> + =A0 =A0 =A0 },
> +};
> +

<<snip>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
