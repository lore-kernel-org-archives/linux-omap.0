From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/8] OMAP2 clock: APLL code shouldn't rely on static clocks in
	its local namespace
Date: Thu, 03 Dec 2009 03:07:03 -0700
Message-ID: <20091203100702.1203.96130.stgit@localhost.localdomain>
References: <20091203095830.1203.76290.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35913 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249AbZLCKLs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 05:11:48 -0500
In-Reply-To: <20091203095830.1203.76290.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Similar to the previous patch, the APLL code relied on the presence of the
static struct clks in its own namespace.  The APLL code didn't use them for
validation, however - it adjusted its own internal state depending on
the struct clk * that called it.  Now that static struct clks are
leaving the clock24xx.c namespace, use a more durable method: split the
omap2_clk_fixed_enable() function into omap2_clk_apll96_enable() and
omap2_clk_apll54_enable().  They still share a disable function.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock24xx.c |   35 +++++++++++++++++++++++------------
 arch/arm/mach-omap2/clock24xx.h |    4 ++--
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 8ecd175..e60d1c0 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -42,7 +42,8 @@
 #include "cm-regbits-24xx.h"
 
 static const struct clkops clkops_oscck;
-static const struct clkops clkops_fixed;
+static const struct clkops clkops_apll96;
+static const struct clkops clkops_apll54;
 
 static void omap2430_clk_i2chs_find_idlest(struct clk *clk,
 					   void __iomem **idlest_reg,
@@ -338,7 +339,7 @@ static void omap2_sys_clk_recalc(struct clk * clk)
 #endif	/* OLD_CK */
 
 /* Enable an APLL if off */
-static int omap2_clk_fixed_enable(struct clk *clk)
+static int omap2_clk_apll_enable(struct clk *clk, u32 status_mask)
 {
 	u32 cval, apll_mask;
 
@@ -353,12 +354,7 @@ static int omap2_clk_fixed_enable(struct clk *clk)
 	cval |= apll_mask;
 	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
 
-	if (clk == &apll96_ck)
-		cval = OMAP24XX_ST_96M_APLL;
-	else if (clk == &apll54_ck)
-		cval = OMAP24XX_ST_54M_APLL;
-
-	omap2_cm_wait_idlest(OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST), cval,
+	omap2_cm_wait_idlest(OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST), status_mask,
 			     clk->name);
 
 	/*
@@ -368,8 +364,18 @@ static int omap2_clk_fixed_enable(struct clk *clk)
 	return 0;
 }
 
+static int omap2_clk_apll96_enable(struct clk *clk)
+{
+	return omap2_clk_apll_enable(clk, OMAP24XX_ST_96M_APLL);
+}
+
+static int omap2_clk_apll54_enable(struct clk *clk)
+{
+	return omap2_clk_apll_enable(clk, OMAP24XX_ST_54M_APLL);
+}
+
 /* Stop APLL */
-static void omap2_clk_fixed_disable(struct clk *clk)
+static void omap2_clk_apll_disable(struct clk *clk)
 {
 	u32 cval;
 
@@ -378,9 +384,14 @@ static void omap2_clk_fixed_disable(struct clk *clk)
 	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
 }
 
-static const struct clkops clkops_fixed = {
-	.enable		= &omap2_clk_fixed_enable,
-	.disable	= &omap2_clk_fixed_disable,
+static const struct clkops clkops_apll96 = {
+	.enable		= &omap2_clk_apll96_enable,
+	.disable	= &omap2_clk_apll_disable,
+};
+
+static const struct clkops clkops_apll54 = {
+	.enable		= &omap2_clk_apll54_enable,
+	.disable	= &omap2_clk_apll_disable,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index d19cf7a..21238d1 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -708,7 +708,7 @@ static struct clk dpll_ck = {
 
 static struct clk apll96_ck = {
 	.name		= "apll96_ck",
-	.ops		= &clkops_fixed,
+	.ops		= &clkops_apll96,
 	.parent		= &sys_ck,
 	.rate		= 96000000,
 	.flags		= RATE_FIXED | ENABLE_ON_INIT,
@@ -719,7 +719,7 @@ static struct clk apll96_ck = {
 
 static struct clk apll54_ck = {
 	.name		= "apll54_ck",
-	.ops		= &clkops_fixed,
+	.ops		= &clkops_apll54,
 	.parent		= &sys_ck,
 	.rate		= 54000000,
 	.flags		= RATE_FIXED | ENABLE_ON_INIT,


