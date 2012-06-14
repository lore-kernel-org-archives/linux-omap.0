From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 14/29] ARM: omap2: clk: Convert to common clk
Date: Thu, 14 Jun 2012 18:17:03 +0530
Message-ID: <1339678038-23082-15-git-send-email-rnayak@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39675 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755931Ab2FNMsK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 08:48:10 -0400
In-Reply-To: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, mturquette@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Convert all OMAP2 specific platform files to use COMMON clk
and keep all the chnages under the CONFIG_COMMON_CLK macro check
so it does not break any existing code. At a later point switch
to COMMON clk and get rid of all old/legacy code.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clkt2xxx_apll.c          |   51 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/clkt2xxx_dpll.c          |   16 ++++++++-
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c      |   21 +++++++++++
 arch/arm/mach-omap2/clkt2xxx_osc.c           |   14 +++++++
 arch/arm/mach-omap2/clkt2xxx_sys.c           |    8 ++++-
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |   18 +++++++++
 arch/arm/mach-omap2/clock2430.c              |   11 ++++++
 arch/arm/mach-omap2/clock2xxx.c              |    1 +
 arch/arm/mach-omap2/clock2xxx.h              |   30 +++++++++++++++
 arch/arm/mach-omap2/pm24xx.c                 |    8 ++++
 10 files changed, 176 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt2xxx_apll.c b/arch/arm/mach-omap2/clkt2xxx_apll.c
index c2d1521..a147188 100644
--- a/arch/arm/mach-omap2/clkt2xxx_apll.c
+++ b/arch/arm/mach-omap2/clkt2xxx_apll.c
@@ -43,8 +43,14 @@ void __iomem *cm_idlest_pll;
 /* Private functions */
 
 /* Enable an APLL if off */
+#ifdef CONFIG_COMMON_CLK
+static int omap2_clk_apll_enable(struct clk_hw *hw, u32 status_mask)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+#else
 static int omap2_clk_apll_enable(struct clk *clk, u32 status_mask)
 {
+#endif
 	u32 cval, apll_mask;
 
 	apll_mask = EN_APLL_LOCKED << clk->enable_bit;
@@ -59,7 +65,11 @@ static int omap2_clk_apll_enable(struct clk *clk, u32 status_mask)
 	omap2_cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
 
 	omap2_cm_wait_idlest(cm_idlest_pll, status_mask,
+#ifdef CONFIG_COMMON_CLK
+			     OMAP24XX_CM_IDLEST_VAL, __clk_get_name(hw->clk));
+#else
 			     OMAP24XX_CM_IDLEST_VAL, __clk_get_name(clk));
+#endif
 
 	/*
 	 * REVISIT: Should we return an error code if omap2_wait_clock_ready()
@@ -68,39 +78,69 @@ static int omap2_clk_apll_enable(struct clk *clk, u32 status_mask)
 	return 0;
 }
 
+#ifdef CONFIG_COMMON_CLK
+int omap2_clk_apll96_enable(struct clk_hw *clk)
+#else
 static int omap2_clk_apll96_enable(struct clk *clk)
+#endif
 {
 	return omap2_clk_apll_enable(clk, OMAP24XX_ST_96M_APLL_MASK);
 }
 
+#ifdef CONFIG_COMMON_CLK
+int omap2_clk_apll54_enable(struct clk_hw *clk)
+#else
 static int omap2_clk_apll54_enable(struct clk *clk)
+#endif
 {
 	return omap2_clk_apll_enable(clk, OMAP24XX_ST_54M_APLL_MASK);
 }
 
+#ifdef CONFIG_COMMON_CLK
+void _apll96_allow_idle(struct clk_hw_omap *clk)
+#else
 static void _apll96_allow_idle(struct clk *clk)
+#endif
 {
 	omap2xxx_cm_set_apll96_auto_low_power_stop();
 }
 
+#ifdef CONFIG_COMMON_CLK
+void _apll96_deny_idle(struct clk_hw_omap *clk)
+#else
 static void _apll96_deny_idle(struct clk *clk)
+#endif
 {
 	omap2xxx_cm_set_apll96_disable_autoidle();
 }
 
+#ifdef CONFIG_COMMON_CLK
+void _apll54_allow_idle(struct clk_hw_omap *clk)
+#else
 static void _apll54_allow_idle(struct clk *clk)
+#endif
 {
 	omap2xxx_cm_set_apll54_auto_low_power_stop();
 }
 
+#ifdef CONFIG_COMMON_CLK
+void _apll54_deny_idle(struct clk_hw_omap *clk)
+#else
 static void _apll54_deny_idle(struct clk *clk)
+#endif
 {
 	omap2xxx_cm_set_apll54_disable_autoidle();
 }
 
 /* Stop APLL */
