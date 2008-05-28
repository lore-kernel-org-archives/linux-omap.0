From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/14] ARM: OMAP: Remove OMAP_PRM_REGADDR
Date: Tue, 27 May 2008 21:20:15 -0700
Message-ID: <1211948418-16455-12-git-send-email-tony@atomide.com>
References: multi-omap-2008-05-27-212014
 <1211948418-16455-1-git-send-email-tony@atomide.com>
 <1211948418-16455-2-git-send-email-tony@atomide.com>
 <1211948418-16455-3-git-send-email-tony@atomide.com>
 <1211948418-16455-4-git-send-email-tony@atomide.com>
 <1211948418-16455-5-git-send-email-tony@atomide.com>
 <1211948418-16455-6-git-send-email-tony@atomide.com>
 <1211948418-16455-7-git-send-email-tony@atomide.com>
 <1211948418-16455-8-git-send-email-tony@atomide.com>
 <1211948418-16455-9-git-send-email-tony@atomide.com>
 <1211948418-16455-10-git-send-email-tony@atomide.com>
 <1211948418-16455-11-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:49728 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbYE1EUh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 00:20:37 -0400
In-Reply-To: <1211948418-16455-11-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Remove OMAP_PRM_REGADDR. Use prm_read/write_mod_reg() instead.
For assembly, use OMAPXXXX_PRM_REGADDR macros.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock24xx.c    |   55 +++++++++-
 arch/arm/mach-omap2/clock24xx.h    |   27 +++---
 arch/arm/mach-omap2/clock34xx.h    |    2 +-
 arch/arm/mach-omap2/memory.c       |    3 +-
 arch/arm/mach-omap2/pm24xx.c       |   21 +++--
 arch/arm/mach-omap2/prcm.c         |   14 +++
 arch/arm/mach-omap2/prm.h          |  192 +++++++++++++++++++-----------------
 arch/arm/plat-omap/common.c        |    1 +
 include/asm-arm/arch-omap/clock.h  |    3 +-
 include/asm-arm/arch-omap/common.h |    5 +
 10 files changed, 206 insertions(+), 117 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index efe4436..84a0d10 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -28,6 +28,7 @@
 #include <linux/io.h>
 #include <linux/cpufreq.h>
 
+#include <asm/arch/common.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sram.h>
 #include <asm/div64.h>
@@ -77,16 +78,16 @@ static u32 omap2_get_dpll_rate_24xx(struct clk *tclk)
 static int omap2_enable_osc_ck(struct clk *clk)
 {
 
-	prm_rmw_reg_bits(OMAP_AUTOEXTCLKMODE_MASK, 0,
-			 OMAP24XX_PRCM_CLKSRC_CTRL);
+	prm_rmw_mod_reg_bits(OMAP_AUTOEXTCLKMODE_MASK, 0,
+			OMAP24XX_GR_MOD, OMAP24XX_PRCM_CLKSRC_CTRL_OFFSET);
 
 	return 0;
 }
 
 static void omap2_disable_osc_ck(struct clk *clk)
 {
-	prm_rmw_reg_bits(OMAP_AUTOEXTCLKMODE_MASK, OMAP_AUTOEXTCLKMODE_MASK,
-			 OMAP24XX_PRCM_CLKSRC_CTRL);
+	prm_rmw_mod_reg_bits(OMAP_AUTOEXTCLKMODE_MASK, OMAP_AUTOEXTCLKMODE_MASK,
+			OMAP24XX_GR_MOD, OMAP24XX_PRCM_CLKSRC_CTRL_OFFSET);
 }
 
 /* Enable an APLL if off */
@@ -443,7 +444,8 @@ static u32 omap2_get_sysclkdiv(void)
 {
 	u32 div;
 
-	div = __raw_readl(OMAP24XX_PRCM_CLKSRC_CTRL);
+	div = prm_read_mod_reg(OMAP24XX_GR_MOD,
+				OMAP24XX_PRCM_CLKSRC_CTRL_OFFSET);
 	div &= OMAP_SYSCLKDIV_MASK;
 	div >>= OMAP_SYSCLKDIV_SHIFT;
 
@@ -499,6 +501,37 @@ static int __init omap2_clk_arch_init(void)
 }
 arch_initcall(omap2_clk_arch_init);
 
