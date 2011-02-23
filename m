From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clockevent
 hwmodright before timer init
Date: Wed, 23 Feb 2011 17:18:40 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A09552D@dbde02.ent.ti.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
 <20110223071153.5874.58923.stgit@twilight.localdomain>
 <581270b49665fcf8227a96065dbbc584@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1257
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45165 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134Ab1BWLs6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 06:48:58 -0500
In-Reply-To: <581270b49665fcf8227a96065dbbc584@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Shilimkar, Santosh
> Sent: Wednesday, February 23, 2011 2:23 PM
> To: Paul Walmsley; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Cc: Tony Lindgren; Hilman, Kevin; Cousson, Benoit
> Subject: RE: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clocke=
vent
> hwmodright before timer init
>=20
> Paul,
> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Wednesday, February 23, 2011 12:42 PM
> > To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.or=
g
> > Cc: Tony Lindgren; Kevin Hilman; Santosh Shilimkar; Beno=EEt Cousso=
n
> > Subject: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER
> > clockevent hwmodright before timer init
> >
> > Late-initialize the GPTIMER hwmod used for the clockevent source
> > immediately
> > before it is used.  This avoids the need to late-initialize all of
> > the hwmods
> > until the boot process is further along.  (In general, we want to
> > defer
> > as much as possible until late in the boot process.)
> >
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Beno=EEt Cousson <b-cousson@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> >  arch/arm/mach-omap2/timer-gp.c |    8 +++++++-
> >  1 files changed, 7 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-
> > omap2/timer-gp.c
> > index 0fc550e..a4e51a2 100644
> > --- a/arch/arm/mach-omap2/timer-gp.c
> > +++ b/arch/arm/mach-omap2/timer-gp.c
> > @@ -40,10 +40,11 @@
> >  #include <plat/dmtimer.h>
> >  #include <asm/localtimer.h>
> >  #include <asm/sched_clock.h>
> > +#include <plat/common.h>
> >
> >  #include "timer-gp.h"
> > +#include <plat/omap_hwmod.h>
> >
> > -#include <plat/common.h>
> >
> >  /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
> >  #define MAX_GPTIMER_ID		12
> > @@ -133,9 +134,13 @@ static void __init
> > omap2_gp_clockevent_init(void)
> >  {
> >  	u32 tick_rate;
> >  	int src;
> > +	const char *clockevent_hwmod_name;
> >
> >  	inited =3D 1;
> >
> > +	clockevent_hwmod_name =3D (gptimer_id =3D=3D 12) ? "timer12" :
> > "timer1";
> > +	omap_hwmod_late_init_one(clockevent_hwmod_name);
> > +
>=20
> Do we need above hard-coding ? This takes away flexibility of
> choosing system timer from board files, right ?
>=20
> Am I missing something here?
Currently, omap_4430sdp_init_early() and omap3_beagle_init_irq() calls
omap2_gp_clockevent_set_gptimer(id) to set it to 1 and 12 respectively.
=46or OMAP24xx, the default settings of gptimer_id=3D1 is taken.
In summary, we are losing the flexibility.
Instead we could have something like:
sscanf(clockevent_hwmod_name, "timer%2d", &gptimer_id);
--
Tarun
>=20
>=20
>=20
> >  	gptimer =3D omap_dm_timer_request_specific(gptimer_id);
> >  	BUG_ON(gptimer =3D=3D NULL);
> >  	gptimer_wakeup =3D gptimer;
> > @@ -250,6 +255,7 @@ static void __init omap2_gp_timer_init(void)
> >  		BUG_ON(!twd_base);
> >  	}
> >  #endif
> > +
> >  	omap_dm_timer_init();
> >
> >  	omap2_gp_clockevent_init();
> >
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
