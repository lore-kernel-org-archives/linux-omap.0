From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH 5/11] Adding OMAP3430 support to mach-omap2
Date: Tue, 29 May 2007 01:21:40 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47FF0E31@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Adding OMAP 3430 support to arch/arm/mach-omap2

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files Changed:
 Kconfig      |   14
 Makefile     |    6
 clock.h      |    1
 clock_34xx.c | 1255 =
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 gpmc.c       |   10
 id.c         |   16
 io.c         |  129 +++++-
 irq.c        |    8
=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -purN linux-omap/arch/arm/mach-omap2/Kconfig =
val_3430_GIT/arch/arm/mach-omap2/Kconfig
--- linux-omap/arch/arm/mach-omap2/Kconfig	2007-04-02 02:29:57.000000000 =
-0500
+++ val_3430_GIT/arch/arm/mach-omap2/Kconfig	2007-05-28 =
12:47:12.000000000 -0500
@@ -5,6 +5,10 @@ config ARCH_OMAP24XX
 	bool "OMAP24xx Based System"
 	depends on ARCH_OMAP2
=20
+config ARCH_OMAP34XX
+	bool "OMAP34xx Based System"
+	depends on ARCH_OMAP3
+
 config ARCH_OMAP2420
 	bool "OMAP2420 support"
 	depends on ARCH_OMAP24XX
@@ -15,8 +19,12 @@ config ARCH_OMAP2430
 	bool "OMAP2430 support"
 	depends on ARCH_OMAP24XX
=20
+config ARCH_OMAP3430
+	bool "OMAP3430 support"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+
 comment "OMAP Board Type"
-	depends on ARCH_OMAP2
+	depends on ARCH_OMAP2 || ARCH_OMAP3
=20
 config MACH_OMAP_GENERIC
 	bool "Generic OMAP board"
@@ -37,6 +45,10 @@ config MACH_OMAP_H4
 	select OMAP_DEBUG_DEVICES
 	select GPIOEXPANDER_OMAP
=20
+
+config MACH_OMAP_3430SDP
+	bool "OMAP 3430 SDP board"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 config MACH_OMAP_H4_TUSB
 	bool "TUSB 6010 EVM board"
 	depends on MACH_OMAP_H4
diff -purN linux-omap/arch/arm/mach-omap2/Makefile =
val_3430_GIT/arch/arm/mach-omap2/Makefile
--- linux-omap/arch/arm/mach-omap2/Makefile	2007-05-16 =
14:32:40.000000000 -0500
+++ val_3430_GIT/arch/arm/mach-omap2/Makefile	2007-05-25 =
23:53:23.000000000 -0500
@@ -3,9 +3,12 @@
 #
=20
 # Common support
-obj-y :=3D irq.o id.o io.o sram-fn.o memory.o prcm.o clock.o mux.o =
devices.o \
+obj-y :=3D irq.o id.o io.o sram-fn.o memory.o prcm.o mux.o devices.o \
 	 serial.o gpmc.o
=20
+obj-$(CONFIG_ARCH_OMAP24XX) +=3D clock.o
+obj-$(CONFIG_ARCH_OMAP34XX) +=3D clock_34xx.o
+
 obj-$(CONFIG_OMAP_MPU_TIMER)		+=3D timer-gp.o
=20
 # Power Management
@@ -23,6 +26,7 @@ obj-$(CONFIG_MACH_OMAP_H4)		+=3D board-h4.
 obj-$(CONFIG_MACH_OMAP_2430SDP)		+=3D board-2430sdp.o \
 					   board-2430sdp-flash.o \
 					   board-2430sdp-usb.o
+obj-$(CONFIG_MACH_OMAP_3430SDP)		+=3D board-3430sdp.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+=3D board-apollon.o \
 					   board-apollon-keys.o
 obj-$(CONFIG_MACH_NOKIA_N800)		+=3D board-n800.o board-n800-flash.o \

