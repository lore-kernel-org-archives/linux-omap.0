From: Thara Gopinath <thara@ti.com>
Subject: [PATCH] OMAP4: Extend clock data.
Date: Thu, 30 Sep 2010 13:30:30 +0530
Message-ID: <1285833630-23044-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48489 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754123Ab0I3IAl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Sep 2010 04:00:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, Thara Gopinath <thara@ti.com>

This patch extends the OMAP4 clock data to include
various x2 clock nodes as the clock framework
skips a *2 whie calculating the dpll locked frequency.

Signed-off-by: Thara Gopinath <thara@ti.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Currently the framework is extended to include x2 nodes
only for a few clocks critical for OMAP4 DVFS. This
exercise needs to be done for most of the other post divider
clocks as and when necessary.
This patch has a checkpatch.pl warning due to the clock
data base omap44xx_clks having all the entries
exceeding 80 chars. Since this data base is auto-generated
to maintain consistency the new entries added also exceed
80 chars.

 arch/arm/mach-omap2/clock44xx_data.c |   40 +++++++++++++++++++++++++++------
 1 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index e10db7a..b66e224 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -486,14 +486,21 @@ static struct clk dpll_core_m5_ck = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
+static struct clk dpll_core_m5x2_ck = {
+	.name		= "dpll_core_m5x2_ck",
+	.parent		= &dpll_core_m5_ck,
+	.ops		= &clkops_null,
+	.recalc		= &omap3_clkoutx2_recalc,
+};
+
 static const struct clksel div_core_div[] = {
-	{ .parent = &dpll_core_m5_ck, .rates = div2_1to2_rates },
+	{ .parent = &dpll_core_m5x2_ck, .rates = div2_1to2_rates },
 	{ .parent = NULL },
 };
 
 static struct clk div_core_ck = {
 	.name		= "div_core_ck",
-	.parent		= &dpll_core_m5_ck,
+	.parent		= &dpll_core_m5x2_ck,
 	.clksel		= div_core_div,
 	.clksel_reg	= OMAP4430_CM_CLKSEL_CORE,
 	.clksel_mask	= OMAP4430_CLKSEL_CORE_MASK,
@@ -512,13 +519,13 @@ static const struct clksel_rate div4_1to8_rates[] = {
 };
 
 static const struct clksel div_iva_hs_clk_div[] = {
-	{ .parent = &dpll_core_m5_ck, .rates = div4_1to8_rates },
+	{ .parent = &dpll_core_m5x2_ck, .rates = div4_1to8_rates },
 	{ .parent = NULL },
 };
 
 static struct clk div_iva_hs_clk = {
 	.name		= "div_iva_hs_clk",
-	.parent		= &dpll_core_m5_ck,
+	.parent		= &dpll_core_m5x2_ck,
 	.clksel		= div_iva_hs_clk_div,
 	.clksel_reg	= OMAP4430_CM_BYPCLK_DPLL_IVA,
 	.clksel_mask	= OMAP4430_CLKSEL_0_1_MASK,
@@ -530,7 +537,7 @@ static struct clk div_iva_hs_clk = {
 
 static struct clk div_mpu_hs_clk = {
 	.name		= "div_mpu_hs_clk",
-	.parent		= &dpll_core_m5_ck,
+	.parent		= &dpll_core_m5x2_ck,
 	.clksel		= div_iva_hs_clk_div,
 	.clksel_reg	= OMAP4430_CM_BYPCLK_DPLL_MPU,
 	.clksel_mask	= OMAP4430_CLKSEL_0_1_MASK,
@@ -656,6 +663,13 @@ static struct clk dpll_iva_m4_ck = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
+static struct clk dpll_iva_m4x2_ck = {
+	.name		= "dpll_iva_m4x2_ck",
+	.parent		= &dpll_iva_m4_ck,
+	.ops		= &clkops_null,
+	.recalc		= &omap3_clkoutx2_recalc,
+};
+
 static struct clk dpll_iva_m5_ck = {
 	.name		= "dpll_iva_m5_ck",
 	.parent		= &dpll_iva_ck,
@@ -668,6 +682,13 @@ static struct clk dpll_iva_m5_ck = {
 	.set_rate	= &omap2_clksel_set_rate,
 };
 
+static struct clk dpll_iva_m5x2_ck = {
+	.name		= "dpll_iva_m5x2_ck",
+	.parent		= &dpll_iva_m5_ck,
+	.ops		= &clkops_null,
+	.recalc		= &omap3_clkoutx2_recalc,
+};
+
 /* DPLL_MPU */
 static struct dpll_data dpll_mpu_dd = {
 	.mult_div1_reg	= OMAP4430_CM_CLKSEL_DPLL_MPU,
@@ -1807,7 +1828,7 @@ static struct clk ivahd_ick = {
 	.enable_reg	= OMAP4430_CM_IVAHD_IVAHD_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
 	.clkdm_name	= "ivahd_clkdm",
-	.parent		= &dpll_iva_m5_ck,
+	.parent		= &dpll_iva_m5x2_ck,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2161,7 +2182,7 @@ static struct clk sl2_ick = {
 	.enable_reg	= OMAP4430_CM_IVAHD_SL2_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
 	.clkdm_name	= "ivahd_clkdm",
-	.parent		= &dpll_iva_m5_ck,
+	.parent		= &dpll_iva_m5x2_ck,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2221,7 +2242,7 @@ static struct clk tesla_ick = {
 	.enable_reg	= OMAP4430_CM_TESLA_TESLA_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
 	.clkdm_name	= "tesla_clkdm",
-	.parent		= &dpll_iva_m4_ck,
+	.parent		= &dpll_iva_m4x2_ck,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2502,6 +2523,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"dpll_core_m2_ck",		&dpll_core_m2_ck,	CK_443X),
 	CLK(NULL,	"ddrphy_ck",			&ddrphy_ck,	CK_443X),
 	CLK(NULL,	"dpll_core_m5_ck",		&dpll_core_m5_ck,	CK_443X),
+	CLK(NULL,	"dpll_core_m5x2_ck",		&dpll_core_m5x2_ck,	CK_443X),
 	CLK(NULL,	"div_core_ck",			&div_core_ck,	CK_443X),
 	CLK(NULL,	"div_iva_hs_clk",		&div_iva_hs_clk,	CK_443X),
 	CLK(NULL,	"div_mpu_hs_clk",		&div_mpu_hs_clk,	CK_443X),
@@ -2513,7 +2535,9 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"iva_hsd_byp_clk_mux_ck",	&iva_hsd_byp_clk_mux_ck,	CK_443X),
 	CLK(NULL,	"dpll_iva_ck",			&dpll_iva_ck,	CK_443X),
 	CLK(NULL,	"dpll_iva_m4_ck",		&dpll_iva_m4_ck,	CK_443X),
+	CLK(NULL,	"dpll_iva_m4x2_ck",		&dpll_iva_m4x2_ck,	CK_443X),
 	CLK(NULL,	"dpll_iva_m5_ck",		&dpll_iva_m5_ck,	CK_443X),
+	CLK(NULL,	"dpll_iva_m5x2_ck",		&dpll_iva_m5x2_ck,	CK_443X),
 	CLK(NULL,	"dpll_mpu_ck",			&dpll_mpu_ck,	CK_443X),
 	CLK(NULL,	"dpll_mpu_m2_ck",		&dpll_mpu_m2_ck,	CK_443X),
 	CLK(NULL,	"per_hs_clk_div_ck",		&per_hs_clk_div_ck,	CK_443X),
-- 
1.7.0.4

