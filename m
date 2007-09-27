From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/7] omap2 clock: add OMAP3430 clock definitions, basic code
Date: Thu, 27 Sep 2007 00:11:23 -0600
Message-ID: <20070927061256.891680465@pwsan.com>
References: <20070927061119.551228401@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=add_clock34xx.h.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Define the clock tree, and add basic supporting clock code, for the 
OMAP34xx chips.  The definitions and code go into two new files, 
clock34xx.[ch].

The 34xx clock tree and code is written to reuse as much of the
existing OMAP clock infrastructure as is reasonable, and to introduce
the minimum amount possible of special-case code.  One notable
addition is the expansion of the dpll_params structure to include the
additional DPLL control registers used on OMAP34XX; most of these
extra registers are used in subsequent patches.

The patches seek to follow the TRM closely.  One implication of this
is that several intermediary clocks are defined that are not
software-controllable, and could normally be removed.  Some examples
include omap_96m_fck, core_l3_ick, corex2_fck.  I included these
clocks for several reasons.  Any further changes in pre-production
OMAP34xx silicon revisions may cause one of these clocks to become
software-controllable; the extra clocks make it easier to double-check
this patch against the TRM, if anyone wishes to do so; and ultimately,
it is easier to remove these clocks than to add them back in.  I
anticipate that we will remove these intermediary clocks once the 3430
silicon and clock definitions mature.

There are some notable divergences between the TRM and the patch.
They include:

* Clock suffixes end in "ck" rather than "clk"; this follows OMAP2
  clock naming style to minimize driver changes in the rest of the tree.

* The dpll*_alwon_fck clocks have been removed (they are not software
  controllable, and are unlikely to change)

* Some documentation in the TRM is inconsistent; I sought to apply
  the most likely resolution in the code.


Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/Makefile           |    1 
 arch/arm/mach-omap2/clock.c            |   45 
 arch/arm/mach-omap2/clock34xx.c        |  222 +++
 arch/arm/mach-omap2/clock34xx.h        | 2214 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cm.h               |    2 
 arch/arm/mach-omap2/cm_regbits_34xx.h  |  138 +-
 arch/arm/mach-omap2/prcm_common.h      |   41 
 arch/arm/mach-omap2/prm.h              |    2 
 arch/arm/mach-omap2/prm_regbits_34xx.h |    9 
 include/asm-arm/arch-omap/clock.h      |    9 
 10 files changed, 2655 insertions(+), 28 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock34xx.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap/arch/arm/mach-omap2/clock34xx.h	2007-09-26 01:50:32.000000000 -0600
