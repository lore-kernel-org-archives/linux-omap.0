From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/4] clockdomains: integrate OMAP3 clocks with clockdomain code
Date: Fri, 18 Apr 2008 19:43:59 -0600
Message-ID: <20080419014335.8203.61286.stgit@localhost.localdomain>
References: <20080419014100.8203.31672.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50847 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbYDSBsX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 21:48:23 -0400
In-Reply-To: <20080419014100.8203.31672.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, karthik-dp@ti.com, rnayak@ti.com, igor.stoppa@nokia.com, sakari.poussa@nokia.com, jouni.hogander@nokia.com, r-woodruff2@ti.com, paul@pwsan.com

This patch integrates the OMAP3 clock tree with the clockdomain code.
This patch:

- marks OMAP34xx clocks with their corresponding clockdomain.

- adds code to convert the clockdomain name to a clockdomain pointer in the
  struct clk during clk_register().

- modifies OMAP2 clock usecounting to call into the clockdomain code
  when clocks are enabled or disabled.


Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/clock.c       |   45 ++++++++
 arch/arm/mach-omap2/clock.h       |    1 
 arch/arm/mach-omap2/clock34xx.c   |    4 +
 arch/arm/mach-omap2/clock34xx.h   |  196 ++++++++++++++++++++++++++++++++++---
 include/asm-arm/arch-omap/clock.h |    4 +
 5 files changed, 227 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index a2b91c3..bdf4cad 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
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
@@ -308,6 +334,9 @@ void omap2_clk_disable(struct clk *clk)
 		_omap2_clk_disable(clk);
 		if (likely((u32)clk->parent))
 			omap2_clk_disable(clk->parent);
+		if (clk->clkdm)
+			omap2_clkdm_clk_disable(clk->clkdm, clk);
+
 	}
 }
 
@@ -324,11 +353,19 @@ int omap2_clk_enable(struct clk *clk)
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
 
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 8d97231..8f3d019 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -36,6 +36,7 @@ void omap2_clk_disable_unused(struct clk *clk);
 #endif
 
 void omap2_clksel_recalc(struct clk *clk);
+void omap2_init_clk_clkdm(struct clk *clk);
 void omap2_init_clksel_parent(struct clk *clk);
 u32 omap2_clksel_get_divisor(struct clk *clk);
 u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index cf6b42f..670c945 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -621,8 +621,10 @@ int __init omap2_clk_init(void)
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
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 9ca2cdf..7352349 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -485,7 +485,7 @@ static struct clk dpll3_m2_ck = {
 };
 
 static const struct clksel core_ck_clksel[] = {
-	{ .parent = &sys_ck,      .rates = dpll_bypass_rates },
+	{ .parent = &sys_ck,	  .rates = dpll_bypass_rates },
 	{ .parent = &dpll3_m2_ck, .rates = dpll_locked_rates },
 	{ .parent = NULL }
 };
@@ -502,7 +502,7 @@ static struct clk core_ck = {
 };
 
 static const struct clksel dpll3_m2x2_ck_clksel[] = {
-	{ .parent = &sys_ck,      .rates = dpll_bypass_rates },
+	{ .parent = &sys_ck,	  .rates = dpll_bypass_rates },
 	{ .parent = &dpll3_x2_ck, .rates = dpll_locked_rates },
 	{ .parent = NULL }
 };
@@ -548,7 +548,7 @@ static struct clk dpll3_m3x2_ck = {
 };
 
 static const struct clksel emu_core_alwon_ck_clksel[] = {
-	{ .parent = &sys_ck,        .rates = dpll_bypass_rates },
+	{ .parent = &sys_ck,	    .rates = dpll_bypass_rates },
 	{ .parent = &dpll3_m3x2_ck, .rates = dpll_locked_rates },
 	{ .parent = NULL }
 };
@@ -642,7 +642,7 @@ static struct clk dpll4_m2x2_ck = {
 };
 
 static const struct clksel omap_96m_alwon_fck_clksel[] = {
-	{ .parent = &sys_ck,        .rates = dpll_bypass_rates },
+	{ .parent = &sys_ck,	    .rates = dpll_bypass_rates },
 	{ .parent = &dpll4_m2x2_ck, .rates = dpll_locked_rates },
 	{ .parent = NULL }
 };
