From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/4] mach-omap2: mark casts between integers and pointers with
	__force
Date: Thu, 17 Jul 2008 20:52:37 -0600
Message-ID: <20080718025235.20613.44567.stgit@localhost.localdomain>
References: <20080718024832.20613.30050.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42273 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbYGRDNF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2008 23:13:05 -0400
In-Reply-To: <20080718024832.20613.30050.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Mark casts between integers and pointers with __force to keep sparse
from complaining.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/clock24xx.h |    6 ++++--
 arch/arm/mach-omap2/clock34xx.h |    9 ++++++---
 arch/arm/mach-omap2/gpmc.c      |   11 +++++++----
 arch/arm/mach-omap2/irq.c       |    4 ++--
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index f890f2b..41d8d26 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -604,8 +604,10 @@ static struct prcm_config rate_table[] = {
  * Since 2420 and 2430 have different cm_base, we use offsets only here.
  * Clock code will rewrite the register address as needed.
  */
-#define _CM_REG_OFFSET(module, reg)	((void __iomem *)(module) + (reg))
-#define _GR_MOD_OFFSET(reg)	((void __iomem *)(OMAP24XX_GR_MOD + (reg)))
+#define _CM_REG_OFFSET(module, reg)				\
+			((__force void __iomem *)(module) + (reg))
+#define _GR_MOD_OFFSET(reg)					\
+			((__force void __iomem *)(OMAP24XX_GR_MOD + (reg)))
 
 /*-------------------------------------------------------------------------
  * 24xx clock tree.
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 161da12..2f8401f 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -178,7 +178,7 @@ static const struct clksel osc_sys_clksel[] = {
 static struct clk osc_sys_ck = {
 	.name		= "osc_sys_ck",
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP3430_PRM_CLKSEL,
+	.clksel_reg	= (__force void __iomem *)OMAP3430_PRM_CLKSEL,
 	.clksel_mask	= OMAP3430_SYS_CLKIN_SEL_MASK,
 	.clksel		= osc_sys_clksel,
 	/* REVISIT: deal with autoextclkmode? */
@@ -204,7 +204,7 @@ static struct clk sys_ck = {
 	.name		= "sys_ck",
 	.parent		= &osc_sys_ck,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP3430_PRM_CLKSRC_CTRL,
+	.clksel_reg	= (__force void __iomem *)OMAP3430_PRM_CLKSRC_CTRL,
 	.clksel_mask	= OMAP_SYSCLKDIV_MASK,
 	.clksel		= sys_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
@@ -229,7 +229,7 @@ static struct clk mcbsp_clks = {
 static struct clk sys_clkout1 = {
 	.name		= "sys_clkout1",
 	.parent		= &osc_sys_ck,
-	.enable_reg	= OMAP3430_PRM_CLKOUT_CTRL,
+	.enable_reg	= (__force void __iomem *)OMAP3430_PRM_CLKOUT_CTRL,
 	.enable_bit	= OMAP3430_CLKOUT_EN_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
@@ -272,6 +272,9 @@ static const struct clksel_rate div16_dpll_rates[] = {
 #define _OMAP34XX_CM_REGADDR(module, reg)				\
 	((__force void __iomem *)(OMAP34XX_CM_REGADDR((module), (reg))))
 
+#define _OMAP34XX_PRM_REGADDR(module, reg)				\
+	((__force void __iomem *)(OMAP34XX_PRM_REGADDR((module), (reg))))
+
 /* DPLL1 */
 /* MPU clock source */
 /* Type: DPLL */
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 83984f7..5c057a9 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -65,12 +65,12 @@ static struct clk *gpmc_l3_clk;
 
 static void gpmc_write_reg(int idx, u32 val)
 {
-	__raw_writel(val, gpmc_base + idx);
+	__raw_writel(val, (__force void __iomem *)(gpmc_base + idx));
 }
 
 static u32 gpmc_read_reg(int idx)
 {
-	return __raw_readl(gpmc_base + idx);
+	return __raw_readl((__force void __iomem *)(gpmc_base + idx));
 }
 
 void gpmc_cs_write_reg(int cs, int idx, u32 val)
@@ -78,12 +78,15 @@ void gpmc_cs_write_reg(int cs, int idx, u32 val)
 	u32 reg_addr;
 
 	reg_addr = gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + idx;
-	__raw_writel(val, reg_addr);
+	__raw_writel(val, (__force void __iomem *)reg_addr);
 }
 
 u32 gpmc_cs_read_reg(int cs, int idx)
 {
-	return __raw_readl(gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + idx);
+	u32 reg_addr;
+
+	reg_addr = gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + idx;
+	return __raw_readl((__force void __iomem *)reg_addr);
 }
 
 /* TODO: Add support for gpmc_fck to clock framework and use it */
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index ce85971..441463e 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -52,12 +52,12 @@ static struct omap_irq_bank {
 
 static void intc_bank_write_reg(u32 val, struct omap_irq_bank *bank, u16 reg)
 {
-	__raw_writel(val, bank->base_reg + reg);
+	__raw_writel(val, (__force void __iomem *)(bank->base_reg + reg));
 }
 
 static u32 intc_bank_read_reg(struct omap_irq_bank *bank, u16 reg)
 {
-	return __raw_readl(bank->base_reg + reg);
+	return __raw_readl((__force void __iomem *)(bank->base_reg + reg));
 }
 
 /* XXX: FIQ and additional INTC support (only MPU at the moment) */


