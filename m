From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/7] omap2 clock: split out OMAP2/3 common defines,
	clksel rates
Date: Thu, 27 Sep 2007 00:11:21 -0600
Message-ID: <20070927061256.674345152@pwsan.com>
References: <20070927061119.551228401@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=clean-up-common-24xx-clock-code.patch
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

This patch is a collection of minor clock code changes in preparation for 
the OMAP3 clock merge.  Specifically:

* Since general-purpose timer and GFX module L3 clksel rates are common to 
  OMAP2/3, hoist those into asm/arch/clock.h.

* Since the CM_FCLKEN define is common to OMAP2/3, remove the OMAP24XX_  
  prefix.  

* Designate the clock transaction code in clock.c as being OMAP2-specific.

* Fix a potential null pointer dereference that could occur when debugging
  is enabled in omap2_init_clksel_parent().  Clocks with no initially-defined 
  parent (as is possible for clksel clocks) will trigger an oops due to a
  buggy conditional.

* Clean up omap2_wait_clock_ready().

* Remove unused struct dpll_params auto_idle* fields.


Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c       |   36 ++++++++++--------
 arch/arm/mach-omap2/clock.h       |   22 +++++++++++
 arch/arm/mach-omap2/clock24xx.c   |    7 ++-
 arch/arm/mach-omap2/clock24xx.h   |   75 +++++++++++++-------------------------
 arch/arm/mach-omap2/cm.h          |    2 -
 include/asm-arm/arch-omap/clock.h |    2 -
 6 files changed, 74 insertions(+), 70 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h	2007-09-26 01:36:43.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.h	2007-09-26 01:36:45.000000000 -0600
@@ -21,6 +21,8 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CLOCK_H
 #define __ARCH_ARM_MACH_OMAP2_CLOCK_H
 
+#include <asm/arch/clock.h>
+
 int omap2_clk_enable(struct clk *clk);
 void omap2_clk_disable(struct clk *clk);
 long omap2_clk_round_rate(struct clk *clk, unsigned long rate);
@@ -49,4 +51,24 @@
 
 extern u8 cpu_mask;
 
+/* clksel_rate data common to 24xx/343x */
+static const struct clksel_rate gpt_32k_rates[] = {
+	 { .div = 1, .val = 0, .flags = RATE_IN_24XX | RATE_IN_343X | DEFAULT_RATE },
+	 { .div = 0 }
+};
+
+static const struct clksel_rate gpt_sys_rates[] = {
+	 { .div = 1, .val = 1, .flags = RATE_IN_24XX | RATE_IN_343X | DEFAULT_RATE },
+	 { .div = 0 }
+};
+
+static const struct clksel_rate gfx_l3_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | RATE_IN_343X },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX | RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 3, .val = 3, .flags = RATE_IN_243X | RATE_IN_343X },
+	{ .div = 4, .val = 4, .flags = RATE_IN_243X | RATE_IN_343X },
+	{ .div = 0 }
+};
+
+
 #endif
Index: linux-omap/arch/arm/mach-omap2/cm.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/cm.h	2007-09-26 01:36:43.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/cm.h	2007-09-26 01:52:13.000000000 -0600
@@ -54,6 +54,7 @@
 /* Common between 24xx and 34xx */
 
 #define CM_FCLKEN1					0x0000
+#define CM_FCLKEN					CM_FCLKEN1
 #define CM_CLKEN					CM_FCLKEN1
 #define CM_ICLKEN1					0x0010
 #define CM_ICLKEN					CM_ICLKEN1
@@ -72,7 +73,6 @@
 
 /* Architecture-specific registers */
 
-#define OMAP24XX_CM_FCLKEN				CM_FCLKEN1
 #define OMAP24XX_CM_FCLKEN2				0x0004
 #define OMAP24XX_CM_ICLKEN4				0x001c
 #define OMAP24XX_CM_AUTOIDLE3				0x0038
Index: linux-omap/include/asm-arm/arch-omap/clock.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/clock.h	2007-09-26 01:36:43.000000000 -0600
+++ linux-omap/include/asm-arm/arch-omap/clock.h	2007-09-26 01:52:14.000000000 -0600
@@ -33,8 +33,6 @@
 	void __iomem		*mult_div1_reg;
 	u32			mult_mask;
 	u32			div1_mask;
-	u32			auto_idle_mask;
-	u8			auto_idle_val;
 };
 
 #endif
Index: linux-omap/arch/arm/mach-omap2/clock24xx.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock24xx.h	2007-09-26 01:36:43.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock24xx.h	2007-09-26 01:52:45.000000000 -0600
@@ -608,8 +608,6 @@
 	.mult_div1_reg		= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.mult_mask		= OMAP24XX_DPLL_MULT_MASK,
 	.div1_mask		= OMAP24XX_DPLL_DIV_MASK,
