From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 10/10][RFC] OMAP4: PM: Adds a few CM1/2 clock nodes
Date: Fri, 29 May 2009 14:12:20 +0530
Message-ID: <1243586540-12274-10-git-send-email-rnayak@ti.com>
References: <1243586540-12274-1-git-send-email-rnayak@ti.com>
 <1243586540-12274-2-git-send-email-rnayak@ti.com>
 <1243586540-12274-3-git-send-email-rnayak@ti.com>
 <1243586540-12274-4-git-send-email-rnayak@ti.com>
 <1243586540-12274-5-git-send-email-rnayak@ti.com>
 <1243586540-12274-6-git-send-email-rnayak@ti.com>
 <1243586540-12274-7-git-send-email-rnayak@ti.com>
 <1243586540-12274-8-git-send-email-rnayak@ti.com>
 <1243586540-12274-9-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42745 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755845AbZE2Im1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 May 2009 04:42:27 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4T8gN7w008062
	for <linux-omap@vger.kernel.org>; Fri, 29 May 2009 03:42:29 -0500
In-Reply-To: <1243586540-12274-9-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

This patch adds some clock nodes in CM1 and CM2 modules

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx.c |    6 ++
 arch/arm/mach-omap2/clock44xx.h |  114 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx.c b/arch/arm/mach-omap2/clock44xx.c
index 2a3696f..76556e6 100644
--- a/arch/arm/mach-omap2/clock44xx.c
+++ b/arch/arm/mach-omap2/clock44xx.c
@@ -130,6 +130,12 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"dpll_unipro_x2_ck",	&dpll_unipro_x2_ck, CK_443X),
 	CLK(NULL,	"dpll_unipro_x2m2_ck",	&dpll_unipro_x2m2_ck, CK_443X),
 	CLK(NULL,	"unipro1_phy_fck",	&unipro1_phy_fck, CK_443X),
+	CLK(NULL,	"core_ck",		&core_ck, CK_443X),
+	CLK(NULL,	"l3_ick",		&l3_ick, CK_443X),
+	CLK(NULL,	"l4_root_ck",		&l4_root_ck, CK_443X),
+	CLK(NULL,	"fdif_fck",		&fdif_fck, CK_443X),
+	CLK(NULL,	"hsi_fck",		&hsi_fck, CK_443X),
+	CLK(NULL,	"mpu_m3_iss_ck",	&mpu_m3_iss_ck, CK_443X),
 };
 
 static struct clk_functions omap2_clk_functions = {
diff --git a/arch/arm/mach-omap2/clock44xx.h b/arch/arm/mach-omap2/clock44xx.h
index 057fdf0..d5729d6 100644
--- a/arch/arm/mach-omap2/clock44xx.h
+++ b/arch/arm/mach-omap2/clock44xx.h
@@ -1016,4 +1016,118 @@ static struct clk unipro1_phy_fck = {
 	.parent         = &dpll_unipro_x2m2_ck,
 	.recalc		= &followparent_recalc,
 };
+
+/* CM1 nodes */
+
+static const struct clksel core_ck_clksel[] = {
+	{ .parent = &core_x2_ck, .rates = div2_rates },
+	{ .parent = NULL }
+};
+
+static struct clk core_ck = {
+	.name		= "core_ck",
+	.ops		= &clkops_null,
+	.init           = &omap2_init_clksel_parent,
+	.clksel_reg     = OMAP4430_CM_CLKSEL_CORE,
+	.clksel_mask    = OMAP4430_CLKSEL_CORE_MASK,
+	.clksel         = core_ck_clksel,
+	.recalc         = &omap2_clksel_recalc,
+};
+
+static const struct clksel l3_ick_clksel[] = {
+	{ .parent = &core_ck, .rates = div2_rates },
+	{ .parent = NULL }
+};
+
+static struct clk l3_ick = {
+	.name		= "l3_ick",
+	.ops		= &clkops_null,
+	.init           = &omap2_init_clksel_parent,
+	.clksel_reg     = OMAP4430_CM_CLKSEL_CORE,
+	.clksel_mask    = OMAP4430_CM_CLKSEL_CORE_RESTORE_CLKSEL_L3_MASK,
+	.clksel         = l3_ick_clksel,
+	.recalc         = &omap2_clksel_recalc,
+};
+
+static const struct clksel l4_root_ck_clksel[] = {
+	{ .parent = &core_ck, .rates = div2_rates },
+	{ .parent = NULL }
+};
+
+static struct clk l4_root_ck = {
+	.name		= "l4_root_ck",
+	.ops		= &clkops_null,
+	.init           = &omap2_init_clksel_parent,
+	.clksel_reg     = OMAP4430_CM_CLKSEL_CORE,
+	.clksel_mask    = OMAP4430_CLKSEL_L4_MASK,
+	.clksel         = l4_root_ck_clksel,
+	.recalc         = &omap2_clksel_recalc,
+};
+
+/* CM2 nodes */
+
+static const struct clksel_rate div124_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_443X | DEFAULT_RATE },
+	{ .div = 2, .val = 1, .flags = RATE_IN_443X },
+	{ .div = 4, .val = 2, .flags = RATE_IN_443X },
+	{ .div = 0 }
+};
+
+static const struct clksel fdif_fck_clksel[] = {
+	{ .parent = &omap_128m_fck, .rates = div124_rates },
+	{ .parent = NULL }
+};
+
+static struct clk fdif_fck = {
+	.name		= "fdif_fck",
+	.ops		= &clkops_null,
+	.init           = &omap2_init_clksel_parent,
+	.clksel_reg     = OMAP4430_CM_CAM_FDIF_CLKCTRL,
+	.clksel_mask    = OMAP4430_CLKSEL_FCLK_MASK,
+	.clksel         = fdif_fck_clksel,
+	.recalc         = &omap2_clksel_recalc,
+};
+
+static const struct clksel hsi_fck_clksel[] = {
+	{ .parent = &omap_192m_fck, .rates = div124_rates },
+	{ .parent = NULL }
+};
+
+static struct clk hsi_fck = {
+	.name		= "hsi_fck",
+	.ops		= &clkops_null,
+	.init           = &omap2_init_clksel_parent,
+	.clksel_reg     = OMAP4430_CM_L3INIT_HSI_CLKCTRL,
+	.clksel_mask    = OMAP4430_HSI_CLKSEL_MASK,
+	.clksel         = hsi_fck_clksel,
+	.recalc         = &omap2_clksel_recalc,
+};
+
+static const struct clksel_rate core_ck_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_443X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate per_mpu_m3_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_443X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel mpu_m3_iss_ck_clksel[] = {
+	{ .parent = &core_ck, .rates = core_ck_rates },
+	{ .parent = &per_mpu_m3, .rates = per_mpu_m3_rates },
+	{ .parent = NULL }
+};
+
+static struct clk mpu_m3_iss_ck = {
+	.name           = "mpu_m3_iss_ck",
+	.ops            = &clkops_null,
+	.init           = &omap2_init_clksel_parent,
+	.parent         = &core_ck,
+	.clksel_reg     = OMAP4430_CM_CLKSEL_DUCATI_ISS_ROOT,
+	.clksel_mask    = OMAP4430_MPU_M3_ISS_ROOT_CLKSEL_MASK,
+	.clksel         = mpu_m3_iss_ck_clksel,
+	.recalc         = &omap2_clksel_recalc,
+};
+
 #endif
-- 
1.5.4.7

