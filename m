From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 23/26] ARM: omap2: clock: Cleanup !CONFIG_COMMON_CLK parts
Date: Wed, 7 Nov 2012 17:12:58 -0800
Message-ID: <1352337181-29427-24-git-send-email-mturquette@ti.com>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36705 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620Ab2KHBNt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 20:13:49 -0500
In-Reply-To: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org, patches@linaro.org, Mike Turquette <mturquette@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Clean all #ifdef's added to OMAP2 clock code to make it COMMON clk
ready, not that CONFIG_COMMON_CLK is enabled.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
[paul@pwsan.com: also drop CONFIG_COMMON_CLK tests around APLL recalc_rate
 functions]
Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/clkt2xxx_apll.c          |   58 --------------------------
 arch/arm/mach-omap2/clkt2xxx_dpll.c          |   16 -------
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c      |   18 --------
 arch/arm/mach-omap2/clkt2xxx_osc.c           |   20 ---------
 arch/arm/mach-omap2/clkt2xxx_sys.c           |    8 ----
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |   16 -------
 arch/arm/mach-omap2/clock2430.c              |   13 ------
 arch/arm/mach-omap2/clock2xxx.h              |   19 ---------
 arch/arm/mach-omap2/pm24xx.c                 |    8 ----
 9 files changed, 176 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt2xxx_apll.c b/arch/arm/mach-omap2/clkt2xxx_apll.c
index d8a850b..225da8a 100644
--- a/arch/arm/mach-omap2/clkt2xxx_apll.c
+++ b/arch/arm/mach-omap2/clkt2xxx_apll.c
@@ -41,7 +41,6 @@ void __iomem *cm_idlest_pll;
 
 /* Private functions */
 
-#ifdef CONFIG_COMMON_CLK
 /**
  * omap2xxx_clk_apll_locked - is the APLL locked?
  * @hw: struct clk_hw * of the APLL to check
@@ -60,17 +59,11 @@ static bool omap2xxx_clk_apll_locked(struct clk_hw *hw)
 
 	return ((r & apll_mask) == apll_mask) ? true : false;
 }
-#endif
 
 /* Enable an APLL if off */
-#ifdef CONFIG_COMMON_CLK
 static int omap2_clk_apll_enable(struct clk_hw *hw, u32 status_mask)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-#else
-static int omap2_clk_apll_enable(struct clk *clk, u32 status_mask)
-{
-#endif
 	u32 cval, apll_mask;
 
 	apll_mask = EN_APLL_LOCKED << clk->enable_bit;
@@ -85,11 +78,7 @@ static int omap2_clk_apll_enable(struct clk *clk, u32 status_mask)
 	omap2_cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
 
 	omap2_cm_wait_idlest(cm_idlest_pll, status_mask,
-#ifdef CONFIG_COMMON_CLK
 			     OMAP24XX_CM_IDLEST_VAL, __clk_get_name(hw->clk));
-#else
-			     OMAP24XX_CM_IDLEST_VAL, __clk_get_name(clk));
-#endif
 
 	/*
 	 * REVISIT: Should we return an error code if omap2_wait_clock_ready()
@@ -98,69 +87,40 @@ static int omap2_clk_apll_enable(struct clk *clk, u32 status_mask)
 	return 0;
 }
 
-#ifdef CONFIG_COMMON_CLK
 int omap2_clk_apll96_enable(struct clk_hw *clk)
-#else
-static int omap2_clk_apll96_enable(struct clk *clk)
-#endif
 {
 	return omap2_clk_apll_enable(clk, OMAP24XX_ST_96M_APLL_MASK);
 }
 
-#ifdef CONFIG_COMMON_CLK
 int omap2_clk_apll54_enable(struct clk_hw *clk)
-#else
-static int omap2_clk_apll54_enable(struct clk *clk)
-#endif
 {
 	return omap2_clk_apll_enable(clk, OMAP24XX_ST_54M_APLL_MASK);
 }
 
-#ifdef CONFIG_COMMON_CLK
 void _apll96_allow_idle(struct clk_hw_omap *clk)
-#else
-static void _apll96_allow_idle(struct clk *clk)
-#endif
 {
 	omap2xxx_cm_set_apll96_auto_low_power_stop();
 }
 
-#ifdef CONFIG_COMMON_CLK
 void _apll96_deny_idle(struct clk_hw_omap *clk)
-#else
-static void _apll96_deny_idle(struct clk *clk)
-#endif
 {
 	omap2xxx_cm_set_apll96_disable_autoidle();
 }
 
-#ifdef CONFIG_COMMON_CLK
 void _apll54_allow_idle(struct clk_hw_omap *clk)
-#else
-static void _apll54_allow_idle(struct clk *clk)
-#endif
 {
 	omap2xxx_cm_set_apll54_auto_low_power_stop();
 }
 
-#ifdef CONFIG_COMMON_CLK
 void _apll54_deny_idle(struct clk_hw_omap *clk)
-#else
-static void _apll54_deny_idle(struct clk *clk)
-#endif
 {
 	omap2xxx_cm_set_apll54_disable_autoidle();
 }
 
 /* Stop APLL */