-	.auto_idle_mask		= OMAP24XX_AUTO_DPLL_MASK,
-	.auto_idle_val		= 0x3, /* stop DPLL upon idle */
 };
 
 static struct clk dpll_ck = {
@@ -965,7 +963,7 @@
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | RATE_PROPAGATES |
 				CONFIG_PARTICIPANT,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_MASK,
@@ -1027,7 +1025,7 @@
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP |
 				CONFIG_PARTICIPANT | RATE_PROPAGATES,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_MASK,
@@ -1082,7 +1080,7 @@
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | CONFIG_PARTICIPANT |
 				RATE_PROPAGATES | DELAYED_APP,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP2420_EN_IVA_COP_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP2420_CLKSEL_IVA_MASK,
@@ -1097,7 +1095,7 @@
 	.name		= "iva1_mpu_int_ifck",
 	.parent		= &iva1_ifck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP2420_EN_IVA_MPU_SHIFT,
 	.fixed_div	= 2,
 	.recalc		= &omap2_fixed_divisor_recalc,
@@ -1232,20 +1230,9 @@
  */
 /* XXX REVISIT: GFX clock is part of CONFIG_PARTICIPANT, no? doublecheck. */
 
-/*
- * These clksel_rate/clksel structs are shared between gfx_3d_fck and
- * gfx_2d_fck
- */
-static const struct clksel_rate gfx_fck_core_l3_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
-	{ .div = 2, .val = 2, .flags = RATE_IN_24XX | DEFAULT_RATE },
-	{ .div = 3, .val = 3, .flags = RATE_IN_243X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_243X },
-	{ .div = 0 }
-};
-
+/* This clksel struct is shared between gfx_3d_fck and gfx_2d_fck */
 static const struct clksel gfx_fck_clksel[] = {
-	{ .parent = &core_l3_ck, .rates = gfx_fck_core_l3_rates },
+	{ .parent = &core_l3_ck, .rates = gfx_l3_rates },
 	{ .parent = NULL },
 };
 
@@ -1253,7 +1240,7 @@
 	.name		= "gfx_3d_fck",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, OMAP24XX_CM_FCLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_3D_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
@@ -1267,7 +1254,7 @@
 	.name		= "gfx_2d_fck",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, OMAP24XX_CM_FCLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_2D_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
@@ -1324,7 +1311,7 @@
 	.name		= "mdm_osc_ck",
 	.parent		= &osc_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, OMAP24XX_CM_FCLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP2430_EN_OSC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1474,22 +1461,12 @@
  * here will likely have an L4 interface parent, and may have multiple
  * functional clock parents.
  */
-static const struct clksel_rate gpt_32k_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
-	{ .div = 0 }
-};
-
-static const struct clksel_rate gpt_sys_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
-	{ .div = 0 }
-};
-
 static const struct clksel_rate gpt_alt_rates[] = {
 	{ .div = 1, .val = 2, .flags = RATE_IN_24XX | DEFAULT_RATE },
 	{ .div = 0 }
 };
 
