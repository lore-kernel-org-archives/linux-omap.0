From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 02/10][RFC] OMAP4: PM: Basic OMAP4 clock framework
Date: Fri, 29 May 2009 14:12:12 +0530
Message-ID: <1243586540-12274-2-git-send-email-rnayak@ti.com>
References: <1243586540-12274-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46790 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755711AbZE2ImZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 May 2009 04:42:25 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4T8gLYh005418
	for <linux-omap@vger.kernel.org>; Fri, 29 May 2009 03:42:27 -0500
In-Reply-To: <1243586540-12274-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

This patch registers the OMAP4430 clock
nodes with the CLKDEV frmaework.
Enables CLKDEV for OMAP4.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/Makefile    |    7 +-
 arch/arm/mach-omap2/clock.c     |    8 ++
 arch/arm/mach-omap2/clock44xx.c |  137 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/io.c        |    6 +-
 arch/arm/plat-omap/Kconfig      |    1 +
 arch/arm/plat-omap/clock.c      |   26 -------
 6 files changed, 152 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clock44xx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4bb24eb..86cfb44 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,11 +3,11 @@
 #
 
 # Common support
-obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o
+obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o clock.o prcm.o
 
 omap-2-3-common				= irq.o sdrc.o
-prcm-common				= prcm.o powerdomain.o
-clock-common				= clock.o clockdomain.o
+prcm-common				= powerdomain.o
+clock-common				= clockdomain.o
 
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(clock-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(prcm-common) $(clock-common)
@@ -35,6 +35,7 @@ endif
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= clock44xx.o
 
 # Specific board support
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index ba528f8..c75096e 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -150,6 +150,7 @@ static int _dpll_test_fint(struct clk *clk, u8 n)
  * clockdomain pointer, and save it into the struct clk.  Intended to be
  * called during clk_register().  No return value.
  */
+#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */
 void omap2_init_clk_clkdm(struct clk *clk)
 {
 	struct clockdomain *clkdm;
@@ -167,6 +168,7 @@ void omap2_init_clk_clkdm(struct clk *clk)
 			 "clkdm %s\n", clk->name, clk->clkdm_name);
 	}
 }
+#endif
 
 /**
  * omap2_init_clksel_parent - set a clksel clk's parent field from the hardware
@@ -435,8 +437,10 @@ void omap2_clk_disable(struct clk *clk)
 		_omap2_clk_disable(clk);
 		if (clk->parent)
 			omap2_clk_disable(clk->parent);
+#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */
 		if (clk->clkdm)
 			omap2_clkdm_clk_disable(clk->clkdm, clk);
+#endif
 
 	}
 }
