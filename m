From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/2] ARM: OMAP2+: PM: share some suspend-related functions
 across OMAP2, 3, 4
Date: Thu, 02 Feb 2012 02:38:51 -0700
Message-ID: <20120202093850.12509.18054.stgit@dusk>
References: <20120202093600.12509.35052.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57788 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754796Ab2BBJj6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Feb 2012 04:39:58 -0500
In-Reply-To: <20120202093600.12509.35052.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

The platform_suspend_ops can be shared across OMAP2, 3, and 4, along
with all of the functions referenced in that structure.  This patch
shares them.  It also removes the suspend_state file-scoped variable
in the OMAP2 and 3 PM code; it does not appear to be actually needed
by anything.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm.c     |   64 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h     |    1 +
 arch/arm/mach-omap2/pm24xx.c |   56 +++----------------------------------
 arch/arm/mach-omap2/pm34xx.c |   56 ++++---------------------------------
 arch/arm/mach-omap2/pm44xx.c |   39 +-------------------------
 5 files changed, 77 insertions(+), 139 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 0118614..35f5ac6 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -15,11 +15,13 @@
 #include <linux/err.h>
 #include <linux/opp.h>
 #include <linux/export.h>
+#include <linux/suspend.h>
 
 #include <plat/omap-pm.h>
 #include <plat/omap_device.h>
 #include "common.h"
 
+#include "prcm-common.h"
 #include "voltage.h"
 #include "powerdomain.h"
 #include "clockdomain.h"
@@ -28,6 +30,12 @@
 
 static struct omap_device_pm_latency *pm_lats;
 
+/*
+ * omap_pm_suspend: points to a function that does the SoC-specific
+ * suspend work
+ */
+int (*omap_pm_suspend)(void);
+
 static int _init_omap_device(char *name)
 {
 	struct omap_hwmod *oh;
@@ -139,6 +147,8 @@ err:
 	return ret;
 }
 
+
+
 /*
  * This API is to be called during init to set the various voltage
  * domains to the voltage as per the opp table. Typically we boot up
@@ -206,6 +216,56 @@ exit:
 	return -EINVAL;
 }
 
+#ifdef CONFIG_SUSPEND
+static int omap_pm_enter(suspend_state_t suspend_state)
+{
+	int ret = 0;
+
+	if (!omap_pm_suspend)
+		return -ENOENT; /* XXX doublecheck */
+
+	switch (suspend_state) {
+	case PM_SUSPEND_STANDBY:
+	case PM_SUSPEND_MEM:
+		ret = omap_pm_suspend();
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int omap_pm_begin(suspend_state_t state)
+{
+	disable_hlt();
+	if (cpu_is_omap34xx())
+		omap_prcm_irq_prepare();
+	return 0;
+}
+
+static void omap_pm_end(void)
+{
+	enable_hlt();
+	return;
+}
+
+static void omap_pm_finish(void)
+{
+	if (cpu_is_omap34xx())
+		omap_prcm_irq_complete();
+}
+
+static const struct platform_suspend_ops omap_pm_ops = {
+	.begin		= omap_pm_begin,
+	.end		= omap_pm_end,
+	.enter		= omap_pm_enter,
+	.finish		= omap_pm_finish,
+	.valid		= suspend_valid_only_mem,
+};
+
+#endif /* CONFIG_SUSPEND */
+
 static void __init omap3_init_voltages(void)
 {
 	if (!cpu_is_omap34xx())
@@ -248,6 +308,10 @@ static int __init omap2_common_pm_late_init(void)
 	/* Smartreflex device init */
 	omap_devinit_smartreflex();
 
+#ifdef CONFIG_SUSPEND
+	suspend_set_ops(&omap_pm_ops);
+#endif
+
 	return 0;
 }
 late_initcall(omap2_common_pm_late_init);
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index eef67f6..a051431 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -23,6 +23,7 @@ extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
 extern int omap4_idle_init(void);
 extern int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused);
+extern int (*omap_pm_suspend)(void);
 
 #if defined(CONFIG_PM_OPP)
 extern int omap3_opp_init(void);
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index bfd7905..538cd15 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -53,19 +53,6 @@
 #include "powerdomain.h"
 #include "clockdomain.h"
 
-#ifdef CONFIG_SUSPEND
-static suspend_state_t suspend_state = PM_SUSPEND_ON;
-static inline bool is_suspending(void)
-{
-	return (suspend_state != PM_SUSPEND_ON);
-}
-#else
-static inline bool is_suspending(void)
-{
-	return false;
-}
-#endif
-
 static void (*omap2_sram_idle)(void);
 static void (*omap2_sram_suspend)(u32 dllctrl, void __iomem *sdrc_dlla_ctrl,
 				  void __iomem *sdrc_power);
@@ -253,13 +240,6 @@ out:
 }
 
 #ifdef CONFIG_SUSPEND
-static int omap2_pm_begin(suspend_state_t state)
-{
-	disable_hlt();
-	suspend_state = state;
-	return 0;
-}
-
 static int omap2_pm_suspend(void)
 {
 	u32 wken_wkup, mir1;
@@ -279,37 +259,6 @@ static int omap2_pm_suspend(void)
 
 	return 0;
 }
