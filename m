From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 14/27] clk: ti: dpll: move omap3 DPLL functionality to clock driver
Date: Mon, 25 May 2015 18:00:19 +0300
Message-ID: <1432566032-10860-15-git-send-email-t-kristo@ti.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50061 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081AbbEYPBb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 May 2015 11:01:31 -0400
In-Reply-To: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

With the legacy clock support gone, OMAP3 generic DPLL code can now be
moved over to the clock driver also. A few un-unused clkoutx2 functions
are also removed at the same time.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/Makefile                       |    8 +-
 arch/arm/mach-omap2/clock.h                        |    4 -
 arch/arm/mach-omap2/clock3xxx.c                    |   77 ----------
 drivers/clk/ti/Makefile                            |    2 +-
 drivers/clk/ti/clk-3xxx.c                          |   31 ++++
 drivers/clk/ti/clock.h                             |   27 ++++
 {arch/arm/mach-omap2 => drivers/clk/ti}/dpll3xxx.c |  153 ++++++++++----------
 include/linux/clk/ti.h                             |   30 ----
 8 files changed, 141 insertions(+), 191 deletions(-)
 rename {arch/arm/mach-omap2 => drivers/clk/ti}/dpll3xxx.c (85%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index bf5d71d..f9d4ccf 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -189,15 +189,11 @@ obj-$(CONFIG_SOC_OMAP2430)		+= clock2430.o
 obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common) clock3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o clkt34xx_dpll3m2.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock3517.o
-obj-$(CONFIG_ARCH_OMAP3)		+= dpll3xxx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common)
-obj-$(CONFIG_ARCH_OMAP4)		+= dpll3xxx.o
-obj-$(CONFIG_SOC_AM33XX)		+= $(clock-common) dpll3xxx.o
+obj-$(CONFIG_SOC_AM33XX)		+= $(clock-common)
 obj-$(CONFIG_SOC_OMAP5)			+= $(clock-common)
-obj-$(CONFIG_SOC_OMAP5)			+= dpll3xxx.o
 obj-$(CONFIG_SOC_DRA7XX)		+= $(clock-common)
