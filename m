From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 06/10][RFC] OMAP4: PM: CORE DPLL clock nodes
Date: Fri, 29 May 2009 14:12:16 +0530
Message-ID: <1243586540-12274-6-git-send-email-rnayak@ti.com>
References: <1243586540-12274-1-git-send-email-rnayak@ti.com>
 <1243586540-12274-2-git-send-email-rnayak@ti.com>
 <1243586540-12274-3-git-send-email-rnayak@ti.com>
 <1243586540-12274-4-git-send-email-rnayak@ti.com>
 <1243586540-12274-5-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58101 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756299AbZE2Im0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 May 2009 04:42:26 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4T8gMOA027246
	for <linux-omap@vger.kernel.org>; Fri, 29 May 2009 03:42:28 -0500
In-Reply-To: <1243586540-12274-5-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

This patch adds all clock nodes for CORE dpll

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx.c |   15 ++++
 arch/arm/mach-omap2/clock44xx.h |  168 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 183 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx.c b/arch/arm/mach-omap2/clock44xx.c
index d7cf3f8..22e9166 100644
--- a/arch/arm/mach-omap2/clock44xx.c
+++ b/arch/arm/mach-omap2/clock44xx.c
@@ -100,6 +100,21 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,       "dss_fck",	&dss_fck, CK_443X),
 	CLK(NULL,       "per_mpu_m3",	&per_mpu_m3, CK_443X),
 	CLK(NULL,       "per_dpll_emu_ck",	&per_dpll_emu_ck, CK_443X),