+#ifdef CONFIG_COMMON_CLK
+void omap2_clk_apll_disable(struct clk_hw *hw)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+#else
 static void omap2_clk_apll_disable(struct clk *clk)
 {
+#endif
 	u32 cval;
 
 	cval = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKEN);
@@ -109,7 +149,17 @@ static void omap2_clk_apll_disable(struct clk *clk)
 }
 
 /* Public data */
+#ifdef CONFIG_COMMON_CLK
+const struct clk_hw_omap_ops clkhwops_apll54 = {
+	.allow_idle	= _apll54_allow_idle,
+	.deny_idle	= _apll54_deny_idle,
+};
 
+const struct clk_hw_omap_ops clkhwops_apll96 = {
+	.allow_idle	= _apll96_allow_idle,
+	.deny_idle	= _apll96_deny_idle,
+};
+#else
 const struct clkops clkops_apll96 = {
 	.enable		= omap2_clk_apll96_enable,
 	.disable	= omap2_clk_apll_disable,
@@ -123,6 +173,7 @@ const struct clkops clkops_apll54 = {
 	.allow_idle	= _apll54_allow_idle,
 	.deny_idle	= _apll54_deny_idle,
 };
+#endif
 
 /* Public functions */
 
diff --git a/arch/arm/mach-omap2/clkt2xxx_dpll.c b/arch/arm/mach-omap2/clkt2xxx_dpll.c
index 1502a7b..a1f9915 100644
--- a/arch/arm/mach-omap2/clkt2xxx_dpll.c
+++ b/arch/arm/mach-omap2/clkt2xxx_dpll.c
@@ -31,7 +31,11 @@
  * REVISIT: DPLL can optionally enter low-power bypass by writing 0x1
  * instead.  Add some mechanism to optionally enter this mode.
  */
+#ifdef CONFIG_COMMON_CLK
+void _allow_idle(struct clk_hw_omap *clk)
+#else
 static void _allow_idle(struct clk *clk)
+#endif
 {
 	if (!clk || !clk->dpll_data)
 		return;
@@ -45,7 +49,11 @@ static void _allow_idle(struct clk *clk)
  *
  * Disable DPLL automatic idle control.  No return value.
  */
+#ifdef CONFIG_COMMON_CLK
+void _deny_idle(struct clk_hw_omap *clk)
+#else
 static void _deny_idle(struct clk *clk)
+#endif
 {
 	if (!clk || !clk->dpll_data)
 		return;
@@ -55,9 +63,15 @@ static void _deny_idle(struct clk *clk)
 
 
 /* Public data */
-
+#ifdef CONFIG_COMMON_CLK
+const struct clk_hw_omap_ops clkhwops_omap2xxx_dpll = {
+	.allow_idle	= _allow_idle,
+	.deny_idle	= _deny_idle,
+};
+#else
 const struct clkops clkops_omap2xxx_dpll_ops = {
 	.allow_idle	= _allow_idle,
 	.deny_idle	= _deny_idle,
 };
+#endif
 
diff --git a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
index 4ae4392..d5e9c94 100644
--- a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
+++ b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
@@ -47,7 +47,11 @@
  * struct clk *dpll_ck, which is a composite clock of dpll_ck and
  * core_ck.
  */
+#ifdef CONFIG_COMMON_CLK
+unsigned long omap2xxx_clk_get_core_rate(struct clk_hw_omap *clk)
+#else
 unsigned long omap2xxx_clk_get_core_rate(struct clk *clk)
+#endif
 {
 	long long core_clk;
 	u32 v;
@@ -98,19 +102,36 @@ static long omap2_dpllcore_round_rate(unsigned long target_rate)
 
 }
 
+#ifdef CONFIG_COMMON_CLK
+unsigned long omap2_dpllcore_recalc(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+#else
 unsigned long omap2_dpllcore_recalc(struct clk *clk)
 {
+#endif
 	return omap2xxx_clk_get_core_rate(clk);
 }
 
+#ifdef CONFIG_COMMON_CLK
+int omap2_reprogram_dpllcore(struct clk_hw *hw, unsigned long rate,
+					unsigned long parent_rate)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+#else
 int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
 {
+#endif
 	u32 cur_rate, low, mult, div, valid_rate, done_rate;
 	u32 bypass = 0;
 	struct prcm_config tmpset;
 	const struct dpll_data *dd;
 
+#ifdef CONFIG_COMMON_CLK
+	cur_rate = omap2xxx_clk_get_core_rate(to_clk_hw_omap(dclk_hw));
+#else
 	cur_rate = omap2xxx_clk_get_core_rate(dclk);
+#endif
 	mult = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
 	mult &= OMAP24XX_CORE_CLK_SRC_MASK;
 
diff --git a/arch/arm/mach-omap2/clkt2xxx_osc.c b/arch/arm/mach-omap2/clkt2xxx_osc.c
index c346092..3b1d13f 100644
--- a/arch/arm/mach-omap2/clkt2xxx_osc.c
+++ b/arch/arm/mach-omap2/clkt2xxx_osc.c
@@ -37,7 +37,11 @@
  * clk_enable/clk_disable()-based usecounting for osc_ck should be
  * replaced with autoidle-based usecounting.
  */
+#ifdef CONFIG_COMMON_CLK
+int omap2_enable_osc_ck(struct clk_hw *clk)
+#else
 static int omap2_enable_osc_ck(struct clk *clk)
+#endif
 {
 	u32 pcc;
 
@@ -55,7 +59,11 @@ static int omap2_enable_osc_ck(struct clk *clk)
  * clk_enable/clk_disable()-based usecounting for osc_ck should be
  * replaced with autoidle-based usecounting.
  */
+#ifdef CONFIG_COMMON_CLK
+void omap2_disable_osc_ck(struct clk_hw *clk)
+#else
 static void omap2_disable_osc_ck(struct clk *clk)
+#endif
 {
 	u32 pcc;
 
@@ -64,12 +72,18 @@ static void omap2_disable_osc_ck(struct clk *clk)
 	__raw_writel(pcc | OMAP_AUTOEXTCLKMODE_MASK, prcm_clksrc_ctrl);
 }
 
+#ifndef CONFIG_COMMON_CLK
 const struct clkops clkops_oscck = {
 	.enable		= omap2_enable_osc_ck,
 	.disable	= omap2_disable_osc_ck,
 };
+#endif
 
+#ifdef CONFIG_COMMON_CLK
+unsigned long omap2_osc_clk_recalc(struct clk_hw *clk, unsigned long parent_rate)
+#else
 unsigned long omap2_osc_clk_recalc(struct clk *clk)
+#endif
 {
 	return omap2xxx_get_apll_clkin() * omap2xxx_get_sysclkdiv();
 }
diff --git a/arch/arm/mach-omap2/clkt2xxx_sys.c b/arch/arm/mach-omap2/clkt2xxx_sys.c
index 8693cfd..12164a6 100644
--- a/arch/arm/mach-omap2/clkt2xxx_sys.c
+++ b/arch/arm/mach-omap2/clkt2xxx_sys.c
@@ -42,9 +42,15 @@ u32 omap2xxx_get_sysclkdiv(void)
 	return div;
 }
 
+#ifdef CONFIG_COMMON_CLK
+unsigned long omap2xxx_sys_clk_recalc(struct clk_hw *clk, unsigned long parent_rate)
+{
+	return parent_rate / omap2xxx_get_sysclkdiv();
+}
+#else
 unsigned long omap2xxx_sys_clk_recalc(struct clk *clk)
 {
 	return clk->parent->rate / omap2xxx_get_sysclkdiv();
 }
-
+#endif
 
diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index 3a27426..a0b2b28 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -53,7 +53,11 @@ const struct prcm_config *rate_table;
  *
  * Set virt_prcm_set's rate to the mpu_speed field of the current PRCM set.
  */
+#ifdef CONFIG_COMMON_CLK
+unsigned long omap2_table_mpu_recalc(struct clk_hw *clk, unsigned long parent_rate)
+#else
 unsigned long omap2_table_mpu_recalc(struct clk *clk)
+#endif
 {
 	return curr_prcm_set->mpu_speed;
 }
@@ -65,7 +69,12 @@ unsigned long omap2_table_mpu_recalc(struct clk *clk)
  * Some might argue L3-DDR, others ARM, others IVA. This code is simple and
  * just uses the ARM rates.
  */
+#ifdef CONFIG_COMMON_CLK
+long omap2_round_to_table_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long *parent_rate)
+#else
 long omap2_round_to_table_rate(struct clk *clk, unsigned long rate)
+#endif
 {
 	const struct prcm_config *ptr;
 	long highest_rate;
@@ -88,7 +97,12 @@ long omap2_round_to_table_rate(struct clk *clk, unsigned long rate)
 }
 
 /* Sets basic clocks based on the specified rate */
+#ifdef CONFIG_COMMON_CLK
+int omap2_select_table_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long parent_rate)
+#else
 int omap2_select_table_rate(struct clk *clk, unsigned long rate)
+#endif
 {
 	u32 cur_rate, done_rate, bypass = 0, tmp;
 	const struct prcm_config *prcm;
@@ -115,7 +129,11 @@ int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 	}
 
 	curr_prcm_set = prcm;
+#ifdef CONFIG_COMMON_CLK
+	cur_rate = omap2xxx_clk_get_core_rate(to_clk_hw_omap(dclk_hw));
+#else
 	cur_rate = omap2xxx_clk_get_core_rate(dclk);
+#endif
 
 	if (prcm->dpll_speed == cur_rate / 2) {
 		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL, 1);
diff --git a/arch/arm/mach-omap2/clock2430.c b/arch/arm/mach-omap2/clock2430.c
index dfda9a3..a629bc3 100644
--- a/arch/arm/mach-omap2/clock2430.c
+++ b/arch/arm/mach-omap2/clock2430.c
@@ -42,7 +42,11 @@
  * passes back the correct CM_IDLEST register address for I2CHS
  * modules.  No return value.
  */
+#ifdef CONFIG_COMMON_CLK
+static void omap2430_clk_i2chs_find_idlest(struct clk_hw_omap *clk,
+#else
 static void omap2430_clk_i2chs_find_idlest(struct clk *clk,
+#endif
 					   void __iomem **idlest_reg,
 					   u8 *idlest_bit,
 					   u8 *idlest_val)
@@ -53,9 +57,16 @@ static void omap2430_clk_i2chs_find_idlest(struct clk *clk,
 }
 
 /* 2430 I2CHS has non-standard IDLEST register */
+#ifdef CONFIG_COMMON_CLK
+const struct clk_hw_omap_ops clkhwops_omap2430_i2chs_wait = {
+	.find_idlest	= omap2430_clk_i2chs_find_idlest,
+	.find_companion	= omap2_clk_dflt_find_companion,
+};
+#else
 const struct clkops clkops_omap2430_i2chs_wait = {
 	.enable		= omap2_dflt_clk_enable,
 	.disable	= omap2_dflt_clk_disable,
 	.find_idlest	= omap2430_clk_i2chs_find_idlest,
 	.find_companion = omap2_clk_dflt_find_companion,
 };
+#endif
diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index 1250009..39a183b 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -31,6 +31,7 @@
 #include "cm-regbits-24xx.h"
 
 struct clk *vclk, *sclk, *dclk;
+struct clk_hw *dclk_hw;
 
 /*
  * Omap24xx specific clock functions
diff --git a/arch/arm/mach-omap2/clock2xxx.h b/arch/arm/mach-omap2/clock2xxx.h
index cb6df8c..73b4647 100644
--- a/arch/arm/mach-omap2/clock2xxx.h
+++ b/arch/arm/mach-omap2/clock2xxx.h
@@ -8,6 +8,20 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CLOCK2XXX_H
 #define __ARCH_ARM_MACH_OMAP2_CLOCK2XXX_H
 
+#ifdef CONFIG_COMMON_CLK
+#include <linux/clk-provider.h>
+#include "clock.h"
+
+unsigned long omap2_table_mpu_recalc(struct clk_hw *clk, unsigned long parent_rate);
+int omap2_select_table_rate(struct clk_hw *hw, unsigned long rate, unsigned long parent_rate);
+long omap2_round_to_table_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *parent_rate);
+unsigned long omap2xxx_sys_clk_recalc(struct clk_hw *clk, unsigned long parent_rate);
+unsigned long omap2_osc_clk_recalc(struct clk_hw *clk, unsigned long parent_rate);
+unsigned long omap2_dpllcore_recalc(struct clk_hw *hw, unsigned long parent_rate);
+int omap2_reprogram_dpllcore(struct clk_hw *clk, unsigned long rate, unsigned long parent_rate);
+unsigned long omap2xxx_clk_get_core_rate(struct clk_hw_omap *clk);
+#else
 unsigned long omap2_table_mpu_recalc(struct clk *clk);
 int omap2_select_table_rate(struct clk *clk, unsigned long rate);
 long omap2_round_to_table_rate(struct clk *clk, unsigned long rate);
@@ -16,6 +30,7 @@ unsigned long omap2_osc_clk_recalc(struct clk *clk);
 unsigned long omap2_dpllcore_recalc(struct clk *clk);
 int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate);
 unsigned long omap2xxx_clk_get_core_rate(struct clk *clk);
+#endif
 u32 omap2xxx_get_apll_clkin(void);
 u32 omap2xxx_get_sysclkdiv(void);
 void omap2xxx_clk_prepare_for_reboot(void);
@@ -36,9 +51,24 @@ extern void __iomem *prcm_clksrc_ctrl, *cm_idlest_pll;
 
 extern struct clk *dclk;
 
+#ifdef CONFIG_COMMON_CLK
+extern struct clk_hw *dclk_hw;
+int omap2_enable_osc_ck(struct clk_hw *hw);
+void omap2_disable_osc_ck(struct clk_hw *hw);
+int omap2_clk_apll96_enable(struct clk_hw *hw);
+int omap2_clk_apll54_enable(struct clk_hw *hw);
+void _apll96_allow_idle(struct clk_hw_omap *hw);
+void _apll96_deny_idle(struct clk_hw_omap *hw);
+void _apll54_allow_idle(struct clk_hw_omap *hw);
+void _apll54_deny_idle(struct clk_hw_omap *hw);
+void omap2_clk_apll_disable(struct clk_hw *hw);
+void _allow_idle(struct clk_hw_omap *hw);
+void _deny_idle(struct clk_hw_omap *hw);
+#else
 extern const struct clkops clkops_omap2430_i2chs_wait;
 extern const struct clkops clkops_oscck;
 extern const struct clkops clkops_apll96;
 extern const struct clkops clkops_apll54;
+#endif
 
 #endif
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index be50b88..a1872b3 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -25,7 +25,11 @@
 #include <linux/sysfs.h>
 #include <linux/module.h>
 #include <linux/delay.h>
+#ifdef CONFIG_COMMON_CLK
+#include <linux/clk-provider.h>
+#else
 #include <linux/clk.h>
+#endif
 #include <linux/irq.h>
 #include <linux/time.h>
 #include <linux/gpio.h>
@@ -202,7 +206,11 @@ static int omap2_can_sleep(void)
 {
 	if (omap2_fclks_active())
 		return 0;
+#ifdef CONFIG_COMMON_CLK
+	if (__clk_is_enabled(osc_ck))
+#else
 	if (osc_ck->usecount > 1)
+#endif
 		return 0;
 	if (omap_dma_running())
 		return 0;
-- 
1.7.1

