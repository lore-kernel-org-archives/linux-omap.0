From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 07/18] OMAP2xxx clock: move the DVFS virtual clock code
	into mach-omap2/clkt2xxx_virt_prcm_set.c
Date: Tue, 19 Jan 2010 16:36:10 -0700
Message-ID: <20100119233606.26047.7049.stgit@localhost.localdomain>
References: <20100119232900.26047.98263.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58615 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755103Ab0ASXie (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 18:38:34 -0500
In-Reply-To: <20100119232900.26047.98263.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Alexander Shishkin <virtuoso@slind.org>, Richard Woodruff <r-woodruff2@ti.com>

Move the DVFS virtual clock functions from clock2xxx.c to
mach-omap2/clkt2xxx_virt_prcm_set.c.  This is intended to make the
clock code easier to understand, since all of the functions needed to
manage the virt_prcm_set clock are now located in their own file,
rather than being mixed with other, unrelated functions.

Clock debugging is also now more finely-grained, since the DEBUG macro
can now be defined for the virt_prcm_set clock alone.  This should
reduce unnecessary console noise when debugging.

Also, if at some future point the mach-omap2/ directory is split into
OMAP2/3/4 variants, this clkt file can be placed in the mach-omap2xxx/
directory, rather than shared with other chip types that don't use
this clock type.

Thanks to Alexander Shishkin <virtuoso@slind.org> for his comments.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Alexander Shishkin <virtuoso@slind.org>
---
 arch/arm/mach-omap2/Makefile                 |    3 
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |  254 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock2xxx.c              |  211 ----------------------
 3 files changed, 256 insertions(+), 212 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 04ce372..2b58363 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -11,7 +11,8 @@ prcm-common				= prcm.o powerdomain.o
 clock-common				= clock.o clock_common_data.o \
 					  clockdomain.o clkt_dpll.o \
 					  clkt_clksel.o
-clock-omap2xxx				= clkt2xxx_dpllcore.o
+clock-omap2xxx				= clkt2xxx_dpllcore.o \
+					  clkt2xxx_virt_prcm_set.o
 
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(clock-common) \
 			    $(clock-omap2xxx)
diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
new file mode 100644
index 0000000..7174d09
--- /dev/null
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -0,0 +1,254 @@
+/*
+ * OMAP2xxx DVFS virtual clock functions
+ *
+ * Copyright (C) 2005-2008 Texas Instruments, Inc.
+ * Copyright (C) 2004-2010 Nokia Corporation
+ *
+ * Contacts:
+ * Richard Woodruff <r-woodruff2@ti.com>
+ * Paul Walmsley
+ *
+ * Based on earlier work by Tuukka Tikkanen, Tony Lindgren,
+ * Gordon McNutt and RidgeRun, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * XXX Some of this code should be replaceable by the upcoming OPP layer
+ * code.  However, some notion of "rate set" is probably still necessary
+ * for OMAP2xxx at least.  Rate sets should be generalized so they can be
+ * used for any OMAP chip, not just OMAP2xxx.  In particular, Richard Woodruff
+ * has in the past expressed a preference to use rate sets for OPP changes,
+ * rather than dynamically recalculating the clock tree, so if someone wants
+ * this badly enough to write the code to handle it, we should support it
+ * as an option.
+ */
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/cpufreq.h>
+
+#include <plat/clock.h>
+#include <plat/sram.h>
+#include <plat/sdrc.h>
+
+#include "clock.h"
+#include "clock2xxx.h"
+#include "opp2xxx.h"
+#include "cm.h"
+#include "cm-regbits-24xx.h"
+
+const struct prcm_config *curr_prcm_set;
+const struct prcm_config *rate_table;
+
+/**
+ * omap2_table_mpu_recalc - just return the MPU speed
+ * @clk: virt_prcm_set struct clk
+ *
+ * Set virt_prcm_set's rate to the mpu_speed field of the current PRCM set.
+ */
+unsigned long omap2_table_mpu_recalc(struct clk *clk)
+{
+	return curr_prcm_set->mpu_speed;
+}
+
+/*
+ * Look for a rate equal or less than the target rate given a configuration set.
+ *
+ * What's not entirely clear is "which" field represents the key field.
+ * Some might argue L3-DDR, others ARM, others IVA. This code is simple and
+ * just uses the ARM rates.
+ */
+long omap2_round_to_table_rate(struct clk *clk, unsigned long rate)
+{
+	const struct prcm_config *ptr;
+	long highest_rate;
+	long sys_ck_rate;
+
+	sys_ck_rate = clk_get_rate(sclk);
+
+	highest_rate = -EINVAL;
+
+	for (ptr = rate_table; ptr->mpu_speed; ptr++) {
+		if (!(ptr->flags & cpu_mask))
+			continue;
+		if (ptr->xtal_speed != sys_ck_rate)
+			continue;
+
+		highest_rate = ptr->mpu_speed;
+
+		/* Can check only after xtal frequency check */
+		if (ptr->mpu_speed <= rate)
+			break;
+	}
+	return highest_rate;
+}
+
+/* Sets basic clocks based on the specified rate */
+int omap2_select_table_rate(struct clk *clk, unsigned long rate)
+{
+	u32 cur_rate, done_rate, bypass = 0, tmp;
+	const struct prcm_config *prcm;
+	unsigned long found_speed = 0;
+	unsigned long flags;
+	long sys_ck_rate;
+
+	sys_ck_rate = clk_get_rate(sclk);
+
+	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
+		if (!(prcm->flags & cpu_mask))
+			continue;
+
+		if (prcm->xtal_speed != sys_ck_rate)
+			continue;
+
+		if (prcm->mpu_speed <= rate) {
+			found_speed = prcm->mpu_speed;
+			break;
+		}
+	}
+
+	if (!found_speed) {
+		printk(KERN_INFO "Could not set MPU rate to %luMHz\n",
+		       rate / 1000000);
+		return -EINVAL;
+	}
+
+	curr_prcm_set = prcm;
+	cur_rate = omap2xxx_clk_get_core_rate(dclk);
+
+	if (prcm->dpll_speed == cur_rate / 2) {
+		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL, 1);
+	} else if (prcm->dpll_speed == cur_rate * 2) {
+		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
+	} else if (prcm->dpll_speed != cur_rate) {
+		local_irq_save(flags);
+
+		if (prcm->dpll_speed == prcm->xtal_speed)
+			bypass = 1;
+
+		if ((prcm->cm_clksel2_pll & OMAP24XX_CORE_CLK_SRC_MASK) ==
+		    CORE_CLK_SRC_DPLL_X2)
+			done_rate = CORE_CLK_SRC_DPLL_X2;
+		else
+			done_rate = CORE_CLK_SRC_DPLL;
+
+		/* MPU divider */
+		cm_write_mod_reg(prcm->cm_clksel_mpu, MPU_MOD, CM_CLKSEL);
+
+		/* dsp + iva1 div(2420), iva2.1(2430) */
+		cm_write_mod_reg(prcm->cm_clksel_dsp,
+				 OMAP24XX_DSP_MOD, CM_CLKSEL);
+
+		cm_write_mod_reg(prcm->cm_clksel_gfx, GFX_MOD, CM_CLKSEL);
+
+		/* Major subsystem dividers */
+		tmp = cm_read_mod_reg(CORE_MOD, CM_CLKSEL1) & OMAP24XX_CLKSEL_DSS2_MASK;
+		cm_write_mod_reg(prcm->cm_clksel1_core | tmp, CORE_MOD,
+				 CM_CLKSEL1);
+
+		if (cpu_is_omap2430())
+			cm_write_mod_reg(prcm->cm_clksel_mdm,
+					 OMAP2430_MDM_MOD, CM_CLKSEL);
+
+		/* x2 to enter omap2xxx_sdrc_init_params() */
+		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
+
+		omap2_set_prcm(prcm->cm_clksel1_pll, prcm->base_sdrc_rfr,
+			       bypass);
+
+		omap2xxx_sdrc_init_params(omap2xxx_sdrc_dll_is_unlocked());
+		omap2xxx_sdrc_reprogram(done_rate, 0);
+
+		local_irq_restore(flags);
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_CPU_FREQ
+/*
+ * Walk PRCM rate table and fillout cpufreq freq_table
+ * XXX This should be replaced by an OPP layer in the near future
+ */
+static struct cpufreq_frequency_table *freq_table;
+
+void omap2xxx_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
+{
+	const struct prcm_config *prcm;
+	long sys_ck_rate;
+	int i = 0;
+	int tbl_sz = 0;
+
+	if (!cpu_is_omap2xxx())
+		return;
+
+	sys_ck_rate = clk_get_rate(sclk);
+
+	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
+		if (!(prcm->flags & cpu_mask))
+			continue;
+		if (prcm->xtal_speed != sys_ck_rate)
+			continue;
+
+		/* don't put bypass rates in table */
+		if (prcm->dpll_speed == prcm->xtal_speed)
+			continue;
+
+		tbl_sz++;
+	}
+
+	/*
+	 * XXX Ensure that we're doing what CPUFreq expects for this error
+	 * case and the following one
+	 */
+	if (tbl_sz == 0) {
+		pr_warning("%s: no matching entries in rate_table\n",
+			   __func__);
+		return;
+	}
+
+	/* Include the CPUFREQ_TABLE_END terminator entry */
+	tbl_sz++;
+
+	freq_table = kzalloc(sizeof(struct cpufreq_frequency_table) * tbl_sz,
+			     GFP_ATOMIC);
+	if (!freq_table) {
+		pr_err("%s: could not kzalloc frequency table\n", __func__);
+		return;
+	}
+
+	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
+		if (!(prcm->flags & cpu_mask))
+			continue;
+		if (prcm->xtal_speed != sys_ck_rate)
+			continue;
+
+		/* don't put bypass rates in table */
+		if (prcm->dpll_speed == prcm->xtal_speed)
+			continue;
+
+		freq_table[i].index = i;
+		freq_table[i].frequency = prcm->mpu_speed / 1000;
+		i++;
+	}
+
+	freq_table[i].index = i;
+	freq_table[i].frequency = CPUFREQ_TABLE_END;
+
+	*table = &freq_table[0];
+}
+
+void omap2xxx_clk_exit_cpufreq_table(struct cpufreq_frequency_table **table)
+{
+	if (!cpu_is_omap2xxx())
+		return;
+
+	kfree(freq_table);
+}
+
+#endif
diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index 419ae80..11d6edb 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -54,9 +54,6 @@
 #define APLLS_CLKIN_13MHZ		2
 #define APLLS_CLKIN_12MHZ		3
 