-obj-$(CONFIG_SOC_DRA7XX)		+= dpll3xxx.o
-obj-$(CONFIG_SOC_AM43XX)		+= $(clock-common) dpll3xxx.o
+obj-$(CONFIG_SOC_AM43XX)		+= $(clock-common)
 
 # OMAP2 clock rate set data (old "OPP" data)
 obj-$(CONFIG_SOC_OMAP2420)		+= opp2420_data.o
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index e2781b4..d60691d 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -180,10 +180,6 @@ struct clksel {
 #define OMAP4XXX_EN_DPLL_FRBYPASS		0x6
 #define OMAP4XXX_EN_DPLL_LOCKED			0x7
 
-u32 omap3_dpll_autoidle_read(struct clk_hw_omap *clk);
-void omap3_dpll_allow_idle(struct clk_hw_omap *clk);
-void omap3_dpll_deny_idle(struct clk_hw_omap *clk);
-
 void __init omap2_clk_disable_clkdm_control(void);
 
 void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/clock3xxx.c
index 4bd6122..0b0e3a87 100644
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -29,82 +29,5 @@
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-34xx.h"
 
-/*
- * DPLL5_FREQ_FOR_USBHOST: USBHOST and USBTLL are the only clocks
- * that are sourced by DPLL5, and both of these require this clock
- * to be at 120 MHz for proper operation.
- */
-#define DPLL5_FREQ_FOR_USBHOST		120000000
-
 /* needed by omap3_core_dpll_m2_set_rate() */
 struct clk *sdrc_ick_p, *arm_fck_p;
-
-/**
- * omap3_dpll4_set_rate - set rate for omap3 per-dpll
- * @hw: clock to change
- * @rate: target rate for clock
- * @parent_rate: rate of the parent clock
- *
- * Check if the current SoC supports the per-dpll reprogram operation
- * or not, and then do the rate change if supported. Returns -EINVAL
- * if not supported, 0 for success, and potential error codes from the
- * clock rate change.
- */
-int omap3_dpll4_set_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long parent_rate)
-{
-	/*
-	 * According to the 12-5 CDP code from TI, "Limitation 2.5"
-	 * on 3430ES1 prevents us from changing DPLL multipliers or dividers
-	 * on DPLL4.
-	 */
-	if (ti_clk_get_features()->flags & TI_CLK_DPLL4_DENY_REPROGRAM) {
-		pr_err("clock: DPLL4 cannot change rate due to silicon 'Limitation 2.5' on 3430ES1.\n");
-		return -EINVAL;
-	}
-
-	return omap3_noncore_dpll_set_rate(hw, rate, parent_rate);
-}
-
-/**
- * omap3_dpll4_set_rate_and_parent - set rate and parent for omap3 per-dpll
- * @hw: clock to change
- * @rate: target rate for clock
- * @parent_rate: rate of the parent clock
- * @index: parent index, 0 - reference clock, 1 - bypass clock
- *
- * Check if the current SoC support the per-dpll reprogram operation
- * or not, and then do the rate + parent change if supported. Returns
- * -EINVAL if not supported, 0 for success, and potential error codes
- * from the clock rate change.
- */
-int omap3_dpll4_set_rate_and_parent(struct clk_hw *hw, unsigned long rate,
-				    unsigned long parent_rate, u8 index)
-{
-	if (ti_clk_get_features()->flags & TI_CLK_DPLL4_DENY_REPROGRAM) {
-		pr_err("clock: DPLL4 cannot change rate due to silicon 'Limitation 2.5' on 3430ES1.\n");
-		return -EINVAL;
-	}
-
-	return omap3_noncore_dpll_set_rate_and_parent(hw, rate, parent_rate,
-						      index);
-}
-
-void __init omap3_clk_lock_dpll5(void)
-{
-	struct clk *dpll5_clk;
-	struct clk *dpll5_m2_clk;
-
-	dpll5_clk = clk_get(NULL, "dpll5_ck");
-	clk_set_rate(dpll5_clk, DPLL5_FREQ_FOR_USBHOST);
-	clk_prepare_enable(dpll5_clk);
-
-	/* Program dpll5_m2_clk divider for no division */
-	dpll5_m2_clk = clk_get(NULL, "dpll5_m2_ck");
-	clk_prepare_enable(dpll5_m2_clk);
-	clk_set_rate(dpll5_m2_clk, DPLL5_FREQ_FOR_USBHOST);
-
-	clk_disable_unprepare(dpll5_m2_clk);
-	clk_disable_unprepare(dpll5_clk);
-	return;
-}
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 23cd726..fe2cfa2 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,7 +1,7 @@
 obj-y					+= clk.o autoidle.o clockdomain.o
 clk-common				= dpll.o composite.o divider.o gate.o \
 					  fixed-factor.o mux.o apll.o \
-					  clkt_dpll.o clkt_iclk.o
+					  clkt_dpll.o clkt_iclk.o dpll3xxx.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(clk-common) clk-33xx.o
 obj-$(CONFIG_SOC_TI81XX)		+= $(clk-common) fapll.o clk-816x.o
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clk-common) interface.o clk-2xxx.o
diff --git a/drivers/clk/ti/clk-3xxx.c b/drivers/clk/ti/clk-3xxx.c
index bb3b883..5489ad8 100644
--- a/drivers/clk/ti/clk-3xxx.c
+++ b/drivers/clk/ti/clk-3xxx.c
@@ -21,6 +21,13 @@
 
 #include "clock.h"
 
