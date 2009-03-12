From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 07/86] [ARM] omap: don't use clkops_omap2_dflt_wait for non-ICLK/FCLK clocks
Date: Thu, 12 Mar 2009 11:27:17 -0700
Message-ID: <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f163.google.com ([209.85.217.163]:60567 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754324AbZCLS33 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:29:29 -0400
Received: by mail-gx0-f163.google.com with SMTP id 7so458514gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:29:27 -0700 (PDT)
In-Reply-To: <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

The original code in omap2_clk_wait_ready() used to check the low 8
bits to determine whether they were within the FCLKEN or ICLKEN
registers.  Specifically, the test is satisfied when these offsets
are used:

 CM_FCLKEN, CM_FCLKEN1, CM_CLKEN, OMAP24XX_CM_FCLKEN2, CM_ICLKEN,
 CM_ICLKEN1, CM_ICLKEN2, CM_ICLKEN3, OMAP24XX_CM_ICLKEN4
 OMAP3430_CM_CLKEN_PLL, OMAP3430ES2_CM_CLKEN2

If one of these offsets isn't used, omap2_clk_wait_ready() merely
returns without doing anything.  So we should use the non-wait clkops
version instead and eliminate that conditional.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock.c     |   14 ++++++--------
 arch/arm/mach-omap2/clock24xx.h |    6 +++---
 arch/arm/mach-omap2/clock34xx.h |   12 ++++++------
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 986c9f5..76afb7b 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -228,14 +228,12 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	 * it and pull it into struct clk itself somehow.
 	 */
 	reg = clk->enable_reg;
-	if ((((u32)reg & 0xff) >= CM_FCLKEN1) &&
-	    (((u32)reg & 0xff) <= OMAP24XX_CM_FCLKEN2))
-		other_reg = (void __iomem *)(((u32)reg & ~0xf0) | 0x10); /* CM_ICLKEN* */
-	else if ((((u32)reg & 0xff) >= CM_ICLKEN1) &&
-		 (((u32)reg & 0xff) <= OMAP24XX_CM_ICLKEN4))
-		other_reg = (void __iomem *)(((u32)reg & ~0xf0) | 0x00); /* CM_FCLKEN* */
-	else
-		return;
+
+	/*
+	 * Convert CM_ICLKEN* <-> CM_FCLKEN*.  This conversion assumes
+	 * it's just a matter of XORing the bits.
+	 */
+	other_reg = (void __iomem *)((u32)reg ^ (CM_FCLKEN ^ CM_ICLKEN));
 
 	/* Check if both functional and interface clocks
 	 * are running. */
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index d386b3d..486fd80 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -890,7 +890,7 @@ static const struct clksel common_clkout_src_clksel[] = {
 
 static struct clk sys_clkout_src = {
 	.name		= "sys_clkout_src",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &func_54m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_PROPAGATES,
@@ -937,7 +937,7 @@ static struct clk sys_clkout = {
 /* In 2430, new in 2420 ES2 */
 static struct clk sys_clkout2_src = {
 	.name		= "sys_clkout2_src",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &func_54m_ck,
 	.flags		= CLOCK_IN_OMAP242X | RATE_PROPAGATES,
 	.clkdm_name	= "wkup_clkdm",
@@ -974,7 +974,7 @@ static struct clk sys_clkout2 = {
 
 static struct clk emul_ck = {
 	.name		= "emul_ck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &func_54m_ck,
 	.flags		= CLOCK_IN_OMAP242X,
 	.clkdm_name	= "wkup_clkdm",
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 1ff05d3..335ef88 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -216,7 +216,7 @@ static struct clk mcbsp_clks = {
 
 static struct clk sys_clkout1 = {
 	.name		= "sys_clkout1",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &osc_sys_ck,
 	.enable_reg	= OMAP3430_PRM_CLKOUT_CTRL,
 	.enable_bit	= OMAP3430_CLKOUT_EN_SHIFT,
@@ -967,7 +967,7 @@ static const struct clksel clkout2_src_clksel[] = {
 
 static struct clk clkout2_src_ck = {
 	.name		= "clkout2_src_ck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP3430_CM_CLKOUT_CTRL,
 	.enable_bit	= OMAP3430_CLKOUT2_EN_SHIFT,
@@ -1356,7 +1356,7 @@ static struct clk gpt11_fck = {
 
 static struct clk cpefuse_fck = {
 	.name		= "cpefuse_fck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &sys_ck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_CPEFUSE_SHIFT,
@@ -1366,7 +1366,7 @@ static struct clk cpefuse_fck = {
 
 static struct clk ts_fck = {
 	.name		= "ts_fck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &omap_32k_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_TS_SHIFT,
@@ -1376,7 +1376,7 @@ static struct clk ts_fck = {
 
 static struct clk usbtll_fck = {
 	.name		= "usbtll_fck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &omap_120m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_USBTLL_SHIFT,
@@ -2295,7 +2295,7 @@ static struct clk usbhost_ick = {
 
 static struct clk usbhost_sar_fck = {
 	.name		= "usbhost_sar_fck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &osc_sys_ck,
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_PRM_REGADDR(OMAP3430ES2_USBHOST_MOD, PM_PWSTCTRL),
-- 
1.6.1.2

