From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clockevent hwmod
	right before timer init
Date: Wed, 23 Feb 2011 00:11:54 -0700
Message-ID: <20110223071153.5874.58923.stgit@twilight.localdomain>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58780 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab1BWHNJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 02:13:09 -0500
In-Reply-To: <20110223070455.5874.51326.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Late-initialize the GPTIMER hwmod used for the clockevent source immedi=
ately
before it is used.  This avoids the need to late-initialize all of the =
hwmods
until the boot process is further along.  (In general, we want to defer
as much as possible until late in the boot process.)

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/timer-gp.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer=
-gp.c
index 0fc550e..a4e51a2 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -40,10 +40,11 @@
 #include <plat/dmtimer.h>
 #include <asm/localtimer.h>
 #include <asm/sched_clock.h>
+#include <plat/common.h>
=20
 #include "timer-gp.h"
+#include <plat/omap_hwmod.h>
=20
-#include <plat/common.h>
=20
 /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
 #define MAX_GPTIMER_ID		12
@@ -133,9 +134,13 @@ static void __init omap2_gp_clockevent_init(void)
 {
 	u32 tick_rate;
 	int src;
+	const char *clockevent_hwmod_name;
=20
 	inited =3D 1;
=20
+	clockevent_hwmod_name =3D (gptimer_id =3D=3D 12) ? "timer12" : "timer=
1";
+	omap_hwmod_late_init_one(clockevent_hwmod_name);
+
 	gptimer =3D omap_dm_timer_request_specific(gptimer_id);
 	BUG_ON(gptimer =3D=3D NULL);
 	gptimer_wakeup =3D gptimer;
@@ -250,6 +255,7 @@ static void __init omap2_gp_timer_init(void)
 		BUG_ON(!twd_base);
 	}
 #endif
+
 	omap_dm_timer_init();
=20
 	omap2_gp_clockevent_init();


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
