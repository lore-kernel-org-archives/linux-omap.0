From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 08/10][RFC] OMAP4: PM: IVA DPLL clock nodes
Date: Fri, 29 May 2009 14:12:18 +0530
Message-ID: <1243586540-12274-8-git-send-email-rnayak@ti.com>
References: <1243586540-12274-1-git-send-email-rnayak@ti.com>
 <1243586540-12274-2-git-send-email-rnayak@ti.com>
 <1243586540-12274-3-git-send-email-rnayak@ti.com>
 <1243586540-12274-4-git-send-email-rnayak@ti.com>
 <1243586540-12274-5-git-send-email-rnayak@ti.com>
 <1243586540-12274-6-git-send-email-rnayak@ti.com>
 <1243586540-12274-7-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46792 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756632AbZE2Im1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 May 2009 04:42:27 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4T8gNZQ005421
	for <linux-omap@vger.kernel.org>; Fri, 29 May 2009 03:42:29 -0500
In-Reply-To: <1243586540-12274-7-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

This patch adds all clock nodes for IVA dpll

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx.c |    8 +++-
 arch/arm/mach-omap2/clock44xx.h |   89 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx.c b/arch/arm/mach-omap2/clock44xx.c
index badcefa..eb2365b 100644
--- a/arch/arm/mach-omap2/clock44xx.c
+++ b/arch/arm/mach-omap2/clock44xx.c
@@ -119,7 +119,13 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"dpll_mpu_ck",		&dpll_mpu_ck, CK_443X),
 	CLK(NULL,	"dpll_mpu_m2_ck",	&dpll_mpu_m2_ck, CK_443X),
 	CLK(NULL,	"mpu_dpll_ck",		&mpu_dpll_ck, CK_443X),
-
+	CLK(NULL,	"iva_dpll_hs_ck",	&iva_dpll_hs_ck, CK_443X),
+	CLK(NULL,	"dpll_iva_ck",		&dpll_iva_ck, CK_443X),
+	CLK(NULL,	"dpll_iva_x2_ck",	&dpll_iva_x2_ck, CK_443X),
+	CLK(NULL,	"dpll_iva_x2m4_ck",	&dpll_iva_x2m4_ck, CK_443X),
+	CLK(NULL,	"dpll_iva_x2m5_ck",	&dpll_iva_x2m5_ck, CK_443X),
+	CLK(NULL,	"dsp_root_ck",		&dsp_root_ck, CK_443X),
+	CLK(NULL,	"ivahd_ck",		&ivahd_ck, CK_443X),
 };
 
 static struct clk_functions omap2_clk_functions = {
diff --git a/arch/arm/mach-omap2/clock44xx.h b/arch/arm/mach-omap2/clock44xx.h
index e58595a..900ba8c 100644
--- a/arch/arm/mach-omap2/clock44xx.h
+++ b/arch/arm/mach-omap2/clock44xx.h
@@ -873,4 +873,93 @@ static struct clk mpu_dpll_ck = {
 	.recalc		= &followparent_recalc,
 };
 
+/* IVA DPLL */
+
+static const struct clksel iva_dpll_hs_ck_clksel[] = {
+	{ .parent = &core_x2_ck, .rates = div4_rates },
+	{ .parent = NULL }
+};
+
+static struct clk iva_dpll_hs_ck = {
+	.name 		= "iva_dpll_hs_ck",
+	.ops            = &clkops_null,
+	.init           = &omap2_init_clksel_parent,
+	.parent         = &core_x2_ck,
+	.clksel_reg     = OMAP4430_CM_BYPCLK_DPLL_IVA,
+	.clksel_mask    = OMAP4430_CLKSEL_MASK,
+	.clksel		= iva_dpll_hs_ck_clksel,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct dpll_data dpll_iva_dd = {
+	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_IVA,
+	.mult_mask	= OMAP4430_CM2_DPLL_MULT_MASK,
+	.div1_mask	= OMAP4430_CM2_DPLL_DIV_MASK,
+	.clk_bypass	= &iva_dpll_hs_ck,
+	.clk_ref	= &dpll_sys_ref_ck,
+	.control_reg	= OMAP4430_CM_CLKMODE_DPLL_IVA,
+	.enable_mask	= OMAP4430_DPLL_EN_MASK,
+	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
+	.autoidle_reg	= OMAP4430_CM_AUTOIDLE_DPLL_IVA,
+	.autoidle_mask	= OMAP4430_AUTO_DPLL_MODE_MASK,
+	.idlest_reg	= OMAP4430_CM_IDLEST_DPLL_IVA,
+	.idlest_mask	= OMAP4430_ST_DPLL_CLK_MASK,
+};
+
+static struct clk dpll_iva_ck = {
+	.name           = "dpll_iva_ck",
+	.ops            = &clkops_null,
+	.parent         = &dpll_sys_ref_ck,
+	.dpll_data      = &dpll_iva_dd,
+	.round_rate     = &omap2_dpll_round_rate,
+	.set_rate       = &omap4_noncore_dpll_set_rate,
+	.recalc         = &omap4_dpll_recalc,
+};
+
+static struct clk dpll_iva_x2_ck = {
+	.name           = "dpll_iva_x2_ck",
+	.ops            = &clkops_null,
+	.parent         = &dpll_iva_ck,
+	.recalc         = &omap4_clkoutx2_recalc,
+};
+
+static const struct clksel dpll_iva_x2mx_clksel[] = {
+	{ .parent = &dpll_iva_x2_ck, .rates = div_mx_dpll_rates },
+	{ .parent = NULL }
+};
+
+static struct clk dpll_iva_x2m4_ck = {
+	.name		= "dpll_iva_x2m4_ck",
+	.ops		= &clkops_null,
+	.init           = &omap2_init_clksel_parent,
+	.clksel_reg     = OMAP4430_CM_DIV_M4_DPLL_IVA,
+	.clksel_mask    = OMAP4430_DPLL_CLKOUTHIF_DIV_MASK,
+	.clksel         = dpll_iva_x2mx_clksel,
+	.recalc         = &omap2_clksel_recalc,
+};
+
+static struct clk dpll_iva_x2m5_ck = {
+	.name		= "dpll_iva_x2m5_ck",
+	.ops		= &clkops_null,
+	.init           = &omap2_init_clksel_parent,
+	.clksel_reg     = OMAP4430_CM_DIV_M5_DPLL_IVA,
+	.clksel_mask    = OMAP4430_DPLL_CLKOUTHIF_DIV_MASK,
+	.clksel         = dpll_iva_x2mx_clksel,
+	.recalc         = &omap2_clksel_recalc,
+};
+
+static struct clk dsp_root_ck = {
+	.name		= "dsp_root_ck",
+	.ops		= &clkops_null,
+	.parent         = &dpll_iva_x2m4_ck,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk ivahd_ck = {
+	.name		= "ivahd_ck",
+	.ops		= &clkops_null,
+	.parent         = &dpll_iva_x2m5_ck,
+	.recalc		= &followparent_recalc,
+};
+
 #endif
-- 
1.5.4.7