+static u32 prm_base;
+static u32 cm_base;
+
+/*
+ * Since we share clock data for 242x and 243x, we need to rewrite some
+ * some register base offsets. Assume offset is at prm_base if flagged,
+ * else assume it's cm_base.
+ */
+static inline void omap2_clk_check_reg(u32 flags, void __iomem **reg)
+{
+	u32 tmp = (__force u32)*reg;
+
+	if ((tmp >> 24) != 0)
+		return;
+
+	if (flags & OFFSET_GR_MOD)
+		tmp += prm_base;
+	else
+		tmp += cm_base;
+
+	*reg = (__force void __iomem *)tmp;
+}
+
+void __init omap2_clk_rewrite_base(struct clk *clk)
+{
+	omap2_clk_check_reg(clk->flags, &clk->clksel_reg);
+	omap2_clk_check_reg(clk->flags, &clk->enable_reg);
+	if (clk->dpll_data)
+		omap2_clk_check_reg(0, &clk->dpll_data->mult_div1_reg);
+}
+
 int __init omap2_clk_init(void)
 {
 	struct prcm_config *prcm;
@@ -510,6 +543,12 @@ int __init omap2_clk_init(void)
 	else if (cpu_is_omap2430())
 		cpu_mask = RATE_IN_243X;
 
+	for (clkp = onchip_24xx_clks;
+	     clkp < onchip_24xx_clks + ARRAY_SIZE(onchip_24xx_clks);
+	     clkp++) {
+			omap2_clk_rewrite_base(*clkp);
+	}
+
 	clk_init(&omap2_clk_functions);
 
 	omap2_osc_clk_recalc(&osc_ck);
@@ -561,3 +600,9 @@ int __init omap2_clk_init(void)
 
 	return 0;
 }
+
+void __init omap2_set_globals_clock24xx(struct omap_globals *omap2_globals)
+{
+	prm_base = (__force u32)omap2_globals->prm;
+	cm_base = (__force u32)omap2_globals->cm;
+}
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index c439be8..c9f3fcf 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -600,6 +600,8 @@ static struct prcm_config rate_table[] = {
 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
 };
 