diff -purN linux-omap/arch/arm/mach-omap2/clock.h =
val_3430_GIT/arch/arm/mach-omap2/clock.h
--- linux-omap/arch/arm/mach-omap2/clock.h	2007-05-25 15:52:23.000000000 =
-0500
+++ val_3430_GIT/arch/arm/mach-omap2/clock.h	2007-05-28 =
12:47:13.000000000 -0500
@@ -39,6 +39,7 @@ static u32 omap2_clksel_get_divisor(stru
=20
 #define RATE_IN_242X	(1 << 0)
 #define RATE_IN_243X	(1 << 1)
+#define RATE_IN_343X	(1 << 2)
=20
 /* Key dividers which make up a PRCM set. Ratio's for a PRCM are =
mandated.
  * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,CM_CLKSEL_DSP
diff -purN linux-omap/arch/arm/mach-omap2/clock_34xx.c =
val_3430_GIT/arch/arm/mach-omap2/clock_34xx.c
--- linux-omap/arch/arm/mach-omap2/clock_34xx.c	1969-12-31 =
18:00:00.000000000 -0600
+++ val_3430_GIT/arch/arm/mach-omap2/clock_34xx.c	2007-05-28 =
12:47:13.000000000 -0500
@@ -0,0 +1,1255 @@
+/*
+ *  linux/arch/arm/mach-omap2/clock_34xx.c
+ *
+ *  Copyright (C) 2005 Texas Instruments Inc.
+ *  Richard Woodruff <r-woodruff2@ti.com>
+ *  Created for OMAP2.
+ *
+ *  Cleaned up and modified to use omap shared clock framework by
+ *  Tony Lindgren <tony@atomide.com>
+ *
+ *  Based on mach-omap2/clock.c, Copyright (C) 2004 - 2005 Nokia =
corporation
+ *  Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+
+#include <asm/io.h>
+
+#include <asm/arch/clock.h>
+#include <asm/arch/sram.h>
+#include <asm/div64.h>
+
+#include "memory.h"
+#include "clock.h"
+#include "prm.h"
+#include "prm_regbits_34xx.h"
+#include "cm.h"
+#include "cm_regbits_34xx.h"
+#include "sdrc.h"
+
+#undef DEBUG
+
+/* SET_PERFORMANCE_LEVEL PARAMETERS */
+#define PRCM_HALF_SPEED		1
+#define PRCM_FULL_SPEED		2
+
+//#define DOWN_VARIABLE_DPLL 1			/* Experimental */
+
+static struct prcm_config *curr_prcm_set;
+static u32 curr_perf_level =3D PRCM_FULL_SPEED;
+static struct clk *vclk;
+static struct clk *sclk;
+
+/*----------------------------------------------------------------------=
---
+ * Omap2 specific clock functions
+ =
*------------------------------------------------------------------------=
-*/
+
+/* Recalculate SYST_CLK */
+static void omap2_sys_clk_recalc(struct clk * clk)
+{
+#if 0
+	u32 div =3D prm_read_reg(OMAP24XX_PRCM_CLKSRC_CTRL);
+	/* Test if ext clk divided by 1 or 2 */
+	div &=3D (0x3 << OMAP_SYSCLKDIV_SHIFT);
+	div >>=3D clk->rate_offset;
+	clk->rate =3D (clk->parent->rate / div);
+#endif
+	propagate_rate(clk);
+}
+
+/* REVISIT: This must be changed for 3430 */
+static u32 omap2_get_dpll_rate(struct clk * tclk)
+{
+	long long dpll_clk;
+	int dpll_mult, dpll_div, amult;
+	u32 dpll;
+
+	dpll =3D cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
+
+	dpll_mult =3D dpll & OMAP24XX_DPLL_MULT_MASK;
+	dpll_mult >>=3D OMAP24XX_DPLL_MULT_SHIFT;		/* 10 bits */
+	dpll_div =3D dpll & OMAP24XX_DPLL_DIV_MASK;
+	dpll_div >>=3D OMAP24XX_DPLL_DIV_SHIFT;		/* 4 bits */
+	dpll_clk =3D (long long)tclk->parent->rate * dpll_mult;
+	do_div(dpll_clk, dpll_div + 1);
+	amult =3D cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+	amult &=3D OMAP24XX_CORE_CLK_SRC_MASK;
+	dpll_clk *=3D amult;
+
+	return dpll_clk;
+}
+
+static void omap2_followparent_recalc(struct clk *clk)
+{
+	followparent_recalc(clk);
+}
+
+static void omap2_propagate_rate(struct clk * clk)
+{
+	if (!(clk->flags & RATE_FIXED))
+		clk->rate =3D clk->parent->rate;
+
+	propagate_rate(clk);
+}
+
+/* REVISIT: pjw updated this for 3430, needs closer look */
+static void omap2_set_osc_ck(int enable)
+{
+	u32 pcc;
+
+	pcc =3D prm_read_reg(OMAP3430_PRM_CLKSRC_CTRL);
+
+	if (enable)
+		prm_write_reg(pcc & ~OMAP3430_AUTOEXTCLKMODE_MASK,
+				  OMAP3430_PRM_CLKSRC_CTRL);
+	else
+		prm_write_reg(pcc | OMAP3430_AUTOEXTCLKMODE_MASK,
+				  OMAP3430_PRM_CLKSRC_CTRL);
+}
+
+/* Enable an APLL if off */
+/* REVISIT: This will need updating for 3430 */
+static void omap2_clk_fixed_enable(struct clk *clk)
+{
+	u32 cval, i=3D0;
+
+	if (clk->enable_bit =3D=3D PARENT_CONTROLS_CLOCK)	/* Parent will do it =
*/
+		return;
+
+	cval =3D cm_read_mod_reg(PLL_MOD, CM_CLKEN);
+
+	if ((cval & (0x3 << clk->enable_bit)) =3D=3D (0x3 << clk->enable_bit))
+		return;
+
+	cval &=3D ~(0x3 << clk->enable_bit);
+	cval |=3D (0x3 << clk->enable_bit);
+	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
+
+	if (clk =3D=3D &apll96_ck)
+		cval =3D OMAP24XX_ST_96M_APLL;
+	else if (clk =3D=3D &apll54_ck)
+		cval =3D OMAP24XX_ST_54M_CLK;
+
+	/* Wait for lock */
+	while (!(cm_read_mod_reg(PLL_MOD, CM_IDLEST) & cval)) {
+		++i;
+		udelay(1);
+		if (i =3D=3D 100000) {
+			printk(KERN_ERR "Clock %s didn't lock\n", clk->name);
+			break;
+		}
+	}
+}
+
+/* REVISIT: This will need updating for 3430 */
+static void omap2_clk_wait_ready(struct clk *clk)
+{
+	unsigned long reg, other_reg, st_reg;
+	u32 bit;
+	int i;
+
+	reg =3D (unsigned long) clk->enable_reg;
+	if (reg =3D=3D (unsigned long)OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1) ||
+		reg =3D=3D (unsigned long)OMAP_CM_REGADDR(CORE_MOD, =
OMAP24XX_CM_FCLKEN2))
+		other_reg =3D (reg & ~0xf0) | 0x10; /* CM_ICLKEN* */
+	else if (reg =3D=3D (unsigned long)OMAP_CM_REGADDR(CORE_MOD, =
CM_ICLKEN1) ||
+		 reg =3D=3D (unsigned long)OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2))
+		other_reg =3D (reg & ~0xf0) | 0x00; /* CM_FCLKEN* */
+	else
+		return;
+
+	/* No check for DSS or cam clocks */
+	if ((reg & 0x0f) =3D=3D 0) {
+		if (clk->enable_bit <=3D 1 || clk->enable_bit =3D=3D 31)
+			return;
+	}
+
+	/* Check if both functional and interface clocks
+	 * are running. */
+	bit =3D 1 << clk->enable_bit;
+	if (!(cm_read_reg((void __iomem *)other_reg) & bit))
+		return;
+	st_reg =3D (other_reg & ~0xf0) | 0x20; /* CM_IDLEST* */
+	i =3D 0;
+	while (!(cm_read_reg((void __iomem *)st_reg) & bit)) {
+		i++;
+		if (i =3D=3D 100000) {
+			printk(KERN_ERR "Timeout enabling clock %s\n", clk->name);
+			break;
+		}
+	}
+	if (i)
+		pr_debug("Clock %s stable after %d loops\n", clk->name, i);
+}
+
+/* Enables clock without considering parent dependencies or use count
+ * REVISIT: Maybe change this to use clk->enable like on omap1?
+ * REVISIT: This will need fixing for 3430
+ */
+static int _omap2_clk_enable(struct clk * clk)
+{
+	u32 regval32;
+
+	if (clk->flags & ALWAYS_ENABLED)
+		return 0;
+
+	if (unlikely(clk =3D=3D &osc_ck)) {
+		omap2_set_osc_ck(1);
+		return 0;
+	}
+
+	if (unlikely(clk->enable_reg =3D=3D 0)) {
+		printk(KERN_ERR "clock_34xx.c: Enable for %s without enable code\n",
+				clk->name);
+		return 0;
+	}
+
+	if (clk->enable_reg =3D=3D (void __iomem *)OMAP_CM_REGADDR(PLL_MOD, =
CM_CLKEN)) {
+		omap2_clk_fixed_enable(clk);
+		return 0;
+	}
+
+	regval32 =3D cm_read_reg(clk->enable_reg);
+	regval32 |=3D (1 << clk->enable_bit);
+	cm_write_reg(regval32, clk->enable_reg);
+	wmb();
+
+	omap2_clk_wait_ready(clk);
+
+	return 0;
+}
+
+/* Stop APLL */
+/* REVISIT: This will need fixing for 3430 */
+static void omap2_clk_fixed_disable(struct clk *clk)
+{
+	u32 cval;
+
+	if (clk->enable_bit =3D=3D PARENT_CONTROLS_CLOCK)
+		return;		/* let parent off do it */
+
+	cval =3D cm_read_mod_reg(PLL_MOD, CM_CLKEN);
+	cval &=3D ~(0x3 << clk->enable_bit);
+	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
+}
+
+/* Disables clock without considering parent dependencies or use count =
*/
+static void _omap2_clk_disable(struct clk *clk)
+{
+	u32 regval32;
+
+	if (unlikely(clk =3D=3D &osc_ck)) {
+		omap2_set_osc_ck(0);
+		return;
+	}
+
+	if (clk->enable_reg =3D=3D 0)
+		return;
+
+	if (clk->enable_reg =3D=3D (void __iomem *)OMAP_CM_REGADDR(PLL_MOD, =
CM_CLKEN)) {
+		omap2_clk_fixed_disable(clk);
+		return;
+	}
+
+	regval32 =3D cm_read_reg(clk->enable_reg);
+	regval32 &=3D ~(1 << clk->enable_bit);
+	cm_write_reg(regval32, clk->enable_reg);
+	wmb();
+}
+
+static int omap2_clk_enable(struct clk *clk)
+{
+	int ret =3D 0;
+
+	if (clk->usecount++ =3D=3D 0) {
+		if (likely((u32)clk->parent))
+			ret =3D omap2_clk_enable(clk->parent);
+
+		if (unlikely(ret !=3D 0)) {
+			clk->usecount--;
+			return ret;
+		}
+
+		ret =3D _omap2_clk_enable(clk);
+
+		if (unlikely(ret !=3D 0) && clk->parent) {
+			omap2_clk_disable(clk->parent);
+			clk->usecount--;
+		}
+	}
+
+	return ret;
+}
+
+static void omap2_clk_disable(struct clk *clk)
+{
+	if (clk->usecount > 0 && !(--clk->usecount)) {
+		_omap2_clk_disable(clk);
+		if (likely((u32)clk->parent))
+			omap2_clk_disable(clk->parent);
+	}
+}
+
+/*
+ * Uses the current prcm set to tell if a rate is valid.
+ * You can go slower, but not faster within a given rate set.
+ * REVISIT: This will need to be fixed for 3430
+ */
+static u32 omap2_dpll_round_rate(unsigned long target_rate)
+{
+	u32 high, low, core_clk_src;
+
+	core_clk_src =3D cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+	core_clk_src &=3D OMAP24XX_CORE_CLK_SRC_MASK;
+
+	if (core_clk_src =3D=3D 1) {	/* DPLL clockout */
+		high =3D curr_prcm_set->dpll_speed * 2;
+		low =3D curr_prcm_set->dpll_speed;
+	} else {				/* DPLL clockout x 2 */
+		high =3D curr_prcm_set->dpll_speed;
+		low =3D curr_prcm_set->dpll_speed / 2;
+	}
+
+#ifdef DOWN_VARIABLE_DPLL
+	if (target_rate > high)
+		return high;
+	else
+		return target_rate;
+#else
+	if (target_rate > low)
+		return high;
+	else
+		return low;
+#endif
+
+}
+
+/*
+ * Used for clocks that are part of CLKSEL_xyz governed clocks.
+ * REVISIT: Maybe change to use clk->enable() functions like on omap1?
+ * REVISIT: Will need to be fixed for 3430
+ */
+static void omap2_clksel_recalc(struct clk * clk)
+{
+#if 0
+	u32 fixed =3D 0, div =3D 0;
+	u32 clksel1_core;
+
+	if (clk =3D=3D &dpll_ck) {
+		clk->rate =3D omap2_get_dpll_rate(clk);
+		fixed =3D 1;
+		div =3D 0;
+	}
+
+	if (clk =3D=3D &iva1_mpu_int_ifck) {
+		div =3D 2;
+		fixed =3D 1;
+	}
+
+	clksel1_core =3D cm_read_mod_reg(CORE_MOD, CM_CLKSEL1);
+
+	if ((clk =3D=3D &dss1_fck) &&
+		(clksel1_core & OMAP24XX_CLKSEL_DSS1_MASK) =3D=3D 0) {
+		clk->rate =3D sys_ck.rate;
+		return;
+	}
+
+	if (!fixed) {
+		div =3D omap2_clksel_get_divisor(clk);
+		if (div =3D=3D 0)
+			return;
+	}
+
+	if (div !=3D 0) {
+		if (unlikely(clk->rate =3D=3D clk->parent->rate / div))
+			return;
+		clk->rate =3D clk->parent->rate / div;
+	}
+
+#endif
+	if (unlikely(clk->flags & RATE_PROPAGATES))
+		propagate_rate(clk);
+}
+
+/*
+ * Finds best divider value in an array based on the source and target
+ * rates. The divider array must be sorted with smallest divider first.
+ */
+static inline u32 omap2_divider_from_table(u32 size, u32 *div_array,
+						u32 src_rate, u32 tgt_rate)
+{
+	int i, test_rate;
+
+	if (div_array =3D=3D NULL)
+		return ~1;
+
+	for (i=3D0; i < size; i++) {
+		test_rate =3D src_rate / *div_array;
+		if (test_rate <=3D tgt_rate)
+			return *div_array;
+		++div_array;
+	}
+
+	return ~0;	/* No acceptable divider */
+}
+
+/*
+ * Find divisor for the given clock and target rate.
+ *
+ * Note that this will not work for clocks which are part of =
CONFIG_PARTICIPANT,
+ * they are only settable as part of virtual_prcm set.
+ */
+static u32 omap2_clksel_round_rate(struct clk *tclk, u32 target_rate,
+	u32 *new_div)
+{
+	u32 gfx_div[] =3D {2, 3, 4};
+	u32 sysclkout_div[] =3D {1, 2, 4, 8, 16};
+	u32 dss1_div[] =3D {1, 2, 3, 4, 5, 6, 8, 9, 12, 16};
+	u32 vylnq_div[] =3D {1, 2, 3, 4, 6, 8, 9, 12, 16, 18};
+	u32 best_div =3D ~0, asize =3D 0;
+	u32 *div_array =3D NULL;
+
+	switch (tclk->flags & SRC_RATE_SEL_MASK) {
+	case CM_GFX_SEL1:
+		asize =3D 3;
+		div_array =3D gfx_div;
+		break;
+	case CM_PLL_SEL1:
+		return omap2_dpll_round_rate(target_rate);
+	case CM_SYSCLKOUT_SEL1:
+		asize =3D 5;
+		div_array =3D sysclkout_div;
+		break;
+	case CM_CORE_SEL1:
+		if (tclk =3D=3D &dss1_fck) {
+			if (tclk->parent =3D=3D &core_ck) {
+				asize =3D 10;
+				div_array =3D dss1_div;
+			} else {
+				*new_div =3D 0; /* fixed clk */
+				return(tclk->parent->rate);
+			}
+		} else if ((tclk =3D=3D &vlynq_fck) && cpu_is_omap2420()) {
+			if (tclk->parent =3D=3D &core_ck) {
+				asize =3D 10;
+				div_array =3D vylnq_div;
+			} else {
+				*new_div =3D 0; /* fixed clk */
+				return(tclk->parent->rate);
+			}
+		}
+		break;
+	}
+
+	best_div =3D omap2_divider_from_table(asize, div_array,
+	 tclk->parent->rate, target_rate);
+	if (best_div =3D=3D ~0) {
+		*new_div =3D 1;
+		return best_div; /* signal error */
+	}
+
+	*new_div =3D best_div;
+	return (tclk->parent->rate / best_div);
+}
+
+/* Given a clock and a rate apply a clock specific rounding function */
+static long omap2_clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	u32 new_div =3D 0;
+	int valid_rate;
+
+	if (clk->flags & RATE_FIXED)
+		return clk->rate;
+
+	if (clk->flags & RATE_CKCTL) {
+		valid_rate =3D omap2_clksel_round_rate(clk, rate, &new_div);
+		return valid_rate;
+	}
+
+	if (clk->round_rate !=3D 0)
+		return clk->round_rate(clk, rate);
+
+	return clk->rate;
+}
+
+/*
+ * Check the DLL lock state, and return tue if running in unlock mode.
+ * This is needed to compenste for the shifted DLL value in unlock =
mode.
+ */
+static u32 omap2_dll_force_needed(void)
+{
+	/* dlla and dllb are a set */
+	u32 dll_state =3D sdrc_read_reg(SDRC_DLLA_CTRL);
+
+	if ((dll_state & (1 << 2)) =3D=3D (1 << 2))
+		return 1;
+	else
+		return 0;
+}
+
+/* REVISIT: Will need to be fixed for 3430 */
+static u32 omap2_reprogram_sdrc(u32 level, u32 force)
+{
+	u32 slow_dll_ctrl, fast_dll_ctrl, m_type;
+	u32 prev =3D curr_perf_level, flags;
+
+	if ((curr_perf_level =3D=3D level) && !force)
+		return prev;
+
+	m_type =3D omap2_memory_get_type();
+	slow_dll_ctrl =3D omap2_memory_get_slow_dll_ctrl();
+	fast_dll_ctrl =3D omap2_memory_get_fast_dll_ctrl();
+
+	if (level =3D=3D PRCM_HALF_SPEED) {
+		local_irq_save(flags);
+		prm_write_reg(0xffff, OMAP24XX_PRCM_VOLTSETUP);
+		omap2_sram_reprogram_sdrc(PRCM_HALF_SPEED,
+					  slow_dll_ctrl, m_type);
+		curr_perf_level =3D PRCM_HALF_SPEED;
+		local_irq_restore(flags);
+	}
+	if (level =3D=3D PRCM_FULL_SPEED) {
+		local_irq_save(flags);
+		prm_write_reg(0xffff, OMAP24XX_PRCM_VOLTSETUP);
+		omap2_sram_reprogram_sdrc(PRCM_FULL_SPEED,
+					  fast_dll_ctrl, m_type);
+		curr_perf_level =3D PRCM_FULL_SPEED;
+		local_irq_restore(flags);
+	}
+
+	return prev;
+}
+
+/* REVISIT: Will need to be fixed for 3430 */
+static int omap2_reprogram_dpll(struct clk * clk, unsigned long rate)
+{
+	u32 flags, cur_rate, low, mult, div, valid_rate, done_rate;
+	u32 bypass =3D 0;
+	struct prcm_config tmpset;
+	int ret =3D -EINVAL;
+
+	local_irq_save(flags);
+	cur_rate =3D omap2_get_dpll_rate(&dpll_ck);
+	mult =3D cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+	mult &=3D OMAP24XX_CORE_CLK_SRC_MASK;
+
+	if ((rate =3D=3D (cur_rate / 2)) && (mult =3D=3D 2)) {
+		omap2_reprogram_sdrc(PRCM_HALF_SPEED, 1);
+	} else if ((rate =3D=3D (cur_rate * 2)) && (mult =3D=3D 1)) {
+		omap2_reprogram_sdrc(PRCM_FULL_SPEED, 1);
+	} else if (rate !=3D cur_rate) {
+		valid_rate =3D omap2_dpll_round_rate(rate);
+		if (valid_rate !=3D rate)
+			goto dpll_exit;
+
+		if (mult =3D=3D 1)
+			low =3D curr_prcm_set->dpll_speed;
+		else
+			low =3D curr_prcm_set->dpll_speed / 2;
+
+		/* REVISIT: This sets several reserved bits? */
+		tmpset.cm_clksel1_pll	=3D cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
+		tmpset.cm_clksel1_pll &=3D ~(0x3FFF << 8);
+		div =3D ((curr_prcm_set->xtal_speed / 1000000) - 1);
+		tmpset.cm_clksel2_pll	=3D cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+		tmpset.cm_clksel2_pll &=3D ~OMAP24XX_CORE_CLK_SRC_MASK;
+		if (rate > low) {
+			tmpset.cm_clksel2_pll |=3D 0x2;
+			mult =3D ((rate / 2) / 1000000);
+			done_rate =3D PRCM_FULL_SPEED;
+		} else {
+			tmpset.cm_clksel2_pll |=3D 0x1;
+			mult =3D (rate / 1000000);
+			done_rate =3D PRCM_HALF_SPEED;
+		}
+		tmpset.cm_clksel1_pll |=3D (div << OMAP24XX_DPLL_DIV_SHIFT);
+		tmpset.cm_clksel1_pll |=3D (mult << OMAP24XX_DPLL_MULT_SHIFT);
+
+		/* Worst case */
+		tmpset.base_sdrc_rfr =3D V24XX_SDRC_RFR_CTRL_BYPASS;
+
+		if (rate =3D=3D curr_prcm_set->xtal_speed)	/* If asking for 1-1 */
+			bypass =3D 1;
+
+		omap2_reprogram_sdrc(PRCM_FULL_SPEED, 1); /* For init_mem */
+
+		/* Force dll lock mode */
+		omap2_set_prcm(tmpset.cm_clksel1_pll, tmpset.base_sdrc_rfr,
+					bypass);
+
+		/* Errata: ret dll entry state */
+		omap2_init_memory_params(omap2_dll_force_needed());
+		omap2_reprogram_sdrc(done_rate, 0);
+	}
+	omap2_clksel_recalc(&dpll_ck);
+	ret =3D 0;
+
+dpll_exit:
+	local_irq_restore(flags);
+	return(ret);
+}
+
+/* Just return the MPU speed */
+static void omap2_mpu_recalc(struct clk * clk)
+{
+	clk->rate =3D curr_prcm_set->mpu_speed;
+}
+
+/*
+ * Look for a rate equal or less than the target rate given a =
configuration set.
+ *
+ * What's not entirely clear is "which" field represents the key field.
+ * Some might argue L3-DDR, others ARM, others IVA. This code is simple =
and
+ * just uses the ARM rates.
+ */
+static long omap2_round_to_table_rate(struct clk * clk, unsigned long =
rate)
+{
+	struct prcm_config * ptr;
+	long highest_rate;
+
+	if (clk !=3D &virt_prcm_set)
+		return -EINVAL;
+
+	highest_rate =3D -EINVAL;
+
+	for (ptr =3D rate_table; ptr->mpu_speed; ptr++) {
+		if (ptr->xtal_speed !=3D sys_ck.rate)
+			continue;
+
+		highest_rate =3D ptr->mpu_speed;
+
+		/* Can check only after xtal frequency check */
+		if (ptr->mpu_speed <=3D rate)
+			break;
+	}
+	return highest_rate;
+}
+
+/*
+ * omap2_convert_field_to_div() - turn field value into integer divider
+ */
+static u32 omap2_clksel_to_divisor(u32 div_sel, u32 field_val)
+{
+	u32 i;
+	u32 clkout_array[] =3D {1, 2, 4, 8, 16};
+
+	if ((div_sel & SRC_RATE_SEL_MASK) =3D=3D CM_SYSCLKOUT_SEL1) {
+		for (i =3D 0; i < 5; i++) {
+			if (field_val =3D=3D i)
+				return clkout_array[i];
+		}
+		return ~0;
+	} else
+		return field_val;
+}
+
+/*
+ * Returns the CLKSEL divider register value
+ * REVISIT: This should be cleaned up to work nicely with void __iomem =
*
+ * REVISIT: Will need to be fixed for 3430
+ */
+static u32 omap2_get_clksel(u32 *div_sel, u32 *field_mask,
+				struct clk *clk)
+{
+	int ret =3D ~0;
+	u32 reg_val, div_off;
+	void __iomem *div_addr =3D 0;
+	u32 mask =3D ~0;
+
+	div_off =3D clk->rate_offset;
+
+	switch ((*div_sel & SRC_RATE_SEL_MASK)) {
+	case CM_MPU_SEL1:
+		div_addr =3D OMAP_CM_REGADDR(MPU_MOD, CM_CLKSEL);
+		mask =3D OMAP24XX_CLKSEL_MPU_MASK;
+		break;
+	case CM_DSP_SEL1:
+		div_addr =3D OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL);
+		if (cpu_is_omap2420()) {
+			if (div_off =3D=3D OMAP24XX_CLKSEL_DSP_SHIFT)
+				mask =3D OMAP24XX_CLKSEL_DSP_MASK;
+			else if (div_off =3D=3D OMAP2420_CLKSEL_IVA_SHIFT)
+				mask =3D OMAP2420_CLKSEL_IVA_MASK;
+			else if (div_off =3D=3D OMAP24XX_CLKSEL_DSP_IF_SHIFT)
+				mask =3D OMAP24XX_CLKSEL_DSP_IF_MASK;
+		} else if (cpu_is_omap2430()) {
+			if (div_off =3D=3D OMAP24XX_CLKSEL_DSP_SHIFT)
+				mask =3D OMAP24XX_CLKSEL_DSP_MASK;
+			else if (div_off =3D=3D OMAP24XX_CLKSEL_DSP_IF_SHIFT)
+				mask =3D OMAP24XX_CLKSEL_DSP_IF_MASK;
+		}
+		break;
+	case CM_GFX_SEL1:
+		div_addr =3D OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL);
+		if (div_off =3D=3D OMAP_CLKSEL_GFX_SHIFT)
+			mask =3D OMAP_CLKSEL_GFX_MASK;
+		break;
+	case CM_MODEM_SEL1:
+		div_addr =3D OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_CLKSEL);
+		if (div_off =3D=3D OMAP2430_CLKSEL_MDM_SHIFT)
+			mask =3D OMAP2430_CLKSEL_MDM_MASK;
+		break;
+	case CM_SYSCLKOUT_SEL1:
+		div_addr =3D OMAP24XX_PRCM_CLKOUT_CTRL;
+		if (div_off =3D=3D OMAP24XX_CLKOUT_DIV_SHIFT)
+			mask =3D OMAP24XX_CLKOUT_DIV_MASK;
+		else if (div_off =3D=3D OMAP2420_CLKOUT2_DIV_SHIFT)
+			mask =3D OMAP2420_CLKOUT2_DIV_MASK;
+		break;
+	case CM_CORE_SEL1:
+		div_addr =3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1);
+		switch (div_off) {
+		case OMAP24XX_CLKSEL_L3_SHIFT:
+			mask =3D OMAP24XX_CLKSEL_L3_MASK;
+			break;
+		case OMAP24XX_CLKSEL_L4_SHIFT:
+			mask =3D OMAP24XX_CLKSEL_L4_MASK;
+			break;
+		case OMAP24XX_CLKSEL_DSS1_SHIFT:
+			mask =3D OMAP24XX_CLKSEL_DSS1_MASK;
+			break;
+		case OMAP24XX_CLKSEL_DSS2_SHIFT:
+			mask =3D OMAP24XX_CLKSEL_DSS2_MASK;
+			break;
+		case OMAP2420_CLKSEL_VLYNQ_SHIFT:
+			mask =3D OMAP2420_CLKSEL_VLYNQ_MASK;
+			break;
+		case OMAP24XX_CLKSEL_SSI_SHIFT:
+			mask =3D OMAP24XX_CLKSEL_SSI_MASK;
+			break;
+		case OMAP24XX_CLKSEL_USB_SHIFT:
+			mask =3D OMAP24XX_CLKSEL_USB_MASK;
+			break;
+		}
+	}
+
+	*field_mask =3D (mask >> div_off);
+
+	if (unlikely(mask =3D=3D ~0))
+		div_addr =3D 0;
+
+	*div_sel =3D (u32)div_addr;
+
+	if (unlikely(div_addr =3D=3D 0))
+		return ret;
+
+	/* Isolate field */
+	reg_val =3D cm_read_reg(div_addr) & mask;
+
+	/* Normalize back to divider value */
+	reg_val >>=3D div_off;
+
+	return reg_val;
+}
+
+/*
+ * Return divider to be applied to parent clock.
+ * Return 0 on error.
+ */
+static u32 omap2_clksel_get_divisor(struct clk *clk)
+{
+	int ret =3D 0;
+	u32 div, div_sel, div_off, field_mask, field_val;
+
+	/* isolate control register */
+	div_sel =3D (SRC_RATE_SEL_MASK & clk->flags);
+
+	div_off =3D clk->rate_offset;
+	field_val =3D omap2_get_clksel(&div_sel, &field_mask, clk);
+	if (div_sel =3D=3D 0)
+		return ret;
+
+	div_sel =3D (SRC_RATE_SEL_MASK & clk->flags);
+	div =3D omap2_clksel_to_divisor(div_sel, field_val);
+
+	return div;
+}
+
+/* Set the clock rate for a clock source */
+static int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
+
+{
+	int ret =3D -EINVAL;
+	void __iomem * reg;
+	u32 div_sel, div_off, field_mask, field_val, reg_val, validrate;
+	u32 new_div =3D 0;
+
+	if (!(clk->flags & CONFIG_PARTICIPANT) && (clk->flags & RATE_CKCTL)) {
+		if (clk =3D=3D &dpll_ck)
+			return omap2_reprogram_dpll(clk, rate);
+
+		/* Isolate control register */
+		div_sel =3D (SRC_RATE_SEL_MASK & clk->flags);
+		div_off =3D clk->rate_offset;
+
+		validrate =3D omap2_clksel_round_rate(clk, rate, &new_div);
+		if (validrate !=3D rate)
+			return(ret);
+
+		field_val =3D omap2_get_clksel(&div_sel, &field_mask, clk);
+		if (div_sel =3D=3D 0)
+			return ret;
+
+		if (clk->flags & CM_SYSCLKOUT_SEL1) {
+			switch (new_div) {
+			case 16:
+				field_val =3D 4;
+				break;
+			case 8:
+				field_val =3D 3;
+				break;
+			case 4:
+				field_val =3D 2;
+				break;
+			case 2:
+				field_val =3D 1;
+				break;
+			case 1:
+				field_val =3D 0;
+				break;
+			}
+		} else
+			field_val =3D new_div;
+
+		reg =3D (void __iomem *)div_sel;
+
+		reg_val =3D cm_read_reg(reg);
+		reg_val &=3D ~(field_mask << div_off);
+		reg_val |=3D (field_val << div_off);
+		cm_write_reg(reg_val, reg);
+		wmb();
+		clk->rate =3D clk->parent->rate / field_val;
+
+		if (clk->flags & DELAYED_APP) {
+			prm_write_reg(OMAP24XX_VALID_CONFIG,
+					  OMAP24XX_PRCM_CLKCFG_CTRL);
+			wmb();
+		}
+		ret =3D 0;
+	} else if (clk->set_rate !=3D 0)
+		ret =3D clk->set_rate(clk, rate);
+
+	if (unlikely(ret =3D=3D 0 && (clk->flags & RATE_PROPAGATES)))
+		propagate_rate(clk);
+
+	return ret;
+}
+
+/* Converts encoded control register address into a full address */
+static u32 omap2_get_src_field(u32 *type_to_addr, u32 reg_offset,
+					struct clk *src_clk, u32 *field_mask)
+{
+	u32 val =3D ~0, mask =3D 0;
+	void __iomem *src_reg_addr =3D 0;
+
+	/* Find target control register.*/
+	switch ((*type_to_addr & SRC_RATE_SEL_MASK)) {
+	case CM_CORE_SEL1:
+		src_reg_addr =3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1);
+		if (reg_offset =3D=3D OMAP24XX_CLKSEL_DSS2_SHIFT) {
+			mask =3D OMAP24XX_CLKSEL_DSS2_MASK;
+			mask >>=3D OMAP24XX_CLKSEL_DSS2_SHIFT;
+			if (src_clk =3D=3D &sys_ck)
+				val =3D 0;
+			if (src_clk =3D=3D &func_48m_ck)
+				val =3D 1;
+		} else if (reg_offset =3D=3D OMAP24XX_CLKSEL_DSS1_SHIFT) {
+			mask =3D OMAP24XX_CLKSEL_DSS1_MASK;
+			mask >>=3D OMAP24XX_CLKSEL_DSS1_SHIFT;
+			if (src_clk =3D=3D &sys_ck)
+				val =3D 0;
+			else if (src_clk =3D=3D &core_ck)	/* divided clock */
+				val =3D 0x10;		/* rate needs fixing */
+		} else if ((reg_offset =3D=3D OMAP2420_CLKSEL_VLYNQ_SHIFT) &&
+				cpu_is_omap2420()) {
+			mask =3D OMAP2420_CLKSEL_VLYNQ_MASK;
+			mask >>=3D OMAP2420_CLKSEL_VLYNQ_SHIFT;
+			if (src_clk =3D=3D &func_96m_ck)
+				val =3D 0;
+			else if (src_clk =3D=3D &core_ck)
+				val =3D 0x10;
+		}
+		break;
+	case CM_CORE_SEL2:
+		src_reg_addr =3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2);
+		mask =3D 0x3;
+		if (src_clk =3D=3D &func_32k_ck)
+			val =3D 0x0;
+		if (src_clk =3D=3D &sys_ck)
+			val =3D 0x1;
+		if (src_clk =3D=3D &alt_ck)
+			val =3D 0x2;
+		break;
+	case CM_WKUP_SEL1:
+		src_reg_addr =3D OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL);
+		mask =3D 0x3;
+		if (src_clk =3D=3D &func_32k_ck)
+			val =3D 0x0;
+		if (src_clk =3D=3D &sys_ck)
+			val =3D 0x1;
+		if (src_clk =3D=3D &alt_ck)
+			val =3D 0x2;
+		break;
+	case CM_PLL_SEL1:
+		src_reg_addr =3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1);
+		mask =3D 0x1;
+		if (reg_offset =3D=3D 0x3) {
+			if (src_clk =3D=3D &apll96_ck)
+				val =3D 0;
+			if (src_clk =3D=3D &alt_ck)
+				val =3D 1;
+		}
+		else if (reg_offset =3D=3D 0x5) {
+			if (src_clk =3D=3D &apll54_ck)
+				val =3D 0;
+			if (src_clk =3D=3D &alt_ck)
+				val =3D 1;
+		}
+		break;
+	case CM_PLL_SEL2:
+		src_reg_addr =3D OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2);
+		mask =3D 0x3;
+		if (src_clk =3D=3D &func_32k_ck)
+			val =3D 0x0;
+		if (src_clk =3D=3D &dpll_ck)
+			val =3D 0x2;
+		break;
+	case CM_SYSCLKOUT_SEL1:
+		src_reg_addr =3D OMAP24XX_PRCM_CLKOUT_CTRL;
+		mask =3D 0x3;
+		if (src_clk =3D=3D &dpll_ck)
+			val =3D 0;
+		if (src_clk =3D=3D &sys_ck)
+			val =3D 1;
+		if (src_clk =3D=3D &func_96m_ck)
+			val =3D 2;
+		if (src_clk =3D=3D &func_54m_ck)
+			val =3D 3;
+		break;
+	}
+
+	if (val =3D=3D ~0)			/* Catch errors in offset */
+		*type_to_addr =3D 0;
+	else
+		*type_to_addr =3D (u32)src_reg_addr;
+	*field_mask =3D mask;
+
+	return val;
+}
+
+/* REVISIT: Needs to be fixed for 3430 */
+static int omap2_clk_set_parent(struct clk *clk, struct clk =
*new_parent)
+{
+	void __iomem * reg;
+	u32 src_sel, src_off, field_val, field_mask, reg_val, rate;
+	int ret =3D -EINVAL;
+
+	if (unlikely(clk->flags & CONFIG_PARTICIPANT))
+		return ret;
+
+	if (clk->flags & SRC_SEL_MASK) {	/* On-chip SEL collection */
+		src_sel =3D (SRC_RATE_SEL_MASK & clk->flags);
+		src_off =3D clk->src_offset;
+
+		if (src_sel =3D=3D 0)
+			goto set_parent_error;
+
+		field_val =3D omap2_get_src_field(&src_sel, src_off, new_parent,
+						&field_mask);
+
+		reg =3D (void __iomem *)src_sel;
+
+		if (clk->usecount > 0)
+			_omap2_clk_disable(clk);
+
+		/* Set new source value (previous dividers if any in effect) */
+		reg_val =3D __raw_readl(reg) & ~(field_mask << src_off);
+		reg_val |=3D (field_val << src_off);
+		__raw_writel(reg_val, reg);
+		wmb();
+
+		if (clk->flags & DELAYED_APP) {
+			prm_write_reg(OMAP24XX_VALID_CONFIG,
+					  OMAP24XX_PRCM_CLKCFG_CTRL);
+			wmb();
+		}
+		if (clk->usecount > 0)
+			_omap2_clk_enable(clk);
+
+		clk->parent =3D new_parent;
+
+		/* SRC_RATE_SEL_MASK clocks follow their parents rates.*/
+		if ((new_parent =3D=3D &core_ck) && (clk =3D=3D &dss1_fck))
+			clk->rate =3D new_parent->rate / 0x10;
+		else
+			clk->rate =3D new_parent->rate;
+
+		if (unlikely(clk->flags & RATE_PROPAGATES))
+			propagate_rate(clk);
+
+		return 0;
+	} else {
+		clk->parent =3D new_parent;
+		rate =3D new_parent->rate;
+		omap2_clk_set_rate(clk, rate);
+		ret =3D 0;
+	}
+
+ set_parent_error:
+	return ret;
+}
+
+/* Sets basic clocks based on the specified rate */
+/* REVISIT: Needs to be fixed for 3430 */
+static int omap2_select_table_rate(struct clk * clk, unsigned long =
rate)
+{
+	u32 flags, cur_rate, done_rate, bypass =3D 0;
+	u8 cpu_mask =3D 0;
+	struct prcm_config *prcm;
+	unsigned long found_speed =3D 0;
+
+	if (clk !=3D &virt_prcm_set)
+		return -EINVAL;
+
+	/* FIXME: Change cpu_is_omap2420() to cpu_is_omap242x() */
+	if (cpu_is_omap2420())
+		cpu_mask =3D RATE_IN_242X;
+	else if (cpu_is_omap2430())
+		cpu_mask =3D RATE_IN_243X;
+	else if (cpu_is_omap3430())
+		cpu_mask =3D RATE_IN_343X;
+
+	for (prcm =3D rate_table; prcm->mpu_speed; prcm++) {
+		if (!(prcm->flags & cpu_mask))
+			continue;
+
+		if (prcm->xtal_speed !=3D sys_ck.rate)
+			continue;
+
+		if (prcm->mpu_speed <=3D rate) {
+			found_speed =3D prcm->mpu_speed;
+			break;
+		}
+	}
+
+	if (!found_speed) {
+		printk(KERN_INFO "Could not set MPU rate to %luMHz\n",
+	 rate / 1000000);
+		return -EINVAL;
+	}
+
+	curr_prcm_set =3D prcm;
+	cur_rate =3D omap2_get_dpll_rate(&dpll_ck);
+
+	if (prcm->dpll_speed =3D=3D cur_rate / 2) {
+		omap2_reprogram_sdrc(PRCM_HALF_SPEED, 1);
+	} else if (prcm->dpll_speed =3D=3D cur_rate * 2) {
+		omap2_reprogram_sdrc(PRCM_FULL_SPEED, 1);
+	} else if (prcm->dpll_speed !=3D cur_rate) {
+		local_irq_save(flags);
+
+		if (prcm->dpll_speed =3D=3D prcm->xtal_speed)
+			bypass =3D 1;
+
+		if ((prcm->cm_clksel2_pll & OMAP24XX_CORE_CLK_SRC_MASK) =3D=3D 2)
+			done_rate =3D PRCM_FULL_SPEED;
+		else
+			done_rate =3D PRCM_HALF_SPEED;
+
+		/* MPU divider */
+		cm_write_mod_reg(prcm->cm_clksel_mpu, MPU_MOD, CM_CLKSEL);
+
+		/* dsp + iva1 div(2420), iva2.1(2430) */
+		cm_write_mod_reg(prcm->cm_clksel_dsp,
+				 OMAP24XX_DSP_MOD, CM_CLKSEL);
+
+		cm_write_mod_reg(prcm->cm_clksel_gfx, GFX_MOD, CM_CLKSEL);
+
+		/* Major subsystem dividers */
+		cm_write_mod_reg(prcm->cm_clksel1_core, CORE_MOD, CM_CLKSEL1);
+		if (cpu_is_omap2430())
+			cm_write_mod_reg(prcm->cm_clksel_mdm,
+					 OMAP2430_MDM_MOD, CM_CLKSEL);
+
+		/* x2 to enter init_mem */
+		omap2_reprogram_sdrc(PRCM_FULL_SPEED, 1);
+
+		omap2_set_prcm(prcm->cm_clksel1_pll, prcm->base_sdrc_rfr,
+					bypass);
+
+		omap2_init_memory_params(omap2_dll_force_needed());
+		omap2_reprogram_sdrc(done_rate, 0);
+
+		local_irq_restore(flags);
+	}
+	omap2_clksel_recalc(&dpll_ck);
+
+	return 0;
+}
+
+/*----------------------------------------------------------------------=
---
+ * Omap2 clock reset and init functions
+ =
*------------------------------------------------------------------------=
-*/
+
+#ifdef CONFIG_OMAP_RESET_CLOCKS
+static void __init omap2_clk_disable_unused(struct clk *clk)
+{
+	u32 regval32;
+
+	regval32 =3D cm_read_reg(clk->enable_reg);
+	if ((regval32 & (1 << clk->enable_bit)) =3D=3D 0)
+		return;
+
+	printk(KERN_INFO "Disabling unused clock \"%s\"\n", clk->name);
+	_omap2_clk_disable(clk);
+}
+#else
+#define omap2_clk_disable_unused	NULL
+#endif
+
+static struct clk_functions omap2_clk_functions =3D {
+	.clk_enable		=3D omap2_clk_enable,
+	.clk_disable		=3D omap2_clk_disable,
+	.clk_round_rate		=3D omap2_clk_round_rate,
+	.clk_set_rate		=3D omap2_clk_set_rate,
+	.clk_set_parent		=3D omap2_clk_set_parent,
+	.clk_disable_unused	=3D omap2_clk_disable_unused,
+};
+
+/* REVISIT: Needs fixing for 3430 */
+static void __init omap2_get_crystal_rate(struct clk *osc, struct clk =
*sys)
+{
+	u32 div, aplls, sclk =3D 13000000;
+
+	aplls =3D cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
+	aplls &=3D OMAP24XX_APLLS_CLKIN_MASK;
+	aplls >>=3D OMAP24XX_APLLS_CLKIN_SHIFT;	/* Isolate field, 0,2,3 */
+
+	if (aplls =3D=3D 0)
+		sclk =3D 19200000;
+	else if (aplls =3D=3D 2)
+		sclk =3D 13000000;
+	else if (aplls =3D=3D 3)
+		sclk =3D 12000000;
+
+	div =3D prm_read_reg(OMAP24XX_PRCM_CLKSRC_CTRL);
+	div &=3D OMAP_SYSCLKDIV_MASK;
+	div >>=3D sys->rate_offset;
+
+	osc->rate =3D sclk * div;
+	sys->rate =3D sclk;
+}
+
+/*
+ * Set clocks for bypass mode for reboot to work.
+ */
+void omap2_clk_prepare_for_reboot(void)
+{
+	u32 rate;
+
+	if (vclk =3D=3D NULL || sclk =3D=3D NULL)
+		return;
+
+	rate =3D clk_get_rate(sclk);
+	clk_set_rate(vclk, rate);
+}
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
+	if (omap2_select_table_rate(&virt_prcm_set, mpurate))
+		printk(KERN_ERR "Could not find matching MPU rate\n");
+
+	propagate_rate(&osc_ck);		/* update main root fast */
+	propagate_rate(&func_32k_ck);		/* update main root slow */
+
+	printk(KERN_INFO "Switched to new clocking rate (Crystal/DPLL/MPU): "
+			"%ld.%01ld/%ld/%ld MHz\n",
+			(sys_ck.rate / 1000000), (sys_ck.rate / 100000) % 10,
+			(dpll_ck.rate / 1000000), (mpu_ck.rate / 1000000)) ;
+
+	return 0;
+}
+#if 0
+arch_initcall(omap2_clk_arch_init);
+#endif
+
+int __init omap2_clk_init(void)
+{
+	struct prcm_config *prcm;
+	struct clk ** clkp;
+	u32 clkrate;
+
+	clk_init(&omap2_clk_functions);
+#if 0
+	omap2_get_crystal_rate(&osc_ck, &sys_ck);
+#endif
+	for (clkp =3D onchip_clks; clkp < onchip_clks + =
ARRAY_SIZE(onchip_clks);
+		 clkp++) {
+
+		if ((*clkp)->flags & CLOCK_IN_OMAP242X && (cpu_is_omap2420() || =
cpu_is_omap34xx())) {
+			clk_register(*clkp);
+			continue;
+		}
+
+		if ((*clkp)->flags & CLOCK_IN_OMAP243X && (cpu_is_omap2430() || =
cpu_is_omap34xx())) {
+			clk_register(*clkp);
+			continue;
+		}
+	}
+
+	/* Check the MPU rate set by bootloader */
+	clkrate =3D omap2_get_dpll_rate(&dpll_ck);
+	for (prcm =3D rate_table; prcm->mpu_speed; prcm++) {
+		if (prcm->xtal_speed !=3D sys_ck.rate)
+			continue;
+		if (prcm->dpll_speed <=3D clkrate)
+			 break;
+	}
+	curr_prcm_set =3D prcm;
+
+	propagate_rate(&osc_ck);		/* update main root fast */
+	propagate_rate(&func_32k_ck);		/* update main root slow */
+#if 0
+	printk(KERN_INFO "Clocking rate (Crystal/DPLL/MPU): "
+			"%ld.%01ld/%ld/%ld MHz\n",
+			(sys_ck.rate / 1000000), (sys_ck.rate / 100000) % 10,
+			(dpll_ck.rate / 1000000), (mpu_ck.rate / 1000000)) ;
+
+	/*
+	 * Only enable those clocks we will need, let the drivers
+	 * enable other clocks as necessary
+	 */
+	clk_enable(&sync_32k_ick);
+	clk_enable(&omapctrl_ick);
+
+	/* Force the APLLs always active. The clocks are idled
+	 * automatically by hardware. */
+	clk_enable(&apll96_ck);
+	clk_enable(&apll54_ck);
+
+	if (cpu_is_omap2430())
+		clk_enable(&sdrc_ick);
+
+	/* Avoid sleeping sleeping during omap2_clk_prepare_for_reboot() */
+	vclk =3D clk_get(NULL, "virt_prcm_set");
+	sclk =3D clk_get(NULL, "sys_ck");
+#endif
+	return 0;
+}
diff -purN linux-omap/arch/arm/mach-omap2/gpmc.c =
val_3430_GIT/arch/arm/mach-omap2/gpmc.c
--- linux-omap/arch/arm/mach-omap2/gpmc.c	2007-05-16 14:32:40.000000000 =
-0500
+++ val_3430_GIT/arch/arm/mach-omap2/gpmc.c	2007-05-28 =
12:47:13.000000000 -0500
@@ -22,12 +22,12 @@
=20
 #undef DEBUG
