From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/16] ARM: OMAP2: Remove OMAP_PRM_REGADDR
Date: Fri,  6 Jun 2008 19:12:34 -0700
Message-ID: <1212804762-18413-7-git-send-email-tony@atomide.com>
References: 1212803277-18007-1-git-send-email-tony@atomide.com
 <1212804762-18413-1-git-send-email-tony@atomide.com>
 <1212804762-18413-2-git-send-email-tony@atomide.com>
 <1212804762-18413-3-git-send-email-tony@atomide.com>
 <1212804762-18413-4-git-send-email-tony@atomide.com>
 <1212804762-18413-5-git-send-email-tony@atomide.com>
 <1212804762-18413-6-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49368 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755092AbYFGCM5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 22:12:57 -0400
In-Reply-To: <1212804762-18413-6-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Remove OMAP_PRM_REGADDR. Use prm_read/write_mod_reg() instead.
For assembly, use OMAPXXXX_PRM_REGADDR macros.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 660d49f..d3ab537 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -28,6 +28,7 @@
 #include <asm/arch/clockdomain.h>
 #include <asm/arch/sram.h>
 #include <asm/arch/cpu.h>
+#include <asm/arch/prcm.h>
 #include <asm/div64.h>
 
 #include "memory.h"
@@ -245,8 +246,8 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	/* REVISIT: What are the appropriate exclusions for 34XX? */
 	/* OMAP3: ignore DSS-mod clocks */
 	if (cpu_is_omap34xx() &&
-	    ((reg & ~0xff) == (__force u32)OMAP_CM_REGADDR(OMAP3430_DSS_MOD, 0) ||
-	     (((reg & ~0xff) == (__force u32)OMAP_CM_REGADDR(CORE_MOD, 0)) &&
+	    ((reg & ~0xff) == cm_read_mod_reg(OMAP3430_DSS_MOD, 0) ||
+	     (((reg & ~0xff) == cm_read_mod_reg(CORE_MOD, 0)) &&
 	      clk->enable_bit == OMAP3430_EN_SSI_SHIFT)))
 		return;
 
@@ -630,8 +631,9 @@ u32 omap2_clksel_get_divisor(struct clk *clk)
 
 int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
 {
-	u32 field_mask, field_val, reg_val, validrate, new_div = 0;
+	u32 field_mask, field_val, validrate, new_div = 0;
 	void __iomem *div_addr;
+	u32 v;
 
 	validrate = omap2_clksel_round_rate_div(clk, rate, &new_div);
 	if (validrate != rate)
@@ -645,10 +647,11 @@ int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
 	if (field_val == ~0)
 		return -EINVAL;
 
-	reg_val = __raw_readl(div_addr);
-	reg_val &= ~field_mask;
-	reg_val |= (field_val << __ffs(field_mask));
-	__raw_writel(reg_val, div_addr);
+	v = __raw_readl(div_addr);
+	v &= ~field_mask;
+	v |= field_val << __ffs(field_mask);
+	__raw_writel(v, div_addr);
+
 	wmb();
 
 	clk->rate = clk->parent->rate / new_div;
@@ -751,7 +754,8 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	wmb();
 
 	if (clk->flags & DELAYED_APP && cpu_is_omap24xx()) {
-		__raw_writel(OMAP24XX_VALID_CONFIG, OMAP24XX_PRCM_CLKCFG_CTRL);
+		prm_write_mod_reg(OMAP24XX_VALID_CONFIG,
+			OMAP24XX_GR_MOD, OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET);
 		wmb();
 	}
 
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 61ddcd0..0d6293b 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -28,6 +28,7 @@
 #include <linux/io.h>
 #include <linux/cpufreq.h>
 
+#include <asm/arch/common.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sram.h>
 #include <asm/div64.h>
@@ -76,24 +77,16 @@ static u32 omap2_get_dpll_rate_24xx(struct clk *tclk)
 
 static int omap2_enable_osc_ck(struct clk *clk)
 {
-	u32 pcc;
-
-	pcc = __raw_readl(OMAP24XX_PRCM_CLKSRC_CTRL);
-
-	__raw_writel(pcc & ~OMAP_AUTOEXTCLKMODE_MASK,
-		      OMAP24XX_PRCM_CLKSRC_CTRL);
+	prm_rmw_mod_reg_bits(OMAP_AUTOEXTCLKMODE_MASK, 0,
+			OMAP24XX_GR_MOD, OMAP24XX_PRCM_CLKSRC_CTRL_OFFSET);
 
 	return 0;
 }
 
 static void omap2_disable_osc_ck(struct clk *clk)
 {
-	u32 pcc;
-
-	pcc = __raw_readl(OMAP24XX_PRCM_CLKSRC_CTRL);
-
-	__raw_writel(pcc | OMAP_AUTOEXTCLKMODE_MASK,
-		      OMAP24XX_PRCM_CLKSRC_CTRL);
+	prm_rmw_mod_reg_bits(OMAP_AUTOEXTCLKMODE_MASK, OMAP_AUTOEXTCLKMODE_MASK,
+			OMAP24XX_GR_MOD, OMAP24XX_PRCM_CLKSRC_CTRL_OFFSET);
 }
 
 #ifdef OLD_CK
@@ -420,7 +413,8 @@ static u32 omap2_get_sysclkdiv(void)
 {
 	u32 div;
 
-	div = __raw_readl(OMAP24XX_PRCM_CLKSRC_CTRL);
+	div = prm_read_mod_reg(OMAP24XX_GR_MOD,
+				OMAP24XX_PRCM_CLKSRC_CTRL_OFFSET);
 	div &= OMAP_SYSCLKDIV_MASK;
 	div >>= OMAP_SYSCLKDIV_SHIFT;
 
@@ -476,6 +470,37 @@ static int __init omap2_clk_arch_init(void)
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
@@ -487,6 +512,12 @@ int __init omap2_clk_init(void)
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
@@ -538,3 +569,9 @@ int __init omap2_clk_init(void)
 
 	return 0;
 }
+
+void __init omap2_set_globals_clock24xx(struct omap_globals *omap2_globals)
+{
+	prm_base = (__force u32)omap2_globals->prm;
+	cm_base = (__force u32)omap2_globals->cm;
+}
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 00ca071..a2898a1 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -600,6 +600,8 @@ static struct prcm_config rate_table[] = {
 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
 };
 
+#define _GR_MOD_OFFSET(reg)	((void __iomem *)(OMAP24XX_GR_MOD + (reg)))
+
 /*-------------------------------------------------------------------------
  * 24xx clock tree.
  *
@@ -889,12 +891,12 @@ static struct clk sys_clkout_src = {
 	.name		= "sys_clkout_src",
 	.parent		= &func_54m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES,
+				RATE_PROPAGATES | OFFSET_GR_MOD,
 	.clkdm_name	= "wkup_clkdm",
-	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.enable_reg	= _GR_MOD_OFFSET(OMAP24XX_PRCM_CLKOUT_CTRL_OFFSET),
 	.enable_bit	= OMAP24XX_CLKOUT_EN_SHIFT,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_reg	= _GR_MOD_OFFSET(OMAP24XX_PRCM_CLKOUT_CTRL_OFFSET),
 	.clksel_mask	= OMAP24XX_CLKOUT_SOURCE_MASK,
 	.clksel		= common_clkout_src_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -920,9 +922,9 @@ static struct clk sys_clkout = {
 	.name		= "sys_clkout",
 	.parent		= &sys_clkout_src,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				PARENT_CONTROLS_CLOCK,
+				PARENT_CONTROLS_CLOCK | OFFSET_GR_MOD,
 	.clkdm_name	= "wkup_clkdm",
-	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_reg	= _GR_MOD_OFFSET(OMAP24XX_PRCM_CLKOUT_CTRL_OFFSET),
 	.clksel_mask	= OMAP24XX_CLKOUT_DIV_MASK,
 	.clksel		= sys_clkout_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -934,12 +936,12 @@ static struct clk sys_clkout = {
 static struct clk sys_clkout2_src = {
 	.name		= "sys_clkout2_src",
 	.parent		= &func_54m_ck,
-	.flags		= CLOCK_IN_OMAP242X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP242X | RATE_PROPAGATES | OFFSET_GR_MOD,
 	.clkdm_name	= "wkup_clkdm",
-	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.enable_reg	= _GR_MOD_OFFSET(OMAP24XX_PRCM_CLKOUT_CTRL_OFFSET),
 	.enable_bit	= OMAP2420_CLKOUT2_EN_SHIFT,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_reg	= _GR_MOD_OFFSET(OMAP24XX_PRCM_CLKOUT_CTRL_OFFSET),
 	.clksel_mask	= OMAP2420_CLKOUT2_SOURCE_MASK,
 	.clksel		= common_clkout_src_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -956,9 +958,10 @@ static const struct clksel sys_clkout2_clksel[] = {
 static struct clk sys_clkout2 = {
 	.name		= "sys_clkout2",
 	.parent		= &sys_clkout2_src,
-	.flags		= CLOCK_IN_OMAP242X | PARENT_CONTROLS_CLOCK,
+	.flags		= CLOCK_IN_OMAP242X | PARENT_CONTROLS_CLOCK |
+				OFFSET_GR_MOD,
 	.clkdm_name	= "wkup_clkdm",
-	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_reg	= _GR_MOD_OFFSET(OMAP24XX_PRCM_CLKOUT_CTRL_OFFSET),
 	.clksel_mask	= OMAP2420_CLKOUT2_DIV_MASK,
 	.clksel		= sys_clkout2_clksel,
 	.recalc		= &omap2_clksel_recalc,
@@ -969,9 +972,9 @@ static struct clk sys_clkout2 = {
 static struct clk emul_ck = {
 	.name		= "emul_ck",
 	.parent		= &func_54m_ck,
-	.flags		= CLOCK_IN_OMAP242X,
+	.flags		= CLOCK_IN_OMAP242X | OFFSET_GR_MOD,
 	.clkdm_name	= "wkup_clkdm",
-	.enable_reg	= OMAP24XX_PRCM_CLKEMUL_CTRL,
+	.enable_reg	= _GR_MOD_OFFSET(OMAP24XX_PRCM_CLKEMUL_CTRL_OFFSET),
 	.enable_bit	= OMAP24XX_EMULATION_EN_SHIFT,
 	.recalc		= &followparent_recalc,
 
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 8f90b8c..fb89d4a 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -53,6 +53,15 @@ static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate);
 #define DPLL_LOW_POWER_BYPASS		0x5
 #define DPLL_LOCKED			0x7
 
+#define OMAP3430_PRM_CLKSRC_CTRL					\
+	OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, 0x0070)
+
+#define OMAP3430_PRM_CLKSEL						\
+	OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, OMAP3_PRM_CLKSEL_OFFSET)
+
+#define OMAP3430_PRM_CLKOUT_CTRL					\
+	OMAP34XX_PRM_REGADDR(OMAP3430_CCR_MOD, OMAP3_PRM_CLKOUT_CTRL_OFFSET)
+
 /* PRM CLOCKS */
 
 /* According to timer32k.c, this is a 32768Hz clock, not a 32000Hz clock. */
@@ -2223,7 +2232,7 @@ static struct clk usbhost_sar_fck = {
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
diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
index 5b5ecfe..c6a7940 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -366,6 +366,7 @@
 
 /* PM_WKEN_WKUP specific bits */
 #define OMAP3430_EN_IO					(1 << 8)
+#define OMAP3430_EN_GPIO1				(1 << 3)
 
 /* PM_MPUGRPSEL_WKUP specific bits */
 
@@ -452,6 +453,14 @@
 #define OMAP3430_CMDRA0_MASK				(0xff << 0)
 
 /* PRM_VC_CMD_VAL_0 specific bits */
+#define OMAP3430_VC_CMD_ON_SHIFT			24
+#define OMAP3430_VC_CMD_ON_MASK				(0xFF << 24)
+#define OMAP3430_VC_CMD_ONLP_SHIFT			16
+#define OMAP3430_VC_CMD_ONLP_MASK			(0xFF << 16)
+#define OMAP3430_VC_CMD_RET_SHIFT			8
+#define OMAP3430_VC_CMD_RET_MASK			(0xFF << 8)
+#define OMAP3430_VC_CMD_OFF_SHIFT			0
+#define OMAP3430_VC_CMD_OFF_MASK			(0xFF << 0)
 
 /* PRM_VC_CMD_VAL_1 specific bits */
 
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index eb9982f..f7dac2e 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -4,8 +4,8 @@
 /*
  * OMAP2/3 Power/Reset Management (PRM) register definitions
  *
- * Copyright (C) 2007 Texas Instruments, Inc.
- * Copyright (C) 2007 Nokia Corporation
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2008 Nokia Corporation
  *
  * Written by Paul Walmsley
  *
@@ -16,21 +16,16 @@
 
 #include "prcm-common.h"
 
-#ifndef __ASSEMBLER__
-#define OMAP_PRM_REGADDR(module, reg)					\
-	(void __iomem *)IO_ADDRESS(OMAP2_PRM_BASE + (module) + (reg))
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
@@ -38,80 +33,66 @@
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
 
 /*
  * Module specific PRM registers from PRM_BASE + domain offset
@@ -141,6 +122,19 @@
 #define PM_PWSTCTRL					0x00e0
 #define PM_PWSTST					0x00e4
 
+/* Omap2 specific registers */
+#define OMAP24XX_PM_WKEN2				0x00a4
+#define OMAP24XX_PM_WKST2				0x00b4
+
+#define OMAP24XX_PRCM_IRQSTATUS_DSP			0x00f0	/* IVA mod */
+#define OMAP24XX_PRCM_IRQENABLE_DSP			0x00f4	/* IVA mod */
+#define OMAP24XX_PRCM_IRQSTATUS_IVA			0x00f8
+#define OMAP24XX_PRCM_IRQENABLE_IVA			0x00fc
+
+/* Omap3 specific registers */
+#define OMAP3430ES2_PM_WKEN3				0x00f0
+#define OMAP3430ES2_PM_WKST3				0x00b8
+
 #define OMAP3430_PM_MPUGRPSEL				0x00a4
 #define OMAP3430_PM_MPUGRPSEL1				OMAP3430_PM_MPUGRPSEL
 
@@ -152,17 +146,6 @@
 #define OMAP3430_PRM_IRQSTATUS_IVA2			0x00f8
 #define OMAP3430_PRM_IRQENABLE_IVA2			0x00fc
 
-
-/* Architecture-specific registers */
-
-#define OMAP24XX_PM_WKEN2				0x00a4
-#define OMAP24XX_PM_WKST2				0x00b4
-
-#define OMAP24XX_PRCM_IRQSTATUS_DSP			0x00f0	/* IVA mod */
-#define OMAP24XX_PRCM_IRQENABLE_DSP			0x00f4	/* IVA mod */
-#define OMAP24XX_PRCM_IRQSTATUS_IVA			0x00f8
-#define OMAP24XX_PRCM_IRQENABLE_IVA			0x00fc
-
 #ifndef __ASSEMBLER__
 
 /* Power/reset management domain register get/set */
@@ -228,7 +211,6 @@ static inline u32 prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
 #define OMAP_RSTTIME1_SHIFT				0
 #define OMAP_RSTTIME1_MASK				(0xff << 0)
 
-
 /* PRM_RSTCTRL */
 /* Named RM_RSTCTRL_WKUP on the 24xx */
 /* 2420 calls RST_DPLL3 'RST_DPLL' */
diff --git a/arch/arm/mach-omap2/sram242x.S b/arch/arm/mach-omap2/sram242x.S
index 4c27451..967d12b 100644
--- a/arch/arm/mach-omap2/sram242x.S
+++ b/arch/arm/mach-omap2/sram242x.S
@@ -31,6 +31,11 @@
 #include "cm.h"
 #include "sdrc.h"
 
+#define OMAP242X_PRCM_VOLTCTRL		OMAP2420_PRM_REGADDR(OMAP24XX_GR_MOD,	\
+						OMAP24XX_PRCM_VOLTCTRL_OFFSET)
+#define OMAP242X_PRCM_CLKCFG_CTRL	OMAP2420_PRM_REGADDR(OMAP24XX_GR_MOD,	\
+						OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET)
+
 	.text
 
 ENTRY(omap242x_sram_ddr_init)
diff --git a/arch/arm/mach-omap2/sram243x.S b/arch/arm/mach-omap2/sram243x.S
index a3fa48d..1d6eb10 100644
--- a/arch/arm/mach-omap2/sram243x.S
+++ b/arch/arm/mach-omap2/sram243x.S
@@ -31,6 +31,11 @@
 #include "cm.h"
 #include "sdrc.h"
 
+#define OMAP243X_PRCM_VOLTCTRL		OMAP2430_PRM_REGADDR(OMAP24XX_GR_MOD,	\
+						OMAP24XX_PRCM_VOLTCTRL_OFFSET)
+#define OMAP243X_PRCM_CLKCFG_CTRL	OMAP2430_PRM_REGADDR(OMAP24XX_GR_MOD,	\
+						OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET)
+
 	.text
 
 ENTRY(omap243x_sram_ddr_init)
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 8d04929..f5e7612 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -251,6 +251,7 @@ static void __init __omap2_set_globals(void)
 	omap2_set_globals_memory(omap2_globals);
 	omap2_set_globals_control(omap2_globals);
 	omap2_set_globals_prcm(omap2_globals);
+	omap2_set_globals_clock24xx(omap2_globals);
 }
 
 #endif
diff --git a/include/asm-arm/arch-omap/clock.h b/include/asm-arm/arch-omap/clock.h
index c2bc8d7..fc5abc3 100644
--- a/include/asm-arm/arch-omap/clock.h
+++ b/include/asm-arm/arch-omap/clock.h
@@ -136,7 +136,8 @@ extern void clk_enable_init_clocks(void);
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
