From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/3] OMAP3 clock: 34xx clock: add enable/disable for non-CORE DPLLs
Date: Thu, 03 Apr 2008 19:09:44 -0600
Message-ID: <20080404012634.340035457@pwsan.com>
References: <20080404010941.510844152@pwsan.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49318 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758628AbYDDB2D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Apr 2008 21:28:03 -0400
Content-Disposition: inline; filename=add_3430_noncore_dpll_enable_disable.patch
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch implements enable/disable for non-CORE DPLLs (DPLLs 1, 2,
4, 5) in the OMAP34xx clock framework.

"Enabling" a DPLL in this context means taking the DPLL from off to
lock, off to bypass, or bypass to lock.  If the clock's target rate is
set to the DPLL parent's clock rate, the DPLL will go to bypass.
Otherwise, the DPLL will attempt to lock.  "Disabling" means going
from bypass or lock to off.

Jouni H=C3=B6gander contributed a fix for _omap3_noncore_dpll_lock().to
bypass the DPLL state test when the DPLL is in autoidle mode.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock34xx.c       |  222 +++++++++++++++++++++++++=
++++++++-
 arch/arm/mach-omap2/clock34xx.h       |   58 ++++++--
 arch/arm/mach-omap2/cm-regbits-34xx.h |   14 +-
 include/asm-arm/arch-omap/clock.h     |    3=20
 4 files changed, 269 insertions(+), 28 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock34xx.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap.orig/arch/arm/mach-omap2/clock34xx.c	2008-03-30 16:31:50=
