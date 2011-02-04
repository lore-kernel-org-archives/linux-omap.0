From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 8/9] omap4: dpll: Enable auto gate control for all MX postdividers
Date: Fri,  4 Feb 2011 15:29:03 +0530
Message-ID: <1296813544-25170-9-git-send-email-santosh.shilimkar@ti.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55027 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755014Ab1BDJ7Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Feb 2011 04:59:25 -0500
In-Reply-To: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

Enable hardware gate control for all dpll MX postdividers.
This requires the allow_idle/deny_idle functions to be
populated for all clock nodes (mx post dividers) in
clkops.

The autogen script is updated for the same.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock.c          |    5 ++++
 arch/arm/mach-omap2/clock.h          |    1 +
 arch/arm/mach-omap2/clock44xx_data.c |   40 +++++++++++++++++-----------------
 3 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 8ec618e..73a2886 100644
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
index 3fb8d2b..3ca47ae 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -329,7 +329,7 @@ static struct clk dpll_abe_m2x2_ck = {
 	.clksel		= dpll_abe_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_ABE,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -396,7 +396,7 @@ static struct clk dpll_abe_m3x2_ck = {
 	.clksel		= dpll_abe_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M3_DPLL_ABE,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUTHIF_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -466,7 +466,7 @@ static struct clk dpll_core_m6x2_ck = {
 	.clksel		= dpll_core_m6x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M6_DPLL_CORE,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT3_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -496,7 +496,7 @@ static struct clk dpll_core_m2_ck = {
 	.clksel		= dpll_core_m2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_CORE,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -516,7 +516,7 @@ static struct clk dpll_core_m5x2_ck = {
 	.clksel		= dpll_core_m6x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M5_DPLL_CORE,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT2_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -582,7 +582,7 @@ static struct clk dpll_core_m4x2_ck = {
 	.clksel		= dpll_core_m6x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M4_DPLL_CORE,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT1_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -607,7 +607,7 @@ static struct clk dpll_abe_m2_ck = {
 	.clksel		= dpll_abe_m2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_ABE,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -633,7 +633,7 @@ static struct clk dpll_core_m7x2_ck = {
 	.clksel		= dpll_core_m6x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M7_DPLL_CORE,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT4_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -705,7 +705,7 @@ static struct clk dpll_iva_m4x2_ck = {
 	.clksel		= dpll_iva_m4x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M4_DPLL_IVA,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT1_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -717,7 +717,7 @@ static struct clk dpll_iva_m5x2_ck = {
 	.clksel		= dpll_iva_m4x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M5_DPLL_IVA,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT2_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -765,7 +765,7 @@ static struct clk dpll_mpu_m2_ck = {
 	.clksel		= dpll_mpu_m2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_MPU,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -838,7 +838,7 @@ static struct clk dpll_per_m2_ck = {
 	.clksel		= dpll_per_m2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_PER,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -862,7 +862,7 @@ static struct clk dpll_per_m2x2_ck = {
 	.clksel		= dpll_per_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_PER,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -888,7 +888,7 @@ static struct clk dpll_per_m4x2_ck = {
 	.clksel		= dpll_per_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M4_DPLL_PER,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT1_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -900,7 +900,7 @@ static struct clk dpll_per_m5x2_ck = {
 	.clksel		= dpll_per_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M5_DPLL_PER,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT2_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -912,7 +912,7 @@ static struct clk dpll_per_m6x2_ck = {
 	.clksel		= dpll_per_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M6_DPLL_PER,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT3_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -924,7 +924,7 @@ static struct clk dpll_per_m7x2_ck = {
 	.clksel		= dpll_per_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M7_DPLL_PER,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT4_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -980,7 +980,7 @@ static struct clk dpll_unipro_m2x2_ck = {
 	.clksel		= dpll_unipro_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_UNIPRO,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -1029,7 +1029,7 @@ static struct clk dpll_usb_ck = {
 static struct clk dpll_usb_clkdcoldo_ck = {
 	.name		= "dpll_usb_clkdcoldo_ck",
 	.parent		= &dpll_usb_ck,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &followparent_recalc,
 };
 
@@ -1044,7 +1044,7 @@ static struct clk dpll_usb_m2_ck = {
 	.clksel		= dpll_usb_m2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_USB,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_0_6_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap4_dpllmx_ops,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-- 
1.6.0.4

