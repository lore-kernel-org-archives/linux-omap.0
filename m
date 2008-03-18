From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/17] ARM: OMAP2: Clean up 24xx clock code
Date: Tue, 18 Mar 2008 16:02:11 +0200
Message-ID: <1205848935-12078-14-git-send-email-tony@atomide.com>
References: omap2-upstream-2008-03-18-160209
	<1205848935-12078-1-git-send-email-tony@atomide.com>
	<1205848935-12078-2-git-send-email-tony@atomide.com>
	<1205848935-12078-3-git-send-email-tony@atomide.com>
	<1205848935-12078-4-git-send-email-tony@atomide.com>
	<1205848935-12078-5-git-send-email-tony@atomide.com>
	<1205848935-12078-6-git-send-email-tony@atomide.com>
	<1205848935-12078-7-git-send-email-tony@atomide.com>
	<1205848935-12078-8-git-send-email-tony@atomide.com>
	<1205848935-12078-9-git-send-email-tony@atomide.com>
	<1205848935-12078-10-git-send-email-tony@atomide.com>
	<1205848935-12078-11-git-send-email-tony@atomide.com>
	<1205848935-12078-12-git-send-email-tony@atomide.com>
	<1205848935-12078-13-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <1205848935-12078-13-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Clean up 24xx clock code to sync it with linux-omap tree.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock.c     |   15 +++---------
 arch/arm/mach-omap2/clock.h     |   13 +++-------
 arch/arm/mach-omap2/clock24xx.c |   46 +++++++++++++++++++-------------------
 arch/arm/mach-omap2/clock24xx.h |   37 +++++++++++++++----------------
 4 files changed, 49 insertions(+), 62 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 5cf88b7..15dd319 100644
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
index 4cba747..b291f14 100644
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
index 0c8ae09..b6c408c 100644
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
@@ -59,6 +59,21 @@ static struct clk *sclk;
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
@@ -93,21 +108,6 @@ static void omap2_sys_clk_recalc(struct clk * clk)
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
@@ -332,7 +332,7 @@ static int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 
 	if (!found_speed) {
 		printk(KERN_INFO "Could not set MPU rate to %luMHz\n",
-	 rate / 1000000);
+		       rate / 1000000);
 		return -EINVAL;
 	}
 
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 559eade..78bc755 100644
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


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
