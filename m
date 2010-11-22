From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCHv4 11/14] OMAP2+: dmtimer: convert to platform devices
Date: Mon, 22 Nov 2010 13:54:41 +0530
Message-ID: <AANLkTi=R6wZ486qMm+9Ktbhb_w0aysq80JfpE8+ujRL0@mail.gmail.com>
References: <1290220778-22244-1-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-2-git-send-email-tarun.kanti@ti.com> <1290220778-22244-3-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-4-git-send-email-tarun.kanti@ti.com> <1290220778-22244-5-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-6-git-send-email-tarun.kanti@ti.com> <1290220778-22244-7-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-8-git-send-email-tarun.kanti@ti.com> <1290220778-22244-9-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-10-git-send-email-tarun.kanti@ti.com> <1290220778-22244-11-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-12-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:51212 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750991Ab0KVIZW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 03:25:22 -0500
Received: by mail-iw0-f179.google.com with SMTP id 2so8190645iwn.38
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 00:25:22 -0800 (PST)
In-Reply-To: <1290220778-22244-12-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>, Partha Basak <p-basak2@ti.com>

<<snip>>

> +/**
> + * omap_timer_init - top level timer device initialization
> + *
> + * uses dedicated hwmod api to parse through hwmod database for
> + * given class names and then build and register the timer device.
> + */
> +static int __init omap2_dmtimer_device_init(void)
> +{
> + =A0 =A0 =A0 int ret =3D omap_hwmod_for_each_by_class("timer", omap2=
_timer_init, NULL);
> +
> + =A0 =A0 =A0 if (unlikely(ret))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: device registration FAILE=
D\n", __func__);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +arch_initcall(omap2_dmtimer_device_init);

While introducing this, calls to omap_dm_timer_init() should be
removed. Else, the init
will happen twice for dmtimer devices

> --
> 1.6.0.4
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
