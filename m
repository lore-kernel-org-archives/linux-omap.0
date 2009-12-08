From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 2/5] ARM: OMAP4: PM: Add dummy hooks for OMAP4 dpll api's
Date: Wed,  9 Dec 2009 00:01:44 +0530
Message-ID: <1260297107-28833-2-git-send-email-rnayak@ti.com>
References: <1260297107-28833-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36727 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752228AbZLHSb4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Dec 2009 13:31:56 -0500
In-Reply-To: <1260297107-28833-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

This patch adds dummy hooks for OMAP4 dpll api's. Removes
dummy hooks for clkdev api's and enables CLKDEV
for OMAP4.
Also comments clockdomain calls from within the clock
framework as its not supported yet for OMAP4.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/Makefile    |    3 +-
 arch/arm/mach-omap2/clock.c     |    8 +++++
 arch/arm/mach-omap2/clock44xx.c |   58 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cm.h        |    4 +++
 arch/arm/mach-omap2/gpmc.c      |    2 +-
 arch/arm/mach-omap2/io.c        |    4 +--
 arch/arm/plat-omap/Kconfig      |    1 +
 arch/arm/plat-omap/clock.c      |   21 --------------
 8 files changed, 75 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clock44xx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 284277e..e3743cf 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -11,7 +11,7 @@ clock-common				= clock.o clock_common_data.o clockdomain.o
 
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(clock-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(prcm-common) $(clock-common)
-obj-$(CONFIG_ARCH_OMAP4) += prcm.o
+obj-$(CONFIG_ARCH_OMAP4) += prcm.o clock.o
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
@@ -49,6 +49,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= clock2xxx.o clock2xxx_data.o
 obj-$(CONFIG_ARCH_OMAP2420)		+= opp2420_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o clock34xx_data.o
 obj-$(CONFIG_ARCH_OMAP2430)		+= opp2430_data.o
+obj-$(CONFIG_ARCH_OMAP4)		+= clock44xx.o clock44xx_data.o
 
 obj-$(CONFIG_OMAP_MBOX_FWK)		+= mailbox_mach.o
 mailbox_mach-objs			:= mailbox.o
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 4716206..5cb2dcb 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -149,6 +149,7 @@ static int _dpll_test_fint(struct clk *clk, u8 n)
  * clockdomain pointer, and save it into the struct clk.  Intended to be
  * called during clk_register().  No return value.
  */
+#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */
 void omap2_init_clk_clkdm(struct clk *clk)
 {
 	struct clockdomain *clkdm;
@@ -166,6 +167,7 @@ void omap2_init_clk_clkdm(struct clk *clk)
 			 "clkdm %s\n", clk->name, clk->clkdm_name);
 	}
 }
+#endif
 
 /**
  * omap2_init_clksel_parent - set a clksel clk's parent field from the hardware
@@ -437,8 +439,10 @@ void omap2_clk_disable(struct clk *clk)
 		_omap2_clk_disable(clk);
 		if (clk->parent)
 			omap2_clk_disable(clk->parent);
+#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */
 		if (clk->clkdm)
 			omap2_clkdm_clk_disable(clk->clkdm, clk);
+#endif
 
 	}
 }