=2E000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock34xx.c	2008-03-30 16:31:51.0000=
00000 -0600
@@ -1,10 +1,11 @@
 /*
  * OMAP3-specific clock framework functions
  *
- * Copyright (C) 2007 Texas Instruments, Inc.
- * Copyright (C) 2007 Nokia Corporation
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2008 Nokia Corporation
  *
  * Written by Paul Walmsley
+ * Testing and integration fixes by Jouni H=C3=B6gander
  *
  * Parts of this code are based on code written by
  * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu
@@ -23,6 +24,7 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/limits.h>
=20
 #include <asm/arch/clock.h>
 #include <asm/arch/sram.h>
@@ -41,8 +43,7 @@
 #define DPLL_AUTOIDLE_DISABLE			0x0
 #define DPLL_AUTOIDLE_LOW_POWER_STOP		0x1
=20
-/* CM_CLKEN_PLL*.EN* bit values */
-#define DPLL_LOCKED		0x7
+#define MAX_DPLL_WAIT_TRIES		1000000
=20
 /**
  * omap3_dpll_recalc - recalculate DPLL rate
@@ -57,6 +58,215 @@
 	propagate_rate(clk);
 }
=20
+/* _omap3_dpll_write_clken - write clken_bits arg to a DPLL's enable b=
its */
+static void _omap3_dpll_write_clken(struct clk *clk, u8 clken_bits)
+{
+	const struct dpll_data *dd;
+
+	dd =3D clk->dpll_data;
+
+	cm_rmw_reg_bits(dd->enable_mask, clken_bits << __ffs(dd->enable_mask)=
,
+			dd->control_reg);
+}
+
+/* _omap3_wait_dpll_status: wait for a DPLL to enter a specific state =
*/
+static int _omap3_wait_dpll_status(struct clk *clk, u8 state)
+{
+	const struct dpll_data *dd;
+	int i =3D 0;
+	int ret =3D -EINVAL;
+	u32 idlest_mask;
+
+	dd =3D clk->dpll_data;
+
+	state <<=3D dd->idlest_bit;
+	idlest_mask =3D 1 << dd->idlest_bit;
+
+	while (((cm_read_reg(dd->idlest_reg) & idlest_mask) !=3D state) &&
+	       i < MAX_DPLL_WAIT_TRIES) {
+		i++;
+		udelay(1);
+	}
+
+	if (i =3D=3D MAX_DPLL_WAIT_TRIES) {
+		printk(KERN_ERR "clock: %s failed transition to '%s'\n",
+		       clk->name, (state) ? "locked" : "bypassed");
+	} else {
+		pr_debug("clock: %s transition to '%s' in %d loops\n",
+			 clk->name, (state) ? "locked" : "bypassed", i);
+
+		ret =3D 0;
+	}
+
+	return ret;
+}
+
+/* Non-CORE DPLL (e.g., DPLLs that do not control SDRC) clock function=
s */
+
+/*
+ * _omap3_noncore_dpll_lock - instruct a DPLL to lock and wait for rea=
diness
+ * @clk: pointer to a DPLL struct clk
+ *
+ * Instructs a non-CORE DPLL to lock.  Waits for the DPLL to report
+ * readiness before returning.  Will save and restore the DPLL's
+ * autoidle state across the enable, per the CDP code.  If the DPLL
+ * locked successfully, return 0; if the DPLL did not lock in the time
+ * allotted, or DPLL3 was passed in, return -EINVAL.
+ */
+static int _omap3_noncore_dpll_lock(struct clk *clk)
+{
+	u8 ai;
+	int r;
+
+	if (clk =3D=3D &dpll3_ck)
+		return -EINVAL;
+
+	pr_debug("clock: locking DPLL %s\n", clk->name);
+
+	ai =3D omap3_dpll_autoidle_read(clk);
+
+	_omap3_dpll_write_clken(clk, DPLL_LOCKED);
+
+	if (ai) {
+		/*
+		 * If no downstream clocks are enabled, CM_IDLEST bit
+		 * may never become active, so don't wait for DPLL to lock.
+		 */
+		r =3D 0;
+		omap3_dpll_allow_idle(clk);
+	} else {
+		r =3D _omap3_wait_dpll_status(clk, 1);
+		omap3_dpll_deny_idle(clk);
+	};
+
+	return r;
+}
+
+/*
+ * omap3_noncore_dpll_bypass - instruct a DPLL to bypass and wait for =
readiness
+ * @clk: pointer to a DPLL struct clk
+ *
+ * Instructs a non-CORE DPLL to enter low-power bypass mode.  In
+ * bypass mode, the DPLL's rate is set equal to its parent clock's
+ * rate.  Waits for the DPLL to report readiness before returning.
+ * Will save and restore the DPLL's autoidle state across the enable,
+ * per the CDP code.  If the DPLL entered bypass mode successfully,
+ * return 0; if the DPLL did not enter bypass in the time allotted, or
+ * DPLL3 was passed in, or the DPLL does not support low-power bypass,
+ * return -EINVAL.
+ */
+static int _omap3_noncore_dpll_bypass(struct clk *clk)
+{
+	int r;
+	u8 ai;
+
+	if (clk =3D=3D &dpll3_ck)
+		return -EINVAL;
+
+	if (!(clk->dpll_data->modes & (1 << DPLL_LOW_POWER_BYPASS)))
+		return -EINVAL;
+
+	pr_debug("clock: configuring DPLL %s for low-power bypass\n",
+		 clk->name);
+
+	ai =3D omap3_dpll_autoidle_read(clk);
+
+	_omap3_dpll_write_clken(clk, DPLL_LOW_POWER_BYPASS);
+
+	r =3D _omap3_wait_dpll_status(clk, 0);
+
+	if (ai)
+		omap3_dpll_allow_idle(clk);
+	else
+		omap3_dpll_deny_idle(clk);
+
+	return r;
+}
+
+/*
+ * _omap3_noncore_dpll_stop - instruct a DPLL to stop
+ * @clk: pointer to a DPLL struct clk
+ *
+ * Instructs a non-CORE DPLL to enter low-power stop. Will save and
+ * restore the DPLL's autoidle state across the stop, per the CDP
+ * code.  If DPLL3 was passed in, or the DPLL does not support
+ * low-power stop, return -EINVAL; otherwise, return 0.
+ */
+static int _omap3_noncore_dpll_stop(struct clk *clk)
+{
+	u8 ai;
+
+	if (clk =3D=3D &dpll3_ck)
+		return -EINVAL;
+
+	if (!(clk->dpll_data->modes & (1 << DPLL_LOW_POWER_STOP)))
+		return -EINVAL;
+
+	pr_debug("clock: stopping DPLL %s\n", clk->name);
+
+	ai =3D omap3_dpll_autoidle_read(clk);
+
+	_omap3_dpll_write_clken(clk, DPLL_LOW_POWER_STOP);
+
+	if (ai)
+		omap3_dpll_allow_idle(clk);
+	else
+		omap3_dpll_deny_idle(clk);
+
+	return 0;
+}
+
+/**
+ * omap3_noncore_dpll_enable - instruct a DPLL to enter bypass or lock=
 mode
+ * @clk: pointer to a DPLL struct clk
+ *
+ * Instructs a non-CORE DPLL to enable, e.g., to enter bypass or lock.
+ * The choice of modes depends on the DPLL's programmed rate: if it is
+ * the same as the DPLL's parent clock, it will enter bypass;
+ * otherwise, it will enter lock.  This code will wait for the DPLL to
+ * indicate readiness before returning, unless the DPLL takes too long
+ * to enter the target state.  Intended to be used as the struct clk's
+ * enable function.  If DPLL3 was passed in, or the DPLL does not
+ * support low-power stop, or if the DPLL took too long to enter
+ * bypass or lock, return -EINVAL; otherwise, return 0.
+ */
+static int omap3_noncore_dpll_enable(struct clk *clk)
+{
+	int r;
+
+	if (clk =3D=3D &dpll3_ck)
+		return -EINVAL;
+
+	if (clk->parent->rate =3D=3D clk_get_rate(clk))
+		r =3D _omap3_noncore_dpll_bypass(clk);
+	else
+		r =3D _omap3_noncore_dpll_lock(clk);
+
+	return r;
+}
+
+/**
+ * omap3_noncore_dpll_enable - instruct a DPLL to enter bypass or lock=
 mode
+ * @clk: pointer to a DPLL struct clk
+ *
+ * Instructs a non-CORE DPLL to enable, e.g., to enter bypass or lock.
+ * The choice of modes depends on the DPLL's programmed rate: if it is
+ * the same as the DPLL's parent clock, it will enter bypass;
+ * otherwise, it will enter lock.  This code will wait for the DPLL to
+ * indicate readiness before returning, unless the DPLL takes too long
+ * to enter the target state.  Intended to be used as the struct clk's
+ * enable function.  If DPLL3 was passed in, or the DPLL does not
+ * support low-power stop, or if the DPLL took too long to enter
+ * bypass or lock, return -EINVAL; otherwise, return 0.
+ */
+static void omap3_noncore_dpll_disable(struct clk *clk)
+{
+	if (clk =3D=3D &dpll3_ck)
+		return;
+
+	_omap3_noncore_dpll_stop(clk);
+}
+
 /**
  * omap3_dpll_autoidle_read - read a DPLL's autoidle bits
  * @clk: struct clk * of the DPLL to read
@@ -130,7 +340,7 @@
 			dd->autoidle_reg);
 }
=20
-
+/* Clock control for DPLL outputs */
=20
 /**
  * omap3_clkoutx2_recalc - recalculate DPLL X2 output virtual clock ra=
te
@@ -168,6 +378,8 @@
 		propagate_rate(clk);
 }
=20
+/* Common clock code */
+
 /*
  * As it is structured now, this will prevent an OMAP2/3 multiboot
  * kernel from compiling.  This will need further attention.
Index: linux-omap/arch/arm/mach-omap2/clock34xx.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap.orig/arch/arm/mach-omap2/clock34xx.h	2008-03-30 16:31:50=
=2E000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock34xx.h	2008-03-30 16:31:51.0000=
00000 -0600
@@ -32,6 +32,8 @@
 static void omap3_dpll_allow_idle(struct clk *clk);
 static void omap3_dpll_deny_idle(struct clk *clk);
 static u32 omap3_dpll_autoidle_read(struct clk *clk);
+static int omap3_noncore_dpll_enable(struct clk *clk);
+static void omap3_noncore_dpll_disable(struct clk *clk);
=20
 /*
  * DPLL1 supplies clock to the MPU.
@@ -41,6 +43,11 @@
  * DPLL5 supplies other peripheral clocks (USBHOST, USIM).
  */
