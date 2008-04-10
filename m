From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/4] Clockdomains: Integrate OMAP3 clocks with clockdomain code
Date: Thu, 10 Apr 2008 10:25:36 -0600
Message-ID: <20080410163626.270188008@pwsan.com>
References: <20080410162532.097381890@pwsan.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34131 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756469AbYDJRRr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2008 13:17:47 -0400
Content-Disposition: inline; filename=map_34xx_clocks_to_clockdomains.patch
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch integrates the OMAP3 clock tree with the clockdomain code.
This patch will:

- mark OMAP34xx clocks with their corresponding clockdomain.  

- add code to convert the clockdomain name to a clockdomain pointer in the 
  struct clk during clk_register().  

- modify OMAP2 clock usecounting to call into the clockdomain code
  when clocks are enabled or disabled.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c       |   45 +++++++-
 arch/arm/mach-omap2/clock.h       |    1 
 arch/arm/mach-omap2/clock34xx.c   |    4 
 arch/arm/mach-omap2/clock34xx.h   |  198 ++++++++++++++++++++++++++++++++++----
 include/asm-arm/arch-omap/clock.h |    4 
 5 files changed, 229 insertions(+), 23 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c	2008-04-10 08:41:46.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.c	2008-04-10 10:12:01.000000000 -0600
@@ -62,10 +62,36 @@
 u8 cpu_mask;
 
 /*-------------------------------------------------------------------------
- * Omap2 specific clock functions
+ * OMAP2/3 specific clock functions
  *-------------------------------------------------------------------------*/
 
 /**
+ * omap2_init_clk_clkdm - look up a clockdomain name, store pointer in clk
+ * @clk: OMAP clock struct ptr to use
+ *
+ * Convert a clockdomain name stored in a struct clk 'clk' into a
+ * clockdomain pointer, and save it into the struct clk.  Intended to be
+ * called during clk_register().  No return value.
+ */
+void omap2_init_clk_clkdm(struct clk *clk)
+{
+	struct clockdomain *clkdm;
+
+	if (!clk->clkdm_name)
+		return;
+
+	clkdm = clkdm_lookup(clk->clkdm_name);
+	if (clkdm) {
+		pr_debug("clock: associated clk %s to clkdm %s\n",
+			 clk->name, clk->clkdm_name);
+		clk->clkdm = clkdm;
+	} else {
+		pr_debug("clock: could not associate clk %s to "
+			 "clkdm %s\n", clk->name, clk->clkdm_name);
+	}
+}
+
+/**
  * omap2_init_clksel_parent - set a clksel clk's parent field from the hardware
  * @clk: OMAP clock struct ptr to use
  *
@@ -306,6 +332,9 @@
 		_omap2_clk_disable(clk);
 		if (likely((u32)clk->parent))
 			omap2_clk_disable(clk->parent);
+		if (clk->clkdm)
+			omap2_clkdm_clk_disable(clk->clkdm, clk);
+
 	}
 }
 
@@ -322,11 +351,19 @@
 			return ret;
 		}
 
+		if (clk->clkdm)
+			omap2_clkdm_clk_enable(clk->clkdm, clk);
+
 		ret = _omap2_clk_enable(clk);
 
-		if (unlikely(ret != 0) && clk->parent) {
-			omap2_clk_disable(clk->parent);
-			clk->usecount--;
+		if (unlikely(ret != 0)) {
+			if (clk->clkdm)
+				omap2_clkdm_clk_disable(clk->clkdm, clk);
+
+			if (clk->parent) {
+				omap2_clk_disable(clk->parent);
+				clk->usecount--;
+			}
 		}
 	}
 
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h	2008-04-10 08:41:46.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.h	2008-04-10 09:53:22.000000000 -0600
@@ -36,6 +36,7 @@
 #endif
 
 void omap2_clksel_recalc(struct clk *clk);
+void omap2_init_clk_clkdm(struct clk *clk);
 void omap2_init_clksel_parent(struct clk *clk);
 u32 omap2_clksel_get_divisor(struct clk *clk);
 u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
Index: linux-omap/arch/arm/mach-omap2/clock34xx.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock34xx.c	2008-04-10 08:41:46.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock34xx.c	2008-04-10 09:53:22.000000000 -0600
@@ -621,8 +621,10 @@
 	for (clkp = onchip_34xx_clks;
 	     clkp < onchip_34xx_clks + ARRAY_SIZE(onchip_34xx_clks);
 	     clkp++) {
-		if ((*clkp)->flags & cpu_clkflg)
+		if ((*clkp)->flags & cpu_clkflg) {
 			clk_register(*clkp);
+			omap2_init_clk_clkdm(*clkp);
+		}
 	}
 
 	/* REVISIT: Not yet ready for OMAP3 */
