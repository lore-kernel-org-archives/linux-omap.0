From: Tero Kristo <t-kristo@ti.com>
Subject: =?UTF-8?q?=5BPATCHv2=2014/27=5D=20clk=3A=20ti=3A=20dpll=3A=20move=20omap3=20DPLL=20functionality=20to=20clock=20driver?=
Date: Mon, 11 May 2015 11:54:40 +0300
Message-ID: <1431334493-24455-15-git-send-email-t-kristo@ti.com>
References: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46533 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753151AbbEKIza (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 May 2015 04:55:30 -0400
In-Reply-To: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mturquette@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

With the legacy clock support gone, OMAP3 generic DPLL code can now be
moved over to the clock driver also. A few un-unused clkoutx2 functions
are also removed at the same time.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/Makefile    |    8 +-
 arch/arm/mach-omap2/clock.h     |    4 -
 arch/arm/mach-omap2/clock3xxx.c |   77 ----
 arch/arm/mach-omap2/dpll3xxx.c  |  818 -------------------------------=
-------
 drivers/clk/ti/Makefile         |    2 +-
 drivers/clk/ti/clk-3xxx.c       |   31 ++
 drivers/clk/ti/clock.h          |   27 ++
 drivers/clk/ti/dpll3xxx.c       |  825 +++++++++++++++++++++++++++++++=
++++++++
 include/linux/clk/ti.h          |   30 --
 9 files changed, 886 insertions(+), 936 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/dpll3xxx.c
 create mode 100644 drivers/clk/ti/dpll3xxx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
index bf5d71d..f9d4ccf 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -189,15 +189,11 @@ obj-$(CONFIG_SOC_OMAP2430)		+=3D clock2430.o
 obj-$(CONFIG_ARCH_OMAP3)		+=3D $(clock-common) clock3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+=3D clock34xx.o clkt34xx_dpll3m2.o
 obj-$(CONFIG_ARCH_OMAP3)		+=3D clock3517.o
-obj-$(CONFIG_ARCH_OMAP3)		+=3D dpll3xxx.o
 obj-$(CONFIG_ARCH_OMAP4)		+=3D $(clock-common)
-obj-$(CONFIG_ARCH_OMAP4)		+=3D dpll3xxx.o
-obj-$(CONFIG_SOC_AM33XX)		+=3D $(clock-common) dpll3xxx.o
+obj-$(CONFIG_SOC_AM33XX)		+=3D $(clock-common)
 obj-$(CONFIG_SOC_OMAP5)			+=3D $(clock-common)
-obj-$(CONFIG_SOC_OMAP5)			+=3D dpll3xxx.o
 obj-$(CONFIG_SOC_DRA7XX)		+=3D $(clock-common)
-obj-$(CONFIG_SOC_DRA7XX)		+=3D dpll3xxx.o
-obj-$(CONFIG_SOC_AM43XX)		+=3D $(clock-common) dpll3xxx.o
+obj-$(CONFIG_SOC_AM43XX)		+=3D $(clock-common)
=20
 # OMAP2 clock rate set data (old "OPP" data)
 obj-$(CONFIG_SOC_OMAP2420)		+=3D opp2420_data.o
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index e2781b4..d60691d 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -180,10 +180,6 @@ struct clksel {
 #define OMAP4XXX_EN_DPLL_FRBYPASS		0x6
 #define OMAP4XXX_EN_DPLL_LOCKED			0x7
=20
-u32 omap3_dpll_autoidle_read(struct clk_hw_omap *clk);
-void omap3_dpll_allow_idle(struct clk_hw_omap *clk);
-void omap3_dpll_deny_idle(struct clk_hw_omap *clk);
-
 void __init omap2_clk_disable_clkdm_control(void);
=20
 void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/cloc=
k3xxx.c
index 4bd6122..0b0e3a87 100644
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -29,82 +29,5 @@
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-34xx.h"
=20
-/*
- * DPLL5_FREQ_FOR_USBHOST: USBHOST and USBTLL are the only clocks
- * that are sourced by DPLL5, and both of these require this clock
- * to be at 120 MHz for proper operation.
- */
-#define DPLL5_FREQ_FOR_USBHOST		120000000
-
 /* needed by omap3_core_dpll_m2_set_rate() */
 struct clk *sdrc_ick_p, *arm_fck_p;
-
-/**
- * omap3_dpll4_set_rate - set rate for omap3 per-dpll
- * @hw: clock to change
- * @rate: target rate for clock
- * @parent_rate: rate of the parent clock
- *
- * Check if the current SoC supports the per-dpll reprogram operation
- * or not, and then do the rate change if supported. Returns -EINVAL
- * if not supported, 0 for success, and potential error codes from the
- * clock rate change.
- */
-int omap3_dpll4_set_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long parent_rate)
-{
-	/*
-	 * According to the 12-5 CDP code from TI, "Limitation 2.5"
-	 * on 3430ES1 prevents us from changing DPLL multipliers or dividers
-	 * on DPLL4.
-	 */
-	if (ti_clk_get_features()->flags & TI_CLK_DPLL4_DENY_REPROGRAM) {
-		pr_err("clock: DPLL4 cannot change rate due to silicon 'Limitation 2=
=2E5' on 3430ES1.\n");
-		return -EINVAL;
-	}
-
-	return omap3_noncore_dpll_set_rate(hw, rate, parent_rate);
-}
-
-/**
- * omap3_dpll4_set_rate_and_parent - set rate and parent for omap3 per=
-dpll
- * @hw: clock to change
- * @rate: target rate for clock
- * @parent_rate: rate of the parent clock
- * @index: parent index, 0 - reference clock, 1 - bypass clock
- *
- * Check if the current SoC support the per-dpll reprogram operation
- * or not, and then do the rate + parent change if supported. Returns
- * -EINVAL if not supported, 0 for success, and potential error codes
- * from the clock rate change.
- */
-int omap3_dpll4_set_rate_and_parent(struct clk_hw *hw, unsigned long r=
ate,
-				    unsigned long parent_rate, u8 index)
-{
-	if (ti_clk_get_features()->flags & TI_CLK_DPLL4_DENY_REPROGRAM) {
-		pr_err("clock: DPLL4 cannot change rate due to silicon 'Limitation 2=
=2E5' on 3430ES1.\n");
-		return -EINVAL;
-	}
-
-	return omap3_noncore_dpll_set_rate_and_parent(hw, rate, parent_rate,
-						      index);
-}
-
-void __init omap3_clk_lock_dpll5(void)
-{
-	struct clk *dpll5_clk;
-	struct clk *dpll5_m2_clk;
-
-	dpll5_clk =3D clk_get(NULL, "dpll5_ck");
-	clk_set_rate(dpll5_clk, DPLL5_FREQ_FOR_USBHOST);
-	clk_prepare_enable(dpll5_clk);
-
-	/* Program dpll5_m2_clk divider for no division */
-	dpll5_m2_clk =3D clk_get(NULL, "dpll5_m2_ck");
-	clk_prepare_enable(dpll5_m2_clk);
-	clk_set_rate(dpll5_m2_clk, DPLL5_FREQ_FOR_USBHOST);
-
-	clk_disable_unprepare(dpll5_m2_clk);
-	clk_disable_unprepare(dpll5_clk);
-	return;
-}
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3=
xxx.c
deleted file mode 100644
index 9a80f59..0000000
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ /dev/null
@@ -1,818 +0,0 @@
-/*
- * OMAP3/4 - specific DPLL control functions
- *
- * Copyright (C) 2009-2010 Texas Instruments, Inc.
- * Copyright (C) 2009-2010 Nokia Corporation
- *
- * Written by Paul Walmsley
- * Testing and integration fixes by Jouni H=C3=B6gander
- *
- * 36xx support added by Vishwanath BS, Richard Woodruff, and Nishanth
- * Menon
- *
- * Parts of this code are based on code written by
- * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu
- *
- * This program is free software; you can redistribute it and/or modif=
y
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/list.h>
-#include <linux/errno.h>
-#include <linux/delay.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/bitops.h>
-#include <linux/clkdev.h>
-
-#include "clockdomain.h"
-#include "clock.h"
-
-/* CM_AUTOIDLE_PLL*.AUTO_* bit values */
-#define DPLL_AUTOIDLE_DISABLE			0x0
-#define DPLL_AUTOIDLE_LOW_POWER_STOP		0x1
-
-#define MAX_DPLL_WAIT_TRIES		1000000
-
-/* Private functions */
-
-/* _omap3_dpll_write_clken - write clken_bits arg to a DPLL's enable b=
its */
-static void _omap3_dpll_write_clken(struct clk_hw_omap *clk, u8 clken_=
bits)
-{
-	const struct dpll_data *dd;
-	u32 v;
-
-	dd =3D clk->dpll_data;
-
-	v =3D omap2_clk_readl(clk, dd->control_reg);
-	v &=3D ~dd->enable_mask;
-	v |=3D clken_bits << __ffs(dd->enable_mask);
-	omap2_clk_writel(v, clk, dd->control_reg);
-}
-
-/* _omap3_wait_dpll_status: wait for a DPLL to enter a specific state =
*/
-static int _omap3_wait_dpll_status(struct clk_hw_omap *clk, u8 state)
-{
-	const struct dpll_data *dd;
-	int i =3D 0;
-	int ret =3D -EINVAL;
-	const char *clk_name;
-
-	dd =3D clk->dpll_data;
-	clk_name =3D __clk_get_name(clk->hw.clk);
-
-	state <<=3D __ffs(dd->idlest_mask);
-
-	while (((omap2_clk_readl(clk, dd->idlest_reg) & dd->idlest_mask)
-		!=3D state) && i < MAX_DPLL_WAIT_TRIES) {
-		i++;
-		udelay(1);
-	}
-
-	if (i =3D=3D MAX_DPLL_WAIT_TRIES) {
-		printk(KERN_ERR "clock: %s failed transition to '%s'\n",
-		       clk_name, (state) ? "locked" : "bypassed");
-	} else {
-		pr_debug("clock: %s transition to '%s' in %d loops\n",
-			 clk_name, (state) ? "locked" : "bypassed", i);
-
-		ret =3D 0;
-	}
-
-	return ret;
-}
-
-/* From 3430 TRM ES2 4.7.6.2 */
-static u16 _omap3_dpll_compute_freqsel(struct clk_hw_omap *clk, u8 n)
-{
-	unsigned long fint;
-	u16 f =3D 0;
-
-	fint =3D __clk_get_rate(clk->dpll_data->clk_ref) / n;
-
-	pr_debug("clock: fint is %lu\n", fint);
-
-	if (fint >=3D 750000 && fint <=3D 1000000)
-		f =3D 0x3;
-	else if (fint > 1000000 && fint <=3D 1250000)
-		f =3D 0x4;
-	else if (fint > 1250000 && fint <=3D 1500000)
-		f =3D 0x5;
-	else if (fint > 1500000 && fint <=3D 1750000)
-		f =3D 0x6;
-	else if (fint > 1750000 && fint <=3D 2100000)
-		f =3D 0x7;
-	else if (fint > 7500000 && fint <=3D 10000000)
-		f =3D 0xB;
-	else if (fint > 10000000 && fint <=3D 12500000)
-		f =3D 0xC;
-	else if (fint > 12500000 && fint <=3D 15000000)
-		f =3D 0xD;
-	else if (fint > 15000000 && fint <=3D 17500000)
-		f =3D 0xE;
-	else if (fint > 17500000 && fint <=3D 21000000)
-		f =3D 0xF;
-	else
-		pr_debug("clock: unknown freqsel setting for %d\n", n);
-
-	return f;
-}
-
-/*
- * _omap3_noncore_dpll_lock - instruct a DPLL to lock and wait for rea=
diness
- * @clk: pointer to a DPLL struct clk
- *
- * Instructs a non-CORE DPLL to lock.  Waits for the DPLL to report
- * readiness before returning.  Will save and restore the DPLL's
- * autoidle state across the enable, per the CDP code.  If the DPLL
- * locked successfully, return 0; if the DPLL did not lock in the time
- * allotted, or DPLL3 was passed in, return -EINVAL.
- */
-static int _omap3_noncore_dpll_lock(struct clk_hw_omap *clk)
-{
-	const struct dpll_data *dd;
-	u8 ai;
-	u8 state =3D 1;
-	int r =3D 0;
-
-	pr_debug("clock: locking DPLL %s\n", __clk_get_name(clk->hw.clk));
-
-	dd =3D clk->dpll_data;
-	state <<=3D __ffs(dd->idlest_mask);
-
-	/* Check if already locked */
-	if ((omap2_clk_readl(clk, dd->idlest_reg) & dd->idlest_mask) =3D=3D s=
tate)
-		goto done;
-
-	ai =3D omap3_dpll_autoidle_read(clk);
-
-	if (ai)
-		omap3_dpll_deny_idle(clk);
-
-	_omap3_dpll_write_clken(clk, DPLL_LOCKED);
-
-	r =3D _omap3_wait_dpll_status(clk, 1);
-
-	if (ai)
-		omap3_dpll_allow_idle(clk);
-
-done:
-	return r;
-}
-
-/*
- * _omap3_noncore_dpll_bypass - instruct a DPLL to bypass and wait for=
 readiness
- * @clk: pointer to a DPLL struct clk
- *
- * Instructs a non-CORE DPLL to enter low-power bypass mode.  In
- * bypass mode, the DPLL's rate is set equal to its parent clock's
- * rate.  Waits for the DPLL to report readiness before returning.
- * Will save and restore the DPLL's autoidle state across the enable,
- * per the CDP code.  If the DPLL entered bypass mode successfully,
- * return 0; if the DPLL did not enter bypass in the time allotted, or
- * DPLL3 was passed in, or the DPLL does not support low-power bypass,
- * return -EINVAL.
- */
-static int _omap3_noncore_dpll_bypass(struct clk_hw_omap *clk)
-{
-	int r;
-	u8 ai;
-
-	if (!(clk->dpll_data->modes & (1 << DPLL_LOW_POWER_BYPASS)))
-		return -EINVAL;
-
-	pr_debug("clock: configuring DPLL %s for low-power bypass\n",
-		 __clk_get_name(clk->hw.clk));
-
-	ai =3D omap3_dpll_autoidle_read(clk);
-
-	_omap3_dpll_write_clken(clk, DPLL_LOW_POWER_BYPASS);
-
-	r =3D _omap3_wait_dpll_status(clk, 0);
-
-	if (ai)
-		omap3_dpll_allow_idle(clk);
-
-	return r;
-}
-
-/*
- * _omap3_noncore_dpll_stop - instruct a DPLL to stop
- * @clk: pointer to a DPLL struct clk
- *
- * Instructs a non-CORE DPLL to enter low-power stop. Will save and
- * restore the DPLL's autoidle state across the stop, per the CDP
- * code.  If DPLL3 was passed in, or the DPLL does not support
- * low-power stop, return -EINVAL; otherwise, return 0.
- */
-static int _omap3_noncore_dpll_stop(struct clk_hw_omap *clk)
-{
-	u8 ai;
-
-	if (!(clk->dpll_data->modes & (1 << DPLL_LOW_POWER_STOP)))
-		return -EINVAL;
-
-	pr_debug("clock: stopping DPLL %s\n", __clk_get_name(clk->hw.clk));
-
-	ai =3D omap3_dpll_autoidle_read(clk);
-
-	_omap3_dpll_write_clken(clk, DPLL_LOW_POWER_STOP);
-
-	if (ai)
-		omap3_dpll_allow_idle(clk);
-
-	return 0;
-}
-
-/**
- * _lookup_dco - Lookup DCO used by j-type DPLL
- * @clk: pointer to a DPLL struct clk
- * @dco: digital control oscillator selector
- * @m: DPLL multiplier to set
- * @n: DPLL divider to set
- *
- * See 36xx TRM section 3.5.3.3.3.2 "Type B DPLL (Low-Jitter)"
- *
- * XXX This code is not needed for 3430/AM35xx; can it be optimized
- * out in non-multi-OMAP builds for those chips?
- */
-static void _lookup_dco(struct clk_hw_omap *clk, u8 *dco, u16 m, u8 n)
-{
-	unsigned long fint, clkinp; /* watch out for overflow */
-
-	clkinp =3D __clk_get_rate(__clk_get_parent(clk->hw.clk));
-	fint =3D (clkinp / n) * m;
-
-	if (fint < 1000000000)
-		*dco =3D 2;
-	else
-		*dco =3D 4;
-}
-
-/**
- * _lookup_sddiv - Calculate sigma delta divider for j-type DPLL
- * @clk: pointer to a DPLL struct clk
- * @sd_div: target sigma-delta divider
- * @m: DPLL multiplier to set
- * @n: DPLL divider to set
- *
- * See 36xx TRM section 3.5.3.3.3.2 "Type B DPLL (Low-Jitter)"
- *
- * XXX This code is not needed for 3430/AM35xx; can it be optimized
- * out in non-multi-OMAP builds for those chips?
- */
-static void _lookup_sddiv(struct clk_hw_omap *clk, u8 *sd_div, u16 m, =
u8 n)
-{
-	unsigned long clkinp, sd; /* watch out for overflow */
-	int mod1, mod2;
-
-	clkinp =3D __clk_get_rate(__clk_get_parent(clk->hw.clk));
-
-	/*
-	 * target sigma-delta to near 250MHz
-	 * sd =3D ceil[(m/(n+1)) * (clkinp_MHz / 250)]
-	 */
-	clkinp /=3D 100000; /* shift from MHz to 10*Hz for 38.4 and 19.2 */
-	mod1 =3D (clkinp * m) % (250 * n);
-	sd =3D (clkinp * m) / (250 * n);
-	mod2 =3D sd % 10;
-	sd /=3D 10;
-
-	if (mod1 || mod2)
-		sd++;
-	*sd_div =3D sd;
-}
-
-/*
- * _omap3_noncore_dpll_program - set non-core DPLL M,N values directly
- * @clk:	struct clk * of DPLL to set
- * @freqsel:	FREQSEL value to set
- *
- * Program the DPLL with the last M, N values calculated, and wait for
- * the DPLL to lock. Returns -EINVAL upon error, or 0 upon success.
- */
-static int omap3_noncore_dpll_program(struct clk_hw_omap *clk, u16 fre=
qsel)
-{
-	struct dpll_data *dd =3D clk->dpll_data;
-	u8 dco, sd_div;
-	u32 v;
-
-	/* 3430 ES2 TRM: 4.7.6.9 DPLL Programming Sequence */
-	_omap3_noncore_dpll_bypass(clk);
-
-	/*
-	 * Set jitter correction. Jitter correction applicable for OMAP343X
-	 * only since freqsel field is no longer present on other devices.
-	 */
-	if (ti_clk_get_features()->flags & TI_CLK_DPLL_HAS_FREQSEL) {
-		v =3D omap2_clk_readl(clk, dd->control_reg);
-		v &=3D ~dd->freqsel_mask;
-		v |=3D freqsel << __ffs(dd->freqsel_mask);
-		omap2_clk_writel(v, clk, dd->control_reg);
-	}
-
-	/* Set DPLL multiplier, divider */
-	v =3D omap2_clk_readl(clk, dd->mult_div1_reg);
-
-	/* Handle Duty Cycle Correction */
-	if (dd->dcc_mask) {
-		if (dd->last_rounded_rate >=3D dd->dcc_rate)
-			v |=3D dd->dcc_mask; /* Enable DCC */
-		else
-			v &=3D ~dd->dcc_mask; /* Disable DCC */
-	}
-
-	v &=3D ~(dd->mult_mask | dd->div1_mask);
-	v |=3D dd->last_rounded_m << __ffs(dd->mult_mask);
-	v |=3D (dd->last_rounded_n - 1) << __ffs(dd->div1_mask);
-
-	/* Configure dco and sd_div for dplls that have these fields */
-	if (dd->dco_mask) {
-		_lookup_dco(clk, &dco, dd->last_rounded_m, dd->last_rounded_n);
-		v &=3D ~(dd->dco_mask);
-		v |=3D dco << __ffs(dd->dco_mask);
-	}
-	if (dd->sddiv_mask) {
-		_lookup_sddiv(clk, &sd_div, dd->last_rounded_m,
-			      dd->last_rounded_n);
-		v &=3D ~(dd->sddiv_mask);
-		v |=3D sd_div << __ffs(dd->sddiv_mask);
-	}
-
-	omap2_clk_writel(v, clk, dd->mult_div1_reg);
-
-	/* Set 4X multiplier and low-power mode */
-	if (dd->m4xen_mask || dd->lpmode_mask) {
-		v =3D omap2_clk_readl(clk, dd->control_reg);
-
-		if (dd->m4xen_mask) {
-			if (dd->last_rounded_m4xen)
-				v |=3D dd->m4xen_mask;
-			else
-				v &=3D ~dd->m4xen_mask;
-		}
-
-		if (dd->lpmode_mask) {
-			if (dd->last_rounded_lpmode)
-				v |=3D dd->lpmode_mask;
-			else
-				v &=3D ~dd->lpmode_mask;
-		}
-
-		omap2_clk_writel(v, clk, dd->control_reg);
-	}
-
-	/* We let the clock framework set the other output dividers later */
-
-	/* REVISIT: Set ramp-up delay? */
-
-	_omap3_noncore_dpll_lock(clk);
-
-	return 0;
-}
-
-/* Public functions */
-
-/**
- * omap3_dpll_recalc - recalculate DPLL rate
- * @clk: DPLL struct clk
- *
- * Recalculate and propagate the DPLL rate.
- */
-unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long paren=
t_rate)
-{
-	struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
-
-	return omap2_get_dpll_rate(clk);
-}
-
-/* Non-CORE DPLL (e.g., DPLLs that do not control SDRC) clock function=
s */
-
-/**
- * omap3_noncore_dpll_enable - instruct a DPLL to enter bypass or lock=
 mode
- * @clk: pointer to a DPLL struct clk
- *
- * Instructs a non-CORE DPLL to enable, e.g., to enter bypass or lock.
- * The choice of modes depends on the DPLL's programmed rate: if it is
- * the same as the DPLL's parent clock, it will enter bypass;
- * otherwise, it will enter lock.  This code will wait for the DPLL to
- * indicate readiness before returning, unless the DPLL takes too long
- * to enter the target state.  Intended to be used as the struct clk's
- * enable function.  If DPLL3 was passed in, or the DPLL does not
- * support low-power stop, or if the DPLL took too long to enter
- * bypass or lock, return -EINVAL; otherwise, return 0.
- */
-int omap3_noncore_dpll_enable(struct clk_hw *hw)
-{
-	struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
-	int r;
-	struct dpll_data *dd;
-	struct clk_hw *parent;
-
-	dd =3D clk->dpll_data;
-	if (!dd)
-		return -EINVAL;
-
-	if (clk->clkdm) {
-		r =3D clkdm_clk_enable(clk->clkdm, hw->clk);
-		if (r) {
-			WARN(1,
-			     "%s: could not enable %s's clockdomain %s: %d\n",
-			     __func__, __clk_get_name(hw->clk),
-			     clk->clkdm->name, r);
-			return r;
-		}
-	}
-
-	parent =3D __clk_get_hw(__clk_get_parent(hw->clk));
-
-	if (__clk_get_rate(hw->clk) =3D=3D __clk_get_rate(dd->clk_bypass)) {
-		WARN_ON(parent !=3D __clk_get_hw(dd->clk_bypass));
-		r =3D _omap3_noncore_dpll_bypass(clk);
-	} else {
-		WARN_ON(parent !=3D __clk_get_hw(dd->clk_ref));
-		r =3D _omap3_noncore_dpll_lock(clk);
-	}
-
-	return r;
-}
-
-/**
- * omap3_noncore_dpll_disable - instruct a DPLL to enter low-power sto=
p
- * @clk: pointer to a DPLL struct clk
- *
- * Instructs a non-CORE DPLL to enter low-power stop.  This function i=
s
- * intended for use in struct clkops.  No return value.
- */
-void omap3_noncore_dpll_disable(struct clk_hw *hw)
-{
-	struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
-
-	_omap3_noncore_dpll_stop(clk);
-	if (clk->clkdm)
-		clkdm_clk_disable(clk->clkdm, hw->clk);
-}
-
-
-/* Non-CORE DPLL rate set code */
-
-/**
- * omap3_noncore_dpll_determine_rate - determine rate for a DPLL
- * @hw: pointer to the clock to determine rate for
- * @rate: target rate for the DPLL
- * @best_parent_rate: pointer for returning best parent rate
- * @best_parent_clk: pointer for returning best parent clock
- *
- * Determines which DPLL mode to use for reaching a desired target rat=
e.
- * Checks whether the DPLL shall be in bypass or locked mode, and if
- * locked, calculates the M,N values for the DPLL via round-rate.
- * Returns a positive clock rate with success, negative error value
- * in failure.
- */
-long omap3_noncore_dpll_determine_rate(struct clk_hw *hw, unsigned lon=
g rate,
-				       unsigned long min_rate,
-				       unsigned long max_rate,
-				       unsigned long *best_parent_rate,
-				       struct clk_hw **best_parent_clk)
-{
-	struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
-	struct dpll_data *dd;
-
-	if (!hw || !rate)
-		return -EINVAL;
-
-	dd =3D clk->dpll_data;
-	if (!dd)
-		return -EINVAL;
-
-	if (__clk_get_rate(dd->clk_bypass) =3D=3D rate &&
-	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
-		*best_parent_clk =3D __clk_get_hw(dd->clk_bypass);
-	} else {
-		rate =3D omap2_dpll_round_rate(hw, rate, best_parent_rate);
-		*best_parent_clk =3D __clk_get_hw(dd->clk_ref);
-	}
-
-	*best_parent_rate =3D rate;
-
-	return rate;
-}
-
-/**
- * omap3_noncore_dpll_set_parent - set parent for a DPLL clock
- * @hw: pointer to the clock to set parent for
- * @index: parent index to select
- *
- * Sets parent for a DPLL clock. This sets the DPLL into bypass or
- * locked mode. Returns 0 with success, negative error value otherwise=
=2E
- */
-int omap3_noncore_dpll_set_parent(struct clk_hw *hw, u8 index)
-{
-	struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
-	int ret;
-
-	if (!hw)
-		return -EINVAL;
-
-	if (index)
-		ret =3D _omap3_noncore_dpll_bypass(clk);
-	else
-		ret =3D _omap3_noncore_dpll_lock(clk);
-
-	return ret;
-}
-
-/**
- * omap3_noncore_dpll_set_rate - set rate for a DPLL clock
- * @hw: pointer to the clock to set parent for
- * @rate: target rate for the clock
- * @parent_rate: rate of the parent clock
- *
- * Sets rate for a DPLL clock. First checks if the clock parent is
- * reference clock (in bypass mode, the rate of the clock can't be
- * changed) and proceeds with the rate change operation. Returns 0
- * with success, negative error value otherwise.
- */
-int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long parent_rate)
-{
-	struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
-	struct dpll_data *dd;
-	u16 freqsel =3D 0;
-	int ret;
-
-	if (!hw || !rate)
-		return -EINVAL;
-
-	dd =3D clk->dpll_data;
-	if (!dd)
-		return -EINVAL;
-
-	if (__clk_get_hw(__clk_get_parent(hw->clk)) !=3D
-	    __clk_get_hw(dd->clk_ref))
-		return -EINVAL;
-
-	if (dd->last_rounded_rate =3D=3D 0)
-		return -EINVAL;
-
-	/* Freqsel is available only on OMAP343X devices */
-	if (ti_clk_get_features()->flags & TI_CLK_DPLL_HAS_FREQSEL) {
-		freqsel =3D _omap3_dpll_compute_freqsel(clk, dd->last_rounded_n);
-		WARN_ON(!freqsel);
-	}
-
-	pr_debug("%s: %s: set rate: locking rate to %lu.\n", __func__,
-		 __clk_get_name(hw->clk), rate);
-
-	ret =3D omap3_noncore_dpll_program(clk, freqsel);
-
-	return ret;
-}
-
-/**
- * omap3_noncore_dpll_set_rate_and_parent - set rate and parent for a =
DPLL clock
- * @hw: pointer to the clock to set rate and parent for
- * @rate: target rate for the DPLL
- * @parent_rate: clock rate of the DPLL parent
- * @index: new parent index for the DPLL, 0 - reference, 1 - bypass
- *
- * Sets rate and parent for a DPLL clock. If new parent is the bypass
- * clock, only selects the parent. Otherwise proceeds with a rate
- * change, as this will effectively also change the parent as the
- * DPLL is put into locked mode. Returns 0 with success, negative erro=
r
- * value otherwise.
- */
-int omap3_noncore_dpll_set_rate_and_parent(struct clk_hw *hw,
-					   unsigned long rate,
-					   unsigned long parent_rate,
-					   u8 index)
-{
-	int ret;
-
-	if (!hw || !rate)
-		return -EINVAL;
-
-	/*
-	 * clk-ref at index[0], in which case we only need to set rate,
-	 * the parent will be changed automatically with the lock sequence.
-	 * With clk-bypass case we only need to change parent.
-	 */
-	if (index)
-		ret =3D omap3_noncore_dpll_set_parent(hw, index);
-	else
-		ret =3D omap3_noncore_dpll_set_rate(hw, rate, parent_rate);
-
-	return ret;
-}
-
-/* DPLL autoidle read/set code */
-
-/**
- * omap3_dpll_autoidle_read - read a DPLL's autoidle bits
- * @clk: struct clk * of the DPLL to read
- *
- * Return the DPLL's autoidle bits, shifted down to bit 0.  Returns
- * -EINVAL if passed a null pointer or if the struct clk does not
- * appear to refer to a DPLL.
- */
-u32 omap3_dpll_autoidle_read(struct clk_hw_omap *clk)
-{
-	const struct dpll_data *dd;
-	u32 v;
-
-	if (!clk || !clk->dpll_data)
-		return -EINVAL;
-
-	dd =3D clk->dpll_data;
-
-	if (!dd->autoidle_reg)
-		return -EINVAL;
-
-	v =3D omap2_clk_readl(clk, dd->autoidle_reg);
-	v &=3D dd->autoidle_mask;
-	v >>=3D __ffs(dd->autoidle_mask);
-
-	return v;
-}
-
-/**
- * omap3_dpll_allow_idle - enable DPLL autoidle bits
- * @clk: struct clk * of the DPLL to operate on
- *
- * Enable DPLL automatic idle control.  This automatic idle mode
- * switching takes effect only when the DPLL is locked, at least on
- * OMAP3430.  The DPLL will enter low-power stop when its downstream
- * clocks are gated.  No return value.
- */
-void omap3_dpll_allow_idle(struct clk_hw_omap *clk)
-{
-	const struct dpll_data *dd;
-	u32 v;
-
-	if (!clk || !clk->dpll_data)
-		return;
-
-	dd =3D clk->dpll_data;
-
-	if (!dd->autoidle_reg)
-		return;
-
-	/*
-	 * REVISIT: CORE DPLL can optionally enter low-power bypass
-	 * by writing 0x5 instead of 0x1.  Add some mechanism to
-	 * optionally enter this mode.
-	 */
-	v =3D omap2_clk_readl(clk, dd->autoidle_reg);
-	v &=3D ~dd->autoidle_mask;
-	v |=3D DPLL_AUTOIDLE_LOW_POWER_STOP << __ffs(dd->autoidle_mask);
-	omap2_clk_writel(v, clk, dd->autoidle_reg);
-
-}
-
-/**
- * omap3_dpll_deny_idle - prevent DPLL from automatically idling
- * @clk: struct clk * of the DPLL to operate on
- *
- * Disable DPLL automatic idle control.  No return value.
- */
-void omap3_dpll_deny_idle(struct clk_hw_omap *clk)
-{
-	const struct dpll_data *dd;
-	u32 v;
-
-	if (!clk || !clk->dpll_data)
-		return;
-
-	dd =3D clk->dpll_data;
-
-	if (!dd->autoidle_reg)
-		return;
-
-	v =3D omap2_clk_readl(clk, dd->autoidle_reg);
-	v &=3D ~dd->autoidle_mask;
-	v |=3D DPLL_AUTOIDLE_DISABLE << __ffs(dd->autoidle_mask);
-	omap2_clk_writel(v, clk, dd->autoidle_reg);
-
-}
-
-/* Clock control for DPLL outputs */
-
-/* Find the parent DPLL for the given clkoutx2 clock */
-static struct clk_hw_omap *omap3_find_clkoutx2_dpll(struct clk_hw *hw)
-{
-	struct clk_hw_omap *pclk =3D NULL;
-	struct clk *parent;
-
-	/* Walk up the parents of clk, looking for a DPLL */
-	do {
-		do {
-			parent =3D __clk_get_parent(hw->clk);
-			hw =3D __clk_get_hw(parent);
-		} while (hw && (__clk_get_flags(hw->clk) & CLK_IS_BASIC));
-		if (!hw)
-			break;
-		pclk =3D to_clk_hw_omap(hw);
-	} while (pclk && !pclk->dpll_data);
-
-	/* clk does not have a DPLL as a parent?  error in the clock data */
-	if (!pclk) {
-		WARN_ON(1);
-		return NULL;
-	}
-
-	return pclk;
-}
-
-/**
- * omap3_clkoutx2_recalc - recalculate DPLL X2 output virtual clock ra=
te
- * @clk: DPLL output struct clk
- *
- * Using parent clock DPLL data, look up DPLL state.  If locked, set o=
ur
- * rate to the dpll_clk * 2; otherwise, just use dpll_clk.
- */
-unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
-				    unsigned long parent_rate)
-{
-	const struct dpll_data *dd;
-	unsigned long rate;
-	u32 v;
-	struct clk_hw_omap *pclk =3D NULL;
-
-	if (!parent_rate)
-		return 0;
-
-	pclk =3D omap3_find_clkoutx2_dpll(hw);
-
-	if (!pclk)
-		return 0;
-
-	dd =3D pclk->dpll_data;
-
-	WARN_ON(!dd->enable_mask);
-
-	v =3D omap2_clk_readl(pclk, dd->control_reg) & dd->enable_mask;
-	v >>=3D __ffs(dd->enable_mask);
-	if ((v !=3D OMAP3XXX_EN_DPLL_LOCKED) || (dd->flags & DPLL_J_TYPE))
-		rate =3D parent_rate;
-	else
-		rate =3D parent_rate * 2;
-	return rate;
-}
-
-int omap3_clkoutx2_set_rate(struct clk_hw *hw, unsigned long rate,
-					unsigned long parent_rate)
-{
-	return 0;
-}
-
-long omap3_clkoutx2_round_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long *prate)
-{
-	const struct dpll_data *dd;
-	u32 v;
-	struct clk_hw_omap *pclk =3D NULL;
-
-	if (!*prate)
-		return 0;
-
-	pclk =3D omap3_find_clkoutx2_dpll(hw);
-
-	if (!pclk)
-		return 0;
-
-	dd =3D pclk->dpll_data;
-
-	/* TYPE J does not have a clkoutx2 */
-	if (dd->flags & DPLL_J_TYPE) {
-		*prate =3D __clk_round_rate(__clk_get_parent(pclk->hw.clk), rate);
-		return *prate;
-	}
-
-	WARN_ON(!dd->enable_mask);
-
-	v =3D omap2_clk_readl(pclk, dd->control_reg) & dd->enable_mask;
-	v >>=3D __ffs(dd->enable_mask);
-
-	/* If in bypass, the rate is fixed to the bypass rate*/
-	if (v !=3D OMAP3XXX_EN_DPLL_LOCKED)
-		return *prate;
-
-	if (__clk_get_flags(hw->clk) & CLK_SET_RATE_PARENT) {
-		unsigned long best_parent;
-
-		best_parent =3D (rate / 2);
-		*prate =3D __clk_round_rate(__clk_get_parent(hw->clk),
-				best_parent);
-	}
-
-	return *prate * 2;
-}
-
-/* OMAP3/4 non-CORE DPLL clkops */
-const struct clk_hw_omap_ops clkhwops_omap3_dpll =3D {
-	.allow_idle	=3D omap3_dpll_allow_idle,
-	.deny_idle	=3D omap3_dpll_deny_idle,
-};
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 23cd726..fe2cfa2 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,7 +1,7 @@
 obj-y					+=3D clk.o autoidle.o clockdomain.o
 clk-common				=3D dpll.o composite.o divider.o gate.o \
 					  fixed-factor.o mux.o apll.o \
