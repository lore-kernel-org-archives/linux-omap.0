From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/17] ARM: OMAP2: Clean up 24xx clock code
Date: Wed,  9 Apr 2008 14:03:19 -0700
Message-ID: <1207775003-7429-14-git-send-email-tony@atomide.com>
References: omap2-upstream-2008-04-09-210318
 <1207775003-7429-1-git-send-email-tony@atomide.com>
 <1207775003-7429-2-git-send-email-tony@atomide.com>
 <1207775003-7429-3-git-send-email-tony@atomide.com>
 <1207775003-7429-4-git-send-email-tony@atomide.com>
 <1207775003-7429-5-git-send-email-tony@atomide.com>
 <1207775003-7429-6-git-send-email-tony@atomide.com>
 <1207775003-7429-7-git-send-email-tony@atomide.com>
 <1207775003-7429-8-git-send-email-tony@atomide.com>
 <1207775003-7429-9-git-send-email-tony@atomide.com>
 <1207775003-7429-10-git-send-email-tony@atomide.com>
 <1207775003-7429-11-git-send-email-tony@atomide.com>
 <1207775003-7429-12-git-send-email-tony@atomide.com>
 <1207775003-7429-13-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:54281 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755563AbYDIVDw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 17:03:52 -0400
In-Reply-To: <1207775003-7429-13-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Clean up 24xx clock code to sync it with linux-omap tree.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock.c     |   15 +++---------
 arch/arm/mach-omap2/clock.h     |   13 +++-------
 arch/arm/mach-omap2/clock24xx.c |   46 +++++++++++++++++++-------------------
 arch/arm/mach-omap2/clock24xx.h |   37 +++++++++++++++----------------
 4 files changed, 49 insertions(+), 62 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index b76c9fc..a5b9564 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -1,20 +1,13 @@
 /*
  *  linux/arch/arm/mach-omap2/clock.c
  *
- *  Copyright (C) 2005 Texas Instruments Inc.
- *  Richard Woodruff <r-woodruff2@ti.com>
- *  Created for OMAP2.
- *
- *  Cleaned up and modified to use omap shared clock framework by
- *  Tony Lindgren <tony@atomide.com>
+ *  Copyright (C) 2005-2008 Texas Instruments, Inc.
+ *  Copyright (C) 2004-2008 Nokia Corporation
  *
- *  Copyright (C) 2007 Texas Instruments, Inc.
- *  Copyright (C) 2007 Nokia Corporation
+ *  Contacts:
+ *  Richard Woodruff <r-woodruff2@ti.com>
  *  Paul Walmsley
  *
- *  Based on omap1 clock.c, Copyright (C) 2004 - 2005 Nokia corporation
- *  Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index d9cc99c..d5980a9 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -1,16 +1,11 @@
 /*
  *  linux/arch/arm/mach-omap2/clock.h
  *
- *  Copyright (C) 2005 Texas Instruments Inc.
- *  Richard Woodruff <r-woodruff2@ti.com>
- *  Created for OMAP2.
- *
- *  Copyright (C) 2004 Nokia corporation
- *  Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
- *  Based on clocks.h by Tony Lindgren, Gordon McNutt and RidgeRun, Inc
+ *  Copyright (C) 2005-2008 Texas Instruments, Inc.
+ *  Copyright (C) 2004-2008 Nokia Corporation
  *
- *  Copyright (C) 2007 Texas Instruments, Inc.
- *  Copyright (C) 2007 Nokia Corporation
+ *  Contacts:
+ *  Richard Woodruff <r-woodruff2@ti.com>
  *  Paul Walmsley
  *
  * This program is free software; you can redistribute it and/or modify
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 615b511..ece32d8 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -1,15 +1,15 @@
 /*
  *  linux/arch/arm/mach-omap2/clock.c
  *
- *  Copyright (C) 2005 Texas Instruments Inc.
- *  Richard Woodruff <r-woodruff2@ti.com>
- *  Created for OMAP2.
+ *  Copyright (C) 2005-2008 Texas Instruments, Inc.
+ *  Copyright (C) 2004-2008 Nokia Corporation
  *
- *  Cleaned up and modified to use omap shared clock framework by
- *  Tony Lindgren <tony@atomide.com>
+ *  Contacts:
+ *  Richard Woodruff <r-woodruff2@ti.com>
+ *  Paul Walmsley
  *
- *  Based on omap1 clock.c, Copyright (C) 2004 - 2005 Nokia corporation
- *  Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ *  Based on earlier work by Tuukka Tikkanen, Tony Lindgren,
+ *  Gordon McNutt and RidgeRun, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -60,6 +60,21 @@ static struct clk *sclk;
  * Omap24xx specific clock functions
  *-------------------------------------------------------------------------*/
 
