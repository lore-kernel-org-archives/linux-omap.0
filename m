From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 7/7] omap4: dpll: Enable auto gate control for all MX postdividers
Date: Tue,  8 Feb 2011 15:40:38 +0530
Message-ID: <1297159838-30282-8-git-send-email-rnayak@ti.com>
References: <1297159838-30282-1-git-send-email-rnayak@ti.com>
 <1297159838-30282-2-git-send-email-rnayak@ti.com>
 <1297159838-30282-3-git-send-email-rnayak@ti.com>
 <1297159838-30282-4-git-send-email-rnayak@ti.com>
 <1297159838-30282-5-git-send-email-rnayak@ti.com>
 <1297159838-30282-6-git-send-email-rnayak@ti.com>
 <1297159838-30282-7-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56878 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753173Ab1BHKKz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Feb 2011 05:10:55 -0500
In-Reply-To: <1297159838-30282-7-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, b-cousson@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Enable hardware gate control for all dpll MX postdividers.
This requires the allow_idle/deny_idle functions to be
populated for all clock nodes (mx post dividers) in
clkops.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock.c          |    5 ++++
 arch/arm/mach-omap2/clock.h          |    1 +
 arch/arm/mach-omap2/clock44xx_data.c |   40 +++++++++++++++++-----------------
 3 files changed, 26 insertions(+), 20 deletions(-)

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
index b843b6e..157c51f 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -328,7 +328,7 @@ static struct clk dpll_abe_m2x2_ck = {
 	.clksel		= dpll_abe_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_ABE,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -395,7 +395,7 @@ static struct clk dpll_abe_m3x2_ck = {
 	.clksel		= dpll_abe_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M3_DPLL_ABE,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUTHIF_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -465,7 +465,7 @@ static struct clk dpll_core_m6x2_ck = {
 	.clksel		= dpll_core_m6x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M6_DPLL_CORE,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT3_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -495,7 +495,7 @@ static struct clk dpll_core_m2_ck = {
 	.clksel		= dpll_core_m2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_CORE,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -515,7 +515,7 @@ static struct clk dpll_core_m5x2_ck = {
 	.clksel		= dpll_core_m6x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M5_DPLL_CORE,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT2_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -581,7 +581,7 @@ static struct clk dpll_core_m4x2_ck = {
 	.clksel		= dpll_core_m6x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M4_DPLL_CORE,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT1_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -606,7 +606,7 @@ static struct clk dpll_abe_m2_ck = {
 	.clksel		= dpll_abe_m2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_ABE,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -632,7 +632,7 @@ static struct clk dpll_core_m7x2_ck = {
 	.clksel		= dpll_core_m6x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M7_DPLL_CORE,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT4_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -704,7 +704,7 @@ static struct clk dpll_iva_m4x2_ck = {
 	.clksel		= dpll_iva_m4x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M4_DPLL_IVA,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT1_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -716,7 +716,7 @@ static struct clk dpll_iva_m5x2_ck = {
 	.clksel		= dpll_iva_m4x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M5_DPLL_IVA,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT2_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -764,7 +764,7 @@ static struct clk dpll_mpu_m2_ck = {
 	.clksel		= dpll_mpu_m2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_MPU,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -837,7 +837,7 @@ static struct clk dpll_per_m2_ck = {
 	.clksel		= dpll_per_m2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_PER,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -861,7 +861,7 @@ static struct clk dpll_per_m2x2_ck = {
 	.clksel		= dpll_per_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_PER,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -887,7 +887,7 @@ static struct clk dpll_per_m4x2_ck = {
 	.clksel		= dpll_per_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M4_DPLL_PER,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT1_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -899,7 +899,7 @@ static struct clk dpll_per_m5x2_ck = {
 	.clksel		= dpll_per_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M5_DPLL_PER,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT2_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -911,7 +911,7 @@ static struct clk dpll_per_m6x2_ck = {
 	.clksel		= dpll_per_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M6_DPLL_PER,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT3_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -923,7 +923,7 @@ static struct clk dpll_per_m7x2_ck = {
 	.clksel		= dpll_per_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M7_DPLL_PER,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT4_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -979,7 +979,7 @@ static struct clk dpll_unipro_m2x2_ck = {
 	.clksel		= dpll_unipro_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_UNIPRO,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -1028,7 +1028,7 @@ static struct clk dpll_usb_ck = {
 static struct clk dpll_usb_clkdcoldo_ck = {
 	.name		= "dpll_usb_clkdcoldo_ck",
 	.parent		= &dpll_usb_ck,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1043,7 +1043,7 @@ static struct clk dpll_usb_m2_ck = {
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

