From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 12/17] omap4: pm-debug: Add wakeup timer and debug counters
Date: Sat, 19 Feb 2011 16:12:33 +0530
Message-ID: <1298112158-28469-13-git-send-email-santosh.shilimkar@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47843 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754117Ab1BSKnE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Feb 2011 05:43:04 -0500
In-Reply-To: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch adds configurable wakeup timer support in suspend. Also
for statistics pm counter support is added.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap4-mpuss-lowpower.c |    8 ++++++++
 arch/arm/mach-omap2/pm-debug.c             |    6 ++++--
 arch/arm/mach-omap2/pm44xx.c               |    5 +++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
index ab2e101..5e0141e 100644
--- a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
@@ -287,6 +287,10 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	if (cpu)
 		goto cpu_prepare;
 
+#ifdef CONFIG_PM_DEBUG
+	pwrdm_pre_transition();
+#endif
+
 	/*
 	 * Check MPUSS next state and save GIC if needed
 	 * GIC lost during MPU OFF and OSWR
@@ -332,6 +336,10 @@ cpu_prepare:
 		gic_dist_set(CPU0_ID, 1);
 	}
 
+#ifdef CONFIG_PM_DEBUG
+	pwrdm_post_transition();
+#endif
+
 ret:
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 9b46b3e..7d6dd5b 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -606,9 +606,11 @@ static int __init pm_dbg_init(void)
 	if (pm_dbg_init_done)
 		return 0;
 
-	if (cpu_is_omap34xx())
+	if (cpu_is_omap34xx()) {
 		pm_dbg_reg_modules = omap3_pm_reg_modules;
-	else {
+	} else if (cpu_is_omap44xx()) {
+		/* Allow pm_dbg_init on OMAP4. */
+	} else {
 		printk(KERN_ERR "%s: only OMAP3 supported\n", __func__);
 		return -ENODEV;
 	}
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index f527e33..8e57b42 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -42,6 +42,11 @@ static int omap4_pm_suspend(void)
 	int state, ret = 0;
 	u32 cpu_id = smp_processor_id();
 
+	/* Wakeup timer from suspend */
+	if (wakeup_timer_seconds || wakeup_timer_milliseconds)
+		omap2_pm_wakeup_on_timer(wakeup_timer_seconds,
+					 wakeup_timer_milliseconds);
+
 	/* Save current powerdomain state */
 	list_for_each_entry(pwrst, &pwrst_list, node) {
 		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst->pwrdm);
-- 
1.6.0.4