=20
-#ifdef CONFIG_ARCH_OMAP2420
+#if defined(CONFIG_ARCH_OMAP2420)
 #define GPMC_BASE		0x6800a000
-#endif
-
-#ifdef CONFIG_ARCH_OMAP2430
-#define GPMC_BASE		0x6E000000
+#elif defined(CONFIG_ARCH_OMAP2430)
+#define GPMC_BASE		0x6e000000
+#elif defined(CONFIG_ARCH_OMAP3430)
+#define GPMC_BASE		0x6e000000
 #endif
=20
 #define GPMC_REVISION		0x00
diff -purN linux-omap/arch/arm/mach-omap2/id.c =
val_3430_GIT/arch/arm/mach-omap2/id.c
--- linux-omap/arch/arm/mach-omap2/id.c	2006-11-20 21:54:01.000000000 =
-0600
+++ val_3430_GIT/arch/arm/mach-omap2/id.c	2007-05-28 12:47:13.000000000 =
-0500
@@ -18,11 +18,11 @@
 #include <asm/io.h>
=20
 #if defined(CONFIG_ARCH_OMAP2420)
-#define OMAP24XX_TAP_BASE	io_p2v(0x48014000)
-#endif
-
-#if defined(CONFIG_ARCH_OMAP2430)
-#define OMAP24XX_TAP_BASE	io_p2v(0x4900A000)
+#define TAP_BASE	io_p2v(0x48014000)
+#elif defined(CONFIG_ARCH_OMAP2430)
+#define TAP_BASE	io_p2v(0x4900A000)
+#elif defined(CONFIG_ARCH_OMAP34XX)
+#define TAP_BASE	io_p2v(0x54004000)
 #endif