@@ -668,7 +668,7 @@ static struct clk omap_96m_fck = {
 };
 
 static const struct clksel cm_96m_fck_clksel[] = {
-	{ .parent = &sys_ck,        .rates = dpll_bypass_rates },
+	{ .parent = &sys_ck,	    .rates = dpll_bypass_rates },
 	{ .parent = &dpll4_m2x2_ck, .rates = dpll_locked_rates },
 	{ .parent = NULL }
 };
@@ -710,7 +710,7 @@ static struct clk dpll4_m3x2_ck = {
 };
 
 static const struct clksel virt_omap_54m_fck_clksel[] = {
-	{ .parent = &sys_ck,        .rates = dpll_bypass_rates },
+	{ .parent = &sys_ck,	    .rates = dpll_bypass_rates },
 	{ .parent = &dpll4_m3x2_ck, .rates = dpll_locked_rates },
 	{ .parent = NULL }
 };
@@ -921,7 +921,7 @@ static struct clk dpll5_m2_ck = {
 };
 
 static const struct clksel omap_120m_fck_clksel[] = {
-	{ .parent = &sys_ck,      .rates = dpll_bypass_rates },
+	{ .parent = &sys_ck,	  .rates = dpll_bypass_rates },
 	{ .parent = &dpll5_m2_ck, .rates = dpll_locked_rates },
 	{ .parent = NULL }
 };
