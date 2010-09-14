From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/3] omap: pm-debug: Move common debug code to pm-debug.c
Date: Tue, 14 Sep 2010 19:25:46 +0530
Message-ID: <1284472548-32151-2-git-send-email-santosh.shilimkar@ti.com>
References: <1284472548-32151-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52039 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753643Ab0INNz5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Sep 2010 09:55:57 -0400
In-Reply-To: <1284472548-32151-1-git-send-email-santosh.shilimkar@ti.com>
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
 arch/arm/mach-omap2/pm-debug.c |   23 +++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h       |    6 ++++--
 arch/arm/mach-omap2/pm34xx.c   |   23 -----------------------
 3 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 723b44e..143266d 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -31,12 +31,18 @@
 #include <plat/board.h>
 #include <plat/powerdomain.h>
 #include <plat/clockdomain.h>
+#include <plat/dmtimer.h>
 
 #include "prm.h"
 #include "cm.h"
 #include "pm.h"
 
 int omap2_pm_debug;
+u32 enable_off_mode;
+u32 sleep_while_idle;
+u32 wakeup_timer_seconds;
+u32 wakeup_timer_milliseconds;
+
 
 #define DUMP_PRM_MOD_REG(mod, reg)    \
 	regs[reg_count].name = #mod "." #reg; \
@@ -349,6 +355,23 @@ void pm_dbg_update_time(struct powerdomain *pwrdm, int prev)
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
index 3de6ece..c74d35c 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -15,6 +15,8 @@
 
 extern u32 enable_off_mode;
 extern u32 sleep_while_idle;
+extern u32 wakeup_timer_seconds;
+extern u32 wakeup_timer_milliseconds;
 
 extern void *omap3_secure_ram_storage;
 extern void omap3_pm_off_mode_enable(int);
@@ -42,15 +44,15 @@ inline void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 
-extern u32 wakeup_timer_seconds;
-extern u32 wakeup_timer_milliseconds;
 extern struct omap_dm_timer *gptimer_wakeup;
 
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
index 7b03426..4fd48e0 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -38,7 +38,6 @@
 #include <plat/prcm.h>
 #include <plat/gpmc.h>
 #include <plat/dma.h>
-#include <plat/dmtimer.h>
 
 #include <asm/tlbflush.h>
 
@@ -55,11 +54,6 @@
 #define OMAP343X_TABLE_VALUE_OFFSET	   0x30
 #define OMAP343X_CONTROL_REG_VALUE_OFFSET  0x32
 
-u32 enable_off_mode;
-u32 sleep_while_idle;
-u32 wakeup_timer_seconds;
-u32 wakeup_timer_milliseconds;
-
 struct power_state {
 	struct powerdomain *pwrdm;
 	u32 next_state;
@@ -567,23 +561,6 @@ out:
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

