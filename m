From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 7/7] omap4: dpll: Enable auto gate control for all MX postdividers
Date: Thu, 10 Feb 2011 14:46:40 +0530
Message-ID: <1297329400-5936-8-git-send-email-rnayak@ti.com>
References: <1297329400-5936-1-git-send-email-rnayak@ti.com>
 <1297329400-5936-2-git-send-email-rnayak@ti.com>
 <1297329400-5936-3-git-send-email-rnayak@ti.com>
 <1297329400-5936-4-git-send-email-rnayak@ti.com>
 <1297329400-5936-5-git-send-email-rnayak@ti.com>
 <1297329400-5936-6-git-send-email-rnayak@ti.com>
 <1297329400-5936-7-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33589 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345Ab1BJJQ6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Feb 2011 04:16:58 -0500
In-Reply-To: <1297329400-5936-7-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, b-cousson@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Enable hardware gate control for all dpll MX and X2 postdividers.
This requires the allow_idle/deny_idle functions to be
populated for all clock nodes (mx/x2 post dividers) in
clkops.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock.c          |    5 +++
 arch/arm/mach-omap2/clock.h          |    1 +
 arch/arm/mach-omap2/clock44xx_data.c |   52 +++++++++++++++++++--------------
 3 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 909e3c5..6ec4c67 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -388,6 +388,11 @@ const struct clkops clkops_omap3_core_dpll_ops = {
 
 #endif
 
+const struct clkops clkops_omap4_dpllmx_ops = {
+	.allow_idle	= omap4_dpllmx_allow_gatectrl,
+	.deny_idle	= omap4_dpllmx_deny_gatectrl,
+};
+
 /*
  * OMAP2+ clock reset and init functions
  */
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index c450d69..0725a6a 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -150,5 +150,6 @@ extern void omap2_clk_exit_cpufreq_table(struct cpufreq_frequency_table **table)
 
 extern const struct clkops clkops_omap3_noncore_dpll_ops;
 extern const struct clkops clkops_omap3_core_dpll_ops;
+extern const struct clkops clkops_omap4_dpllmx_ops;
 
 #endif
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index b843b6e..dcbe105 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -278,8 +278,10 @@ static struct clk dpll_abe_ck = {
 static struct clk dpll_abe_x2_ck = {
 	.name		= "dpll_abe_x2_ck",
 	.parent		= &dpll_abe_ck,
-	.ops		= &clkops_null,
+	.flags		= CLOCK_CLKOUTX2,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap3_clkoutx2_recalc,
+	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_ABE,
 };
 
 static const struct clksel_rate div31_1to31_rates[] = {
@@ -328,7 +330,7 @@ static struct clk dpll_abe_m2x2_ck = {
 	.clksel		= dpll_abe_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_ABE,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -395,7 +397,7 @@ static struct clk dpll_abe_m3x2_ck = {
 	.clksel		= dpll_abe_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M3_DPLL_ABE,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUTHIF_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -450,6 +452,7 @@ static struct clk dpll_core_ck = {
 static struct clk dpll_core_x2_ck = {
 	.name		= "dpll_core_x2_ck",
 	.parent		= &dpll_core_ck,
+	.flags		= CLOCK_CLKOUTX2,
 	.ops		= &clkops_null,
 	.recalc		= &omap3_clkoutx2_recalc,
 };
@@ -465,7 +468,7 @@ static struct clk dpll_core_m6x2_ck = {
 	.clksel		= dpll_core_m6x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M6_DPLL_CORE,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT3_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -495,7 +498,7 @@ static struct clk dpll_core_m2_ck = {
 	.clksel		= dpll_core_m2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_CORE,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -515,7 +518,7 @@ static struct clk dpll_core_m5x2_ck = {
 	.clksel		= dpll_core_m6x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M5_DPLL_CORE,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT2_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -581,7 +584,7 @@ static struct clk dpll_core_m4x2_ck = {
 	.clksel		= dpll_core_m6x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M4_DPLL_CORE,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT1_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -606,7 +609,7 @@ static struct clk dpll_abe_m2_ck = {
 	.clksel		= dpll_abe_m2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_ABE,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -632,7 +635,7 @@ static struct clk dpll_core_m7x2_ck = {
 	.clksel		= dpll_core_m6x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M7_DPLL_CORE,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT4_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -689,6 +692,7 @@ static struct clk dpll_iva_ck = {
 static struct clk dpll_iva_x2_ck = {
 	.name		= "dpll_iva_x2_ck",
 	.parent		= &dpll_iva_ck,
+	.flags		= CLOCK_CLKOUTX2,
 	.ops		= &clkops_null,
 	.recalc		= &omap3_clkoutx2_recalc,
 };
@@ -704,7 +708,7 @@ static struct clk dpll_iva_m4x2_ck = {
 	.clksel		= dpll_iva_m4x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M4_DPLL_IVA,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT1_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -716,7 +720,7 @@ static struct clk dpll_iva_m5x2_ck = {
 	.clksel		= dpll_iva_m4x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M5_DPLL_IVA,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT2_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -764,7 +768,7 @@ static struct clk dpll_mpu_m2_ck = {
 	.clksel		= dpll_mpu_m2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_MPU,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -837,7 +841,7 @@ static struct clk dpll_per_m2_ck = {
 	.clksel		= dpll_per_m2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_PER,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -846,8 +850,10 @@ static struct clk dpll_per_m2_ck = {
 static struct clk dpll_per_x2_ck = {
 	.name		= "dpll_per_x2_ck",
 	.parent		= &dpll_per_ck,
-	.ops		= &clkops_null,
+	.flags		= CLOCK_CLKOUTX2,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap3_clkoutx2_recalc,
+	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_PER,
 };
 
 static const struct clksel dpll_per_m2x2_div[] = {
@@ -861,7 +867,7 @@ static struct clk dpll_per_m2x2_ck = {
 	.clksel		= dpll_per_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_PER,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -887,7 +893,7 @@ static struct clk dpll_per_m4x2_ck = {
 	.clksel		= dpll_per_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M4_DPLL_PER,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT1_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -899,7 +905,7 @@ static struct clk dpll_per_m5x2_ck = {
 	.clksel		= dpll_per_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M5_DPLL_PER,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT2_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -911,7 +917,7 @@ static struct clk dpll_per_m6x2_ck = {
 	.clksel		= dpll_per_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M6_DPLL_PER,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT3_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -923,7 +929,7 @@ static struct clk dpll_per_m7x2_ck = {
 	.clksel		= dpll_per_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M7_DPLL_PER,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT4_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -964,6 +970,7 @@ static struct clk dpll_unipro_ck = {
 static struct clk dpll_unipro_x2_ck = {
 	.name		= "dpll_unipro_x2_ck",
 	.parent		= &dpll_unipro_ck,
+	.flags		= CLOCK_CLKOUTX2,
 	.ops		= &clkops_null,
 	.recalc		= &omap3_clkoutx2_recalc,
 };
@@ -979,7 +986,7 @@ static struct clk dpll_unipro_m2x2_ck = {
 	.clksel		= dpll_unipro_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_UNIPRO,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -1028,7 +1035,8 @@ static struct clk dpll_usb_ck = {
 static struct clk dpll_usb_clkdcoldo_ck = {
 	.name		= "dpll_usb_clkdcoldo_ck",
 	.parent		= &dpll_usb_ck,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
+	.clksel_reg	= OMAP4430_CM_CLKDCOLDO_DPLL_USB,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1043,7 +1051,7 @@ static struct clk dpll_usb_m2_ck = {
 	.clksel		= dpll_usb_m2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_USB,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_0_6_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-- 
1.7.0.4

