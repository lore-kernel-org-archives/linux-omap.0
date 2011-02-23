From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clockevent
 hwmod	right before timer init
Date: Wed, 23 Feb 2011 14:43:30 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A095471@dbde02.ent.ti.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
 <20110223071153.5874.58923.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38974 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932088Ab1BWJNl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 04:13:41 -0500
In-Reply-To: <20110223071153.5874.58923.stgit@twilight.localdomain>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Wednesday, February 23, 2011 12:42 PM
> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: Tony Lindgren; Hilman, Kevin; Shilimkar, Santosh; Cousson, Benoit
> Subject: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clockevent
> hwmod right before timer init
I am not able to apply this patch.
Patch 1-7 applied successfully on top of:
04aa67d  Merge branch 'for-tony' of git://gitorious.org/usb/usb into om=
ap-for-linus

--
Tarun
>=20
> Late-initialize the GPTIMER hwmod used for the clockevent source
> immediately
> before it is used.  This avoids the need to late-initialize all of th=
e
> hwmods
> until the boot process is further along.  (In general, we want to def=
er
> as much as possible until late in the boot process.)
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Beno=EEt Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/timer-gp.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/tim=
er-
> gp.c
> index 0fc550e..a4e51a2 100644
> --- a/arch/arm/mach-omap2/timer-gp.c
> +++ b/arch/arm/mach-omap2/timer-gp.c
> @@ -40,10 +40,11 @@
>  #include <plat/dmtimer.h>
>  #include <asm/localtimer.h>
>  #include <asm/sched_clock.h>
> +#include <plat/common.h>
>=20
>  #include "timer-gp.h"
> +#include <plat/omap_hwmod.h>
>=20
> -#include <plat/common.h>
>=20
>  /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
>  #define MAX_GPTIMER_ID		12
> @@ -133,9 +134,13 @@ static void __init omap2_gp_clockevent_init(void=
)
>  {
>  	u32 tick_rate;
>  	int src;
> +	const char *clockevent_hwmod_name;
>=20
>  	inited =3D 1;
>=20
> +	clockevent_hwmod_name =3D (gptimer_id =3D=3D 12) ? "timer12" : "tim=
er1";
> +	omap_hwmod_late_init_one(clockevent_hwmod_name);
> +
>  	gptimer =3D omap_dm_timer_request_specific(gptimer_id);
>  	BUG_ON(gptimer =3D=3D NULL);
>  	gptimer_wakeup =3D gptimer;
> @@ -250,6 +255,7 @@ static void __init omap2_gp_timer_init(void)
>  		BUG_ON(!twd_base);
>  	}
>  #endif
> +
>  	omap_dm_timer_init();
>=20
>  	omap2_gp_clockevent_init();
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
