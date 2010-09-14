From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/3 v2] omap: pm-debug: Move common debug code to pm-debug.c
Date: Wed, 15 Sep 2010 01:03:59 +0530
Message-ID: <1284492841-14858-2-git-send-email-santosh.shilimkar@ti.com>
References: <1284492841-14858-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33027 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832Ab0INTeL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 15:34:11 -0400
In-Reply-To: <1284492841-14858-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, rnayak@ti.com, b-cousson@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch moves omap2_pm_wakeup_on_timer() and pm debug entries
form pm34xx.c to pm-debug.c and export it, so that it is available
to other OMAPs

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm-debug.c |   18 ++++++++++++++++++
 arch/arm/mach-omap2/pm.h       |    2 ++
 arch/arm/mach-omap2/pm34xx.c   |   18 ------------------
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 056ff17..655f9df 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -31,6 +31,7 @@
 #include <plat/board.h>
 #include <plat/powerdomain.h>
 #include <plat/clockdomain.h>
+#include <plat/dmtimer.h>
 
 #include "prm.h"
 #include "cm.h"
@@ -353,6 +354,23 @@ void pm_dbg_update_time(struct powerdomain *pwrdm, int prev)
 	pwrdm->timer = t;
 }
 
+void omap2_pm_wakeup_on_timer(u32 seconds, u32 milliseconds)
+{
+	u32 tick_rate, cycles;
+
+	if (!seconds && !milliseconds)
+		return;
+
+	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer_wakeup));
+	cycles = tick_rate * seconds + tick_rate * milliseconds / 1000;
+	omap_dm_timer_stop(gptimer_wakeup);
+	omap_dm_timer_set_load_start(gptimer_wakeup, 0, 0xffffffff - cycles);
+
+	pr_info("PM: Resume timer in %u.%03u secs"
+		" (%d ticks at %d ticks/sec.)\n",
+		seconds, milliseconds, cycles, tick_rate);
+}
+
 static int clkdm_dbg_show_counter(struct clockdomain *clkdm, void *user)
 {
 	struct seq_file *s = (struct seq_file *)user;
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 3de6ece..4fd021f 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -48,9 +48,11 @@ extern struct omap_dm_timer *gptimer_wakeup;
 
 #ifdef CONFIG_PM_DEBUG
 extern void omap2_pm_dump(int mode, int resume, unsigned int us);
+extern void omap2_pm_wakeup_on_timer(u32 seconds, u32 milliseconds);
 extern int omap2_pm_debug;
 #else
 #define omap2_pm_dump(mode, resume, us)		do {} while (0);
+#define omap2_pm_wakeup_on_timer(seconds, milliseconds)	do {} while (0);
 #define omap2_pm_debug				0
 #endif
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index bb2ba1e..bc24fbd 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -38,7 +38,6 @@
 #include <plat/prcm.h>
 #include <plat/gpmc.h>
 #include <plat/dma.h>
-#include <plat/dmtimer.h>
 
 #include <asm/tlbflush.h>
 
@@ -550,23 +549,6 @@ out:
 #ifdef CONFIG_SUSPEND
 static suspend_state_t suspend_state;
 
-static void omap2_pm_wakeup_on_timer(u32 seconds, u32 milliseconds)
-{
-	u32 tick_rate, cycles;
-
-	if (!seconds && !milliseconds)
-		return;
-
-	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer_wakeup));
-	cycles = tick_rate * seconds + tick_rate * milliseconds / 1000;
-	omap_dm_timer_stop(gptimer_wakeup);
-	omap_dm_timer_set_load_start(gptimer_wakeup, 0, 0xffffffff - cycles);
-
-	pr_info("PM: Resume timer in %u.%03u secs"
-		" (%d ticks at %d ticks/sec.)\n",
-		seconds, milliseconds, cycles, tick_rate);
-}
-
 static int omap3_pm_prepare(void)
 {
 	disable_hlt();
-- 
1.6.0.4