=20
+/* CM_CLKEN_PLL*.EN* bit values - not all are available for every DPLL=
 */
+#define DPLL_LOW_POWER_STOP		0x1
+#define DPLL_LOW_POWER_BYPASS		0x5
+#define DPLL_LOCKED			0x7
+
 /* PRM CLOCKS */
=20
 /* According to timer32k.c, this is a 32768Hz clock, not a 32000Hz clo=
ck. */
@@ -254,11 +261,14 @@
 	.div1_mask	=3D OMAP3430_MPU_DPLL_DIV_MASK,
 	.control_reg	=3D OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKEN_PLL),
 	.enable_mask	=3D OMAP3430_EN_MPU_DPLL_MASK,
+	.modes		=3D (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	.auto_recal_bit	=3D OMAP3430_EN_MPU_DPLL_DRIFTGUARD_SHIFT,
 	.recal_en_bit	=3D OMAP3430_MPU_DPLL_RECAL_EN_SHIFT,
 	.recal_st_bit	=3D OMAP3430_MPU_DPLL_ST_SHIFT,
 	.autoidle_reg	=3D OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_AUTOIDLE_PLL),
 	.autoidle_mask	=3D OMAP3430_AUTO_MPU_DPLL_MASK,
+	.idlest_reg	=3D OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
+	.idlest_bit	=3D OMAP3430_ST_MPU_CLK_SHIFT,
 };