=20
 #define OMAP_TAP_IDCODE		0x0204
@@ -58,7 +58,7 @@ static struct omap_id omap_ids[] __initd
=20
 static u32 __init read_tap_reg(int reg)
 {
-	return __raw_readl(OMAP24XX_TAP_BASE + reg);
+	return __raw_readl(TAP_BASE + reg);
 }
=20
 void __init omap2_check_revision(void)
@@ -119,7 +119,11 @@ void __init omap2_check_revision(void)
 	system_rev |=3D rev << 8;
=20
 	/* Add the cpu class info (24xx) */
+#ifndef CONFIG_ARCH_OMAP3
 	system_rev |=3D 0x24;
+#else
+	system_rev |=3D 0x34;
+#endif
=20
 	pr_info("OMAP%04x", system_rev >> 16);
 	if ((system_rev >> 8) & 0x0f)
diff -purN linux-omap/arch/arm/mach-omap2/io.c =
val_3430_GIT/arch/arm/mach-omap2/io.c
--- linux-omap/arch/arm/mach-omap2/io.c	2007-05-16 14:32:40.000000000 =
-0500
+++ val_3430_GIT/arch/arm/mach-omap2/io.c	2007-05-28 13:12:04.000000000 =
-0500
@@ -4,8 +4,11 @@
  * OMAP2 I/O mapping code
  *
  * Copyright (C) 2005 Nokia Corporation
