From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 17/17] ARM: OMAP2: New DPLL clock framework
Date: Tue, 18 Mar 2008 16:02:15 +0200
Message-ID: <1205848935-12078-18-git-send-email-tony@atomide.com>
References: omap2-upstream-2008-03-18-160209
	<1205848935-12078-1-git-send-email-tony@atomide.com>
	<1205848935-12078-2-git-send-email-tony@atomide.com>
	<1205848935-12078-3-git-send-email-tony@atomide.com>
	<1205848935-12078-4-git-send-email-tony@atomide.com>
	<1205848935-12078-5-git-send-email-tony@atomide.com>
	<1205848935-12078-6-git-send-email-tony@atomide.com>
	<1205848935-12078-7-git-send-email-tony@atomide.com>
	<1205848935-12078-8-git-send-email-tony@atomide.com>
	<1205848935-12078-9-git-send-email-tony@atomide.com>
	<1205848935-12078-10-git-send-email-tony@atomide.com>
	<1205848935-12078-11-git-send-email-tony@atomide.com>
	<1205848935-12078-12-git-send-email-tony@atomide.com>
	<1205848935-12078-13-git-send-email-tony@atomide.com>
	<1205848935-12078-14-git-send-email-tony@atomide.com>
	<1205848935-12078-15-git-send-email-tony@atomide.com>
	<1205848935-12078-16-git-send-email-tony@atomide.com>
	<1205848935-12078-17-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <1205848935-12078-17-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Roman Tereshonkov <roman.tereshonkov@nokia.com>
List-Id: linux-omap@vger.kernel.org

From: Roman Tereshonkov <roman.tereshonkov@nokia.com>

These changes is the result of the discussion with Paul Walmsley.
His ideas are included into this patch.

Remove DPLL output divider handling from DPLLs and CLKOUTX2 clocks,
and place it into specific DPLL output divider clocks (e.g., dpll3_m2_clk).
omap2_get_dpll_rate() now returns the correct DPLL rate, as represented
by the DPLL's CLKOUT output. Also add MPU and IVA2 subsystem clocks, along
with high-frequency bypass support.

Add support for DPLLs function in locked and bypass clock modes.

Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock.c           |    8 -
 arch/arm/mach-omap2/clock34xx.c       |    4 +-
 arch/arm/mach-omap2/clock34xx.h       |  503 ++++++++++++++++++++++++++-------
 arch/arm/mach-omap2/cm-regbits-34xx.h |    4 +
 include/asm-arm/arch-omap/clock.h     |    2 -
 5 files changed, 410 insertions(+), 111 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 15dd319..f7bddc8 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -115,14 +115,6 @@ u32 omap2_get_dpll_rate(struct clk *clk)
 	dpll_clk = (long long)clk->parent->rate * dpll_mult;
 	do_div(dpll_clk, dpll_div + 1);
 
-	/* 34XX only */
-	if (dd->div2_reg) {
-		dpll = cm_read_reg(dd->div2_reg);
-		dpll_div = dpll & dd->div2_mask;
-		dpll_div >>= mask_to_shift(dd->div2_mask);
-		do_div(dpll_clk, dpll_div + 1);
-	}
-
 	return dpll_clk;
 }
 
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index f05dd2e..19ae852 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -212,10 +212,10 @@ int __init omap2_clk_init(void)
 
 	recalculate_root_clocks();
 
-	printk(KERN_INFO "Clocking rate (Crystal/DPLL/MPU): "
+	printk(KERN_INFO "Clocking rate (Crystal/DPLL/ARM core): "
 	       "%ld.%01ld/%ld/%ld MHz\n",
 	       (osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 100000) % 10,
-	       (core_ck.rate / 1000000), (dpll1_fck.rate / 1000000)) ;
+	       (core_ck.rate / 1000000), (arm_fck.rate / 1000000));
 
 	/*
 	 * Only enable those clocks we will need, let the drivers
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 1d871a8..b0741ba 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1,6 +1,10 @@
 /*
  * OMAP3 clock framework
  *
+ * Virtual clocks are introduced as a convenient tools.
+ * They are sources for other clocks and not supposed
+ * to be requested from drivers directly.
+ *
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
  * Copyright (C) 2007-2008 Nokia Corporation
  *
@@ -203,6 +207,36 @@ static struct clk sys_clkout1 = {
 
 /* CM CLOCKS */
 