+#define _GR_MOD_OFFSET(reg)	((void __iomem*)(OMAP24XX_GR_MOD + (reg)))
+
 /*-------------------------------------------------------------------------
  * 24xx clock tree.
  *
@@ -877,11 +879,11 @@ static struct clk sys_clkout_src = {
 	.name		= "sys_clkout_src",
 	.parent		= &func_54m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES,
-	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+				RATE_PROPAGATES | OFFSET_GR_MOD,
+	.enable_reg	= _GR_MOD_OFFSET(OMAP24XX_PRCM_CLKOUT_CTRL_OFFSET),
 	.enable_bit	= OMAP24XX_CLKOUT_EN_SHIFT,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_reg	= _GR_MOD_OFFSET(OMAP24XX_PRCM_CLKOUT_CTRL_OFFSET),
 	.clksel_mask	= OMAP24XX_CLKOUT_SOURCE_MASK,
 	.clksel		= common_clkout_src_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -907,8 +909,8 @@ static struct clk sys_clkout = {
 	.name		= "sys_clkout",
 	.parent		= &sys_clkout_src,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				PARENT_CONTROLS_CLOCK,
-	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+				PARENT_CONTROLS_CLOCK | OFFSET_GR_MOD,
+	.clksel_reg	= _GR_MOD_OFFSET(OMAP24XX_PRCM_CLKOUT_CTRL_OFFSET),
 	.clksel_mask	= OMAP24XX_CLKOUT_DIV_MASK,
 	.clksel		= sys_clkout_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -920,11 +922,11 @@ static struct clk sys_clkout = {
 static struct clk sys_clkout2_src = {
 	.name		= "sys_clkout2_src",
 	.parent		= &func_54m_ck,
-	.flags		= CLOCK_IN_OMAP242X | RATE_PROPAGATES,
-	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.flags		= CLOCK_IN_OMAP242X | RATE_PROPAGATES | OFFSET_GR_MOD,
+	.enable_reg	= _GR_MOD_OFFSET(OMAP24XX_PRCM_CLKOUT_CTRL_OFFSET),
 	.enable_bit	= OMAP2420_CLKOUT2_EN_SHIFT,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_reg	= _GR_MOD_OFFSET(OMAP24XX_PRCM_CLKOUT_CTRL_OFFSET),
 	.clksel_mask	= OMAP2420_CLKOUT2_SOURCE_MASK,
 	.clksel		= common_clkout_src_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -941,8 +943,9 @@ static const struct clksel sys_clkout2_clksel[] = {
 static struct clk sys_clkout2 = {
 	.name		= "sys_clkout2",
 	.parent		= &sys_clkout2_src,
-	.flags		= CLOCK_IN_OMAP242X | PARENT_CONTROLS_CLOCK,
-	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.flags		= CLOCK_IN_OMAP242X | PARENT_CONTROLS_CLOCK |
+				OFFSET_GR_MOD,
+	.clksel_reg	= _GR_MOD_OFFSET(OMAP24XX_PRCM_CLKOUT_CTRL_OFFSET),
 	.clksel_mask	= OMAP2420_CLKOUT2_DIV_MASK,
 	.clksel		= sys_clkout2_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -953,8 +956,8 @@ static struct clk sys_clkout2 = {
 static struct clk emul_ck = {
 	.name		= "emul_ck",
 	.parent		= &func_54m_ck,
-	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= OMAP24XX_PRCM_CLKEMUL_CTRL,
+	.flags		= CLOCK_IN_OMAP242X | OFFSET_GR_MOD,
+	.enable_reg	= _GR_MOD_OFFSET(OMAP24XX_PRCM_CLKEMUL_CTRL_OFFSET),
 	.enable_bit	= OMAP24XX_EMULATION_EN_SHIFT,
 	.recalc		= &followparent_recalc,
 
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 284c796..4cc9142 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -2219,7 +2219,7 @@ static struct clk usbhost_sar_fck = {
 	.name		= "usbhost_sar_fck",
 	.parent		= &osc_sys_ck,
 	.init		= &omap2_init_clk_clkdm,
-	.enable_reg	= OMAP_PRM_REGADDR(OMAP3430ES2_USBHOST_MOD, PM_PWSTCTRL),
+	.enable_reg	= OMAP34XX_PRM_REGADDR(OMAP3430ES2_USBHOST_MOD, PM_PWSTCTRL),
 	.enable_bit	= OMAP3430ES2_SAVEANDRESTORE_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
 	.clkdm_name	= "usbhost_clkdm",
diff --git a/arch/arm/mach-omap2/memory.c b/arch/arm/mach-omap2/memory.c
index 73cadb2..2ad29fd 100644
--- a/arch/arm/mach-omap2/memory.c
+++ b/arch/arm/mach-omap2/memory.c
@@ -94,7 +94,8 @@ u32 omap2_reprogram_sdrc(u32 level, u32 force)
 	m_type = omap2_memory_get_type();
 
 	local_irq_save(flags);
-	__raw_writel(0xffff, OMAP24XX_PRCM_VOLTSETUP);
+	prm_write_mod_reg(0xffff, OMAP24XX_GR_MOD,
+					OMAP24XX_PRCM_VOLTSETUP_OFFSET);
 	omap2_sram_reprogram_sdrc(level, dll_ctrl, m_type);
 	curr_perf_level = level;
 	local_irq_restore(flags);
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 10088e0..3e34f13 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -134,14 +134,16 @@ no_sleep:
 	prm_clear_mod_reg_bits(0x4 | 0x1, WKUP_MOD, PM_WKST);
 
 	/* MPU domain wake events */
-	l = __raw_readl(OMAP24XX_PRCM_IRQSTATUS_MPU);
+	l = prm_read_mod_reg(OCP_MOD, OMAP24XX_PRCM_IRQSTATUS_MPU_OFFSET);
 	if (l & 0x01)
