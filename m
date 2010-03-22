From: Ari Kauppi <Ext-Ari.Kauppi@nokia.com>
Subject: [PATCH] OMAP3: PM: Modify suspend wakeup timer to use milliseconds instead of seconds
Date: Mon, 22 Mar 2010 10:10:54 +0200
Message-ID: <1269245454-24254-1-git-send-email-Ext-Ari.Kauppi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:29417 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165Ab0CVILf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Mar 2010 04:11:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, tero.kristo@nokia.com

Millisecond resolution is possible and there are use cases for it
(automatic testing).

Seconds-based interface is preserved for compatibility.

Signed-off-by: Ari Kauppi <Ext-Ari.Kauppi@nokia.com>
---
 arch/arm/mach-omap2/pm-debug.c |   11 +++++++++++
 arch/arm/mach-omap2/pm.h       |    2 +-
 arch/arm/mach-omap2/pm34xx.c   |   16 ++++++++--------
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 8aafd71..0cf2a03 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -37,6 +37,7 @@
 #include "prm-regbits-34xx.h"
 
 int omap2_pm_debug;
+static u32 wakeup_timer_seconds;
 
 #define DUMP_PRM_MOD_REG(mod, reg)    \
 	regs[reg_count].name = #mod "." #reg; \
@@ -552,6 +553,12 @@ static int option_set(void *data, u64 val)
 
 	if (option == &enable_off_mode)
 		omap3_pm_off_mode_enable(val);
+
+	if (option == &wakeup_timer_seconds)
+		wakeup_timer_milliseconds = val * 1000;
+	if (option == &wakeup_timer_milliseconds)
+		wakeup_timer_seconds = roundup((u32)val, 1000) / 1000;
+
 	return 0;
 }
 
@@ -605,6 +612,10 @@ static int __init pm_dbg_init(void)
 				   &sleep_while_idle, &pm_dbg_option_fops);
 	(void) debugfs_create_file("wakeup_timer_seconds", S_IRUGO | S_IWUGO, d,
 				   &wakeup_timer_seconds, &pm_dbg_option_fops);
+	(void) debugfs_create_file("wakeup_timer_milliseconds",
+				   S_IRUGO | S_IWUGO, d,
+				   &wakeup_timer_milliseconds,
+				   &pm_dbg_option_fops);
 
 	/* Only enable for >= ES2.1 . Going to 0V on anything under
 	 * ES2.1 will eventually cause a crash */
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index b761be5..423395a 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -68,7 +68,7 @@ static inline void omap3_pm_init_vc(struct prm_setup_vc *setup_vc)
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 
-extern u32 wakeup_timer_seconds;
+extern u32 wakeup_timer_milliseconds;
 extern struct omap_dm_timer *gptimer_wakeup;
 
 #ifdef CONFIG_PM_DEBUG
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 3868c76..cd55968 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -73,7 +73,7 @@ static inline bool is_suspending(void)
 
 u32 enable_off_mode;
 u32 sleep_while_idle;
-u32 wakeup_timer_seconds;
+u32 wakeup_timer_milliseconds;
 u32 voltage_off_while_idle;
 
 struct power_state {
@@ -640,20 +640,20 @@ out:
 }
 
 #ifdef CONFIG_SUSPEND
-static void omap2_pm_wakeup_on_timer(u32 seconds)
+static void omap2_pm_wakeup_on_timer(u32 milliseconds)
 {
 	u32 tick_rate, cycles;
 
-	if (!seconds)
+	if (!milliseconds)
 		return;
 
 	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer_wakeup));
-	cycles = tick_rate * seconds;
+	cycles = tick_rate * milliseconds / 1000;
 	omap_dm_timer_stop(gptimer_wakeup);
 	omap_dm_timer_set_load_start(gptimer_wakeup, 0, 0xffffffff - cycles);
 
-	pr_info("PM: Resume timer in %d secs (%d ticks at %d ticks/sec.)\n",
-		seconds, cycles, tick_rate);
+	pr_info("PM: Resume timer in %u ms (%u ticks at %u ticks/sec.)\n",
+		milliseconds, cycles, tick_rate);
 }
 
 static int omap3_pm_prepare(void)
@@ -667,8 +667,8 @@ static int omap3_pm_suspend(void)
 	struct power_state *pwrst;
 	int state, ret = 0;
 
-	if (wakeup_timer_seconds)
-		omap2_pm_wakeup_on_timer(wakeup_timer_seconds);
+	if (wakeup_timer_milliseconds)
+		omap2_pm_wakeup_on_timer(wakeup_timer_milliseconds);
 
 	/* Read current next_pwrsts */
 	list_for_each_entry(pwrst, &pwrst_list, node)
-- 
1.6.4.2