+/* This actually returns the rate of core_ck, not dpll_ck. */
+static u32 omap2_get_dpll_rate_24xx(struct clk *tclk)
+{
+	long long dpll_clk;
+	u8 amult;
+
+	dpll_clk = omap2_get_dpll_rate(tclk);
+
+	amult = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+	amult &= OMAP24XX_CORE_CLK_SRC_MASK;
+	dpll_clk *= amult;
+
+	return dpll_clk;
+}
+
 static int omap2_enable_osc_ck(struct clk *clk)
 {
 	u32 pcc;
@@ -94,21 +109,6 @@ static void omap2_sys_clk_recalc(struct clk * clk)
 }
 #endif	/* OLD_CK */
 
-/* This actually returns the rate of core_ck, not dpll_ck. */
-static u32 omap2_get_dpll_rate_24xx(struct clk *tclk)
-{
-	long long dpll_clk;
-	u8 amult;
-
-	dpll_clk = omap2_get_dpll_rate(tclk);
-
-	amult = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
-	amult &= OMAP24XX_CORE_CLK_SRC_MASK;
-	dpll_clk *= amult;
-
-	return dpll_clk;
-}
-
 /* Enable an APLL if off */
 static int omap2_clk_fixed_enable(struct clk *clk)
 {
@@ -333,7 +333,7 @@ static int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 
 	if (!found_speed) {
 		printk(KERN_INFO "Could not set MPU rate to %luMHz\n",
-	 rate / 1000000);
+		       rate / 1000000);
 		return -EINVAL;
 	}
 
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index ccf6a6c..88081ed 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -1,13 +1,12 @@
 /*
- *  linux/arch/arm/mach-omap24xx/clock.h
+ *  linux/arch/arm/mach-omap2/clock24xx.h
  *
- *  Copyright (C) 2005 Texas Instruments Inc.
- *  Richard Woodruff <r-woodruff2@ti.com>
- *  Created for OMAP2.
+ *  Copyright (C) 2005-2008 Texas Instruments, Inc.
+ *  Copyright (C) 2004-2008 Nokia Corporation
  *
- *  Copyright (C) 2004 Nokia corporation
- *  Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
- *  Based on clocks.h by Tony Lindgren, Gordon McNutt and RidgeRun, Inc
+ *  Contacts:
+ *  Richard Woodruff <r-woodruff2@ti.com>
+ *  Paul Walmsley
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -25,18 +24,18 @@
 #include "cm-regbits-24xx.h"
 #include "sdrc.h"
 
-static void omap2_table_mpu_recalc(struct clk * clk);
-static int omap2_select_table_rate(struct clk * clk, unsigned long rate);
-static long omap2_round_to_table_rate(struct clk * clk, unsigned long rate);
-static void omap2_sys_clk_recalc(struct clk * clk);
-static void omap2_osc_clk_recalc(struct clk * clk);
-static void omap2_sys_clk_recalc(struct clk * clk);
-static void omap2_dpll_recalc(struct clk * clk);
-static int omap2_clk_fixed_enable(struct clk * clk);
-static void omap2_clk_fixed_disable(struct clk * clk);
-static int omap2_enable_osc_ck(struct clk * clk);
-static void omap2_disable_osc_ck(struct clk * clk);
-static int omap2_reprogram_dpll(struct clk * clk, unsigned long rate);
+static void omap2_table_mpu_recalc(struct clk *clk);
+static int omap2_select_table_rate(struct clk *clk, unsigned long rate);
+static long omap2_round_to_table_rate(struct clk *clk, unsigned long rate);
+static void omap2_sys_clk_recalc(struct clk *clk);
+static void omap2_osc_clk_recalc(struct clk *clk);
+static void omap2_sys_clk_recalc(struct clk *clk);
+static void omap2_dpll_recalc(struct clk *clk);
+static int omap2_clk_fixed_enable(struct clk *clk);
+static void omap2_clk_fixed_disable(struct clk *clk);
+static int omap2_enable_osc_ck(struct clk *clk);
+static void omap2_disable_osc_ck(struct clk *clk);
+static int omap2_reprogram_dpll(struct clk *clk, unsigned long rate);
 
 /* Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
  * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,CM_CLKSEL_DSP
-- 
1.5.3.6

