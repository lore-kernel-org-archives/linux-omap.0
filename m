From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clockevent
 hwmodright before timer init
Date: Thu, 24 Feb 2011 01:13:38 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102240109500.6198@utopia.booyaka.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain> <20110223071153.5874.58923.stgit@twilight.localdomain> <581270b49665fcf8227a96065dbbc584@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1273003510-1298535218=:6198"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46265 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755250Ab1BXINj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 03:13:39 -0500
In-Reply-To: <581270b49665fcf8227a96065dbbc584@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1273003510-1298535218=:6198
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Santosh,

On Wed, 23 Feb 2011, Santosh Shilimkar wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Wednesday, February 23, 2011 12:42 PM
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
> >  #define MAX_GPTIMER_ID=09=0912
> > @@ -133,9 +134,13 @@ static void __init
> > omap2_gp_clockevent_init(void)
> >  {
> >  =09u32 tick_rate;
> >  =09int src;
> > +=09const char *clockevent_hwmod_name;
> >
> >  =09inited =3D 1;
> >
> > +=09clockevent_hwmod_name =3D (gptimer_id =3D=3D 12) ? "timer12" :
> > "timer1";
> > +=09omap_hwmod_late_init_one(clockevent_hwmod_name);
> > +
>=20
> Do we need above hard-coding ? This takes away flexibility of
> choosing system timer from board files, right ?
>=20
> Am I missing something here?

You are absolutely right.  That was an error on my part.  I propose the=20
following change instead - please let me know what you think.


- Paul


From: Paul Walmsley <paul@pwsan.com>
Date: Wed, 23 Feb 2011 00:14:08 -0700
Subject: [PATCH] OMAP2+: clockevent: late-init GPTIMER clockevent hwmod rig=
ht before timer init

Late-initialize the GPTIMER hwmod used for the clockevent source immediatel=
y
before it is used.  This avoids the need to late-initialize all of the hwmo=
ds
until the boot process is further along.  (In general, we want to defer
as much as possible until late in the boot process.)

This second version fixes a bug pointed out by Santosh Shilimkar
<santosh.shilimkar@ti.com>, that would cause the kernel to use an
incorrect timer hwmod name if the selected GPTIMER was not 1 or 12 -
thanks Santosh.  Also, Tarun Kanti DebBarma <tarun.kanti@ti.com>
pointed out that the original patch did not apply cleanly; this has
now been fixed.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/mach-omap2/timer-gp.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.=
c
index 7b7c268..d23767f 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -39,10 +39,11 @@
 #include <asm/mach/time.h>
 #include <plat/dmtimer.h>
 #include <asm/localtimer.h>
+#include <plat/common.h>
+#include <plat/omap_hwmod.h>
=20
 #include "timer-gp.h"
=20
-#include <plat/common.h>
=20
 /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
 #define MAX_GPTIMER_ID=09=0912
@@ -132,9 +133,13 @@ static void __init omap2_gp_clockevent_init(void)
 {
 =09u32 tick_rate;
 =09int src;
+=09char *clockevent_hwmod_name;
=20
 =09inited =3D 1;
=20
+=09sprintf(clockevent_hwmod_name, "timer%d", gptimer_id);
+=09omap_hwmod_late_init_one(clockevent_hwmod_name);
+
 =09gptimer =3D omap_dm_timer_request_specific(gptimer_id);
 =09BUG_ON(gptimer =3D=3D NULL);
 =09gptimer_wakeup =3D gptimer;
--=20
1.7.2.3

--155748971-1273003510-1298535218=:6198--