Index: linux-omap/arch/arm/mach-omap2/clock34xx.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock34xx.h	2008-04-10 08:41:46.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock34xx.h	2008-04-10 09:53:22.000000000 -0600
@@ -485,7 +485,7 @@
 };
 
 static const struct clksel core_ck_clksel[] = {
-	{ .parent = &sys_ck,      .rates = dpll_bypass_rates },
+	{ .parent = &sys_ck,	  .rates = dpll_bypass_rates },
 	{ .parent = &dpll3_m2_ck, .rates = dpll_locked_rates },
 	{ .parent = NULL }
 };
@@ -502,7 +502,7 @@
 };
 
 static const struct clksel dpll3_m2x2_ck_clksel[] = {
-	{ .parent = &sys_ck,      .rates = dpll_bypass_rates },
+	{ .parent = &sys_ck,	  .rates = dpll_bypass_rates },
 	{ .parent = &dpll3_x2_ck, .rates = dpll_locked_rates },
 	{ .parent = NULL }
 };
@@ -548,7 +548,7 @@
 };
 
 static const struct clksel emu_core_alwon_ck_clksel[] = {
-	{ .parent = &sys_ck,        .rates = dpll_bypass_rates },
+	{ .parent = &sys_ck,	    .rates = dpll_bypass_rates },
 	{ .parent = &dpll3_m3x2_ck, .rates = dpll_locked_rates },
 	{ .parent = NULL }
 };
@@ -642,7 +642,7 @@
 };
 
 static const struct clksel omap_96m_alwon_fck_clksel[] = {
-	{ .parent = &sys_ck,        .rates = dpll_bypass_rates },
+	{ .parent = &sys_ck,	    .rates = dpll_bypass_rates },
 	{ .parent = &dpll4_m2x2_ck, .rates = dpll_locked_rates },
 	{ .parent = NULL }
 };
@@ -668,7 +668,7 @@
 };
 
 static const struct clksel cm_96m_fck_clksel[] = {
-	{ .parent = &sys_ck,        .rates = dpll_bypass_rates },
+	{ .parent = &sys_ck,	    .rates = dpll_bypass_rates },
 	{ .parent = &dpll4_m2x2_ck, .rates = dpll_locked_rates },
 	{ .parent = NULL }
 };
@@ -710,7 +710,7 @@
 };
 
 static const struct clksel virt_omap_54m_fck_clksel[] = {
-	{ .parent = &sys_ck,        .rates = dpll_bypass_rates },
+	{ .parent = &sys_ck,	    .rates = dpll_bypass_rates },
 	{ .parent = &dpll4_m3x2_ck, .rates = dpll_locked_rates },
 	{ .parent = NULL }
 };
@@ -921,7 +921,7 @@
 };
 
 static const struct clksel omap_120m_fck_clksel[] = {
-	{ .parent = &sys_ck,      .rates = dpll_bypass_rates },
+	{ .parent = &sys_ck,	  .rates = dpll_bypass_rates },
 	{ .parent = &dpll5_m2_ck, .rates = dpll_locked_rates },
 	{ .parent = NULL }
 };
@@ -929,13 +929,13 @@
 static struct clk omap_120m_fck = {
 	.name		= "omap_120m_fck",
 	.parent		= &dpll5_m2_ck,
-	.init           = &omap2_init_clksel_parent,
-	.clksel_reg     = OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST2),
-	.clksel_mask    = OMAP3430ES2_ST_PERIPH2_CLK_MASK,
-	.clksel         = omap_120m_fck_clksel,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST2),
+	.clksel_mask	= OMAP3430ES2_ST_PERIPH2_CLK_MASK,
+	.clksel		= omap_120m_fck_clksel,
 	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
-	.recalc         = &omap2_clksel_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 /* CM EXTERNAL CLOCK OUTPUTS */
@@ -1044,7 +1044,7 @@
  * called 'dpll1_fck'
  */
 static const struct clksel mpu_clksel[] = {
-	{ .parent = &dpll1_fck,     .rates = dpll_bypass_rates },
+	{ .parent = &dpll1_fck,	    .rates = dpll_bypass_rates },
 	{ .parent = &dpll1_x2m2_ck, .rates = dpll_locked_rates },
 	{ .parent = NULL }
 };
