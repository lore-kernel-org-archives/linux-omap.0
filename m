From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v2 04/11] OMAP4: Extend clock data.
Date: Sat, 25 Sep 2010 18:21:19 +0530
Message-ID: <1285419086-13047-5-git-send-email-thara@ti.com>
References: <1285419086-13047-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53967 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945Ab0IYMvj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Sep 2010 08:51:39 -0400
In-Reply-To: <1285419086-13047-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch extends the OMAP4 clock data to include
various x2 clockc nodes as the clock framework
skips a *2 whie calculating the dpll locked frequency.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |   40 +++++++++++++++++++++++++++------
 1 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index edf2c28..3652fda 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -481,14 +481,21 @@ static struct clk dpll_core_m5_ck = {
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
@@ -507,13 +514,13 @@ static const struct clksel_rate div4_1to8_rates[] = {
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
@@ -525,7 +532,7 @@ static struct clk div_iva_hs_clk = {
 
 static struct clk div_mpu_hs_clk = {
 	.name		= "div_mpu_hs_clk",
-	.parent		= &dpll_core_m5_ck,
+	.parent		= &dpll_core_m5x2_ck,
 	.clksel		= div_iva_hs_clk_div,
 	.clksel_reg	= OMAP4430_CM_BYPCLK_DPLL_MPU,
 	.clksel_mask	= OMAP4430_CLKSEL_0_1_MASK,
@@ -651,6 +658,13 @@ static struct clk dpll_iva_m4_ck = {
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
@@ -663,6 +677,13 @@ static struct clk dpll_iva_m5_ck = {
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
@@ -1350,7 +1371,7 @@ static struct clk dsp_fck = {
 	.enable_reg	= OMAP4430_CM_TESLA_TESLA_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
 	.clkdm_name	= "tesla_clkdm",
-	.parent		= &dpll_iva_m4_ck,
+	.parent		= &dpll_iva_m4x2_ck,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1725,7 +1746,7 @@ static struct clk iva_fck = {
 	.enable_reg	= OMAP4430_CM_IVAHD_IVAHD_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
 	.clkdm_name	= "ivahd_clkdm",
-	.parent		= &dpll_iva_m5_ck,
+	.parent		= &dpll_iva_m5x2_ck,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2089,7 +2110,7 @@ static struct clk sl2if_ick = {
 	.enable_reg	= OMAP4430_CM_IVAHD_SL2_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
 	.clkdm_name	= "ivahd_clkdm",
-	.parent		= &dpll_iva_m5_ck,
+	.parent		= &dpll_iva_m5x2_ck,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2782,6 +2803,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"dpll_core_m2_ck",		&dpll_core_m2_ck,	CK_443X),
 	CLK(NULL,	"ddrphy_ck",			&ddrphy_ck,	CK_443X),
 	CLK(NULL,	"dpll_core_m5_ck",		&dpll_core_m5_ck,	CK_443X),
+	CLK(NULL,	"dpll_core_m5x2_ck",		&dpll_core_m5x2_ck,	CK_443X),
 	CLK(NULL,	"div_core_ck",			&div_core_ck,	CK_443X),
 	CLK(NULL,	"div_iva_hs_clk",		&div_iva_hs_clk,	CK_443X),
 	CLK(NULL,	"div_mpu_hs_clk",		&div_mpu_hs_clk,	CK_443X),
@@ -2793,7 +2815,9 @@ static struct omap_clk omap44xx_clks[] = {
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