- * Author: Juha Yrjola<juha.yrjola@nokia.com>
- * Updated map desc to add 2430 support : <x0khasim@ti.com>
+ * Copyright (C) 2007 Texas Instruments
+ *
+ * Author:
+ * Juha Yrjola <juha.yrjola@nokia.com>
+ * Syed Khasim <x0khasim@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -31,36 +34,104 @@ extern void omap2_init_memory(void);
 extern void gpmc_init(void);
 extern void omapfb_reserve_sdram(void);
=20
+#if defined(CONFIG_ARCH_OMAP24XX)
+
+#define L3_VIRT		L3_24XX_VIRT
+#define L3_PHYS		L3_24XX_PHYS
+#define L3_SIZE		L3_24XX_SIZE
+
+#define L4_VIRT		L4_24XX_VIRT
+#define L4_PHYS		L4_24XX_PHYS
+#define L4_SIZE		L4_24XX_SIZE
+
+#define L4_WK_VIRT	L4_WK_243X_VIRT
+#define L4_WK_PHYS	L4_WK_243X_PHYS
+#define L4_WK_SIZE	L4_WK_243X_SIZE
+
+#define GPMC_VIRT	OMAP243X_GPMC_VIRT
+#define GPMC_PHYS	OMAP243X_GPMC_PHYS
+#define GPMC_SIZE	OMAP243X_GPMC_SIZE
+
+#define DSP_MEM_VIRT	DSP_MEM_24XX_VIRT
+#define DSP_MEM_PHYS	DSP_MEM_24XX_PHYS
+#define DSP_MEM_SIZE	DSP_MEM_24XX_SIZE
+
+#define DSP_IPI_VIRT	DSP_IPI_24XX_VIRT
+#define DSP_IPI_PHYS	DSP_IPI_24XX_PHYS
+#define DSP_IPI_SIZE	DSP_IPI_24XX_SIZE
+
+#define DSP_MMU_VIRT	DSP_MMU_24XX_VIRT
+#define DSP_MMU_PHYS	DSP_MMU_24XX_PHYS
+#define DSP_MMU_SIZE	DSP_MMU_24XX_SIZE
+
+#elif defined(CONFIG_ARCH_OMAP34XX)
+
+#define L3_VIRT		L3_34XX_VIRT
+#define L3_PHYS		L3_34XX_PHYS
+#define L3_SIZE		L3_34XX_SIZE
+
+#define L4_VIRT		L4_34XX_VIRT
+#define L4_PHYS		L4_34XX_PHYS
+#define L4_SIZE		L4_34XX_SIZE
+
+#define L4_PER_VIRT	L4_PER_34XX_VIRT
+#define L4_PER_PHYS	L4_PER_34XX_PHYS
+#define L4_PER_SIZE	L4_PER_34XX_SIZE
+
+#define L4_WK_VIRT	L4_WK_34XX_VIRT
+#define L4_WK_PHYS	L4_WK_34XX_PHYS
+#define L4_WK_SIZE	L4_WK_34XX_SIZE
+
+#define GPMC_VIRT	OMAP34XX_GPMC_VIRT
+#define GPMC_PHYS	OMAP34XX_GPMC_PHYS
+#define GPMC_SIZE	OMAP34XX_GPMC_SIZE
+
+#define DSP_MEM_VIRT	DSP_MEM_34XX_VIRT
+#define DSP_MEM_PHYS	DSP_MEM_34XX_PHYS
+#define DSP_MEM_SIZE	DSP_MEM_34XX_SIZE
+
+#define DSP_IPI_VIRT	DSP_IPI_34XX_VIRT
+#define DSP_IPI_PHYS	DSP_IPI_34XX_PHYS
+#define DSP_IPI_SIZE	DSP_IPI_34XX_SIZE
+
+#define DSP_MMU_VIRT	DSP_MMU_34XX_VIRT
+#define DSP_MMU_PHYS	DSP_MMU_34XX_PHYS
+#define DSP_MMU_SIZE	DSP_MMU_34XX_SIZE
+
+#endif
+
 /*
  * The machine specific code may provide the extra mapping besides the
  * default mapping provided here.
  */
 static struct map_desc omap2_io_desc[] __initdata =3D {
 	{
-		.virtual	=3D L3_24XX_VIRT,
-		.pfn		=3D __phys_to_pfn(L3_24XX_PHYS),
-		.length		=3D L3_24XX_SIZE,
+		.virtual	=3D L3_VIRT,
+		.pfn		=3D __phys_to_pfn(L3_PHYS),
+		.length		=3D L3_SIZE,
 		.type		=3D MT_DEVICE
 	},
 	{
-		.virtual	=3D L4_24XX_VIRT,
-		.pfn		=3D __phys_to_pfn(L4_24XX_PHYS),
-		.length		=3D L4_24XX_SIZE,
+		.virtual	=3D L4_VIRT,
+		.pfn		=3D __phys_to_pfn(L4_PHYS),
+		.length		=3D L4_SIZE,
 		.type		=3D MT_DEVICE
 	},
-#ifdef CONFIG_ARCH_OMAP2430
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
 	{
-		.virtual	=3D L4_WK_243X_VIRT,
-		.pfn		=3D __phys_to_pfn(L4_WK_243X_PHYS),
-		.length		=3D L4_WK_243X_SIZE,
+		.virtual	=3D L4_WK_VIRT,
+		.pfn		=3D __phys_to_pfn(L4_WK_PHYS),
+		.length		=3D L4_WK_SIZE,
 		.type		=3D MT_DEVICE
 	},
 	{
-		.virtual	=3D OMAP243X_GPMC_VIRT,
-		.pfn		=3D __phys_to_pfn(OMAP243X_GPMC_PHYS),
-		.length		=3D OMAP243X_GPMC_SIZE,
+		.virtual	=3D GPMC_VIRT,
+		.pfn		=3D __phys_to_pfn(GPMC_PHYS),
+		.length		=3D GPMC_SIZE,
 		.type		=3D MT_DEVICE
 	},
+#endif
+#if defined(CONFIG_ARCH_OMAP2430)
 	{
 		.virtual	=3D OMAP243X_SDRC_VIRT,
 		.pfn		=3D __phys_to_pfn(OMAP243X_SDRC_PHYS),
@@ -74,6 +145,33 @@ static struct map_desc omap2_io_desc[] _
 		.type		=3D MT_DEVICE
 	},
 #endif
+#if defined(CONFIG_ARCH_OMAP34XX)
+	{
+		.virtual	=3D OMAP343X_SMS_VIRT,
+		.pfn		=3D __phys_to_pfn(OMAP343X_SMS_PHYS),
+		.length		=3D OMAP343X_SMS_SIZE,
+		.type		=3D MT_DEVICE
+	},
+	{
+		.virtual	=3D OMAP343X_SDRC_VIRT,
+		.pfn		=3D __phys_to_pfn(OMAP343X_SDRC_PHYS),
+		.length		=3D OMAP343X_SDRC_SIZE,
+		.type		=3D MT_DEVICE
+	},
+	{
+		.virtual	=3D L4_PER_VIRT,
+		.pfn		=3D __phys_to_pfn(L4_PER_PHYS),
+		.length		=3D L4_PER_SIZE,
+		.type		=3D MT_DEVICE
+	},
+	{
+		.virtual	=3D L4_EMU_34XX_VIRT,
+		.pfn		=3D __phys_to_pfn(L4_EMU_34XX_PHYS),
+		.length		=3D L4_EMU_34XX_SIZE,
+		.type		=3D MT_DEVICE
+	},
+#endif
+#if defined(CONFIG_ARCH_OMAP2420) || defined(CONFIG_ARCH_OMAP2430)
 	{
 		.virtual	=3D DSP_MEM_24XX_VIRT,
 		.pfn		=3D __phys_to_pfn(DSP_MEM_24XX_PHYS),
@@ -94,6 +192,7 @@ static struct map_desc omap2_io_desc[] _
 		.length		=3D DSP_MMU_24XX_SIZE,
 		.type		=3D MT_DEVICE
 	},
+#endif
 };