@@ -1058,6 +1058,7 @@
 	.clksel		= mpu_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm_name	= "mpu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1085,6 +1086,8 @@
 	.recalc		= &omap2_clksel_recalc,
 };
 
+/* XXX What about neon_clkdm ? */
+
 /*
  * REVISIT: This clock is never specifically defined in the 3430 TRM,
  * although it is referenced - so this is a guess
@@ -1117,7 +1120,7 @@
  */
 
 static const struct clksel iva2_clksel[] = {
-	{ .parent = &dpll2_fck,   .rates = dpll_bypass_rates },
+	{ .parent = &dpll2_fck,	  .rates = dpll_bypass_rates },
 	{ .parent = &dpll2_m2_ck, .rates = dpll_locked_rates },
 	{ .parent = NULL }
 };
@@ -1133,6 +1136,7 @@
 	.clksel_mask	= OMAP3430_ST_IVA2_CLK_MASK,
 	.clksel		= iva2_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.clkdm_name	= "iva2_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1147,6 +1151,7 @@
 	.clksel		= div2_core_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1164,6 +1169,7 @@
 	.clksel		= div2_l3_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 
 };
@@ -1203,33 +1209,40 @@
 	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
 	.clksel		= gfx_l3_clksel,
 	.flags		= CLOCK_IN_OMAP3430ES1 | RATE_PROPAGATES,
+	.clkdm_name	= "gfx_3430es1_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gfx_l3_ick = {
 	.name		= "gfx_l3_ick",
 	.parent		= &l3_ick,