=20
 static struct clk dpll1_ck =3D {
@@ -313,19 +323,24 @@
 	.div1_mask	=3D OMAP3430_IVA2_DPLL_DIV_MASK,
 	.control_reg	=3D OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKEN=
_PLL),
 	.enable_mask	=3D OMAP3430_EN_IVA2_DPLL_MASK,
+	.modes		=3D (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED) |
+				(1 << DPLL_LOW_POWER_BYPASS),
 	.auto_recal_bit	=3D OMAP3430_EN_IVA2_DPLL_DRIFTGUARD_SHIFT,
 	.recal_en_bit	=3D OMAP3430_PRM_IRQENABLE_MPU_IVA2_DPLL_RECAL_EN_SHIFT=
,
 	.recal_st_bit	=3D OMAP3430_PRM_IRQSTATUS_MPU_IVA2_DPLL_ST_SHIFT,
 	.autoidle_reg	=3D OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_AUTO=
IDLE_PLL),
 	.autoidle_mask	=3D OMAP3430_AUTO_IVA2_DPLL_MASK,
-
+	.idlest_reg	=3D OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_IDLEST=
_PLL),
+	.idlest_bit	=3D OMAP3430_ST_IVA2_CLK_SHIFT
 };
=20
 static struct clk dpll2_ck =3D {
 	.name		=3D "dpll2_ck",
 	.parent		=3D &sys_ck,
 	.dpll_data	=3D &dpll2_dd,
-	.flags		=3D CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		=3D CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.enable		=3D &omap3_noncore_dpll_enable,
+	.disable	=3D &omap3_noncore_dpll_disable,
 	.recalc		=3D &omap3_dpll_recalc,
 };
=20
@@ -351,9 +366,11 @@
 	.recalc		=3D &omap2_clksel_recalc,
 };
=20
-/* DPLL3 */
-/* Source clock for all interfaces and for some device fclks */
-/* Type: DPLL */
+/*
+ * DPLL3
+ * Source clock for all interfaces and for some device fclks
+ * REVISIT: Also supports fast relock bypass - not included below
+ */
 static const struct dpll_data dpll3_dd =3D {
 	.mult_div1_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
 	.mult_mask	=3D OMAP3430_CORE_DPLL_MULT_MASK,
@@ -454,7 +471,7 @@
 	.name		=3D "core_ck",
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	=3D OMAP3430_ST_CORE_CLK,
+	.clksel_mask	=3D OMAP3430_ST_CORE_CLK_MASK,
 	.clksel		=3D core_ck_clksel,
 	.flags		=3D CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
@@ -471,7 +488,7 @@
 	.name		=3D "dpll3_m2x2_ck",
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	=3D OMAP3430_ST_CORE_CLK,
+	.clksel_mask	=3D OMAP3430_ST_CORE_CLK_MASK,
 	.clksel		=3D dpll3_m2x2_ck_clksel,
 	.flags		=3D CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
@@ -518,7 +535,7 @@
 	.parent		=3D &dpll3_m3x2_ck,
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	=3D OMAP3430_ST_CORE_CLK,
+	.clksel_mask	=3D OMAP3430_ST_CORE_CLK_MASK,
 	.clksel		=3D emu_core_alwon_ck_clksel,
 	.flags		=3D CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
@@ -534,18 +551,23 @@
 	.div1_mask	=3D OMAP3430_PERIPH_DPLL_DIV_MASK,
 	.control_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_mask	=3D OMAP3430_EN_PERIPH_DPLL_MASK,
+	.modes		=3D (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
 	.auto_recal_bit	=3D OMAP3430_EN_PERIPH_DPLL_DRIFTGUARD_SHIFT,
 	.recal_en_bit	=3D OMAP3430_PERIPH_DPLL_RECAL_EN_SHIFT,
 	.recal_st_bit	=3D OMAP3430_PERIPH_DPLL_ST_SHIFT,
 	.autoidle_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_AUTOIDLE),
 	.autoidle_mask	=3D OMAP3430_AUTO_PERIPH_DPLL_MASK,
+	.idlest_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
+	.idlest_bit	=3D OMAP3430_ST_PERIPH_CLK_SHIFT,
 };