-		__raw_writel(0x01, OMAP24XX_PRCM_IRQSTATUS_MPU);
+		prm_write_mod_reg(0x01, OCP_MOD,
+				OMAP24XX_PRCM_IRQSTATUS_MPU_OFFSET);
 	if (l & 0x20)
-		__raw_writel(0x20, OMAP24XX_PRCM_IRQSTATUS_MPU);
+		prm_write_mod_reg(0x20, OCP_MOD,
+				OMAP24XX_PRCM_IRQSTATUS_MPU_OFFSET);
 
 	/* Mask future PRCM-to-MPU interrupts */
-	__raw_writel(0x0, OMAP24XX_PRCM_IRQSTATUS_MPU);
+	prm_write_mod_reg(0x0, OCP_MOD, OMAP24XX_PRCM_IRQSTATUS_MPU_OFFSET);
 }
 
 static int omap2_i2c_active(void)
@@ -327,7 +329,8 @@ static void __init prcm_setup_regs(void)
 	u32 l;
 
 	/* Enable autoidle */
-	__raw_writel(OMAP24XX_AUTOIDLE, OMAP24XX_PRCM_SYSCONFIG);
+	prm_write_mod_reg(OMAP24XX_AUTOIDLE, OCP_MOD,
+				OMAP24XX_PRCM_SYSCONFIG_OFFSET);
 
 	/* Set all domain wakeup dependencies */
 	prm_write_mod_reg(OMAP_EN_WKUP_MASK, MPU_MOD, PM_WKDEP);
@@ -433,10 +436,12 @@ static void __init prcm_setup_regs(void)
 
 	/* REVISIT: Configure number of 32 kHz clock cycles for sys_clk
 	 * stabilisation */
-	__raw_writel(15 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_PRCM_CLKSSETUP);
+	prm_write_mod_reg(15 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_GR_MOD,
+					OMAP24XX_PRCM_CLKSSETUP_OFFSET);
 
 	/* Configure automatic voltage transition */
