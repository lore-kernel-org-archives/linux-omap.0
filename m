From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v5 8/12] OMAP2+: dmtimer: convert to platform devices
Date: Tue, 7 Dec 2010 11:16:19 +0530
Message-ID: <AANLkTim4Kq2xA-RZ21HuX0Du2umzyJuGs4=mCufEuNc6@mail.gmail.com>
References: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com> <1291679059-13419-9-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:59508 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751138Ab0LGFrA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Dec 2010 00:47:00 -0500
Received: by mail-iw0-f170.google.com with SMTP id 2so771154iwn.15
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 21:46:59 -0800 (PST)
In-Reply-To: <1291679059-13419-9-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

Tarun,

On Tue, Dec 7, 2010 at 05:14, Tarun Kanti DebBarma <tarun.kanti@ti.com>=
 wrote:
> Add routines to converts dmtimers to platform devices. The device dat=
a
> is obtained from hwmod database of respective platform and is registe=
red
> to device model after successful binding to driver. It also provides
> provision to access timers during early boot when pm_runtime framewor=
k
> is not completely up and running.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Reviewed-by: Cousson, Benoit <b-cousson@ti.com>
> Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
> ---
> =A0arch/arm/mach-omap2/Makefile =A0| =A0 =A02 +-
> =A0arch/arm/mach-omap2/dmtimer.c | =A0174 +++++++++++++++++++++++++++=
++++++++++++++
> =A02 files changed, 175 insertions(+), 1 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/dmtimer.c
>

<<snip>>

> +/**
> + * omap_timer_init - build and register timer device with an
> + * associated timer hwmod
> + * @oh: =A0 =A0 =A0 =A0timer hwmod pointer to be used to build timer=
 device
> + * @user: =A0 =A0 =A0parameter that can be passed from calling hwmod=
 API
> + *
> + * Called by omap_hwmod_for_each_by_class to register each of the ti=
mer
> + * devices present in the system. The number of timer devices is kno=
wn
> + * by parsing through the hwmod database for a given class name. At =
the
> + * end of function call memory is allocated for timer device and it =
is
> + * registered to the framework ready to be proved by the driver.
> + */
> +static int __init omap_timer_init(struct omap_hwmod *oh, void *user)
> +{
> + =A0 =A0 =A0 int id;
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 char *name =3D "omap_timer";
> + =A0 =A0 =A0 struct dmtimer_platform_data *pdata;
> + =A0 =A0 =A0 struct omap_device *od;
> +
> + =A0 =A0 =A0 pr_debug("%s: %s\n", __func__, oh->name);
> +
> + =A0 =A0 =A0 pdata =3D kzalloc(sizeof(*pdata), GFP_KERNEL);
> + =A0 =A0 =A0 if (!pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: No memory for [%s]\n", __fu=
nc__, oh->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (user)

Check for the value of "user".

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->is_early_init =3D 1;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->is_early_init =3D 0;
> +
> + =A0 =A0 =A0 /* hook clock set/get functions */
> + =A0 =A0 =A0 pdata->set_timer_src =3D omap2_dm_timer_set_src;
> +

<<snip>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
