From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 16/17] ARM: OMAP2: Add 34xx clock code
Date: Fri, 28 Mar 2008 14:39:10 +0200
Message-ID: <20080328123910.GK24896@atomide.com>
References: <1205848935-12078-8-git-send-email-tony@atomide.com> <1205848935-12078-9-git-send-email-tony@atomide.com> <1205848935-12078-10-git-send-email-tony@atomide.com> <1205848935-12078-11-git-send-email-tony@atomide.com> <1205848935-12078-12-git-send-email-tony@atomide.com> <1205848935-12078-13-git-send-email-tony@atomide.com> <1205848935-12078-14-git-send-email-tony@atomide.com> <1205848935-12078-15-git-send-email-tony@atomide.com> <1205848935-12078-16-git-send-email-tony@atomide.com> <1205848935-12078-17-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FUaywKC54iCcLzqT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58527 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746AbYC1MjN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 08:39:13 -0400
Content-Disposition: inline
In-Reply-To: <1205848935-12078-17-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>


--FUaywKC54iCcLzqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [080318 17:05]:
> From: Paul Walmsley <paul@pwsan.com>
> 
> This patch add 34xx clock code.

Here's an updated version of this patch. I've folded in two more patches
from Paul [1][2]. Patches change to use __ffs() instead of
mask_to_shift,
and clean up clock register defines.

Regards,

Tony

[1] http://master.kernel.org/git/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commitdiff;h=f417e171cd2d2bd0302c8f420ee97295a165a39c
[2] http://master.kernel.org/git/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commitdiff;h=70d19cc5c7999445b84e6ffea8e025512b877e8c

--FUaywKC54iCcLzqT
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0016-ARM-OMAP2-Add-34xx-clock-code.patch"

>From e37c21222372325d7c0409d875999a567d852ea3 Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Tue, 18 Mar 2008 15:09:51 +0200
Subject: [PATCH] ARM: OMAP2: Add 34xx clock code