+/*
+ * DPLL5_FREQ_FOR_USBHOST: USBHOST and USBTLL are the only clocks
+ * that are sourced by DPLL5, and both of these require this clock
+ * to be at 120 MHz for proper operation.
+ */
+#define DPLL5_FREQ_FOR_USBHOST		120000000
+
 static struct ti_dt_clk omap3xxx_clks[] = {
 	DT_CLK(NULL, "apb_pclk", "dummy_apb_pclk"),
 	DT_CLK(NULL, "omap_32k_fck", "omap_32k_fck"),
@@ -325,6 +332,30 @@ enum {
 	OMAP3_SOC_OMAP3630,
 };
 
+/**
+ * omap3_clk_lock_dpll5 - locks DPLL5
+ *
+ * Locks DPLL5 to a pre-defined frequency. This is required for proper
+ * operation of USB.
+ */
+void __init omap3_clk_lock_dpll5(void)
+{
+	struct clk *dpll5_clk;
+	struct clk *dpll5_m2_clk;
+
+	dpll5_clk = clk_get(NULL, "dpll5_ck");
+	clk_set_rate(dpll5_clk, DPLL5_FREQ_FOR_USBHOST);
+	clk_prepare_enable(dpll5_clk);
+
+	/* Program dpll5_m2_clk divider for no division */
+	dpll5_m2_clk = clk_get(NULL, "dpll5_m2_ck");
+	clk_prepare_enable(dpll5_m2_clk);
+	clk_set_rate(dpll5_m2_clk, DPLL5_FREQ_FOR_USBHOST);
+
+	clk_disable_unprepare(dpll5_m2_clk);
+	clk_disable_unprepare(dpll5_clk);
+}
+
 static int __init omap3xxx_dt_clk_init(int soc_type)
 {
 	if (soc_type == OMAP3_SOC_AM35XX || soc_type == OMAP3_SOC_OMAP3630 ||
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 4b26af8..688d9e4 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -173,11 +173,38 @@ void omap2_init_clk_hw_omap_clocks(struct clk *clk);
 int of_ti_clk_autoidle_setup(struct device_node *node);
 void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks);
 
+extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
 extern const struct clk_hw_omap_ops clkhwops_iclk;
 extern const struct clk_hw_omap_ops clkhwops_iclk_wait;
 
 u8 omap2_init_dpll_parent(struct clk_hw *hw);
+int omap3_noncore_dpll_enable(struct clk_hw *hw);
+void omap3_noncore_dpll_disable(struct clk_hw *hw);
+int omap3_noncore_dpll_set_parent(struct clk_hw *hw, u8 index);
+int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate);
+int omap3_noncore_dpll_set_rate_and_parent(struct clk_hw *hw,
+					   unsigned long rate,
+					   unsigned long parent_rate,
+					   u8 index);
+long omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
+				       unsigned long rate,
+				       unsigned long min_rate,
+				       unsigned long max_rate,
+				       unsigned long *best_parent_rate,
+				       struct clk_hw **best_parent_clk);
+long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
+			   unsigned long *parent_rate);
+unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
+				    unsigned long parent_rate);
+
+unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long parent_rate);
+int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
+			 unsigned long parent_rate);
+int omap3_dpll4_set_rate_and_parent(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate, u8 index);
+void omap3_clk_lock_dpll5(void);
 
 unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
 					 unsigned long parent_rate);
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
similarity index 85%
rename from arch/arm/mach-omap2/dpll3xxx.c
rename to drivers/clk/ti/dpll3xxx.c
index 9a80f59..22d77a3 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/drivers/clk/ti/dpll3xxx.c
@@ -27,8 +27,8 @@
 #include <linux/io.h>
 #include <linux/bitops.h>
 #include <linux/clkdev.h>
+#include <linux/clk/ti.h>
 
-#include "clockdomain.h"
 #include "clock.h"
 
 /* CM_AUTOIDLE_PLL*.AUTO_* bit values */
@@ -37,6 +37,13 @@
 
 #define MAX_DPLL_WAIT_TRIES		1000000
 
+#define OMAP3XXX_EN_DPLL_LOCKED		0x7
+
+/* Forward declarations */
+static u32 omap3_dpll_autoidle_read(struct clk_hw_omap *clk);
+static void omap3_dpll_deny_idle(struct clk_hw_omap *clk);
+static void omap3_dpll_allow_idle(struct clk_hw_omap *clk);
+
 /* Private functions */
 
 /* _omap3_dpll_write_clken - write clken_bits arg to a DPLL's enable bits */
