From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP: PM debug: fix wake-on-timer debugfs dependency
Date: Wed,  1 Dec 2010 11:55:46 +0100
Message-ID: <1291200946-29342-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37467 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000Ab0LAKzw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Dec 2010 05:55:52 -0500
Received: by qwb7 with SMTP id 7so6924013qwb.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Dec 2010 02:55:51 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Wakeup-on-timer code does not have/need debugfs dependency.  Move
the function out of debugfs ifdef.

Fixes compile error when CONFIG_DEBUG_FS is disabled but PM debug is
enabled.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Applies to Tony's omap-fixes branch, targeted for .37-rc.

Apologies for duplicates, original had wrong address for linux-omap ML

 arch/arm/mach-omap2/pm-debug.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 5e81517..a8afb61 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -161,6 +161,23 @@ void omap2_pm_dump(int mode, int resume, unsigned int us)
 		printk(KERN_INFO "%-20s: 0x%08x\n", regs[i].name, regs[i].val);
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
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
@@ -354,23 +371,6 @@ void pm_dbg_update_time(struct powerdomain *pwrdm, int prev)
 	pwrdm->timer = t;
 }
 
-void omap2_pm_wakeup_on_timer(u32 seconds, u32 milliseconds)
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
 static int clkdm_dbg_show_counter(struct clockdomain *clkdm, void *user)
 {
 	struct seq_file *s = (struct seq_file *)user;
-- 
1.7.2.1

