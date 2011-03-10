From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 14/19] OMAP4: pm-debug: Add wakeup timer and debug counters
Date: Thu, 10 Mar 2011 19:38:10 +0530
Message-ID: <1299766095-23879-15-git-send-email-santosh.shilimkar@ti.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50197 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487Ab1CJOIk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 09:08:40 -0500
In-Reply-To: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch adds configurable wakeup timer support in suspend. Also
for statistics pm counter support is added.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap4-mpuss-lowpower.c |    4 ++++
 arch/arm/mach-omap2/pm-debug.c             |   10 ++++++++--
 arch/arm/mach-omap2/pm44xx.c               |    5 +++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
index 7348d29..3cd9e8b 100644
--- a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
@@ -289,6 +289,8 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	if (cpu)
 		goto cpu_prepare;
 
+	pwrdm_pre_transition();
+
 	/*
 	 * Check MPUSS next state and save GIC if needed
 	 * GIC lost during MPU OFF and OSWR
@@ -334,6 +336,8 @@ cpu_prepare:
 		gic_dist_enable();
 	}
 
+	pwrdm_post_transition();
+
 ret:
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 34f0e5d..c83a0f6 100644
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
@@ -624,6 +626,9 @@ static int __init pm_dbg_init(void)
 
 	pwrdm_for_each(pwrdms_setup, (void *)d);
 
+	if (cpu_is_omap44xx())
+		goto skip_reg_debufs;
+
 	pm_dbg_dir = debugfs_create_dir("registers", d);
 	if (IS_ERR(pm_dbg_dir))
 		return PTR_ERR(pm_dbg_dir);
@@ -638,6 +643,7 @@ static int __init pm_dbg_init(void)
 				pm_dbg_dir, (void *)(i+1), &debug_reg_fops);
 
 		}
+skip_reg_debufs:
 
 	(void) debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUSR, d,
 				   &enable_off_mode, &pm_dbg_option_fops);
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 0d1f33a..14d4229 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -41,6 +41,11 @@ static int omap4_pm_suspend(void)
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

