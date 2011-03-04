From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v11 2/8] OMAP4: hwmod data: add dmtimer version information
Date: Thu, 03 Mar 2011 16:24:11 -0800
Message-ID: <871v2npwb8.fsf@ti.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
	<1298546811-27055-3-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:37520 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751120Ab1CDAYP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 19:24:15 -0500
Received: by pve39 with SMTP id 39so243780pve.3
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 16:24:14 -0800 (PST)
In-Reply-To: <1298546811-27055-3-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Thu, 24 Feb 2011 16:56:45 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> OMAP4 has two groups of timers: version 1 timers are 1, 2, 10,
> while the rest of the timers, 3-9, 11 are version 2 timers.
> The version information is required by the driver so that they
> could be handled correctly by it.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Minor comment below, also needs an ack from Beno=C3=AEt...

> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +++
>  arch/arm/plat-omap/include/plat/dmtimer.h  |    2 ++
>  2 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/ma=
ch-omap2/omap_hwmod_44xx_data.c
> index 79a8601..ee57742 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -25,6 +25,7 @@
>  #include <plat/gpio.h>
>  #include <plat/dma.h>
>  #include <plat/mcspi.h>
> +#include <plat/dmtimer.h>
> =20
>  #include "omap_hwmod_common_data.h"
> =20
> @@ -3940,6 +3941,7 @@ static struct omap_hwmod_class_sysconfig omap44=
xx_timer_1ms_sysc =3D {
>  static struct omap_hwmod_class omap44xx_timer_1ms_hwmod_class =3D {
>  	.name	=3D "timer",
>  	.sysc	=3D &omap44xx_timer_1ms_sysc,
> +	.rev =3D OMAP_TIMER_IP_VERSION_1,

Please use tab and align '=3D' with above lines.

>  };
> =20
>  static struct omap_hwmod_class_sysconfig omap44xx_timer_sysc =3D {
> @@ -3955,6 +3957,7 @@ static struct omap_hwmod_class_sysconfig omap44=
xx_timer_sysc =3D {
>  static struct omap_hwmod_class omap44xx_timer_hwmod_class =3D {
>  	.name	=3D "timer",
>  	.sysc	=3D &omap44xx_timer_sysc,
> +	.rev =3D OMAP_TIMER_IP_VERSION_2,

ditto

>  };
> =20
>  /* timer1 */
> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/pla=
t-omap/include/plat/dmtimer.h
> index d6c70d2..05a967e 100644
> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> @@ -55,6 +55,8 @@
>   * in OMAP4 can be distinguished.
>   */
>  #define OMAP_TIMER_IP_VERSION_1                        0x1
> +#define OMAP_TIMER_IP_VERSION_2                        0x2
> +
>  struct omap_dm_timer;
>  extern struct omap_dm_timer *gptimer_wakeup;
>  extern struct sys_timer omap_timer;
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