+	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP_EN_GFX_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES1,
+	.clkdm_name	= "gfx_3430es1_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
 static struct clk gfx_cg1_ck = {
 	.name		= "gfx_cg1_ck",
 	.parent		= &gfx_l3_fck, /* REVISIT: correct? */
+	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430ES1_EN_2D_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES1,
+	.clkdm_name	= "gfx_3430es1_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
 static struct clk gfx_cg2_ck = {
 	.name		= "gfx_cg2_ck",
 	.parent		= &gfx_l3_fck, /* REVISIT: correct? */
+	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430ES1_EN_3D_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES1,
+	.clkdm_name	= "gfx_3430es1_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1262,15 +1275,18 @@
 	.clksel_mask	= OMAP3430ES2_CLKSEL_SGX_MASK,
 	.clksel		= sgx_clksel,
 	.flags		= CLOCK_IN_OMAP3430ES2,
+	.clkdm_name	= "sgx_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk sgx_ick = {
 	.name		= "sgx_ick",
 	.parent		= &l3_ick,
+	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430ES2_EN_SGX_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
+	.clkdm_name	= "sgx_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1279,9 +1295,11 @@
 static struct clk d2d_26m_fck = {
 	.name		= "d2d_26m_fck",
 	.parent		= &sys_ck,
+	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430ES1_EN_D2D_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES1,
+	.clkdm_name	= "d2d_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1301,6 +1319,7 @@
 	.clksel_mask	= OMAP3430_CLKSEL_GPT10_MASK,
 	.clksel		= omap343x_gpt_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1314,6 +1333,7 @@
 	.clksel_mask	= OMAP3430_CLKSEL_GPT11_MASK,
 	.clksel		= omap343x_gpt_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1351,6 +1371,7 @@
 	.parent		= &omap_96m_fck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1361,6 +1382,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430ES2_EN_MMC3_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1371,6 +1393,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MMC2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1380,6 +1403,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MSPRO_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1390,6 +1414,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MMC1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1400,16 +1425,18 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
 static struct clk i2c2_fck = {
 	.name		= "i2c_fck",
-	.id 		= 2,
+	.id		= 2,
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1420,6 +1447,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1452,6 +1480,7 @@
 	.clksel_mask	= OMAP2_MCBSP5_CLKS_MASK,
 	.clksel		= mcbsp_15_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1464,6 +1493,7 @@
 	.clksel_mask	= OMAP2_MCBSP1_CLKS_MASK,
 	.clksel		= mcbsp_15_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1474,6 +1504,7 @@
 	.parent		= &omap_48m_fck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1551,6 +1582,7 @@
 	.parent		= &omap_12m_fck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1589,6 +1621,7 @@
 	.clksel_mask	= OMAP3430_CLKSEL_SSI_MASK,
 	.clksel		= ssi_ssr_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1604,11 +1637,17 @@
 
 /* CORE_L3_ICK based clocks */
 
+/*
+ * XXX must add clk_enable/clk_disable for these if standard code won't
+ * handle it
+ */
 static struct clk core_l3_ick = {
 	.name		= "core_l3_ick",
 	.parent		= &l3_ick,
+	.init		= &omap2_init_clk_clkdm,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1618,6 +1657,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_HSOTGUSB_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1627,6 +1667,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_SDRC_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X | ENABLE_ON_INIT,
+	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1635,6 +1676,7 @@
 	.parent		= &core_l3_ick,
 	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK |
 				ENABLE_ON_INIT,
+	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1662,8 +1704,10 @@
 static struct clk core_l4_ick = {
 	.name		= "core_l4_ick",
 	.parent		= &l4_ick,
+	.init		= &omap2_init_clk_clkdm,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1673,6 +1717,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_USBTLL_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1683,6 +1728,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430ES2_EN_MMC3_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1693,6 +1739,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_ICR_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1702,6 +1749,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_AES2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1711,6 +1759,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_SHA12_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1720,6 +1769,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_DES2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1730,6 +1780,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MMC2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1740,6 +1791,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MMC1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1749,6 +1801,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MSPRO_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1758,6 +1811,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_HDQ_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1768,6 +1822,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI4_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1778,6 +1833,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1788,6 +1844,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1798,6 +1855,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1808,6 +1866,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1818,6 +1877,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1828,6 +1888,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1837,6 +1898,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_UART2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1846,6 +1908,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_UART1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1855,6 +1918,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_GPT11_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1864,6 +1928,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_GPT10_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1873,6 +1938,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP5_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1882,6 +1948,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1891,6 +1958,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430ES1_EN_FAC_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES1,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1900,6 +1968,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MAILBOXES_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1909,15 +1978,18 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_OMAPCTRL_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X | ENABLE_ON_INIT,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
 /* SSI_L4_ICK based clocks */
 
+/* XXX should the parent here be core_l4_ick ? TRM figure 4-65 */
 static struct clk ssi_l4_ick = {
 	.name		= "ssi_l4_ick",
 	.parent		= &l4_ick,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1927,6 +1999,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_SSI_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2001,7 +2074,7 @@
 
 /* DSS */
 static const struct clksel dss1_alwon_fck_clksel[] = {
-	{ .parent = &sys_ck,        .rates = dpll_bypass_rates },
+	{ .parent = &sys_ck,	    .rates = dpll_bypass_rates },
 	{ .parent = &dpll4_m4x2_ck, .rates = dpll_locked_rates },
 	{ .parent = NULL }
 };
@@ -2016,33 +2089,40 @@
 	.clksel_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
 	.clksel		= dss1_alwon_fck_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "dss_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk dss_tv_fck = {
 	.name		= "dss_tv_fck",
 	.parent		= &omap_54m_fck,
+	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_TV_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "dss_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
 static struct clk dss_96m_fck = {
 	.name		= "dss_96m_fck",
 	.parent		= &omap_96m_fck,
+	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_TV_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "dss_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
 static struct clk dss2_alwon_fck = {
 	.name		= "dss2_alwon_fck",
 	.parent		= &sys_ck,
+	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_DSS2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "dss_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2050,16 +2130,18 @@
 	/* Handles both L3 and L4 clocks */
 	.name		= "dss_ick",
 	.parent		= &l4_ick,
+	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "dss_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
 /* CAM */
 
 static const struct clksel cam_mclk_clksel[] = {
-	{ .parent = &sys_ck,        .rates = dpll_bypass_rates },
+	{ .parent = &sys_ck,	    .rates = dpll_bypass_rates },
 	{ .parent = &dpll4_m5x2_ck, .rates = dpll_locked_rates },
 	{ .parent = NULL }
 };
@@ -2074,24 +2156,29 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_CAM_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "cam_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk cam_l3_ick = {
 	.name		= "cam_l3_ick",
 	.parent		= &l3_ick,
+	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_CAM_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "cam_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
 static struct clk cam_l4_ick = {
 	.name		= "cam_l4_ick",
 	.parent		= &l4_ick,
+	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_CAM_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "cam_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2100,45 +2187,55 @@
 static struct clk usbhost_120m_fck = {
 	.name		= "usbhost_120m_fck",
 	.parent		= &omap_120m_fck,
+	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430ES2_EN_USBHOST2_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
+	.clkdm_name	= "usbhost_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
 static struct clk usbhost_48m_fck = {
 	.name		= "usbhost_48m_fck",
 	.parent		= &omap_48m_fck,
+	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430ES2_EN_USBHOST1_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
+	.clkdm_name	= "usbhost_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
 static struct clk usbhost_l3_ick = {
 	.name		= "usbhost_l3_ick",
 	.parent		= &l3_ick,
+	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430ES2_EN_USBHOST_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
+	.clkdm_name	= "usbhost_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
 static struct clk usbhost_l4_ick = {
 	.name		= "usbhost_l4_ick",
 	.parent		= &l4_ick,
+	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430ES2_EN_USBHOST_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
+	.clkdm_name	= "usbhost_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
 static struct clk usbhost_sar_fck = {
 	.name		= "usbhost_sar_fck",
 	.parent		= &osc_sys_ck,
+	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= OMAP_PRM_REGADDR(OMAP3430ES2_USBHOST_MOD, PM_PWSTCTRL),
 	.enable_bit	= OMAP3430ES2_SAVEANDRESTORE_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
+	.clkdm_name	= "usbhost_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2180,6 +2277,7 @@
 	.recalc		= &omap2_clksel_recalc,
 };
 
+/* XXX should gpt1's clksel have wkup_32k_fck as the 32k opt? */
 static struct clk gpt1_fck = {
 	.name		= "gpt1_fck",
 	.init		= &omap2_init_clksel_parent,
@@ -2189,13 +2287,16 @@
 	.clksel_mask	= OMAP3430_CLKSEL_GPT1_MASK,
 	.clksel		= omap343x_gpt_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk wkup_32k_fck = {
 	.name		= "wkup_32k_fck",
+	.init		= &omap2_init_clk_clkdm,
 	.parent		= &omap_32k_fck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2205,6 +2306,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2214,6 +2316,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_WDT2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2221,6 +2324,7 @@
 	.name		= "wkup_l4_ick",
 	.parent		= &sys_ck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2232,6 +2336,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430ES2_EN_USIMOCP_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2241,6 +2346,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_WDT2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2250,6 +2356,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_WDT1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2259,6 +2366,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2268,15 +2376,18 @@
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_32KSYNC_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
+/* XXX This clock no longer exists in 3430 TRM rev F */
 static struct clk gpt12_ick = {
 	.name		= "gpt12_ick",
 	.parent		= &wkup_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT12_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2286,6 +2397,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2296,16 +2408,20 @@
 static struct clk per_96m_fck = {
 	.name		= "per_96m_fck",
 	.parent		= &omap_96m_alwon_fck,
+	.init		= &omap2_init_clk_clkdm,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
 static struct clk per_48m_fck = {
 	.name		= "per_48m_fck",
 	.parent		= &omap_48m_fck,
+	.init		= &omap2_init_clk_clkdm,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2315,6 +2431,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_UART3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2327,6 +2444,7 @@
 	.clksel_mask	= OMAP3430_CLKSEL_GPT2_MASK,
 	.clksel		= omap343x_gpt_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2339,6 +2457,7 @@
 	.clksel_mask	= OMAP3430_CLKSEL_GPT3_MASK,
 	.clksel		= omap343x_gpt_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2351,6 +2470,7 @@
 	.clksel_mask	= OMAP3430_CLKSEL_GPT4_MASK,
 	.clksel		= omap343x_gpt_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2363,6 +2483,7 @@
 	.clksel_mask	= OMAP3430_CLKSEL_GPT5_MASK,
 	.clksel		= omap343x_gpt_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2375,6 +2496,7 @@
 	.clksel_mask	= OMAP3430_CLKSEL_GPT6_MASK,
 	.clksel		= omap343x_gpt_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2387,6 +2509,7 @@
 	.clksel_mask	= OMAP3430_CLKSEL_GPT7_MASK,
 	.clksel		= omap343x_gpt_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2399,6 +2522,7 @@
 	.clksel_mask	= OMAP3430_CLKSEL_GPT8_MASK,
 	.clksel		= omap343x_gpt_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2411,12 +2535,14 @@
 	.clksel_mask	= OMAP3430_CLKSEL_GPT9_MASK,
 	.clksel		= omap343x_gpt_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk per_32k_alwon_fck = {
 	.name		= "per_32k_alwon_fck",
 	.parent		= &omap_32k_fck,
+	.clkdm_name	= "per_clkdm",
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
 	.recalc		= &followparent_recalc,
 };
@@ -2427,6 +2553,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO6_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2436,6 +2563,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO5_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2445,6 +2573,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO4_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2454,6 +2583,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2463,6 +2593,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2472,6 +2603,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_WDT3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2480,6 +2612,7 @@
 	.parent		= &l4_ick,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2489,6 +2622,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO6_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2498,6 +2632,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO5_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2507,6 +2642,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO4_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2516,6 +2652,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2525,6 +2662,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2534,6 +2672,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_WDT3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2543,6 +2682,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_UART3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2552,6 +2692,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT9_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2561,6 +2702,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT8_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2570,6 +2712,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT7_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2579,6 +2722,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT6_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2588,6 +2732,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT5_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2597,6 +2742,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT4_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2606,6 +2752,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2615,6 +2762,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2624,6 +2772,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2633,6 +2782,7 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2642,12 +2792,13 @@
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP4_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
 static const struct clksel mcbsp_234_clksel[] = {
 	{ .parent = &per_96m_fck, .rates = common_mcbsp_96m_rates },
-	{ .parent = &mcbsp_clks,   .rates = common_mcbsp_mcbsp_rates },
+	{ .parent = &mcbsp_clks,  .rates = common_mcbsp_mcbsp_rates },
 	{ .parent = NULL }
 };
 
@@ -2660,6 +2811,7 @@
 	.clksel_mask	= OMAP2_MCBSP2_CLKS_MASK,
 	.clksel		= mcbsp_234_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2672,6 +2824,7 @@
 	.clksel_mask	= OMAP2_MCBSP3_CLKS_MASK,
 	.clksel		= mcbsp_234_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2684,6 +2837,7 @@
 	.clksel_mask	= OMAP2_MCBSP4_CLKS_MASK,
 	.clksel		= mcbsp_234_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2731,6 +2885,7 @@
 	.clksel_mask	= OMAP3430_MUX_CTRL_MASK,
 	.clksel		= emu_src_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2754,6 +2909,7 @@
 	.clksel_mask	= OMAP3430_CLKSEL_PCLK_MASK,
 	.clksel		= pclk_emu_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2776,6 +2932,7 @@
 	.clksel_mask	= OMAP3430_CLKSEL_PCLKX2_MASK,
 	.clksel		= pclkx2_emu_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2791,6 +2948,7 @@
 	.clksel_mask	= OMAP3430_CLKSEL_ATCLK_MASK,
 	.clksel		= atclk_emu_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2801,6 +2959,7 @@
 	.clksel_mask	= OMAP3430_TRACE_MUX_CTRL_MASK,
 	.clksel		= emu_src_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2823,6 +2982,7 @@
 	.clksel_mask	= OMAP3430_CLKSEL_TRACECLK_MASK,
 	.clksel		= traceclk_clksel,
 	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
+	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2852,11 +3012,13 @@
 	.name		= "sr_l4_ick",
 	.parent		= &l4_ick,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
 /* SECURE_32K_FCK clocks */
 
+/* XXX This clock no longer exists in 3430 TRM rev F */
 static struct clk gpt12_fck = {
 	.name		= "gpt12_fck",
 	.parent		= &secure_32k_fck,
Index: linux-omap/include/asm-arm/arch-omap/clock.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/clock.h	2008-04-10 08:41:46.000000000 -0600
+++ linux-omap/include/asm-arm/arch-omap/clock.h	2008-04-10 09:53:22.000000000 -0600
@@ -15,6 +15,8 @@
 #ifndef __ARCH_ARM_OMAP_CLOCK_H
 #define __ARCH_ARM_OMAP_CLOCK_H
 
+#include <asm/arch/clockdomain.h>
+
 struct module;
 struct clk;
 
@@ -82,6 +84,8 @@
 	u32			clksel_mask;
 	const struct clksel	*clksel;
 	struct dpll_data	*dpll_data;
+	const char              *clkdm_name;
+	struct clockdomain      *clkdm;
 #else
 	__u8			rate_offset;
 	__u8			src_offset;

-- 