@@ -446,8 +450,10 @@ int omap2_clk_enable(struct clk *clk)
 	int ret = 0;
 
 	if (clk->usecount++ == 0) {
+#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */
 		if (clk->clkdm)
 			omap2_clkdm_clk_enable(clk->clkdm, clk);
+#endif
 
 		if (clk->parent) {
 			ret = omap2_clk_enable(clk->parent);
@@ -466,8 +472,10 @@ int omap2_clk_enable(struct clk *clk)
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
index 0000000..f4e0113
--- /dev/null
+++ b/arch/arm/mach-omap2/clock44xx.c
@@ -0,0 +1,137 @@
+/*
+ * OMAP4-specific clock framework functions
+ *
+ * Copyright (C) 2009 Texas Instruments, Inc.
+ *
+ * Written by Rajendra Nayak (rnayak@ti.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#undef DEBUG
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/limits.h>
+#include <linux/bitops.h>
+
+#include <mach/clock.h>
+#include <mach/sram.h>
+#include <asm/div64.h>
+#include <asm/clkdev.h>
+
+#include <mach/sdrc.h>
+#include "clock.h"
+#include "prm.h"
+#include "prm-regbits-44xx.h"
+#include "cm.h"
+#include "cm1-regbits-44xx.h"
+#include "cm2-regbits-44xx.h"
+
+#include "clock44xx.h"
+
+struct omap_clk {
+	u32		cpu;
+	struct clk_lookup lk;
+};
+
+#define CLK(dev, con, ck, cp) 		\
+	{				\
+		 .cpu = cp,		\
+		.lk = {			\
+			.dev_id = dev,	\
+			.con_id = con,	\
+			.clk = ck,	\
+		},			\
+	}
+
+#define CK_443X		(1 << 0)
+
+static struct omap_clk omap44xx_clks[] = {
+	CLK(NULL,	"omap_32k_fck",	&omap_32k_fck,	CK_443X),
+	CLK(NULL,	"virt_12m_ck",	&virt_12m_ck,	CK_443X),
+	CLK(NULL,	"virt_13m_ck",	&virt_13m_ck,	CK_443X),
+	CLK(NULL,	"virt_19_2m_ck", &virt_19_2m_ck, CK_443X),
+	CLK(NULL,	"virt_26m_ck",	&virt_26m_ck,	CK_443X),
+	CLK(NULL,	"virt_27m_ck",	&virt_27m_ck,	CK_443X),
+	CLK(NULL,	"virt_38_4m_ck", &virt_38_4m_ck, CK_443X),
+	CLK(NULL,	"sys_ck",	&sys_ck,	CK_443X),
+	CLK(NULL,	"abe_dss_sys_ck", &abe_dss_sys_ck, CK_443X),
+	CLK(NULL,	"dpll_sys_ref_ck", &dpll_sys_ref_ck, CK_443X),
+	CLK(NULL,	"abe_dpll_alwon_ck", &abe_dpll_alwon_ck, CK_443X),
+	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_443X),
+	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_443X),
+	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_443X),
+	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_443X),
+	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_443X),
+	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_443X),
+	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_443X),
+};
+
+static struct clk_functions omap2_clk_functions = {
+	.clk_enable		= omap2_clk_enable,
+	.clk_disable		= omap2_clk_disable,
+	.clk_round_rate		= omap2_clk_round_rate,
+	.clk_set_rate		= omap2_clk_set_rate,
+	.clk_set_parent		= omap2_clk_set_parent,
+	.clk_disable_unused	= omap2_clk_disable_unused,
+};
+
+void omap2_clk_prepare_for_reboot(void)
+{
+	return;
+}
+
+static int __init omap2_clk_arch_init(void)
+{
+	if (!mpurate)
+		return -EINVAL;
+
+	recalculate_root_clocks();
+	return 0;
+}
+arch_initcall(omap2_clk_arch_init);
+
+int __init omap2_clk_init(void)
+{
+	/* struct prcm_config *prcm; */
+	struct omap_clk *c;
+	/* u32 clkrate; */
+	u32 cpu_clkflg;
+
+	if (cpu_is_omap44xx()) {
+		cpu_mask = RATE_IN_443X;
+		cpu_clkflg = CK_443X;
+	}
+
+	clk_init(&omap2_clk_functions);
+
+	for (c = omap44xx_clks; c < omap44xx_clks + ARRAY_SIZE(omap44xx_clks); c++)
+		clk_init_one(c->lk.clk);
+
+	for (c = omap44xx_clks; c < omap44xx_clks + ARRAY_SIZE(omap44xx_clks); c++)
+		if (c->cpu & cpu_clkflg) {
+			clkdev_add(&c->lk);
+			clk_register(c->lk.clk);
+			/* TODO
+			omap2_init_clk_clkdm(c->lk.clk);
+			*/
+		}
+
+	recalculate_root_clocks();
+
+	/*
+	 * Only enable those clocks we will need, let the drivers
+	 * enable other clocks as necessary
+	 */
+	clk_enable_init_clocks();
+
+	return 0;
+}
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 32afd94..0fabeac 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -32,7 +32,6 @@
 #include <mach/sdrc.h>
 #include <mach/gpmc.h>
 
-#ifndef CONFIG_ARCH_OMAP4	/* FIXME: Remove this once clkdev is ready */
 #include "clock.h"
 
 #include <mach/powerdomain.h>
@@ -41,7 +40,6 @@
 
 #include <mach/clockdomain.h>
 #include "clockdomains.h"
-#endif
 /*
  * The machine specific code may provide the extra mapping besides the
  * default mapping provided here.
@@ -244,11 +242,11 @@ void __init omap2_map_common_io(void)
 void __init omap2_init_common_hw(struct omap_sdrc_params *sp)
 {
 	omap2_mux_init();
-#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is ready */
+#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdm/pwrdm f/w is ready */
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
-	omap2_clk_init();
 	omap2_sdrc_init(sp);
 #endif
+	omap2_clk_init();
 	gpmc_init();
 }
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index f8a6124..32170ef 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -27,6 +27,7 @@ config ARCH_OMAP4
 	bool "TI OMAP4"
 	select CPU_V7
 	select ARM_GIC
+	select COMMON_CLKDEV
 
 endchoice
 
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index e8c327a..972694b 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -40,36 +40,10 @@ static struct clk_functions *arch_clock;
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
-
-void omap_prcm_arch_reset(char mode)
-{
-}
-EXPORT_SYMBOL(omap_prcm_arch_reset);
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