@@ -929,13 +929,13 @@ static const struct clksel omap_120m_fck_clksel[] = {
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
@@ -1044,7 +1044,7 @@ static struct clk dpll1_fck = {
  * called 'dpll1_fck'
  */
 static const struct clksel mpu_clksel[] = {
-	{ .parent = &dpll1_fck,     .rates = dpll_bypass_rates },
+	{ .parent = &dpll1_fck,	    .rates = dpll_bypass_rates },
 	{ .parent = &dpll1_x2m2_ck, .rates = dpll_locked_rates },
 	{ .parent = NULL }
 };
@@ -1058,6 +1058,7 @@ static struct clk mpu_ck = {
 	.clksel		= mpu_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm_name	= "mpu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1085,6 +1086,8 @@ static struct clk arm_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
+/* XXX What about neon_clkdm ? */
+
 /*
  * REVISIT: This clock is never specifically defined in the 3430 TRM,
  * although it is referenced - so this is a guess
@@ -1117,7 +1120,7 @@ static struct clk dpll2_fck = {
  */
 
 static const struct clksel iva2_clksel[] = {
-	{ .parent = &dpll2_fck,   .rates = dpll_bypass_rates },
+	{ .parent = &dpll2_fck,	  .rates = dpll_bypass_rates },
 	{ .parent = &dpll2_m2_ck, .rates = dpll_locked_rates },
 	{ .parent = NULL }
 };
@@ -1133,6 +1136,7 @@ static struct clk iva2_ck = {
 	.clksel_mask	= OMAP3430_ST_IVA2_CLK_MASK,
 	.clksel		= iva2_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.clkdm_name	= "iva2_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1147,6 +1151,7 @@ static struct clk l3_ick = {
 	.clksel		= div2_core_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1164,6 +1169,7 @@ static struct clk l4_ick = {
 	.clksel		= div2_l3_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 
 };
@@ -1203,33 +1209,40 @@ static struct clk gfx_l3_fck = {
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
 
@@ -1262,15 +1275,18 @@ static struct clk sgx_fck = {
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
 
@@ -1279,9 +1295,11 @@ static struct clk sgx_ick = {
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
 
@@ -1301,6 +1319,7 @@ static struct clk gpt10_fck = {
 	.clksel_mask	= OMAP3430_CLKSEL_GPT10_MASK,
 	.clksel		= omap343x_gpt_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1314,6 +1333,7 @@ static struct clk gpt11_fck = {
 	.clksel_mask	= OMAP3430_CLKSEL_GPT11_MASK,
 	.clksel		= omap343x_gpt_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1351,6 +1371,7 @@ static struct clk core_96m_fck = {
 	.parent		= &omap_96m_fck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1361,6 +1382,7 @@ static struct clk mmchs3_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430ES2_EN_MMC3_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1371,6 +1393,7 @@ static struct clk mmchs2_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MMC2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1380,6 +1403,7 @@ static struct clk mspro_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MSPRO_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1390,6 +1414,7 @@ static struct clk mmchs1_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MMC1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1400,16 +1425,18 @@ static struct clk i2c3_fck = {
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
 
@@ -1420,6 +1447,7 @@ static struct clk i2c1_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1452,6 +1480,7 @@ static struct clk mcbsp5_fck = {
 	.clksel_mask	= OMAP2_MCBSP5_CLKS_MASK,
 	.clksel		= mcbsp_15_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1464,6 +1493,7 @@ static struct clk mcbsp1_fck = {
 	.clksel_mask	= OMAP2_MCBSP1_CLKS_MASK,
 	.clksel		= mcbsp_15_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1474,6 +1504,7 @@ static struct clk core_48m_fck = {
 	.parent		= &omap_48m_fck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1551,6 +1582,7 @@ static struct clk core_12m_fck = {
 	.parent		= &omap_12m_fck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1589,6 +1621,7 @@ static struct clk ssi_ssr_fck = {
 	.clksel_mask	= OMAP3430_CLKSEL_SSI_MASK,
 	.clksel		= ssi_ssr_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1604,11 +1637,17 @@ static struct clk ssi_sst_fck = {
 
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
 
@@ -1618,6 +1657,7 @@ static struct clk hsotgusb_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_HSOTGUSB_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1627,6 +1667,7 @@ static struct clk sdrc_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_SDRC_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X | ENABLE_ON_INIT,
+	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1635,6 +1676,7 @@ static struct clk gpmc_fck = {
 	.parent		= &core_l3_ick,
 	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK |
 				ENABLE_ON_INIT,
+	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1662,8 +1704,10 @@ static struct clk pka_ick = {
 static struct clk core_l4_ick = {
 	.name		= "core_l4_ick",
 	.parent		= &l4_ick,
+	.init		= &omap2_init_clk_clkdm,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1673,6 +1717,7 @@ static struct clk usbtll_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_USBTLL_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1683,6 +1728,7 @@ static struct clk mmchs3_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430ES2_EN_MMC3_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1693,6 +1739,7 @@ static struct clk icr_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_ICR_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1702,6 +1749,7 @@ static struct clk aes2_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_AES2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1711,6 +1759,7 @@ static struct clk sha12_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_SHA12_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1720,6 +1769,7 @@ static struct clk des2_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_DES2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1730,6 +1780,7 @@ static struct clk mmchs2_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MMC2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1740,6 +1791,7 @@ static struct clk mmchs1_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MMC1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1749,6 +1801,7 @@ static struct clk mspro_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MSPRO_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1758,6 +1811,7 @@ static struct clk hdq_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_HDQ_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1768,6 +1822,7 @@ static struct clk mcspi4_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI4_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1778,6 +1833,7 @@ static struct clk mcspi3_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1788,6 +1844,7 @@ static struct clk mcspi2_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1798,6 +1855,7 @@ static struct clk mcspi1_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1808,6 +1866,7 @@ static struct clk i2c3_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1818,6 +1877,7 @@ static struct clk i2c2_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1828,6 +1888,7 @@ static struct clk i2c1_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1837,6 +1898,7 @@ static struct clk uart2_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_UART2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1846,6 +1908,7 @@ static struct clk uart1_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_UART1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1855,6 +1918,7 @@ static struct clk gpt11_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_GPT11_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1864,6 +1928,7 @@ static struct clk gpt10_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_GPT10_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1873,6 +1938,7 @@ static struct clk mcbsp5_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP5_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1882,6 +1948,7 @@ static struct clk mcbsp1_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1891,6 +1958,7 @@ static struct clk fac_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430ES1_EN_FAC_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES1,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1900,6 +1968,7 @@ static struct clk mailboxes_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MAILBOXES_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1919,6 +1988,7 @@ static struct clk ssi_l4_ick = {
 	.parent		= &l4_ick,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -1928,6 +1998,7 @@ static struct clk ssi_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_SSI_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2002,7 +2073,7 @@ static struct clk des1_ick = {
 
 /* DSS */
 static const struct clksel dss1_alwon_fck_clksel[] = {
-	{ .parent = &sys_ck,        .rates = dpll_bypass_rates },
+	{ .parent = &sys_ck,	    .rates = dpll_bypass_rates },
 	{ .parent = &dpll4_m4x2_ck, .rates = dpll_locked_rates },
 	{ .parent = NULL }
 };
@@ -2017,33 +2088,40 @@ static struct clk dss1_alwon_fck = {
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
 
@@ -2051,16 +2129,18 @@ static struct clk dss_ick = {
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
@@ -2075,24 +2155,29 @@ static struct clk cam_mclk = {
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
 
@@ -2101,45 +2186,55 @@ static struct clk cam_l4_ick = {
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
 
@@ -2181,6 +2276,7 @@ static struct clk usim_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
+/* XXX should gpt1's clksel have wkup_32k_fck as the 32k opt? */
 static struct clk gpt1_fck = {
 	.name		= "gpt1_fck",
 	.init		= &omap2_init_clksel_parent,
@@ -2190,13 +2286,16 @@ static struct clk gpt1_fck = {
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
 
@@ -2206,6 +2305,7 @@ static struct clk gpio1_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2215,6 +2315,7 @@ static struct clk wdt2_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_WDT2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2222,6 +2323,7 @@ static struct clk wkup_l4_ick = {
 	.name		= "wkup_l4_ick",
 	.parent		= &sys_ck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2233,6 +2335,7 @@ static struct clk usim_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430ES2_EN_USIMOCP_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2242,6 +2345,7 @@ static struct clk wdt2_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_WDT2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2251,6 +2355,7 @@ static struct clk wdt1_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_WDT1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2260,6 +2365,7 @@ static struct clk gpio1_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2269,15 +2375,18 @@ static struct clk omap_32ksync_ick = {
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
 
@@ -2287,6 +2396,7 @@ static struct clk gpt1_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2297,16 +2407,20 @@ static struct clk gpt1_ick = {
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
 
@@ -2316,6 +2430,7 @@ static struct clk uart3_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_UART3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2328,6 +2443,7 @@ static struct clk gpt2_fck = {
 	.clksel_mask	= OMAP3430_CLKSEL_GPT2_MASK,
 	.clksel		= omap343x_gpt_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2340,6 +2456,7 @@ static struct clk gpt3_fck = {
 	.clksel_mask	= OMAP3430_CLKSEL_GPT3_MASK,
 	.clksel		= omap343x_gpt_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2352,6 +2469,7 @@ static struct clk gpt4_fck = {
 	.clksel_mask	= OMAP3430_CLKSEL_GPT4_MASK,
 	.clksel		= omap343x_gpt_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2364,6 +2482,7 @@ static struct clk gpt5_fck = {
 	.clksel_mask	= OMAP3430_CLKSEL_GPT5_MASK,
 	.clksel		= omap343x_gpt_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2376,6 +2495,7 @@ static struct clk gpt6_fck = {
 	.clksel_mask	= OMAP3430_CLKSEL_GPT6_MASK,
 	.clksel		= omap343x_gpt_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2388,6 +2508,7 @@ static struct clk gpt7_fck = {
 	.clksel_mask	= OMAP3430_CLKSEL_GPT7_MASK,
 	.clksel		= omap343x_gpt_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2400,6 +2521,7 @@ static struct clk gpt8_fck = {
 	.clksel_mask	= OMAP3430_CLKSEL_GPT8_MASK,
 	.clksel		= omap343x_gpt_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2412,12 +2534,14 @@ static struct clk gpt9_fck = {
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
@@ -2428,6 +2552,7 @@ static struct clk gpio6_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO6_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2437,6 +2562,7 @@ static struct clk gpio5_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO5_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2446,6 +2572,7 @@ static struct clk gpio4_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO4_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2455,6 +2582,7 @@ static struct clk gpio3_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2464,6 +2592,7 @@ static struct clk gpio2_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2473,6 +2602,7 @@ static struct clk wdt3_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_WDT3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2481,6 +2611,7 @@ static struct clk per_l4_ick = {
 	.parent		= &l4_ick,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2490,6 +2621,7 @@ static struct clk gpio6_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO6_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2499,6 +2631,7 @@ static struct clk gpio5_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO5_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2508,6 +2641,7 @@ static struct clk gpio4_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO4_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2517,6 +2651,7 @@ static struct clk gpio3_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2526,6 +2661,7 @@ static struct clk gpio2_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2535,6 +2671,7 @@ static struct clk wdt3_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_WDT3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2544,6 +2681,7 @@ static struct clk uart3_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_UART3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2553,6 +2691,7 @@ static struct clk gpt9_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT9_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2562,6 +2701,7 @@ static struct clk gpt8_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT8_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2571,6 +2711,7 @@ static struct clk gpt7_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT7_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2580,6 +2721,7 @@ static struct clk gpt6_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT6_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2589,6 +2731,7 @@ static struct clk gpt5_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT5_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2598,6 +2741,7 @@ static struct clk gpt4_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT4_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2607,6 +2751,7 @@ static struct clk gpt3_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2616,6 +2761,7 @@ static struct clk gpt2_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2625,6 +2771,7 @@ static struct clk mcbsp2_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2634,6 +2781,7 @@ static struct clk mcbsp3_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2643,12 +2791,13 @@ static struct clk mcbsp4_ick = {
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
 
@@ -2661,6 +2810,7 @@ static struct clk mcbsp2_fck = {
 	.clksel_mask	= OMAP2_MCBSP2_CLKS_MASK,
 	.clksel		= mcbsp_234_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2673,6 +2823,7 @@ static struct clk mcbsp3_fck = {
 	.clksel_mask	= OMAP2_MCBSP3_CLKS_MASK,
 	.clksel		= mcbsp_234_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2685,6 +2836,7 @@ static struct clk mcbsp4_fck = {
 	.clksel_mask	= OMAP2_MCBSP4_CLKS_MASK,
 	.clksel		= mcbsp_234_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm_name	= "per_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2732,6 +2884,7 @@ static struct clk emu_src_ck = {
 	.clksel_mask	= OMAP3430_MUX_CTRL_MASK,
 	.clksel		= emu_src_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2755,6 +2908,7 @@ static struct clk pclk_fck = {
 	.clksel_mask	= OMAP3430_CLKSEL_PCLK_MASK,
 	.clksel		= pclk_emu_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2777,6 +2931,7 @@ static struct clk pclkx2_fck = {
 	.clksel_mask	= OMAP3430_CLKSEL_PCLKX2_MASK,
 	.clksel		= pclkx2_emu_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2792,6 +2947,7 @@ static struct clk atclk_fck = {
 	.clksel_mask	= OMAP3430_CLKSEL_ATCLK_MASK,
 	.clksel		= atclk_emu_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2802,6 +2958,7 @@ static struct clk traceclk_src_fck = {
 	.clksel_mask	= OMAP3430_TRACE_MUX_CTRL_MASK,
 	.clksel		= emu_src_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2824,6 +2981,7 @@ static struct clk traceclk_fck = {
 	.clksel_mask	= OMAP3430_CLKSEL_TRACECLK_MASK,
 	.clksel		= traceclk_clksel,
 	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
+	.clkdm_name	= "emu_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2853,11 +3011,13 @@ static struct clk sr_l4_ick = {
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
diff --git a/include/asm-arm/arch-omap/clock.h b/include/asm-arm/arch-omap/clock.h
index cce55ba..ec8e067 100644
--- a/include/asm-arm/arch-omap/clock.h
+++ b/include/asm-arm/arch-omap/clock.h
@@ -15,6 +15,8 @@
 #ifndef __ARCH_ARM_OMAP_CLOCK_H
 #define __ARCH_ARM_OMAP_CLOCK_H
 
+#include <asm/arch/clockdomain.h>
+
 struct module;
 struct clk;
 
@@ -82,6 +84,8 @@ struct clk {
 	u32			clksel_mask;
 	const struct clksel	*clksel;
 	struct dpll_data	*dpll_data;
+	const char              *clkdm_name;
+	struct clockdomain      *clkdm;
 #else
 	__u8			rate_offset;
 	__u8			src_offset;


