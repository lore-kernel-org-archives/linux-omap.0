From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 15/28] omap2 clock: convert remaining clksel clocks to use
	omap2_clksel_recalc
Date: Mon, 20 Aug 2007 03:54:02 -0600
Message-ID: <20070820095531.435845303@pwsan.com>
References: <20070820095347.933473149@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=use_clksel_recalc_for_all_clksel_clks.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This completes the transition to struct clksel/clksel_rate by converting the
remaining clksel clocks to call omap2_clksel_recalc() on rate recalculation.
Also remove RATE_FIXED from some clocks that can now recalculate their own
rates correctly via clksel.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.h |   56 +++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.h
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -1,5 +1,5 @@
 /*
- *  linux/arch/arm/mach-omap24xx/clock.h
+ *  linux/arch/arm/mach-omap2/clock.h
  *
  *  Copyright (C) 2005 Texas Instruments Inc.
  *  Richard Woodruff <r-woodruff2@ti.com>
@@ -9,6 +9,10 @@
  *  Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
  *  Based on clocks.h by Tony Lindgren, Gordon McNutt and RidgeRun, Inc
  *
+ *  Copyright (C) 2007 Texas Instruments, Inc.
+ *  Copyright (C) 2007 Nokia Corporation
+ *  Revised by Paul Walmsley
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -687,16 +691,15 @@ static const struct clksel func_54m_clks
 static struct clk func_54m_ck = {
 	.name		= "func_54m_ck",
 	.parent		= &apll54_ck,	/* can also be alt_clk */
-	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES |
+				CM_PLL_SEL1 | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
 	.src_offset	= OMAP24XX_54M_SOURCE_SHIFT,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_54M_SOURCE,
 	.clksel		= func_54m_clksel,
-	.recalc		= &propagate_rate,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk core_ck = {
@@ -728,15 +731,13 @@ static const struct clksel func_96m_clks
 static struct clk func_96m_ck = {
 	.name		= "func_96m_ck",
 	.parent		= &apll96_ck,
-	.rate		= 96000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
+				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP2430_96M_SOURCE,
 	.clksel		= func_96m_clksel,
-	.recalc		= &propagate_rate,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 /* func_48m_ck */
@@ -760,16 +761,15 @@ static const struct clksel func_48m_clks
 static struct clk func_48m_ck = {
 	.name		= "func_48m_ck",
 	.parent		= &apll96_ck,	 /* 96M or Alt */
-	.rate		= 48000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES |
+				CM_PLL_SEL1 | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
 	.src_offset	= OMAP24XX_48M_SOURCE_SHIFT,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP24XX_48M_SOURCE,
 	.clksel		= func_48m_clksel,
-	.recalc		= &propagate_rate,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk func_12m_ck = {
@@ -828,7 +828,6 @@ static const struct clksel common_clkout
 static struct clk sys_clkout_src = {
 	.name		= "sys_clkout_src",
 	.parent		= &func_54m_ck,
-	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				CM_SYSCLKOUT_SEL1 | RATE_CKCTL |
 				RATE_PROPAGATES,
@@ -839,7 +838,7 @@ static struct clk sys_clkout_src = {
 	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP24XX_CLKOUT_SOURCE_MASK,
 	.clksel		= common_clkout_src_clksel,
-	.recalc		= &propagate_rate,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static const struct clksel_rate common_clkout_rates[] = {
@@ -882,7 +881,7 @@ static struct clk sys_clkout2_src = {
 	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
 	.clksel_mask	= OMAP2420_CLKOUT2_SOURCE_MASK,
 	.clksel		= common_clkout_src_clksel,
-	.recalc		= &propagate_rate,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static const struct clksel sys_clkout2_clksel[] = {
@@ -900,7 +899,7 @@ static struct clk sys_clkout2 = {
 	.clksel_mask	= OMAP2420_CLKOUT2_DIV_MASK,
 	.clksel		= sys_clkout2_clksel,
 	.rate_offset	= OMAP2420_CLKOUT2_DIV_SHIFT,
-	.recalc		= &propagate_rate,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk emul_ck = {
@@ -1466,8 +1465,7 @@ static struct clk dss2_fck = {		/* Alt c
 	.name		= "dss2_fck",
 	.parent		= &sys_ck,		/* fixed at sys_ck or 48MHz */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_CORE_SEL1 | RATE_FIXED |
-				DELAYED_APP,
+				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP24XX_EN_DSS2_SHIFT,
 	.src_offset	= OMAP24XX_CLKSEL_DSS2_SHIFT,
@@ -1536,7 +1534,7 @@ static struct clk gpt1_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT1_MASK,
 	.clksel		= gpt_clksel,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt2_ick = {
@@ -1560,7 +1558,7 @@ static struct clk gpt2_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT2_MASK,
 	.clksel		= gpt_clksel,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt3_ick = {
@@ -1584,7 +1582,7 @@ static struct clk gpt3_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT3_MASK,
 	.clksel		= gpt_clksel,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt4_ick = {
@@ -1608,7 +1606,7 @@ static struct clk gpt4_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT4_MASK,
 	.clksel		= gpt_clksel,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt5_ick = {
@@ -1632,7 +1630,7 @@ static struct clk gpt5_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT5_MASK,
 	.clksel		= gpt_clksel,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt6_ick = {
@@ -1656,7 +1654,7 @@ static struct clk gpt6_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT6_MASK,
 	.clksel		= gpt_clksel,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt7_ick = {
@@ -1680,7 +1678,7 @@ static struct clk gpt7_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT7_MASK,
 	.clksel		= gpt_clksel,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt8_ick = {
@@ -1704,7 +1702,7 @@ static struct clk gpt8_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT8_MASK,
 	.clksel		= gpt_clksel,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt9_ick = {
@@ -1728,7 +1726,7 @@ static struct clk gpt9_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT9_MASK,
 	.clksel		= gpt_clksel,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt10_ick = {
@@ -1752,7 +1750,7 @@ static struct clk gpt10_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT10_MASK,
 	.clksel		= gpt_clksel,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt11_ick = {
@@ -1776,7 +1774,7 @@ static struct clk gpt11_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT11_MASK,
 	.clksel		= gpt_clksel,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt12_ick = {
@@ -1800,7 +1798,7 @@ static struct clk gpt12_fck = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT12_MASK,
 	.clksel		= gpt_clksel,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk mcbsp1_ick = {

-- 