-
-static int omap2_pm_enter(suspend_state_t state)
-{
-	int ret = 0;
-
-	switch (state) {
-	case PM_SUSPEND_STANDBY:
-	case PM_SUSPEND_MEM:
-		ret = omap2_pm_suspend();
-		break;
-	default:
-		ret = -EINVAL;
-	}
-
-	return ret;
-}
-
-static void omap2_pm_end(void)
-{
-	suspend_state = PM_SUSPEND_ON;
-	enable_hlt();
-}
-
-static const struct platform_suspend_ops omap_pm_ops = {
-	.begin		= omap2_pm_begin,
-	.enter		= omap2_pm_enter,
-	.end		= omap2_pm_end,
-	.valid		= suspend_valid_only_mem,
-};
-#else
-static const struct platform_suspend_ops __initdata omap_pm_ops;
 #endif /* CONFIG_SUSPEND */
 
 static void __init prcm_setup_regs(void)
@@ -356,6 +305,10 @@ static void __init prcm_setup_regs(void)
 	clkdm_for_each(omap_pm_clkdms_setup, NULL);
 	clkdm_add_wkdep(mpu_clkdm, wkup_clkdm);
 
+#ifdef CONFIG_SUSPEND
+	omap_pm_suspend = omap2_pm_suspend;
+#endif
+
 	/* REVISIT: Configure number of 32 kHz clock cycles for sys_clk
 	 * stabilisation */
 	omap2_prm_write_mod_reg(15 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_GR_MOD,
@@ -456,7 +409,6 @@ static int __init omap2_pm_init(void)
 						    omap24xx_cpu_suspend_sz);
 	}
 
-	suspend_set_ops(&omap_pm_ops);
 	pm_idle = omap2_pm_idle;
 
 	return 0;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ae962b5..0e0a2af 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -50,10 +50,6 @@
 #include "sdrc.h"
 #include "control.h"
 
-#ifdef CONFIG_SUSPEND
-static suspend_state_t suspend_state = PM_SUSPEND_ON;
-#endif
-
 /* pm34xx errata defined in pm.h */
 u16 pm34xx_errata;
 
@@ -479,50 +475,6 @@ restore:
 	return ret;
 }
 
-static int omap3_pm_enter(suspend_state_t unused)
-{
-	int ret = 0;
-
-	switch (suspend_state) {
-	case PM_SUSPEND_STANDBY:
-	case PM_SUSPEND_MEM:
-		ret = omap3_pm_suspend();
-		break;
-	default:
-		ret = -EINVAL;
-	}
-
-	return ret;
-}
-
-/* Hooks to enable / disable UART interrupts during suspend */
-static int omap3_pm_begin(suspend_state_t state)
-{
-	disable_hlt();
-	suspend_state = state;
-	omap_prcm_irq_prepare();
-	return 0;
-}
-
-static void omap3_pm_end(void)
-{
-	suspend_state = PM_SUSPEND_ON;
-	enable_hlt();
-	return;
-}
-
-static void omap3_pm_finish(void)
-{
-	omap_prcm_irq_complete();
-}
-
-static const struct platform_suspend_ops omap_pm_ops = {
-	.begin		= omap3_pm_begin,
-	.end		= omap3_pm_end,
-	.enter		= omap3_pm_enter,
-	.finish		= omap3_pm_finish,
-	.valid		= suspend_valid_only_mem,
-};
 #endif /* CONFIG_SUSPEND */
 
 
@@ -813,6 +765,10 @@ static int __init omap3_pm_init(void)
 
 	(void) clkdm_for_each(omap_pm_clkdms_setup, NULL);
 
+#ifdef CONFIG_SUSPEND
+	omap_pm_suspend = omap3_pm_suspend;
+#endif
+
 	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
 	if (mpu_pwrdm == NULL) {
 		printk(KERN_ERR "Failed to get mpu_pwrdm\n");
@@ -830,8 +786,8 @@ static int __init omap3_pm_init(void)
 	core_clkdm = clkdm_lookup("core_clkdm");
 
 #ifdef CONFIG_SUSPEND
-	suspend_set_ops(&omap_pm_ops);
-#endif /* CONFIG_SUSPEND */
+	omap_pm_suspend = omap3_pm_suspend;
+#endif
 
 	pm_idle = omap3_pm_idle;
 	omap3_idle_init();
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index a6fb31b..82aa352 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -83,41 +83,6 @@ static int omap4_pm_suspend(void)
 
 	return 0;
 }
-
-static int omap4_pm_enter(suspend_state_t suspend_state)
-{
-	int ret = 0;
-
-	switch (suspend_state) {
-	case PM_SUSPEND_STANDBY:
-	case PM_SUSPEND_MEM:
-		ret = omap4_pm_suspend();
-		break;
-	default:
-		ret = -EINVAL;
-	}
-
-	return ret;
-}
-
-static int omap4_pm_begin(suspend_state_t state)
-{
-	disable_hlt();
-	return 0;
-}
-
-static void omap4_pm_end(void)
-{
-	enable_hlt();
-	return;
-}
-
-static const struct platform_suspend_ops omap_pm_ops = {
-	.begin		= omap4_pm_begin,
-	.end		= omap4_pm_end,
-	.enter		= omap4_pm_enter,
-	.valid		= suspend_valid_only_mem,
-};
 #endif /* CONFIG_SUSPEND */
 
 static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
@@ -236,8 +201,8 @@ static int __init omap4_pm_init(void)
 	(void) clkdm_for_each(omap_pm_clkdms_setup, NULL);
 
 #ifdef CONFIG_SUSPEND
-	suspend_set_ops(&omap_pm_ops);
-#endif /* CONFIG_SUSPEND */
+	omap_pm_suspend = omap4_pm_suspend;
+#endif
 
 	/* Overwrite the default arch_idle() */
 	pm_idle = omap_default_idle;


