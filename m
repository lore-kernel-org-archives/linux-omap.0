From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/12] ARM: OMAP2: Clock: Add OMAP3 DPLL autoidle functions
Date: Fri,  6 Jun 2008 18:35:06 -0700
Message-ID: <1212802517-17885-2-git-send-email-tony@atomide.com>
References: omap2-clocks-2008-06-06-183514
 <1212802517-17885-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:57192 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690AbYFGBfW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 21:35:22 -0400
In-Reply-To: <1212802517-17885-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

=46rom: Paul Walmsley <paul@pwsan.com>

This patch adds support for DPLL autoidle control to the OMAP3 clock
framework.  These functions will be used by the noncore DPLL enable
and disable code - this is because, according to the CDP code, the
DPLL autoidle status must be saved and restored across DPLL
lock/bypass/off transitions.

N.B.: the CORE DPLL (DPLL3) has three autoidle mode options, rather
than just two.  This code currently does not support the third option,
low-power bypass autoidle.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/cloc=
k34xx.c
index b42bdd6..4263099 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
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
@@ -37,8 +39,11 @@
 #include "cm.h"
 #include "cm-regbits-34xx.h"
=20
-/* CM_CLKEN_PLL*.EN* bit values */
-#define DPLL_LOCKED		0x7
+/* CM_AUTOIDLE_PLL*.AUTO_* bit values */
+#define DPLL_AUTOIDLE_DISABLE			0x0
+#define DPLL_AUTOIDLE_LOW_POWER_STOP		0x1
+
+#define MAX_DPLL_WAIT_TRIES		1000000
=20
 /**
  * omap3_dpll_recalc - recalculate DPLL rate
@@ -53,6 +58,290 @@ static void omap3_dpll_recalc(struct clk *clk)
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
+/**
+ * omap3_dpll_autoidle_read - read a DPLL's autoidle bits
+ * @clk: struct clk * of the DPLL to read
+ *
+ * Return the DPLL's autoidle bits, shifted down to bit 0.  Returns
+ * -EINVAL if passed a null pointer or if the struct clk does not
+ * appear to refer to a DPLL.
+ */
+static u32 omap3_dpll_autoidle_read(struct clk *clk)
+{
+	const struct dpll_data *dd;
+	u32 v;
+
+	if (!clk || !clk->dpll_data)
+		return -EINVAL;
+
+	dd =3D clk->dpll_data;
+
+	v =3D cm_read_reg(dd->autoidle_reg);
+	v &=3D dd->autoidle_mask;
+	v >>=3D __ffs(dd->autoidle_mask);
+
+	return v;
+}
+
+/**
+ * omap3_dpll_allow_idle - enable DPLL autoidle bits
+ * @clk: struct clk * of the DPLL to operate on
+ *
+ * Enable DPLL automatic idle control.  This automatic idle mode
+ * switching takes effect only when the DPLL is locked, at least on
+ * OMAP3430.  The DPLL will enter low-power stop when its downstream
+ * clocks are gated.  No return value.
+ */
+static void omap3_dpll_allow_idle(struct clk *clk)
+{
+	const struct dpll_data *dd;
+
+	if (!clk || !clk->dpll_data)
+		return;
+
+	dd =3D clk->dpll_data;
+
+	/*
+	 * REVISIT: CORE DPLL can optionally enter low-power bypass
+	 * by writing 0x5 instead of 0x1.  Add some mechanism to
+	 * optionally enter this mode.
+	 */
+	cm_rmw_reg_bits(dd->autoidle_mask,
+			DPLL_AUTOIDLE_LOW_POWER_STOP << __ffs(dd->autoidle_mask),
+			dd->autoidle_reg);
+}
+
+/**
+ * omap3_dpll_deny_idle - prevent DPLL from automatically idling
+ * @clk: struct clk * of the DPLL to operate on
+ *
+ * Disable DPLL automatic idle control.  No return value.
+ */
+static void omap3_dpll_deny_idle(struct clk *clk)
+{
+	const struct dpll_data *dd;
+
+	if (!clk || !clk->dpll_data)
+		return;
+
+	dd =3D clk->dpll_data;
+
+	cm_rmw_reg_bits(dd->autoidle_mask,
+			DPLL_AUTOIDLE_DISABLE << __ffs(dd->autoidle_mask),
+			dd->autoidle_reg);
+}
+
+/* Clock control for DPLL outputs */
+
 /**
  * omap3_clkoutx2_recalc - recalculate DPLL X2 output virtual clock ra=
te
  * @clk: DPLL output struct clk
@@ -89,6 +378,8 @@ static void omap3_clkoutx2_recalc(struct clk *clk)
 		propagate_rate(clk);
 }
=20
+/* Common clock code */
+
 /*
  * As it is structured now, this will prevent an OMAP2/3 multiboot
  * kernel from compiling.  This will need further attention.
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/cloc=
k34xx.h
index 73624dc..e349d48 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1,14 +1,19 @@
 /*
  * OMAP3 clock framework
  *
- * Virtual clocks are introduced as a convenient tools.
- * They are sources for other clocks and not supposed
- * to be requested from drivers directly.
- *
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
  * Copyright (C) 2007-2008 Nokia Corporation
  *
  * Written by Paul Walmsley
+ * With many device clock fixes by Kevin Hilman and Jouni H=C3=B6gande=
r
+ * DPLL bypass clock support added by Roman Tereshonkov
+ *
+ */
+
+/*
+ * Virtual clocks are introduced as convenient tools.
+ * They are sources for other clocks and not supposed
+ * to be requested from drivers directly.
  */
