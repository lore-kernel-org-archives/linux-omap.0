From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/5] ARM: OMAP2/3: Remove OMAP_PRM_REGADDR and OMAP2_PRM_BASE
Date: Thu, 14 May 2009 16:24:30 -0700
Message-ID: <20090514232430.19331.81184.stgit@localhost>
References: <20090514231820.19331.65419.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63831 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081AbZENXYd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 19:24:33 -0400
In-Reply-To: <20090514231820.19331.65419.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

Remove OMAP_PRM_REGADDR and use processor specific defines instead.

Also fold in a patch from Kevin Hilman to add _OFFSET #defines
for the PRCM registers to be used with the prm_[read|write]_* macros.
These are used extensively in the forthcoming OMAP PM support.

Also remove now unused OMAP2_PRM_BASE.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock.c                |    4 -
 arch/arm/mach-omap2/clock24xx.c            |   21 ++-
 arch/arm/mach-omap2/clock24xx.h            |    9 +
 arch/arm/mach-omap2/cm.h                   |    1 
 arch/arm/mach-omap2/prm.h                  |  205 +++++++++++++++++-----------
 arch/arm/mach-omap2/sdrc2xxx.c             |    5 +
 arch/arm/mach-omap2/sram242x.S             |    6 -
 arch/arm/mach-omap2/sram243x.S             |    6 -
 arch/arm/plat-omap/include/mach/omap24xx.h |    2 
 arch/arm/plat-omap/include/mach/omap34xx.h |    1 
 10 files changed, 160 insertions(+), 100 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 4247a15..dd37483 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -91,9 +91,9 @@ static void _omap2xxx_clk_commit(struct clk *clk)
 		return;
 
 	prm_write_mod_reg(OMAP24XX_VALID_CONFIG, OMAP24XX_GR_MOD,
-		OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET);
+		OMAP2_PRCM_CLKCFG_CTRL_OFFSET);
 	/* OCP barrier */
-	prm_read_mod_reg(OMAP24XX_GR_MOD, OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET);
+	prm_read_mod_reg(OMAP24XX_GR_MOD, OMAP2_PRCM_CLKCFG_CTRL_OFFSET);
 }
 
 /*
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index e4cef33..c442fe9 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -233,6 +233,8 @@ static struct prcm_config *curr_prcm_set;
 static struct clk *vclk;
 static struct clk *sclk;
 
+static void __iomem *prcm_clksrc_ctrl;
+
 /*-------------------------------------------------------------------------
  * Omap24xx specific clock functions
  *-------------------------------------------------------------------------*/
@@ -269,10 +271,9 @@ static int omap2_enable_osc_ck(struct clk *clk)
 {
 	u32 pcc;
 
-	pcc = __raw_readl(OMAP24XX_PRCM_CLKSRC_CTRL);
+	pcc = __raw_readl(prcm_clksrc_ctrl);
 
-	__raw_writel(pcc & ~OMAP_AUTOEXTCLKMODE_MASK,
-		      OMAP24XX_PRCM_CLKSRC_CTRL);
+	__raw_writel(pcc & ~OMAP_AUTOEXTCLKMODE_MASK, prcm_clksrc_ctrl);
 
 	return 0;
 }