This patch add 34xx clock code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile    |    1 +
 arch/arm/mach-omap2/clock34xx.c |  235 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 236 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clock34xx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 2eabadc..2feb687 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_PM) += pm.o sleep.o
 
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
 
 # Specific board support
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
new file mode 100644
index 0000000..1e206d8
--- /dev/null
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -0,0 +1,235 @@
+/*
+ * OMAP3-specific clock framework functions
+ *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ * Copyright (C) 2007 Nokia Corporation
+ *
+ * Written by Paul Walmsley
+ *
+ * Parts of this code are based on code written by
+ * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu
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
+
+#include <asm/arch/clock.h>
+#include <asm/arch/sram.h>
+#include <asm/div64.h>
+#include <asm/bitops.h>
+
+#include "memory.h"
+#include "clock.h"
+#include "clock34xx.h"
+#include "prm.h"
+#include "prm-regbits-34xx.h"
+#include "cm.h"
+#include "cm-regbits-34xx.h"
+
+/* CM_CLKEN_PLL*.EN* bit values */
+#define DPLL_LOCKED		0x7
+
+/**
+ * omap3_dpll_recalc - recalculate DPLL rate
+ * @clk: DPLL struct clk
+ *
+ * Recalculate and propagate the DPLL rate.
+ */
+static void omap3_dpll_recalc(struct clk *clk)
+{
+	clk->rate = omap2_get_dpll_rate(clk);
+
+	propagate_rate(clk);
+}
+
+/**
+ * omap3_clkoutx2_recalc - recalculate DPLL X2 output virtual clock rate
+ * @clk: DPLL output struct clk
+ *
+ * Using parent clock DPLL data, look up DPLL state.  If locked, set our
+ * rate to the dpll_clk * 2; otherwise, just use dpll_clk.
+ */
+static void omap3_clkoutx2_recalc(struct clk *clk)
+{
+	const struct dpll_data *dd;
+	u32 v;
+	struct clk *pclk;
+
+	/* Walk up the parents of clk, looking for a DPLL */
+	pclk = clk->parent;
+	while (pclk && !pclk->dpll_data)
+		pclk = pclk->parent;
+
+	/* clk does not have a DPLL as a parent? */
+	WARN_ON(!pclk);
+
+	dd = pclk->dpll_data;
+
+	WARN_ON(!dd->control_reg || !dd->enable_mask);
+
+	v = cm_read_reg(dd->control_reg) & dd->enable_mask;
+	v >>= __ffs(dd->enable_mask);
+	if (v != DPLL_LOCKED)
+		clk->rate = clk->parent->rate;
+	else
+		clk->rate = clk->parent->rate * 2;
+
+	if (clk->flags & RATE_PROPAGATES)
+		propagate_rate(clk);
+}
+
+/*
+ * As it is structured now, this will prevent an OMAP2/3 multiboot
+ * kernel from compiling.  This will need further attention.
+ */
+#if defined(CONFIG_ARCH_OMAP3)
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
+/*
+ * Set clocks for bypass mode for reboot to work.
+ */
+void omap2_clk_prepare_for_reboot(void)
+{
+	/* REVISIT: Not ready for 343x */
+#if 0
+	u32 rate;
+
+	if (vclk == NULL || sclk == NULL)
+		return;
+
+	rate = clk_get_rate(sclk);
+	clk_set_rate(vclk, rate);
+#endif
+}
+
+/* REVISIT: Move this init stuff out into clock.c */
+
+/*
+ * Switch the MPU rate if specified on cmdline.
+ * We cannot do this early until cmdline is parsed.
+ */
+static int __init omap2_clk_arch_init(void)
+{
+	if (!mpurate)
+		return -EINVAL;
+
+	/* REVISIT: not yet ready for 343x */
+#if 0
+	if (omap2_select_table_rate(&virt_prcm_set, mpurate))
+		printk(KERN_ERR "Could not find matching MPU rate\n");
+#endif
+
+	recalculate_root_clocks();
+
+	printk(KERN_INFO "Switched to new clocking rate (Crystal/DPLL3/MPU): "
+	       "%ld.%01ld/%ld/%ld MHz\n",
+	       (osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 100000) % 10,
+	       (core_ck.rate / 1000000), (dpll1_fck.rate / 1000000)) ;
+
+	return 0;
+}
+arch_initcall(omap2_clk_arch_init);
+
+int __init omap2_clk_init(void)
+{
+	/* struct prcm_config *prcm; */
+	struct clk **clkp;
+	/* u32 clkrate; */
+	u32 cpu_clkflg;
+
+	/* REVISIT: Ultimately this will be used for multiboot */
+#if 0
+	if (cpu_is_omap242x()) {
+		cpu_mask = RATE_IN_242X;
+		cpu_clkflg = CLOCK_IN_OMAP242X;
+		clkp = onchip_24xx_clks;
+	} else if (cpu_is_omap2430()) {
+		cpu_mask = RATE_IN_243X;
+		cpu_clkflg = CLOCK_IN_OMAP243X;
+		clkp = onchip_24xx_clks;
+	}
+#endif
+	if (cpu_is_omap34xx()) {
+		cpu_mask = RATE_IN_343X;
+		cpu_clkflg = CLOCK_IN_OMAP343X;
+		clkp = onchip_34xx_clks;
+
+		/*
+		 * Update this if there are further clock changes between ES2
+		 * and production parts
+		 */
+		if (is_sil_rev_equal_to(OMAP3430_REV_ES1_0)) {
+			/* No 3430ES1-only rates exist, so no RATE_IN_3430ES1 */
+			cpu_clkflg |= CLOCK_IN_OMAP3430ES1;
+		} else {
+			cpu_mask |= RATE_IN_3430ES2;
+			cpu_clkflg |= CLOCK_IN_OMAP3430ES2;
+		}
+	}
+
+	clk_init(&omap2_clk_functions);
+
+	for (clkp = onchip_34xx_clks;
+	     clkp < onchip_34xx_clks + ARRAY_SIZE(onchip_34xx_clks);
+	     clkp++) {
+		if ((*clkp)->flags & cpu_clkflg)
+			clk_register(*clkp);
+	}
+
+	/* REVISIT: Not yet ready for OMAP3 */
+#if 0
+	/* Check the MPU rate set by bootloader */
+	clkrate = omap2_get_dpll_rate_24xx(&dpll_ck);
+	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
+		if (!(prcm->flags & cpu_mask))
+			continue;
+		if (prcm->xtal_speed != sys_ck.rate)
+			continue;
+		if (prcm->dpll_speed <= clkrate)
+			 break;
+	}
+	curr_prcm_set = prcm;
+#endif
+
+	recalculate_root_clocks();
+
+	printk(KERN_INFO "Clocking rate (Crystal/DPLL/MPU): "
+	       "%ld.%01ld/%ld/%ld MHz\n",
+	       (osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 100000) % 10,
+	       (core_ck.rate / 1000000), (dpll1_fck.rate / 1000000)) ;
+
+	/*
+	 * Only enable those clocks we will need, let the drivers
+	 * enable other clocks as necessary
+	 */
+	clk_enable_init_clocks();
+
+	/* Avoid sleeping during omap2_clk_prepare_for_reboot() */
+	/* REVISIT: not yet ready for 343x */
+#if 0
+	vclk = clk_get(NULL, "virt_prcm_set");
+	sclk = clk_get(NULL, "sys_ck");
+#endif
+	return 0;
+}
+
+#endif
-- 
1.5.3.6


--FUaywKC54iCcLzqT--
