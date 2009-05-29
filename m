From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 09/10][RFC] OMAP4: PM: UNIPRO DPLL clock nodes
Date: Fri, 29 May 2009 14:12:19 +0530
Message-ID: <1243586540-12274-9-git-send-email-rnayak@ti.com>
References: <1243586540-12274-1-git-send-email-rnayak@ti.com>
 <1243586540-12274-2-git-send-email-rnayak@ti.com>
 <1243586540-12274-3-git-send-email-rnayak@ti.com>
 <1243586540-12274-4-git-send-email-rnayak@ti.com>
 <1243586540-12274-5-git-send-email-rnayak@ti.com>
 <1243586540-12274-6-git-send-email-rnayak@ti.com>
 <1243586540-12274-7-git-send-email-rnayak@ti.com>
 <1243586540-12274-8-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58103 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756667AbZE2Im1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 May 2009 04:42:27 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4T8gN0w027248
	for <linux-omap@vger.kernel.org>; Fri, 29 May 2009 03:42:29 -0500
In-Reply-To: <1243586540-12274-8-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

This patch adds all clock nodes for UNIPRO dpll

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx.c |    4 +++
 arch/arm/mach-omap2/clock44xx.h |   54 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx.c b/arch/arm/mach-omap2/clock44xx.c
index eb2365b..2a3696f 100644
--- a/arch/arm/mach-omap2/clock44xx.c
+++ b/arch/arm/mach-omap2/clock44xx.c
@@ -126,6 +126,10 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"dpll_iva_x2m5_ck",	&dpll_iva_x2m5_ck, CK_443X),
 	CLK(NULL,	"dsp_root_ck",		&dsp_root_ck, CK_443X),
 	CLK(NULL,	"ivahd_ck",		&ivahd_ck, CK_443X),
+	CLK(NULL,	"dpll_unipro_ck",	&dpll_unipro_ck, CK_443X),
+	CLK(NULL,	"dpll_unipro_x2_ck",	&dpll_unipro_x2_ck, CK_443X),
+	CLK(NULL,	"dpll_unipro_x2m2_ck",	&dpll_unipro_x2m2_ck, CK_443X),
+	CLK(NULL,	"unipro1_phy_fck",	&unipro1_phy_fck, CK_443X),
 };
 
 static struct clk_functions omap2_clk_functions = {
diff --git a/arch/arm/mach-omap2/clock44xx.h b/arch/arm/mach-omap2/clock44xx.h
index 900ba8c..057fdf0 100644
--- a/arch/arm/mach-omap2/clock44xx.h
+++ b/arch/arm/mach-omap2/clock44xx.h
@@ -962,4 +962,58 @@ static struct clk ivahd_ck = {
 	.recalc		= &followparent_recalc,
 };
 
+/* UNIPRO DPLL */
+
+static struct dpll_data dpll_unipro_dd = {
+	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_UNIPRO,
+	.mult_mask	= OMAP4430_CM2_DPLL_MULT_MASK,
+	.div1_mask	= OMAP4430_CM2_DPLL_DIV_MASK,
+	.clk_ref	= &dpll_sys_ref_ck,
+	.control_reg	= OMAP4430_CM_CLKMODE_DPLL_UNIPRO,
+	.enable_mask	= OMAP4430_DPLL_EN_MASK,
+	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
+	.autoidle_reg	= OMAP4430_CM_AUTOIDLE_DPLL_UNIPRO,
+	.autoidle_mask	= OMAP4430_AUTO_DPLL_MODE_MASK,
+	.idlest_reg	= OMAP4430_CM_IDLEST_DPLL_UNIPRO,
+	.idlest_mask	= OMAP4430_ST_DPLL_CLK_MASK,
+};
+
+static struct clk dpll_unipro_ck = {
+	.name           = "dpll_unipro_ck",
+	.ops            = &clkops_null,
+	.parent         = &dpll_sys_ref_ck,
+	.dpll_data      = &dpll_unipro_dd,
+	.round_rate     = &omap2_dpll_round_rate,
+	.set_rate       = &omap4_noncore_dpll_set_rate,
+	.recalc         = &omap4_dpll_recalc,
+};
+
+static struct clk dpll_unipro_x2_ck = {
+	.name           = "dpll_unipro_x2_ck",
+	.ops            = &clkops_null,
+	.parent         = &dpll_unipro_ck,
+	.recalc         = &omap4_clkoutx2_recalc,
+};
+
+static const struct clksel dpll_unipro_x2mx_clksel[] = {
+	{ .parent = &dpll_unipro_x2_ck, .rates = div_mx_dpll_rates },
+	{ .parent = NULL }
+};
+
+static struct clk dpll_unipro_x2m2_ck = {
+	.name		= "dpll_unipro_x2m2_ck",
+	.ops		= &clkops_null,
+	.init           = &omap2_init_clksel_parent,
+	.clksel_reg     = OMAP4430_CM_DIV_M2_DPLL_UNIPRO,
+	.clksel_mask    = OMAP4430_DPLL_CLKOUTHIF_DIV_MASK,
+	.clksel         = dpll_unipro_x2mx_clksel,
+	.recalc         = &omap2_clksel_recalc,
+};
+
+static struct clk unipro1_phy_fck = {
+	.name		= "unipro1_phy_fck",
+	.ops		= &clkops_null,
+	.parent         = &dpll_unipro_x2m2_ck,
+	.recalc		= &followparent_recalc,
+};
 #endif
-- 
1.5.4.7