+static const struct clksel_rate dpll_bypass_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate dpll_locked_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 }
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
 /* DPLL1 */
 /* MPU clock source */
 /* Type: DPLL */
@@ -210,8 +244,6 @@ static const struct dpll_data dpll1_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL),
 	.mult_mask	= OMAP3430_MPU_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430_MPU_DPLL_DIV_MASK,
-	.div2_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL2_PLL),
-	.div2_mask	= OMAP3430_MPU_DPLL_CLKOUT_DIV_MASK,
 	.control_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKEN_PLL),
 	.enable_mask	= OMAP3430_EN_MPU_DPLL_MASK,
 	.auto_recal_bit	= OMAP3430_EN_MPU_DPLL_DRIFTGUARD_SHIFT,
@@ -228,15 +260,37 @@ static struct clk dpll1_ck = {
 };
 
 /*
- * REVISIT: This clock is never specifically defined in the 3430 TRM,
- * although it is referenced - so this is a guess
+ * This virtual clock provides the CLKOUTX2 output from the DPLL if the
+ * DPLL isn't bypassed.
  */
-static struct clk emu_mpu_alwon_ck = {
-	.name		= "emu_mpu_alwon_ck",
+static struct clk dpll1_x2_ck = {
+	.name		= "dpll1_x2_ck",
 	.parent		= &dpll1_ck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap3_clkoutx2_recalc,
+};
+
+/* On DPLL1, unlike other DPLLs, the divider is downstream from CLKOUTX2 */
+static const struct clksel div16_dpll1_x2m2_clksel[] = {
+	{ .parent = &dpll1_x2_ck, .rates = div16_dpll_rates },
+	{ .parent = NULL }
+};
+
+/*
+ * Does not exist in the TRM - needed to separate the M2 divider from
+ * bypass selection in mpu_ck
+ */
+static struct clk dpll1_x2m2_ck = {
+	.name		= "dpll1_x2m2_ck",
+	.parent		= &dpll1_x2_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKSEL2_PLL),
+	.clksel_mask	= OMAP3430_MPU_DPLL_CLKOUT_DIV_MASK,
+	.clksel		= div16_dpll1_x2m2_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 /* DPLL2 */
@@ -247,8 +301,6 @@ static const struct dpll_data dpll2_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSEL1_PLL),
 	.mult_mask	= OMAP3430_IVA2_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430_IVA2_DPLL_DIV_MASK,
-	.div2_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSEL2_PLL),
-	.div2_mask	= OMAP3430_IVA2_DPLL_CLKOUT_DIV_MASK,
 	.control_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKEN_PLL),
 	.enable_mask	= OMAP3430_EN_IVA2_DPLL_MASK,
 	.auto_recal_bit	= OMAP3430_EN_IVA2_DPLL_DRIFTGUARD_SHIFT,
@@ -264,6 +316,28 @@ static struct clk dpll2_ck = {
 	.recalc		= &omap3_dpll_recalc,
 };
 
+static const struct clksel div16_dpll2_m2x2_clksel[] = {
+	{ .parent = &dpll2_ck, .rates = div16_dpll_rates },
+	{ .parent = NULL }
+};
+
+/*
+ * The TRM is conflicted on whether IVA2 clock comes from DPLL2 CLKOUT
+ * or CLKOUTX2. CLKOUT seems most plausible.
+ */
+static struct clk dpll2_m2_ck = {
+	.name		= "dpll2_m2_ck",
+	.parent		= &dpll2_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD,
+					  OMAP3430_CM_CLKSEL2_PLL),
+	.clksel_mask	= OMAP3430_IVA2_DPLL_CLKOUT_DIV_MASK,
+	.clksel		= div16_dpll2_m2x2_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
+	.recalc		= &omap2_clksel_recalc,
+};
+
 /* DPLL3 */
 /* Source clock for all interfaces and for some device fclks */
 /* Type: DPLL */