-	__raw_writel(2 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_PRCM_VOLTSETUP);
+	prm_write_mod_reg(2 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_GR_MOD,
+					OMAP24XX_PRCM_VOLTSETUP_OFFSET);
 	prm_write_mod_reg(OMAP24XX_AUTO_EXTVOLT |
 		      (0x1 << OMAP24XX_SETOFF_LEVEL_SHIFT) |
 		      OMAP24XX_MEMRETCTRL |
@@ -454,7 +459,7 @@ int __init omap2_pm_init(void)
 	u32 l;
 
 	printk(KERN_INFO "Power Management for OMAP2 initializing\n");
-	l = __raw_readl(OMAP24XX_PRCM_REVISION);
+	l = prm_read_mod_reg(OCP_MOD, OMAP24XX_PRCM_REVISION_OFFSET);
 	printk(KERN_INFO "PRCM revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
 
 	osc_ck = clk_get(NULL, "osc_ck");
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 6d88f1c..ad17933 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -78,6 +78,20 @@ void prm_write_mod_reg(u32 val, s16 module, u16 idx)
 }
 EXPORT_SYMBOL(prm_write_mod_reg);
 
+/* Read-modify-write a register in a PRM module. Caller must lock */
+u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
+{
+	u32 v;
+
+	v = prm_read_mod_reg(module, idx);
+	v &= ~mask;
+	v |= bits;
+	prm_write_mod_reg(v, module, idx);
+
+	return v;
+}
+EXPORT_SYMBOL(prm_rmw_mod_reg_bits);
+
 /* Read a register in a CM module */
 u32 cm_read_mod_reg(s16 module, u16 idx)
 {
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 5eed16d..f255579 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -16,21 +16,16 @@
 
 #include "prcm-common.h"
 
-#ifndef __ASSEMBLER__
-#define OMAP_PRM_REGADDR(module, reg)					\
-	(__force void __iomem *)IO_ADDRESS(OMAP2_PRM_BASE + (module) + (reg))
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
- * Use __raw_{read,write}l() with these registers.
+ * Use prm_{read,write}_mod_reg() with these registers.
  *
  * With a few exceptions, these are the register names beginning with
  * PRCM_* on 24xx, and PRM_* on 34xx.  (The exceptions are the
@@ -38,9 +33,67 @@
  *
  */
 
-/* Global 24xx registers in GR_MOD (Same as OCP_MOD for 24xx) */
+/* 24xx register offsets in OCP_MOD */
+#define OMAP24XX_PRCM_REVISION_OFFSET		0x0000
+#define OMAP24XX_PRCM_SYSCONFIG_OFFSET		0x0010
+#define OMAP24XX_PRCM_IRQSTATUS_MPU_OFFSET	0x0018
+#define OMAP24XX_PRCM_IRQENABLE_MPU_OFFSET	0x001c
+
+/* 24xx register offsets in OMAP24XX_GR_MOD (Same as OCP_MOD for 24xx) */
 #define OMAP24XX_PRCM_VOLTCTRL_OFFSET		0x0050
+#define OMAP24XX_PRCM_VOLTST_OFFSET		0x0054
+#define OMAP24XX_PRCM_CLKSRC_CTRL_OFFSET	0x0060
+#define OMAP24XX_PRCM_CLKOUT_CTRL_OFFSET	0x0070
+#define OMAP24XX_PRCM_CLKEMUL_CTRL_OFFSET	0x0078
 #define OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET	0x0080
+#define OMAP24XX_PRCM_CLKCFG_STATUS_OFFSET	0x0084
+#define OMAP24XX_PRCM_VOLTSETUP_OFFSET		0x0090
+#define OMAP24XX_PRCM_CLKSSETUP_OFFSET		0x0094
+#define OMAP24XX_PRCM_POLCTRL_OFFSET		0x0098
+
+/* 34xx register offsets in OCP_MOD */
+#define OMAP3430_PRM_REVISION_OFFSET		0x0004
+#define OMAP3430_PRM_SYSCONFIG_OFFSET		0x0014
+#define OMAP3430_PRM_IRQSTATUS_MPU_OFFSET	0x0018
+#define OMAP3430_PRM_IRQENABLE_MPU_OFFSET	0x001c
+
+/* 34xx register offsets in GR_MOD */
+#define OMAP3_PRM_VC_SMPS_SA_OFFSET		0x0020
+#define OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET		0x0024
+#define OMAP3_PRM_VC_SMPS_CMD_RA_OFFSET		0x0028
+#define OMAP3_PRM_VC_CMD_VAL_0_OFFSET		0x002c
+#define OMAP3_PRM_VC_CMD_VAL_1_OFFSET		0x0030
+#define OMAP3_PRM_VC_CH_CONF_OFFSET		0x0034
+#define OMAP3_PRM_VC_I2C_CFG_OFFSET		0x0038
+#define OMAP3_PRM_VC_BYPASS_VAL_OFFSET		0x003c
+#define OMAP3_PRM_RSTCTRL_OFFSET		0x0050
+#define OMAP3_PRM_RSTTIME_OFFSET		0x0054
+#define OMAP3_PRM_RSTST_OFFSET			0x0058
+#define OMAP3_PRM_VOLTCTRL_OFFSET		0x0060
+#define OMAP3_PRM_SRAM_PCHARGE_OFFSET		0x0064
+#define OMAP3_PRM_CLKSRC_CTRL_OFFSET		0x0070
+#define OMAP3_PRM_VOLTSETUP1_OFFSET		0x0090
+#define OMAP3_PRM_VOLTOFFSET_OFFSET		0x0094
+#define OMAP3_PRM_CLKSETUP_OFFSET		0x0098
+#define OMAP3_PRM_POLCTRL_OFFSET		0x009c
+#define OMAP3_PRM_VOLTSETUP2_OFFSET		0x00a0
+#define OMAP3_PRM_VP1_CONFIG_OFFSET		0x00b0
+#define OMAP3_PRM_VP1_VSTEPMIN_OFFSET		0x00b4
+#define OMAP3_PRM_VP1_VSTEPMAX_OFFSET		0x00b8
+#define OMAP3_PRM_VP1_VLIMITTO_OFFSET		0x00bc
+#define OMAP3_PRM_VP1_VOLTAGE_OFFSET		0x00c0
+#define OMAP3_PRM_VP1_STATUS_OFFSET		0x00c4
+#define OMAP3_PRM_VP2_CONFIG_OFFSET		0x00d0
+#define OMAP3_PRM_VP2_VSTEPMIN_OFFSET		0x00d4
+#define OMAP3_PRM_VP2_VSTEPMAX_OFFSET		0x00d8
+#define OMAP3_PRM_VP2_VLIMITTO_OFFSET		0x00dc
+#define OMAP3_PRM_VP2_VOLTAGE_OFFSET		0x00e0
+#define OMAP3_PRM_VP2_STATUS_OFFSET		0x00e4
+
+/* 34xx register offsets in CCR_MOD */
+#define OMAP3_PRM_CLKSEL_OFFSET			0x0040
+#define OMAP3_PRM_CLKOUT_CTRL_OFFSET		0x0070
+
 
 /* 242x GR_MOD registers, use these only for assembly code */
 #define OMAP242X_PRCM_VOLTCTRL		OMAP2420_PRM_REGADDR(OMAP24XX_GR_MOD,	\
@@ -55,79 +108,45 @@
 						OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET)
 
 /* These will disappear */
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
-
-#ifndef __ASSEMBLER__
-
-/* Read-modify-write bits in a PRM register */
-static __inline__ u32 __attribute__((unused)) prm_rmw_reg_bits(u32 mask,
-						u32 bits, void __iomem *va)
-{
-	u32 v;
-
-	v = __raw_readl(va);
-	v &= ~mask;
-	v |= bits;
-	__raw_writel(v, va);
-
-	return v;
-}
 
-#endif
+#define OMAP3430_PRM_IRQSTATUS_MPU	OMAP34XX_PRM_REGADDR(OCP_MOD, 0x0018)
+#define OMAP3430_PRM_IRQENABLE_MPU	OMAP34XX_PRM_REGADDR(OCP_MOD, 0x001c)
+
+/* 34xx GR_MOD registers, use these only for assembly code */
+#define OMAP3430_PRM_VC_SMPS_SA		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0020)
+#define OMAP3430_PRM_VC_SMPS_VOL_RA	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0024)
+#define OMAP3430_PRM_VC_SMPS_CMD_RA	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0028)
+#define OMAP3430_PRM_VC_CMD_VAL_0	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x002c)
+#define OMAP3430_PRM_VC_CMD_VAL_1	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0030)
+#define OMAP3430_PRM_VC_CH_CONF		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0034)
+#define OMAP3430_PRM_VC_I2C_CFG		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0038)
+#define OMAP3430_PRM_VC_BYPASS_VAL	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x003c)
+#define OMAP3430_PRM_RSTCTRL		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0050)
+#define OMAP3430_PRM_RSTTIME		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0054)
+#define OMAP3430_PRM_RSTST		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0058)
+#define OMAP3430_PRM_VOLTCTRL		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0060)
+#define OMAP3430_PRM_SRAM_PCHARGE	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0064)
+#define OMAP3430_PRM_CLKSRC_CTRL	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0070)
+#define OMAP3430_PRM_VOLTSETUP1		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0090)
+#define OMAP3430_PRM_VOLTOFFSET		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0094)
+#define OMAP3430_PRM_CLKSETUP		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0098)
+#define OMAP3430_PRM_POLCTRL		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x009c)
+#define OMAP3430_PRM_VOLTSETUP2		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00a0)
+#define OMAP3430_PRM_VP1_CONFIG		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b0)
+#define OMAP3430_PRM_VP1_VSTEPMIN	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b4)
+#define OMAP3430_PRM_VP1_VSTEPMAX	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00b8)
+#define OMAP3430_PRM_VP1_VLIMITTO	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00bc)
+#define OMAP3430_PRM_VP1_VOLTAGE	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00c0)
+#define OMAP3430_PRM_VP1_STATUS		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00c4)
+#define OMAP3430_PRM_VP2_CONFIG		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d0)
+#define OMAP3430_PRM_VP2_VSTEPMIN	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d4)
+#define OMAP3430_PRM_VP2_VSTEPMAX	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00d8)
+#define OMAP3430_PRM_VP2_VLIMITTO	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00dc)
+#define OMAP3430_PRM_VP2_VOLTAGE	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00e0)
+#define OMAP3430_PRM_VP2_STATUS		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x00e4)
+
+#define OMAP3430_PRM_CLKSEL		OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, 0x0040)
+#define OMAP3430_PRM_CLKOUT_CTRL	OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, 0x0070)
 
 /*
  * Module specific PRM registers from PRM_BASE + domain offset
@@ -183,13 +202,12 @@ static __inline__ u32 __attribute__((unused)) prm_rmw_reg_bits(u32 mask,
 
 #ifndef __ASSEMBLER__
 
-/* Read-modify-write bits in a PRM register (by domain) */
-static u32 __attribute__((unused)) prm_rmw_mod_reg_bits(u32 mask, u32 bits,
-							s16 module, s16 idx)
-{
-	return prm_rmw_reg_bits(mask, bits, OMAP_PRM_REGADDR(module, idx));
-}
+/* Power/reset management domain register get/set */
+extern u32 prm_read_mod_reg(s16 module, u16 idx);
+extern void prm_write_mod_reg(u32 val, s16 module, u16 idx);
+extern u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
 
+/* Read-modify-write bits in a PRM register (by domain) */
 static u32 __attribute__((unused)) prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
 {
 	return prm_rmw_mod_reg_bits(bits, bits, module, idx);
@@ -200,10 +218,6 @@ static u32 __attribute__((unused)) prm_clear_mod_reg_bits(u32 bits, s16 module,
 	return prm_rmw_mod_reg_bits(bits, 0x0, module, idx);
 }
 
-/* Power/reset management domain register get/set */
-extern u32 prm_read_mod_reg(s16 module, u16 idx);
-extern void prm_write_mod_reg(u32 val, s16 module, u16 idx);
-
 #endif
 
 /*
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index dfe9c46..8a718ff 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -271,6 +271,7 @@ static void __init __omap2_set_globals(void)
 	omap2_set_globals_memory(omap2_globals);
 	omap2_set_globals_control(omap2_globals);
 	omap2_set_globals_prcm(omap2_globals);
+	omap2_set_globals_clock24xx(omap2_globals);
 }
 
 #endif
diff --git a/include/asm-arm/arch-omap/clock.h b/include/asm-arm/arch-omap/clock.h
index 0e28247..bfaf7b6 100644
--- a/include/asm-arm/arch-omap/clock.h
+++ b/include/asm-arm/arch-omap/clock.h
@@ -139,7 +139,8 @@ extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
 #define CONFIG_PARTICIPANT	(1 << 10)	/* Fundamental clock */
 #define ENABLE_ON_INIT		(1 << 11)	/* Enable upon framework init */
 #define INVERT_ENABLE           (1 << 12)       /* 0 enables, 1 disables */
-/* bits 13-20 are currently free */
+#define OFFSET_GR_MOD		(1 << 13)	/* 24xx GR_MOD reg as offset */
+/* bits 14-20 are currently free */
 #define CLOCK_IN_OMAP310	(1 << 21)
 #define CLOCK_IN_OMAP730	(1 << 22)
 #define CLOCK_IN_OMAP1510	(1 << 23)
diff --git a/include/asm-arm/arch-omap/common.h b/include/asm-arm/arch-omap/common.h
index e015e94..e4cce2e 100644
--- a/include/asm-arm/arch-omap/common.h
+++ b/include/asm-arm/arch-omap/common.h
@@ -66,5 +66,10 @@ void omap2_set_globals_343x(void);
 void omap2_set_globals_memory(struct omap_globals *);
 void omap2_set_globals_control(struct omap_globals *);
 void omap2_set_globals_prcm(struct omap_globals *);
+#ifdef CONFIG_ARCH_OMAP24XX
+void omap2_set_globals_clock24xx(struct omap_globals *);
+#else
+#define omap2_set_globals_clock24xx(x)	do { } while (0)
+#endif
 
 #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */
-- 
1.5.3.6

