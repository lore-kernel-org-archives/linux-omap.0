From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 04/10][RFC] OMAP4: PM: ABE DPLL clock nodes
Date: Fri, 29 May 2009 14:12:14 +0530
Message-ID: <1243586540-12274-4-git-send-email-rnayak@ti.com>
References: <1243586540-12274-1-git-send-email-rnayak@ti.com>
 <1243586540-12274-2-git-send-email-rnayak@ti.com>
 <1243586540-12274-3-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46791 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755863AbZE2Im0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 May 2009 04:42:26 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4T8gM4Z005420
	for <linux-omap@vger.kernel.org>; Fri, 29 May 2009 03:42:27 -0500
In-Reply-To: <1243586540-12274-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

This patch adds all clock nodes for ABE dpll

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx.c         |   26 +++++-
 arch/arm/mach-omap2/clock44xx.h         |  147 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/clock.h |    4 +
 3 files changed, 176 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx.c b/arch/arm/mach-omap2/clock44xx.c
index ffb63b3..7047760 100644
--- a/arch/arm/mach-omap2/clock44xx.c
+++ b/arch/arm/mach-omap2/clock44xx.c
@@ -73,7 +73,16 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_443X),
 	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_443X),
 	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_443X),
-	CLK(NULL,       "gpmc_fck",    &gpmc_fck,     CK_443X),
+	CLK(NULL,       "gpmc_fck",	&gpmc_fck,	CK_443X),
+	CLK(NULL,       "dpll_abe_ck",	&dpll_abe_ck,	CK_443X),
+	CLK(NULL,       "dpll_abe_x2_ck",	&dpll_abe_x2_ck, CK_443X),
+	CLK(NULL,       "dpll_abe_m2_ck",	&dpll_abe_m2_ck, CK_443X),
+	CLK(NULL,       "dpll_abe_x2m2_ck",	&dpll_abe_x2m2_ck, CK_443X),
+	CLK(NULL,       "dpll_abe_x2m3_ck",	&dpll_abe_x2m3_ck, CK_443X),
+	CLK(NULL,       "per_abe_x1_fck",	&per_abe_x1_fck, CK_443X),
+	CLK(NULL,       "dpll_abe_x2_fck",	&dpll_abe_x2_fck, CK_443X),
+	CLK(NULL,       "core_dpll_hs_ck",	&core_dpll_hs_ck, CK_443X),
+	CLK(NULL,       "per_dpll_hs_ck",	&per_dpll_hs_ck, CK_443X),
 };
 
 static struct clk_functions omap2_clk_functions = {
@@ -90,6 +99,21 @@ void omap2_clk_prepare_for_reboot(void)
 	return;
 }
 
