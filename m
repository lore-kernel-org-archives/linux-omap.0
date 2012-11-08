From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 18/26] ARM: OMAP4: clock: Cleanup !CONFIG_COMMON_CLK parts
Date: Wed, 7 Nov 2012 17:12:53 -0800
Message-ID: <1352337181-29427-19-git-send-email-mturquette@ti.com>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36686 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314Ab2KHBNn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 20:13:43 -0500
In-Reply-To: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org, patches@linaro.org, Mike Turquette <mturquette@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Clean all #ifdef's added to OMAP4 clock code to make it COMMON clk
ready, now that CONFIG_COMMON_CLK is enabled.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/dpll44xx.c |   33 ---------------------------------
 arch/arm/mach-omap2/io.c       |    2 --
 2 files changed, 35 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
index aa75a3c..d3326c4 100644
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -21,11 +21,7 @@
 #include "cm-regbits-44xx.h"
 
 /* Supported only on OMAP4 */
-#ifdef CONFIG_COMMON_CLK
 int omap4_dpllmx_gatectrl_read(struct clk_hw_omap *clk)
-#else
-int omap4_dpllmx_gatectrl_read(struct clk *clk)
-#endif
 {
 	u32 v;
 	u32 mask;
@@ -44,11 +40,7 @@ int omap4_dpllmx_gatectrl_read(struct clk *clk)
 	return v;
 }
 
-#ifdef CONFIG_COMMON_CLK
 void omap4_dpllmx_allow_gatectrl(struct clk_hw_omap *clk)
-#else
-void omap4_dpllmx_allow_gatectrl(struct clk *clk)
-#endif
 {
 	u32 v;
 	u32 mask;
@@ -66,11 +58,7 @@ void omap4_dpllmx_allow_gatectrl(struct clk *clk)
 	__raw_writel(v, clk->clksel_reg);
 }
 
-#ifdef CONFIG_COMMON_CLK
 void omap4_dpllmx_deny_gatectrl(struct clk_hw_omap *clk)
-#else
-void omap4_dpllmx_deny_gatectrl(struct clk *clk)
-#endif
 {
 	u32 v;
 	u32 mask;
@@ -88,17 +76,10 @@ void omap4_dpllmx_deny_gatectrl(struct clk *clk)
 	__raw_writel(v, clk->clksel_reg);
 }
 
-#ifdef CONFIG_COMMON_CLK
 const struct clk_hw_omap_ops clkhwops_omap4_dpllmx = {
 	.allow_idle	= omap4_dpllmx_allow_gatectrl,
 	.deny_idle      = omap4_dpllmx_deny_gatectrl,
 };
-#else
-const struct clkops clkops_omap4_dpllmx_ops = {
-	.allow_idle	= omap4_dpllmx_allow_gatectrl,
-	.deny_idle	= omap4_dpllmx_deny_gatectrl,
-};
-#endif
 
 /**
  * omap4_dpll_regm4xen_recalc - compute DPLL rate, considering REGM4XEN bit
@@ -109,15 +90,10 @@ const struct clkops clkops_omap4_dpllmx_ops = {
  * OMAP4 ABE DPLL.  Returns the DPLL's output rate (before M-dividers)
  * upon success, or 0 upon error.
  */
-#ifdef CONFIG_COMMON_CLK
 unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
 			unsigned long parent_rate)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-#else
-unsigned long omap4_dpll_regm4xen_recalc(struct clk *clk)
-{
-#endif
 	u32 v;
 	unsigned long rate;
 	struct dpll_data *dd;
@@ -149,16 +125,11 @@ unsigned long omap4_dpll_regm4xen_recalc(struct clk *clk)
  * M-dividers) upon success, -EINVAL if @clk is null or not a DPLL, or
  * ~0 if an error occurred in omap2_dpll_round_rate().
  */
-#ifdef CONFIG_COMMON_CLK
 long omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
 				    unsigned long target_rate,
 				    unsigned long *parent_rate)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-#else
-long omap4_dpll_regm4xen_round_rate(struct clk *clk, unsigned long target_rate)
-{
-#endif
 	u32 v;
 	struct dpll_data *dd;
 	long r;
@@ -174,11 +145,7 @@ long omap4_dpll_regm4xen_round_rate(struct clk *clk, unsigned long target_rate)
 	if (v)
 		target_rate = target_rate / OMAP4430_REGM4XEN_MULT;
 
-#ifdef CONFIG_COMMON_CLK
 	r = omap2_dpll_round_rate(hw, target_rate, NULL);
-#else
-	r = omap2_dpll_round_rate(clk, target_rate);
-#endif
 	if (r == ~0)
 		return r;
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index a62010e..e6192cb 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -574,9 +574,7 @@ void __init omap4430_init_late(void)
 	omap_mux_late_init();
 	omap2_common_pm_late_init();
 	omap4_pm_init();
-#ifdef CONFIG_COMMON_CLK
 	omap2_clk_enable_autoidle_all();
-#endif
 }
 #endif
 
-- 
1.7.9.5

