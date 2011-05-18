From: jean.pihet@newoldbits.com
Subject: [PATCH 11/13] OMAP2+: PM: implement modules insertion and removal code
Date: Wed, 18 May 2011 19:32:28 +0200
Message-ID: <1305739950-11695-12-git-send-email-j-pihet@ti.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63275 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933340Ab1ERRdA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 13:33:00 -0400
Received: by mail-yw0-f46.google.com with SMTP id 9so445875ywe.19
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 10:33:00 -0700 (PDT)
In-Reply-To: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

Clean-up of used resources to allow clean insertion and removal
of the PM modules.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   14 +++++++++++++-
 arch/arm/mach-omap2/pm-debug.c    |   22 +++++++++++++++++++++-
 arch/arm/mach-omap2/pm.h          |    1 +
 arch/arm/mach-omap2/pm24xx.c      |   24 ++++++++++++++++++++++++
 arch/arm/mach-omap2/pm34xx.c      |   37 ++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/pm44xx.c      |   21 +++++++++++++++++++++
 6 files changed, 116 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index df92f4a..233ff30 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -525,8 +525,11 @@ int __init omap3_idle_init(void)
 		count++;
 	}
 
-	if (!count)
+	if (!count) {
+		cpuidle_unregister_driver(&omap3_idle_driver);
 		return -EINVAL;
+	}
+
 	dev->state_count = count;
 
 	if (enable_off_mode)
@@ -542,6 +545,15 @@ int __init omap3_idle_init(void)
 
 	return 0;
 }
+
+void __exit omap3_idle_exit(void)
+{
+	struct cpuidle_device *dev;
+
+	dev = &per_cpu(omap3_idle_dev, smp_processor_id());
+	cpuidle_unregister_device(dev);
+	cpuidle_unregister_driver(&omap3_idle_driver);
+}
 #else
 int __init omap3_idle_init(void)
 {
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 24e5c31..4e81e8d 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -54,6 +54,8 @@
 	regs[reg_count++].val = \
 			 __raw_readl(OMAP2_L4_IO_ADDRESS(0x480fe000 + (off)))
 
+struct dentry *pm_debug_dentry;
+
 void omap2_pm_dump(int mode, int resume, unsigned int us)
 {
 	struct reg {
@@ -567,6 +569,7 @@ static int __init pm_dbg_init(void)
 	d = debugfs_create_dir("pm_debug", NULL);
 	if (IS_ERR(d))
 		return PTR_ERR(d);
+	pm_debug_dentry = d;
 
 	(void) debugfs_create_file("count", S_IRUGO,
 		d, (void *)DEBUG_FILE_COUNTERS, &debug_fops);
@@ -603,6 +606,23 @@ static int __init pm_dbg_init(void)
 
 	return 0;
 }
+
+static void __exit pm_dbg_exit(void)
+{
+	if (!cpu_is_omap34xx())
+		return;
+
+	debugfs_remove_recursive(pm_debug_dentry);
+	pm_debug_dentry = NULL;
+
+	pm_dbg_init_done = 0;
+}
+
 arch_initcall(pm_dbg_init);
+module_exit(pm_dbg_exit);
 
-#endif
+#endif /* CONFIG_DEBUG_FS */
+
+MODULE_AUTHOR("Texas Instruments, Inc.");
+MODULE_DESCRIPTION("OMAP2+ PM debug");
+MODULE_LICENSE("GPL");
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 194e883..fe5d0dc 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -22,6 +22,7 @@ extern void omap_sram_idle(void);
 extern int omap3_can_sleep(void);
 extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
+extern void omap3_idle_exit(void);
 
 #if defined(CONFIG_PM_OPP)
 extern int omap3_opp_init(void);
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 340da03..dd5a4989 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -53,6 +53,8 @@
 #include "powerdomain.h"
 #include "clockdomain.h"
 
+static void (*pm_idle_old)(void);
+
 #ifdef CONFIG_SUSPEND
 static suspend_state_t suspend_state = PM_SUSPEND_ON;
 static inline bool is_suspending(void)
@@ -515,9 +517,31 @@ static int __init omap2_pm_init(void)
 #ifdef CONFIG_SUSPEND
 	omap_pm_suspend_set_ops(&omap_pm_ops);
 #endif
+	pm_idle_old = pm_idle;
 	pm_idle = omap2_pm_idle;
 
 	return 0;
 }
 
+static void __exit omap2_pm_exit(void)
+{
+	if (!cpu_is_omap24xx())
+		return;
+
+	if (pm_idle_old)
+		pm_idle = pm_idle_old;
+
+	omap_pm_suspend_set_ops(NULL);
+
+	/* ToDo: reset PRCM registers to default values (non-PM) */
+
+	clk_put(emul_ck);
+	clk_put(osc_ck);
+}
+
 late_initcall(omap2_pm_init);
+module_exit(omap2_pm_exit);
+
+MODULE_AUTHOR("Texas Instruments, Inc.");
+MODULE_DESCRIPTION("OMAP2 PM");
+MODULE_LICENSE("GPL");
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 967b931..dd36e6d 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -51,6 +51,8 @@
 #include "sdrc.h"
 #include "control.h"
 
+static void (*pm_idle_old)(void);
+
 #ifdef CONFIG_SUSPEND
 static suspend_state_t suspend_state = PM_SUSPEND_ON;
 static inline bool is_suspending(void)
@@ -909,6 +911,31 @@ static inline u32 _get_secure_ram_restore_ptr(void)
 		return (u32) __pa(omap3_secure_ram_storage);
 }
 
