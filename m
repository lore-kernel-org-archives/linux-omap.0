From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 20/24] ARM: omap3: clk: Cleanup !CONFIG_COMMON_CLK parts
Date: Fri, 1 Jun 2012 17:38:01 +0530
Message-ID: <1338552485-31325-21-git-send-email-rnayak@ti.com>
References: <1338552485-31325-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54082 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759528Ab2FAMJB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jun 2012 08:09:01 -0400
In-Reply-To: <1338552485-31325-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mturquette@ti.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Clean all #ifdef's added to OMAP3 clock code to make it COMMON clk
ready, now that CONFIG_COMMON_CLK is enabled.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c |   13 ------
 arch/arm/mach-omap2/clock.h            |   16 -------
 arch/arm/mach-omap2/clock34xx.c        |   68 +-------------------------------
 arch/arm/mach-omap2/clock3517.c        |   34 +---------------
 arch/arm/mach-omap2/clock36xx.c        |   19 ---------
 arch/arm/mach-omap2/clock36xx.h        |    4 --
 arch/arm/mach-omap2/clock3xxx.c        |    8 ----
 arch/arm/mach-omap2/clock3xxx.h        |    5 --
 8 files changed, 3 insertions(+), 164 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
index 74cc4ed..df266c7 100644
--- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
+++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
@@ -46,15 +46,10 @@
  * Program the DPLL M2 divider with the rounded target rate.  Returns
  * -EINVAL upon error, or 0 upon success.
  */
-#ifdef CONFIG_COMMON_CLK
 int omap3_core_dpll_m2_set_rate(struct clk_hw *hw, unsigned long rate,
 					unsigned long parent_rate)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-#else
-int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
-{
-#endif
 	u32 new_div = 0;
 	u32 unlock_dll = 0;
 	u32 c;
@@ -72,11 +67,7 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 		return -EINVAL;
 
 	sdrcrate = __clk_get_rate(sdrc_ick_p);
-#ifdef CONFIG_COMMON_CLK
 	clkrate = __clk_get_rate(hw->clk);
-#else
-	clkrate = __clk_get_rate(clk);
-#endif
 	if (rate > clkrate)
 		sdrcrate <<= ((rate / clkrate) >> 1);
 	else
@@ -127,10 +118,6 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 				  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
 				  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
 				  0, 0, 0, 0);
-#ifndef CONFIG_COMMON_CLK
-	clk->rate = rate;
-#endif
-
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index b2e73aa..1bd4505 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -330,13 +330,8 @@ int omap2_clksel_set_rate(struct clk_hw *hw, unsigned long rate,
 int omap2_clksel_set_parent(struct clk_hw *hw, u8 field_val);
 
 /* clkt_iclk.c public functions */
-#ifdef CONFIG_COMMON_CLK
 extern void omap2_clkt_iclk_allow_idle(struct clk_hw_omap *clk);
 extern void omap2_clkt_iclk_deny_idle(struct clk_hw_omap *clk);
-#else
-extern void omap2_clkt_iclk_allow_idle(struct clk *clk);
-extern void omap2_clkt_iclk_deny_idle(struct clk *clk);
-#endif
 
 u8 omap2_init_dpll_parent(struct clk_hw *hw);
 unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk);
@@ -398,7 +393,6 @@ extern const struct clksel_rate gfx_l3_rates[];
 extern const struct clksel_rate dsp_ick_rates[];
 extern struct clk dummy_ck;
 
-#ifdef CONFIG_COMMON_CLK
 extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
 extern const struct clk_hw_omap_ops clkhwops_iclk_wait;
 extern const struct clk_hw_omap_ops clkhwops_wait;
@@ -416,15 +410,5 @@ extern const struct clk_hw_omap_ops clkhwops_apll54;
 extern const struct clk_hw_omap_ops clkhwops_apll96;
 extern const struct clk_hw_omap_ops clkhwops_omap2xxx_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap2430_i2chs_wait;
