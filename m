From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 06/86] [ARM] omap: eliminate unnecessary conditionals in omap2_clk_wait_ready
Date: Thu, 12 Mar 2009 11:27:16 -0700
Message-ID: <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533AbZCLS32 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:29:28 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:29:26 -0700 (PDT)
In-Reply-To: <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

Rather than employing run-time tests in omap2_clk_wait_ready() to
decide whether we need to wait for the clock to become ready, we
can set the .ops appropriately.

This change deals with the OMAP24xx and OMAP34xx conditionals only.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock.c     |   42 ++++++++++++++++++++------------------
 arch/arm/mach-omap2/clock.h     |    1 +
 arch/arm/mach-omap2/clock24xx.h |   10 ++++----
 arch/arm/mach-omap2/clock34xx.h |   14 ++++++------
 4 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 8c09711..986c9f5 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -237,23 +237,6 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	else
 		return;
 
-	/* REVISIT: What are the appropriate exclusions for 34XX? */
-	/* No check for DSS or cam clocks */
-	if (cpu_is_omap24xx() && ((u32)reg & 0x0f) == 0) { /* CM_{F,I}CLKEN1 */
-		if (clk->enable_bit == OMAP24XX_EN_DSS2_SHIFT ||
-		    clk->enable_bit == OMAP24XX_EN_DSS1_SHIFT ||
-		    clk->enable_bit == OMAP24XX_EN_CAM_SHIFT)
-			return;
-	}
-
-	/* REVISIT: What are the appropriate exclusions for 34XX? */
-	/* OMAP3: ignore DSS-mod clocks */
-	if (cpu_is_omap34xx() &&
-	    (((u32)reg & ~0xff) == (u32)OMAP_CM_REGADDR(OMAP3430_DSS_MOD, 0) ||
-	     ((((u32)reg & ~0xff) == (u32)OMAP_CM_REGADDR(CORE_MOD, 0)) &&
-	     clk->enable_bit == OMAP3430_EN_SSI_SHIFT)))
-		return;
-
 	/* Check if both functional and interface clocks
 	 * are running. */
 	bit = 1 << clk->enable_bit;
@@ -264,7 +247,7 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	omap2_wait_clock_ready(st_reg, bit, clk->name);
 }
 
-static int omap2_dflt_clk_enable_wait(struct clk *clk)
+static int omap2_dflt_clk_enable(struct clk *clk)
 {
 	u32 regval32;
 
@@ -282,11 +265,25 @@ static int omap2_dflt_clk_enable_wait(struct clk *clk)
 	__raw_writel(regval32, clk->enable_reg);
 	wmb();
 
-	omap2_clk_wait_ready(clk);
-
 	return 0;
 }
 
+static int omap2_dflt_clk_enable_wait(struct clk *clk)
+{
+	int ret;
+
+	if (unlikely(clk->enable_reg == NULL)) {
+		printk(KERN_ERR "clock.c: Enable for %s without enable code\n",
+		       clk->name);
+		return 0; /* REVISIT: -EINVAL */
+	}
+
+	ret = omap2_dflt_clk_enable(clk);
+	if (ret == 0)
+		omap2_clk_wait_ready(clk);
+	return ret;
+}
+
 static void omap2_dflt_clk_disable(struct clk *clk)
 {
 	u32 regval32;
@@ -315,6 +312,11 @@ const struct clkops clkops_omap2_dflt_wait = {
 	.disable	= omap2_dflt_clk_disable,
 };
 
+const struct clkops clkops_omap2_dflt = {
+	.enable		= omap2_dflt_clk_enable,
+	.disable	= omap2_dflt_clk_disable,
+};
+
 /* Enables clock without considering parent dependencies or use count
  * REVISIT: Maybe change this to use clk->enable like on omap1?
  */
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index d4bdb59..b0358b6 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -52,6 +52,7 @@ int omap2_wait_clock_ready(void __iomem *reg, u32 cval, const char *name);
 void omap2_clk_prepare_for_reboot(void);
 
 extern const struct clkops clkops_omap2_dflt_wait;
+extern const struct clkops clkops_omap2_dflt;
 
 extern u8 cpu_mask;
 
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index b59bf90..d386b3d 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -1455,7 +1455,7 @@ static const struct clksel dss1_fck_clksel[] = {
 
 static struct clk dss_ick = {		/* Enables both L3,L4 ICLK's */
 	.name		= "dss_ick",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &l4_ck,	/* really both l3 and l4 */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "dss_clkdm",
@@ -1466,7 +1466,7 @@ static struct clk dss_ick = {		/* Enables both L3,L4 ICLK's */
 
 static struct clk dss1_fck = {
 	.name		= "dss1_fck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &core_ck,		/* Core or sys */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				DELAYED_APP,
@@ -1500,7 +1500,7 @@ static const struct clksel dss2_fck_clksel[] = {
 
 static struct clk dss2_fck = {		/* Alt clk used in power management */
 	.name		= "dss2_fck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &sys_ck,		/* fixed at sys_ck or 48MHz */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				DELAYED_APP,
@@ -2206,7 +2206,7 @@ static struct clk icr_ick = {
 
 static struct clk cam_ick = {
 	.name		= "cam_ick",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2222,7 +2222,7 @@ static struct clk cam_ick = {
  */
 static struct clk cam_fck = {
 	.name		= "cam_fck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.clkdm_name	= "core_l3_clkdm",
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 0d6a11c..1ff05d3 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1652,7 +1652,7 @@ static const struct clksel ssi_ssr_clksel[] = {
 
 static struct clk ssi_ssr_fck = {
 	.name		= "ssi_ssr_fck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_SSI_SHIFT,
@@ -2064,7 +2064,7 @@ static struct clk ssi_l4_ick = {
 
 static struct clk ssi_ick = {
 	.name		= "ssi_ick",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &ssi_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_SSI_SHIFT,
@@ -2156,7 +2156,7 @@ static const struct clksel dss1_alwon_fck_clksel[] = {
 
 static struct clk dss1_alwon_fck = {
 	.name		= "dss1_alwon_fck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &dpll4_m4x2_ck,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
@@ -2171,7 +2171,7 @@ static struct clk dss1_alwon_fck = {
 
 static struct clk dss_tv_fck = {
 	.name		= "dss_tv_fck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &omap_54m_fck,
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
@@ -2183,7 +2183,7 @@ static struct clk dss_tv_fck = {
 
 static struct clk dss_96m_fck = {
 	.name		= "dss_96m_fck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &omap_96m_fck,
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
@@ -2195,7 +2195,7 @@ static struct clk dss_96m_fck = {
 
 static struct clk dss2_alwon_fck = {
 	.name		= "dss2_alwon_fck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &sys_ck,
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
@@ -2208,7 +2208,7 @@ static struct clk dss2_alwon_fck = {
 static struct clk dss_ick = {
 	/* Handles both L3 and L4 clocks */
 	.name		= "dss_ick",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &l4_ick,
 	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_ICLKEN),
-- 
1.6.1.2