=20
 #ifndef __ARCH_ARM_MACH_OMAP2_CLOCK34XX_H
@@ -24,6 +29,11 @@
=20
 static void omap3_dpll_recalc(struct clk *clk);
 static void omap3_clkoutx2_recalc(struct clk *clk);
+static void omap3_dpll_allow_idle(struct clk *clk);
+static void omap3_dpll_deny_idle(struct clk *clk);
+static u32 omap3_dpll_autoidle_read(struct clk *clk);
+static int omap3_noncore_dpll_enable(struct clk *clk);
+static void omap3_noncore_dpll_disable(struct clk *clk);
=20
 /*
  * DPLL1 supplies clock to the MPU.
@@ -33,6 +43,11 @@ static void omap3_clkoutx2_recalc(struct clk *clk);
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
@@ -246,9 +261,14 @@ static const struct dpll_data dpll1_dd =3D {
 	.div1_mask	=3D OMAP3430_MPU_DPLL_DIV_MASK,
 	.control_reg	=3D OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_CLKEN_PLL),
 	.enable_mask	=3D OMAP3430_EN_MPU_DPLL_MASK,
+	.modes		=3D (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	.auto_recal_bit	=3D OMAP3430_EN_MPU_DPLL_DRIFTGUARD_SHIFT,
 	.recal_en_bit	=3D OMAP3430_MPU_DPLL_RECAL_EN_SHIFT,
 	.recal_st_bit	=3D OMAP3430_MPU_DPLL_ST_SHIFT,
+	.autoidle_reg	=3D OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_AUTOIDLE_PLL),
+	.autoidle_mask	=3D OMAP3430_AUTO_MPU_DPLL_MASK,
+	.idlest_reg	=3D OMAP_CM_REGADDR(MPU_MOD, OMAP3430_CM_IDLEST_PLL),
+	.idlest_bit	=3D OMAP3430_ST_MPU_CLK_SHIFT,
 };
=20
 static struct clk dpll1_ck =3D {
@@ -303,16 +323,24 @@ static const struct dpll_data dpll2_dd =3D {
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
+	.autoidle_reg	=3D OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_AUTO=
IDLE_PLL),
+	.autoidle_mask	=3D OMAP3430_AUTO_IVA2_DPLL_MASK,
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
@@ -338,9 +366,11 @@ static struct clk dpll2_m2_ck =3D {
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
@@ -350,6 +380,8 @@ static const struct dpll_data dpll3_dd =3D {
 	.auto_recal_bit	=3D OMAP3430_EN_CORE_DPLL_DRIFTGUARD_SHIFT,
 	.recal_en_bit	=3D OMAP3430_CORE_DPLL_RECAL_EN_SHIFT,
 	.recal_st_bit	=3D OMAP3430_CORE_DPLL_ST_SHIFT,
+	.autoidle_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_AUTOIDLE),
+	.autoidle_mask	=3D OMAP3430_AUTO_CORE_DPLL_MASK,
 };
=20
 static struct clk dpll3_ck =3D {
@@ -439,7 +471,7 @@ static struct clk core_ck =3D {
 	.name		=3D "core_ck",
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	=3D OMAP3430_ST_CORE_CLK,
+	.clksel_mask	=3D OMAP3430_ST_CORE_CLK_MASK,
 	.clksel		=3D core_ck_clksel,
 	.flags		=3D CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
@@ -456,7 +488,7 @@ static struct clk dpll3_m2x2_ck =3D {
 	.name		=3D "dpll3_m2x2_ck",
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	=3D OMAP3430_ST_CORE_CLK,
+	.clksel_mask	=3D OMAP3430_ST_CORE_CLK_MASK,
 	.clksel		=3D dpll3_m2x2_ck_clksel,
 	.flags		=3D CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
@@ -503,7 +535,7 @@ static struct clk emu_core_alwon_ck =3D {
 	.parent		=3D &dpll3_m3x2_ck,
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	=3D OMAP3430_ST_CORE_CLK,
+	.clksel_mask	=3D OMAP3430_ST_CORE_CLK_MASK,
 	.clksel		=3D emu_core_alwon_ck_clksel,
 	.flags		=3D CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
@@ -519,16 +551,23 @@ static const struct dpll_data dpll4_dd =3D {
 	.div1_mask	=3D OMAP3430_PERIPH_DPLL_DIV_MASK,
 	.control_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_mask	=3D OMAP3430_EN_PERIPH_DPLL_MASK,
+	.modes		=3D (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
 	.auto_recal_bit	=3D OMAP3430_EN_PERIPH_DPLL_DRIFTGUARD_SHIFT,
 	.recal_en_bit	=3D OMAP3430_PERIPH_DPLL_RECAL_EN_SHIFT,
 	.recal_st_bit	=3D OMAP3430_PERIPH_DPLL_ST_SHIFT,
+	.autoidle_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_AUTOIDLE),
+	.autoidle_mask	=3D OMAP3430_AUTO_PERIPH_DPLL_MASK,
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
@@ -584,7 +623,7 @@ static struct clk omap_96m_alwon_fck =3D {
 	.parent		=3D &dpll4_m2x2_ck,
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	=3D OMAP3430_ST_PERIPH_CLK,
+	.clksel_mask	=3D OMAP3430_ST_PERIPH_CLK_MASK,
 	.clksel		=3D omap_96m_alwon_fck_clksel,
 	.flags		=3D CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				 PARENT_CONTROLS_CLOCK,
@@ -610,7 +649,7 @@ static struct clk cm_96m_fck =3D {
 	.parent		=3D &dpll4_m2x2_ck,
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	=3D OMAP3430_ST_PERIPH_CLK,
+	.clksel_mask	=3D OMAP3430_ST_PERIPH_CLK_MASK,
 	.clksel		=3D cm_96m_fck_clksel,
 	.flags		=3D CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
@@ -652,7 +691,7 @@ static struct clk virt_omap_54m_fck =3D {
 	.parent		=3D &dpll4_m3x2_ck,
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	=3D OMAP3430_ST_PERIPH_CLK,
+	.clksel_mask	=3D OMAP3430_ST_PERIPH_CLK_MASK,
 	.clksel		=3D virt_omap_54m_fck_clksel,
 	.flags		=3D CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
@@ -810,17 +849,23 @@ static const struct dpll_data dpll5_dd =3D {
 	.div1_mask	=3D OMAP3430ES2_PERIPH2_DPLL_DIV_MASK,
 	.control_reg	=3D OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_CLKEN2),
 	.enable_mask	=3D OMAP3430ES2_EN_PERIPH2_DPLL_MASK,
+	.modes		=3D (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
 	.auto_recal_bit	=3D OMAP3430ES2_EN_PERIPH2_DPLL_DRIFTGUARD_SHIFT,
 	.recal_en_bit	=3D OMAP3430ES2_SND_PERIPH_DPLL_RECAL_EN_SHIFT,
 	.recal_st_bit	=3D OMAP3430ES2_SND_PERIPH_DPLL_ST_SHIFT,
+	.autoidle_reg	=3D OMAP_CM_REGADDR(PLL_MOD, OMAP3430ES2_CM_AUTOIDLE2_P=
LL),
+	.autoidle_mask	=3D OMAP3430ES2_AUTO_PERIPH2_DPLL_MASK,
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
@@ -1939,7 +1984,7 @@ static struct clk dss1_alwon_fck =3D {
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
 	.enable_bit	=3D OMAP3430_EN_DSS1_SHIFT,
 	.clksel_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	=3D OMAP3430_ST_PERIPH_CLK,
+	.clksel_mask	=3D OMAP3430_ST_PERIPH_CLK_MASK,
 	.clksel		=3D dss1_alwon_fck_clksel,
 	.flags		=3D CLOCK_IN_OMAP343X,
 	.recalc		=3D &omap2_clksel_recalc,
@@ -1995,7 +2040,7 @@ static struct clk cam_mclk =3D {
 	.parent		=3D &dpll4_m5x2_ck,
 	.init		=3D &omap2_init_clksel_parent,
 	.clksel_reg	=3D OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
-	.clksel_mask	=3D OMAP3430_ST_PERIPH_CLK,
+	.clksel_mask	=3D OMAP3430_ST_PERIPH_CLK_MASK,
 	.clksel		=3D cam_mclk_clksel,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
 	.enable_bit	=3D OMAP3430_EN_CAM_SHIFT,
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap=
2/cm-regbits-34xx.h
index 3c38395..ee4c0ca 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -72,7 +72,8 @@
 #define OMAP3430_ST_IVA2				(1 << 0)
=20
 /* CM_IDLEST_PLL_IVA2 */