+static int omap4_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
+{
+	return 0;
+}
+
+static unsigned long omap4_clkoutx2_recalc(struct clk *clk)
+{
+	return 0;
+}
+
+static unsigned long omap4_dpll_recalc(struct clk *clk)
+{
+	return 0;
+}
+
 static int __init omap2_clk_arch_init(void)
 {
 	if (!mpurate)
diff --git a/arch/arm/mach-omap2/clock44xx.h b/arch/arm/mach-omap2/clock44xx.h
index 8a0cc62..f1adc92 100644
--- a/arch/arm/mach-omap2/clock44xx.h
+++ b/arch/arm/mach-omap2/clock44xx.h
@@ -19,6 +19,10 @@
 #include "prm.h"
 #include "prm-regbits-44xx.h"
 
+static unsigned long omap4_dpll_recalc(struct clk *clk);
+static unsigned long omap4_clkoutx2_recalc(struct clk *clk);
+static int omap4_noncore_dpll_set_rate(struct clk *clk, unsigned long rate);
+
 /* PRM CLOCKS */
 
 static struct clk omap_32k_fck = {
@@ -298,4 +302,147 @@ static struct clk gpmc_fck = {
 	.ops            = &clkops_null,
 };
 
+/* DPLL's */
+
+#define DPLL_LOW_POWER_STOP	0x1
+#define DPLL_LOW_POWER_BYPASS	0x5
+#define	DPLL_LOCKED		0x7
+
+static const struct clksel_rate div_mx_dpll_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_443X | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_443X },
+	{ .div = 3, .val = 3, .flags = RATE_IN_443X },
+	{ .div = 4, .val = 4, .flags = RATE_IN_443X },
+	{ .div = 5, .val = 5, .flags = RATE_IN_443X },
+	{ .div = 6, .val = 6, .flags = RATE_IN_443X },
+	{ .div = 7, .val = 7, .flags = RATE_IN_443X },
+	{ .div = 8, .val = 8, .flags = RATE_IN_443X },
+	{ .div = 9, .val = 9, .flags = RATE_IN_443X },
+	{ .div = 10, .val = 10, .flags = RATE_IN_443X },
+	{ .div = 11, .val = 11, .flags = RATE_IN_443X },
+	{ .div = 12, .val = 12, .flags = RATE_IN_443X },
+	{ .div = 13, .val = 13, .flags = RATE_IN_443X },
+	{ .div = 14, .val = 14, .flags = RATE_IN_443X },
+	{ .div = 15, .val = 15, .flags = RATE_IN_443X },
+	{ .div = 16, .val = 16, .flags = RATE_IN_443X },
+	{ .div = 17, .val = 17, .flags = RATE_IN_443X },
+	{ .div = 18, .val = 18, .flags = RATE_IN_443X },
+	{ .div = 19, .val = 19, .flags = RATE_IN_443X },
+	{ .div = 20, .val = 20, .flags = RATE_IN_443X },
+	{ .div = 21, .val = 21, .flags = RATE_IN_443X },
+	{ .div = 22, .val = 22, .flags = RATE_IN_443X },
+	{ .div = 23, .val = 23, .flags = RATE_IN_443X },
+	{ .div = 24, .val = 24, .flags = RATE_IN_443X },
+	{ .div = 25, .val = 25, .flags = RATE_IN_443X },
+	{ .div = 26, .val = 26, .flags = RATE_IN_443X },
+	{ .div = 27, .val = 27, .flags = RATE_IN_443X },
+	{ .div = 28, .val = 28, .flags = RATE_IN_443X },
+	{ .div = 29, .val = 29, .flags = RATE_IN_443X },
+	{ .div = 30, .val = 30, .flags = RATE_IN_443X },
+	{ .div = 31, .val = 31, .flags = RATE_IN_443X },
+	{ .div = 0 }
+};
+
+/* DPLL ABE */
+
+static struct dpll_data dpll_abe_dd = {
+	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_ABE,
+	.mult_mask	= OMAP4430_CM2_DPLL_MULT_MASK,
+	.div1_mask	= OMAP4430_CM2_DPLL_DIV_MASK,
+	.clk_bypass	= &sys_ck,
+	.clk_ref	= &abe_dpll_alwon_ck,
+	.control_reg	= OMAP4430_CM_CLKMODE_DPLL_ABE,
+	.enable_mask	= OMAP4430_DPLL_EN_MASK,
+	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
+	.autoidle_reg	= OMAP4430_CM_AUTOIDLE_DPLL_ABE,
+	.autoidle_mask	= OMAP4430_AUTO_DPLL_MODE_MASK,
+	.idlest_reg	= OMAP4430_CM_IDLEST_DPLL_ABE,
+	.idlest_mask	= OMAP4430_ST_DPLL_CLK_MASK,
+};
+
+static struct clk dpll_abe_ck = {
+	.name           = "dpll_abe_ck",
+	.ops            = &clkops_null,
+	.parent         = &abe_dpll_alwon_ck,
+	.dpll_data      = &dpll_abe_dd,
+	.round_rate     = &omap2_dpll_round_rate,
+	.set_rate       = &omap4_noncore_dpll_set_rate,
+	.recalc         = &omap4_dpll_recalc,
+};
+
+static struct clk dpll_abe_x2_ck = {
+	.name           = "dpll_abe_x2_ck",
+	.ops            = &clkops_null,
+	.parent         = &dpll_abe_ck,
+	.recalc         = &omap4_clkoutx2_recalc,
+};
+
+static const struct clksel dpll_abe_m2_clksel[] = {
+	{ .parent = &dpll_abe_ck, .rates = div_mx_dpll_rates },
+	{ .parent = NULL }
+};
+
+static struct clk dpll_abe_m2_ck = {
+	.name		= "dpll_abe_m2_ck",
+	.ops		= &clkops_null,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_ABE,
+	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
+	.clksel		= dpll_abe_m2_clksel,
+	.recalc         = &omap2_clksel_recalc,
+};
+
+static const struct clksel dpll_abe_x2mx_clksel[] = {
+	{ .parent = &dpll_abe_x2_ck, .rates = div_mx_dpll_rates },
+	{ .parent = NULL }
+};
+
+static struct clk dpll_abe_x2m2_ck = {
+	.name		= "dpll_abe_x2m2_ck",
+	.ops		= &clkops_null,
+	.init           = &omap2_init_clksel_parent,
+	.clksel_reg     = OMAP4430_CM_DIV_M2_DPLL_ABE,
+	.clksel_mask    = OMAP4430_DPLL_CLKOUT_DIV_MASK,
+	.clksel         = dpll_abe_x2mx_clksel,
+	.recalc         = &omap2_clksel_recalc,
+};
+
+static struct clk dpll_abe_x2m3_ck = {
+	.name		= "dpll_abe_x2m3_ck",
+	.ops		= &clkops_null,
+	.init           = &omap2_init_clksel_parent,
+	.clksel_reg     = OMAP4430_CM_DIV_M3_DPLL_ABE,
+	.clksel_mask    = OMAP4430_DPLL_CLKOUTHIF_DIV_MASK,
+	.clksel         = dpll_abe_x2mx_clksel,
+	.recalc         = &omap2_clksel_recalc,
+};
+
+static struct clk per_abe_x1_fck = {
+	.name		= "per_abe_x1_fck",
+	.ops		= &clkops_null,
+	.parent		= &dpll_abe_m2_ck,
+	.recalc         = &followparent_recalc,
+};
+
+static struct clk dpll_abe_x2_fck = {
+	.name		= "dpll_abe_x2_fck",
+	.ops		= &clkops_null,
+	.parent		= &dpll_abe_m2_ck,
+	.recalc         = &followparent_recalc,
+};
+
+static struct clk core_dpll_hs_ck = {
+	.name		= "core_dpll_hs_ck",
+	.ops		= &clkops_null,
+	.parent		= &dpll_abe_m2_ck,
+	.recalc         = &followparent_recalc,
+};
+
+static struct clk per_dpll_hs_ck = {
+	.name 		= "per_dpll_hs_ck",
+	.ops		= &clkops_null,
+	.parent		= &core_dpll_hs_ck,
+	.fixed_div      = 2,
+	.recalc         = &omap2_fixed_divisor_recalc,
+};
 #endif
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 095d8a6..e0cac22 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -63,6 +63,10 @@ struct dpll_data {
 	u8			recal_en_bit;
 	u8			recal_st_bit;
 #  endif
+
+#if defined(CONFIG_ARCH_OMAP4)
+	struct clk		*clk_hsd_bypass;
+#endif
 };
 
 #endif
-- 
1.5.4.7

