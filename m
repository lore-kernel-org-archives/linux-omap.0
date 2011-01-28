From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 6/6] omap4: dpll: Enable auto gate control for all MX postdividers
Date: Fri, 28 Jan 2011 16:34:48 +0530
Message-ID: <1296212688-21951-7-git-send-email-santosh.shilimkar@ti.com>
References: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59135 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754612Ab1A1LFD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jan 2011 06:05:03 -0500
In-Reply-To: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

Enable auto/hw gate control for all dpll MX postdividers.
This requires the corresponding CLOCK_MX_IDLE_CONTROL to
be populated for all respective clock nodes.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index e5c59a0..0f06dd2 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -329,6 +329,7 @@ static struct clk dpll_abe_m2x2_ck = {
 	.clksel		= dpll_abe_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_ABE,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
+	.flags		= CLOCK_MX_IDLE_CONTROL,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
@@ -396,6 +397,7 @@ static struct clk dpll_abe_m3x2_ck = {
 	.clksel		= dpll_abe_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M3_DPLL_ABE,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUTHIF_DIV_MASK,
+	.flags		= CLOCK_MX_IDLE_CONTROL,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
@@ -466,6 +468,7 @@ static struct clk dpll_core_m6x2_ck = {
 	.clksel		= dpll_core_m6x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M6_DPLL_CORE,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT3_DIV_MASK,
+	.flags		= CLOCK_MX_IDLE_CONTROL,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
@@ -496,6 +499,7 @@ static struct clk dpll_core_m2_ck = {
 	.clksel		= dpll_core_m2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_CORE,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
+	.flags		= CLOCK_MX_IDLE_CONTROL,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
@@ -516,6 +520,7 @@ static struct clk dpll_core_m5x2_ck = {
 	.clksel		= dpll_core_m6x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M5_DPLL_CORE,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT2_DIV_MASK,
+	.flags		= CLOCK_MX_IDLE_CONTROL,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
@@ -582,6 +587,7 @@ static struct clk dpll_core_m4x2_ck = {
 	.clksel		= dpll_core_m6x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M4_DPLL_CORE,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT1_DIV_MASK,
+	.flags		= CLOCK_MX_IDLE_CONTROL,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
@@ -607,6 +613,7 @@ static struct clk dpll_abe_m2_ck = {
 	.clksel		= dpll_abe_m2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_ABE,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
+	.flags		= CLOCK_MX_IDLE_CONTROL,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
@@ -633,6 +640,7 @@ static struct clk dpll_core_m7x2_ck = {
 	.clksel		= dpll_core_m6x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M7_DPLL_CORE,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT4_DIV_MASK,
+	.flags		= CLOCK_MX_IDLE_CONTROL,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
@@ -705,6 +713,7 @@ static struct clk dpll_iva_m4x2_ck = {
 	.clksel		= dpll_iva_m4x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M4_DPLL_IVA,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT1_DIV_MASK,
+	.flags		= CLOCK_MX_IDLE_CONTROL,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
@@ -717,6 +726,7 @@ static struct clk dpll_iva_m5x2_ck = {
 	.clksel		= dpll_iva_m4x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M5_DPLL_IVA,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT2_DIV_MASK,
+	.flags		= CLOCK_MX_IDLE_CONTROL,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
@@ -765,6 +775,7 @@ static struct clk dpll_mpu_m2_ck = {
 	.clksel		= dpll_mpu_m2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_MPU,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
+	.flags		= CLOCK_MX_IDLE_CONTROL,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
@@ -838,6 +849,7 @@ static struct clk dpll_per_m2_ck = {
 	.clksel		= dpll_per_m2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_PER,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
+	.flags		= CLOCK_MX_IDLE_CONTROL,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
@@ -862,6 +874,7 @@ static struct clk dpll_per_m2x2_ck = {
 	.clksel		= dpll_per_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_PER,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
+	.flags		= CLOCK_MX_IDLE_CONTROL,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
@@ -888,6 +901,7 @@ static struct clk dpll_per_m4x2_ck = {
 	.clksel		= dpll_per_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M4_DPLL_PER,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT1_DIV_MASK,
+	.flags		= CLOCK_MX_IDLE_CONTROL,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
@@ -900,6 +914,7 @@ static struct clk dpll_per_m5x2_ck = {
 	.clksel		= dpll_per_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M5_DPLL_PER,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT2_DIV_MASK,
+	.flags		= CLOCK_MX_IDLE_CONTROL,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
@@ -912,6 +927,7 @@ static struct clk dpll_per_m6x2_ck = {
 	.clksel		= dpll_per_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M6_DPLL_PER,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT3_DIV_MASK,
+	.flags		= CLOCK_MX_IDLE_CONTROL,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
@@ -924,6 +940,7 @@ static struct clk dpll_per_m7x2_ck = {
 	.clksel		= dpll_per_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M7_DPLL_PER,
 	.clksel_mask	= OMAP4430_HSDIVIDER_CLKOUT4_DIV_MASK,
+	.flags		= CLOCK_MX_IDLE_CONTROL,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
@@ -980,6 +997,7 @@ static struct clk dpll_unipro_m2x2_ck = {
 	.clksel		= dpll_unipro_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_UNIPRO,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_MASK,
+	.flags		= CLOCK_MX_IDLE_CONTROL,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
@@ -1029,6 +1047,7 @@ static struct clk dpll_usb_ck = {
 static struct clk dpll_usb_clkdcoldo_ck = {
 	.name		= "dpll_usb_clkdcoldo_ck",
 	.parent		= &dpll_usb_ck,
+	.flags		= CLOCK_MX_IDLE_CONTROL,
 	.ops		= &clkops_null,
 	.recalc		= &followparent_recalc,
 };
@@ -1044,6 +1063,7 @@ static struct clk dpll_usb_m2_ck = {
 	.clksel		= dpll_usb_m2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M2_DPLL_USB,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUT_DIV_0_6_MASK,
+	.flags		= CLOCK_MX_IDLE_CONTROL,
 	.ops		= &clkops_null,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
@@ -3302,6 +3322,8 @@ int __init omap4xxx_clk_init(void)
 			omap2_init_clk_clkdm(c->lk.clk);
 			if (c->lk.clk->dpll_data)
 				omap3_dpll_allow_idle(c->lk.clk);
+			if (c->lk.clk->flags & CLOCK_MX_IDLE_CONTROL)
+				omap4_dpllmx_allow_gatectrl(c->lk.clk);
 		}
 
 	recalculate_root_clocks();
-- 
1.6.0.4