-					  clkt_dpll.o clkt_iclk.o
+					  clkt_dpll.o clkt_iclk.o dpll3xxx.o
 obj-$(CONFIG_SOC_AM33XX)		+=3D $(clk-common) clk-33xx.o
 obj-$(CONFIG_SOC_TI81XX)		+=3D $(clk-common) fapll.o clk-816x.o
 obj-$(CONFIG_ARCH_OMAP2)		+=3D $(clk-common) interface.o clk-2xxx.o
diff --git a/drivers/clk/ti/clk-3xxx.c b/drivers/clk/ti/clk-3xxx.c
index bb3b883..5489ad8 100644
--- a/drivers/clk/ti/clk-3xxx.c
+++ b/drivers/clk/ti/clk-3xxx.c
@@ -21,6 +21,13 @@
=20
 #include "clock.h"
=20
+/*
+ * DPLL5_FREQ_FOR_USBHOST: USBHOST and USBTLL are the only clocks
+ * that are sourced by DPLL5, and both of these require this clock
+ * to be at 120 MHz for proper operation.
+ */
+#define DPLL5_FREQ_FOR_USBHOST		120000000
+
 static struct ti_dt_clk omap3xxx_clks[] =3D {
 	DT_CLK(NULL, "apb_pclk", "dummy_apb_pclk"),
 	DT_CLK(NULL, "omap_32k_fck", "omap_32k_fck"),
@@ -325,6 +332,30 @@ enum {
 	OMAP3_SOC_OMAP3630,
 };
=20
+/**
+ * omap3_clk_lock_dpll5 - locks DPLL5
+ *
+ * Locks DPLL5 to a pre-defined frequency. This is required for proper
+ * operation of USB.
+ */
+void __init omap3_clk_lock_dpll5(void)
+{
+	struct clk *dpll5_clk;
+	struct clk *dpll5_m2_clk;
+
+	dpll5_clk =3D clk_get(NULL, "dpll5_ck");
+	clk_set_rate(dpll5_clk, DPLL5_FREQ_FOR_USBHOST);
+	clk_prepare_enable(dpll5_clk);
+
+	/* Program dpll5_m2_clk divider for no division */
+	dpll5_m2_clk =3D clk_get(NULL, "dpll5_m2_ck");
+	clk_prepare_enable(dpll5_m2_clk);
+	clk_set_rate(dpll5_m2_clk, DPLL5_FREQ_FOR_USBHOST);
+
+	clk_disable_unprepare(dpll5_m2_clk);
+	clk_disable_unprepare(dpll5_clk);
+}
+
 static int __init omap3xxx_dt_clk_init(int soc_type)
 {
 	if (soc_type =3D=3D OMAP3_SOC_AM35XX || soc_type =3D=3D OMAP3_SOC_OMA=
P3630 ||
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 4b26af8..688d9e4 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -173,11 +173,38 @@ void omap2_init_clk_hw_omap_clocks(struct clk *cl=
k);
 int of_ti_clk_autoidle_setup(struct device_node *node);
 void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clock=
s);
=20
+extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
 extern const struct clk_hw_omap_ops clkhwops_iclk;
 extern const struct clk_hw_omap_ops clkhwops_iclk_wait;
=20
 u8 omap2_init_dpll_parent(struct clk_hw *hw);
+int omap3_noncore_dpll_enable(struct clk_hw *hw);
+void omap3_noncore_dpll_disable(struct clk_hw *hw);
+int omap3_noncore_dpll_set_parent(struct clk_hw *hw, u8 index);
+int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate);
+int omap3_noncore_dpll_set_rate_and_parent(struct clk_hw *hw,
+					   unsigned long rate,
+					   unsigned long parent_rate,
+					   u8 index);
+long omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
+				       unsigned long rate,
+				       unsigned long min_rate,
+				       unsigned long max_rate,
+				       unsigned long *best_parent_rate,
+				       struct clk_hw **best_parent_clk);
+long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rat=
e,
+			   unsigned long *parent_rate);
+unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
+				    unsigned long parent_rate);
+
+unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long paren=
t_rate);
+int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
+			 unsigned long parent_rate);
+int omap3_dpll4_set_rate_and_parent(struct clk_hw *hw, unsigned long r=
ate,
+				    unsigned long parent_rate, u8 index);
+void omap3_clk_lock_dpll5(void);
=20
 unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
 					 unsigned long parent_rate);
diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
new file mode 100644
index 0000000..22d77a3
--- /dev/null
+++ b/drivers/clk/ti/dpll3xxx.c
@@ -0,0 +1,825 @@
+/*
+ * OMAP3/4 - specific DPLL control functions
+ *
+ * Copyright (C) 2009-2010 Texas Instruments, Inc.
+ * Copyright (C) 2009-2010 Nokia Corporation
+ *
+ * Written by Paul Walmsley
+ * Testing and integration fixes by Jouni H=C3=B6gander
+ *
+ * 36xx support added by Vishwanath BS, Richard Woodruff, and Nishanth
+ * Menon
+ *
+ * Parts of this code are based on code written by
+ * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/bitops.h>
+#include <linux/clkdev.h>
+#include <linux/clk/ti.h>
+
+#include "clock.h"
+
+/* CM_AUTOIDLE_PLL*.AUTO_* bit values */
+#define DPLL_AUTOIDLE_DISABLE			0x0
+#define DPLL_AUTOIDLE_LOW_POWER_STOP		0x1
+
+#define MAX_DPLL_WAIT_TRIES		1000000
+
+#define OMAP3XXX_EN_DPLL_LOCKED		0x7
+
+/* Forward declarations */
+static u32 omap3_dpll_autoidle_read(struct clk_hw_omap *clk);
+static void omap3_dpll_deny_idle(struct clk_hw_omap *clk);
+static void omap3_dpll_allow_idle(struct clk_hw_omap *clk);
+
+/* Private functions */
+
+/* _omap3_dpll_write_clken - write clken_bits arg to a DPLL's enable b=
its */
+static void _omap3_dpll_write_clken(struct clk_hw_omap *clk, u8 clken_=
bits)
+{
+	const struct dpll_data *dd;
+	u32 v;
+
+	dd =3D clk->dpll_data;
+
+	v =3D ti_clk_ll_ops->clk_readl(dd->control_reg);
+	v &=3D ~dd->enable_mask;
+	v |=3D clken_bits << __ffs(dd->enable_mask);
+	ti_clk_ll_ops->clk_writel(v, dd->control_reg);
+}
+
+/* _omap3_wait_dpll_status: wait for a DPLL to enter a specific state =
*/
+static int _omap3_wait_dpll_status(struct clk_hw_omap *clk, u8 state)
+{
+	const struct dpll_data *dd;
+	int i =3D 0;
+	int ret =3D -EINVAL;
+	const char *clk_name;
+
+	dd =3D clk->dpll_data;
+	clk_name =3D __clk_get_name(clk->hw.clk);
+
+	state <<=3D __ffs(dd->idlest_mask);
+
+	while (((ti_clk_ll_ops->clk_readl(dd->idlest_reg) & dd->idlest_mask)
+		!=3D state) && i < MAX_DPLL_WAIT_TRIES) {
+		i++;
+		udelay(1);
+	}
+
+	if (i =3D=3D MAX_DPLL_WAIT_TRIES) {
+		pr_err("clock: %s failed transition to '%s'\n",
+		       clk_name, (state) ? "locked" : "bypassed");
+	} else {
+		pr_debug("clock: %s transition to '%s' in %d loops\n",
+			 clk_name, (state) ? "locked" : "bypassed", i);
+
+		ret =3D 0;
+	}
+
+	return ret;
+}
+
+/* From 3430 TRM ES2 4.7.6.2 */
+static u16 _omap3_dpll_compute_freqsel(struct clk_hw_omap *clk, u8 n)
+{
+	unsigned long fint;
+	u16 f =3D 0;
+
+	fint =3D __clk_get_rate(clk->dpll_data->clk_ref) / n;
+
+	pr_debug("clock: fint is %lu\n", fint);
+
+	if (fint >=3D 750000 && fint <=3D 1000000)
+		f =3D 0x3;
+	else if (fint > 1000000 && fint <=3D 1250000)
+		f =3D 0x4;
+	else if (fint > 1250000 && fint <=3D 1500000)
+		f =3D 0x5;
+	else if (fint > 1500000 && fint <=3D 1750000)
+		f =3D 0x6;
+	else if (fint > 1750000 && fint <=3D 2100000)
+		f =3D 0x7;
+	else if (fint > 7500000 && fint <=3D 10000000)
+		f =3D 0xB;
+	else if (fint > 10000000 && fint <=3D 12500000)
+		f =3D 0xC;
+	else if (fint > 12500000 && fint <=3D 15000000)
+		f =3D 0xD;
+	else if (fint > 15000000 && fint <=3D 17500000)
+		f =3D 0xE;
+	else if (fint > 17500000 && fint <=3D 21000000)
+		f =3D 0xF;
+	else
+		pr_debug("clock: unknown freqsel setting for %d\n", n);
+
+	return f;
+}
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
+static int _omap3_noncore_dpll_lock(struct clk_hw_omap *clk)
+{
+	const struct dpll_data *dd;
+	u8 ai;
+	u8 state =3D 1;
+	int r =3D 0;
+
+	pr_debug("clock: locking DPLL %s\n", __clk_get_name(clk->hw.clk));
+
+	dd =3D clk->dpll_data;
+	state <<=3D __ffs(dd->idlest_mask);
+
+	/* Check if already locked */
+	if ((ti_clk_ll_ops->clk_readl(dd->idlest_reg) & dd->idlest_mask) =3D=3D
+	    state)
+		goto done;
+
+	ai =3D omap3_dpll_autoidle_read(clk);
+
+	if (ai)
+		omap3_dpll_deny_idle(clk);
+
+	_omap3_dpll_write_clken(clk, DPLL_LOCKED);
+
+	r =3D _omap3_wait_dpll_status(clk, 1);
+
+	if (ai)
+		omap3_dpll_allow_idle(clk);
+
+done:
+	return r;
+}
+
+/*
+ * _omap3_noncore_dpll_bypass - instruct a DPLL to bypass and wait for=
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
+static int _omap3_noncore_dpll_bypass(struct clk_hw_omap *clk)
+{
+	int r;
+	u8 ai;
+
+	if (!(clk->dpll_data->modes & (1 << DPLL_LOW_POWER_BYPASS)))
+		return -EINVAL;
+
+	pr_debug("clock: configuring DPLL %s for low-power bypass\n",
+		 __clk_get_name(clk->hw.clk));
+
+	ai =3D omap3_dpll_autoidle_read(clk);
+
+	_omap3_dpll_write_clken(clk, DPLL_LOW_POWER_BYPASS);
+
+	r =3D _omap3_wait_dpll_status(clk, 0);
+
+	if (ai)
+		omap3_dpll_allow_idle(clk);
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
+static int _omap3_noncore_dpll_stop(struct clk_hw_omap *clk)
+{
+	u8 ai;
+
+	if (!(clk->dpll_data->modes & (1 << DPLL_LOW_POWER_STOP)))
+		return -EINVAL;
+
+	pr_debug("clock: stopping DPLL %s\n", __clk_get_name(clk->hw.clk));
+
+	ai =3D omap3_dpll_autoidle_read(clk);
+
+	_omap3_dpll_write_clken(clk, DPLL_LOW_POWER_STOP);
+
+	if (ai)
+		omap3_dpll_allow_idle(clk);
+
+	return 0;
+}
+
+/**
+ * _lookup_dco - Lookup DCO used by j-type DPLL
+ * @clk: pointer to a DPLL struct clk
+ * @dco: digital control oscillator selector
+ * @m: DPLL multiplier to set
+ * @n: DPLL divider to set
+ *
+ * See 36xx TRM section 3.5.3.3.3.2 "Type B DPLL (Low-Jitter)"
+ *
+ * XXX This code is not needed for 3430/AM35xx; can it be optimized
+ * out in non-multi-OMAP builds for those chips?
+ */
+static void _lookup_dco(struct clk_hw_omap *clk, u8 *dco, u16 m, u8 n)
+{
+	unsigned long fint, clkinp; /* watch out for overflow */
+
+	clkinp =3D __clk_get_rate(__clk_get_parent(clk->hw.clk));
+	fint =3D (clkinp / n) * m;
+
+	if (fint < 1000000000)
+		*dco =3D 2;
+	else
+		*dco =3D 4;
+}
+
+/**
+ * _lookup_sddiv - Calculate sigma delta divider for j-type DPLL
+ * @clk: pointer to a DPLL struct clk
+ * @sd_div: target sigma-delta divider
+ * @m: DPLL multiplier to set
+ * @n: DPLL divider to set
+ *
+ * See 36xx TRM section 3.5.3.3.3.2 "Type B DPLL (Low-Jitter)"
+ *
+ * XXX This code is not needed for 3430/AM35xx; can it be optimized
+ * out in non-multi-OMAP builds for those chips?
+ */
+static void _lookup_sddiv(struct clk_hw_omap *clk, u8 *sd_div, u16 m, =
u8 n)
+{
+	unsigned long clkinp, sd; /* watch out for overflow */
+	int mod1, mod2;
+
+	clkinp =3D __clk_get_rate(__clk_get_parent(clk->hw.clk));
+
+	/*
+	 * target sigma-delta to near 250MHz
+	 * sd =3D ceil[(m/(n+1)) * (clkinp_MHz / 250)]
+	 */
+	clkinp /=3D 100000; /* shift from MHz to 10*Hz for 38.4 and 19.2 */
+	mod1 =3D (clkinp * m) % (250 * n);
+	sd =3D (clkinp * m) / (250 * n);
+	mod2 =3D sd % 10;
+	sd /=3D 10;
+
+	if (mod1 || mod2)
+		sd++;
+	*sd_div =3D sd;
+}
+
+/*
+ * _omap3_noncore_dpll_program - set non-core DPLL M,N values directly
+ * @clk:	struct clk * of DPLL to set
+ * @freqsel:	FREQSEL value to set
+ *
+ * Program the DPLL with the last M, N values calculated, and wait for
+ * the DPLL to lock. Returns -EINVAL upon error, or 0 upon success.
+ */
+static int omap3_noncore_dpll_program(struct clk_hw_omap *clk, u16 fre=
qsel)
+{
+	struct dpll_data *dd =3D clk->dpll_data;
+	u8 dco, sd_div;
+	u32 v;
+
+	/* 3430 ES2 TRM: 4.7.6.9 DPLL Programming Sequence */
+	_omap3_noncore_dpll_bypass(clk);
+
+	/*
+	 * Set jitter correction. Jitter correction applicable for OMAP343X
+	 * only since freqsel field is no longer present on other devices.
+	 */
+	if (ti_clk_get_features()->flags & TI_CLK_DPLL_HAS_FREQSEL) {
+		v =3D ti_clk_ll_ops->clk_readl(dd->control_reg);
+		v &=3D ~dd->freqsel_mask;
+		v |=3D freqsel << __ffs(dd->freqsel_mask);
+		ti_clk_ll_ops->clk_writel(v, dd->control_reg);
+	}
+
+	/* Set DPLL multiplier, divider */
+	v =3D ti_clk_ll_ops->clk_readl(dd->mult_div1_reg);
+
+	/* Handle Duty Cycle Correction */
+	if (dd->dcc_mask) {
+		if (dd->last_rounded_rate >=3D dd->dcc_rate)
+			v |=3D dd->dcc_mask; /* Enable DCC */
+		else
+			v &=3D ~dd->dcc_mask; /* Disable DCC */
+	}
+
+	v &=3D ~(dd->mult_mask | dd->div1_mask);
+	v |=3D dd->last_rounded_m << __ffs(dd->mult_mask);
+	v |=3D (dd->last_rounded_n - 1) << __ffs(dd->div1_mask);
+
+	/* Configure dco and sd_div for dplls that have these fields */
+	if (dd->dco_mask) {
+		_lookup_dco(clk, &dco, dd->last_rounded_m, dd->last_rounded_n);
+		v &=3D ~(dd->dco_mask);
+		v |=3D dco << __ffs(dd->dco_mask);
+	}
+	if (dd->sddiv_mask) {
+		_lookup_sddiv(clk, &sd_div, dd->last_rounded_m,
+			      dd->last_rounded_n);
+		v &=3D ~(dd->sddiv_mask);
+		v |=3D sd_div << __ffs(dd->sddiv_mask);
+	}
+
+	ti_clk_ll_ops->clk_writel(v, dd->mult_div1_reg);
+
+	/* Set 4X multiplier and low-power mode */
+	if (dd->m4xen_mask || dd->lpmode_mask) {
+		v =3D ti_clk_ll_ops->clk_readl(dd->control_reg);
+
+		if (dd->m4xen_mask) {
+			if (dd->last_rounded_m4xen)
+				v |=3D dd->m4xen_mask;
+			else
+				v &=3D ~dd->m4xen_mask;
+		}
+
+		if (dd->lpmode_mask) {
+			if (dd->last_rounded_lpmode)
+				v |=3D dd->lpmode_mask;
+			else
+				v &=3D ~dd->lpmode_mask;
+		}
+
+		ti_clk_ll_ops->clk_writel(v, dd->control_reg);
+	}
+
+	/* We let the clock framework set the other output dividers later */
+
+	/* REVISIT: Set ramp-up delay? */
+
+	_omap3_noncore_dpll_lock(clk);
+
+	return 0;
+}
+
+/* Public functions */
+
+/**
+ * omap3_dpll_recalc - recalculate DPLL rate
+ * @clk: DPLL struct clk
+ *
+ * Recalculate and propagate the DPLL rate.
+ */
+unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long paren=
t_rate)
+{
+	struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
+
+	return omap2_get_dpll_rate(clk);
+}
+
+/* Non-CORE DPLL (e.g., DPLLs that do not control SDRC) clock function=
s */
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
+int omap3_noncore_dpll_enable(struct clk_hw *hw)
+{
+	struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
+	int r;
+	struct dpll_data *dd;
+	struct clk_hw *parent;
+
+	dd =3D clk->dpll_data;
+	if (!dd)
+		return -EINVAL;
+
+	if (clk->clkdm) {
+		r =3D ti_clk_ll_ops->clkdm_clk_enable(clk->clkdm, hw->clk);
+		if (r) {
+			WARN(1,
+			     "%s: could not enable %s's clockdomain %s: %d\n",
+			     __func__, __clk_get_name(hw->clk),
+			     clk->clkdm_name, r);
+			return r;
+		}
+	}
+
+	parent =3D __clk_get_hw(__clk_get_parent(hw->clk));
+
+	if (__clk_get_rate(hw->clk) =3D=3D __clk_get_rate(dd->clk_bypass)) {
+		WARN_ON(parent !=3D __clk_get_hw(dd->clk_bypass));
+		r =3D _omap3_noncore_dpll_bypass(clk);
+	} else {
+		WARN_ON(parent !=3D __clk_get_hw(dd->clk_ref));
+		r =3D _omap3_noncore_dpll_lock(clk);
+	}
+
+	return r;
+}
+
+/**
+ * omap3_noncore_dpll_disable - instruct a DPLL to enter low-power sto=
p
+ * @clk: pointer to a DPLL struct clk
+ *
+ * Instructs a non-CORE DPLL to enter low-power stop.  This function i=
s
+ * intended for use in struct clkops.  No return value.
+ */
+void omap3_noncore_dpll_disable(struct clk_hw *hw)
+{
+	struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
+
+	_omap3_noncore_dpll_stop(clk);
+	if (clk->clkdm)
+		ti_clk_ll_ops->clkdm_clk_disable(clk->clkdm, hw->clk);
+}
+
+/* Non-CORE DPLL rate set code */
+
+/**
+ * omap3_noncore_dpll_determine_rate - determine rate for a DPLL
+ * @hw: pointer to the clock to determine rate for
+ * @rate: target rate for the DPLL
+ * @best_parent_rate: pointer for returning best parent rate
+ * @best_parent_clk: pointer for returning best parent clock
+ *
+ * Determines which DPLL mode to use for reaching a desired target rat=
e.
+ * Checks whether the DPLL shall be in bypass or locked mode, and if
+ * locked, calculates the M,N values for the DPLL via round-rate.
+ * Returns a positive clock rate with success, negative error value
+ * in failure.
+ */
+long omap3_noncore_dpll_determine_rate(struct clk_hw *hw, unsigned lon=
g rate,
+				       unsigned long min_rate,
+				       unsigned long max_rate,
+				       unsigned long *best_parent_rate,
+				       struct clk_hw **best_parent_clk)
+{
+	struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
+	struct dpll_data *dd;
+
+	if (!hw || !rate)
+		return -EINVAL;
+
+	dd =3D clk->dpll_data;
+	if (!dd)
+		return -EINVAL;
+
+	if (__clk_get_rate(dd->clk_bypass) =3D=3D rate &&
+	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
+		*best_parent_clk =3D __clk_get_hw(dd->clk_bypass);
+	} else {
+		rate =3D omap2_dpll_round_rate(hw, rate, best_parent_rate);
+		*best_parent_clk =3D __clk_get_hw(dd->clk_ref);
+	}
+
+	*best_parent_rate =3D rate;
+
+	return rate;
+}
+
+/**
+ * omap3_noncore_dpll_set_parent - set parent for a DPLL clock
+ * @hw: pointer to the clock to set parent for
+ * @index: parent index to select
+ *
+ * Sets parent for a DPLL clock. This sets the DPLL into bypass or
+ * locked mode. Returns 0 with success, negative error value otherwise=
=2E
+ */
+int omap3_noncore_dpll_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
+	int ret;
+
+	if (!hw)
+		return -EINVAL;
+
+	if (index)
+		ret =3D _omap3_noncore_dpll_bypass(clk);
+	else
+		ret =3D _omap3_noncore_dpll_lock(clk);
+
+	return ret;
+}
+
+/**
+ * omap3_noncore_dpll_set_rate - set rate for a DPLL clock
+ * @hw: pointer to the clock to set parent for
+ * @rate: target rate for the clock
+ * @parent_rate: rate of the parent clock
+ *
+ * Sets rate for a DPLL clock. First checks if the clock parent is
+ * reference clock (in bypass mode, the rate of the clock can't be
+ * changed) and proceeds with the rate change operation. Returns 0
+ * with success, negative error value otherwise.
+ */
+int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct clk_hw_omap *clk =3D to_clk_hw_omap(hw);
+	struct dpll_data *dd;
+	u16 freqsel =3D 0;
+	int ret;
+
+	if (!hw || !rate)
+		return -EINVAL;
+
+	dd =3D clk->dpll_data;
+	if (!dd)
+		return -EINVAL;
+
+	if (__clk_get_hw(__clk_get_parent(hw->clk)) !=3D
+	    __clk_get_hw(dd->clk_ref))
+		return -EINVAL;
+
+	if (dd->last_rounded_rate =3D=3D 0)
+		return -EINVAL;
+
+	/* Freqsel is available only on OMAP343X devices */
+	if (ti_clk_get_features()->flags & TI_CLK_DPLL_HAS_FREQSEL) {
+		freqsel =3D _omap3_dpll_compute_freqsel(clk, dd->last_rounded_n);
+		WARN_ON(!freqsel);
+	}
+
+	pr_debug("%s: %s: set rate: locking rate to %lu.\n", __func__,
+		 __clk_get_name(hw->clk), rate);
+
+	ret =3D omap3_noncore_dpll_program(clk, freqsel);
+
+	return ret;
+}
+
+/**
+ * omap3_noncore_dpll_set_rate_and_parent - set rate and parent for a =
DPLL clock
+ * @hw: pointer to the clock to set rate and parent for
+ * @rate: target rate for the DPLL
+ * @parent_rate: clock rate of the DPLL parent
+ * @index: new parent index for the DPLL, 0 - reference, 1 - bypass
+ *
+ * Sets rate and parent for a DPLL clock. If new parent is the bypass
+ * clock, only selects the parent. Otherwise proceeds with a rate
+ * change, as this will effectively also change the parent as the
+ * DPLL is put into locked mode. Returns 0 with success, negative erro=
r
+ * value otherwise.
+ */
+int omap3_noncore_dpll_set_rate_and_parent(struct clk_hw *hw,
+					   unsigned long rate,
+					   unsigned long parent_rate,
+					   u8 index)
+{
+	int ret;
+
+	if (!hw || !rate)
+		return -EINVAL;
+
+	/*
+	 * clk-ref at index[0], in which case we only need to set rate,
+	 * the parent will be changed automatically with the lock sequence.
+	 * With clk-bypass case we only need to change parent.
+	 */
+	if (index)
+		ret =3D omap3_noncore_dpll_set_parent(hw, index);
+	else
+		ret =3D omap3_noncore_dpll_set_rate(hw, rate, parent_rate);
+
+	return ret;
+}
+
+/* DPLL autoidle read/set code */
+
+/**
+ * omap3_dpll_autoidle_read - read a DPLL's autoidle bits
+ * @clk: struct clk * of the DPLL to read
+ *
+ * Return the DPLL's autoidle bits, shifted down to bit 0.  Returns
+ * -EINVAL if passed a null pointer or if the struct clk does not
+ * appear to refer to a DPLL.
+ */
+static u32 omap3_dpll_autoidle_read(struct clk_hw_omap *clk)
+{
+	const struct dpll_data *dd;
+	u32 v;
+
+	if (!clk || !clk->dpll_data)
+		return -EINVAL;
+
+	dd =3D clk->dpll_data;
+
+	if (!dd->autoidle_reg)
+		return -EINVAL;
+
+	v =3D ti_clk_ll_ops->clk_readl(dd->autoidle_reg);
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
+static void omap3_dpll_allow_idle(struct clk_hw_omap *clk)
+{
+	const struct dpll_data *dd;
+	u32 v;
+
+	if (!clk || !clk->dpll_data)
+		return;
+
+	dd =3D clk->dpll_data;
+
+	if (!dd->autoidle_reg)
+		return;
+
+	/*
+	 * REVISIT: CORE DPLL can optionally enter low-power bypass
+	 * by writing 0x5 instead of 0x1.  Add some mechanism to
+	 * optionally enter this mode.
+	 */
+	v =3D ti_clk_ll_ops->clk_readl(dd->autoidle_reg);
+	v &=3D ~dd->autoidle_mask;
+	v |=3D DPLL_AUTOIDLE_LOW_POWER_STOP << __ffs(dd->autoidle_mask);
+	ti_clk_ll_ops->clk_writel(v, dd->autoidle_reg);
+}
+
+/**
+ * omap3_dpll_deny_idle - prevent DPLL from automatically idling
+ * @clk: struct clk * of the DPLL to operate on
+ *
+ * Disable DPLL automatic idle control.  No return value.
+ */
+static void omap3_dpll_deny_idle(struct clk_hw_omap *clk)
+{
+	const struct dpll_data *dd;
+	u32 v;
+
+	if (!clk || !clk->dpll_data)
+		return;
+
+	dd =3D clk->dpll_data;
+
+	if (!dd->autoidle_reg)
+		return;
+
+	v =3D ti_clk_ll_ops->clk_readl(dd->autoidle_reg);
+	v &=3D ~dd->autoidle_mask;
+	v |=3D DPLL_AUTOIDLE_DISABLE << __ffs(dd->autoidle_mask);
+	ti_clk_ll_ops->clk_writel(v, dd->autoidle_reg);
+}
+
+/* Clock control for DPLL outputs */
+
+/* Find the parent DPLL for the given clkoutx2 clock */
+static struct clk_hw_omap *omap3_find_clkoutx2_dpll(struct clk_hw *hw)
+{
+	struct clk_hw_omap *pclk =3D NULL;
+	struct clk *parent;
+
+	/* Walk up the parents of clk, looking for a DPLL */
+	do {
+		do {
+			parent =3D __clk_get_parent(hw->clk);
+			hw =3D __clk_get_hw(parent);
+		} while (hw && (__clk_get_flags(hw->clk) & CLK_IS_BASIC));
+		if (!hw)
+			break;
+		pclk =3D to_clk_hw_omap(hw);
+	} while (pclk && !pclk->dpll_data);
+
+	/* clk does not have a DPLL as a parent?  error in the clock data */
+	if (!pclk) {
+		WARN_ON(1);
+		return NULL;
+	}
+
+	return pclk;
+}
+
+/**
+ * omap3_clkoutx2_recalc - recalculate DPLL X2 output virtual clock ra=
te
+ * @clk: DPLL output struct clk
+ *
+ * Using parent clock DPLL data, look up DPLL state.  If locked, set o=
ur
+ * rate to the dpll_clk * 2; otherwise, just use dpll_clk.
+ */
+unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
+				    unsigned long parent_rate)
+{
+	const struct dpll_data *dd;
+	unsigned long rate;
+	u32 v;
+	struct clk_hw_omap *pclk =3D NULL;
+
+	if (!parent_rate)
+		return 0;
+
+	pclk =3D omap3_find_clkoutx2_dpll(hw);
+
+	if (!pclk)
+		return 0;
+
+	dd =3D pclk->dpll_data;
+
+	WARN_ON(!dd->enable_mask);
+
+	v =3D ti_clk_ll_ops->clk_readl(dd->control_reg) & dd->enable_mask;
+	v >>=3D __ffs(dd->enable_mask);
+	if ((v !=3D OMAP3XXX_EN_DPLL_LOCKED) || (dd->flags & DPLL_J_TYPE))
+		rate =3D parent_rate;
+	else
+		rate =3D parent_rate * 2;
+	return rate;
+}
+
+/* OMAP3/4 non-CORE DPLL clkops */
+const struct clk_hw_omap_ops clkhwops_omap3_dpll =3D {
+	.allow_idle	=3D omap3_dpll_allow_idle,
+	.deny_idle	=3D omap3_dpll_deny_idle,
+};
+
+/**
+ * omap3_dpll4_set_rate - set rate for omap3 per-dpll
+ * @hw: clock to change
+ * @rate: target rate for clock
+ * @parent_rate: rate of the parent clock
+ *
+ * Check if the current SoC supports the per-dpll reprogram operation
+ * or not, and then do the rate change if supported. Returns -EINVAL
+ * if not supported, 0 for success, and potential error codes from the
+ * clock rate change.
+ */
+int omap3_dpll4_set_rate(struct clk_hw *hw, unsigned long rate,
+			 unsigned long parent_rate)
+{
+	/*
+	 * According to the 12-5 CDP code from TI, "Limitation 2.5"
+	 * on 3430ES1 prevents us from changing DPLL multipliers or dividers
+	 * on DPLL4.
+	 */
+	if (ti_clk_get_features()->flags & TI_CLK_DPLL4_DENY_REPROGRAM) {
+		pr_err("clock: DPLL4 cannot change rate due to silicon 'Limitation 2=
=2E5' on 3430ES1.\n");
+		return -EINVAL;
+	}
+
+	return omap3_noncore_dpll_set_rate(hw, rate, parent_rate);
+}
+
+/**
+ * omap3_dpll4_set_rate_and_parent - set rate and parent for omap3 per=
-dpll
+ * @hw: clock to change
+ * @rate: target rate for clock
+ * @parent_rate: rate of the parent clock
+ * @index: parent index, 0 - reference clock, 1 - bypass clock
+ *
+ * Check if the current SoC support the per-dpll reprogram operation
+ * or not, and then do the rate + parent change if supported. Returns
+ * -EINVAL if not supported, 0 for success, and potential error codes
+ * from the clock rate change.
+ */
+int omap3_dpll4_set_rate_and_parent(struct clk_hw *hw, unsigned long r=
ate,
+				    unsigned long parent_rate, u8 index)
+{
+	if (ti_clk_get_features()->flags & TI_CLK_DPLL4_DENY_REPROGRAM) {
+		pr_err("clock: DPLL4 cannot change rate due to silicon 'Limitation 2=
=2E5' on 3430ES1.\n");
+		return -EINVAL;
+	}
+
+	return omap3_noncore_dpll_set_rate_and_parent(hw, rate, parent_rate,
+						      index);
+}
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 3ca818e..0f9d15f 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -271,41 +271,13 @@ extern const struct clk_ops ti_clk_mux_ops;
=20
 #define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
=20
-int omap3_noncore_dpll_enable(struct clk_hw *hw);
-void omap3_noncore_dpll_disable(struct clk_hw *hw);
-int omap3_noncore_dpll_set_parent(struct clk_hw *hw, u8 index);
-int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long parent_rate);
-int omap3_noncore_dpll_set_rate_and_parent(struct clk_hw *hw,
-					   unsigned long rate,
-					   unsigned long parent_rate,
-					   u8 index);
-long omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
-				       unsigned long rate,
-				       unsigned long min_rate,
-				       unsigned long max_rate,
-				       unsigned long *best_parent_rate,
-				       struct clk_hw **best_parent_clk);
-unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long paren=
t_rate);
-long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rat=
e,
-			   unsigned long *parent_rate);
 void omap2_init_clk_clkdm(struct clk_hw *clk);
-unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
-				    unsigned long parent_rate);
-int omap3_clkoutx2_set_rate(struct clk_hw *hw, unsigned long rate,
-					unsigned long parent_rate);
-long omap3_clkoutx2_round_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long *prate);
 int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 int omap2_clk_disable_autoidle_all(void);
 int omap2_clk_enable_autoidle_all(void);
 int omap2_clk_allow_idle(struct clk *clk);
 int omap2_clk_deny_idle(struct clk *clk);
-int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
-			 unsigned long parent_rate);
-int omap3_dpll4_set_rate_and_parent(struct clk_hw *hw, unsigned long r=
ate,
-				    unsigned long parent_rate, u8 index);
 int omap2_dflt_clk_enable(struct clk_hw *hw);
 void omap2_dflt_clk_disable(struct clk_hw *hw);
 int omap2_dflt_clk_is_enabled(struct clk_hw *hw);
@@ -317,7 +289,6 @@ void omap2_clk_dflt_find_companion(struct clk_hw_om=
ap *clk,
 void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk,
 				void __iomem **idlest_reg,
 				u8 *idlest_bit, u8 *idlest_val);
-void omap3_clk_lock_dpll5(void);
 unsigned long omap2_dpllcore_recalc(struct clk_hw *hw,
 				    unsigned long parent_rate);
 int omap2_reprogram_dpllcore(struct clk_hw *clk, unsigned long rate,
@@ -365,7 +336,6 @@ struct ti_clk_features *ti_clk_get_features(void);
=20
 extern const struct clk_hw_omap_ops clkhwops_omap2xxx_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap2430_i2chs_wait;
-extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
 extern const struct clk_hw_omap_ops clkhwops_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_w=
ait;
 extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait;
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
