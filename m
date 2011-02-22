From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] omap: Move omap_hwmod_late_init() to mdesc->timer->init() code
Date: Tue, 22 Feb 2011 20:07:29 +0530
Message-ID: <1298385449-27356-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32905 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404Ab1BVOhl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 09:37:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>

To adhere to recent early_init changes, commit '44dc0' made
omap_hwmod_late_init() to core_initcall to avoid ioremap() failures.

Later 'e7c7d7' removed _mpu_rt_va population omap_hwmod_late_init()

So now if we move the  omap_hwmod_late_init() to mdesc->timer->init(),
timer1 should work with hwmod instead of any special hwmod settings.

This was proposed by Paul Walmsley <paul@pwsan.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
Same patch I posted as part of the "Linux-next as of
20110222 broken on OMAP4" thread.
 
 arch/arm/mach-omap2/omap_hwmod.c             |    3 +--
 arch/arm/mach-omap2/timer-gp.c               |    4 +++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 9e89a58..b39cb40 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1646,7 +1646,7 @@ static int __init _populate_mpu_rt_base(struct omap_hwmod *oh, void *data)
  * to struct clk pointers for each registered omap_hwmod.  Also calls
  * _setup() on each hwmod.  Returns 0.
  */
-static int __init omap_hwmod_late_init(void)
+int __init omap_hwmod_late_init(void)
 {
 	int r;
 
@@ -1664,7 +1664,6 @@ static int __init omap_hwmod_late_init(void)
 
 	return 0;
 }
-core_initcall(omap_hwmod_late_init);
 
 /**
  * omap_hwmod_enable - enable an omap_hwmod
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 7b7c268..319ca42 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -37,8 +37,9 @@
 #include <linux/clockchips.h>
 
 #include <asm/mach/time.h>
-#include <plat/dmtimer.h>
 #include <asm/localtimer.h>
+#include <plat/dmtimer.h>
+#include <plat/omap_hwmod.h>
 
 #include "timer-gp.h"
 
@@ -231,6 +232,7 @@ static void __init omap2_gp_clocksource_init(void)
 
 static void __init omap2_gp_timer_init(void)
 {
+	omap_hwmod_late_init();
 #ifdef CONFIG_LOCAL_TIMERS
 	if (cpu_is_omap44xx()) {
 		twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index fedd829..e2bdbb3 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -536,6 +536,7 @@ struct omap_hwmod {
 };
 
 int omap_hwmod_init(struct omap_hwmod **ohs);
+int omap_hwmod_late_init(void);
 struct omap_hwmod *omap_hwmod_lookup(const char *name);
 int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 			void *data);
-- 
1.6.0.4