=20
 void __init omap2_map_common_io(void)
diff -purN linux-omap/arch/arm/mach-omap2/irq.c =
val_3430_GIT/arch/arm/mach-omap2/irq.c
--- linux-omap/arch/arm/mach-omap2/irq.c	2007-01-08 18:55:58.000000000 =
-0600
+++ val_3430_GIT/arch/arm/mach-omap2/irq.c	2007-05-28 12:47:13.000000000 =
-0500
@@ -18,6 +18,12 @@
 #include <asm/irq.h>
 #include <asm/io.h>
=20
+#if defined(CONFIG_ARCH_OMAP24XX)
+#define IC_BASE		OMAP24XX_IC_BASE
+#elif defined(CONFIG_ARCH_OMAP34XX)
+#define IC_BASE		OMAP34XX_IC_BASE
+#endif
+
 #define INTC_REVISION	0x0000
 #define INTC_SYSCONFIG	0x0010
 #define INTC_SYSSTATUS	0x0014
@@ -37,7 +43,7 @@ static struct omap_irq_bank {
 } __attribute__ ((aligned(4))) irq_banks[] =3D {
 	{
 		/* MPU INTC */
-		.base_reg	=3D IO_ADDRESS(OMAP24XX_IC_BASE),
+		.base_reg	=3D IO_ADDRESS(IC_BASE),
 		.nr_irqs	=3D 96,
 	}, {
 		/* XXX: DSP INTC */