-#ifdef CONFIG_COMMON_CLK
 void omap2_clk_apll_disable(struct clk_hw *hw)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-#else
-static void omap2_clk_apll_disable(struct clk *clk)
-{
-#endif
 	u32 cval;
 
 	cval = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKEN);
@@ -168,7 +128,6 @@ static void omap2_clk_apll_disable(struct clk *clk)
 	omap2_cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
 }
 
-#ifdef CONFIG_COMMON_CLK
 unsigned long omap2_clk_apll54_recalc(struct clk_hw *hw,
 				      unsigned long parent_rate)
 {
@@ -180,10 +139,8 @@ unsigned long omap2_clk_apll96_recalc(struct clk_hw *hw,
 {
 	return (omap2xxx_clk_apll_locked(hw)) ? 96000000 : 0;
 }
-#endif
 
 /* Public data */
-#ifdef CONFIG_COMMON_CLK
 const struct clk_hw_omap_ops clkhwops_apll54 = {
 	.allow_idle	= _apll54_allow_idle,
 	.deny_idle	= _apll54_deny_idle,
@@ -193,21 +150,6 @@ const struct clk_hw_omap_ops clkhwops_apll96 = {
 	.allow_idle	= _apll96_allow_idle,
 	.deny_idle	= _apll96_deny_idle,
 };
-#else
-const struct clkops clkops_apll96 = {
-	.enable		= omap2_clk_apll96_enable,
-	.disable	= omap2_clk_apll_disable,
-	.allow_idle	= _apll96_allow_idle,
-	.deny_idle	= _apll96_deny_idle,
-};
-
-const struct clkops clkops_apll54 = {
-	.enable		= omap2_clk_apll54_enable,
-	.disable	= omap2_clk_apll_disable,
-	.allow_idle	= _apll54_allow_idle,
-	.deny_idle	= _apll54_deny_idle,
-};
-#endif
 
 /* Public functions */
 
diff --git a/arch/arm/mach-omap2/clkt2xxx_dpll.c b/arch/arm/mach-omap2/clkt2xxx_dpll.c
index bbbf032..58931c4 100644
--- a/arch/arm/mach-omap2/clkt2xxx_dpll.c
+++ b/arch/arm/mach-omap2/clkt2xxx_dpll.c
@@ -29,11 +29,7 @@
  * REVISIT: DPLL can optionally enter low-power bypass by writing 0x1
  * instead.  Add some mechanism to optionally enter this mode.
  */
-#ifdef CONFIG_COMMON_CLK
 void _allow_idle(struct clk_hw_omap *clk)
-#else
-static void _allow_idle(struct clk *clk)
-#endif
 {
 	if (!clk || !clk->dpll_data)
 		return;
@@ -47,11 +43,7 @@ static void _allow_idle(struct clk *clk)
  *
  * Disable DPLL automatic idle control.  No return value.
  */
-#ifdef CONFIG_COMMON_CLK
 void _deny_idle(struct clk_hw_omap *clk)
-#else
-static void _deny_idle(struct clk *clk)
-#endif
 {
 	if (!clk || !clk->dpll_data)
 		return;
@@ -61,15 +53,7 @@ static void _deny_idle(struct clk *clk)
 
 
 /* Public data */
-#ifdef CONFIG_COMMON_CLK
 const struct clk_hw_omap_ops clkhwops_omap2xxx_dpll = {
 	.allow_idle	= _allow_idle,
 	.deny_idle	= _deny_idle,
 };
-#else
-const struct clkops clkops_omap2xxx_dpll_ops = {
-	.allow_idle	= _allow_idle,
-	.deny_idle	= _deny_idle,
-};
-#endif
-
diff --git a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
index fb26e2f..54be803 100644
--- a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
+++ b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
@@ -46,11 +46,7 @@
  * struct clk *dpll_ck, which is a composite clock of dpll_ck and
  * core_ck.
  */
-#ifdef CONFIG_COMMON_CLK
 unsigned long omap2xxx_clk_get_core_rate(struct clk_hw_omap *clk)
-#else
-unsigned long omap2xxx_clk_get_core_rate(struct clk *clk)
-#endif
 {
 	long long core_clk;
 	u32 v;
@@ -101,37 +97,23 @@ static long omap2_dpllcore_round_rate(unsigned long target_rate)
 
 }
 
-#ifdef CONFIG_COMMON_CLK
 unsigned long omap2_dpllcore_recalc(struct clk_hw *hw,
 				    unsigned long parent_rate)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-#else
-unsigned long omap2_dpllcore_recalc(struct clk *clk)
-{
-#endif
 	return omap2xxx_clk_get_core_rate(clk);
 }
 
-#ifdef CONFIG_COMMON_CLK
 int omap2_reprogram_dpllcore(struct clk_hw *hw, unsigned long rate,
 			     unsigned long parent_rate)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-#else
-int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
-{
-#endif
 	u32 cur_rate, low, mult, div, valid_rate, done_rate;
 	u32 bypass = 0;
 	struct prcm_config tmpset;
 	const struct dpll_data *dd;
 
-#ifdef CONFIG_COMMON_CLK
 	cur_rate = omap2xxx_clk_get_core_rate(to_clk_hw_omap(dclk_hw));
-#else
-	cur_rate = omap2xxx_clk_get_core_rate(dclk);
-#endif
 	mult = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
 	mult &= OMAP24XX_CORE_CLK_SRC_MASK;
 
diff --git a/arch/arm/mach-omap2/clkt2xxx_osc.c b/arch/arm/mach-omap2/clkt2xxx_osc.c
index 395e0c1..19f54d4 100644
--- a/arch/arm/mach-omap2/clkt2xxx_osc.c
+++ b/arch/arm/mach-omap2/clkt2xxx_osc.c
@@ -35,11 +35,7 @@
  * clk_enable/clk_disable()-based usecounting for osc_ck should be
  * replaced with autoidle-based usecounting.
  */
-#ifdef CONFIG_COMMON_CLK
 int omap2_enable_osc_ck(struct clk_hw *clk)
-#else
-static int omap2_enable_osc_ck(struct clk *clk)
-#endif
 {
 	u32 pcc;
 
@@ -57,11 +53,7 @@ static int omap2_enable_osc_ck(struct clk *clk)
  * clk_enable/clk_disable()-based usecounting for osc_ck should be
  * replaced with autoidle-based usecounting.
  */
-#ifdef CONFIG_COMMON_CLK
 void omap2_disable_osc_ck(struct clk_hw *clk)
-#else
-static void omap2_disable_osc_ck(struct clk *clk)
-#endif
 {
 	u32 pcc;
 
@@ -70,20 +62,8 @@ static void omap2_disable_osc_ck(struct clk *clk)
 	__raw_writel(pcc | OMAP_AUTOEXTCLKMODE_MASK, prcm_clksrc_ctrl);
 }
 
-#ifndef CONFIG_COMMON_CLK
-const struct clkops clkops_oscck = {
-	.enable		= omap2_enable_osc_ck,
-	.disable	= omap2_disable_osc_ck,
-};
-#endif
-
-#ifdef CONFIG_COMMON_CLK
 unsigned long omap2_osc_clk_recalc(struct clk_hw *clk,
 				   unsigned long parent_rate)
-#else
-unsigned long omap2_osc_clk_recalc(struct clk *clk)
-#endif
 {
 	return omap2xxx_get_apll_clkin() * omap2xxx_get_sysclkdiv();
 }
-
diff --git a/arch/arm/mach-omap2/clkt2xxx_sys.c b/arch/arm/mach-omap2/clkt2xxx_sys.c
index e6e73cf..f467d07 100644
--- a/arch/arm/mach-omap2/clkt2xxx_sys.c
+++ b/arch/arm/mach-omap2/clkt2xxx_sys.c
@@ -40,16 +40,8 @@ u32 omap2xxx_get_sysclkdiv(void)
 	return div;
 }
 
-#ifdef CONFIG_COMMON_CLK
 unsigned long omap2xxx_sys_clk_recalc(struct clk_hw *clk,
 				      unsigned long parent_rate)
 {
 	return parent_rate / omap2xxx_get_sysclkdiv();
 }
-#else
-unsigned long omap2xxx_sys_clk_recalc(struct clk *clk)
-{
-	return clk->parent->rate / omap2xxx_get_sysclkdiv();
-}
-#endif
-
diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index 23456a8..5055e2b 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -52,12 +52,8 @@ const struct prcm_config *rate_table;
  *
  * Set virt_prcm_set's rate to the mpu_speed field of the current PRCM set.
  */
-#ifdef CONFIG_COMMON_CLK
 unsigned long omap2_table_mpu_recalc(struct clk_hw *clk,
 				     unsigned long parent_rate)
-#else
-unsigned long omap2_table_mpu_recalc(struct clk *clk)
-#endif
 {
 	return curr_prcm_set->mpu_speed;
 }
@@ -69,12 +65,8 @@ unsigned long omap2_table_mpu_recalc(struct clk *clk)
  * Some might argue L3-DDR, others ARM, others IVA. This code is simple and
  * just uses the ARM rates.
  */
-#ifdef CONFIG_COMMON_CLK
 long omap2_round_to_table_rate(struct clk_hw *hw, unsigned long rate,
 			       unsigned long *parent_rate)
-#else
-long omap2_round_to_table_rate(struct clk *clk, unsigned long rate)
-#endif
 {
 	const struct prcm_config *ptr;
 	long highest_rate, sys_clk_rate;
@@ -98,12 +90,8 @@ long omap2_round_to_table_rate(struct clk *clk, unsigned long rate)
 }
 
 /* Sets basic clocks based on the specified rate */
-#ifdef CONFIG_COMMON_CLK
 int omap2_select_table_rate(struct clk_hw *hw, unsigned long rate,
 			    unsigned long parent_rate)
-#else
-int omap2_select_table_rate(struct clk *clk, unsigned long rate)
-#endif
 {
 	u32 cur_rate, done_rate, bypass = 0, tmp;
 	const struct prcm_config *prcm;
@@ -133,11 +121,7 @@ int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 	}
 
 	curr_prcm_set = prcm;
-#ifdef CONFIG_COMMON_CLK
 	cur_rate = omap2xxx_clk_get_core_rate(to_clk_hw_omap(dclk_hw));
-#else
-	cur_rate = omap2xxx_clk_get_core_rate(dclk);
-#endif
 
 	if (prcm->dpll_speed == cur_rate / 2) {
 		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL, 1);
diff --git a/arch/arm/mach-omap2/clock2430.c b/arch/arm/mach-omap2/clock2430.c
index 7a61d78..cef0c8d 100644
--- a/arch/arm/mach-omap2/clock2430.c
+++ b/arch/arm/mach-omap2/clock2430.c
@@ -40,11 +40,7 @@
  * passes back the correct CM_IDLEST register address for I2CHS
  * modules.  No return value.
  */
-#ifdef CONFIG_COMMON_CLK
 static void omap2430_clk_i2chs_find_idlest(struct clk_hw_omap *clk,
-#else
-static void omap2430_clk_i2chs_find_idlest(struct clk *clk,
-#endif
 					   void __iomem **idlest_reg,
 					   u8 *idlest_bit,
 					   u8 *idlest_val)
@@ -55,16 +51,7 @@ static void omap2430_clk_i2chs_find_idlest(struct clk *clk,
 }
 
 /* 2430 I2CHS has non-standard IDLEST register */
-#ifdef CONFIG_COMMON_CLK
 const struct clk_hw_omap_ops clkhwops_omap2430_i2chs_wait = {
 	.find_idlest	= omap2430_clk_i2chs_find_idlest,
 	.find_companion	= omap2_clk_dflt_find_companion,
 };
-#else
-const struct clkops clkops_omap2430_i2chs_wait = {
-	.enable		= omap2_dflt_clk_enable,
-	.disable	= omap2_dflt_clk_disable,
-	.find_idlest	= omap2430_clk_i2chs_find_idlest,
-	.find_companion = omap2_clk_dflt_find_companion,
-};
-#endif
diff --git a/arch/arm/mach-omap2/clock2xxx.h b/arch/arm/mach-omap2/clock2xxx.h
index f2b93e3..7b8ae61 100644
--- a/arch/arm/mach-omap2/clock2xxx.h
+++ b/arch/arm/mach-omap2/clock2xxx.h
@@ -8,7 +8,6 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CLOCK2XXX_H
 #define __ARCH_ARM_MACH_OMAP2_CLOCK2XXX_H
 
-#ifdef CONFIG_COMMON_CLK
 #include <linux/clk-provider.h>
 #include "clock.h"
 
@@ -31,16 +30,6 @@ unsigned long omap2_clk_apll54_recalc(struct clk_hw *hw,
 				      unsigned long parent_rate);
 unsigned long omap2_clk_apll96_recalc(struct clk_hw *hw,
 				      unsigned long parent_rate);
-#else
-unsigned long omap2_table_mpu_recalc(struct clk *clk);
-int omap2_select_table_rate(struct clk *clk, unsigned long rate);
-long omap2_round_to_table_rate(struct clk *clk, unsigned long rate);
-unsigned long omap2xxx_sys_clk_recalc(struct clk *clk);
-unsigned long omap2_osc_clk_recalc(struct clk *clk);
-unsigned long omap2_dpllcore_recalc(struct clk *clk);
-int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate);
-unsigned long omap2xxx_clk_get_core_rate(struct clk *clk);
-#endif
 u32 omap2xxx_get_apll_clkin(void);
 u32 omap2xxx_get_sysclkdiv(void);
 void omap2xxx_clk_prepare_for_reboot(void);
@@ -60,8 +49,6 @@ int omap2430_clk_init(void);
 extern void __iomem *prcm_clksrc_ctrl, *cm_idlest_pll;
 
 extern struct clk *dclk;
-
-#ifdef CONFIG_COMMON_CLK
 extern struct clk_hw *dclk_hw;
 int omap2_enable_osc_ck(struct clk_hw *hw);
 void omap2_disable_osc_ck(struct clk_hw *hw);
@@ -74,11 +61,5 @@ void _apll54_deny_idle(struct clk_hw_omap *hw);
 void omap2_clk_apll_disable(struct clk_hw *hw);
 void _allow_idle(struct clk_hw_omap *hw);
 void _deny_idle(struct clk_hw_omap *hw);
-#else
-extern const struct clkops clkops_omap2430_i2chs_wait;
-extern const struct clkops clkops_oscck;
-extern const struct clkops clkops_apll96;
-extern const struct clkops clkops_apll54;
-#endif
 
 #endif
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 87ae36c..3d35bd6 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -25,11 +25,7 @@
 #include <linux/sysfs.h>
 #include <linux/module.h>
 #include <linux/delay.h>
-#ifdef CONFIG_COMMON_CLK
 #include <linux/clk-provider.h>
-#else
-#include <linux/clk.h>
-#endif
 #include <linux/irq.h>
 #include <linux/time.h>
 #include <linux/gpio.h>
@@ -206,11 +202,7 @@ static int omap2_can_sleep(void)
 {
 	if (omap2_fclks_active())
 		return 0;
-#ifdef CONFIG_COMMON_CLK
 	if (__clk_is_enabled(osc_ck))
-#else
-	if (osc_ck->usecount > 1)
-#endif
 		return 0;
 	if (omap_dma_running())
 		return 0;
-- 
1.7.9.5

