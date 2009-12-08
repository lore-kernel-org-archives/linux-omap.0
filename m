From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 3/5] ARM: OMAP4: PM: Move DPLL control apis to dpll.c
Date: Wed,  9 Dec 2009 00:01:45 +0530
Message-ID: <1260297107-28833-3-git-send-email-rnayak@ti.com>
References: <1260297107-28833-1-git-send-email-rnayak@ti.com>
 <1260297107-28833-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54699 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136AbZLHScA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 13:32:00 -0500
In-Reply-To: <1260297107-28833-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

This patch moves all the dpll control api's to a
common file dpll.c. This is in preperation of omap4
support wherein most of these api's can be reused.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/Makefile    |    3 +-
 arch/arm/mach-omap2/clock.h     |   13 +
 arch/arm/mach-omap2/clock34xx.c |  489 -------------------------------=
----
 arch/arm/mach-omap2/clock34xx.h |   11 -
 arch/arm/mach-omap2/clock44xx.h |    8 -
 arch/arm/mach-omap2/dpll.c      |  532 +++++++++++++++++++++++++++++++=
++++++++
 6 files changed, 547 insertions(+), 509 deletions(-)
 create mode 100644 arch/arm/mach-omap2/dpll.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
index e3743cf..e5946c1 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -10,7 +10,8 @@ prcm-common				=3D prcm.o powerdomain.o
 clock-common				=3D clock.o clock_common_data.o clockdomain.o
=20
 obj-$(CONFIG_ARCH_OMAP2) +=3D $(omap-2-3-common) $(prcm-common) $(cloc=
k-common)
-obj-$(CONFIG_ARCH_OMAP3) +=3D $(omap-2-3-common) $(prcm-common) $(cloc=
k-common)
+obj-$(CONFIG_ARCH_OMAP3) +=3D $(omap-2-3-common) $(prcm-common) $(cloc=
k-common) \
+			    dpll.o
 obj-$(CONFIG_ARCH_OMAP4) +=3D prcm.o clock.o
=20
 obj-$(CONFIG_OMAP_MCBSP) +=3D mcbsp.o
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 87c0805..4df7aa4 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -36,6 +36,11 @@
 #define OMAP3XXX_EN_DPLL_FRBYPASS		0x6
 #define OMAP3XXX_EN_DPLL_LOCKED			0x7
=20
+/* CM_CLKEN_PLL*.EN* bit values - not all are available for every DPLL=
 */
+#define DPLL_LOW_POWER_STOP	0x1
+#define DPLL_LOW_POWER_BYPASS	0x5
+#define DPLL_LOCKED		0x7
+
 int omap2_clk_init(void);
 int omap2_clk_enable(struct clk *clk);
 void omap2_clk_disable(struct clk *clk);
@@ -44,6 +49,14 @@ int omap2_clk_set_rate(struct clk *clk, unsigned lon=
g rate);
 int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent);
 int omap2_dpll_set_rate_tolerance(struct clk *clk, unsigned int tolera=
nce);
 long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)=
;
+unsigned long omap3_dpll_recalc(struct clk *clk);
+unsigned long omap3_clkoutx2_recalc(struct clk *clk);
+void omap3_dpll_allow_idle(struct clk *clk);
+void omap3_dpll_deny_idle(struct clk *clk);
+u32 omap3_dpll_autoidle_read(struct clk *clk);
+int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate);
+int omap3_noncore_dpll_enable(struct clk *clk);
+void omap3_noncore_dpll_disable(struct clk *clk);
=20
 #ifdef CONFIG_OMAP_RESET_CLOCKS
 void omap2_clk_disable_unused(struct clk *clk);
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/cloc=
k34xx.c
index 7dffbfc..d4217b9 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -42,12 +42,6 @@
 #include "cm.h"
 #include "cm-regbits-34xx.h"
