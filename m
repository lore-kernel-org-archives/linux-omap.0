From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [RFC PATCH 07/10] OMAP: GPIO: cleanup suspend and resume functions
Date: Fri, 20 May 2011 14:50:42 +0530
Message-ID: <BANLkTim50UAuwen2LRfdyOGZsOKA3mbxgQ@mail.gmail.com>
References: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com> <1305546104-1511-8-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:59282 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935449Ab1ETJVX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 05:21:23 -0400
Received: by iye7 with SMTP id 7so3221395iye.20
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 02:21:22 -0700 (PDT)
In-Reply-To: <1305546104-1511-8-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>

Tarun,

On Mon, May 16, 2011 at 17:11, Tarun Kanti DebBarma <tarun.kanti@ti.com=
> wrote:
> Since wake_status, wake_clear, wake_set is common for all banks on a =
given
> OMAP version it is enough to get their values once during probe().
> Also, register offsets are already initialzed according to OMAP versi=
ons
> during device registration. We no longer need these explicit checks.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Cc: Charulatha V <charu@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
> =A0arch/arm/mach-omap1/gpio16xx.c =A0 =A0 =A0 =A0 | =A0 =A03 +
> =A0arch/arm/mach-omap2/gpio.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06 +++
> =A0arch/arm/plat-omap/gpio.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 78 ++++=
+++------------------------
> =A0arch/arm/plat-omap/include/plat/gpio.h | =A0 =A03 +
> =A04 files changed, 30 insertions(+), 60 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpi=
o16xx.c
> index d886b88..bc4cc8f 100644
> --- a/arch/arm/mach-omap1/gpio16xx.c
> +++ b/arch/arm/mach-omap1/gpio16xx.c
> @@ -46,6 +46,9 @@ static struct omap_gpio_reg_offs omap16xx_mpuio_reg=
s =3D {
> =A0 =A0 =A0 =A0.irqenable =A0 =A0 =A0=3D OMAP_MPUIO_GPIO_MASKIT,
> =A0 =A0 =A0 =A0.irqenable_inv =A0=3D true,
> =A0 =A0 =A0 =A0.ctrl =A0 =A0 =A0 =A0 =A0 =3D USHRT_MAX,
> + =A0 =A0 =A0 .wkupstatus =A0 =A0 =3D OMAP1610_GPIO_WAKEUPENABLE,
> + =A0 =A0 =A0 .wkupclear =A0 =A0 =A0=3D OMAP1610_GPIO_CLEAR_WAKEUPENA=
,
> + =A0 =A0 =A0 .wkupset =A0 =A0 =A0 =A0=3D OMAP1610_GPIO_SET_WAKEUPENA=
,

This should have been added for omap16xx_gpio_regs and not for
omap16xx_mpuio_regs.

-V Charulatha

>  };
>
> =A0static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpio=
_config =3D {

[...]
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