@@ -448,8 +452,10 @@ int omap2_clk_enable(struct clk *clk)
 	int ret = 0;
 
 	if (clk->usecount++ == 0) {
+#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */
 		if (clk->clkdm)
 			omap2_clkdm_clk_enable(clk->clkdm, clk);
+#endif
 
 		if (clk->parent) {
 			ret = omap2_clk_enable(clk->parent);
@@ -468,8 +474,10 @@ int omap2_clk_enable(struct clk *clk)
 	return ret;
 
 err:
+#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */
 	if (clk->clkdm)
 		omap2_clkdm_clk_disable(clk->clkdm, clk);
+#endif
 	clk->usecount--;
 	return ret;
 }
diff --git a/arch/arm/mach-omap2/clock44xx.c b/arch/arm/mach-omap2/clock44xx.c
new file mode 100644
index 0000000..5b25d38
--- /dev/null
+++ b/arch/arm/mach-omap2/clock44xx.c
@@ -0,0 +1,58 @@
+/*
+ * OMAP4-specific clock framework functions
+ *
+ * Copyright (C) 2009 Texas Instruments, Inc.
+ *
+ * Rajendra Nayak (rnayak@ti.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/errno.h>
+#include "clock.h"
+
+struct clk_functions omap2_clk_functions = {
+	.clk_enable		= omap2_clk_enable,
+	.clk_disable		= omap2_clk_disable,
+	.clk_round_rate		= omap2_clk_round_rate,
+	.clk_set_rate		= omap2_clk_set_rate,
+	.clk_set_parent		= omap2_clk_set_parent,
+	.clk_disable_unused	= omap2_clk_disable_unused,
+};
+
+/*
+ * Dummy functions for DPLL control. Plan is to re-use
+ * existing OMAP3 dpll control functions.
+ */
+
+unsigned long omap3_dpll_recalc(struct clk *clk)
+{
+	return 0;
+}
+
+int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
+{
+	return 0;
+}
+
+int omap3_noncore_dpll_enable(struct clk *clk)
+{
+	return 0;
+}
+
+void omap3_noncore_dpll_disable(struct clk *clk)
+{
+	return;
+}
+
+const struct clkops clkops_noncore_dpll_ops = {
+	.enable		= &omap3_noncore_dpll_enable,
+	.disable	= &omap3_noncore_dpll_disable,
+};
+
+void omap2_clk_prepare_for_reboot(void)
+{
+	return;
+}
diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index e8814a6..90a4086 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -97,6 +97,10 @@
 
 /* CM2.CEFUSE_CM2 register offsets */
 
+/* OMAP4 modulemode control */
+#define OMAP4430_MODULEMODE_HWCTRL			0
+#define OMAP4430_MODULEMODE_SWCTRL			1
+
 /* Clock management domain register get/set */
 
 #ifndef __ASSEMBLER__
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index e86f5ca..bd8cb59 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -517,7 +517,7 @@ void __init gpmc_init(void)
 		ck = "gpmc_fck";
 		l = OMAP34XX_GPMC_BASE;
 	} else if (cpu_is_omap44xx()) {
-		ck = "gpmc_fck";
+		ck = "gpmc_ck";
 		l = OMAP44XX_GPMC_BASE;
 	}
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 7d344d0..b8c2499 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -35,7 +35,6 @@
 #include <plat/serial.h>
 #include <plat/mux.h>
 
-#ifndef CONFIG_ARCH_OMAP4	/* FIXME: Remove this once clkdev is ready */
 #include "clock.h"
 
 #include <plat/omap-pm.h>
@@ -44,7 +43,6 @@
 
 #include <plat/clockdomain.h>
 #include "clockdomains.h"
-#endif
 #include <plat/omap_hwmod.h>
 #include "omap_hwmod_2420.h"
 #include "omap_hwmod_2430.h"
@@ -320,8 +318,8 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
-	omap2_clk_init();
 #endif
+	omap2_clk_init();
 	omap_serial_early_init();
 #ifndef CONFIG_ARCH_OMAP4
 	omap_hwmod_late_init();
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index f348ddf..3669d92 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -27,6 +27,7 @@ config ARCH_OMAP4
 	bool "TI OMAP4"
 	select CPU_V7
 	select ARM_GIC
+	select COMMON_CLKDEV
 
 endchoice
 
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index b857d11..89cafc9 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -40,31 +40,10 @@ static struct clk_functions *arch_clock;
  * clock framework is not up , it is defined here to avoid rework in
  * every driver. Also dummy prcm reset function is added */
 
-/* Dummy hooks only for OMAP4.For rest OMAPs, common clkdev is used */
-#if defined(CONFIG_ARCH_OMAP4)
-struct clk *clk_get(struct device *dev, const char *id)
-{
-	return NULL;
-}
-EXPORT_SYMBOL(clk_get);
-
-void clk_put(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_put);
-
-void omap2_clk_prepare_for_reboot(void)
-{
-}
-EXPORT_SYMBOL(omap2_clk_prepare_for_reboot);
-#endif
 int clk_enable(struct clk *clk)
 {
 	unsigned long flags;
 	int ret = 0;
-	if (cpu_is_omap44xx())
-		/* OMAP4 clk framework not supported yet */
-		return 0;
 
 	if (clk == NULL || IS_ERR(clk))
 		return -EINVAL;
-- 
1.5.4.7