@@ -281,10 +282,9 @@ static void omap2_disable_osc_ck(struct clk *clk)
 {
 	u32 pcc;
 
-	pcc = __raw_readl(OMAP24XX_PRCM_CLKSRC_CTRL);
+	pcc = __raw_readl(prcm_clksrc_ctrl);
 
-	__raw_writel(pcc | OMAP_AUTOEXTCLKMODE_MASK,
-		      OMAP24XX_PRCM_CLKSRC_CTRL);
+	__raw_writel(pcc | OMAP_AUTOEXTCLKMODE_MASK, prcm_clksrc_ctrl);
 }
 
 static const struct clkops clkops_oscck = {
@@ -654,7 +654,7 @@ static u32 omap2_get_sysclkdiv(void)
 {
 	u32 div;
 
-	div = __raw_readl(OMAP24XX_PRCM_CLKSRC_CTRL);
+	div = __raw_readl(prcm_clksrc_ctrl);
 	div &= OMAP_SYSCLKDIV_MASK;
 	div >>= OMAP_SYSCLKDIV_SHIFT;
 
@@ -714,10 +714,13 @@ int __init omap2_clk_init(void)
 	struct omap_clk *c;
 	u32 clkrate;
 
-	if (cpu_is_omap242x())
+	if (cpu_is_omap242x()) {
+		prcm_clksrc_ctrl = OMAP2420_PRCM_CLKSRC_CTRL;
 		cpu_mask = RATE_IN_242X;
-	else if (cpu_is_omap2430())
+	} else if (cpu_is_omap2430()) {
+		prcm_clksrc_ctrl = OMAP2430_PRCM_CLKSRC_CTRL;
 		cpu_mask = RATE_IN_243X;
+	}
 
 	clk_init(&omap2_clk_functions);
 
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 88c5acb..f0e4480 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -24,6 +24,15 @@
 #include "cm-regbits-24xx.h"
 #include "sdrc.h"
 
+/* REVISIT: These should be set dynamically for CONFIG_MULTI_OMAP2 */
+#ifdef CONFIG_ARCH_OMAP2420
+#define OMAP24XX_PRCM_CLKOUT_CTRL	OMAP2420_PRCM_CLKOUT_CTRL
+#define OMAP24XX_PRCM_CLKEMUL_CTRL	OMAP2420_PRCM_CLKEMUL_CTRL
+#else
+#define OMAP24XX_PRCM_CLKOUT_CTRL	OMAP2430_PRCM_CLKOUT_CTRL
+#define OMAP24XX_PRCM_CLKEMUL_CTRL	OMAP2430_PRCM_CLKEMUL_CTRL
+#endif
+
 static unsigned long omap2_table_mpu_recalc(struct clk *clk);
 static int omap2_select_table_rate(struct clk *clk, unsigned long rate);
 static long omap2_round_to_table_rate(struct clk *clk, unsigned long rate);
diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index 65fdf78..efc082a 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -38,6 +38,7 @@
 #define OMAP3430_CM_SYSCONFIG		OMAP_CM_REGADDR(OCP_MOD, 0x0010)
 #define OMAP3430_CM_POLCTRL		OMAP_CM_REGADDR(OCP_MOD, 0x009c)
 
+#define OMAP3_CM_CLKOUT_CTRL_OFFSET	0x0070
 #define OMAP3430_CM_CLKOUT_CTRL		OMAP_CM_REGADDR(OMAP3430_CCR_MOD, 0x0070)
 
 /*
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 826d326..7c8e0c4 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -16,17 +16,12 @@
 
 #include "prcm-common.h"
 
-#ifndef __ASSEMBLER__
-#define OMAP_PRM_REGADDR(module, reg)					\
-			IO_ADDRESS(OMAP2_PRM_BASE + (module) + (reg))
-#else
 #define OMAP2420_PRM_REGADDR(module, reg)				\
 			IO_ADDRESS(OMAP2420_PRM_BASE + (module) + (reg))
 #define OMAP2430_PRM_REGADDR(module, reg)				\
 			IO_ADDRESS(OMAP2430_PRM_BASE + (module) + (reg))
 #define OMAP34XX_PRM_REGADDR(module, reg)				\
 			IO_ADDRESS(OMAP3430_PRM_BASE + (module) + (reg))
-#endif
 
 /*
  * Architecture-specific global PRM registers
@@ -38,80 +33,132 @@
  *
  */
 
-/* Global 24xx registers in GR_MOD (Same as OCP_MOD for 24xx) */
-#define OMAP24XX_PRCM_VOLTCTRL_OFFSET		0x0050
-#define OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET	0x0080
-
-/* 242x GR_MOD registers, use these only for assembly code */
-#define OMAP242X_PRCM_VOLTCTRL		OMAP2420_PRM_REGADDR(OMAP24XX_GR_MOD,	\
-						OMAP24XX_PRCM_VOLTCTRL_OFFSET)
-#define OMAP242X_PRCM_CLKCFG_CTRL	OMAP2420_PRM_REGADDR(OMAP24XX_GR_MOD,	\
-						OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET)
-
-/* 243x GR_MOD registers, use these only for assembly code */
-#define OMAP243X_PRCM_VOLTCTRL		OMAP2430_PRM_REGADDR(OMAP24XX_GR_MOD,	\
-						OMAP24XX_PRCM_VOLTCTRL_OFFSET)
-#define OMAP243X_PRCM_CLKCFG_CTRL	OMAP2430_PRM_REGADDR(OMAP24XX_GR_MOD,	\
-						OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET)
-
-/* These will disappear */
-#define OMAP24XX_PRCM_REVISION		OMAP_PRM_REGADDR(OCP_MOD, 0x0000)
-#define OMAP24XX_PRCM_SYSCONFIG		OMAP_PRM_REGADDR(OCP_MOD, 0x0010)
-
-#define OMAP24XX_PRCM_IRQSTATUS_MPU	OMAP_PRM_REGADDR(OCP_MOD, 0x0018)
-#define OMAP24XX_PRCM_IRQENABLE_MPU	OMAP_PRM_REGADDR(OCP_MOD, 0x001c)
-
-#define OMAP24XX_PRCM_VOLTST		OMAP_PRM_REGADDR(OCP_MOD, 0x0054)
-#define OMAP24XX_PRCM_CLKSRC_CTRL	OMAP_PRM_REGADDR(OCP_MOD, 0x0060)
-#define OMAP24XX_PRCM_CLKOUT_CTRL	OMAP_PRM_REGADDR(OCP_MOD, 0x0070)
-#define OMAP24XX_PRCM_CLKEMUL_CTRL	OMAP_PRM_REGADDR(OCP_MOD, 0x0078)
-#define OMAP24XX_PRCM_CLKCFG_CTRL	OMAP_PRM_REGADDR(OCP_MOD, 0x0080)
-#define OMAP24XX_PRCM_CLKCFG_STATUS	OMAP_PRM_REGADDR(OCP_MOD, 0x0084)
-#define OMAP24XX_PRCM_VOLTSETUP		OMAP_PRM_REGADDR(OCP_MOD, 0x0090)
-#define OMAP24XX_PRCM_CLKSSETUP		OMAP_PRM_REGADDR(OCP_MOD, 0x0094)
-#define OMAP24XX_PRCM_POLCTRL		OMAP_PRM_REGADDR(OCP_MOD, 0x0098)
-
-#define OMAP3430_PRM_REVISION		OMAP_PRM_REGADDR(OCP_MOD, 0x0004)
-#define OMAP3430_PRM_SYSCONFIG		OMAP_PRM_REGADDR(OCP_MOD, 0x0014)
-
-#define OMAP3430_PRM_IRQSTATUS_MPU	OMAP_PRM_REGADDR(OCP_MOD, 0x0018)
-#define OMAP3430_PRM_IRQENABLE_MPU	OMAP_PRM_REGADDR(OCP_MOD, 0x001c)
-
-
-#define OMAP3430_PRM_VC_SMPS_SA		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0020)
-#define OMAP3430_PRM_VC_SMPS_VOL_RA	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0024)
-#define OMAP3430_PRM_VC_SMPS_CMD_RA	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0028)
-#define OMAP3430_PRM_VC_CMD_VAL_0	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x002c)
-#define OMAP3430_PRM_VC_CMD_VAL_1	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0030)
-#define OMAP3430_PRM_VC_CH_CONF		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0034)
-#define OMAP3430_PRM_VC_I2C_CFG		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0038)
-#define OMAP3430_PRM_VC_BYPASS_VAL	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x003c)
-#define OMAP3430_PRM_RSTCTRL		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0050)
-#define OMAP3430_PRM_RSTTIME		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0054)
-#define OMAP3430_PRM_RSTST		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0058)
-#define OMAP3430_PRM_VOLTCTRL		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0060)
-#define OMAP3430_PRM_SRAM_PCHARGE	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0064)
-#define OMAP3430_PRM_CLKSRC_CTRL	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0070)
-#define OMAP3430_PRM_VOLTSETUP1		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0090)
-#define OMAP3430_PRM_VOLTOFFSET		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0094)
-#define OMAP3430_PRM_CLKSETUP		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x0098)
-#define OMAP3430_PRM_POLCTRL		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x009c)
-#define OMAP3430_PRM_VOLTSETUP2		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00a0)
-#define OMAP3430_PRM_VP1_CONFIG		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b0)
-#define OMAP3430_PRM_VP1_VSTEPMIN	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b4)
-#define OMAP3430_PRM_VP1_VSTEPMAX	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b8)
-#define OMAP3430_PRM_VP1_VLIMITTO	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00bc)
-#define OMAP3430_PRM_VP1_VOLTAGE	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00c0)
-#define OMAP3430_PRM_VP1_STATUS		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00c4)
-#define OMAP3430_PRM_VP2_CONFIG		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d0)
-#define OMAP3430_PRM_VP2_VSTEPMIN	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d4)
-#define OMAP3430_PRM_VP2_VSTEPMAX	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d8)
-#define OMAP3430_PRM_VP2_VLIMITTO	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00dc)
-#define OMAP3430_PRM_VP2_VOLTAGE	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00e0)
-#define OMAP3430_PRM_VP2_STATUS		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00e4)
-
-#define OMAP3430_PRM_CLKSEL		OMAP_PRM_REGADDR(OMAP3430_CCR_MOD, 0x0040)
-#define OMAP3430_PRM_CLKOUT_CTRL	OMAP_PRM_REGADDR(OMAP3430_CCR_MOD, 0x0070)
+#define OMAP2_PRCM_REVISION_OFFSET	0x0000
+#define OMAP2420_PRCM_REVISION		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0000)
+#define OMAP2_PRCM_SYSCONFIG_OFFSET	0x0010
+#define OMAP2420_PRCM_SYSCONFIG		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0010)
+
+#define OMAP2_PRCM_IRQSTATUS_MPU_OFFSET	0x0018
+#define OMAP2420_PRCM_IRQSTATUS_MPU	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0018)
+#define OMAP2_PRCM_IRQENABLE_MPU_OFFSET	0x001c
+#define OMAP2420_PRCM_IRQENABLE_MPU	OMAP2420_PRM_REGADDR(OCP_MOD, 0x001c)
+
+#define OMAP2_PRCM_VOLTCTRL_OFFSET	0x0050
+#define OMAP2420_PRCM_VOLTCTRL		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0050)
+#define OMAP2_PRCM_VOLTST_OFFSET	0x0054
+#define OMAP2420_PRCM_VOLTST		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0054)
+#define OMAP2_PRCM_CLKSRC_CTRL_OFFSET	0x0060
+#define OMAP2420_PRCM_CLKSRC_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0060)
+#define OMAP2_PRCM_CLKOUT_CTRL_OFFSET	0x0070
+#define OMAP2420_PRCM_CLKOUT_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0070)
+#define OMAP2_PRCM_CLKEMUL_CTRL_OFFSET	0x0078
+#define OMAP2420_PRCM_CLKEMUL_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0078)
+#define OMAP2_PRCM_CLKCFG_CTRL_OFFSET	0x0080
+#define OMAP2420_PRCM_CLKCFG_CTRL	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0080)
+#define OMAP2_PRCM_CLKCFG_STATUS_OFFSET	0x0084
+#define OMAP2420_PRCM_CLKCFG_STATUS	OMAP2420_PRM_REGADDR(OCP_MOD, 0x0084)
+#define OMAP2_PRCM_VOLTSETUP_OFFSET	0x0090
+#define OMAP2420_PRCM_VOLTSETUP		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0090)
+#define OMAP2_PRCM_CLKSSETUP_OFFSET	0x0094
+#define OMAP2420_PRCM_CLKSSETUP		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0094)
+#define OMAP2_PRCM_POLCTRL_OFFSET	0x0098
+#define OMAP2420_PRCM_POLCTRL		OMAP2420_PRM_REGADDR(OCP_MOD, 0x0098)
+
+#define OMAP2430_PRCM_REVISION		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0000)
+#define OMAP2430_PRCM_SYSCONFIG		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0010)
+
+#define OMAP2430_PRCM_IRQSTATUS_MPU	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0018)
+#define OMAP2430_PRCM_IRQENABLE_MPU	OMAP2430_PRM_REGADDR(OCP_MOD, 0x001c)
+
+#define OMAP2430_PRCM_VOLTCTRL		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0050)
+#define OMAP2430_PRCM_VOLTST		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0054)
+#define OMAP2430_PRCM_CLKSRC_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0060)
+#define OMAP2430_PRCM_CLKOUT_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0070)
+#define OMAP2430_PRCM_CLKEMUL_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0078)
+#define OMAP2430_PRCM_CLKCFG_CTRL	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0080)
+#define OMAP2430_PRCM_CLKCFG_STATUS	OMAP2430_PRM_REGADDR(OCP_MOD, 0x0084)
+#define OMAP2430_PRCM_VOLTSETUP		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0090)
+#define OMAP2430_PRCM_CLKSSETUP		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0094)
+#define OMAP2430_PRCM_POLCTRL		OMAP2430_PRM_REGADDR(OCP_MOD, 0x0098)
+
+#define OMAP3_PRM_REVISION_OFFSET	0x0004
+#define OMAP3430_PRM_REVISION		OMAP34XX_PRM_REGADDR(OCP_MOD, 0x0004)
+#define OMAP3_PRM_SYSCONFIG_OFFSET	0x0014
+#define OMAP3430_PRM_SYSCONFIG		OMAP34XX_PRM_REGADDR(OCP_MOD, 0x0014)
+
+#define OMAP3_PRM_IRQSTATUS_MPU_OFFSET	0x0018
+#define OMAP3430_PRM_IRQSTATUS_MPU	OMAP34XX_PRM_REGADDR(OCP_MOD, 0x0018)
+#define OMAP3_PRM_IRQENABLE_MPU_OFFSET	0x001c
+#define OMAP3430_PRM_IRQENABLE_MPU	OMAP34XX_PRM_REGADDR(OCP_MOD, 0x001c)
+
+
+#define OMAP3_PRM_VC_SMPS_SA_OFFSET	0x0020
+#define OMAP3430_PRM_VC_SMPS_SA		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0020)
+#define OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET	0x0024
+#define OMAP3430_PRM_VC_SMPS_VOL_RA	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0024)
+#define OMAP3_PRM_VC_SMPS_CMD_RA_OFFSET	0x0028
+#define OMAP3430_PRM_VC_SMPS_CMD_RA	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0028)
+#define OMAP3_PRM_VC_CMD_VAL_0_OFFSET	0x002c
+#define OMAP3430_PRM_VC_CMD_VAL_0	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x002c)
+#define OMAP3_PRM_VC_CMD_VAL_1_OFFSET	0x0030
+#define OMAP3430_PRM_VC_CMD_VAL_1	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0030)
+#define OMAP3_PRM_VC_CH_CONF_OFFSET	0x0034
+#define OMAP3430_PRM_VC_CH_CONF		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0034)
+#define OMAP3_PRM_VC_I2C_CFG_OFFSET	0x0038
+#define OMAP3430_PRM_VC_I2C_CFG		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0038)
+#define OMAP3_PRM_VC_BYPASS_VAL_OFFSET	0x003c
+#define OMAP3430_PRM_VC_BYPASS_VAL	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x003c)
+#define OMAP3_PRM_RSTCTRL_OFFSET	0x0050
+#define OMAP3430_PRM_RSTCTRL		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0050)
+#define OMAP3_PRM_RSTTIME_OFFSET	0x0054
+#define OMAP3430_PRM_RSTTIME		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0054)
+#define OMAP3_PRM_RSTST_OFFSET	0x0058
+#define OMAP3430_PRM_RSTST		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0058)
+#define OMAP3_PRM_VOLTCTRL_OFFSET	0x0060
+#define OMAP3430_PRM_VOLTCTRL		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0060)
+#define OMAP3_PRM_SRAM_PCHARGE_OFFSET	0x0064
+#define OMAP3430_PRM_SRAM_PCHARGE	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0064)
+#define OMAP3_PRM_CLKSRC_CTRL_OFFSET	0x0070
+#define OMAP3430_PRM_CLKSRC_CTRL	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0070)
+#define OMAP3_PRM_VOLTSETUP1_OFFSET	0x0090
+#define OMAP3430_PRM_VOLTSETUP1		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0090)
+#define OMAP3_PRM_VOLTOFFSET_OFFSET	0x0094
+#define OMAP3430_PRM_VOLTOFFSET		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0094)
+#define OMAP3_PRM_CLKSETUP_OFFSET	0x0098
+#define OMAP3430_PRM_CLKSETUP		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0098)
+#define OMAP3_PRM_POLCTRL_OFFSET	0x009c
+#define OMAP3430_PRM_POLCTRL		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x009c)
+#define OMAP3_PRM_VOLTSETUP2_OFFSET	0x00a0
+#define OMAP3430_PRM_VOLTSETUP2		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00a0)
+#define OMAP3_PRM_VP1_CONFIG_OFFSET	0x00b0
+#define OMAP3430_PRM_VP1_CONFIG		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b0)
+#define OMAP3_PRM_VP1_VSTEPMIN_OFFSET	0x00b4
+#define OMAP3430_PRM_VP1_VSTEPMIN	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b4)
+#define OMAP3_PRM_VP1_VSTEPMAX_OFFSET	0x00b8
+#define OMAP3430_PRM_VP1_VSTEPMAX	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b8)
+#define OMAP3_PRM_VP1_VLIMITTO_OFFSET	0x00bc
+#define OMAP3430_PRM_VP1_VLIMITTO	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00bc)
+#define OMAP3_PRM_VP1_VOLTAGE_OFFSET	0x00c0
+#define OMAP3430_PRM_VP1_VOLTAGE	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00c0)
+#define OMAP3_PRM_VP1_STATUS_OFFSET	0x00c4
+#define OMAP3430_PRM_VP1_STATUS		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00c4)
+#define OMAP3_PRM_VP2_CONFIG_OFFSET	0x00d0
+#define OMAP3430_PRM_VP2_CONFIG		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d0)
+#define OMAP3_PRM_VP2_VSTEPMIN_OFFSET	0x00d4
+#define OMAP3430_PRM_VP2_VSTEPMIN	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d4)
+#define OMAP3_PRM_VP2_VSTEPMAX_OFFSET	0x00d8
+#define OMAP3430_PRM_VP2_VSTEPMAX	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d8)
+#define OMAP3_PRM_VP2_VLIMITTO_OFFSET	0x00dc
+#define OMAP3430_PRM_VP2_VLIMITTO	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00dc)
+#define OMAP3_PRM_VP2_VOLTAGE_OFFSET	0x00e0
+#define OMAP3430_PRM_VP2_VOLTAGE	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00e0)
+#define OMAP3_PRM_VP2_STATUS_OFFSET	0x00e4
+#define OMAP3430_PRM_VP2_STATUS		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00e4)
+
+#define OMAP3_PRM_CLKSEL_OFFSET	0x0040
+#define OMAP3430_PRM_CLKSEL		OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, 0x0040)
+#define OMAP3_PRM_CLKOUT_CTRL_OFFSET	0x0070
+#define OMAP3430_PRM_CLKOUT_CTRL	OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, 0x0070)
 
 /*
  * Module specific PRM registers from PRM_BASE + domain offset
diff --git a/arch/arm/mach-omap2/sdrc2xxx.c b/arch/arm/mach-omap2/sdrc2xxx.c
index 0afdad5..feaec7e 100644
--- a/arch/arm/mach-omap2/sdrc2xxx.c
+++ b/arch/arm/mach-omap2/sdrc2xxx.c
@@ -99,7 +99,10 @@ u32 omap2xxx_sdrc_reprogram(u32 level, u32 force)
 	m_type = omap2xxx_sdrc_get_type();
 
 	local_irq_save(flags);
-	__raw_writel(0xffff, OMAP24XX_PRCM_VOLTSETUP);
+	if (cpu_is_omap2420())
+		__raw_writel(0xffff, OMAP2420_PRCM_VOLTSETUP);
+	else
+		__raw_writel(0xffff, OMAP2430_PRCM_VOLTSETUP);
 	omap2_sram_reprogram_sdrc(level, dll_ctrl, m_type);
 	curr_perf_level = level;
 	local_irq_restore(flags);
diff --git a/arch/arm/mach-omap2/sram242x.S b/arch/arm/mach-omap2/sram242x.S
index cbb8930..bb29985 100644
--- a/arch/arm/mach-omap2/sram242x.S
+++ b/arch/arm/mach-omap2/sram242x.S
@@ -124,7 +124,7 @@ omap242x_sdi_cm_clksel2_pll:
 omap242x_sdi_sdrc_dlla_ctrl:
 	.word OMAP242X_SDRC_REGADDR(SDRC_DLLA_CTRL)
 omap242x_sdi_prcm_voltctrl:
-	.word OMAP242X_PRCM_VOLTCTRL
+	.word OMAP2420_PRCM_VOLTCTRL
 prcm_mask_val:
 	.word 0xFFFF3FFC
 omap242x_sdi_timer_32ksynct_cr:
@@ -220,7 +220,7 @@ omap242x_srs_sdrc_dlla_ctrl:
 omap242x_srs_sdrc_rfr_ctrl:
 	.word OMAP242X_SDRC_REGADDR(SDRC_RFR_CTRL_0)
 omap242x_srs_prcm_voltctrl:
-	.word OMAP242X_PRCM_VOLTCTRL
+	.word OMAP2420_PRCM_VOLTCTRL
 ddr_prcm_mask_val:
 	.word 0xFFFF3FFC
 omap242x_srs_timer_32ksynct:
@@ -305,7 +305,7 @@ wait_dll_lock:
 	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
 
 omap242x_ssp_set_config:
-	.word OMAP242X_PRCM_CLKCFG_CTRL
+	.word OMAP2420_PRCM_CLKCFG_CTRL
 omap242x_ssp_pll_ctl:
 	.word OMAP2420_CM_REGADDR(PLL_MOD, CM_CLKEN)
 omap242x_ssp_pll_stat:
diff --git a/arch/arm/mach-omap2/sram243x.S b/arch/arm/mach-omap2/sram243x.S
index 054b0f3..9955abc 100644
--- a/arch/arm/mach-omap2/sram243x.S
+++ b/arch/arm/mach-omap2/sram243x.S
@@ -124,7 +124,7 @@ omap243x_sdi_cm_clksel2_pll:
 omap243x_sdi_sdrc_dlla_ctrl:
 	.word OMAP243X_SDRC_REGADDR(SDRC_DLLA_CTRL)
 omap243x_sdi_prcm_voltctrl:
-	.word OMAP243X_PRCM_VOLTCTRL
+	.word OMAP2430_PRCM_VOLTCTRL
 prcm_mask_val:
 	.word 0xFFFF3FFC
 omap243x_sdi_timer_32ksynct_cr:
@@ -220,7 +220,7 @@ omap243x_srs_sdrc_dlla_ctrl:
 omap243x_srs_sdrc_rfr_ctrl:
 	.word OMAP243X_SDRC_REGADDR(SDRC_RFR_CTRL_0)
 omap243x_srs_prcm_voltctrl:
-	.word OMAP243X_PRCM_VOLTCTRL
+	.word OMAP2430_PRCM_VOLTCTRL
 ddr_prcm_mask_val:
 	.word 0xFFFF3FFC
 omap243x_srs_timer_32ksynct:
@@ -305,7 +305,7 @@ wait_dll_lock:
 	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
 
 omap243x_ssp_set_config:
-	.word OMAP243X_PRCM_CLKCFG_CTRL
+	.word OMAP2430_PRCM_CLKCFG_CTRL
 omap243x_ssp_pll_ctl:
 	.word OMAP2430_CM_REGADDR(PLL_MOD, CM_CLKEN)
 omap243x_ssp_pll_stat:
diff --git a/arch/arm/plat-omap/include/mach/omap24xx.h b/arch/arm/plat-omap/include/mach/omap24xx.h
index 4202cf4..10a6413 100644
--- a/arch/arm/plat-omap/include/mach/omap24xx.h
+++ b/arch/arm/plat-omap/include/mach/omap24xx.h
@@ -89,14 +89,12 @@
 
 #define OMAP2_PRCM_BASE		OMAP2420_PRCM_BASE
 #define OMAP2_CM_BASE		OMAP2420_CM_BASE
-#define OMAP2_PRM_BASE		OMAP2420_PRM_BASE
 #define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP24XX_IC_BASE)
 
 #elif defined(CONFIG_ARCH_OMAP2430)
 
 #define OMAP2_PRCM_BASE		OMAP2430_PRCM_BASE
 #define OMAP2_CM_BASE		OMAP2430_CM_BASE
-#define OMAP2_PRM_BASE		OMAP2430_PRM_BASE
 #define OMAP2_VA_IC_BASE	IO_ADDRESS(OMAP24XX_IC_BASE)
 
 #endif
diff --git a/arch/arm/plat-omap/include/mach/omap34xx.h b/arch/arm/plat-omap/include/mach/omap34xx.h
index 581d910..4233064 100644
--- a/arch/arm/plat-omap/include/mach/omap34xx.h
+++ b/arch/arm/plat-omap/include/mach/omap34xx.h
@@ -86,7 +86,6 @@
 #if defined(CONFIG_ARCH_OMAP3430)
 
 #define OMAP2_CM_BASE			OMAP3430_CM_BASE
-#define OMAP2_PRM_BASE			OMAP3430_PRM_BASE
 #define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP34XX_IC_BASE)
 
 #endif