+	CLK(NULL,       "core_phy_hsd_byp_ck",	&core_phy_hsd_byp_ck, CK_443X),
+	CLK(NULL,       "dpll_core_ck",		&dpll_core_ck, CK_443X),
+	CLK(NULL,       "dpll_core_x2_ck",	&dpll_core_x2_ck, CK_443X),
+	CLK(NULL,       "dpll_core_m2_ck",	&dpll_core_m2_ck, CK_443X),
+	CLK(NULL,       "dpll_core_x2m3_ck",	&dpll_core_x2m3_ck, CK_443X),
+	CLK(NULL,       "dpll_core_x2m4_ck",	&dpll_core_x2m4_ck, CK_443X),
+	CLK(NULL,       "dpll_core_x2m5_ck",	&dpll_core_x2m5_ck, CK_443X),
+	CLK(NULL,       "dpll_core_x2m6_ck",	&dpll_core_x2m6_ck, CK_443X),
+	CLK(NULL,       "dpll_core_x2m7_ck",	&dpll_core_x2m7_ck, CK_443X),
+	CLK(NULL,       "phy_root_ck",		&phy_root_ck, CK_443X),
+	CLK(NULL,       "core_dpll_scrm_ck",	&core_dpll_scrm_ck, CK_443X),
+	CLK(NULL,       "dpll_x2_ck",		&dpll_x2_ck, CK_443X),
+	CLK(NULL,       "core_x2_ck",		&core_x2_ck, CK_443X),
+	CLK(NULL,       "core_dpll_emu_ck",	&core_dpll_emu_ck, CK_443X),
+	CLK(NULL,       "core_sgx_fck",		&core_sgx_fck, CK_443X),
 };
 
 static struct clk_functions omap2_clk_functions = {
diff --git a/arch/arm/mach-omap2/clock44xx.h b/arch/arm/mach-omap2/clock44xx.h
index 8d22024..7b9a0c8 100644
--- a/arch/arm/mach-omap2/clock44xx.h
+++ b/arch/arm/mach-omap2/clock44xx.h
@@ -631,4 +631,172 @@ static struct clk per_dpll_emu_ck = {
 	.parent		= &dpll_per_x2m7_ck,
 	.recalc		= &followparent_recalc,
 };
+
+/* DPLL CORE */
+static const struct clksel_rate core_dpll_hs_ck_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_443X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel core_phy_hsd_byp_ck_clksel[] = {
+	{ .parent = &dpll_sys_ref_ck, .rates = dpll_sys_ref_ck_rates },
+	{ .parent = &core_dpll_hs_ck, .rates = core_dpll_hs_ck_rates },
+	{ .parent = NULL }
+};
+
+static struct clk core_phy_hsd_byp_ck = {
+	.name 		= "core_phy_hsd_byp_ck",
+	.ops		= &clkops_null,
+	.init           = &omap2_init_clksel_parent,
+	.parent         = &dpll_sys_ref_ck,
+	.clksel_reg     = OMAP4430_CM_CLKSEL_DPLL_CORE,
+	.clksel_mask    = OMAP4430_DPLL_BYP_CLKSEL_MASK,
+	.clksel         = core_phy_hsd_byp_ck_clksel,
+	.recalc         = &omap2_clksel_recalc,
+};
+
+static struct dpll_data dpll_core_dd = {
+	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_CORE,
+	.mult_mask	= OMAP4430_CM2_DPLL_MULT_MASK,
+	.div1_mask	= OMAP4430_CM2_DPLL_DIV_MASK,
+	.clk_bypass	= &core_dpll_hs_ck,
+	.clk_ref	= &dpll_sys_ref_ck,
+	.clk_hsd_bypass	= &core_phy_hsd_byp_ck,
+	.control_reg	= OMAP4430_CM_CLKMODE_DPLL_CORE,
+	.enable_mask	= OMAP4430_DPLL_EN_MASK,
+	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
+	.autoidle_reg	= OMAP4430_CM_AUTOIDLE_DPLL_CORE,
+	.autoidle_mask	= OMAP4430_AUTO_DPLL_MODE_MASK,
+	.idlest_reg	= OMAP4430_CM_IDLEST_DPLL_CORE,
+	.idlest_mask	= OMAP4430_ST_DPLL_CLK_MASK,
+};
+
+static struct clk dpll_core_ck = {
+	.name           = "dpll_core_ck",
+	.ops            = &clkops_null,
+	.parent         = &dpll_sys_ref_ck,
+	.dpll_data      = &dpll_core_dd,
+	.round_rate     = &omap2_dpll_round_rate,
+	.set_rate       = &omap4_noncore_dpll_set_rate,
+	.recalc         = &omap4_dpll_recalc,
+};
+
+static struct clk dpll_core_x2_ck = {
+	.name           = "dpll_core_x2_ck",
+	.ops            = &clkops_null,
+	.parent         = &dpll_core_ck,
+	.recalc         = &omap4_clkoutx2_recalc,
+};
+
+static const struct clksel dpll_core_m2_clksel[] = {
+	{ .parent = &dpll_core_ck, .rates = div_mx_dpll_rates },
+	{ .parent = NULL }
+};
+
+static struct clk dpll_core_m2_ck = {
+	.name		= "dpll_core_m2_ck",
+	.ops		= &clkops_null,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_CORE,
+	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
+	.clksel		= dpll_core_m2_clksel,
+	.recalc         = &omap2_clksel_recalc,
+};
+
+static const struct clksel dpll_core_x2mx_clksel[] = {
+	{ .parent = &dpll_core_x2_ck, .rates = div_mx_dpll_rates },
+	{ .parent = NULL }
+};
+
+static struct clk dpll_core_x2m3_ck = {
+	.name		= "dpll_core_x2m3_ck",
+	.ops		= &clkops_null,
+	.init           = &omap2_init_clksel_parent,
+	.clksel_reg     = OMAP4430_CM_DIV_M3_DPLL_CORE,
+	.clksel_mask    = OMAP4430_DPLL_CLKOUTHIF_DIV_MASK,
+	.clksel         = dpll_core_x2mx_clksel,
+	.recalc         = &omap2_clksel_recalc,
+};
+
+static struct clk dpll_core_x2m4_ck = {
+	.name		= "dpll_core_x2m4_ck",
+	.ops		= &clkops_null,
+	.init           = &omap2_init_clksel_parent,
+	.clksel_reg     = OMAP4430_CM_DIV_M4_DPLL_CORE,
+	.clksel_mask    = OMAP4430_DPLL_CLKOUTHIF_DIV_MASK,
+	.clksel         = dpll_core_x2mx_clksel,
+	.recalc         = &omap2_clksel_recalc,
+};
+
+static struct clk dpll_core_x2m5_ck = {
+	.name		= "dpll_core_x2m5_ck",
+	.ops		= &clkops_null,
+	.init           = &omap2_init_clksel_parent,
+	.clksel_reg     = OMAP4430_CM_DIV_M5_DPLL_CORE,
+	.clksel_mask    = OMAP4430_DPLL_CLKOUTHIF_DIV_MASK,
+	.clksel         = dpll_core_x2mx_clksel,
+	.recalc         = &omap2_clksel_recalc,
+};
+
+static struct clk dpll_core_x2m6_ck = {
+	.name		= "dpll_core_x2m6_ck",
+	.ops		= &clkops_null,
+	.init           = &omap2_init_clksel_parent,
+	.clksel_reg     = OMAP4430_CM_DIV_M6_DPLL_CORE,
+	.clksel_mask    = OMAP4430_DPLL_CLKOUTHIF_DIV_MASK,
+	.clksel         = dpll_core_x2mx_clksel,
+	.recalc         = &omap2_clksel_recalc,
+};
+
+static struct clk dpll_core_x2m7_ck = {
+	.name		= "dpll_core_x2m7_ck",
+	.ops		= &clkops_null,
+	.init           = &omap2_init_clksel_parent,
+	.clksel_reg     = OMAP4430_CM_DIV_M7_DPLL_CORE,
+	.clksel_mask    = OMAP4430_DPLL_CLKOUTHIF_DIV_MASK,
+	.clksel         = dpll_core_x2mx_clksel,
+	.recalc         = &omap2_clksel_recalc,
+};
+
+static struct clk phy_root_ck = {
+	.name		= "phy_root_ck",
+	.ops		= &clkops_null,
+	.parent		= &dpll_core_m2_ck,
+	.recalc         = &followparent_recalc,
+};
+
+static struct clk core_dpll_scrm_ck = {
+	.name		= "core_dpll_scrm_ck",
+	.ops		= &clkops_null,
+	.parent		= &dpll_core_x2m3_ck,
+	.recalc         = &followparent_recalc,
+};
+
+static struct clk dpll_x2_ck = {
+	.name		= "dpll_x2_ck",
+	.ops		= &clkops_null,
+	.parent		= &dpll_core_x2m4_ck,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk core_x2_ck = {
+	.name		= "core_x2_ck",
+	.ops		= &clkops_null,
+	.parent		= &dpll_core_x2m5_ck,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk core_dpll_emu_ck = {
+	.name		= "core_dpll_emu_ck",
+	.ops		= &clkops_null,
+	.parent         = &dpll_core_x2m6_ck,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk core_sgx_fck = {
+	.name		= "core_sgx_fck",
+	.ops		= &clkops_null,
+	.parent		= &dpll_core_x2m7_ck,
+	.recalc		= &followparent_recalc,
+};
 #endif
-- 
1.5.4.7

