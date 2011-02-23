From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clockevent
 hwmodright before timer init
Date: Wed, 23 Feb 2011 14:23:03 +0530
Message-ID: <581270b49665fcf8227a96065dbbc584@mail.gmail.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain> <20110223071153.5874.58923.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:60837 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754759Ab1BWIxG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 03:53:06 -0500
Received: by mail-qy0-f171.google.com with SMTP id 19so3121842qyj.16
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 00:53:05 -0800 (PST)
In-Reply-To: <20110223071153.5874.58923.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>

Paul,
> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Wednesday, February 23, 2011 12:42 PM
> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: Tony Lindgren; Kevin Hilman; Santosh Shilimkar; Beno=C4=ABt Couss=
on
> Subject: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER
> clockevent hwmodright before timer init
>
> Late-initialize the GPTIMER hwmod used for the clockevent source
> immediately
> before it is used.  This avoids the need to late-initialize all of
> the hwmods
> until the boot process is further along.  (In general, we want to
> defer
> as much as possible until late in the boot process.)
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Beno=C4=ABt Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/timer-gp.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-
> omap2/timer-gp.c
> index 0fc550e..a4e51a2 100644
> --- a/arch/arm/mach-omap2/timer-gp.c
> +++ b/arch/arm/mach-omap2/timer-gp.c
> @@ -40,10 +40,11 @@
>  #include <plat/dmtimer.h>
>  #include <asm/localtimer.h>
>  #include <asm/sched_clock.h>
> +#include <plat/common.h>
>
>  #include "timer-gp.h"
> +#include <plat/omap_hwmod.h>
>
> -#include <plat/common.h>
>
>  /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
>  #define MAX_GPTIMER_ID		12
> @@ -133,9 +134,13 @@ static void __init
> omap2_gp_clockevent_init(void)
>  {
>  	u32 tick_rate;
>  	int src;
> +	const char *clockevent_hwmod_name;
>
>  	inited =3D 1;
>
> +	clockevent_hwmod_name =3D (gptimer_id =3D=3D 12) ? "timer12" :
> "timer1";
> +	omap_hwmod_late_init_one(clockevent_hwmod_name);
> +

Do we need above hard-coding ? This takes away flexibility of
choosing system timer from board files, right ?

Am I missing something here?



>  	gptimer =3D omap_dm_timer_request_specific(gptimer_id);
>  	BUG_ON(gptimer =3D=3D NULL);
>  	gptimer_wakeup =3D gptimer;
> @@ -250,6 +255,7 @@ static void __init omap2_gp_timer_init(void)
>  		BUG_ON(!twd_base);
>  	}
>  #endif
> +
>  	omap_dm_timer_init();
>
>  	omap2_gp_clockevent_init();
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
