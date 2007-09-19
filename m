From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/7] omap2 clock: split out OMAP2/3 common defines,
	clksel rates
Date: Wed, 19 Sep 2007 15:10:01 -0600
Message-ID: <20070919211138.865281843@pwsan.com>
References: <20070919210959.062447046@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline; filename=clean-up-common-24xx-clock-code.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
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

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c       |   10 +++--
 arch/arm/mach-omap2/clock.h       |   22 +++++++++++
 arch/arm/mach-omap2/clock24xx.h   |   73 +++++++++++++-------------------------
 arch/arm/mach-omap2/cm.h          |    2 -
 include/asm-arm/arch-omap/clock.h |    2 -
 5 files changed, 55 insertions(+), 54 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h	2007-09-19 10:57:39.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.h	2007-09-19 11:38:27.000000000 -0600
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
--- linux-omap.orig/arch/arm/mach-omap2/cm.h	2007-09-19 10:57:39.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/cm.h	2007-09-19 11:38:27.000000000 -0600
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
--- linux-omap.orig/include/asm-arm/arch-omap/clock.h	2007-09-19 10:57:39.000000000 -0600
+++ linux-omap/include/asm-arm/arch-omap/clock.h	2007-09-19 11:38:31.000000000 -0600
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
--- linux-omap.orig/arch/arm/mach-omap2/clock24xx.h	2007-09-19 10:57:39.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock24xx.h	2007-09-19 11:38:27.000000000 -0600
@@ -965,7 +965,7 @@
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | RATE_PROPAGATES |
 				CONFIG_PARTICIPANT,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_MASK,
@@ -1027,7 +1027,7 @@
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP |
 				CONFIG_PARTICIPANT | RATE_PROPAGATES,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_MASK,
@@ -1082,7 +1082,7 @@
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | CONFIG_PARTICIPANT |
 				RATE_PROPAGATES | DELAYED_APP,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP2420_EN_IVA_COP_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP2420_CLKSEL_IVA_MASK,
@@ -1097,7 +1097,7 @@
 	.name		= "iva1_mpu_int_ifck",
 	.parent		= &iva1_ifck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, OMAP24XX_CM_FCLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP2420_EN_IVA_MPU_SHIFT,
 	.fixed_div	= 2,
 	.recalc		= &omap2_fixed_divisor_recalc,
@@ -1232,20 +1232,9 @@
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
 
@@ -1253,7 +1242,7 @@
 	.name		= "gfx_3d_fck",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, OMAP24XX_CM_FCLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_3D_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
@@ -1267,7 +1256,7 @@
 	.name		= "gfx_2d_fck",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, OMAP24XX_CM_FCLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_2D_SHIFT,
 	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
@@ -1324,7 +1313,7 @@
 	.name		= "mdm_osc_ck",
 	.parent		= &osc_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, OMAP24XX_CM_FCLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP2430_EN_OSC_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1474,22 +1463,12 @@
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
@@ -1509,12 +1488,12 @@
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
@@ -1538,7 +1517,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT2_MASK,
-	.clksel		= gpt_clksel,
+	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1560,7 +1539,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT3_MASK,
-	.clksel		= gpt_clksel,
+	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1582,7 +1561,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT4_MASK,
-	.clksel		= gpt_clksel,
+	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1604,7 +1583,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT5_MASK,
-	.clksel		= gpt_clksel,
+	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1626,7 +1605,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT6_MASK,
-	.clksel		= gpt_clksel,
+	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1648,7 +1627,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT7_MASK,
-	.clksel		= gpt_clksel,
+	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1670,7 +1649,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT8_MASK,
-	.clksel		= gpt_clksel,
+	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1692,7 +1671,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT9_MASK,
-	.clksel		= gpt_clksel,
+	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1714,7 +1693,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT10_MASK,
-	.clksel		= gpt_clksel,
+	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1736,7 +1715,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT11_MASK,
-	.clksel		= gpt_clksel,
+	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1758,7 +1737,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT12_MASK,
-	.clksel		= gpt_clksel,
+	.clksel		= omap24xx_gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1979,7 +1958,7 @@
 	.name		= "gpios_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, OMAP24XX_CM_FCLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_GPIOS_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -1997,7 +1976,7 @@
 	.name		= "mpu_wdt_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, OMAP24XX_CM_FCLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_MPU_WDT_SHIFT,
 	.recalc		= &followparent_recalc,
 };
@@ -2495,7 +2474,7 @@
 	.round_rate	= &omap2_round_to_table_rate,
 };
 
-static struct clk *onchip_clks[] __initdata = {
+static struct clk *onchip_24xx_clks[] __initdata = {
 	/* external root sources */
 	&func_32k_ck,
 	&osc_ck,
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c	2007-09-19 11:38:23.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.c	2007-09-19 11:38:31.000000000 -0600
@@ -31,6 +31,7 @@
 
 #include <asm/arch/clock.h>
 #include <asm/arch/sram.h>
+#include <asm/arch/cpu.h>
 #include <asm/div64.h>
 
 #include "memory.h"
@@ -84,7 +85,7 @@
 					pr_debug("clock: inited %s parent "
 						 "to %s (was %s)\n",
 						 clk->name, clks->parent->name,
-						 ((clk->parent->name) ?
+						 ((clk->parent) ?
 						  clk->parent->name : "NULL"));
 					clk->parent = clks->parent;
 				};
@@ -180,8 +181,9 @@
 	else
 		return;
 
+	/* REVISIT: What are the appropriate exclusions for 34XX? */
 	/* No check for DSS or cam clocks */
-	if (((u32)reg & 0x0f) == 0) { /* CM_{F,I}CLKEN1 */
+	if (cpu_is_omap24xx() && ((u32)reg & 0x0f) == 0) { /* CM_{F,I}CLKEN1 */
 		if (clk->enable_bit == OMAP24XX_EN_DSS2_SHIFT ||
 		    clk->enable_bit == OMAP24XX_EN_DSS1_SHIFT ||
 		    clk->enable_bit == OMAP24XX_EN_CAM_SHIFT)
@@ -574,7 +576,7 @@
 
 	clk->rate = clk->parent->rate / new_div;
 
-	if (clk->flags & DELAYED_APP) {
+	if (clk->flags & DELAYED_APP && cpu_is_omap24xx()) {
 		prm_write_reg(OMAP24XX_VALID_CONFIG, OMAP24XX_PRCM_CLKCFG_CTRL);
 		wmb();
 	}
@@ -670,7 +672,7 @@
 	__raw_writel(reg_val, src_addr);
 	wmb();
 
-	if (clk->flags & DELAYED_APP) {
+	if (clk->flags & DELAYED_APP && cpu_is_omap24xx()) {
 		prm_write_reg(OMAP24XX_VALID_CONFIG,
 			      OMAP24XX_PRCM_CLKCFG_CTRL);
 		wmb();

-- 