=20
-/* CM_AUTOIDLE_PLL*.AUTO_* bit values */
-#define DPLL_AUTOIDLE_DISABLE			0x0
-#define DPLL_AUTOIDLE_LOW_POWER_STOP		0x1
-
-#define MAX_DPLL_WAIT_TRIES		1000000
-
 #define CYCLES_PER_MHZ			1000000
=20
 /*
@@ -148,376 +142,11 @@ const struct clkops clkops_omap3430es2_hsotgusb_=
wait =3D {
 	.find_companion =3D omap2_clk_dflt_find_companion,
 };
=20
-/**
- * omap3_dpll_recalc - recalculate DPLL rate
- * @clk: DPLL struct clk
- *
- * Recalculate and propagate the DPLL rate.
- */
-unsigned long omap3_dpll_recalc(struct clk *clk)
-{
-	return omap2_get_dpll_rate(clk);
-}
-
-/* _omap3_dpll_write_clken - write clken_bits arg to a DPLL's enable b=
its */
-static void _omap3_dpll_write_clken(struct clk *clk, u8 clken_bits)
-{
-	const struct dpll_data *dd;
-	u32 v;
-
-	dd =3D clk->dpll_data;
-
-	v =3D __raw_readl(dd->control_reg);
-	v &=3D ~dd->enable_mask;
-	v |=3D clken_bits << __ffs(dd->enable_mask);
-	__raw_writel(v, dd->control_reg);
-}
-
-/* _omap3_wait_dpll_status: wait for a DPLL to enter a specific state =
*/
-static int _omap3_wait_dpll_status(struct clk *clk, u8 state)
-{
-	const struct dpll_data *dd;
-	int i =3D 0;
-	int ret =3D -EINVAL;
-
-	dd =3D clk->dpll_data;
-
-	state <<=3D __ffs(dd->idlest_mask);
-
-	while (((__raw_readl(dd->idlest_reg) & dd->idlest_mask) !=3D state) &=
&
-	       i < MAX_DPLL_WAIT_TRIES) {
-		i++;
-		udelay(1);
-	}
-
-	if (i =3D=3D MAX_DPLL_WAIT_TRIES) {
-		printk(KERN_ERR "clock: %s failed transition to '%s'\n",
-		       clk->name, (state) ? "locked" : "bypassed");
-	} else {
-		pr_debug("clock: %s transition to '%s' in %d loops\n",
-			 clk->name, (state) ? "locked" : "bypassed", i);
-
-		ret =3D 0;
-	}
-
-	return ret;
-}
-
-/* From 3430 TRM ES2 4.7.6.2 */
-static u16 _omap3_dpll_compute_freqsel(struct clk *clk, u8 n)
-{
-	unsigned long fint;
-	u16 f =3D 0;
-
-	fint =3D clk->dpll_data->clk_ref->rate / n;
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
-/* Non-CORE DPLL (e.g., DPLLs that do not control SDRC) clock function=
s */
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
-static int _omap3_noncore_dpll_lock(struct clk *clk)
-{
-	u8 ai;
-	int r;
-
-	pr_debug("clock: locking DPLL %s\n", clk->name);
-
-	ai =3D omap3_dpll_autoidle_read(clk);
-
-	omap3_dpll_deny_idle(clk);
-
-	_omap3_dpll_write_clken(clk, DPLL_LOCKED);
-
-	r =3D _omap3_wait_dpll_status(clk, 1);
-
-	if (ai)
-		omap3_dpll_allow_idle(clk);
-
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
-static int _omap3_noncore_dpll_bypass(struct clk *clk)
-{
-	int r;
-	u8 ai;
-
-	if (!(clk->dpll_data->modes & (1 << DPLL_LOW_POWER_BYPASS)))
-		return -EINVAL;
-
-	pr_debug("clock: configuring DPLL %s for low-power bypass\n",
-		 clk->name);
-
-	ai =3D omap3_dpll_autoidle_read(clk);
-
-	_omap3_dpll_write_clken(clk, DPLL_LOW_POWER_BYPASS);
-
-	r =3D _omap3_wait_dpll_status(clk, 0);
-
-	if (ai)
-		omap3_dpll_allow_idle(clk);
-	else
-		omap3_dpll_deny_idle(clk);
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
-static int _omap3_noncore_dpll_stop(struct clk *clk)
-{
-	u8 ai;
-
-	if (!(clk->dpll_data->modes & (1 << DPLL_LOW_POWER_STOP)))
-		return -EINVAL;
-
-	pr_debug("clock: stopping DPLL %s\n", clk->name);
-
-	ai =3D omap3_dpll_autoidle_read(clk);
-
-	_omap3_dpll_write_clken(clk, DPLL_LOW_POWER_STOP);
-
-	if (ai)
-		omap3_dpll_allow_idle(clk);
-	else
-		omap3_dpll_deny_idle(clk);
-
-	return 0;
-}
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
-static int omap3_noncore_dpll_enable(struct clk *clk)
-{
-	int r;
-	struct dpll_data *dd;
-
-	dd =3D clk->dpll_data;
-	if (!dd)
-		return -EINVAL;
-
-	if (clk->rate =3D=3D dd->clk_bypass->rate) {
-		WARN_ON(clk->parent !=3D dd->clk_bypass);
-		r =3D _omap3_noncore_dpll_bypass(clk);
-	} else {
-		WARN_ON(clk->parent !=3D dd->clk_ref);
-		r =3D _omap3_noncore_dpll_lock(clk);
-	}
-	/* FIXME: this is dubious - if clk->rate has changed, what about prop=
agating? */
-	if (!r)
-		clk->rate =3D omap2_get_dpll_rate(clk);
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
-static void omap3_noncore_dpll_disable(struct clk *clk)
-{
-	_omap3_noncore_dpll_stop(clk);
-}
-
 const struct clkops clkops_noncore_dpll_ops =3D {
 	.enable		=3D omap3_noncore_dpll_enable,
 	.disable	=3D omap3_noncore_dpll_disable,
 };
=20
-/* Non-CORE DPLL rate set code */
-
-/*
- * omap3_noncore_dpll_program - set non-core DPLL M,N values directly
- * @clk: struct clk * of DPLL to set
- * @m: DPLL multiplier to set
- * @n: DPLL divider to set
- * @freqsel: FREQSEL value to set
- *
- * Program the DPLL with the supplied M, N values, and wait for the DP=
LL to
- * lock..  Returns -EINVAL upon error, or 0 upon success.
- */
-static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u1=
6 freqsel)
-{
-	struct dpll_data *dd =3D clk->dpll_data;
-	u32 v;
-
-	/* 3430 ES2 TRM: 4.7.6.9 DPLL Programming Sequence */
-	_omap3_noncore_dpll_bypass(clk);
-
-	/* Set jitter correction */
-	v =3D __raw_readl(dd->control_reg);
-	v &=3D ~dd->freqsel_mask;
-	v |=3D freqsel << __ffs(dd->freqsel_mask);
-	__raw_writel(v, dd->control_reg);
-
-	/* Set DPLL multiplier, divider */
-	v =3D __raw_readl(dd->mult_div1_reg);
-	v &=3D ~(dd->mult_mask | dd->div1_mask);
-	v |=3D m << __ffs(dd->mult_mask);
-	v |=3D (n - 1) << __ffs(dd->div1_mask);
-	__raw_writel(v, dd->mult_div1_reg);
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
-/**
- * omap3_noncore_dpll_set_rate - set non-core DPLL rate
- * @clk: struct clk * of DPLL to set
- * @rate: rounded target rate
- *
- * Set the DPLL CLKOUT to the target rate.  If the DPLL can enter
- * low-power bypass, and the target rate is the bypass source clock
- * rate, then configure the DPLL for bypass.  Otherwise, round the
- * target rate if it hasn't been done already, then program and lock
- * the DPLL.  Returns -EINVAL upon error, or 0 upon success.
- */
-int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
-{
-	struct clk *new_parent =3D NULL;
-	u16 freqsel;
-	struct dpll_data *dd;
-	int ret;
-
-	if (!clk || !rate)
-		return -EINVAL;
-
-	dd =3D clk->dpll_data;
-	if (!dd)
-		return -EINVAL;
-
-	if (rate =3D=3D omap2_get_dpll_rate(clk))
-		return 0;
-
-	/*
-	 * Ensure both the bypass and ref clocks are enabled prior to
-	 * doing anything; we need the bypass clock running to reprogram
-	 * the DPLL.
-	 */
-	omap2_clk_enable(dd->clk_bypass);
-	omap2_clk_enable(dd->clk_ref);
-
-	if (dd->clk_bypass->rate =3D=3D rate &&
-	    (clk->dpll_data->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
-		pr_debug("clock: %s: set rate: entering bypass.\n", clk->name);
-
-		ret =3D _omap3_noncore_dpll_bypass(clk);
-		if (!ret)
-			new_parent =3D dd->clk_bypass;
-	} else {
-		if (dd->last_rounded_rate !=3D rate)
-			omap2_dpll_round_rate(clk, rate);
-
-		if (dd->last_rounded_rate =3D=3D 0)
-			return -EINVAL;
-
-		freqsel =3D _omap3_dpll_compute_freqsel(clk, dd->last_rounded_n);
-		if (!freqsel)
-			WARN_ON(1);
-
-		pr_debug("clock: %s: set rate: locking rate to %lu.\n",
-			 clk->name, rate);
-
-		ret =3D omap3_noncore_dpll_program(clk, dd->last_rounded_m,
-						 dd->last_rounded_n, freqsel);
-		if (!ret)
-			new_parent =3D dd->clk_ref;
-	}
-	if (!ret) {
-		/*
-		 * Switch the parent clock in the heirarchy, and make sure
-		 * that the new parent's usecount is correct.  Note: we
-		 * enable the new parent before disabling the old to avoid
-		 * any unnecessary hardware disable->enable transitions.
-		 */
-		if (clk->usecount) {
-			omap2_clk_enable(new_parent);
-			omap2_clk_disable(clk->parent);
-		}
-		clk_reparent(clk, new_parent);
-		clk->rate =3D rate;
-	}
-	omap2_clk_disable(dd->clk_ref);
-	omap2_clk_disable(dd->clk_bypass);
-
-	return 0;
-}
-
 int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
 {
 	/*
@@ -621,124 +250,6 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, =
unsigned long rate)
 	return 0;
 }
=20
-
-/* DPLL autoidle read/set code */
-
-
-/**
- * omap3_dpll_autoidle_read - read a DPLL's autoidle bits
- * @clk: struct clk * of the DPLL to read
- *
- * Return the DPLL's autoidle bits, shifted down to bit 0.  Returns
- * -EINVAL if passed a null pointer or if the struct clk does not
- * appear to refer to a DPLL.
- */
-u32 omap3_dpll_autoidle_read(struct clk *clk)
-{
-	const struct dpll_data *dd;
-	u32 v;
-
-	if (!clk || !clk->dpll_data)
-		return -EINVAL;
-
-	dd =3D clk->dpll_data;
-
-	v =3D __raw_readl(dd->autoidle_reg);
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
-void omap3_dpll_allow_idle(struct clk *clk)
-{
-	const struct dpll_data *dd;
-	u32 v;
-
-	if (!clk || !clk->dpll_data)
-		return;
-
-	dd =3D clk->dpll_data;
-
-	/*
-	 * REVISIT: CORE DPLL can optionally enter low-power bypass
-	 * by writing 0x5 instead of 0x1.  Add some mechanism to
-	 * optionally enter this mode.
-	 */
-	v =3D __raw_readl(dd->autoidle_reg);
-	v &=3D ~dd->autoidle_mask;
-	v |=3D DPLL_AUTOIDLE_LOW_POWER_STOP << __ffs(dd->autoidle_mask);
-	__raw_writel(v, dd->autoidle_reg);
-}
-
-/**
- * omap3_dpll_deny_idle - prevent DPLL from automatically idling
- * @clk: struct clk * of the DPLL to operate on
- *
- * Disable DPLL automatic idle control.  No return value.
- */
-void omap3_dpll_deny_idle(struct clk *clk)
-{
-	const struct dpll_data *dd;
-	u32 v;
-
-	if (!clk || !clk->dpll_data)
-		return;
-
-	dd =3D clk->dpll_data;
-
-	v =3D __raw_readl(dd->autoidle_reg);
-	v &=3D ~dd->autoidle_mask;
-	v |=3D DPLL_AUTOIDLE_DISABLE << __ffs(dd->autoidle_mask);
-	__raw_writel(v, dd->autoidle_reg);
-}
-
-/* Clock control for DPLL outputs */
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
-unsigned long omap3_clkoutx2_recalc(struct clk *clk)
-{
-	const struct dpll_data *dd;
-	unsigned long rate;
-	u32 v;
-	struct clk *pclk;
-
-	/* Walk up the parents of clk, looking for a DPLL */
-	pclk =3D clk->parent;
-	while (pclk && !pclk->dpll_data)
-		pclk =3D pclk->parent;
-
-	/* clk does not have a DPLL as a parent? */
-	WARN_ON(!pclk);
-
-	dd =3D pclk->dpll_data;
-
-	WARN_ON(!dd->enable_mask);
-
-	v =3D __raw_readl(dd->control_reg) & dd->enable_mask;
-	v >>=3D __ffs(dd->enable_mask);
-	if (v !=3D OMAP3XXX_EN_DPLL_LOCKED)
-		rate =3D clk->parent->rate;
-	else
-		rate =3D clk->parent->rate * 2;
-	return rate;
-}
-
 /* Common clock code */
=20
 /*
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/cloc=
k34xx.h
index b08809e..9a2c07e 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -8,21 +8,10 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CLOCK_34XX_H
 #define __ARCH_ARM_MACH_OMAP2_CLOCK_34XX_H
=20
-unsigned long omap3_dpll_recalc(struct clk *clk);
-unsigned long omap3_clkoutx2_recalc(struct clk *clk);
-void omap3_dpll_allow_idle(struct clk *clk);
-void omap3_dpll_deny_idle(struct clk *clk);
-u32 omap3_dpll_autoidle_read(struct clk *clk);
-int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate);
 int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate);
 int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate);
 void omap3_clk_lock_dpll5(void);
=20
-/* CM_CLKEN_PLL*.EN* bit values - not all are available for every DPLL=
 */
-#define DPLL_LOW_POWER_STOP		0x1
-#define DPLL_LOW_POWER_BYPASS		0x5
-#define DPLL_LOCKED			0x7
-
 extern struct clk *sdrc_ick_p;
 extern struct clk *arm_fck_p;
=20
diff --git a/arch/arm/mach-omap2/clock44xx.h b/arch/arm/mach-omap2/cloc=
k44xx.h
index c1bc4b6..59b9ced 100644
--- a/arch/arm/mach-omap2/clock44xx.h
+++ b/arch/arm/mach-omap2/clock44xx.h
@@ -7,14 +7,6 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CLOCK_44XX_H
 #define __ARCH_ARM_MACH_OMAP2_CLOCK_44XX_H
=20
-unsigned long omap3_dpll_recalc(struct clk *clk);
-unsigned long omap3_clkoutx2_recalc(struct clk *clk);
-int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate);
-
-/* DPLL modes */
-#define DPLL_LOW_POWER_STOP	0x1
-#define DPLL_LOW_POWER_BYPASS	0x5
-#define DPLL_LOCKED		0x7
 #define OMAP4430_MAX_DPLL_MULT	2048
 #define OMAP4430_MAX_DPLL_DIV	128
=20
diff --git a/arch/arm/mach-omap2/dpll.c b/arch/arm/mach-omap2/dpll.c
new file mode 100644
index 0000000..d55f8df
--- /dev/null
+++ b/arch/arm/mach-omap2/dpll.c
@@ -0,0 +1,532 @@
+/*
+ * OMAP3/4 - specific DPLL control functions
+ *
+ * Copyright (C) 2009 Texas Instruments, Inc.
+ * Copyright (C) 2009 Nokia Corporation
+ *
+ * Written by Paul Walmsley
+ * Testing and integration fixes by Jouni H=C3=83=C2=B6gander
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
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/limits.h>
+#include <linux/bitops.h>
+
+#include <mach/cpu.h>
+#include <mach/clock.h>
+#include <mach/sram.h>
+#include <asm/div64.h>
+#include <asm/clkdev.h>
+
+#include "clock.h"
+#include "prm.h"
+#include "prm-regbits-34xx.h"
+#include "cm.h"
+#include "cm-regbits-34xx.h"
+
+/* CM_AUTOIDLE_PLL*.AUTO_* bit values */
+#define DPLL_AUTOIDLE_DISABLE			0x0
+#define DPLL_AUTOIDLE_LOW_POWER_STOP		0x1
+
+#define MAX_DPLL_WAIT_TRIES		1000000
+
+
+/**
+ * omap3_dpll_recalc - recalculate DPLL rate
+ * @clk: DPLL struct clk
+ *
+ * Recalculate and propagate the DPLL rate.
+ */
+unsigned long omap3_dpll_recalc(struct clk *clk)
+{
+	return omap2_get_dpll_rate(clk);
+}
+
+/* _omap3_dpll_write_clken - write clken_bits arg to a DPLL's enable b=
its */
+static void _omap3_dpll_write_clken(struct clk *clk, u8 clken_bits)
+{
+	const struct dpll_data *dd;
+	u32 v;
+
+	dd =3D clk->dpll_data;
+
+	v =3D __raw_readl(dd->control_reg);
+	v &=3D ~dd->enable_mask;
+	v |=3D clken_bits << __ffs(dd->enable_mask);
+	__raw_writel(v, dd->control_reg);
+}
+
+/* _omap3_wait_dpll_status: wait for a DPLL to enter a specific state =
*/
+static int _omap3_wait_dpll_status(struct clk *clk, u8 state)
+{
+	const struct dpll_data *dd;
+	int i =3D 0;
+	int ret =3D -EINVAL;
+
+	dd =3D clk->dpll_data;
+
+	state <<=3D __ffs(dd->idlest_mask);
+
+	while (((__raw_readl(dd->idlest_reg) & dd->idlest_mask) !=3D state) &=
&
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
+/* From 3430 TRM ES2 4.7.6.2 */
+static u16 _omap3_dpll_compute_freqsel(struct clk *clk, u8 n)
+{
+	unsigned long fint;
+	u16 f =3D 0;
+
+	fint =3D clk->dpll_data->clk_ref->rate / n;
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
+	pr_debug("clock: locking DPLL %s\n", clk->name);
+
+	ai =3D omap3_dpll_autoidle_read(clk);
+
+	omap3_dpll_deny_idle(clk);
+
+	_omap3_dpll_write_clken(clk, DPLL_LOCKED);
+
+	r =3D _omap3_wait_dpll_status(clk, 1);
+
+	if (ai)
+		omap3_dpll_allow_idle(clk);
+
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
+static int _omap3_noncore_dpll_bypass(struct clk *clk)
+{
+	int r;
+	u8 ai;
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
+int omap3_noncore_dpll_enable(struct clk *clk)
+{
+	int r;
+	struct dpll_data *dd;
+
+	dd =3D clk->dpll_data;
+	if (!dd)
+		return -EINVAL;
+
+	if (clk->rate =3D=3D dd->clk_bypass->rate) {
+		WARN_ON(clk->parent !=3D dd->clk_bypass);
+		r =3D _omap3_noncore_dpll_bypass(clk);
+	} else {
+		WARN_ON(clk->parent !=3D dd->clk_ref);
+		r =3D _omap3_noncore_dpll_lock(clk);
+	}
+	/*
+	 *FIXME: this is dubious - if clk->rate has changed, what about
+	 * propagating?
+	 */
+	if (!r)
+		clk->rate =3D omap2_get_dpll_rate(clk);
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
+void omap3_noncore_dpll_disable(struct clk *clk)
+{
+	_omap3_noncore_dpll_stop(clk);
+}
+
+
+/* Non-CORE DPLL rate set code */
+
+/*
+ * omap3_noncore_dpll_program - set non-core DPLL M,N values directly
+ * @clk: struct clk * of DPLL to set
+ * @m: DPLL multiplier to set
+ * @n: DPLL divider to set
+ * @freqsel: FREQSEL value to set
+ *
+ * Program the DPLL with the supplied M, N values, and wait for the DP=
LL to
+ * lock..  Returns -EINVAL upon error, or 0 upon success.
+ */
+int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqs=
el)
+{
+	struct dpll_data *dd =3D clk->dpll_data;
+	u32 v;
+
+	/* 3430 ES2 TRM: 4.7.6.9 DPLL Programming Sequence */
+	_omap3_noncore_dpll_bypass(clk);
+
+	/* Set jitter correction */
+	v =3D __raw_readl(dd->control_reg);
+	v &=3D ~dd->freqsel_mask;
+	v |=3D freqsel << __ffs(dd->freqsel_mask);
+	__raw_writel(v, dd->control_reg);
+
+	/* Set DPLL multiplier, divider */
+	v =3D __raw_readl(dd->mult_div1_reg);
+	v &=3D ~(dd->mult_mask | dd->div1_mask);
+	v |=3D m << __ffs(dd->mult_mask);
+	v |=3D (n - 1) << __ffs(dd->div1_mask);
+	__raw_writel(v, dd->mult_div1_reg);
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
+/**
+ * omap3_noncore_dpll_set_rate - set non-core DPLL rate
+ * @clk: struct clk * of DPLL to set
+ * @rate: rounded target rate
+ *
+ * Set the DPLL CLKOUT to the target rate.  If the DPLL can enter
+ * low-power bypass, and the target rate is the bypass source clock
+ * rate, then configure the DPLL for bypass.  Otherwise, round the
+ * target rate if it hasn't been done already, then program and lock
+ * the DPLL.  Returns -EINVAL upon error, or 0 upon success.
+ */
+int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
+{
+	struct clk *new_parent =3D NULL;
+	u16 freqsel;
+	struct dpll_data *dd;
+	int ret;
+
+	if (!clk || !rate)
+		return -EINVAL;
+
+	dd =3D clk->dpll_data;
+	if (!dd)
+		return -EINVAL;
+
+	if (rate =3D=3D omap2_get_dpll_rate(clk))
+		return 0;
+
+	/*
+	 * Ensure both the bypass and ref clocks are enabled prior to
+	 * doing anything; we need the bypass clock running to reprogram
+	 * the DPLL.
+	 */
+	omap2_clk_enable(dd->clk_bypass);
+	omap2_clk_enable(dd->clk_ref);
+
+	if (dd->clk_bypass->rate =3D=3D rate &&
+	    (clk->dpll_data->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
+		pr_debug("clock: %s: set rate: entering bypass.\n", clk->name);
+
+		ret =3D _omap3_noncore_dpll_bypass(clk);
+		if (!ret)
+			new_parent =3D dd->clk_bypass;
+	} else {
+		if (dd->last_rounded_rate !=3D rate)
+			omap2_dpll_round_rate(clk, rate);
+
+		if (dd->last_rounded_rate =3D=3D 0)
+			return -EINVAL;
+
+		freqsel =3D _omap3_dpll_compute_freqsel(clk, dd->last_rounded_n);
+		if (!freqsel)
+			WARN_ON(1);
+
+		pr_debug("clock: %s: set rate: locking rate to %lu.\n",
+			 clk->name, rate);
+
+		ret =3D omap3_noncore_dpll_program(clk, dd->last_rounded_m,
+						 dd->last_rounded_n, freqsel);
+		if (!ret)
+			new_parent =3D dd->clk_ref;
+	}
+	if (!ret) {
+		/*
+		 * Switch the parent clock in the heirarchy, and make sure
+		 * that the new parent's usecount is correct.  Note: we
+		 * enable the new parent before disabling the old to avoid
+		 * any unnecessary hardware disable->enable transitions.
+		 */
+		if (clk->usecount) {
+			omap2_clk_enable(new_parent);
+			omap2_clk_disable(clk->parent);
+		}
+		clk_reparent(clk, new_parent);
+		clk->rate =3D rate;
+	}
+	omap2_clk_disable(dd->clk_ref);
+	omap2_clk_disable(dd->clk_bypass);
+
+	return 0;
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
+u32 omap3_dpll_autoidle_read(struct clk *clk)
+{
+	const struct dpll_data *dd;
+	u32 v;
+
+	if (!clk || !clk->dpll_data)
+		return -EINVAL;
+
+	dd =3D clk->dpll_data;
+
+	v =3D __raw_readl(dd->autoidle_reg);
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
+void omap3_dpll_allow_idle(struct clk *clk)
+{
+	const struct dpll_data *dd;
+	u32 v;
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
+	v =3D __raw_readl(dd->autoidle_reg);
+	v &=3D ~dd->autoidle_mask;
+	v |=3D DPLL_AUTOIDLE_LOW_POWER_STOP << __ffs(dd->autoidle_mask);
+	__raw_writel(v, dd->autoidle_reg);
+}
+
+/**
+ * omap3_dpll_deny_idle - prevent DPLL from automatically idling
+ * @clk: struct clk * of the DPLL to operate on
+ *
+ * Disable DPLL automatic idle control.  No return value.
+ */
+void omap3_dpll_deny_idle(struct clk *clk)
+{
+	const struct dpll_data *dd;
+	u32 v;
+
+	if (!clk || !clk->dpll_data)
+		return;
+
+	dd =3D clk->dpll_data;
+
+	v =3D __raw_readl(dd->autoidle_reg);
+	v &=3D ~dd->autoidle_mask;
+	v |=3D DPLL_AUTOIDLE_DISABLE << __ffs(dd->autoidle_mask);
+	__raw_writel(v, dd->autoidle_reg);
+
+}
+
+/* Clock control for DPLL outputs */
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
+unsigned long omap3_clkoutx2_recalc(struct clk *clk)
+{
+	const struct dpll_data *dd;
+	unsigned long rate;
+	u32 v;
+	struct clk *pclk;
+
+	/* Walk up the parents of clk, looking for a DPLL */
+	pclk =3D clk->parent;
+	while (pclk && !pclk->dpll_data)
+		pclk =3D pclk->parent;
+
+	/* clk does not have a DPLL as a parent? */
+	WARN_ON(!pclk);
+
+	dd =3D pclk->dpll_data;
+
+	WARN_ON(!dd->enable_mask);
+
+	v =3D __raw_readl(dd->control_reg) & dd->enable_mask;
+	v >>=3D __ffs(dd->enable_mask);
+	if (v !=3D OMAP3XXX_EN_DPLL_LOCKED)
+		rate =3D clk->parent->rate;
+	else
+		rate =3D clk->parent->rate * 2;
+	return rate;
+}
--=20
1.5.4.7

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