+static void __exit omap3_pm_exit(void)
+{
+	struct power_state *pwrst, *tmp;
+
+	if (!cpu_is_omap34xx())
+		return;
+
+	omap3_idle_exit();
+	if (pm_idle_old)
+		pm_idle = pm_idle_old;
+
+	omap_pm_suspend_set_ops(NULL);
+
+	/* ToDo: configure clkdm back to default */
+
+	list_for_each_entry_safe(pwrst, tmp, &pwrst_list, node) {
+		list_del(&pwrst->node);
+		kfree(pwrst);
+	}
+
+	free_irq(INT_34XX_PRCM_MPU_IRQ, NULL);
+
+	/* ToDo: -reset PRCM registers to default values (non-PM) */
+}
+
 static int __init omap3_pm_init(void)
 {
 	struct power_state *pwrst, *tmp;
@@ -964,6 +991,7 @@ static int __init omap3_pm_init(void)
 	omap_pm_suspend_set_ops(&omap_pm_ops);
 #endif /* CONFIG_SUSPEND */
 
+	pm_idle_old = pm_idle;
 	pm_idle = omap3_pm_idle;
 	omap3_idle_init();
 
@@ -999,12 +1027,19 @@ static int __init omap3_pm_init(void)
 err1:
 	return ret;
 err2:
-	free_irq(INT_34XX_PRCM_MPU_IRQ, NULL);
 	list_for_each_entry_safe(pwrst, tmp, &pwrst_list, node) {
 		list_del(&pwrst->node);
 		kfree(pwrst);
 	}
+
+	free_irq(INT_34XX_PRCM_MPU_IRQ, NULL);
+
 	return ret;
 }
 
 late_initcall(omap3_pm_init);
+module_exit(omap3_pm_exit);
+
+MODULE_AUTHOR("Texas Instruments, Inc.");
+MODULE_DESCRIPTION("OMAP3 PM");
+MODULE_LICENSE("GPL");
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 3d6b991..aea5b8d 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -118,4 +118,25 @@ static int __init omap4_pm_init(void)
 err2:
 	return ret;
 }
+
+static void __exit omap4_pm_exit(void)
+{
+	struct power_state *pwrst;
+
+	if (!cpu_is_omap44xx())
+		return;
+
+	omap_pm_suspend_set_ops(NULL);
+
+	list_for_each_entry(pwrst, &pwrst_list, node) {
+		list_del(&pwrst->node);
+		kfree(pwrst);
+	}
+}
+
 late_initcall(omap4_pm_init);
+module_exit(omap4_pm_exit);
+
+MODULE_AUTHOR("Texas Instruments, Inc.");
+MODULE_DESCRIPTION("OMAP4 PM");
+MODULE_LICENSE("GPL");
-- 
1.7.4.1

