From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 07/10][RFC] OMAP4: PM: MPU DPLL clock nodes
Date: Fri, 29 May 2009 14:12:17 +0530
Message-ID: <1243586540-12274-7-git-send-email-rnayak@ti.com>
References: <1243586540-12274-1-git-send-email-rnayak@ti.com>
 <1243586540-12274-2-git-send-email-rnayak@ti.com>
 <1243586540-12274-3-git-send-email-rnayak@ti.com>
 <1243586540-12274-4-git-send-email-rnayak@ti.com>
 <1243586540-12274-5-git-send-email-rnayak@ti.com>
 <1243586540-12274-6-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58102 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756554AbZE2Im0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 May 2009 04:42:26 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4T8gMlX027247
	for <linux-omap@vger.kernel.org>; Fri, 29 May 2009 03:42:28 -0500
In-Reply-To: <1243586540-12274-6-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

This patch adds all clock nodes for MPU dpll

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx.c |    5 +++
 arch/arm/mach-omap2/clock44xx.h |   74 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx.c b/arch/arm/mach-omap2/clock44xx.c
index 22e9166..badcefa 100644
--- a/arch/arm/mach-omap2/clock44xx.c
+++ b/arch/arm/mach-omap2/clock44xx.c
@@ -115,6 +115,11 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,       "core_x2_ck",		&core_x2_ck, CK_443X),
 	CLK(NULL,       "core_dpll_emu_ck",	&core_dpll_emu_ck, CK_443X),
 	CLK(NULL,       "core_sgx_fck",		&core_sgx_fck, CK_443X),
+	CLK(NULL,       "mpu_dpll_hs_ck",	&mpu_dpll_hs_ck, CK_443X),
+	CLK(NULL,	"dpll_mpu_ck",		&dpll_mpu_ck, CK_443X),
+	CLK(NULL,	"dpll_mpu_m2_ck",	&dpll_mpu_m2_ck, CK_443X),
+	CLK(NULL,	"mpu_dpll_ck",		&mpu_dpll_ck, CK_443X),
+
 };
 
 static struct clk_functions omap2_clk_functions = {
diff --git a/arch/arm/mach-omap2/clock44xx.h b/arch/arm/mach-omap2/clock44xx.h
index 7b9a0c8..e58595a 100644
--- a/arch/arm/mach-omap2/clock44xx.h
+++ b/arch/arm/mach-omap2/clock44xx.h
@@ -799,4 +799,78 @@ static struct clk core_sgx_fck = {
 	.parent		= &dpll_core_x2m7_ck,
 	.recalc		= &followparent_recalc,
 };
+
+/* MPU DPLL */
+
+static const struct clksel_rate div4_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_443X | DEFAULT_RATE },
+	{ .div = 2, .val = 1, .flags = RATE_IN_443X },
+	{ .div = 4, .val = 2, .flags = RATE_IN_443X },
+	{ .div = 8, .val = 3, .flags = RATE_IN_443X },
+	{ .div = 0 }
+};
+
+static const struct clksel mpu_dpll_hs_ck_clksel[] = {
+	{ .parent = &core_x2_ck, .rates = div4_rates },
+	{ .parent = NULL }
+};
+
+static struct clk mpu_dpll_hs_ck = {
+	.name 		= "mpu_dpll_hs_ck",
+	.ops            = &clkops_null,
+	.init           = &omap2_init_clksel_parent,
+	.parent         = &core_x2_ck,
+	.clksel_reg     = OMAP4430_CM_BYPCLK_DPLL_MPU,
+	.clksel_mask    = OMAP4430_CLKSEL_MASK,
+	.clksel		= mpu_dpll_hs_ck_clksel,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct dpll_data dpll_mpu_dd = {
+	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_MPU,
+	.mult_mask	= OMAP4430_CM2_DPLL_MULT_MASK,
+	.div1_mask	= OMAP4430_CM2_DPLL_DIV_MASK,
+	.clk_bypass	= &mpu_dpll_hs_ck,
+	.clk_ref	= &dpll_sys_ref_ck,
+	.control_reg	= OMAP4430_CM_CLKMODE_DPLL_MPU,
+	.enable_mask	= OMAP4430_DPLL_EN_MASK,
+	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
+	.autoidle_reg	= OMAP4430_CM_AUTOIDLE_DPLL_MPU,
+	.autoidle_mask	= OMAP4430_AUTO_DPLL_MODE_MASK,
+	.idlest_reg	= OMAP4430_CM_IDLEST_DPLL_MPU,
+	.idlest_mask	= OMAP4430_ST_DPLL_CLK_MASK,
+};
+
+static struct clk dpll_mpu_ck = {
+	.name           = "dpll_mpu_ck",
+	.ops            = &clkops_null,
+	.parent         = &dpll_sys_ref_ck,
+	.dpll_data      = &dpll_mpu_dd,
+	.round_rate     = &omap2_dpll_round_rate,
+	.set_rate       = &omap4_noncore_dpll_set_rate,
+	.recalc         = &omap4_dpll_recalc,
+};
+
+static const struct clksel dpll_mpu_m2_clksel[] = {
+	{ .parent = &dpll_mpu_ck, .rates = div_mx_dpll_rates },
+	{ .parent = NULL }
+};
+
+static struct clk dpll_mpu_m2_ck = {
+	.name		= "dpll_mpu_m2_ck",
+	.ops		= &clkops_null,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_MPU,
+	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
+	.clksel		= dpll_mpu_m2_clksel,
+	.recalc         = &omap2_clksel_recalc,
+};
+
+static struct clk mpu_dpll_ck = {
+	.name		= "mpu_dpll_ck",
+	.ops		= &clkops_null,
+	.parent         = &dpll_mpu_m2_ck,
+	.recalc		= &followparent_recalc,
+};
+
 #endif
-- 
1.5.4.7

