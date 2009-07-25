From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 7/8] OMAP2 clock: 2430 I2CHS uses non-standard CM_IDLEST
	register
Date: Fri, 24 Jul 2009 20:11:31 -0600
Message-ID: <20090725021130.29059.94405.stgit@localhost.localdomain>
References: <20090725021102.29059.94214.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50661 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274AbZGYCNE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 22:13:04 -0400
In-Reply-To: <20090725021102.29059.94214.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

OMAP2430 I2CHS CM_IDLEST bits are in CM_IDLEST1_CORE, but the CM_*CLKEN bits
are in CM_{I,F}CLKEN2_CORE [1].  Fix by implementing a custom clkops
.find_idlest function to return the correct slave IDLEST register.

...

1. OMAP2430 Multimedia Device Package-on-Package (POP) Silicon Revision 2.1
   (Rev. V) Technical Reference Manual, tables 4-99 and 4-105.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock24xx.c |   37 +++++++++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/clock24xx.h |    4 ++--
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 44de027..bc5d3ac 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -30,6 +30,7 @@
 
 #include <mach/clock.h>
 #include <mach/sram.h>
+#include <mach/prcm.h>
 #include <asm/div64.h>
 #include <asm/clkdev.h>
 
@@ -43,6 +44,18 @@
 static const struct clkops clkops_oscck;
 static const struct clkops clkops_fixed;
 
+static void omap2430_clk_i2chs_find_idlest(struct clk *clk,
+					   void __iomem **idlest_reg,
+					   u8 *idlest_bit);
+
+/* 2430 I2CHS has non-standard IDLEST register */
+static const struct clkops clkops_omap2430_i2chs_wait = {
+	.enable		= omap2_dflt_clk_enable,
+	.disable	= omap2_dflt_clk_disable,
+	.find_idlest	= omap2430_clk_i2chs_find_idlest,
+	.find_companion = omap2_clk_dflt_find_companion,
+};
+
 #include "clock24xx.h"
 
 struct omap_clk {
@@ -240,6 +253,26 @@ static void __iomem *prcm_clksrc_ctrl;
  *-------------------------------------------------------------------------*/
 
 /**
+ * omap2430_clk_i2chs_find_idlest - return CM_IDLEST info for 2430 I2CHS
+ * @clk: struct clk * being enabled
+ * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
+ * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ *
+ * OMAP2430 I2CHS CM_IDLEST bits are in CM_IDLEST1_CORE, but the
+ * CM_*CLKEN bits are in CM_{I,F}CLKEN2_CORE.  This custom function
+ * passes back the correct CM_IDLEST register address for I2CHS
+ * modules.  No return value.
+ */
+static void omap2430_clk_i2chs_find_idlest(struct clk *clk,
+					   void __iomem **idlest_reg,
+					   u8 *idlest_bit)
+{
+	*idlest_reg = OMAP_CM_REGADDR(CORE_MOD, CM_IDLEST);
+	*idlest_bit = clk->enable_bit;
+}
+
+
+/**
  * omap2xxx_clk_get_core_rate - return the CORE_CLK rate
  * @clk: pointer to the combined dpll_ck + core_ck (currently "dpll_ck")
  *
@@ -325,8 +358,8 @@ static int omap2_clk_fixed_enable(struct clk *clk)
 	else if (clk == &apll54_ck)
 		cval = OMAP24XX_ST_54M_APLL;
 
-	omap2_wait_clock_ready(OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST), cval,
-			    clk->name);
+	omap2_cm_wait_idlest(OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST), cval,
+			     clk->name);
 
 	/*
 	 * REVISIT: Should we return an error code if omap2_wait_clock_ready()
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 458f00c..d19cf7a 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -2337,7 +2337,7 @@ static struct clk i2c2_fck = {
 
 static struct clk i2chs2_fck = {
 	.name		= "i2c_fck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2430_i2chs_wait,
 	.id		= 2,
 	.parent		= &func_96m_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2370,7 +2370,7 @@ static struct clk i2c1_fck = {
 
 static struct clk i2chs1_fck = {
 	.name		= "i2c_fck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2430_i2chs_wait,
 	.id		= 1,
 	.parent		= &func_96m_ck,
 	.clkdm_name	= "core_l4_clkdm",