-static const struct clksel gpt_clksel[] = {
+static const struct clksel omap24xx_gpt_clksel[] = {
 	{ .parent = &func_32k_ck, .rates = gpt_32k_rates },
 	{ .parent = &sys_ck,	  .rates = gpt_sys_rates },
 	{ .parent = &alt_ck,	  .rates = gpt_alt_rates },
@@ -1509,12 +1486,12 @@
 	.name		= "gpt1_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, OMAP24XX_CM_FCLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT1_MASK,
-	.clksel		= gpt_clksel,
+	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate
@@ -1538,7 +1515,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT2_MASK,
-	.clksel		= gpt_clksel,
+	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1560,7 +1537,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT3_MASK,
-	.clksel		= gpt_clksel,
+	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1582,7 +1559,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT4_MASK,
-	.clksel		= gpt_clksel,
+	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1604,7 +1581,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT5_MASK,
-	.clksel		= gpt_clksel,
+	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1626,7 +1603,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT6_MASK,
-	.clksel		= gpt_clksel,
+	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1648,7 +1625,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT7_MASK,
-	.clksel		= gpt_clksel,
+	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1670,7 +1647,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT8_MASK,
-	.clksel		= gpt_clksel,
+	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1692,7 +1669,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT9_MASK,
-	.clksel		= gpt_clksel,
+	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1714,7 +1691,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT10_MASK,
-	.clksel		= gpt_clksel,
+	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1736,7 +1713,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT11_MASK,
-	.clksel		= gpt_clksel,
+	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1758,7 +1735,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT12_MASK,
-	.clksel		= gpt_clksel,
+	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1979,7 +1956,7 @@
 	.name		= "gpios_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, OMAP24XX_CM_FCLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_GPIOS_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1997,7 +1974,7 @@
 	.name		= "mpu_wdt_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, OMAP24XX_CM_FCLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_MPU_WDT_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2495,7 +2472,7 @@
 	.round_rate	= &omap2_round_to_table_rate,
 };
 
-static struct clk *onchip_clks[] __initdata = {
+static struct clk *onchip_24xx_clks[] __initdata = {
 	/* external root sources */
 	&func_32k_ck,
 	&osc_ck,
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c	2007-09-26 01:36:43.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.c	2007-09-26 01:52:14.000000000 -0600
@@ -19,6 +19,8 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#undef DEBUG
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
@@ -31,6 +33,7 @@
 
 #include <asm/arch/clock.h>
 #include <asm/arch/sram.h>
+#include <asm/arch/cpu.h>
 #include <asm/div64.h>
 
 #include "memory.h"
@@ -41,9 +44,7 @@
 #include "cm.h"
 #include "cm_regbits_24xx.h"
 
-#undef DEBUG
-
-#define MAX_PLL_LOCK_WAIT		100000
+#define MAX_CLOCK_ENABLE_WAIT		100000
 
 u8 cpu_mask;
 
@@ -84,7 +85,7 @@
 					pr_debug("clock: inited %s parent "
 						 "to %s (was %s)\n",
 						 clk->name, clks->parent->name,
-						 ((clk->parent->name) ?
+						 ((clk->parent) ?
 						  clk->parent->name : "NULL"));
 					clk->parent = clks->parent;
 				};
@@ -138,10 +139,14 @@
 		propagate_rate(clk);
 }
 
-/*
- * omap2_wait_clock_ready - wait for PLL to lock
+/**
+ * omap2_wait_clock_ready - wait for clock to enable
+ * @reg: physical address of clock IDLEST register
+ * @cval: value to test against to determine if the clock is active
+ * @name: name of the clock (for printk)
  *
- * Returns 1 if the PLL locked, 0 if it failed to lock.
+ * Returns 1 if the clock enabled in time, or 0 if it failed to enable
+ * in roughly MAX_CLOCK_ENABLE_WAIT microseconds.
  */
 int omap2_wait_clock_ready(void __iomem *reg, u32 cval, const char *name)
 {
@@ -151,17 +156,17 @@
 	while (!(cm_read_reg(reg) & cval)) {
 		++i;
 		udelay(1);
-		if (i == MAX_PLL_LOCK_WAIT) {
-			printk(KERN_ERR "Clock %s didn't lock in %d tries\n",
-			       name, MAX_PLL_LOCK_WAIT);
+		if (i == MAX_CLOCK_ENABLE_WAIT) {
+			printk(KERN_ERR "Clock %s didn't enable in %d tries\n",
+			       name, MAX_CLOCK_ENABLE_WAIT);
 			break;
 		}
 	}
 
-	if (i)
+	if (i < MAX_CLOCK_ENABLE_WAIT)
 		pr_debug("Clock %s stable after %d loops\n", name, i);
 
-	return (i < MAX_PLL_LOCK_WAIT) ? 1 : 0;
+	return (i < MAX_CLOCK_ENABLE_WAIT) ? 1 : 0;
 };
 
 
@@ -180,8 +185,9 @@
 	else
 		return;
 
+	/* REVISIT: What are the appropriate exclusions for 34XX? */
 	/* No check for DSS or cam clocks */
-	if (((u32)reg & 0x0f) == 0) { /* CM_{F,I}CLKEN1 */
+	if (cpu_is_omap24xx() && ((u32)reg & 0x0f) == 0) { /* CM_{F,I}CLKEN1 */
 		if (clk->enable_bit == OMAP24XX_EN_DSS2_SHIFT ||
 		    clk->enable_bit == OMAP24XX_EN_DSS1_SHIFT ||
 		    clk->enable_bit == OMAP24XX_EN_CAM_SHIFT)
@@ -574,7 +580,7 @@
 
 	clk->rate = clk->parent->rate / new_div;
 
-	if (clk->flags & DELAYED_APP) {
+	if (clk->flags & DELAYED_APP && cpu_is_omap24xx()) {
 		prm_write_reg(OMAP24XX_VALID_CONFIG, OMAP24XX_PRCM_CLKCFG_CTRL);
 		wmb();
 	}
@@ -670,7 +676,7 @@
 	__raw_writel(reg_val, src_addr);
 	wmb();
 
-	if (clk->flags & DELAYED_APP) {
+	if (clk->flags & DELAYED_APP && cpu_is_omap24xx()) {
 		prm_write_reg(OMAP24XX_VALID_CONFIG,
 			      OMAP24XX_PRCM_CLKCFG_CTRL);
 		wmb();
Index: linux-omap/arch/arm/mach-omap2/clock24xx.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock24xx.c	2007-09-26 01:36:43.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock24xx.c	2007-09-26 01:53:09.000000000 -0600
@@ -15,6 +15,8 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#undef DEBUG
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
@@ -37,8 +39,6 @@
 #include "cm.h"
 #include "cm_regbits_24xx.h"
 
-#undef DEBUG
-
 /* CM_CLKEN_PLL.EN_{54,96}M_PLL options (24XX) */
 #define EN_APLL_STOPPED			0
 #define EN_APLL_LOCKED			3
@@ -476,7 +476,8 @@
 
 	omap2_osc_clk_recalc(&osc_ck);
 
-	for (clkp = onchip_clks; clkp < onchip_clks + ARRAY_SIZE(onchip_clks);
+	for (clkp = onchip_24xx_clks;
+	     clkp < onchip_24xx_clks + ARRAY_SIZE(onchip_24xx_clks);
 	     clkp++) {
 
 		if ((*clkp)->flags & CLOCK_IN_OMAP242X && cpu_is_omap2420()) {

-- 