-const struct prcm_config *curr_prcm_set;
-const struct prcm_config *rate_table;
-
 struct clk *vclk, *sclk, *dclk;
 
 void __iomem *prcm_clksrc_ctrl;
@@ -185,214 +182,6 @@ const struct clkops clkops_apll54 = {
 	.disable	= omap2_clk_apll_disable,
 };
 
-/**
- * omap2_table_mpu_recalc - just return the MPU speed
- * @clk: virt_prcm_set struct clk
- *
- * Set virt_prcm_set's rate to the mpu_speed field of the current PRCM set.
- */
-unsigned long omap2_table_mpu_recalc(struct clk *clk)
-{
-	return curr_prcm_set->mpu_speed;
-}
-
-/*
- * Look for a rate equal or less than the target rate given a configuration set.
- *
- * What's not entirely clear is "which" field represents the key field.
- * Some might argue L3-DDR, others ARM, others IVA. This code is simple and
- * just uses the ARM rates.
- */
-long omap2_round_to_table_rate(struct clk *clk, unsigned long rate)
-{
-	const struct prcm_config *ptr;
-	long highest_rate;
-	long sys_ck_rate;
-
-	sys_ck_rate = clk_get_rate(sclk);
-
-	highest_rate = -EINVAL;
-
-	for (ptr = rate_table; ptr->mpu_speed; ptr++) {
-		if (!(ptr->flags & cpu_mask))
-			continue;
-		if (ptr->xtal_speed != sys_ck_rate)
-			continue;
-
-		highest_rate = ptr->mpu_speed;
-
-		/* Can check only after xtal frequency check */
-		if (ptr->mpu_speed <= rate)
-			break;
-	}
-	return highest_rate;
-}
-
-/* Sets basic clocks based on the specified rate */
-int omap2_select_table_rate(struct clk *clk, unsigned long rate)
-{
-	u32 cur_rate, done_rate, bypass = 0, tmp;
-	const struct prcm_config *prcm;
-	unsigned long found_speed = 0;
-	unsigned long flags;
-	long sys_ck_rate;
-
-	sys_ck_rate = clk_get_rate(sclk);
-
-	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
-		if (!(prcm->flags & cpu_mask))
-			continue;
-
-		if (prcm->xtal_speed != sys_ck_rate)
-			continue;
-
-		if (prcm->mpu_speed <= rate) {
-			found_speed = prcm->mpu_speed;
-			break;
-		}
-	}
-
-	if (!found_speed) {
-		printk(KERN_INFO "Could not set MPU rate to %luMHz\n",
-		       rate / 1000000);
-		return -EINVAL;
-	}
-
-	curr_prcm_set = prcm;
-	cur_rate = omap2xxx_clk_get_core_rate(dclk);
-
-	if (prcm->dpll_speed == cur_rate / 2) {
-		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL, 1);
-	} else if (prcm->dpll_speed == cur_rate * 2) {
-		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
-	} else if (prcm->dpll_speed != cur_rate) {
-		local_irq_save(flags);
-
-		if (prcm->dpll_speed == prcm->xtal_speed)
-			bypass = 1;
-
-		if ((prcm->cm_clksel2_pll & OMAP24XX_CORE_CLK_SRC_MASK) ==
-		    CORE_CLK_SRC_DPLL_X2)
-			done_rate = CORE_CLK_SRC_DPLL_X2;
-		else
-			done_rate = CORE_CLK_SRC_DPLL;
-
-		/* MPU divider */
-		cm_write_mod_reg(prcm->cm_clksel_mpu, MPU_MOD, CM_CLKSEL);
-
-		/* dsp + iva1 div(2420), iva2.1(2430) */
-		cm_write_mod_reg(prcm->cm_clksel_dsp,
-				 OMAP24XX_DSP_MOD, CM_CLKSEL);
-
-		cm_write_mod_reg(prcm->cm_clksel_gfx, GFX_MOD, CM_CLKSEL);
-
-		/* Major subsystem dividers */
-		tmp = cm_read_mod_reg(CORE_MOD, CM_CLKSEL1) & OMAP24XX_CLKSEL_DSS2_MASK;
-		cm_write_mod_reg(prcm->cm_clksel1_core | tmp, CORE_MOD,
-				 CM_CLKSEL1);
-
-		if (cpu_is_omap2430())
-			cm_write_mod_reg(prcm->cm_clksel_mdm,
-					 OMAP2430_MDM_MOD, CM_CLKSEL);
-
-		/* x2 to enter omap2xxx_sdrc_init_params() */
-		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
-
-		omap2_set_prcm(prcm->cm_clksel1_pll, prcm->base_sdrc_rfr,
-			       bypass);
-
-		omap2xxx_sdrc_init_params(omap2xxx_sdrc_dll_is_unlocked());
-		omap2xxx_sdrc_reprogram(done_rate, 0);
-
-		local_irq_restore(flags);
-	}
-
-	return 0;
-}
-
-#ifdef CONFIG_CPU_FREQ
-/*
- * Walk PRCM rate table and fillout cpufreq freq_table
- * XXX This should be replaced by an OPP layer in the near future
- */
-static struct cpufreq_frequency_table *freq_table;
-
-void omap2xxx_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
-{
-	const struct prcm_config *prcm;
-	long sys_ck_rate;
-	int i = 0;
-	int tbl_sz = 0;
-
-	if (!cpu_is_omap2xxx())
-		return;
-
-	sys_ck_rate = clk_get_rate(sclk);
-
-	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
-		if (!(prcm->flags & cpu_mask))
-			continue;
-		if (prcm->xtal_speed != sys_ck_rate)
-			continue;
-
-		/* don't put bypass rates in table */
-		if (prcm->dpll_speed == prcm->xtal_speed)
-			continue;
-
-		tbl_sz++;
-	}
-
-	/*
-	 * XXX Ensure that we're doing what CPUFreq expects for this error
-	 * case and the following one
-	 */
-	if (tbl_sz == 0) {
-		pr_warning("%s: no matching entries in rate_table\n",
-			   __func__);
-		return;
-	}
-
-	/* Include the CPUFREQ_TABLE_END terminator entry */
-	tbl_sz++;
-
-	freq_table = kzalloc(sizeof(struct cpufreq_frequency_table) * tbl_sz,
-			     GFP_ATOMIC);
-	if (!freq_table) {
-		pr_err("%s: could not kzalloc frequency table\n", __func__);
-		return;
-	}
-
-	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
-		if (!(prcm->flags & cpu_mask))
-			continue;
-		if (prcm->xtal_speed != sys_ck_rate)
-			continue;
-
-		/* don't put bypass rates in table */
-		if (prcm->dpll_speed == prcm->xtal_speed)
-			continue;
-
-		freq_table[i].index = i;
-		freq_table[i].frequency = prcm->mpu_speed / 1000;
-		i++;
-	}
-
-	freq_table[i].index = i;
-	freq_table[i].frequency = CPUFREQ_TABLE_END;
-
-	*table = &freq_table[0];
-}
-
-void omap2xxx_clk_exit_cpufreq_table(struct cpufreq_frequency_table **table)
-{
-	if (!cpu_is_omap2xxx())
-		return;
-
-	kfree(freq_table);
-}
-
-#endif
-
 static u32 omap2_get_apll_clkin(void)
 {
 	u32 aplls, srate = 0;