-#else
-extern const struct clkops clkops_omap2_iclk_dflt_wait;
-extern const struct clkops clkops_omap2_iclk_dflt;
-extern const struct clkops clkops_omap2_iclk_idle_only;
-extern const struct clkops clkops_omap2_mdmclk_dflt_wait;
-extern const struct clkops clkops_omap2xxx_dpll_ops;
-extern const struct clkops clkops_omap3_noncore_dpll_ops;
-extern const struct clkops clkops_omap3_core_dpll_ops;
-extern const struct clkops clkops_omap4_dpllmx_ops;
-#endif /* CONFIG_COMMON_CLK */
 
 #endif
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 16da66e..4f6700d 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -37,11 +37,7 @@
  * from the CM_{I,F}CLKEN bit.  Pass back the correct info via
  * @idlest_reg and @idlest_bit.  No return value.
  */
-#ifdef CONFIG_COMMON_CLK
 static void omap3430es2_clk_ssi_find_idlest(struct clk_hw_omap *clk,
-#else
-static void omap3430es2_clk_ssi_find_idlest(struct clk *clk,
-#endif
 					    void __iomem **idlest_reg,
 					    u8 *idlest_bit,
 					    u8 *idlest_val)
@@ -53,7 +49,6 @@ static void omap3430es2_clk_ssi_find_idlest(struct clk *clk,
 	*idlest_bit = OMAP3430ES2_ST_SSI_IDLE_SHIFT;
 	*idlest_val = OMAP34XX_CM_IDLEST_VAL;
 }
-#ifdef CONFIG_COMMON_CLK
 const struct clk_hw_omap_ops clkhwops_omap3430es2_ssi_wait = {
 	.find_idlest	= omap3430es2_clk_ssi_find_idlest,
 	.find_companion	= omap2_clk_dflt_find_companion,
@@ -65,23 +60,6 @@ const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_ssi_wait = {
 	.find_idlest	= omap3430es2_clk_ssi_find_idlest,
 	.find_companion = omap2_clk_dflt_find_companion,
 };
-#else
-const struct clkops clkops_omap3430es2_ssi_wait = {
-	.enable		= omap2_dflt_clk_enable,
-	.disable	= omap2_dflt_clk_disable,
-	.find_idlest	= omap3430es2_clk_ssi_find_idlest,
-	.find_companion = omap2_clk_dflt_find_companion,
-};
-
-const struct clkops clkops_omap3430es2_iclk_ssi_wait = {
-	.enable		= omap2_dflt_clk_enable,
-	.disable	= omap2_dflt_clk_disable,
-	.find_idlest	= omap3430es2_clk_ssi_find_idlest,
-	.find_companion = omap2_clk_dflt_find_companion,
-	.allow_idle	= omap2_clkt_iclk_allow_idle,
-	.deny_idle	= omap2_clkt_iclk_deny_idle,
-};
-#endif
 
 /**
  * omap3430es2_clk_dss_usbhost_find_idlest - CM_IDLEST info for DSS, USBHOST
@@ -97,11 +75,7 @@ const struct clkops clkops_omap3430es2_iclk_ssi_wait = {
  * default find_idlest code assumes that they are at the same
  * position.)  No return value.
  */
-#ifdef CONFIG_COMMON_CLK
 static void omap3430es2_clk_dss_usbhost_find_idlest(struct clk_hw_omap *clk,
-#else
-static void omap3430es2_clk_dss_usbhost_find_idlest(struct clk *clk,
-#endif
 						    void __iomem **idlest_reg,
 						    u8 *idlest_bit,
 						    u8 *idlest_val)
@@ -114,7 +88,7 @@ static void omap3430es2_clk_dss_usbhost_find_idlest(struct clk *clk,
 	*idlest_bit = OMAP3430ES2_ST_DSS_IDLE_SHIFT;
 	*idlest_val = OMAP34XX_CM_IDLEST_VAL;
 }
-#ifdef CONFIG_COMMON_CLK
+
 const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_wait = {
 	.find_idlest	= omap3430es2_clk_dss_usbhost_find_idlest,
 	.find_companion	= omap2_clk_dflt_find_companion,
@@ -126,23 +100,6 @@ const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_dss_usbhost_wait = {
 	.find_idlest	= omap3430es2_clk_dss_usbhost_find_idlest,
 	.find_companion	= omap2_clk_dflt_find_companion,
 };
-#else
-const struct clkops clkops_omap3430es2_dss_usbhost_wait = {
-	.enable		= omap2_dflt_clk_enable,
-	.disable	= omap2_dflt_clk_disable,
-	.find_idlest	= omap3430es2_clk_dss_usbhost_find_idlest,
-	.find_companion = omap2_clk_dflt_find_companion,
-};
-
-const struct clkops clkops_omap3430es2_iclk_dss_usbhost_wait = {
-	.enable		= omap2_dflt_clk_enable,
-	.disable	= omap2_dflt_clk_disable,
-	.find_idlest	= omap3430es2_clk_dss_usbhost_find_idlest,
-	.find_companion = omap2_clk_dflt_find_companion,
-	.allow_idle	= omap2_clkt_iclk_allow_idle,
-	.deny_idle	= omap2_clkt_iclk_deny_idle,
-};
-#endif
 
 /**
  * omap3430es2_clk_hsotgusb_find_idlest - return CM_IDLEST info for HSOTGUSB
@@ -155,11 +112,7 @@ const struct clkops clkops_omap3430es2_iclk_dss_usbhost_wait = {
  * shift from the CM_{I,F}CLKEN bit.  Pass back the correct info via
  * @idlest_reg and @idlest_bit.  No return value.
  */
-#ifdef CONFIG_COMMON_CLK
 static void omap3430es2_clk_hsotgusb_find_idlest(struct clk_hw_omap *clk,
-#else
-static void omap3430es2_clk_hsotgusb_find_idlest(struct clk *clk,
-#endif
 						 void __iomem **idlest_reg,
 						 u8 *idlest_bit,
 						 u8 *idlest_val)
@@ -171,7 +124,7 @@ static void omap3430es2_clk_hsotgusb_find_idlest(struct clk *clk,
 	*idlest_bit = OMAP3430ES2_ST_HSOTGUSB_IDLE_SHIFT;
 	*idlest_val = OMAP34XX_CM_IDLEST_VAL;
 }
-#ifdef CONFIG_COMMON_CLK
+
 const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_hsotgusb_wait = {
 	.allow_idle	= omap2_clkt_iclk_allow_idle,
 	.deny_idle	= omap2_clkt_iclk_deny_idle,
@@ -183,20 +136,3 @@ const struct clk_hw_omap_ops clkhwops_omap3430es2_hsotgusb_wait = {
 	.find_idlest	= omap3430es2_clk_hsotgusb_find_idlest,
 	.find_companion	= omap2_clk_dflt_find_companion,
 };
-#else
-const struct clkops clkops_omap3430es2_hsotgusb_wait = {
-	.enable		= omap2_dflt_clk_enable,
-	.disable	= omap2_dflt_clk_disable,
-	.find_idlest	= omap3430es2_clk_hsotgusb_find_idlest,
-	.find_companion = omap2_clk_dflt_find_companion,
-};
-
-const struct clkops clkops_omap3430es2_iclk_hsotgusb_wait = {
-	.enable		= omap2_dflt_clk_enable,
-	.disable	= omap2_dflt_clk_disable,
-	.find_idlest	= omap3430es2_clk_hsotgusb_find_idlest,
-	.find_companion = omap2_clk_dflt_find_companion,
-	.allow_idle	= omap2_clkt_iclk_allow_idle,
-	.deny_idle	= omap2_clkt_iclk_deny_idle,
-};
-#endif
diff --git a/arch/arm/mach-omap2/clock3517.c b/arch/arm/mach-omap2/clock3517.c
index 07cb9e2..9f91c68 100644
--- a/arch/arm/mach-omap2/clock3517.c
+++ b/arch/arm/mach-omap2/clock3517.c
@@ -47,11 +47,7 @@
  * in the enable register itsel at a bit offset of 4 from the enable
  * bit. A value of 1 indicates that clock is enabled.
  */
-#ifdef CONFIG_COMMON_CLK
 static void am35xx_clk_find_idlest(struct clk_hw_omap *clk,
-#else
-static void am35xx_clk_find_idlest(struct clk *clk,
-#endif
 					    void __iomem **idlest_reg,
 					    u8 *idlest_bit,
 					    u8 *idlest_val)
@@ -75,11 +71,7 @@ static void am35xx_clk_find_idlest(struct clk *clk,
  * associate this type of code with per-module data structures to
  * avoid this issue, and remove the casts.  No return value.
  */
-#ifdef CONFIG_COMMON_CLK
 static void am35xx_clk_find_companion(struct clk_hw_omap *clk, void __iomem **other_reg,
-#else
-static void am35xx_clk_find_companion(struct clk *clk, void __iomem **other_reg,
-#endif
 					    u8 *other_bit)
 {
 	*other_reg = (__force void __iomem *)(clk->enable_reg);
@@ -88,19 +80,10 @@ static void am35xx_clk_find_companion(struct clk *clk, void __iomem **other_reg,
 	else
 		*other_bit = clk->enable_bit - AM35XX_IPSS_ICK_FCK_OFFSET;
 }
-#ifdef CONFIG_COMMON_CLK
 const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait = {
 	.find_idlest	= am35xx_clk_find_idlest,
 	.find_companion	= am35xx_clk_find_companion,
 };
-#else
-const struct clkops clkops_am35xx_ipss_module_wait = {
-	.enable		= omap2_dflt_clk_enable,
-	.disable	= omap2_dflt_clk_disable,
-	.find_idlest	= am35xx_clk_find_idlest,
-	.find_companion	= am35xx_clk_find_companion,
-};
-#endif
 
 /**
  * am35xx_clk_ipss_find_idlest - return CM_IDLEST info for IPSS
@@ -113,11 +96,7 @@ const struct clkops clkops_am35xx_ipss_module_wait = {
  * CM_{I,F}CLKEN bit.  Pass back the correct info via @idlest_reg
  * and @idlest_bit.  No return value.
  */
-#ifdef CONFIG_COMMON_CLK
 static void am35xx_clk_ipss_find_idlest(struct clk_hw_omap *clk,
-#else
-static void am35xx_clk_ipss_find_idlest(struct clk *clk,
-#endif
 					    void __iomem **idlest_reg,
 					    u8 *idlest_bit,
 					    u8 *idlest_val)
@@ -129,21 +108,10 @@ static void am35xx_clk_ipss_find_idlest(struct clk *clk,
 	*idlest_bit = AM35XX_ST_IPSS_SHIFT;
 	*idlest_val = OMAP34XX_CM_IDLEST_VAL;
 }
-#ifdef CONFIG_COMMON_CLK
+
 const struct clk_hw_omap_ops clkhwops_am35xx_ipss_wait = {
 	.allow_idle	= omap2_clkt_iclk_allow_idle,
 	.deny_idle	= omap2_clkt_iclk_deny_idle,
 	.find_idlest	= am35xx_clk_ipss_find_idlest,
 	.find_companion	= omap2_clk_dflt_find_companion,
 };
-#else
-const struct clkops clkops_am35xx_ipss_wait = {
-	.enable		= omap2_dflt_clk_enable,
-	.disable	= omap2_dflt_clk_disable,
-	.find_idlest	= am35xx_clk_ipss_find_idlest,
-	.find_companion	= omap2_clk_dflt_find_companion,
-	.allow_idle	= omap2_clkt_iclk_allow_idle,
-	.deny_idle	= omap2_clkt_iclk_deny_idle,
-};
-#endif
-
diff --git a/arch/arm/mach-omap2/clock36xx.c b/arch/arm/mach-omap2/clock36xx.c
index 9f50e97..8f3bf4e 100644
--- a/arch/arm/mach-omap2/clock36xx.c
+++ b/arch/arm/mach-omap2/clock36xx.c
@@ -37,28 +37,18 @@
  * (Any other value different from the Read value) to the
  * corresponding CM_CLKSEL register will refresh the dividers.
  */
-#ifdef CONFIG_COMMON_CLK
 int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk_hw *clk)
 {
 	struct clk_hw_omap *parent;
 	struct clk_hw *parent_hw;
-#else
-static int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk *clk)
-{
-	struct clk *parent;
-#endif
 	u32 dummy_v, orig_v, clksel_shift;
 	int ret;
 
 	/* Clear PWRDN bit of HSDIVIDER */
 	ret = omap2_dflt_clk_enable(clk);
 
-#ifdef CONFIG_COMMON_CLK
 	parent_hw = __clk_get_hw(__clk_get_parent(clk->clk));
 	parent = to_clk_hw_omap(parent_hw);
-#else
-	parent = clk->parent;
-#endif
 
 	/* Restore the dividers */
 	if (!ret) {
@@ -76,12 +66,3 @@ static int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk *clk)
 
 	return ret;
 }
-
-#ifndef CONFIG_COMMON_CLK
-const struct clkops clkops_omap36xx_pwrdn_with_hsdiv_wait_restore = {
-	.enable		= omap36xx_pwrdn_clk_enable_with_hsdiv_restore,
-	.disable	= omap2_dflt_clk_disable,
-	.find_companion	= omap2_clk_dflt_find_companion,
-	.find_idlest	= omap2_clk_dflt_find_idlest,
-};
-#endif
diff --git a/arch/arm/mach-omap2/clock36xx.h b/arch/arm/mach-omap2/clock36xx.h
index e6a748e..945bb7f 100644
--- a/arch/arm/mach-omap2/clock36xx.h
+++ b/arch/arm/mach-omap2/clock36xx.h
@@ -8,10 +8,6 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CLOCK36XX_H
 #define __ARCH_ARM_MACH_OMAP2_CLOCK36XX_H
 
-#ifdef CONFIG_COMMON_CLK
 extern int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk_hw *hw);
-#else
-extern const struct clkops clkops_omap36xx_pwrdn_with_hsdiv_wait_restore;
-#endif
 
 #endif
diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/clock3xxx.c
index ecb6029..b494f92 100644
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -39,12 +39,8 @@
 
 /* needed by omap3_core_dpll_m2_set_rate() */
 struct clk *sdrc_ick_p, *arm_fck_p;
-#ifdef CONFIG_COMMON_CLK
 int omap3_dpll4_set_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long parent_rate)
-#else
-int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
-#endif
 {
 	/*
 	 * According to the 12-5 CDP code from TI, "Limitation 2.5"
@@ -57,11 +53,7 @@ int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
 		return -EINVAL;
 	}
 
-#ifdef CONFIG_COMMON_CLK
 	return omap3_noncore_dpll_set_rate(hw, rate, parent_rate);
-#else
-	return omap3_noncore_dpll_set_rate(clk, rate);
-#endif
 }
 
 void __init omap3_clk_lock_dpll5(void)
diff --git a/arch/arm/mach-omap2/clock3xxx.h b/arch/arm/mach-omap2/clock3xxx.h
index 73ad5d3..284a394 100644
--- a/arch/arm/mach-omap2/clock3xxx.h
+++ b/arch/arm/mach-omap2/clock3xxx.h
@@ -11,15 +11,10 @@
 #include "clock.h"
 
 int omap3xxx_clk_init(void);
-#ifdef CONFIG_COMMON_CLK
 int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
 					unsigned long parent_rate);
 int omap3_core_dpll_m2_set_rate(struct clk_hw *clk, unsigned long rate,
 					unsigned long parent_rate);
-#else
-int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate);
-int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate);
-#endif
 void omap3_clk_lock_dpll5(void);
 
 extern struct clk *sdrc_ick_p;
-- 
1.7.1

