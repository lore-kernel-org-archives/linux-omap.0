From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clockevent
 hwmodright before timer init
Date: Thu, 24 Feb 2011 13:59:01 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A0958B7@dbde02.ent.ti.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
 <20110223071153.5874.58923.stgit@twilight.localdomain>
 <581270b49665fcf8227a96065dbbc584@mail.gmail.com>
 <alpine.DEB.2.00.1102240109500.6198@utopia.booyaka.com>
 <alpine.DEB.2.00.1102240114160.6198@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58797 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492Ab1BXI3P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 03:29:15 -0500
In-Reply-To: <alpine.DEB.2.00.1102240114160.6198@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Thursday, February 24, 2011 1:45 PM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;=
 Tony
> Lindgren; Hilman, Kevin; Cousson, Benoit
> Subject: RE: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clocke=
vent
> hwmodright before timer init
>=20
> Hello Santosh,
>=20
> On Thu, 24 Feb 2011, Paul Walmsley wrote:
>=20
> > I propose the following change instead - please let me know what yo=
u
> > think.
>=20
> Oops - the patch I sent you was not completely refreshed in the local
> tree.  Here is the correct one.
I have tested on OMAP3 and works fine.
On OMAP2, I guess there is different issue for which it does not work.
--
Tarun
>=20
> From: Paul Walmsley <paul@pwsan.com>
> Date: Wed, 23 Feb 2011 00:14:08 -0700
> Subject: [PATCH] OMAP2+: clockevent: late-init GPTIMER clockevent hwm=
od
> right before timer init
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
> This second version fixes a bug pointed out by Santosh Shilimkar
> <santosh.shilimkar@ti.com>, that would cause the kernel to use an
> incorrect timer hwmod name if the selected GPTIMER was not 1 or 12 -
> thanks Santosh.  Also, Tarun Kanti DebBarma <tarun.kanti@ti.com>
> pointed out that the original patch did not apply cleanly; this has
> now been fixed.
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Beno=EEt Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
>  arch/arm/mach-omap2/timer-gp.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/tim=
er-
> gp.c
> index 7b7c268..b289d53 100644
> --- a/arch/arm/mach-omap2/timer-gp.c
> +++ b/arch/arm/mach-omap2/timer-gp.c
> @@ -39,10 +39,11 @@
>  #include <asm/mach/time.h>
>  #include <plat/dmtimer.h>
>  #include <asm/localtimer.h>
> +#include <plat/common.h>
> +#include <plat/omap_hwmod.h>
>=20
>  #include "timer-gp.h"
>=20
> -#include <plat/common.h>
>=20
>  /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
>  #define MAX_GPTIMER_ID		12
> @@ -132,9 +133,13 @@ static void __init omap2_gp_clockevent_init(void=
)
>  {
>  	u32 tick_rate;
>  	int src;
> +	char clockevent_hwmod_name[8]; /* 8 =3D sizeof("timerXX0") */
>=20
>  	inited =3D 1;
>=20
> +	sprintf(clockevent_hwmod_name, "timer%d", gptimer_id);
> +	omap_hwmod_late_init_one(clockevent_hwmod_name);
> +
>  	gptimer =3D omap_dm_timer_request_specific(gptimer_id);
>  	BUG_ON(gptimer =3D=3D NULL);
>  	gptimer_wakeup =3D gptimer;
> --
> 1.7.2.3
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