-#define OMAP3430_ST_IVA2_CLK				(1 << 0)
+#define OMAP3430_ST_IVA2_CLK_SHIFT			0
+#define OMAP3430_ST_IVA2_CLK_MASK			(1 << 0)
=20
 /* CM_AUTOIDLE_PLL_IVA2 */
 #define OMAP3430_AUTO_IVA2_DPLL_SHIFT			0
@@ -115,10 +116,7 @@
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
@@ -408,8 +406,10 @@
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
@@ -423,6 +423,10 @@
 #define OMAP3430_AUTO_CORE_DPLL_SHIFT			0
 #define OMAP3430_AUTO_CORE_DPLL_MASK			(0x7 << 0)
=20
+/* CM_AUTOIDLE2_PLL */
+#define OMAP3430ES2_AUTO_PERIPH2_DPLL_SHIFT		0
+#define OMAP3430ES2_AUTO_PERIPH2_DPLL_MASK		(0x7 << 0)
+
 /* CM_CLKSEL1_PLL */
 /* Note that OMAP3430_CORE_DPLL_CLKOUT_DIV_MASK was (0x3 << 27) on 343=
0ES1 */
 #define OMAP3430_CORE_DPLL_CLKOUT_DIV_SHIFT		27
diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index 1dd873f..87a44c7 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -81,6 +81,7 @@
 #define OMAP3430ES2_CM_FCLKEN3				0x0008
 #define OMAP3430_CM_IDLEST_PLL				CM_IDLEST2
 #define OMAP3430_CM_AUTOIDLE_PLL			CM_AUTOIDLE2
+#define OMAP3430ES2_CM_AUTOIDLE2_PLL			CM_AUTOIDLE2
 #define OMAP3430_CM_CLKSEL1				CM_CLKSEL
 #define OMAP3430_CM_CLKSEL1_PLL				CM_CLKSEL
 #define OMAP3430_CM_CLKSEL2_PLL				CM_CLKSEL2
diff --git a/include/asm-arm/arch-omap/clock.h b/include/asm-arm/arch-o=
map/clock.h
index 8490fbb..22daa5d 100644
--- a/include/asm-arm/arch-omap/clock.h
+++ b/include/asm-arm/arch-omap/clock.h
@@ -34,11 +34,16 @@ struct dpll_data {
 	u32			mult_mask;
 	u32			div1_mask;
 #  if defined(CONFIG_ARCH_OMAP3)
+	u8			modes;
 	void __iomem		*control_reg;
 	u32			enable_mask;
 	u8			auto_recal_bit;
 	u8			recal_en_bit;
 	u8			recal_st_bit;
+	void __iomem		*autoidle_reg;
+	u32			autoidle_mask;
+	void __iomem		*idlest_reg;
+	u8			idlest_bit;
 #  endif
 };
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