@@ -47,10 +54,10 @@ static void _omap3_dpll_write_clken(struct clk_hw_omap *clk, u8 clken_bits)
 
 	dd = clk->dpll_data;
 
-	v = omap2_clk_readl(clk, dd->control_reg);
+	v = ti_clk_ll_ops->clk_readl(dd->control_reg);
 	v &= ~dd->enable_mask;
 	v |= clken_bits << __ffs(dd->enable_mask);
-	omap2_clk_writel(v, clk, dd->control_reg);
+	ti_clk_ll_ops->clk_writel(v, dd->control_reg);
 }
 
 /* _omap3_wait_dpll_status: wait for a DPLL to enter a specific state */
@@ -66,14 +73,14 @@ static int _omap3_wait_dpll_status(struct clk_hw_omap *clk, u8 state)
 
 	state <<= __ffs(dd->idlest_mask);
 
-	while (((omap2_clk_readl(clk, dd->idlest_reg) & dd->idlest_mask)
+	while (((ti_clk_ll_ops->clk_readl(dd->idlest_reg) & dd->idlest_mask)
 		!= state) && i < MAX_DPLL_WAIT_TRIES) {
 		i++;
 		udelay(1);
 	}
 
 	if (i == MAX_DPLL_WAIT_TRIES) {
-		printk(KERN_ERR "clock: %s failed transition to '%s'\n",
+		pr_err("clock: %s failed transition to '%s'\n",
 		       clk_name, (state) ? "locked" : "bypassed");
 	} else {
 		pr_debug("clock: %s transition to '%s' in %d loops\n",
@@ -144,7 +151,8 @@ static int _omap3_noncore_dpll_lock(struct clk_hw_omap *clk)
 	state <<= __ffs(dd->idlest_mask);
 
 	/* Check if already locked */
-	if ((omap2_clk_readl(clk, dd->idlest_reg) & dd->idlest_mask) == state)
+	if ((ti_clk_ll_ops->clk_readl(dd->idlest_reg) & dd->idlest_mask) ==
+	    state)
 		goto done;
 
 	ai = omap3_dpll_autoidle_read(clk);
@@ -308,14 +316,14 @@ static int omap3_noncore_dpll_program(struct clk_hw_omap *clk, u16 freqsel)
 	 * only since freqsel field is no longer present on other devices.
 	 */
 	if (ti_clk_get_features()->flags & TI_CLK_DPLL_HAS_FREQSEL) {
-		v = omap2_clk_readl(clk, dd->control_reg);
+		v = ti_clk_ll_ops->clk_readl(dd->control_reg);
 		v &= ~dd->freqsel_mask;
 		v |= freqsel << __ffs(dd->freqsel_mask);
-		omap2_clk_writel(v, clk, dd->control_reg);
+		ti_clk_ll_ops->clk_writel(v, dd->control_reg);
 	}
 
 	/* Set DPLL multiplier, divider */
-	v = omap2_clk_readl(clk, dd->mult_div1_reg);
+	v = ti_clk_ll_ops->clk_readl(dd->mult_div1_reg);
 
 	/* Handle Duty Cycle Correction */
 	if (dd->dcc_mask) {
@@ -342,11 +350,11 @@ static int omap3_noncore_dpll_program(struct clk_hw_omap *clk, u16 freqsel)
 		v |= sd_div << __ffs(dd->sddiv_mask);
 	}
 
-	omap2_clk_writel(v, clk, dd->mult_div1_reg);
+	ti_clk_ll_ops->clk_writel(v, dd->mult_div1_reg);
 
 	/* Set 4X multiplier and low-power mode */
 	if (dd->m4xen_mask || dd->lpmode_mask) {
-		v = omap2_clk_readl(clk, dd->control_reg);
+		v = ti_clk_ll_ops->clk_readl(dd->control_reg);
 
 		if (dd->m4xen_mask) {
 			if (dd->last_rounded_m4xen)
@@ -362,7 +370,7 @@ static int omap3_noncore_dpll_program(struct clk_hw_omap *clk, u16 freqsel)
 				v &= ~dd->lpmode_mask;
 		}
 
-		omap2_clk_writel(v, clk, dd->control_reg);
+		ti_clk_ll_ops->clk_writel(v, dd->control_reg);
 	}
 
 	/* We let the clock framework set the other output dividers later */
@@ -417,12 +425,12 @@ int omap3_noncore_dpll_enable(struct clk_hw *hw)
 		return -EINVAL;
 
 	if (clk->clkdm) {
-		r = clkdm_clk_enable(clk->clkdm, hw->clk);
+		r = ti_clk_ll_ops->clkdm_clk_enable(clk->clkdm, hw->clk);
 		if (r) {
 			WARN(1,
 			     "%s: could not enable %s's clockdomain %s: %d\n",
 			     __func__, __clk_get_name(hw->clk),
-			     clk->clkdm->name, r);
+			     clk->clkdm_name, r);
 			return r;
 		}
 	}
@@ -453,10 +461,9 @@ void omap3_noncore_dpll_disable(struct clk_hw *hw)
 
 	_omap3_noncore_dpll_stop(clk);
 	if (clk->clkdm)
-		clkdm_clk_disable(clk->clkdm, hw->clk);
+		ti_clk_ll_ops->clkdm_clk_disable(clk->clkdm, hw->clk);
 }
 
-
 /* Non-CORE DPLL rate set code */
 
 /**
@@ -618,7 +625,7 @@ int omap3_noncore_dpll_set_rate_and_parent(struct clk_hw *hw,
  * -EINVAL if passed a null pointer or if the struct clk does not
  * appear to refer to a DPLL.
  */
-u32 omap3_dpll_autoidle_read(struct clk_hw_omap *clk)
+static u32 omap3_dpll_autoidle_read(struct clk_hw_omap *clk)
 {
 	const struct dpll_data *dd;
 	u32 v;
@@ -631,7 +638,7 @@ u32 omap3_dpll_autoidle_read(struct clk_hw_omap *clk)
 	if (!dd->autoidle_reg)
 		return -EINVAL;
 
-	v = omap2_clk_readl(clk, dd->autoidle_reg);
+	v = ti_clk_ll_ops->clk_readl(dd->autoidle_reg);
 	v &= dd->autoidle_mask;
 	v >>= __ffs(dd->autoidle_mask);
 
@@ -647,7 +654,7 @@ u32 omap3_dpll_autoidle_read(struct clk_hw_omap *clk)
  * OMAP3430.  The DPLL will enter low-power stop when its downstream
  * clocks are gated.  No return value.
  */
-void omap3_dpll_allow_idle(struct clk_hw_omap *clk)
+static void omap3_dpll_allow_idle(struct clk_hw_omap *clk)
 {
 	const struct dpll_data *dd;
 	u32 v;
@@ -665,11 +672,10 @@ void omap3_dpll_allow_idle(struct clk_hw_omap *clk)
 	 * by writing 0x5 instead of 0x1.  Add some mechanism to
 	 * optionally enter this mode.
 	 */
-	v = omap2_clk_readl(clk, dd->autoidle_reg);
+	v = ti_clk_ll_ops->clk_readl(dd->autoidle_reg);
 	v &= ~dd->autoidle_mask;
 	v |= DPLL_AUTOIDLE_LOW_POWER_STOP << __ffs(dd->autoidle_mask);
-	omap2_clk_writel(v, clk, dd->autoidle_reg);
-
+	ti_clk_ll_ops->clk_writel(v, dd->autoidle_reg);
 }
 
 /**
@@ -678,7 +684,7 @@ void omap3_dpll_allow_idle(struct clk_hw_omap *clk)
  *
  * Disable DPLL automatic idle control.  No return value.
  */
-void omap3_dpll_deny_idle(struct clk_hw_omap *clk)
+static void omap3_dpll_deny_idle(struct clk_hw_omap *clk)
 {
 	const struct dpll_data *dd;
 	u32 v;
@@ -691,11 +697,10 @@ void omap3_dpll_deny_idle(struct clk_hw_omap *clk)
 	if (!dd->autoidle_reg)
 		return;
 
-	v = omap2_clk_readl(clk, dd->autoidle_reg);
+	v = ti_clk_ll_ops->clk_readl(dd->autoidle_reg);
 	v &= ~dd->autoidle_mask;
 	v |= DPLL_AUTOIDLE_DISABLE << __ffs(dd->autoidle_mask);
-	omap2_clk_writel(v, clk, dd->autoidle_reg);
-
+	ti_clk_ll_ops->clk_writel(v, dd->autoidle_reg);
 }
 
 /* Clock control for DPLL outputs */
@@ -753,7 +758,7 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
 
 	WARN_ON(!dd->enable_mask);
 
-	v = omap2_clk_readl(pclk, dd->control_reg) & dd->enable_mask;
+	v = ti_clk_ll_ops->clk_readl(dd->control_reg) & dd->enable_mask;
 	v >>= __ffs(dd->enable_mask);
 	if ((v != OMAP3XXX_EN_DPLL_LOCKED) || (dd->flags & DPLL_J_TYPE))
 		rate = parent_rate;
@@ -762,57 +767,59 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
 	return rate;
 }
 
-int omap3_clkoutx2_set_rate(struct clk_hw *hw, unsigned long rate,
-					unsigned long parent_rate)
-{
-	return 0;
-}
+/* OMAP3/4 non-CORE DPLL clkops */
+const struct clk_hw_omap_ops clkhwops_omap3_dpll = {
+	.allow_idle	= omap3_dpll_allow_idle,
+	.deny_idle	= omap3_dpll_deny_idle,
+};
 
-long omap3_clkoutx2_round_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long *prate)
+/**
+ * omap3_dpll4_set_rate - set rate for omap3 per-dpll
+ * @hw: clock to change
+ * @rate: target rate for clock
+ * @parent_rate: rate of the parent clock
+ *
+ * Check if the current SoC supports the per-dpll reprogram operation
+ * or not, and then do the rate change if supported. Returns -EINVAL
+ * if not supported, 0 for success, and potential error codes from the
+ * clock rate change.
+ */
+int omap3_dpll4_set_rate(struct clk_hw *hw, unsigned long rate,
+			 unsigned long parent_rate)
 {
-	const struct dpll_data *dd;
-	u32 v;
-	struct clk_hw_omap *pclk = NULL;
-
-	if (!*prate)
-		return 0;
-
-	pclk = omap3_find_clkoutx2_dpll(hw);
-
-	if (!pclk)
-		return 0;
-
-	dd = pclk->dpll_data;
-
-	/* TYPE J does not have a clkoutx2 */
-	if (dd->flags & DPLL_J_TYPE) {
-		*prate = __clk_round_rate(__clk_get_parent(pclk->hw.clk), rate);
-		return *prate;
+	/*
+	 * According to the 12-5 CDP code from TI, "Limitation 2.5"
+	 * on 3430ES1 prevents us from changing DPLL multipliers or dividers
+	 * on DPLL4.
+	 */
+	if (ti_clk_get_features()->flags & TI_CLK_DPLL4_DENY_REPROGRAM) {
+		pr_err("clock: DPLL4 cannot change rate due to silicon 'Limitation 2.5' on 3430ES1.\n");
+		return -EINVAL;
 	}
 
-	WARN_ON(!dd->enable_mask);
-
-	v = omap2_clk_readl(pclk, dd->control_reg) & dd->enable_mask;
-	v >>= __ffs(dd->enable_mask);
-
-	/* If in bypass, the rate is fixed to the bypass rate*/
-	if (v != OMAP3XXX_EN_DPLL_LOCKED)
-		return *prate;
-
-	if (__clk_get_flags(hw->clk) & CLK_SET_RATE_PARENT) {
-		unsigned long best_parent;
+	return omap3_noncore_dpll_set_rate(hw, rate, parent_rate);
+}
 
-		best_parent = (rate / 2);
-		*prate = __clk_round_rate(__clk_get_parent(hw->clk),
-				best_parent);
+/**
+ * omap3_dpll4_set_rate_and_parent - set rate and parent for omap3 per-dpll
+ * @hw: clock to change
+ * @rate: target rate for clock
+ * @parent_rate: rate of the parent clock
+ * @index: parent index, 0 - reference clock, 1 - bypass clock
+ *
+ * Check if the current SoC support the per-dpll reprogram operation
+ * or not, and then do the rate + parent change if supported. Returns
+ * -EINVAL if not supported, 0 for success, and potential error codes
+ * from the clock rate change.
+ */
+int omap3_dpll4_set_rate_and_parent(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate, u8 index)
+{
+	if (ti_clk_get_features()->flags & TI_CLK_DPLL4_DENY_REPROGRAM) {
+		pr_err("clock: DPLL4 cannot change rate due to silicon 'Limitation 2.5' on 3430ES1.\n");
+		return -EINVAL;
 	}
 
-	return *prate * 2;
+	return omap3_noncore_dpll_set_rate_and_parent(hw, rate, parent_rate,
+						      index);
 }
-
-/* OMAP3/4 non-CORE DPLL clkops */
-const struct clk_hw_omap_ops clkhwops_omap3_dpll = {
-	.allow_idle	= omap3_dpll_allow_idle,
-	.deny_idle	= omap3_dpll_deny_idle,
-};
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 3ca818e..0f9d15f 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -271,41 +271,13 @@ extern const struct clk_ops ti_clk_mux_ops;
 
 #define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
 
-int omap3_noncore_dpll_enable(struct clk_hw *hw);
-void omap3_noncore_dpll_disable(struct clk_hw *hw);
-int omap3_noncore_dpll_set_parent(struct clk_hw *hw, u8 index);
-int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long parent_rate);
-int omap3_noncore_dpll_set_rate_and_parent(struct clk_hw *hw,
-					   unsigned long rate,
-					   unsigned long parent_rate,
-					   u8 index);
-long omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
-				       unsigned long rate,
-				       unsigned long min_rate,
-				       unsigned long max_rate,
-				       unsigned long *best_parent_rate,
-				       struct clk_hw **best_parent_clk);
-unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long parent_rate);
-long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
-			   unsigned long *parent_rate);
 void omap2_init_clk_clkdm(struct clk_hw *clk);
-unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
-				    unsigned long parent_rate);
-int omap3_clkoutx2_set_rate(struct clk_hw *hw, unsigned long rate,
-					unsigned long parent_rate);
-long omap3_clkoutx2_round_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long *prate);
 int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 int omap2_clk_disable_autoidle_all(void);
 int omap2_clk_enable_autoidle_all(void);
 int omap2_clk_allow_idle(struct clk *clk);
 int omap2_clk_deny_idle(struct clk *clk);
-int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
-			 unsigned long parent_rate);
-int omap3_dpll4_set_rate_and_parent(struct clk_hw *hw, unsigned long rate,
-				    unsigned long parent_rate, u8 index);
 int omap2_dflt_clk_enable(struct clk_hw *hw);
 void omap2_dflt_clk_disable(struct clk_hw *hw);
 int omap2_dflt_clk_is_enabled(struct clk_hw *hw);
@@ -317,7 +289,6 @@ void omap2_clk_dflt_find_companion(struct clk_hw_omap *clk,
 void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk,
 				void __iomem **idlest_reg,
 				u8 *idlest_bit, u8 *idlest_val);
-void omap3_clk_lock_dpll5(void);
 unsigned long omap2_dpllcore_recalc(struct clk_hw *hw,
 				    unsigned long parent_rate);
 int omap2_reprogram_dpllcore(struct clk_hw *clk, unsigned long rate,
@@ -365,7 +336,6 @@ struct ti_clk_features *ti_clk_get_features(void);
 
 extern const struct clk_hw_omap_ops clkhwops_omap2xxx_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap2430_i2chs_wait;
-extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
 extern const struct clk_hw_omap_ops clkhwops_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_wait;
 extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait;
-- 
1.7.9.5