@@ -271,8 +345,6 @@ static const struct dpll_data dpll3_dd = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.mult_mask	= OMAP3430_CORE_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430_CORE_DPLL_DIV_MASK,
-	.div2_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
-	.div2_mask	= OMAP3430_CORE_DPLL_CLKOUT_DIV_MASK,
 	.control_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_mask	= OMAP3430_EN_CORE_DPLL_MASK,
 	.auto_recal_bit	= OMAP3430_EN_CORE_DPLL_DRIFTGUARD_SHIFT,
@@ -288,24 +360,16 @@ static struct clk dpll3_ck = {
 	.recalc		= &omap3_dpll_recalc,
 };
 
-static const struct clksel_rate div16_dpll_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 3, .val = 3, .flags = RATE_IN_343X },
-	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
-	{ .div = 5, .val = 5, .flags = RATE_IN_343X },
-	{ .div = 6, .val = 6, .flags = RATE_IN_343X },
-	{ .div = 7, .val = 7, .flags = RATE_IN_343X },
-	{ .div = 8, .val = 8, .flags = RATE_IN_343X },
-	{ .div = 9, .val = 9, .flags = RATE_IN_343X },
-	{ .div = 10, .val = 10, .flags = RATE_IN_343X },
-	{ .div = 11, .val = 11, .flags = RATE_IN_343X },
-	{ .div = 12, .val = 12, .flags = RATE_IN_343X },
-	{ .div = 13, .val = 13, .flags = RATE_IN_343X },
-	{ .div = 14, .val = 14, .flags = RATE_IN_343X },
-	{ .div = 15, .val = 15, .flags = RATE_IN_343X },
-	{ .div = 16, .val = 16, .flags = RATE_IN_343X },
-	{ .div = 0 }
+/*
+ * This virtual clock provides the CLKOUTX2 output from the DPLL if the
+ * DPLL isn't bypassed
+ */
+static struct clk dpll3_x2_ck = {
+	.name		= "dpll3_x2_ck",
+	.parent		= &dpll3_ck,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
+	.recalc		= &omap3_clkoutx2_recalc,
 };
 
 static const struct clksel_rate div31_dpll3_rates[] = {
@@ -349,9 +413,9 @@ static const struct clksel div31_dpll3m2_clksel[] = {
 };
 
 /*
- * REVISIT: Not sure what to do about clksel & these M2 divider clocks.
- * Shouldn't they be changed in SRAM?
- * This should probably remain a 'read-only' clksel clock.
+ * DPLL3 output M2
+ * REVISIT: This DPLL output divider must be changed in SRAM, so until
+ * that code is ready, this should remain a 'read-only' clksel clock.
  */
 static struct clk dpll3_m2_ck = {
 	.name		= "dpll3_m2_ck",
@@ -365,58 +429,85 @@ static struct clk dpll3_m2_ck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
+static const struct clksel core_ck_clksel[] = {
+	{ .parent = &sys_ck,      .rates = dpll_bypass_rates },
+	{ .parent = &dpll3_m2_ck, .rates = dpll_locked_rates },
+	{ .parent = NULL }
+};
+
 static struct clk core_ck = {
 	.name		= "core_ck",
-	.parent		= &dpll3_m2_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
+	.clksel_mask	= OMAP3430_ST_CORE_CLK,
+	.clksel		= core_ck_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
-/*
- * This virtual clock provides the CLKOUTX2 output from the DPLL if the
- * DPLL isn't bypassed
- */
-static struct clk dpll3_x2_ck = {
-	.name		= "dpll3_x2_ck",
-	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
-				PARENT_CONTROLS_CLOCK,
-	.recalc		= &omap3_clkoutx2_recalc,
+static const struct clksel dpll3_m2x2_ck_clksel[] = {
+	{ .parent = &sys_ck,      .rates = dpll_bypass_rates },
+	{ .parent = &dpll3_x2_ck, .rates = dpll_locked_rates },
+	{ .parent = NULL }
 };
 
 static struct clk dpll3_m2x2_ck = {
 	.name		= "dpll3_m2x2_ck",
-	.parent		= &dpll3_x2_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
+	.clksel_mask	= OMAP3430_ST_CORE_CLK,
+	.clksel		= dpll3_m2x2_ck_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+/* The PWRDN bit is apparently only available on 3430ES2 and above */
+static const struct clksel div16_dpll3_clksel[] = {
+	{ .parent = &dpll3_ck, .rates = div16_dpll_rates },
+	{ .parent = NULL }
+};
+
+/* This virtual clock is the source for dpll3_m3x2_ck */
+static struct clk dpll3_m3_ck = {
+	.name		= "dpll3_m3_ck",
+	.parent		= &dpll3_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP3430_DIV_DPLL3_MASK,
+	.clksel		= div16_dpll3_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
 static struct clk dpll3_m3x2_ck = {
 	.name		= "dpll3_m3x2_ck",
-	.parent		= &dpll3_x2_ck,
+	.parent		= &dpll3_m3_ck,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_EMU_CORE_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap3_clkoutx2_recalc,
 };
 
-static const struct clksel div16_dpll3_clksel[] = {
-	{ .parent = &dpll3_x2_ck, .rates = div16_dpll_rates },
+static const struct clksel emu_core_alwon_ck_clksel[] = {
+	{ .parent = &sys_ck,        .rates = dpll_bypass_rates },
+	{ .parent = &dpll3_m3x2_ck, .rates = dpll_locked_rates },
 	{ .parent = NULL }
 };
 
 static struct clk emu_core_alwon_ck = {
 	.name		= "emu_core_alwon_ck",
-	.parent		= &dpll3_x2_ck,
+	.parent		= &dpll3_m3x2_ck,
 	.init		= &omap2_init_clksel_parent,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP3430_DIV_DPLL3_MASK,
-	.clksel		= div16_dpll3_clksel,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
-	.recalc		= &followparent_recalc,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
+	.clksel_mask	= OMAP3430_ST_CORE_CLK,
+	.clksel		= emu_core_alwon_ck_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 /* DPLL4 */
@@ -443,7 +534,8 @@ static struct clk dpll4_ck = {
 
 /*
  * This virtual clock provides the CLKOUTX2 output from the DPLL if the
- * DPLL isn't bypassed
+ * DPLL isn't bypassed --
+ * XXX does this serve any downstream clocks?
  */
 static struct clk dpll4_x2_ck = {
 	.name		= "dpll4_x2_ck",
@@ -454,30 +546,49 @@ static struct clk dpll4_x2_ck = {
 };
 
 static const struct clksel div16_dpll4_clksel[] = {
-	{ .parent = &dpll4_x2_ck, .rates = div16_dpll_rates },
+	{ .parent = &dpll4_ck, .rates = div16_dpll_rates },
 	{ .parent = NULL }
 };
 
+/* This virtual clock is the source for dpll4_m2x2_ck */
+static struct clk dpll4_m2_ck = {
+	.name		= "dpll4_m2_ck",
+	.parent		= &dpll4_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430_CM_CLKSEL3),
+	.clksel_mask	= OMAP3430_DIV_96M_MASK,
+	.clksel		= div16_dpll4_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
+	.recalc		= &omap2_clksel_recalc,
+};
+
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
 static struct clk dpll4_m2x2_ck = {
 	.name		= "dpll4_m2x2_ck",
-	.parent		= &dpll4_x2_ck,
-	.init		= &omap2_init_clksel_parent,
+	.parent		= &dpll4_m2_ck,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_96M_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430_CM_CLKSEL3),
-	.clksel_mask	= OMAP3430_DIV_96M_MASK,
-	.clksel		= div16_dpll4_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
-	.recalc		= &omap2_clksel_recalc,
+	.recalc		= &omap3_clkoutx2_recalc,
+};
+
+static const struct clksel omap_96m_alwon_fck_clksel[] = {
+	{ .parent = &sys_ck,        .rates = dpll_bypass_rates },
+	{ .parent = &dpll4_m2x2_ck, .rates = dpll_locked_rates },
+	{ .parent = NULL }
 };
 
 static struct clk omap_96m_alwon_fck = {
 	.name		= "omap_96m_alwon_fck",
 	.parent		= &dpll4_m2x2_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
+	.clksel_mask	= OMAP3430_ST_PERIPH_CLK,
+	.clksel		= omap_96m_alwon_fck_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				 PARENT_CONTROLS_CLOCK,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk omap_96m_fck = {
@@ -488,25 +599,63 @@ static struct clk omap_96m_fck = {
 	.recalc		= &followparent_recalc,
 };
 
+static const struct clksel cm_96m_fck_clksel[] = {
+	{ .parent = &sys_ck,        .rates = dpll_bypass_rates },
+	{ .parent = &dpll4_m2x2_ck, .rates = dpll_locked_rates },
+	{ .parent = NULL }
+};
+
 static struct clk cm_96m_fck = {
 	.name		= "cm_96m_fck",
 	.parent		= &dpll4_m2x2_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
+	.clksel_mask	= OMAP3430_ST_PERIPH_CLK,
+	.clksel		= cm_96m_fck_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+/* This virtual clock is the source for dpll4_m3x2_ck */
+static struct clk dpll4_m3_ck = {
+	.name		= "dpll4_m3_ck",
+	.parent		= &dpll4_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3430_CLKSEL_TV_MASK,
+	.clksel		= div16_dpll4_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
 static struct clk dpll4_m3x2_ck = {
 	.name		= "dpll4_m3x2_ck",
-	.parent		= &dpll4_x2_ck,
+	.parent		= &dpll4_m3_ck,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_TV_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_TV_MASK,
-	.clksel		= div16_dpll4_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.recalc		= &omap3_clkoutx2_recalc,
+};
+
+static const struct clksel virt_omap_54m_fck_clksel[] = {
+	{ .parent = &sys_ck,        .rates = dpll_bypass_rates },
+	{ .parent = &dpll4_m3x2_ck, .rates = dpll_locked_rates },
+	{ .parent = NULL }
+};
+
+static struct clk virt_omap_54m_fck = {
+	.name		= "virt_omap_54m_fck",
+	.parent		= &dpll4_m3x2_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
+	.clksel_mask	= OMAP3430_ST_PERIPH_CLK,
+	.clksel		= virt_omap_54m_fck_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -521,7 +670,7 @@ static const struct clksel_rate omap_54m_alt_rates[] = {
 };
 
 static const struct clksel omap_54m_clksel[] = {
-	{ .parent = &dpll4_m3x2_ck, .rates = omap_54m_d4m3x2_rates },
+	{ .parent = &virt_omap_54m_fck, .rates = omap_54m_d4m3x2_rates },
 	{ .parent = &sys_altclk,    .rates = omap_54m_alt_rates },
 	{ .parent = NULL }
 };
@@ -573,46 +722,74 @@ static struct clk omap_12m_fck = {
 	.recalc		= &omap2_fixed_divisor_recalc,
 };
 
+/* This virstual clock is the source for dpll4_m4x2_ck */
+static struct clk dpll4_m4_ck = {
+	.name		= "dpll4_m4_ck",
+	.parent		= &dpll4_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3430_CLKSEL_DSS1_MASK,
+	.clksel		= div16_dpll4_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
+	.recalc		= &omap2_clksel_recalc,
+};
+
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
 static struct clk dpll4_m4x2_ck = {
 	.name		= "dpll4_m4x2_ck",
-	.parent		= &dpll4_x2_ck,
-	.init		= &omap2_init_clksel_parent,
+	.parent		= &dpll4_m4_ck,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_CAM_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_DSS1_MASK,
-	.clksel		= div16_dpll4_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.recalc		= &omap3_clkoutx2_recalc,
+};
+
+/* This virtual clock is the source for dpll4_m5x2_ck */
+static struct clk dpll4_m5_ck = {
+	.name		= "dpll4_m5_ck",
+	.parent		= &dpll4_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP3430_CLKSEL_CAM_MASK,
+	.clksel		= div16_dpll4_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_clksel_recalc,
 };
 
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
 static struct clk dpll4_m5x2_ck = {
 	.name		= "dpll4_m5x2_ck",
-	.parent		= &dpll4_x2_ck,
-	.init		= &omap2_init_clksel_parent,
+	.parent		= &dpll4_m5_ck,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_CAM_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_CLKSEL),
-	.clksel_mask	= OMAP3430_CLKSEL_CAM_MASK,
-	.clksel		= div16_dpll4_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
+	.recalc		= &omap3_clkoutx2_recalc,
+};
+
+/* This virtual clock is the source for dpll4_m6x2_ck */
+static struct clk dpll4_m6_ck = {
+	.name		= "dpll4_m6_ck",
+	.parent		= &dpll4_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP3430_DIV_DPLL4_MASK,
+	.clksel		= div16_dpll4_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &omap2_clksel_recalc,
 };
 
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
 static struct clk dpll4_m6x2_ck = {
 	.name		= "dpll4_m6x2_ck",
-	.parent		= &dpll4_x2_ck,
+	.parent		= &dpll4_m6_ck,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP3430_PWRDN_EMU_PERIPH_SHIFT,
-	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
-	.clksel_mask	= OMAP3430_DIV_DPLL4_MASK,
-	.clksel		= div16_dpll4_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | INVERT_ENABLE,
-	.recalc		= &omap2_clksel_recalc,
+	.recalc		= &omap3_clkoutx2_recalc,
 };
 
 static struct clk emu_per_alwon_ck = {
@@ -647,7 +824,7 @@ static struct clk dpll5_ck = {
 	.recalc		= &omap3_dpll_recalc,
 };
 
-static const struct clksel div16_dpll5m2_clksel[] = {
+static const struct clksel div16_dpll5_clksel[] = {
 	{ .parent = &dpll5_ck, .rates = div16_dpll_rates },
 	{ .parent = NULL }
 };
@@ -658,16 +835,27 @@ static struct clk dpll5_m2_ck = {
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_CLKSEL5),
 	.clksel_mask	= OMAP3430ES2_DIV_120M_MASK,
-	.clksel		= div16_dpll5m2_clksel,
+	.clksel		= div16_dpll5_clksel,
 	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES,
 	.recalc		= &omap2_clksel_recalc,
 };
 
+static const struct clksel omap_120m_fck_clksel[] = {
+	{ .parent = &sys_ck,      .rates = dpll_bypass_rates },
+	{ .parent = &dpll5_m2_ck, .rates = dpll_locked_rates },
+	{ .parent = NULL }
+};
+
 static struct clk omap_120m_fck = {
 	.name		= "omap_120m_fck",
 	.parent		= &dpll5_m2_ck,
-	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES,
-	.recalc		= &followparent_recalc,
+	.init           = &omap2_init_clksel_parent,
+	.clksel_reg     = OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST2),
+	.clksel_mask    = OMAP3430_ST_PERIPH2_CLK,
+	.clksel         = omap_120m_fck_clksel,
+	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
+	.recalc         = &omap2_clksel_recalc,
 };
 
 /* CM EXTERNAL CLOCK OUTPUTS */
@@ -753,10 +941,10 @@ static const struct clksel div2_core_clksel[] = {
 	{ .parent = NULL }
 };
 
-/* TRM s. 4.7.7.4 lists the input for these two clocks as CORE_CK,
-   but presuming that is an error, or at least an overgeneralization */
-/* REVISIT: Are these in DPLL power domain or CM power domain?	docs
-   may be inconsistent here? */
+/*
+ * REVISIT: Are these in DPLL power domain or CM power domain? docs
+ * may be inconsistent here?
+ */
 static struct clk dpll1_fck = {
 	.name		= "dpll1_fck",
 	.parent		= &core_ck,
@@ -769,6 +957,66 @@ static struct clk dpll1_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
+/*
+ * MPU clksel:
+ * If DPLL1 is locked, mpu_ck derives from DPLL1; otherwise, mpu_ck
+ * derives from the high-frequency bypass clock originating from DPLL3,
+ * called 'dpll1_fck'
+ */
+static const struct clksel mpu_clksel[] = {
+	{ .parent = &dpll1_fck,     .rates = dpll_bypass_rates },
+	{ .parent = &dpll1_x2m2_ck, .rates = dpll_locked_rates },
+	{ .parent = NULL }
+};
+
+static struct clk mpu_ck = {
+	.name		= "mpu_ck",
+	.parent		= &dpll1_x2m2_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
+	.clksel_mask	= OMAP3430_ST_MPU_CLK_MASK,
+	.clksel		= mpu_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+/* arm_fck is divided by two when DPLL1 locked; otherwise, passthrough mpu_ck */
+static const struct clksel_rate arm_fck_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 2, .val = 1, .flags = RATE_IN_343X },
+	{ .div = 0 },
+};
+
+static const struct clksel arm_fck_clksel[] = {
+	{ .parent = &mpu_ck, .rates = arm_fck_rates },
+	{ .parent = NULL }
+};
+
+static struct clk arm_fck = {
+	.name		= "arm_fck",
+	.parent		= &mpu_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
+	.clksel_mask	= OMAP3430_ST_MPU_CLK_MASK,
+	.clksel		= arm_fck_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+/*
+ * REVISIT: This clock is never specifically defined in the 3430 TRM,
+ * although it is referenced - so this is a guess
+ */
+static struct clk emu_mpu_alwon_ck = {
+	.name		= "emu_mpu_alwon_ck",
+	.parent		= &mpu_ck,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk dpll2_fck = {
 	.name		= "dpll2_fck",
 	.parent		= &core_ck,
@@ -781,6 +1029,32 @@ static struct clk dpll2_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
+/*
+ * IVA2 clksel:
+ * If DPLL2 is locked, iva2_ck derives from DPLL2; otherwise, iva2_ck
+ * derives from the high-frequency bypass clock originating from DPLL3,
+ * called 'dpll2_fck'
+ */
+
+static const struct clksel iva2_clksel[] = {
+	{ .parent = &dpll2_fck,   .rates = dpll_bypass_rates },
+	{ .parent = &dpll2_m2_ck, .rates = dpll_locked_rates },
+	{ .parent = NULL }
+};
+
+static struct clk iva2_ck = {
+	.name		= "iva2_ck",
+	.parent		= &dpll2_m2_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD,
+					  OMAP3430_CM_IDLEST_PLL),
+	.clksel_mask	= OMAP3430_ST_IVA2_CLK_MASK,
+	.clksel		= iva2_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
+	.recalc		= &omap2_clksel_recalc,
+};
+
 /* Common interface clocks */
 
 static struct clk l3_ick = {
@@ -831,7 +1105,7 @@ static struct clk rm_ick = {
 
 /* GFX power domain */
 
-/* GFX clocks are in 3430ES1 only.  3430ES2 and later uses the SGX instead */
+/* GFX clocks are in 3430ES1 only. 3430ES2 and later uses the SGX instead */
 
 static const struct clksel gfx_l3_clksel[] = {
 	{ .parent = &l3_ick, .rates = gfx_l3_rates },
@@ -1644,14 +1918,23 @@ static struct clk des1_ick = {
 };
 
 /* DSS */
+static const struct clksel dss1_alwon_fck_clksel[] = {
+	{ .parent = &sys_ck,        .rates = dpll_bypass_rates },
+	{ .parent = &dpll4_m4x2_ck, .rates = dpll_locked_rates },
+	{ .parent = NULL }
+};
 
 static struct clk dss1_alwon_fck = {
 	.name		= "dss1_alwon_fck",
 	.parent		= &dpll4_m4x2_ck,
+	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_DSS1_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
+	.clksel_mask	= OMAP3430_ST_PERIPH_CLK,
+	.clksel		= dss1_alwon_fck_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk dss_tv_fck = {
@@ -1693,13 +1976,23 @@ static struct clk dss_ick = {
 
 /* CAM */
 
+static const struct clksel cam_mclk_clksel[] = {
+	{ .parent = &sys_ck,        .rates = dpll_bypass_rates },
+	{ .parent = &dpll4_m5x2_ck, .rates = dpll_locked_rates },
+	{ .parent = NULL }
+};
+
 static struct clk cam_mclk = {
 	.name		= "cam_mclk",
 	.parent		= &dpll4_m5x2_ck,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
+	.clksel_mask	= OMAP3430_ST_PERIPH_CLK,
+	.clksel		= cam_mclk_clksel,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_CAM_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk cam_l3_ick = {
@@ -2496,7 +2789,6 @@ static struct clk wdt1_fck = {
 	.recalc		= &followparent_recalc,
 };
 
-
 static struct clk *onchip_34xx_clks[] __initdata = {
 	&omap_32k_fck,
 	&virt_12m_ck,
@@ -2511,13 +2803,16 @@ static struct clk *onchip_34xx_clks[] __initdata = {
 	&mcbsp_clks,
 	&sys_clkout1,
 	&dpll1_ck,
-	&emu_mpu_alwon_ck,
+	&dpll1_x2_ck,
+	&dpll1_x2m2_ck,
 	&dpll2_ck,
+	&dpll2_m2_ck,
 	&dpll3_ck,
 	&core_ck,
 	&dpll3_x2_ck,
 	&dpll3_m2_ck,
 	&dpll3_m2x2_ck,
+	&dpll3_m3_ck,
 	&dpll3_m3x2_ck,
 	&emu_core_alwon_ck,
 	&dpll4_ck,
@@ -2525,13 +2820,19 @@ static struct clk *onchip_34xx_clks[] __initdata = {
 	&omap_96m_alwon_fck,
 	&omap_96m_fck,
 	&cm_96m_fck,
+	&virt_omap_54m_fck,
 	&omap_54m_fck,
 	&omap_48m_fck,
 	&omap_12m_fck,
+	&dpll4_m2_ck,
 	&dpll4_m2x2_ck,
+	&dpll4_m3_ck,
 	&dpll4_m3x2_ck,
+	&dpll4_m4_ck,
 	&dpll4_m4x2_ck,
+	&dpll4_m5_ck,
 	&dpll4_m5x2_ck,
+	&dpll4_m6_ck,
 	&dpll4_m6x2_ck,
 	&emu_per_alwon_ck,
 	&dpll5_ck,
@@ -2541,7 +2842,11 @@ static struct clk *onchip_34xx_clks[] __initdata = {
 	&sys_clkout2,
 	&corex2_fck,
 	&dpll1_fck,
+	&mpu_ck,
+	&arm_fck,
+	&emu_mpu_alwon_ck,
 	&dpll2_fck,
+	&iva2_ck,
 	&l3_ick,
 	&l4_ick,
 	&rm_ick,
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index fcc108d..739488c 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -115,6 +115,10 @@
 
 /* CM_IDLEST_PLL_MPU */
 #define OMAP3430_ST_MPU_CLK				(1 << 0)
+#define OMAP3430_ST_IVA2_CLK_MASK			(1 << 0)
+
+/* CM_IDLEST_PLL_MPU */
+#define OMAP3430_ST_MPU_CLK_MASK			(1 << 0)
 
 /* CM_AUTOIDLE_PLL_MPU */
 #define OMAP3430_AUTO_MPU_DPLL_SHIFT			0
diff --git a/include/asm-arm/arch-omap/clock.h b/include/asm-arm/arch-omap/clock.h
index 0baa79a..57523bd 100644
--- a/include/asm-arm/arch-omap/clock.h
+++ b/include/asm-arm/arch-omap/clock.h
@@ -33,8 +33,6 @@ struct dpll_data {
 	void __iomem		*mult_div1_reg;
 	u32			mult_mask;
 	u32			div1_mask;
-	void __iomem		*div2_reg;
-	u32			div2_mask;
 #  if defined(CONFIG_ARCH_OMAP3)
 	void __iomem		*control_reg;
 	u32			enable_mask;
-- 
1.5.3.6


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