@@ -0,0 +1,2214 @@
+/*
+ * OMAP3 clock framework
+ *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ * Copyright (C) 2007 Nokia Corporation
+ *
+ * Written by Paul Walmsley
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK34XX_H
+#define __ARCH_ARM_MACH_OMAP2_CLOCK34XX_H
+
+#include "clock.h"
+#include "cm.h"
+#include "cm_regbits_34xx.h"
+#include "prm.h"
+#include "prm_regbits_34xx.h"
+
+static void omap3_dpll_recalc(struct clk *clk);
+static void omap3_clkoutx2_recalc(struct clk *clk);
+
+/* REVISIT: this stuff should be moved to a scm.h file */
+/* CONTROL_DEVCONF0 bits */
+#define OMAP3430_MCBSP2_CLKS_MASK		    (1 << 6)
+#define OMAP3430_MCBSP1_CLKS_MASK		    (1 << 2)
+/* OMAP34XX_CONTROL_DEVCONF1 bits */
+#define OMAP3430_MCBSP5_CLKS_MASK		    (1 << 4)
+#define OMAP3430_MCBSP4_CLKS_MASK		    (1 << 2)
+#define OMAP3430_MCBSP3_CLKS_MASK		    (1 << 0)
+
+/*
+ * DPLL1 supplies clock to the MPU.
+ * DPLL2 supplies clock to the IVA2.
+ * DPLL3 supplies CORE domain clocks.
+ * DPLL4 supplies peripheral clocks.
+ */
+
+/* PRM CLOCKS */
+
+/* According to timer32k.c, this is a 32768Hz clock, not a 32000Hz clock. */
+static struct clk omap_32k_fck = {
+	.name		= "omap_32k_fck",
+	.rate		= 32768,
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
+				ALWAYS_ENABLED,
+	.recalc		= &propagate_rate,
+};
+
+static struct clk secure_32k_fck = {
+	.name		= "secure_32k_fck",
+	.rate		= 32768,
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
+				ALWAYS_ENABLED,
+	.recalc		= &propagate_rate,
+};
+
+/* Virtual source clocks for osc_sys_ck */
+static struct clk virt_12m_ck = {
+	.name		= "virt_12m_ck",
+	.rate		= 12000000,
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
+				ALWAYS_ENABLED,
+	.recalc		= &propagate_rate,
+};
+
+static struct clk virt_13m_ck = {
+	.name		= "virt_13m_ck",
+	.rate		= 13000000,
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
+				ALWAYS_ENABLED,
+	.recalc		= &propagate_rate,
+};
+
+/* 3430ES2 only */
+static struct clk virt_16_8m_ck = {
+	.name		= "virt_16_8m_ck",
+	.rate		= 16800000,
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
+				ALWAYS_ENABLED,
+	.recalc		= &propagate_rate,
+};
+
+static struct clk virt_19_2m_ck = {
+	.name		= "virt_19_2m_ck",
+	.rate		= 19200000,
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
+				ALWAYS_ENABLED,
+	.recalc		= &propagate_rate,
+};
+
+static struct clk virt_26m_ck = {
+	.name		= "virt_26m_ck",
+	.rate		= 26000000,
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
+				ALWAYS_ENABLED,
+	.recalc		= &propagate_rate,
+};
+
+static struct clk virt_38_4m_ck = {
+	.name		= "virt_38_4m_ck",
+	.rate		= 38400000,
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
+				ALWAYS_ENABLED,
+	.recalc		= &propagate_rate,
+};
+
+static const struct clksel_rate osc_sys_12m_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate osc_sys_13m_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+/* 3430ES2 only */
+static const struct clksel_rate osc_sys_16_8m_rates[] = {
+	{ .div = 1, .val = 5, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate osc_sys_19_2m_rates[] = {
+	{ .div = 1, .val = 2, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate osc_sys_26m_rates[] = {
+	{ .div = 1, .val = 3, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate osc_sys_38_4m_rates[] = {
+	{ .div = 1, .val = 4, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel osc_sys_clksel[] = {
+	{ .parent = &virt_12m_ck,   .rates = osc_sys_12m_rates },
+	{ .parent = &virt_13m_ck,   .rates = osc_sys_13m_rates },
+	{ .parent = &virt_16_8m_ck, .rates = osc_sys_16_8m_rates },
+	{ .parent = &virt_19_2m_ck, .rates = osc_sys_19_2m_rates },
+	{ .parent = &virt_26m_ck,   .rates = osc_sys_26m_rates },
+	{ .parent = &virt_38_4m_ck, .rates = osc_sys_38_4m_rates },
+	{ .parent = NULL },
+};
+
+/* Oscillator clock */
+/* 12, 13, 16.8, 19.2, 26, or 38.4 MHz */
+static struct clk osc_sys_ck = {
+	.name		= "osc_sys_ck",
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP3430_PRM_CLKSEL,
+	.clksel_mask	= OMAP3430_SYS_CLKIN_SEL_MASK,
+	.clksel		= osc_sys_clksel,
+	/* REVISIT: deal with autoextclkmode? */
+	.flags		= CLOCK_IN_OMAP343X | RATE_FIXED | RATE_PROPAGATES |
+				ALWAYS_ENABLED,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static const struct clksel_rate sys_osc_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
+	{ .div = 0 }
+};
+
+static const struct clksel sys_clksel[] = {
+	{ .parent = &osc_sys_ck, .rates = sys_osc_rates },
+	{ .parent = NULL }
+};
+
+/* Latency: this clock is only enabled after PRM_CLKSETUP.SETUP_TIME */
+/* Feeds DPLLs - divided first by PRM_CLKSRC_CTRL.SYSCLKDIV? */
+static struct clk sys_ck = {
+	.name		= "sys_ck",
+	.parent		= &osc_sys_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP3430_PRM_CLKSRC_CTRL,
+	.clksel_mask	= OMAP_SYSCLKDIV_MASK,
+	.clksel		= sys_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk sys_altclk = {
+	.name		= "sys_altclk",
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.recalc		= &propagate_rate,
+};
+
+/* Optional external clock input for some McBSPs */
+static struct clk mcbsp_clks = {
+	.name		= "mcbsp_clks",
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.recalc		= &propagate_rate,
+};
+
+/* PRM EXTERNAL CLOCK OUTPUT */
+
+static struct clk sys_clkout1 = {
+	.name		= "sys_clkout1",
+	.parent		= &osc_sys_ck,
+	.enable_reg	= OMAP3430_PRM_CLKOUT_CTRL,
+	.enable_bit	= OMAP3430_CLKOUT_EN_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+/* DPLLS */
+
+/* CM CLOCKS */
+
+/* DPLL1 */
+/* MPU clock source */
+/* Type: DPLL */
+static const struct dpll_data dpll1_dd = {
+	.mult_div1_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL),
+	.mult_mask	= OMAP3430_MPU_DPLL_MULT_MASK,
+	.div1_mask	= OMAP3430_MPU_DPLL_DIV_MASK,
+	.div2_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL2_PLL),
+	.div2_mask	= OMAP3430_MPU_DPLL_CLKOUT_DIV_MASK,
+	.control_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKEN_PLL),
+	.enable_mask	= OMAP3430_EN_MPU_DPLL_MASK,
+	.auto_recal_bit	= OMAP3430_EN_MPU_DPLL_DRIFTGUARD_SHIFT,
+	.recal_en_bit	= OMAP3430_MPU_DPLL_RECAL_EN_SHIFT,
+	.recal_st_bit	= OMAP3430_MPU_DPLL_ST_SHIFT,
+};
+
+static struct clk dpll1_ck = {
+	.name		= "dpll1_ck",
+	.parent		= &sys_ck,
+	.dpll_data	= &dpll1_dd,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &omap3_dpll_recalc,
+};
+
+/* DPLL2 */
+/* IVA2 clock source */
+/* Type: DPLL */
+
+static const struct dpll_data dpll2_dd = {
+	.mult_div1_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSEL1_PLL),
+	.mult_mask	= OMAP3430_IVA2_DPLL_MULT_MASK,
+	.div1_mask	= OMAP3430_IVA2_DPLL_DIV_MASK,
+	.div2_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSEL2_PLL),
+	.div2_mask	= OMAP3430_IVA2_DPLL_CLKOUT_DIV_MASK,
+	.control_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKEN_PLL),
+	.enable_mask	= OMAP3430_EN_IVA2_DPLL_MASK,
+	.auto_recal_bit	= OMAP3430_EN_IVA2_DPLL_DRIFTGUARD_SHIFT,
+	.recal_en_bit	= OMAP3430_PRM_IRQENABLE_MPU_IVA2_DPLL_RECAL_EN_SHIFT,
+	.recal_st_bit	= OMAP3430_PRM_IRQSTATUS_MPU_IVA2_DPLL_ST_SHIFT,
+};
+
+static struct clk dpll2_ck = {
+	.name		= "dpll2_ck",
+	.parent		= &sys_ck,
+	.dpll_data	= &dpll2_dd,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &omap3_dpll_recalc,
+};
+
+/* DPLL3 */
+/* Source clock for all interfaces and for some device fclks */
+/* Type: DPLL */
+static const struct dpll_data dpll3_dd = {
+	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+	.mult_mask	= OMAP3430_CORE_DPLL_MULT_MASK,
+	.div1_mask	= OMAP3430_CORE_DPLL_DIV_MASK,
+	.div2_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+	.div2_mask	= OMAP3430_CORE_DPLL_CLKOUT_DIV_MASK,
+	.control_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+	.enable_mask	= OMAP3430_EN_CORE_DPLL_MASK,
+	.auto_recal_bit	= OMAP3430_EN_CORE_DPLL_DRIFTGUARD_SHIFT,
+	.recal_en_bit	= OMAP3430_CORE_DPLL_RECAL_EN_SHIFT,
+	.recal_st_bit	= OMAP3430_CORE_DPLL_ST_SHIFT,
+};
+
+static struct clk dpll3_ck = {
+	.name		= "dpll3_ck",
+	.parent		= &sys_ck,
+	.dpll_data	= &dpll3_dd,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &omap3_dpll_recalc,
+};
+
+static const struct clksel_rate div16_dpll_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
+	{ .div = 3, .val = 3, .flags = RATE_IN_343X },
+	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
+	{ .div = 5, .val = 5, .flags = RATE_IN_343X },
+	{ .div = 6, .val = 6, .flags = RATE_IN_343X },
+	{ .div = 7, .val = 7, .flags = RATE_IN_343X },
+	{ .div = 8, .val = 8, .flags = RATE_IN_343X },
+	{ .div = 9, .val = 9, .flags = RATE_IN_343X },
+	{ .div = 10, .val = 10, .flags = RATE_IN_343X },
+	{ .div = 11, .val = 11, .flags = RATE_IN_343X },
+	{ .div = 12, .val = 12, .flags = RATE_IN_343X },
+	{ .div = 13, .val = 13, .flags = RATE_IN_343X },
+	{ .div = 14, .val = 14, .flags = RATE_IN_343X },
+	{ .div = 15, .val = 15, .flags = RATE_IN_343X },
+	{ .div = 16, .val = 16, .flags = RATE_IN_343X },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate div2_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
+	{ .div = 0 },
+};
+
+static const struct clksel div2_dpll3m2_clksel[] = {
+	{ .parent = &dpll3_ck, .rates = div2_rates },
+	{ .parent = NULL }
+};
+
+/*
+ * REVISIT: Not sure what to do about clksel & these M2 divider clocks.
+ * Shouldn't they be changed in SRAM?
+ * This should probably remain a 'read-only' clksel clock.
+ */
+static struct clk dpll3_m2_ck = {
+	.name		= "dpll3_m2_ck",
+	.parent		= &dpll3_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP3430_CORE_DPLL_CLKOUT_DIV_MASK,
+	.clksel		= div2_dpll3m2_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk core_ck = {
+	.name		= "core_ck",
+	.parent		= &dpll3_m2_ck,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &followparent_recalc,
+};
+
+/*
+ * This virtual clock provides the CLKOUTX2 output from the DPLL if the
+ * DPLL isn't bypassed
+ */
+static struct clk dpll3_x2_ck = {
+	.name		= "dpll3_x2_ck",
+	.parent		= &core_ck,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &omap3_clkoutx2_recalc,
+};
+
+static struct clk dpll3_m2x2_ck = {
+	.name		= "dpll3_m2x2_ck",
+	.parent		= &dpll3_x2_ck,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &followparent_recalc,
+};
+
+/* The PWRDN bit is apparently only available on 3430ES2 and above */
+static struct clk dpll3_m3x2_ck = {
+	.name		= "dpll3_m3x2_ck",
+	.parent		= &dpll3_x2_ck,
+	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+	.enable_bit	= OMAP3430_PWRDN_EMU_CORE_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.recalc		= &followparent_recalc,
+};
+
+static const struct clksel div16_dpll3_clksel[] = {
+	{ .parent = &dpll3_x2_ck, .rates = div16_dpll_rates },
+	{ .parent = NULL }
+};
+
+static struct clk emul_core_alwon_ck = {
+	.name		= "emul_core_alwon_ck",
+	.parent		= &dpll3_x2_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP3430_DIV_DPLL3_MASK,
+	.clksel		= div16_dpll3_clksel,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+/* DPLL4 */
+/* Supplies 96MHz, 54Mhz TV DAC, DSS fclk, CAM sensor clock, emul trace clk */
+/* Type: DPLL */
+static const struct dpll_data dpll4_dd = {
+	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2),
+	.mult_mask	= OMAP3430_PERIPH_DPLL_MULT_MASK,
+	.div1_mask	= OMAP3430_PERIPH_DPLL_DIV_MASK,
+	.control_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+	.enable_mask	= OMAP3430_EN_PERIPH_DPLL_MASK,
+	.auto_recal_bit	= OMAP3430_EN_PERIPH_DPLL_DRIFTGUARD_SHIFT,
+	.recal_en_bit	= OMAP3430_PERIPH_DPLL_RECAL_EN_SHIFT,
+	.recal_st_bit	= OMAP3430_PERIPH_DPLL_ST_SHIFT,
+};
+
+static struct clk dpll4_ck = {
+	.name		= "dpll4_ck",
+	.parent		= &sys_ck,
+	.dpll_data	= &dpll4_dd,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &omap3_dpll_recalc,
+};
+
+/*
+ * This virtual clock provides the CLKOUTX2 output from the DPLL if the
+ * DPLL isn't bypassed
+ */
+static struct clk dpll4_x2_ck = {
+	.name		= "dpll4_x2_ck",
+	.parent		= &dpll4_ck,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &omap3_clkoutx2_recalc,
+};
+
+static const struct clksel div16_dpll4_clksel[] = {
+	{ .parent = &dpll4_x2_ck, .rates = div16_dpll_rates },
+	{ .parent = NULL }
+};
+
+/* The PWRDN bit is apparently only available on 3430ES2 and above */
+static struct clk dpll4_m2x2_ck = {
+	.name		= "dpll4_m2x2_ck",
+	.parent		= &dpll4_x2_ck,
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+	.enable_bit	= OMAP3430_PWRDN_96M_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430_CM_CLKSEL3),
+	.clksel_mask	= OMAP3430_DIV_96M_MASK,
+	.clksel		= div16_dpll4_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk omap_96m_alwon_fck = {
+	.name		= "omap_96m_alwon_fck",
+	.parent		= &dpll4_m2x2_ck,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk omap_96m_fck = {
+	.name		= "omap_96m_fck",
+	.parent		= &omap_96m_alwon_fck,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk cm_96m_fck = {
+	.name		= "cm_96m_fck",
+	.parent		= &dpll4_m2x2_ck,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &followparent_recalc,
+};
+
+/* The PWRDN bit is apparently only available on 3430ES2 and above */
+static struct clk dpll4_m3x2_ck = {
+	.name		= "dpll4_m3x2_ck",
+	.parent		= &dpll4_x2_ck,
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+	.enable_bit	= OMAP3430_PWRDN_TV_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3430_CLKSEL_TV_MASK,
+	.clksel		= div16_dpll4_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static const struct clksel_rate omap_54m_d4m3x2_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate omap_54m_alt_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel omap_54m_clksel[] = {
+	{ .parent = &dpll4_m3x2_ck, .rates = omap_54m_d4m3x2_rates },
+	{ .parent = &sys_altclk,     .rates = omap_54m_alt_rates },
+	{ .parent = NULL }
+};
+
+static struct clk omap_54m_fck = {
+	.name		= "omap_54m_fck",
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP3430_SOURCE_54M,
+	.clksel		= omap_54m_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static const struct clksel_rate omap_48m_96md2_rates[] = {
+	{ .div = 2, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate omap_48m_alt_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel omap_48m_clksel[] = {
+	{ .parent = &cm_96m_fck, .rates = omap_48m_96md2_rates },
+	{ .parent = &sys_altclk, .rates = omap_48m_alt_rates },
+	{ .parent = NULL }
+};
+
+static struct clk omap_48m_fck = {
+	.name		= "omap_48m_fck",
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP3430_SOURCE_48M,
+	.clksel		= omap_48m_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk omap_12m_fck = {
+	.name		= "omap_12m_fck",
+	.parent		= &omap_48m_fck,
+	.fixed_div	= 4,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &omap2_fixed_divisor_recalc,
+};
+
+/* The PWRDN bit is apparently only available on 3430ES2 and above */
+static struct clk dpll4_m4x2_ck = {
+	.name		= "dpll4_m4x2_ck",
+	.parent		= &dpll4_x2_ck,
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+	.enable_bit	= OMAP3430_PWRDN_CAM_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3430_CLKSEL_DSS1_MASK,
+	.clksel		= div16_dpll4_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+/* The PWRDN bit is apparently only available on 3430ES2 and above */
+static struct clk dpll4_m5x2_ck = {
+	.name		= "dpll4_m5x2_ck",
+	.parent		= &dpll4_x2_ck,
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+	.enable_bit	= OMAP3430_PWRDN_CAM_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3430_CLKSEL_CAM_MASK,
+	.clksel		= div16_dpll4_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+/* The PWRDN bit is apparently only available on 3430ES2 and above */
+static struct clk dpll4_m6x2_ck = {
+	.name		= "dpll4_m6x2_ck",
+	.parent		= &dpll4_x2_ck,
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+	.enable_bit	= OMAP3430_PWRDN_EMU_PERIPH_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP3430_DIV_DPLL4_MASK,
+	.clksel		= div16_dpll4_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk emul_per_alwon_ck = {
+	.name		= "emul_per_alwon_ck",
+	.parent		= &dpll4_m6x2_ck,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+
+/* CM EXTERNAL CLOCK OUTPUTS */
+
+static const struct clksel_rate clkout2_src_core_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate clkout2_src_sys_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate clkout2_src_96m_rates[] = {
+	{ .div = 1, .val = 2, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate clkout2_src_54m_rates[] = {
+	{ .div = 1, .val = 3, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel clkout2_src_clksel[] = {
+	{ .parent = &core_ck,		  .rates = clkout2_src_core_rates },
+	{ .parent = &sys_ck,		  .rates = clkout2_src_sys_rates },
+	{ .parent = &omap_96m_alwon_fck,  .rates = clkout2_src_96m_rates },
+	{ .parent = &omap_54m_fck,	  .rates = clkout2_src_54m_rates },
+	{ .parent = NULL }
+};
+
+static struct clk clkout2_src_ck = {
+	.name		= "clkout2_src_ck",
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP3430_CM_CLKOUT_CTRL,
+	.enable_bit	= OMAP3430_CLKOUT2_EN_SHIFT,
+	.clksel_reg	= OMAP3430_CM_CLKOUT_CTRL,
+	.clksel_mask	= OMAP3430_CLKOUT2SOURCE_MASK,
+	.clksel		= clkout2_src_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static const struct clksel_rate sys_clkout2_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 2, .val = 1, .flags = RATE_IN_343X },
+	{ .div = 4, .val = 2, .flags = RATE_IN_343X },
+	{ .div = 8, .val = 3, .flags = RATE_IN_343X },
+	{ .div = 16, .val = 4, .flags = RATE_IN_343X },
+	{ .div = 0 },
+};
+
+static const struct clksel sys_clkout2_clksel[] = {
+	{ .parent = &clkout2_src_ck, .rates = sys_clkout2_rates },
+	{ .parent = NULL },
+};
+
+static struct clk sys_clkout2 = {
+	.name		= "sys_clkout2",
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP3430_CM_CLKOUT_CTRL,
+	.clksel_mask	= OMAP3430_CLKOUT2_DIV_MASK,
+	.clksel		= sys_clkout2_clksel,
+	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+/* CM OUTPUT CLOCKS */
+
+static struct clk corex2_fck = {
+	.name		= "corex2_fck",
+	.parent		= &dpll3_m2x2_ck,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &followparent_recalc,
+};
+
+/* DPLL power domain clock controls */
+
+static const struct clksel div2_core_clksel[] = {
+	{ .parent = &core_ck, .rates = div2_rates },
+	{ .parent = NULL }
+};
+
+/* TRM s. 4.7.7.4 lists the input for these two clocks as CORE_CK,
+   but presuming that is an error, or at least an overgeneralization */
+/* REVISIT: Are these in DPLL power domain or CM power domain?	docs
+   may be inconsistent here? */
+static struct clk dpll1_fck = {
+	.name		= "dpll1_fck",
+	.parent		= &core_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL),
+	.clksel_mask	= OMAP3430_MPU_CLK_SRC_MASK,
+	.clksel		= div2_core_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk dpll2_fck = {
+	.name		= "dpll2_fck",
+	.parent		= &core_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSEL1_PLL),
+	.clksel_mask	= OMAP3430_IVA2_CLK_SRC_MASK,
+	.clksel		= div2_core_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+/* Common interface clocks */
+
+static struct clk l3_ick = {
+	.name		= "l3_ick",
+	.parent		= &core_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3430_CLKSEL_L3_MASK,
+	.clksel		= div2_core_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static const struct clksel div2_l3_clksel[] = {
+	{ .parent = &l3_ick, .rates = div2_rates },
+	{ .parent = NULL }
+};
+
+static struct clk l4_ick = {
+	.name		= "l4_ick",
+	.parent		= &l3_ick,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3430_CLKSEL_L4_MASK,
+	.clksel		= div2_l3_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &omap2_clksel_recalc,
+
+};
+
+static const struct clksel div2_l4_clksel[] = {
+	{ .parent = &l4_ick, .rates = div2_rates },
+	{ .parent = NULL }
+};
+
+static struct clk rm_ick = {
+	.name		= "rm_ick",
+	.parent		= &l4_ick,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3430_CLKSEL_RM_MASK,
+	.clksel		= div2_l4_clksel,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+/* GFX power domain */
+
+/* REVISIT: These clocks have disappeared in the 3430 ES2 TRM ?? */
+
+static const struct clksel gfx_l3_clksel[] = {
+	{ .parent = &l3_ick, .rates = gfx_l3_rates },
+	{ .parent = NULL }
+};
+
+static struct clk gfx_l3_fck = {
+	.name		= "gfx_l3_fck",
+	.parent		= &l3_ick,
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP_EN_GFX_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
+	.clksel		= gfx_l3_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk gfx_l3_ick = {
+	.name		= "gfx_l3_ick",
+	.parent		= &l3_ick,
+	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP_EN_GFX_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gfx_cg1_ck = {
+	.name		= "gfx_cg1_ck",
+	.parent		= &gfx_l3_fck, /* REVISIT: correct? */
+	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_2D_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gfx_cg2_ck = {
+	.name		= "gfx_cg2_ck",
+	.parent		= &gfx_l3_fck, /* REVISIT: correct? */
+	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_3D_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+/* CORE power domain */
+
+static struct clk d2d_26m_fck = {
+	.name		= "d2d_26m_fck",
+	.parent		= &sys_ck,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_D2D_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static const struct clksel omap343x_gpt_clksel[] = {
+	{ .parent = &omap_32k_fck, .rates = gpt_32k_rates },
+	{ .parent = &sys_ck,	   .rates = gpt_sys_rates },
+	{ .parent = NULL}
+};
+
+static struct clk gpt10_fck = {
+	.name		= "gpt10_fck",
+	.parent		= &sys_ck,
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_GPT10_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3430_CLKSEL_GPT10_MASK,
+	.clksel		= omap343x_gpt_clksel,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk gpt11_fck = {
+	.name		= "gpt11_fck",
+	.parent		= &sys_ck,
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_GPT11_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3430_CLKSEL_GPT11_MASK,
+	.clksel		= omap343x_gpt_clksel,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+/* CORE 96M FCLK-derived clocks */
+
+static struct clk core_96m_fck = {
+	.name		= "core_96m_fck",
+	.parent		= &omap_96m_fck,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mmc2_fck = {
+	.name		= "mmc2_fck",
+	.parent		= &core_96m_fck,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_MMC2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mspro_fck = {
+	.name		= "mspro_fck",
+	.parent		= &core_96m_fck,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_MSPRO_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mmc1_fck = {
+	.name		= "mmc1_fck",
+	.parent		= &core_96m_fck,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_MMC1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk i2c3_fck = {
+	.name		= "i2c3_fck",
+	.parent		= &core_96m_fck,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_I2C3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk i2c2_fck = {
+	.name		= "i2c2_fck",
+	.parent		= &core_96m_fck,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_I2C2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk i2c1_fck = {
+	.name		= "i2c1_fck",
+	.parent		= &core_96m_fck,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_I2C1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+/*
+ * MCBSP 1 & 5 get their 96MHz clock from core_96m_fck;
+ * MCBSP 2, 3, 4 get their 96MHz clock from per_96m_fck.
+ */
+static const struct clksel_rate common_mcbsp_96m_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate common_mcbsp_mcbsp_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel mcbsp_15_clksel[] = {
+	{ .parent = &core_96m_fck, .rates = common_mcbsp_96m_rates },
+	{ .parent = &mcbsp_clks,   .rates = common_mcbsp_mcbsp_rates },
+	{ .parent = NULL }
+};
+
+static struct clk mcbsp5_fck = {
+	.name		= "mcbsp5_fck",
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_MCBSP5_SHIFT,
+	.clksel_reg	= (void __iomem *)IO_ADDRESS(OMAP34XX_CONTROL_DEVCONF1),
+	.clksel_mask	= OMAP3430_MCBSP5_CLKS_MASK,
+	.clksel		= mcbsp_15_clksel,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk mcbsp1_fck = {
+	.name		= "mcbsp1_fck",
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_MCBSP1_SHIFT,
+	.clksel_reg	= (void __iomem *)IO_ADDRESS(OMAP34XX_CONTROL_DEVCONF0),
+	.clksel_mask	= OMAP3430_MCBSP1_CLKS_MASK,
+	.clksel		= mcbsp_15_clksel,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+/* CORE_48M_FCK-derived clocks */
+
+static struct clk core_48m_fck = {
+	.name		= "core_48m_fck",
+	.parent		= &omap_48m_fck,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mcspi4_fck = {
+	.name		= "mcspi4_fck",
+	.parent		= &core_48m_fck,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_MCSPI4_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mcspi3_fck = {
+	.name		= "mcspi3_fck",
+	.parent		= &core_48m_fck,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_MCSPI3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mcspi2_fck = {
+	.name		= "mcspi2_fck",
+	.parent		= &core_48m_fck,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_MCSPI2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mcspi1_fck = {
+	.name		= "mcspi1_fck",
+	.parent		= &core_48m_fck,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_MCSPI1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk uart2_fck = {
+	.name		= "uart2_fck",
+	.parent		= &core_48m_fck,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_UART2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk uart1_fck = {
+	.name		= "uart1_fck",
+	.parent		= &core_48m_fck,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_UART1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk fshostusb_fck = {
+	.name		= "fshostusb_fck",
+	.parent		= &core_48m_fck,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_FSHOSTUSB_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+/* CORE_12M_FCK based clocks */
+
+static struct clk core_12m_fck = {
+	.name		= "core_12m_fck",
+	.parent		= &omap_12m_fck,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk hdq_fck = {
+	.name		= "hdq_fck",
+	.parent		= &core_12m_fck,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_HDQ_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+/* DPLL3-derived clock */
+
+static const struct clksel_rate ssi_ssr_corex2_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
+	{ .div = 3, .val = 3, .flags = RATE_IN_343X },
+	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
+	{ .div = 6, .val = 6, .flags = RATE_IN_343X },
+	{ .div = 8, .val = 8, .flags = RATE_IN_343X },
+	{ .div = 0 }
+};
+
+static const struct clksel ssi_ssr_clksel[] = {
+	{ .parent = &corex2_fck, .rates = ssi_ssr_corex2_rates },
+	{ .parent = NULL }
+};
+
+static struct clk ssi_ssr_fck = {
+	.name		= "ssi_ssr_fck",
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_SSI_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3430_CLKSEL_SSI_MASK,
+	.clksel		= ssi_ssr_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk ssi_sst_fck = {
+	.name		= "ssi_sst_fck",
+	.parent		= &ssi_ssr_fck,
+	.fixed_div	= 2,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &omap2_fixed_divisor_recalc,
+};
+
+
+
+/* CORE_L3_ICK based clocks */
+
+static struct clk core_l3_ick = {
+	.name		= "core_l3_ick",
+	.parent		= &l3_ick,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk hsotgusb_ick = {
+	.name		= "hsotgusb_fck",
+	.parent		= &core_l3_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_HSOTGUSB_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk sdrc_ick = {
+	.name		= "sdrc_ick",
+	.parent		= &core_l3_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_SDRC_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpmc_fck = {
+	.name		= "gpmc_fck",
+	.parent		= &core_l3_ick,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+/* SECURITY_L3_ICK based clocks */
+
+static struct clk security_l3_ick = {
+	.name		= "security_l3_ick",
+	.parent		= &l3_ick,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk pka_ick = {
+	.name		= "pka_ick",
+	.parent		= &security_l3_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP3430_EN_PKA_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+/* CORE_L4_ICK based clocks */
+
+static struct clk core_l4_ick = {
+	.name		= "core_l4_ick",
+	.parent		= &l4_ick,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk aes2_ick = {
+	.name		= "aes2_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_AES2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk sha12_ick = {
+	.name		= "sha12_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_SHA12_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk des2_ick = {
+	.name		= "des2_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_DES2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mmc2_ick = {
+	.name		= "mmc2_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_MMC2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mmc1_ick = {
+	.name		= "mmc1_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_MMC1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mspro_ick = {
+	.name		= "mspro_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_MSPRO_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk hdq_ick = {
+	.name		= "hdq_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_HDQ_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mcspi4_ick = {
+	.name		= "mcspi4_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_MCSPI4_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mcspi3_ick = {
+	.name		= "mcspi3_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_MCSPI3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mcspi2_ick = {
+	.name		= "mcspi2_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_MCSPI2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mcspi1_ick = {
+	.name		= "mcspi1_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_MCSPI1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk i2c3_ick = {
+	.name		= "i2c3_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_I2C3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk i2c2_ick = {
+	.name		= "i2c2_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_I2C2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk i2c1_ick = {
+	.name		= "i2c1_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_I2C1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk uart2_ick = {
+	.name		= "uart2_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_UART2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk uart1_ick = {
+	.name		= "uart1_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_UART1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpt11_ick = {
+	.name		= "gpt11_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_GPT11_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpt10_ick = {
+	.name		= "gpt10_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_GPT10_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mcbsp5_ick = {
+	.name		= "mcbsp5_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_MCBSP5_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mcbsp1_ick = {
+	.name		= "mcbsp1_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_MCBSP1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk fac_ick = {
+	.name		= "fac_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_FAC_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mailboxes_ick = {
+	.name		= "mailboxes_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_MAILBOXES_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk omapctrl_ick = {
+	.name		= "omapctrl_ick",
+	.parent		= &core_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_OMAPCTRL_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+/* SSI_L4_ICK based clocks */
+
+static struct clk ssi_l4_ick = {
+	.name		= "ssi_l4_ick",
+	.parent		= &l4_ick,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk ssi_ick = {
+	.name		= "ssi_ick",
+	.parent		= &ssi_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_SSI_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+/* REVISIT: Technically the TRM claims that this is CORE_CLK based,
+ * but l4_ick makes more sense to me */
+
+static const struct clksel_rate usb_l4_l4_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
+	{ .div = 0 }
+};
+
+static const struct clksel usb_l4_clksel[] = {
+	{ .parent = &l4_ick, .rates = usb_l4_l4_rates },
+	{ .parent = NULL },
+};
+
+static struct clk usb_l4_ick = {
+	.name		= "usb_l4_ick",
+	.parent		= &l4_ick,
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP3430_EN_FSHOSTUSB_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3430_CLKSEL_FSHOSTUSB_MASK,
+	.clksel		= usb_l4_clksel,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+/* XXX MDM_INTC_ICK, SAD2D_ICK ?? */
+
+/* SECURITY_L4_ICK2 based clocks */
+
+static struct clk security_l4_ick2 = {
+	.name		= "security_l4_ick2",
+	.parent		= &l4_ick,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk aes1_ick = {
+	.name		= "aes1_ick",
+	.parent		= &security_l4_ick2,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP3430_EN_AES1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk rng_ick = {
+	.name		= "rng_ick",
+	.parent		= &security_l4_ick2,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP3430_EN_RNG_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk sha11_ick = {
+	.name		= "sha11_ick",
+	.parent		= &security_l4_ick2,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP3430_EN_SHA11_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk des1_ick = {
+	.name		= "des1_ick",
+	.parent		= &security_l4_ick2,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP3430_EN_DES1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+/* DSS */
+
+static struct clk dss1_alwon_fck = {
+	.name		= "dss1_alwon_fck",
+	.parent		= &dpll4_m4x2_ck,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_DSS1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk dss_tv_fck = {
+	.name		= "dss_tv_fck",
+	.parent		= &omap_54m_fck,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_TV_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk dss_96m_fck = {
+	.name		= "dss_96m_fck",
+	.parent		= &omap_96m_fck,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_TV_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk dss2_alwon_fck = {
+	.name		= "dss2_alwon_fck",
+	.parent		= &sys_ck,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_DSS2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk dss_l3_ick = {
+	.name		= "dss_l3_ick",
+	.parent		= &l3_ick,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk dss_l4_ick = {
+	.name		= "dss_l4_ick",
+	.parent		= &l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+/* CAM */
+
+static struct clk cam_mclk = {
+	.name		= "cam_mclk",
+	.parent		= &dpll4_m5x2_ck,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_CAM_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk cam_l3_ick = {
+	.name		= "cam_l3_ick",
+	.parent		= &l3_ick,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_CAM_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk cam_l4_ick = {
+	.name		= "cam_l4_ick",
+	.parent		= &l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_CAM_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+/* WKUP */
+
+static struct clk gpt1_fck = {
+	.name		= "gpt1_fck",
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_GPT1_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3430_CLKSEL_GPT1_MASK,
+	.clksel		= omap343x_gpt_clksel,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk wkup_32k_fck = {
+	.name		= "wkup_32k_fck",
+	.parent		= &omap_32k_fck,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpio1_fck = {
+	.name		= "gpio1_fck",
+	.parent		= &wkup_32k_fck,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_GPIO1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk wdt2_fck = {
+	.name		= "wdt2_fck",
+	.parent		= &wkup_32k_fck,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_WDT2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk wkup_l4_ick = {
+	.name		= "wkup_l4_ick",
+	.parent		= &sys_ck,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk wdt2_ick = {
+	.name		= "wdt2_ick",
+	.parent		= &wkup_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_WDT2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk wdt1_ick = {
+	.name		= "wdt1_ick",
+	.parent		= &wkup_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_WDT1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpio1_ick = {
+	.name		= "gpio1_ick",
+	.parent		= &wkup_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_GPIO1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk omap_32ksync_ick = {
+	.name		= "omap_32ksync_ick",
+	.parent		= &wkup_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_32KSYNC_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpt12_ick = {
+	.name		= "gpt12_ick",
+	.parent		= &wkup_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_GPT12_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpt1_ick = {
+	.name		= "gpt1_ick",
+	.parent		= &wkup_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_GPT1_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+
+
+/* PER clock domain */
+
+static struct clk per_96m_fck = {
+	.name		= "per_96m_fck",
+	.parent		= &omap_96m_alwon_fck,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk per_48m_fck = {
+	.name		= "per_48m_fck",
+	.parent		= &omap_48m_fck,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk uart3_fck = {
+	.name		= "uart3_fck",
+	.parent		= &per_48m_fck,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_UART3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpt2_fck = {
+	.name		= "gpt2_fck",
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_GPT2_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3430_CLKSEL_GPT2_MASK,
+	.clksel		= omap343x_gpt_clksel,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk gpt3_fck = {
+	.name		= "gpt3_fck",
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_GPT3_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3430_CLKSEL_GPT3_MASK,
+	.clksel		= omap343x_gpt_clksel,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk gpt4_fck = {
+	.name		= "gpt4_fck",
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_GPT4_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3430_CLKSEL_GPT4_MASK,
+	.clksel		= omap343x_gpt_clksel,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk gpt5_fck = {
+	.name		= "gpt5_fck",
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_GPT5_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3430_CLKSEL_GPT5_MASK,
+	.clksel		= omap343x_gpt_clksel,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk gpt6_fck = {
+	.name		= "gpt6_fck",
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_GPT6_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3430_CLKSEL_GPT6_MASK,
+	.clksel		= omap343x_gpt_clksel,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk gpt7_fck = {
+	.name		= "gpt7_fck",
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_GPT7_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3430_CLKSEL_GPT7_MASK,
+	.clksel		= omap343x_gpt_clksel,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk gpt8_fck = {
+	.name		= "gpt8_fck",
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_GPT8_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3430_CLKSEL_GPT8_MASK,
+	.clksel		= omap343x_gpt_clksel,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk gpt9_fck = {
+	.name		= "gpt9_fck",
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_GPT9_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3430_CLKSEL_GPT9_MASK,
+	.clksel		= omap343x_gpt_clksel,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk per_32k_alwon_fck = {
+	.name		= "per_32k_alwon_fck",
+	.parent		= &omap_32k_fck,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpio6_fck = {
+	.name		= "gpio6_fck",
+	.parent		= &per_32k_alwon_fck,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_GPT6_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpio5_fck = {
+	.name		= "gpio5_fck",
+	.parent		= &per_32k_alwon_fck,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_GPT5_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpio4_fck = {
+	.name		= "gpio4_fck",
+	.parent		= &per_32k_alwon_fck,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_GPT4_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpio3_fck = {
+	.name		= "gpio3_fck",
+	.parent		= &per_32k_alwon_fck,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_GPT3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpio2_fck = {
+	.name		= "gpio2_fck",
+	.parent		= &per_32k_alwon_fck,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_GPT2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk wdt3_fck = {
+	.name		= "wdt3_fck",
+	.parent		= &per_32k_alwon_fck,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP3430_EN_WDT3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk per_l4_ick = {
+	.name		= "per_l4_ick",
+	.parent		= &l4_ick,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpio6_ick = {
+	.name		= "gpio6_ick",
+	.parent		= &per_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_GPIO6_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpio5_ick = {
+	.name		= "gpio5_ick",
+	.parent		= &per_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_GPIO5_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpio4_ick = {
+	.name		= "gpio4_ick",
+	.parent		= &per_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_GPIO4_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpio3_ick = {
+	.name		= "gpio3_ick",
+	.parent		= &per_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_GPIO3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpio2_ick = {
+	.name		= "gpio2_ick",
+	.parent		= &per_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_GPIO2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk wdt3_ick = {
+	.name		= "wdt3_ick",
+	.parent		= &per_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_WDT3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk uart3_ick = {
+	.name		= "uart3_ick",
+	.parent		= &per_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_UART3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpt9_ick = {
+	.name		= "gpt9_ick",
+	.parent		= &per_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_GPT9_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpt8_ick = {
+	.name		= "gpt8_ick",
+	.parent		= &per_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_GPT8_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpt7_ick = {
+	.name		= "gpt7_ick",
+	.parent		= &per_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_GPT7_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpt6_ick = {
+	.name		= "gpt6_ick",
+	.parent		= &per_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_GPT6_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpt5_ick = {
+	.name		= "gpt5_ick",
+	.parent		= &per_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_GPT5_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpt4_ick = {
+	.name		= "gpt4_ick",
+	.parent		= &per_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_GPT4_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpt3_ick = {
+	.name		= "gpt3_ick",
+	.parent		= &per_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_GPT3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpt2_ick = {
+	.name		= "gpt2_ick",
+	.parent		= &per_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_GPT2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mcbsp2_ick = {
+	.name		= "mcbsp2_ick",
+	.parent		= &per_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_MCBSP2_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mcbsp3_ick = {
+	.name		= "mcbsp3_ick",
+	.parent		= &per_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_MCBSP3_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk mcbsp4_ick = {
+	.name		= "mcbsp4_ick",
+	.parent		= &per_l4_ick,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP3430_EN_MCBSP4_SHIFT,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static const struct clksel mcbsp_234_clksel[] = {
+	{ .parent = &per_96m_fck, .rates = common_mcbsp_96m_rates },
+	{ .parent = &mcbsp_clks,   .rates = common_mcbsp_mcbsp_rates },
+	{ .parent = NULL }
+};
+
+static struct clk mcbsp2_fck = {
+	.name		= "mcbsp2_fck",
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_MCBSP2_SHIFT,
+	.clksel_reg	= (void __iomem *)IO_ADDRESS(OMAP34XX_CONTROL_DEVCONF0),
+	.clksel_mask	= OMAP3430_MCBSP2_CLKS_MASK,
+	.clksel		= mcbsp_234_clksel,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk mcbsp3_fck = {
+	.name		= "mcbsp3_fck",
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_MCBSP3_SHIFT,
+	.clksel_reg	= (void __iomem *)IO_ADDRESS(OMAP34XX_CONTROL_DEVCONF1),
+	.clksel_mask	= OMAP3430_MCBSP3_CLKS_MASK,
+	.clksel		= mcbsp_234_clksel,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk mcbsp4_fck = {
+	.name		= "mcbsp4_fck",
+	.init		= &omap2_init_clksel_parent,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP3430_EN_MCBSP4_SHIFT,
+	.clksel_reg	= (void __iomem *)IO_ADDRESS(OMAP34XX_CONTROL_DEVCONF1),
+	.clksel_mask	= OMAP3430_MCBSP4_CLKS_MASK,
+	.clksel		= mcbsp_234_clksel,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+/* SR clocks */
+
+/* REVISIT: dependent on en_sr1 && en_sr2 - use custom enable/disable? */
+static struct clk sr_alwon_fck = {
+	.name		= "sr_alwon_fck",
+	.parent		= &sys_ck,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk sr_l4_ick = {
+	.name		= "sr_l4_ick",
+	.parent		= &l4_ick,
+	.flags		= CLOCK_IN_OMAP343X,
+	.recalc		= &followparent_recalc,
+};
+
+/* SECURE_32K_FCK clocks */
+
+static struct clk gpt12_fck = {
+	.name		= "gpt12_fck",
+	.parent		= &secure_32k_fck,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk wdt1_fck = {
+	.name		= "wdt1_fck",
+	.parent		= &secure_32k_fck,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
+	.recalc		= &followparent_recalc,
+};
+
+
+static struct clk *onchip_34xx_clks[] __initdata = {
+	&omap_32k_fck,
+	&virt_12m_ck,
+	&virt_13m_ck,
+	&virt_16_8m_ck,
+	&virt_19_2m_ck,
+	&virt_26m_ck,
+	&virt_38_4m_ck,
+	&osc_sys_ck,
+	&sys_ck,
+	&sys_altclk,
+	&sys_clkout1,
+	&dpll1_ck,
+	&dpll2_ck,
+	&dpll3_ck,
+	&core_ck,
+	&dpll3_x2_ck,
+	&dpll3_m2_ck,
+	&dpll3_m2x2_ck,
+	&dpll3_m3x2_ck,
+	&emul_core_alwon_ck,
+	&dpll4_ck,
+	&dpll4_x2_ck,
+	&omap_96m_alwon_fck,
+	&omap_96m_fck,
+	&cm_96m_fck,
+	&omap_54m_fck,
+	&omap_48m_fck,
+	&omap_12m_fck,
+	&dpll4_m2x2_ck,
+	&dpll4_m3x2_ck,
+	&dpll4_m4x2_ck,
+	&dpll4_m5x2_ck,
+	&dpll4_m6x2_ck,
+	&emul_per_alwon_ck,
+	&clkout2_src_ck,
+	&sys_clkout2,
+	&corex2_fck,
+	&dpll1_fck,
+	&dpll2_fck,
+	&l3_ick,
+	&l4_ick,
+	&rm_ick,
+	&gfx_l3_fck,
+	&gfx_l3_ick,
+	&gfx_cg1_ck,
+	&gfx_cg2_ck,
+	&d2d_26m_fck,
+	&gpt10_fck,
+	&gpt11_fck,
+	&core_96m_fck,
+	&mmc2_fck,
+	&mspro_fck,
+	&mmc1_fck,
+	&i2c3_fck,
+	&i2c2_fck,
+	&i2c1_fck,
+	&mcbsp5_fck,
+	&mcbsp1_fck,
+	&core_48m_fck,
+	&mcspi4_fck,
+	&mcspi3_fck,
+	&mcspi2_fck,
+	&mcspi1_fck,
+	&uart2_fck,
+	&uart1_fck,
+	&fshostusb_fck,
+	&core_12m_fck,
+	&hdq_fck,
+	&ssi_ssr_fck,
+	&ssi_sst_fck,
+	&core_l3_ick,
+	&hsotgusb_ick,
+	&sdrc_ick,
+	&gpmc_fck,
+	&security_l3_ick,
+	&pka_ick,
+	&core_l4_ick,
+	&aes2_ick,
+	&sha12_ick,
+	&des2_ick,
+	&mmc2_ick,
+	&mmc1_ick,
+	&mspro_ick,
+	&hdq_ick,
+	&mcspi4_ick,
+	&mcspi3_ick,
+	&mcspi2_ick,
+	&mcspi1_ick,
+	&i2c3_ick,
+	&i2c2_ick,
+	&i2c1_ick,
+	&uart2_ick,
+	&uart1_ick,
+	&gpt11_ick,
+	&gpt10_ick,
+	&mcbsp5_ick,
+	&mcbsp1_ick,
+	&fac_ick,
+	&mailboxes_ick,
+	&omapctrl_ick,
+	&ssi_l4_ick,
+	&ssi_ick,
+	&usb_l4_ick,
+	&security_l4_ick2,
+	&aes1_ick,
+	&rng_ick,
+	&sha11_ick,
+	&des1_ick,
+	&dss1_alwon_fck,
+	&dss_tv_fck,
+	&dss_96m_fck,
+	&dss2_alwon_fck,
+	&dss_l3_ick,
+	&dss_l4_ick,
+	&cam_mclk,
+	&cam_l3_ick,
+	&cam_l4_ick,
+	&gpt1_fck,
+	&wkup_32k_fck,
+	&gpio1_fck,
+	&wdt2_fck,
+	&wkup_l4_ick,
+	&wdt2_ick,
+	&wdt1_ick,
+	&gpio1_ick,
+	&omap_32ksync_ick,
+	&gpt12_ick,
+	&gpt1_ick,
+	&per_96m_fck,
+	&per_48m_fck,
+	&uart3_fck,
+	&gpt2_fck,
+	&gpt3_fck,
+	&gpt4_fck,
+	&gpt5_fck,
+	&gpt6_fck,
+	&gpt7_fck,
+	&gpt8_fck,
+	&gpt9_fck,
+	&per_32k_alwon_fck,
+	&gpio6_fck,
+	&gpio5_fck,
+	&gpio4_fck,
+	&gpio3_fck,
+	&gpio2_fck,
+	&wdt3_fck,
+	&per_l4_ick,
+	&gpio6_ick,
+	&gpio5_ick,
+	&gpio4_ick,
+	&gpio3_ick,
+	&gpio2_ick,
+	&wdt3_ick,
+	&uart3_ick,
+	&gpt9_ick,
+	&gpt8_ick,
+	&gpt7_ick,
+	&gpt6_ick,
+	&gpt5_ick,
+	&gpt4_ick,
+	&gpt3_ick,
+	&gpt2_ick,
+	&mcbsp2_ick,
+	&mcbsp3_ick,
+	&mcbsp4_ick,
+	&mcbsp2_fck,
+	&mcbsp3_fck,
+	&mcbsp4_fck,
+	&sr_alwon_fck,
+	&sr_l4_ick,
+	&secure_32k_fck,
+	&gpt12_fck,
+	&wdt1_fck,
+};
+
+#endif
Index: linux-omap/arch/arm/mach-omap2/cm.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/cm.h	2007-09-26 01:47:44.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/cm.h	2007-09-26 01:47:45.000000000 -0600
@@ -30,6 +30,8 @@
 #define OMAP3430_CM_SYSCONFIG		OMAP_CM_REGADDR(OCP_MOD, 0x0010)
 #define OMAP3430_CM_POLCTRL		OMAP_CM_REGADDR(OCP_MOD, 0x009c)
 
+#define OMAP3430_CM_CLKOUT_CTRL		OMAP_CM_REGADDR(OMAP3430_CCR_MOD, 0x0070)
+
 
 /* Clock management global register get/set */
 
Index: linux-omap/arch/arm/mach-omap2/prm.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/prm.h	2007-09-26 01:47:44.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/prm.h	2007-09-26 01:47:45.000000000 -0600
@@ -87,6 +87,8 @@
 #define OMAP3430_PRM_VP2_VOLTAGE	OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00e0)
 #define OMAP3430_PRM_VP2_STATUS		OMAP_PRM_REGADDR(OMAP3430_GR_MOD, 0x00e4)
 
+#define OMAP3430_PRM_CLKSEL		OMAP_PRM_REGADDR(OMAP3430_CCR_MOD, 0x0040)
+#define OMAP3430_PRM_CLKOUT_CTRL	OMAP_PRM_REGADDR(OMAP3430_CCR_MOD, 0x0070)
 
 /* Power/reset management global register get/set */
 
Index: linux-omap/arch/arm/mach-omap2/clock34xx.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap/arch/arm/mach-omap2/clock34xx.c	2007-09-26 01:47:45.000000000 -0600
@@ -0,0 +1,222 @@
+/*
+ * OMAP3-specific clock framework functions
+ *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ * Copyright (C) 2007 Nokia Corporation
+ *
+ * Written by Paul Walmsley
+ *
+ * Parts of this code are based on code written by
+ * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#undef DEBUG
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+
+#include <linux/io.h>
+
+#include <asm/arch/clock.h>
+#include <asm/arch/sram.h>
+#include <asm/div64.h>
+
+#include "memory.h"
+#include "clock.h"
+#include "clock34xx.h"
+#include "prm.h"
+#include "prm_regbits_34xx.h"
+#include "cm.h"
+#include "cm_regbits_34xx.h"
+
+/* CM_CLKEN_PLL*.EN* bit values */
+#define DPLL_LOCKED		0x7
+
+/**
+ * omap3_dpll_recalc - recalculate DPLL rate
+ * @clk: DPLL struct clk
+ *
+ * Recalculate and propagate the DPLL rate.
+ */
+static void omap3_dpll_recalc(struct clk *clk)
+{
+	clk->rate = omap2_get_dpll_rate(clk);
+
+	propagate_rate(clk);
+}
+
+/**
+ * omap3_clkoutx2_recalc - recalculate DPLL X2 output virtual clock rate
+ * @clk: DPLL output struct clk
+ *
+ * Using parent clock DPLL data, look up DPLL state.  If locked, set our
+ * rate to the dpll_clk * 2; otherwise, just use dpll_clk.
+ */
+static void omap3_clkoutx2_recalc(struct clk *clk)
+{
+	const struct dpll_data *dd;
+	u32 v;
+	struct clk *pclk;
+
+	/* Walk up the parents of clk, looking for a DPLL */
+	pclk = clk->parent;
+	while (pclk && !pclk->dpll_data)
+		pclk = pclk->parent;
+
+	/* clk does not have a DPLL as a parent? */
+	WARN_ON(!pclk);
+
+	dd = pclk->dpll_data;
+
+	WARN_ON(!dd->control_reg || !dd->enable_mask);
+
+	v = cm_read_reg(dd->control_reg) & dd->enable_mask;
+	if (v != DPLL_LOCKED)
+		clk->rate = clk->parent->rate;
+	else
+		clk->rate = clk->parent->rate * 2;
+
+	if (clk->flags & RATE_PROPAGATES)
+		propagate_rate(clk);
+}
+
+/*
+ * As it is structured now, this will prevent an OMAP2/3 multiboot
+ * kernel from compiling.  This will need further attention.
+ */
+#if defined(CONFIG_ARCH_OMAP3)
+
+static struct clk_functions omap2_clk_functions = {
+	.clk_enable		= omap2_clk_enable,
+	.clk_disable		= omap2_clk_disable,
+	.clk_round_rate		= omap2_clk_round_rate,
+	.clk_set_rate		= omap2_clk_set_rate,
+	.clk_set_parent		= omap2_clk_set_parent,
+	.clk_disable_unused	= omap2_clk_disable_unused,
+};
+
+/*
+ * Set clocks for bypass mode for reboot to work.
+ */
+void omap2_clk_prepare_for_reboot(void)
+{
+	/* REVISIT: Not ready for 343x */
+#if 0
+	u32 rate;
+
+	if (vclk == NULL || sclk == NULL)
+		return;
+
+	rate = clk_get_rate(sclk);
+	clk_set_rate(vclk, rate);
+#endif
+}
+
+/* REVISIT: Move this init stuff out into clock.c */
+
+/*
+ * Switch the MPU rate if specified on cmdline.
+ * We cannot do this early until cmdline is parsed.
+ */
+static int __init omap2_clk_arch_init(void)
+{
+	if (!mpurate)
+		return -EINVAL;
+
+	/* REVISIT: not yet ready for 343x */
+#if 0
+	if (omap2_select_table_rate(&virt_prcm_set, mpurate))
+		printk(KERN_ERR "Could not find matching MPU rate\n");
+#endif
+
+	recalculate_root_clocks();
+
+	printk(KERN_INFO "Switched to new clocking rate (Crystal/DPLL3/MPU): "
+	       "%ld.%01ld/%ld/%ld MHz\n",
+	       (osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 100000) % 10,
+	       (core_ck.rate / 1000000), (dpll1_fck.rate / 1000000)) ;
+
+	return 0;
+}
+arch_initcall(omap2_clk_arch_init);
+
+int __init omap2_clk_init(void)
+{
+	/* struct prcm_config *prcm; */
+	struct clk **clkp;
+	/* u32 clkrate; */
+	u32 cpu_clkflg;
+
+	/* REVISIT: Ultimately this will be used for multiboot */
+#if 0
+	if (cpu_is_omap242x()) {
+		cpu_mask = RATE_IN_242X;
+		cpu_clkflg = CLOCK_IN_OMAP242X;
+		clkp = onchip_24xx_clks;
+	} else if (cpu_is_omap2430()) {
+		cpu_mask = RATE_IN_243X;
+		cpu_clkflg = CLOCK_IN_OMAP243X;
+		clkp = onchip_24xx_clks;
+	}
+#endif
+	if (cpu_is_omap34xx()) {
+		cpu_mask = RATE_IN_343X;
+		cpu_clkflg = CLOCK_IN_OMAP343X;
+		clkp = onchip_34xx_clks;
+	}
+
+	clk_init(&omap2_clk_functions);
+
+	for (clkp = onchip_34xx_clks;
+	     clkp < onchip_34xx_clks + ARRAY_SIZE(onchip_34xx_clks);
+	     clkp++) {
+		if ((*clkp)->flags & cpu_clkflg)
+			clk_register(*clkp);
+	}
+
+	/* REVISIT: Not yet ready for OMAP3 */
+#if 0
+	/* Check the MPU rate set by bootloader */
+	clkrate = omap2_get_dpll_rate_24xx(&dpll_ck);
+	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
+		if (!(prcm->flags & cpu_mask))
+			continue;
+		if (prcm->xtal_speed != sys_ck.rate)
+			continue;
+		if (prcm->dpll_speed <= clkrate)
+			 break;
+	}
+	curr_prcm_set = prcm;
+#endif
+
+	recalculate_root_clocks();
+
+	printk(KERN_INFO "Clocking rate (Crystal/DPLL/MPU): "
+	       "%ld.%01ld/%ld/%ld MHz\n",
+	       (osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 100000) % 10,
+	       (core_ck.rate / 1000000), (dpll1_fck.rate / 1000000)) ;
+
+	/*
+	 * Only enable those clocks we will need, let the drivers
+	 * enable other clocks as necessary
+	 */
+	clk_enable_init_clocks();
+
+	/* Avoid sleeping during omap2_clk_prepare_for_reboot() */
+	/* REVISIT: not yet ready for 343x */
+#if 0
+	vclk = clk_get(NULL, "virt_prcm_set");
+	sclk = clk_get(NULL, "sys_ck");
+#endif
+	return 0;
+}
+
+#endif
Index: linux-omap/arch/arm/mach-omap2/Makefile
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/Makefile	2007-09-26 01:47:44.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/Makefile	2007-09-26 01:47:45.000000000 -0600
@@ -13,6 +13,7 @@
 
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
 
 # DSP
 obj-$(CONFIG_OMAP_MMU_FWK)	+= mmu_mach.o
Index: linux-omap/include/asm-arm/arch-omap/clock.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/clock.h	2007-09-26 01:47:44.000000000 -0600
+++ linux-omap/include/asm-arm/arch-omap/clock.h	2007-09-26 01:48:00.000000000 -0600
@@ -33,6 +33,15 @@
 	void __iomem		*mult_div1_reg;
 	u32			mult_mask;
 	u32			div1_mask;
+	void __iomem		*div2_reg;
+	u32			div2_mask;
+#  if defined(CONFIG_ARCH_OMAP3)
+	void __iomem		*control_reg;
+	u32			enable_mask;
+	u8			auto_recal_bit;
+	u8			recal_en_bit;
+	u8			recal_st_bit;
+#  endif
 };
 
 #endif
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c	2007-09-26 01:47:44.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.c	2007-09-26 01:47:45.000000000 -0600
@@ -74,8 +74,7 @@
 	if (!clk->clksel)
 		return;
 
-	/* XXX Should be __raw_readl for non-CM 3430 clocks ? */
-	r = cm_read_reg(clk->clksel_reg) & clk->clksel_mask;
+	r = __raw_readl(clk->clksel_reg) & clk->clksel_mask;
 	r >>= mask_to_shift(clk->clksel_mask);
 
 	for (clks = clk->clksel; clks->parent && !found; clks++) {
@@ -122,6 +121,14 @@
 	dpll_clk = (long long)clk->parent->rate * dpll_mult;
 	do_div(dpll_clk, dpll_div + 1);
 
+	/* 34XX only */
+	if (dd->div2_reg) {
+		dpll = cm_read_reg(dd->div2_reg);
+		dpll_div = dpll & dd->div2_mask;
+		dpll_div >>= mask_to_shift(dd->div2_mask);
+		do_div(dpll_clk, dpll_div + 1);
+	}
+
 	return dpll_clk;
 }
 
@@ -142,29 +149,39 @@
 /**
  * omap2_wait_clock_ready - wait for clock to enable
  * @reg: physical address of clock IDLEST register
- * @cval: value to test against to determine if the clock is active
+ * @mask: value to mask against to determine if the clock is active
  * @name: name of the clock (for printk)
  *
  * Returns 1 if the clock enabled in time, or 0 if it failed to enable
  * in roughly MAX_CLOCK_ENABLE_WAIT microseconds.
  */
-int omap2_wait_clock_ready(void __iomem *reg, u32 cval, const char *name)
+int omap2_wait_clock_ready(void __iomem *reg, u32 mask, const char *name)
 {
 	int i = 0;
+	int ena = 0;
+
+	/*
+	 * 24xx uses 0 to indicate not ready, and 1 to indicate ready.
+	 * 34xx reverses this, just to keep us on our toes
+	 */
+	if (cpu_mask & (RATE_IN_242X | RATE_IN_243X)) {
+		ena = mask;
+	} else if (cpu_mask & RATE_IN_343X) {
+		ena = 0;
+	}
 
 	/* Wait for lock */
-	while (!(cm_read_reg(reg) & cval)) {
-		++i;
+	while (((cm_read_reg(reg) & mask) != ena) &&
+	       (i++ < MAX_CLOCK_ENABLE_WAIT)) {
 		udelay(1);
-		if (i == MAX_CLOCK_ENABLE_WAIT) {
-			printk(KERN_ERR "Clock %s didn't enable in %d tries\n",
-			       name, MAX_CLOCK_ENABLE_WAIT);
-			break;
-		}
 	}
 
 	if (i < MAX_CLOCK_ENABLE_WAIT)
 		pr_debug("Clock %s stable after %d loops\n", name, i);
+	else
+		printk(KERN_ERR "Clock %s didn't enable in %d tries\n",
+		       name, MAX_CLOCK_ENABLE_WAIT);
+
 
 	return (i < MAX_CLOCK_ENABLE_WAIT) ? 1 : 0;
 };
@@ -180,6 +197,10 @@
 	void __iomem *reg, *other_reg, *st_reg;
 	u32 bit;
 
+	/*
+	 * REVISIT: This code is pretty ugly.  It would be nice to generalize
+	 * it and pull it into struct clk itself somehow.
+	 */
 	reg = clk->enable_reg;
 	if (reg == OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1) ||
 	    reg == OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2))
@@ -225,7 +246,7 @@
 	if (unlikely(clk->enable_reg == 0)) {
 		printk(KERN_ERR "clock.c: Enable for %s without enable code\n",
 		       clk->name);
-		return -EINVAL;
+		return 0; /* REVISIT: -EINVAL */
 	}
 
 	regval32 = cm_read_reg(clk->enable_reg);
Index: linux-omap/arch/arm/mach-omap2/cm_regbits_34xx.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/cm_regbits_34xx.h	2007-09-26 01:47:44.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/cm_regbits_34xx.h	2007-09-26 01:47:45.000000000 -0600
@@ -20,17 +20,23 @@
 
 /* CM_FCLKEN1_CORE and CM_ICLKEN1_CORE shared bits */
 #define OMAP3430_EN_MSPRO				(1 << 23)
+#define OMAP3430_EN_MSPRO_SHIFT				23
 #define OMAP3430_EN_HDQ					(1 << 22)
+#define OMAP3430_EN_HDQ_SHIFT				22
 #define OMAP3430_EN_SSI					(1 << 0)
+#define OMAP3430_EN_SSI_SHIFT				0
 
 /* CM_FCLKEN_WKUP and CM_ICLKEN_WKUP shared bits */
 #define OMAP3430_EN_WDT2				(1 << 5)
+#define OMAP3430_EN_WDT2_SHIFT				5
 
 /* CM_ICLKEN_CAM, CM_FCLKEN_CAM shared bits */
 #define OMAP3430_EN_CAM					(1 << 0)
+#define OMAP3430_EN_CAM_SHIFT				0
 
 /* CM_FCLKEN_PER, CM_ICLKEN_PER shared bits */
 #define OMAP3430_EN_WDT3				(1 << 12)
+#define OMAP3430_EN_WDT3_SHIFT				12
 
 /* CM_CLKSEL2_EMU, CM_CLKSEL3_EMU shared bits */
 #define OMAP3430_OVERRIDE_ENABLE			(1 << 19)
@@ -46,7 +52,8 @@
 #define OMAP3430_IVA2_DPLL_RAMPTIME_MASK		(0x3 << 8)
 #define OMAP3430_IVA2_DPLL_FREQSEL_SHIFT		4
 #define OMAP3430_IVA2_DPLL_FREQSEL_MASK			(0xf << 4)
-#define OMAP3430_EN_IVA2_DPLL_DRIFTGUARD		(1 << 3)
+#define OMAP3430_EN_IVA2_DPLL_DRIFTGUARD_SHIFT		3
+#define OMAP3430_EN_IVA2_DPLL_DRIFTGUARD_MASK		(1 << 3)
 #define OMAP3430_EN_IVA2_DPLL_SHIFT			0
 #define OMAP3430_EN_IVA2_DPLL_MASK			(0x7 << 0)
 
@@ -88,7 +95,8 @@
 #define OMAP3430_MPU_DPLL_RAMPTIME_MASK			(0x3 << 8)
 #define OMAP3430_MPU_DPLL_FREQSEL_SHIFT			4
 #define OMAP3430_MPU_DPLL_FREQSEL_MASK			(0xf << 4)
-#define OMAP3430_EN_MPU_DPLL_DRIFTGUARD			(1 << 3)
+#define OMAP3430_EN_MPU_DPLL_DRIFTGUARD_SHIFT		3
+#define OMAP3430_EN_MPU_DPLL_DRIFTGUARD_MASK		(1 << 3)
 #define OMAP3430_EN_MPU_DPLL_SHIFT			0
 #define OMAP3430_EN_MPU_DPLL_MASK			(0x7 << 0)
 
@@ -125,20 +133,33 @@
 
 /* CM_ICLKEN1_CORE specific bits */
 #define OMAP3430_EN_ICR					(1 << 29)
+#define OMAP3430_EN_ICR_SHIFT				29
 #define OMAP3430_EN_AES2				(1 << 28)
+#define OMAP3430_EN_AES2_SHIFT				28
 #define OMAP3430_EN_SHA12				(1 << 27)
+#define OMAP3430_EN_SHA12_SHIFT				27
 #define OMAP3430_EN_DES2				(1 << 26)
+#define OMAP3430_EN_DES2_SHIFT				26
 #define OMAP3430_EN_FAC					(1 << 8)
+#define OMAP3430_EN_FAC_SHIFT				8
 #define OMAP3430_EN_MAILBOXES				(1 << 7)
+#define OMAP3430_EN_MAILBOXES_SHIFT			7
 #define OMAP3430_EN_OMAPCTRL				(1 << 6)
+#define OMAP3430_EN_OMAPCTRL_SHIFT			6
 #define OMAP3430_EN_SDRC				(1 << 1)
+#define OMAP3430_EN_SDRC_SHIFT				1
 
 /* CM_ICLKEN2_CORE */
 #define OMAP3430_EN_PKA					(1 << 4)
+#define OMAP3430_EN_PKA_SHIFT				4
 #define OMAP3430_EN_AES1				(1 << 3)
+#define OMAP3430_EN_AES1_SHIFT				3
 #define OMAP3430_EN_RNG					(1 << 2)
+#define OMAP3430_EN_RNG_SHIFT				2
 #define OMAP3430_EN_SHA11				(1 << 1)
+#define OMAP3430_EN_SHA11_SHIFT				1
 #define OMAP3430_EN_DES1				(1 << 0)
+#define OMAP3430_EN_DES1_SHIFT				0
 
 /* CM_IDLEST1_CORE specific bits */
 #define OMAP3430_ST_ICR					(1 << 29)
@@ -162,47 +183,80 @@
 #define OMAP3430_ST_DES1				(1 << 0)
 
 /* CM_AUTOIDLE1_CORE */
-#define OMAP3430_AUTO_ICR				(1 << 29)
 #define OMAP3430_AUTO_AES2				(1 << 28)
+#define OMAP3430_AUTO_AES2_SHIFT			28
 #define OMAP3430_AUTO_SHA12				(1 << 27)
+#define OMAP3430_AUTO_SHA12_SHIFT			27
 #define OMAP3430_AUTO_DES2				(1 << 26)
+#define OMAP3430_AUTO_DES2_SHIFT			26
 #define OMAP3430_AUTO_MMC2				(1 << 25)
+#define OMAP3430_AUTO_MMC2_SHIFT			25
 #define OMAP3430_AUTO_MMC1				(1 << 24)
+#define OMAP3430_AUTO_MMC1_SHIFT			24
 #define OMAP3430_AUTO_MSPRO				(1 << 23)
+#define OMAP3430_AUTO_MSPRO_SHIFT			23
 #define OMAP3430_AUTO_HDQ				(1 << 22)
+#define OMAP3430_AUTO_HDQ_SHIFT				22
 #define OMAP3430_AUTO_MCSPI4				(1 << 21)
+#define OMAP3430_AUTO_MCSPI4_SHIFT			21
 #define OMAP3430_AUTO_MCSPI3				(1 << 20)
+#define OMAP3430_AUTO_MCSPI3_SHIFT			20
 #define OMAP3430_AUTO_MCSPI2				(1 << 19)
+#define OMAP3430_AUTO_MCSPI2_SHIFT			19
 #define OMAP3430_AUTO_MCSPI1				(1 << 18)
+#define OMAP3430_AUTO_MCSPI1_SHIFT			18
 #define OMAP3430_AUTO_I2C3				(1 << 17)
+#define OMAP3430_AUTO_I2C3_SHIFT			17
 #define OMAP3430_AUTO_I2C2				(1 << 16)
+#define OMAP3430_AUTO_I2C2_SHIFT			16
 #define OMAP3430_AUTO_I2C1				(1 << 15)
+#define OMAP3430_AUTO_I2C1_SHIFT			15
 #define OMAP3430_AUTO_UART2				(1 << 14)
+#define OMAP3430_AUTO_UART2_SHIFT			14
 #define OMAP3430_AUTO_UART1				(1 << 13)
+#define OMAP3430_AUTO_UART1_SHIFT			13
 #define OMAP3430_AUTO_GPT11				(1 << 12)
+#define OMAP3430_AUTO_GPT11_SHIFT			12
 #define OMAP3430_AUTO_GPT10				(1 << 11)
+#define OMAP3430_AUTO_GPT10_SHIFT			11
 #define OMAP3430_AUTO_MCBSP5				(1 << 10)
+#define OMAP3430_AUTO_MCBSP5_SHIFT			10
 #define OMAP3430_AUTO_MCBSP1				(1 << 9)
+#define OMAP3430_AUTO_MCBSP1_SHIFT			9
 #define OMAP3430_AUTO_FAC				(1 << 8)
+#define OMAP3430_AUTO_FAC_SHIFT				8
 #define OMAP3430_AUTO_MAILBOXES				(1 << 7)
+#define OMAP3430_AUTO_MAILBOXES_SHIFT			7
 #define OMAP3430_AUTO_OMAPCTRL				(1 << 6)
+#define OMAP3430_AUTO_OMAPCTRL_SHIFT			6
 #define OMAP3430_AUTO_FSHOSTUSB				(1 << 5)
+#define OMAP3430_AUTO_FSHOSTUSB_SHIFT			5
 #define OMAP3430_AUTO_HSOTGUSB				(1 << 4)
+#define OMAP3430_AUTO_HSOTGUSB_SHIFT			4
 #define OMAP3430_AUTO_D2D				(1 << 3)
+#define OMAP3430_AUTO_D2D_SHIFT				3
 #define OMAP3430_AUTO_SSI				(1 << 0)
+#define OMAP3430_AUTO_SSI_SHIFT				0
 
 /* CM_AUTOIDLE2_CORE */
 #define OMAP3430_AUTO_PKA				(1 << 4)
+#define OMAP3430_AUTO_PKA_SHIFT				4
 #define OMAP3430_AUTO_AES1				(1 << 3)
+#define OMAP3430_AUTO_AES1_SHIFT			3
 #define OMAP3430_AUTO_RNG				(1 << 2)
+#define OMAP3430_AUTO_RNG_SHIFT				2
 #define OMAP3430_AUTO_SHA11				(1 << 1)
+#define OMAP3430_AUTO_SHA11_SHIFT			1
 #define OMAP3430_AUTO_DES1				(1 << 0)
+#define OMAP3430_AUTO_DES1_SHIFT			0
 
 /* CM_CLKSEL_CORE */
 #define OMAP3430_CLKSEL_SSI_SHIFT			8
 #define OMAP3430_CLKSEL_SSI_MASK			(0xf << 8)
-#define OMAP3430_CLKSEL_GPT11				(1 << 7)
-#define OMAP3430_CLKSEL_GPT10				(1 << 6)
+#define OMAP3430_CLKSEL_GPT11_MASK			(1 << 7)
+#define OMAP3430_CLKSEL_GPT11_SHIFT			7
+#define OMAP3430_CLKSEL_GPT10_MASK			(1 << 6)
+#define OMAP3430_CLKSEL_GPT10_SHIFT			6
 #define OMAP3430_CLKSEL_FSHOSTUSB_SHIFT			4
 #define OMAP3430_CLKSEL_FSHOSTUSB_MASK			(0x3 << 4)
 #define OMAP3430_CLKSEL_L4_SHIFT			2
@@ -225,7 +279,9 @@
 
 /* CM_FCLKEN_GFX */
 #define OMAP3430_EN_3D					(1 << 2)
+#define OMAP3430_EN_3D_SHIFT				2
 #define OMAP3430_EN_2D					(1 << 1)
+#define OMAP3430_EN_2D_SHIFT				1
 
 /* CM_ICLKEN_GFX specific bits */
 
@@ -246,7 +302,9 @@
 
 /* CM_ICLKEN_WKUP specific bits */
 #define OMAP3430_EN_WDT1				(1 << 4)
+#define OMAP3430_EN_WDT1_SHIFT				4
 #define OMAP3430_EN_32KSYNC				(1 << 2)
+#define OMAP3430_EN_32KSYNC_SHIFT			       2
 
 /* CM_IDLEST_WKUP specific bits */
 #define OMAP3430_ST_WDT2				(1 << 5)
@@ -255,30 +313,45 @@
 
 /* CM_AUTOIDLE_WKUP */
 #define OMAP3430_AUTO_WDT2				(1 << 5)
+#define OMAP3430_AUTO_WDT2_SHIFT			5
 #define OMAP3430_AUTO_WDT1				(1 << 4)
+#define OMAP3430_AUTO_WDT1_SHIFT			4
 #define OMAP3430_AUTO_GPIO1				(1 << 3)
+#define OMAP3430_AUTO_GPIO1_SHIFT			3
 #define OMAP3430_AUTO_32KSYNC				(1 << 2)
+#define OMAP3430_AUTO_32KSYNC_SHIFT			2
 #define OMAP3430_AUTO_GPT12				(1 << 1)
+#define OMAP3430_AUTO_GPT12_SHIFT			1
 #define OMAP3430_AUTO_GPT1				(1 << 0)
+#define OMAP3430_AUTO_GPT1_SHIFT			0
 
 /* CM_CLKSEL_WKUP */
 #define OMAP3430_CLKSEL_RM_SHIFT			1
 #define OMAP3430_CLKSEL_RM_MASK				(0x3 << 1)
-#define OMAP3430_CLKSEL_GPT1				(1 << 0)
+#define OMAP3430_CLKSEL_GPT1_MASK			(1 << 0)
+#define OMAP3430_CLKSEL_GPT1_SHIFT			0
 
 /* CM_CLKEN_PLL */
+#define OMAP3430_PWRDN_EMU_PERIPH_SHIFT			31
+#define OMAP3430_PWRDN_CAM_SHIFT			30
+#define OMAP3430_PWRDN_DSS1_SHIFT			29
+#define OMAP3430_PWRDN_TV_SHIFT				28
+#define OMAP3430_PWRDN_96M_SHIFT			27
 #define OMAP3430_PERIPH_DPLL_RAMPTIME_SHIFT		24
 #define OMAP3430_PERIPH_DPLL_RAMPTIME_MASK		(0x3 << 24)
 #define OMAP3430_PERIPH_DPLL_FREQSEL_SHIFT		20
 #define OMAP3430_PERIPH_DPLL_FREQSEL_MASK		(0xf << 20)
-#define OMAP3430_EN_PERIPH_DPLL_DRIFTGUARD		(1 << 19)
+#define OMAP3430_EN_PERIPH_DPLL_DRIFTGUARD_SHIFT	19
+#define OMAP3430_EN_PERIPH_DPLL_DRIFTGUARD_MASK		(1 << 19)
 #define OMAP3430_EN_PERIPH_DPLL_SHIFT			16
 #define OMAP3430_EN_PERIPH_DPLL_MASK			(0x7 << 16)
+#define OMAP3430_PWRDN_EMU_CORE_SHIFT			12
 #define OMAP3430_CORE_DPLL_RAMPTIME_SHIFT		8
 #define OMAP3430_CORE_DPLL_RAMPTIME_MASK		(0x3 << 8)
 #define OMAP3430_CORE_DPLL_FREQSEL_SHIFT		4
 #define OMAP3430_CORE_DPLL_FREQSEL_MASK			(0xf << 4)
-#define OMAP3430_EN_CORE_DPLL_DRIFTGUARD		(1 << 3)
+#define OMAP3430_EN_CORE_DPLL_DRIFTGUARD_SHIFT		3
+#define OMAP3430_EN_CORE_DPLL_DRIFTGUARD_MASK		(1 << 3)
 #define OMAP3430_EN_CORE_DPLL_SHIFT			0
 #define OMAP3430_EN_CORE_DPLL_MASK			(0x7 << 0)
 
@@ -317,6 +390,7 @@
 #define OMAP3430_DIV_96M_MASK				(0x1f << 0)
 
 /* CM_CLKOUT_CTRL */
+#define OMAP3430_CLKOUT2_EN_SHIFT			7
 #define OMAP3430_CLKOUT2_EN				(1 << 7)
 #define OMAP3430_CLKOUT2_DIV_SHIFT			3
 #define OMAP3430_CLKOUT2_DIV_MASK			(0x7 << 3)
@@ -325,17 +399,22 @@
 
 /* CM_FCLKEN_DSS */
 #define OMAP3430_EN_TV					(1 << 2)
+#define OMAP3430_EN_TV_SHIFT				       2
 #define OMAP3430_EN_DSS2				(1 << 1)
+#define OMAP3430_EN_DSS2_SHIFT				1
 #define OMAP3430_EN_DSS1				(1 << 0)
+#define OMAP3430_EN_DSS1_SHIFT				0
 
 /* CM_ICLKEN_DSS */
 #define OMAP3430_CM_ICLKEN_DSS_EN_DSS			(1 << 0)
+#define OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT		0
 
 /* CM_IDLEST_DSS */
 #define OMAP3430_ST_DSS					(1 << 0)
 
 /* CM_AUTOIDLE_DSS */
 #define OMAP3430_AUTO_DSS				(1 << 0)
+#define OMAP3430_AUTO_DSS_SHIFT				0
 
 /* CM_CLKSEL_DSS */
 #define OMAP3430_CLKSEL_TV_SHIFT			8
@@ -361,6 +440,7 @@
 
 /* CM_AUTOIDLE_CAM */
 #define OMAP3430_AUTO_CAM				(1 << 0)
+#define OMAP3430_AUTO_CAM_SHIFT				0
 
 /* CM_CLKSEL_CAM */
 #define OMAP3430_CLKSEL_CAM_SHIFT			0
@@ -387,33 +467,59 @@
 
 /* CM_AUTOIDLE_PER */
 #define OMAP3430_AUTO_GPIO6				(1 << 17)
+#define OMAP3430_AUTO_GPIO6_SHIFT			17
 #define OMAP3430_AUTO_GPIO5				(1 << 16)
+#define OMAP3430_AUTO_GPIO5_SHIFT			16
 #define OMAP3430_AUTO_GPIO4				(1 << 15)
+#define OMAP3430_AUTO_GPIO4_SHIFT			15
 #define OMAP3430_AUTO_GPIO3				(1 << 14)
+#define OMAP3430_AUTO_GPIO3_SHIFT			14
 #define OMAP3430_AUTO_GPIO2				(1 << 13)
+#define OMAP3430_AUTO_GPIO2_SHIFT			13
 #define OMAP3430_AUTO_WDT3				(1 << 12)
+#define OMAP3430_AUTO_WDT3_SHIFT			12
 #define OMAP3430_AUTO_UART3				(1 << 11)
+#define OMAP3430_AUTO_UART3_SHIFT			11
 #define OMAP3430_AUTO_GPT9				(1 << 10)
+#define OMAP3430_AUTO_GPT9_SHIFT			10
 #define OMAP3430_AUTO_GPT8				(1 << 9)
+#define OMAP3430_AUTO_GPT8_SHIFT			9
 #define OMAP3430_AUTO_GPT7				(1 << 8)
+#define OMAP3430_AUTO_GPT7_SHIFT			8
 #define OMAP3430_AUTO_GPT6				(1 << 7)
+#define OMAP3430_AUTO_GPT6_SHIFT			7
 #define OMAP3430_AUTO_GPT5				(1 << 6)
+#define OMAP3430_AUTO_GPT5_SHIFT			6
 #define OMAP3430_AUTO_GPT4				(1 << 5)
+#define OMAP3430_AUTO_GPT4_SHIFT			5
 #define OMAP3430_AUTO_GPT3				(1 << 4)
+#define OMAP3430_AUTO_GPT3_SHIFT			4
 #define OMAP3430_AUTO_GPT2				(1 << 3)
+#define OMAP3430_AUTO_GPT2_SHIFT			3
 #define OMAP3430_AUTO_MCBSP4				(1 << 2)
+#define OMAP3430_AUTO_MCBSP4_SHIFT			2
 #define OMAP3430_AUTO_MCBSP3				(1 << 1)
+#define OMAP3430_AUTO_MCBSP3_SHIFT			1
 #define OMAP3430_AUTO_MCBSP2				(1 << 0)
+#define OMAP3430_AUTO_MCBSP2_SHIFT			0
 
 /* CM_CLKSEL_PER */
-#define OMAP3430_CLKSEL_GPT9				(1 << 7)
-#define OMAP3430_CLKSEL_GPT8				(1 << 6)
-#define OMAP3430_CLKSEL_GPT7				(1 << 5)
-#define OMAP3430_CLKSEL_GPT6				(1 << 4)
-#define OMAP3430_CLKSEL_GPT5				(1 << 3)
-#define OMAP3430_CLKSEL_GPT4				(1 << 2)
-#define OMAP3430_CLKSEL_GPT3				(1 << 1)
-#define OMAP3430_CLKSEL_GPT2				(1 << 0)
+#define OMAP3430_CLKSEL_GPT9_MASK			(1 << 7)
+#define OMAP3430_CLKSEL_GPT9_SHIFT			7
+#define OMAP3430_CLKSEL_GPT8_MASK			(1 << 6)
+#define OMAP3430_CLKSEL_GPT8_SHIFT			6
+#define OMAP3430_CLKSEL_GPT7_MASK			(1 << 5)
+#define OMAP3430_CLKSEL_GPT7_SHIFT			5
+#define OMAP3430_CLKSEL_GPT6_MASK			(1 << 4)
+#define OMAP3430_CLKSEL_GPT6_SHIFT			4
+#define OMAP3430_CLKSEL_GPT5_MASK			(1 << 3)
+#define OMAP3430_CLKSEL_GPT5_SHIFT			3
+#define OMAP3430_CLKSEL_GPT4_MASK			(1 << 2)
+#define OMAP3430_CLKSEL_GPT4_SHIFT			2
+#define OMAP3430_CLKSEL_GPT3_MASK			(1 << 1)
+#define OMAP3430_CLKSEL_GPT3_SHIFT			1
+#define OMAP3430_CLKSEL_GPT2_MASK			(1 << 0)
+#define OMAP3430_CLKSEL_GPT2_SHIFT			0
 
 /* CM_SLEEPDEP_PER specific bits */
 #define OMAP3430_CM_SLEEPDEP_PER_EN_IVA2		(1 << 2)
Index: linux-omap/arch/arm/mach-omap2/prcm_common.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/prcm_common.h	2007-09-26 01:47:44.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/prcm_common.h	2007-09-26 01:47:45.000000000 -0600
@@ -159,25 +159,43 @@
 
 /* CM_FCLKEN1_CORE, CM_ICLKEN1_CORE, PM_WKEN1_CORE shared bits */
 #define OMAP3430_EN_MMC2				(1 << 25)
+#define OMAP3430_EN_MMC2_SHIFT				25
 #define OMAP3430_EN_MMC1				(1 << 24)
+#define OMAP3430_EN_MMC1_SHIFT				24
 #define OMAP3430_EN_MCSPI4				(1 << 21)
+#define OMAP3430_EN_MCSPI4_SHIFT			21
 #define OMAP3430_EN_MCSPI3				(1 << 20)
+#define OMAP3430_EN_MCSPI3_SHIFT			20
 #define OMAP3430_EN_MCSPI2				(1 << 19)
+#define OMAP3430_EN_MCSPI2_SHIFT			19
 #define OMAP3430_EN_MCSPI1				(1 << 18)
+#define OMAP3430_EN_MCSPI1_SHIFT			18
 #define OMAP3430_EN_I2C3				(1 << 17)
+#define OMAP3430_EN_I2C3_SHIFT				17
 #define OMAP3430_EN_I2C2				(1 << 16)
+#define OMAP3430_EN_I2C2_SHIFT				16
 #define OMAP3430_EN_I2C1				(1 << 15)
+#define OMAP3430_EN_I2C1_SHIFT				15
 #define OMAP3430_EN_UART2				(1 << 14)
+#define OMAP3430_EN_UART2_SHIFT				14
 #define OMAP3430_EN_UART1				(1 << 13)
+#define OMAP3430_EN_UART1_SHIFT				13
 #define OMAP3430_EN_GPT11				(1 << 12)
+#define OMAP3430_EN_GPT11_SHIFT				12
 #define OMAP3430_EN_GPT10				(1 << 11)
+#define OMAP3430_EN_GPT10_SHIFT				11
 #define OMAP3430_EN_MCBSP5				(1 << 10)
+#define OMAP3430_EN_MCBSP5_SHIFT			10
 #define OMAP3430_EN_MCBSP1				(1 << 9)
+#define OMAP3430_EN_MCBSP1_SHIFT			9
 #define OMAP3430_EN_FSHOSTUSB				(1 << 5)
+#define OMAP3430_EN_FSHOSTUSB_SHIFT			5
 #define OMAP3430_EN_D2D					(1 << 3)
+#define OMAP3430_EN_D2D_SHIFT				3
 
 /* CM_ICLKEN1_CORE, PM_WKEN1_CORE shared bits */
 #define OMAP3430_EN_HSOTGUSB				(1 << 4)
+#define OMAP3430_EN_HSOTGUSB_SHIFT				4
 
 /* PM_WKST1_CORE, CM_IDLEST1_CORE shared bits */
 #define OMAP3430_ST_MMC2				(1 << 25)
@@ -201,14 +219,19 @@
 
 /* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
 #define OMAP3430_EN_GPIO1				(1 << 3)
+#define OMAP3430_EN_GPIO1_SHIFT				3
 #define OMAP3430_EN_GPT1				(1 << 0)
+#define OMAP3430_EN_GPT1_SHIFT				0
 
 /* CM_FCLKEN_WKUP, PM_WKEN_WKUP shared bits */
 #define OMAP3430_EN_SR2					(1 << 7)
+#define OMAP3430_EN_SR2_SHIFT				7
 #define OMAP3430_EN_SR1					(1 << 6)
+#define OMAP3430_EN_SR1_SHIFT				6
 
 /* CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
 #define OMAP3430_EN_GPT12				(1 << 1)
+#define OMAP3430_EN_GPT12_SHIFT				1
 
 /* CM_IDLEST_WKUP, PM_WKST_WKUP shared bits */
 #define OMAP3430_ST_SR2					(1 << 7)
@@ -223,29 +246,47 @@
  * PM_WKDEP_DSS, PM_WKDEP_CAM, PM_WKDEP_PER, PM_WKDEP_NEON shared bits
  */
 #define OMAP3430_EN_MPU					(1 << 1)
+#define OMAP3430_EN_MPU_SHIFT				1
 
 /* CM_FCLKEN_PER, CM_ICLKEN_PER, PM_WKEN_PER shared bits */
 #define OMAP3430_EN_GPIO6				(1 << 17)
+#define OMAP3430_EN_GPIO6_SHIFT				17
 #define OMAP3430_EN_GPIO5				(1 << 16)
+#define OMAP3430_EN_GPIO5_SHIFT				16
 #define OMAP3430_EN_GPIO4				(1 << 15)
+#define OMAP3430_EN_GPIO4_SHIFT				15
 #define OMAP3430_EN_GPIO3				(1 << 14)
+#define OMAP3430_EN_GPIO3_SHIFT				14
 #define OMAP3430_EN_GPIO2				(1 << 13)
+#define OMAP3430_EN_GPIO2_SHIFT				13
 #define OMAP3430_EN_UART3				(1 << 11)
+#define OMAP3430_EN_UART3_SHIFT				11
 #define OMAP3430_EN_GPT9				(1 << 10)
+#define OMAP3430_EN_GPT9_SHIFT				10
 #define OMAP3430_EN_GPT8				(1 << 9)
+#define OMAP3430_EN_GPT8_SHIFT				9
 #define OMAP3430_EN_GPT7				(1 << 8)
+#define OMAP3430_EN_GPT7_SHIFT				8
 #define OMAP3430_EN_GPT6				(1 << 7)
+#define OMAP3430_EN_GPT6_SHIFT				7
 #define OMAP3430_EN_GPT5				(1 << 6)
+#define OMAP3430_EN_GPT5_SHIFT				6
 #define OMAP3430_EN_GPT4				(1 << 5)
+#define OMAP3430_EN_GPT4_SHIFT				5
 #define OMAP3430_EN_GPT3				(1 << 4)
+#define OMAP3430_EN_GPT3_SHIFT				4
 #define OMAP3430_EN_GPT2				(1 << 3)
+#define OMAP3430_EN_GPT2_SHIFT				3
 
 /* CM_FCLKEN_PER, CM_ICLKEN_PER, PM_WKEN_PER, PM_WKST_PER shared bits */
 /* XXX Possible TI documentation bug: should the PM_WKST_PER EN_* bits
  * be ST_* bits instead? */
 #define OMAP3430_EN_MCBSP4				(1 << 2)
+#define OMAP3430_EN_MCBSP4_SHIFT			2
 #define OMAP3430_EN_MCBSP3				(1 << 1)
+#define OMAP3430_EN_MCBSP3_SHIFT			1
 #define OMAP3430_EN_MCBSP2				(1 << 0)
+#define OMAP3430_EN_MCBSP2_SHIFT			0
 
 /* CM_IDLEST_PER, PM_WKST_PER shared bits */
 #define OMAP3430_ST_GPIO6				(1 << 17)
Index: linux-omap/arch/arm/mach-omap2/prm_regbits_34xx.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/prm_regbits_34xx.h	2007-09-26 01:47:44.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/prm_regbits_34xx.h	2007-09-26 01:47:45.000000000 -0600
@@ -228,9 +228,13 @@
 #define OMAP3430_VP1_OPPCHANGEDONE_ST			(1 << 10)
 #define OMAP3430_IO_ST					(1 << 9)
 #define OMAP3430_PRM_IRQSTATUS_MPU_IVA2_DPLL_ST		(1 << 8)
+#define OMAP3430_PRM_IRQSTATUS_MPU_IVA2_DPLL_ST_SHIFT	8
 #define OMAP3430_MPU_DPLL_ST				(1 << 7)
+#define OMAP3430_MPU_DPLL_ST_SHIFT			7
 #define OMAP3430_PERIPH_DPLL_ST				(1 << 6)
+#define OMAP3430_PERIPH_DPLL_ST_SHIFT			6
 #define OMAP3430_CORE_DPLL_ST				(1 << 5)
+#define OMAP3430_CORE_DPLL_ST_SHIFT			5
 #define OMAP3430_TRANSITION_ST				(1 << 4)
 #define OMAP3430_EVGENOFF_ST				(1 << 3)
 #define OMAP3430_EVGENON_ST				(1 << 2)
@@ -254,9 +258,13 @@
 #define OMAP3430_VP1_OPPCHANGEDONE_EN				(1 << 10)
 #define OMAP3430_IO_EN						(1 << 9)
 #define OMAP3430_PRM_IRQENABLE_MPU_IVA2_DPLL_RECAL_EN		(1 << 8)
+#define OMAP3430_PRM_IRQENABLE_MPU_IVA2_DPLL_RECAL_EN_SHIFT	8
 #define OMAP3430_MPU_DPLL_RECAL_EN				(1 << 7)
+#define OMAP3430_MPU_DPLL_RECAL_EN_SHIFT			7
 #define OMAP3430_PERIPH_DPLL_RECAL_EN				(1 << 6)
+#define OMAP3430_PERIPH_DPLL_RECAL_EN_SHIFT			6
 #define OMAP3430_CORE_DPLL_RECAL_EN				(1 << 5)
+#define OMAP3430_CORE_DPLL_RECAL_EN_SHIFT			5
 #define OMAP3430_TRANSITION_EN					(1 << 4)
 #define OMAP3430_EVGENOFF_EN					(1 << 3)
 #define OMAP3430_EVGENON_EN					(1 << 2)
@@ -365,6 +373,7 @@
 
 /* PRM_CLKOUT_CTRL */
 #define OMAP3430_CLKOUT_EN				(1 << 7)
+#define OMAP3430_CLKOUT_EN_SHIFT			7
 
 /* RM_RSTST_DSS specific bits */
 

-- 