=20
 static struct clk dpll4_ck =3D {
 	.name		=3D "dpll4_ck",
 	.parent		=3D &sys_ck,
 	.dpll_data	=3D &dpll4_dd,
-	.flags		=3D CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.flags		=3D CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.enable		=3D &omap3_noncore_dpll_enable,
+	.disable	=3D &omap3_noncore_dpll_disable,
 	.recalc		=3D &omap3_dpll_recalc,
 };
=20
@@ -601,7 +623,7 @@
 	.parent		=3D &dpll4_m2x2_ck,
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	=3D OMAP3430_ST_PERIPH_CLK,
+	.clksel_mask	=3D OMAP3430_ST_PERIPH_CLK_MASK,
 	.clksel		=3D omap_96m_alwon_fck_clksel,
 	.flags		=3D CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				 PARENT_CONTROLS_CLOCK,
@@ -627,7 +649,7 @@
 	.parent		=3D &dpll4_m2x2_ck,
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	=3D OMAP3430_ST_PERIPH_CLK,
+	.clksel_mask	=3D OMAP3430_ST_PERIPH_CLK_MASK,
 	.clksel		=3D cm_96m_fck_clksel,
 	.flags		=3D CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
@@ -669,7 +691,7 @@
 	.parent		=3D &dpll4_m3x2_ck,
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	=3D OMAP3430_ST_PERIPH_CLK,
+	.clksel_mask	=3D OMAP3430_ST_PERIPH_CLK_MASK,
 	.clksel		=3D virt_omap_54m_fck_clksel,
 	.flags		=3D CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
@@ -827,19 +849,23 @@
 	.div1_mask	=3D OMAP3430ES2_PERIPH2_DPLL_DIV_MASK,
 	.control_reg	=3D OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_CLKEN2),
 	.enable_mask	=3D OMAP3430ES2_EN_PERIPH2_DPLL_MASK,
+	.modes		=3D (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
 	.auto_recal_bit	=3D OMAP3430ES2_EN_PERIPH2_DPLL_DRIFTGUARD_SHIFT,
 	.recal_en_bit	=3D OMAP3430ES2_SND_PERIPH_DPLL_RECAL_EN_SHIFT,
 	.recal_st_bit	=3D OMAP3430ES2_SND_PERIPH_DPLL_ST_SHIFT,
 	.autoidle_reg	=3D OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_AUTOIDLE2_P=
LL),
 	.autoidle_mask	=3D OMAP3430ES2_AUTO_PERIPH2_DPLL_MASK,
+	.idlest_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST2),
+	.idlest_bit	=3D OMAP3430ES2_ST_PERIPH2_CLK_SHIFT,
 };
=20
 static struct clk dpll5_ck =3D {
 	.name		=3D "dpll5_ck",
 	.parent		=3D &sys_ck,
 	.dpll_data	=3D &dpll5_dd,
-	.flags		=3D CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES |
-				ALWAYS_ENABLED,
+	.flags		=3D CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES,
+	.enable		=3D &omap3_noncore_dpll_enable,
+	.disable	=3D &omap3_noncore_dpll_disable,
 	.recalc		=3D &omap3_dpll_recalc,
 };
=20
@@ -1950,7 +1976,7 @@
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
 	.enable_bit	=3D OMAP3430_EN_DSS1_SHIFT,
 	.clksel_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	=3D OMAP3430_ST_PERIPH_CLK,
+	.clksel_mask	=3D OMAP3430_ST_PERIPH_CLK_MASK,
 	.clksel		=3D dss1_alwon_fck_clksel,
 	.flags		=3D CLOCK_IN_OMAP343X,
 	.recalc		=3D &omap2_clksel_recalc,
@@ -2006,7 +2032,7 @@
 	.parent		=3D &dpll4_m5x2_ck,
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	=3D OMAP3430_ST_PERIPH_CLK,
+	.clksel_mask	=3D OMAP3430_ST_PERIPH_CLK_MASK,
 	.clksel		=3D cam_mclk_clksel,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
 	.enable_bit	=3D OMAP3430_EN_CAM_SHIFT,
Index: linux-omap/arch/arm/mach-omap2/cm-regbits-34xx.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap.orig/arch/arm/mach-omap2/cm-regbits-34xx.h	2008-03-30 16=
:31:50.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/cm-regbits-34xx.h	2008-03-30 16:31:5=
1.000000000 -0600
@@ -71,7 +71,8 @@
 #define OMAP3430_ST_IVA2				(1 << 0)
=20
 /* CM_IDLEST_PLL_IVA2 */
-#define OMAP3430_ST_IVA2_CLK				(1 << 0)
+#define OMAP3430_ST_IVA2_CLK_SHIFT			0
+#define OMAP3430_ST_IVA2_CLK_MASK			(1 << 0)
=20
 /* CM_AUTOIDLE_PLL_IVA2 */
 #define OMAP3430_AUTO_IVA2_DPLL_SHIFT			0
@@ -114,10 +115,7 @@
 #define OMAP3430_ST_MPU					(1 << 0)
=20
 /* CM_IDLEST_PLL_MPU */
-#define OMAP3430_ST_MPU_CLK				(1 << 0)
-#define OMAP3430_ST_IVA2_CLK_MASK			(1 << 0)
-
-/* CM_IDLEST_PLL_MPU */
+#define OMAP3430_ST_MPU_CLK_SHIFT			0
 #define OMAP3430_ST_MPU_CLK_MASK			(1 << 0)
=20
 /* CM_AUTOIDLE_PLL_MPU */
@@ -407,8 +405,10 @@
 #define OMAP3430_ST_12M_CLK				(1 << 4)
 #define OMAP3430_ST_48M_CLK				(1 << 3)
 #define OMAP3430_ST_96M_CLK				(1 << 2)
-#define OMAP3430_ST_PERIPH_CLK				(1 << 1)
-#define OMAP3430_ST_CORE_CLK				(1 << 0)
+#define OMAP3430_ST_PERIPH_CLK_SHIFT			1
+#define OMAP3430_ST_PERIPH_CLK_MASK			(1 << 1)
+#define OMAP3430_ST_CORE_CLK_SHIFT			0
+#define OMAP3430_ST_CORE_CLK_MASK			(1 << 0)
=20
 /* CM_IDLEST2_CKGEN */
 #define OMAP3430ES2_ST_120M_CLK_SHIFT			1
Index: linux-omap/include/asm-arm/arch-omap/clock.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap.orig/include/asm-arm/arch-omap/clock.h	2008-03-30 16:31:=
50.000000000 -0600
+++ linux-omap/include/asm-arm/arch-omap/clock.h	2008-03-30 16:31:51.00=
0000000 -0600
@@ -36,6 +36,7 @@
 	u32			mult_mask;
 	u32			div1_mask;
 #  if defined(CONFIG_ARCH_OMAP3)
+	u8			modes;
 	void __iomem		*control_reg;
 	u32			enable_mask;
 	u8			auto_recal_bit;
@@ -43,6 +44,8 @@
 	u8			recal_st_bit;
 	void __iomem		*autoidle_reg;
 	u32			autoidle_mask;
+	void __iomem		*idlest_reg;
+	u8			idlest_bit;
 #  endif
 };
=20

--=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
