From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/12]
Date: Tue, 18 Mar 2008 12:39:54 +0200
Message-ID: <1205836800-31737-7-git-send-email-tony@atomide.com>
References: omap2-upstream-2008-03-18-123926
	<1205836800-31737-1-git-send-email-tony@atomide.com>
	<1205836800-31737-2-git-send-email-tony@atomide.com>
	<1205836800-31737-3-git-send-email-tony@atomide.com>
	<1205836800-31737-4-git-send-email-tony@atomide.com>
	<1205836800-31737-5-git-send-email-tony@atomide.com>
	<1205836800-31737-6-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <1205836800-31737-6-git-send-email-tony@atomide.com>
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

This patch moves clock.[ch] to clock24xx.[ch]  to make room for
adding common clock code for 24xx and 34xx.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile    |    5 +-
 arch/arm/mach-omap2/clock.c     | 1176 ----------------------
 arch/arm/mach-omap2/clock.h     | 2111 ---------------------------------------
 arch/arm/mach-omap2/clock24xx.c | 1176 ++++++++++++++++++++++
 arch/arm/mach-omap2/clock24xx.h | 2111 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 3291 insertions(+), 3288 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clock.c
 delete mode 100644 arch/arm/mach-omap2/clock.h
 create mode 100644 arch/arm/mach-omap2/clock24xx.c
 create mode 100644 arch/arm/mach-omap2/clock24xx.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b9313c9..be2b671 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,12 +3,15 @@
 #
 
 # Common support
-obj-y := irq.o id.o io.o sram-fn.o memory.o control.o prcm.o clock.o mux.o \
+obj-y := irq.o id.o io.o sram-fn.o memory.o control.o prcm.o mux.o \
 		devices.o serial.o gpmc.o timer-gp.o
 
 # Power Management
 obj-$(CONFIG_PM) += pm.o pm-domain.o sleep.o
 
+# Clock framework
+obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
+
 # Specific board support
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
deleted file mode 100644
index e6e85b7..0000000
--- a/arch/arm/mach-omap2/clock.c
+++ /dev/null
@@ -1,1176 +0,0 @@
-/*
- *  linux/arch/arm/mach-omap2/clock.c
- *
- *  Copyright (C) 2005 Texas Instruments Inc.
- *  Richard Woodruff <r-woodruff2@ti.com>
- *  Created for OMAP2.
- *
- *  Cleaned up and modified to use omap shared clock framework by
- *  Tony Lindgren <tony@atomide.com>
- *
- *  Based on omap1 clock.c, Copyright (C) 2004 - 2005 Nokia corporation
- *  Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/list.h>
-#include <linux/errno.h>
-#include <linux/delay.h>
-#include <linux/clk.h>
-
-#include <asm/io.h>
-
-#include <asm/arch/clock.h>
-#include <asm/arch/sram.h>
-#include <asm/div64.h>
-
-#include "prcm-regs.h"
-#include "memory.h"
-#include "clock.h"
-
-#undef DEBUG
-
-//#define DOWN_VARIABLE_DPLL 1			/* Experimental */
-
-static struct prcm_config *curr_prcm_set;
-static u32 curr_perf_level = PRCM_FULL_SPEED;
-static struct clk *vclk;
-static struct clk *sclk;
-
-/*-------------------------------------------------------------------------
- * Omap2 specific clock functions
- *-------------------------------------------------------------------------*/
-
-/* Recalculate SYST_CLK */
-static void omap2_sys_clk_recalc(struct clk * clk)
-{
-	u32 div = PRCM_CLKSRC_CTRL;
-	div &= (1 << 7) | (1 << 6);	/* Test if ext clk divided by 1 or 2 */
-	div >>= clk->rate_offset;
-	clk->rate = (clk->parent->rate / div);
-	propagate_rate(clk);
-}
-
-static u32 omap2_get_dpll_rate(struct clk * tclk)
-{
-	long long dpll_clk;
-	int dpll_mult, dpll_div, amult;
-
-	dpll_mult = (CM_CLKSEL1_PLL >> 12) & 0x03ff;	/* 10 bits */
-	dpll_div = (CM_CLKSEL1_PLL >> 8) & 0x0f;	/* 4 bits */
-	dpll_clk = (long long)tclk->parent->rate * dpll_mult;
-	do_div(dpll_clk, dpll_div + 1);
-	amult = CM_CLKSEL2_PLL & 0x3;
-	dpll_clk *= amult;
-
-	return dpll_clk;
-}
-
-static void omap2_followparent_recalc(struct clk *clk)
-{
-	followparent_recalc(clk);
-}
-
-static void omap2_propagate_rate(struct clk * clk)
-{
-	if (!(clk->flags & RATE_FIXED))
-		clk->rate = clk->parent->rate;
-
-	propagate_rate(clk);
-}
-
-static void omap2_set_osc_ck(int enable)
-{
-	if (enable)
-		PRCM_CLKSRC_CTRL &= ~(0x3 << 3);
-	else
-		PRCM_CLKSRC_CTRL |= 0x3 << 3;
-}
-
-/* Enable an APLL if off */
-static void omap2_clk_fixed_enable(struct clk *clk)
-{
-	u32 cval, i=0;
-
-	if (clk->enable_bit == 0xff)			/* Parent will do it */
-		return;
-
-	cval = CM_CLKEN_PLL;
-
-	if ((cval & (0x3 << clk->enable_bit)) == (0x3 << clk->enable_bit))
-		return;
-
-	cval &= ~(0x3 << clk->enable_bit);
-	cval |= (0x3 << clk->enable_bit);
-	CM_CLKEN_PLL = cval;
-
-	if (clk == &apll96_ck)
-		cval = (1 << 8);
-	else if (clk == &apll54_ck)
-		cval = (1 << 6);
-
-	while (!(CM_IDLEST_CKGEN & cval)) {		/* Wait for lock */
-		++i;
-		udelay(1);
-		if (i == 100000) {
-			printk(KERN_ERR "Clock %s didn't lock\n", clk->name);
-			break;
-		}
-	}
-}
-
-static void omap2_clk_wait_ready(struct clk *clk)
-{
-	unsigned long reg, other_reg, st_reg;
-	u32 bit;
-	int i;
-
-	reg = (unsigned long) clk->enable_reg;
-	if (reg == (unsigned long) &CM_FCLKEN1_CORE ||
-	    reg == (unsigned long) &CM_FCLKEN2_CORE)
-		other_reg = (reg & ~0xf0) | 0x10;
-	else if (reg == (unsigned long) &CM_ICLKEN1_CORE ||
-		 reg == (unsigned long) &CM_ICLKEN2_CORE)
-		other_reg = (reg & ~0xf0) | 0x00;
-	else
-		return;
-
-	/* No check for DSS or cam clocks */
-	if ((reg & 0x0f) == 0) {
-		if (clk->enable_bit <= 1 || clk->enable_bit == 31)
-			return;
-	}
-
-	/* Check if both functional and interface clocks
-	 * are running. */
-	bit = 1 << clk->enable_bit;
-	if (!(__raw_readl(other_reg) & bit))
-		return;
-	st_reg = (other_reg & ~0xf0) | 0x20;
-	i = 0;
-	while (!(__raw_readl(st_reg) & bit)) {
-		i++;
-		if (i == 100000) {
-			printk(KERN_ERR "Timeout enabling clock %s\n", clk->name);
-			break;
-		}
-	}
-	if (i)
-		pr_debug("Clock %s stable after %d loops\n", clk->name, i);
-}
-
-/* Enables clock without considering parent dependencies or use count
- * REVISIT: Maybe change this to use clk->enable like on omap1?
- */
-static int _omap2_clk_enable(struct clk * clk)
-{
-	u32 regval32;
-
-	if (clk->flags & ALWAYS_ENABLED)
-		return 0;
-
-	if (unlikely(clk == &osc_ck)) {
-		omap2_set_osc_ck(1);
-		return 0;
-	}
-
-	if (unlikely(clk->enable_reg == 0)) {
-		printk(KERN_ERR "clock.c: Enable for %s without enable code\n",
-		       clk->name);
-		return 0;
-	}
-
-	if (clk->enable_reg == (void __iomem *)&CM_CLKEN_PLL) {
-		omap2_clk_fixed_enable(clk);
-		return 0;
-	}
-
-	regval32 = __raw_readl(clk->enable_reg);
-	regval32 |= (1 << clk->enable_bit);
-	__raw_writel(regval32, clk->enable_reg);
-	wmb();
-
-	omap2_clk_wait_ready(clk);
-
-	return 0;
-}
-
-/* Stop APLL */
-static void omap2_clk_fixed_disable(struct clk *clk)
-{
-	u32 cval;
-
-	if(clk->enable_bit == 0xff)		/* let parent off do it */
-		return;
-
-	cval = CM_CLKEN_PLL;
-	cval &= ~(0x3 << clk->enable_bit);
-	CM_CLKEN_PLL = cval;
-}
-
-/* Disables clock without considering parent dependencies or use count */
-static void _omap2_clk_disable(struct clk *clk)
-{
-	u32 regval32;
-
-	if (unlikely(clk == &osc_ck)) {
-		omap2_set_osc_ck(0);
-		return;
-	}
-
-	if (clk->enable_reg == 0)
-		return;
-
-	if (clk->enable_reg == (void __iomem *)&CM_CLKEN_PLL) {
-		omap2_clk_fixed_disable(clk);
-		return;
-	}
-
-	regval32 = __raw_readl(clk->enable_reg);
-	regval32 &= ~(1 << clk->enable_bit);
-	__raw_writel(regval32, clk->enable_reg);
-	wmb();
-}
-
-static int omap2_clk_enable(struct clk *clk)
-{
-	int ret = 0;
-
-	if (clk->usecount++ == 0) {
-		if (likely((u32)clk->parent))
-			ret = omap2_clk_enable(clk->parent);
-
-		if (unlikely(ret != 0)) {
-			clk->usecount--;
-			return ret;
-		}
-
-		ret = _omap2_clk_enable(clk);
-
-		if (unlikely(ret != 0) && clk->parent) {
-			omap2_clk_disable(clk->parent);
-			clk->usecount--;
-		}
-	}
-
-	return ret;
-}
-
-static void omap2_clk_disable(struct clk *clk)
-{
-	if (clk->usecount > 0 && !(--clk->usecount)) {
-		_omap2_clk_disable(clk);
-		if (likely((u32)clk->parent))
-			omap2_clk_disable(clk->parent);
-	}
-}
-
-/*
- * Uses the current prcm set to tell if a rate is valid.
- * You can go slower, but not faster within a given rate set.
- */
-static u32 omap2_dpll_round_rate(unsigned long target_rate)
-{
-	u32 high, low;
-
-	if ((CM_CLKSEL2_PLL & 0x3) == 1) {	/* DPLL clockout */
-		high = curr_prcm_set->dpll_speed * 2;
-		low = curr_prcm_set->dpll_speed;
-	} else {				/* DPLL clockout x 2 */
-		high = curr_prcm_set->dpll_speed;
-		low = curr_prcm_set->dpll_speed / 2;
-	}
-
-#ifdef DOWN_VARIABLE_DPLL
-	if (target_rate > high)
-		return high;
-	else
-		return target_rate;
-#else
-	if (target_rate > low)
-		return high;
-	else
-		return low;
-#endif
-
-}
-
-/*
- * Used for clocks that are part of CLKSEL_xyz governed clocks.
- * REVISIT: Maybe change to use clk->enable() functions like on omap1?
- */
-static void omap2_clksel_recalc(struct clk * clk)
-{
-	u32 fixed = 0, div = 0;
-
-	if (clk == &dpll_ck) {
-		clk->rate = omap2_get_dpll_rate(clk);
-		fixed = 1;
-		div = 0;
-	}
-
-	if (clk == &iva1_mpu_int_ifck) {
-		div = 2;
-		fixed = 1;
-	}
-
-	if ((clk == &dss1_fck) && ((CM_CLKSEL1_CORE & (0x1f << 8)) == 0)) {
-		clk->rate = sys_ck.rate;
-		return;
-	}
-
-	if (!fixed) {
-		div = omap2_clksel_get_divisor(clk);
-		if (div == 0)
-			return;
-	}
-
-	if (div != 0) {
-		if (unlikely(clk->rate == clk->parent->rate / div))
-			return;
-		clk->rate = clk->parent->rate / div;
-	}
-
-	if (unlikely(clk->flags & RATE_PROPAGATES))
-		propagate_rate(clk);
-}
-
-/*
- * Finds best divider value in an array based on the source and target
- * rates. The divider array must be sorted with smallest divider first.
- */
-static inline u32 omap2_divider_from_table(u32 size, u32 *div_array,
-					   u32 src_rate, u32 tgt_rate)
-{
-	int i, test_rate;
-
-	if (div_array == NULL)
-		return ~1;
-
-	for (i=0; i < size; i++) {
-		test_rate = src_rate / *div_array;
-		if (test_rate <= tgt_rate)
-			return *div_array;
-		++div_array;
-	}
-
-	return ~0;	/* No acceptable divider */
-}
-
-/*
- * Find divisor for the given clock and target rate.
- *
- * Note that this will not work for clocks which are part of CONFIG_PARTICIPANT,
- * they are only settable as part of virtual_prcm set.
- */
-static u32 omap2_clksel_round_rate(struct clk *tclk, u32 target_rate,
-	u32 *new_div)
-{
-	u32 gfx_div[] = {2, 3, 4};
-	u32 sysclkout_div[] = {1, 2, 4, 8, 16};
-	u32 dss1_div[] = {1, 2, 3, 4, 5, 6, 8, 9, 12, 16};
-	u32 vylnq_div[] = {1, 2, 3, 4, 6, 8, 9, 12, 16, 18};
-	u32 best_div = ~0, asize = 0;
-	u32 *div_array = NULL;
-
-	switch (tclk->flags & SRC_RATE_SEL_MASK) {
-	case CM_GFX_SEL1:
-		asize = 3;
-		div_array = gfx_div;
-		break;
-	case CM_PLL_SEL1:
-		return omap2_dpll_round_rate(target_rate);
-	case CM_SYSCLKOUT_SEL1:
-		asize = 5;
-		div_array = sysclkout_div;
-		break;
-	case CM_CORE_SEL1:
-		if(tclk == &dss1_fck){
-			if(tclk->parent == &core_ck){
-				asize = 10;
-				div_array = dss1_div;
-			} else {
-				*new_div = 0; /* fixed clk */
-				return(tclk->parent->rate);
-			}
-		} else if((tclk == &vlynq_fck) && cpu_is_omap2420()){
-			if(tclk->parent == &core_ck){
-				asize = 10;
-				div_array = vylnq_div;
-			} else {
-				*new_div = 0; /* fixed clk */
-				return(tclk->parent->rate);
-			}
-		}
-		break;
-	}
-
-	best_div = omap2_divider_from_table(asize, div_array,
-	 tclk->parent->rate, target_rate);
-	if (best_div == ~0){
-		*new_div = 1;
-		return best_div; /* signal error */
-	}
-
-	*new_div = best_div;
-	return (tclk->parent->rate / best_div);
-}
-
-/* Given a clock and a rate apply a clock specific rounding function */
-static long omap2_clk_round_rate(struct clk *clk, unsigned long rate)
-{
-	u32 new_div = 0;
-	int valid_rate;
-
-	if (clk->flags & RATE_FIXED)
-		return clk->rate;
-
-	if (clk->flags & RATE_CKCTL) {
-		valid_rate = omap2_clksel_round_rate(clk, rate, &new_div);
-		return valid_rate;
-	}
-
-	if (clk->round_rate != 0)
-		return clk->round_rate(clk, rate);
-
-	return clk->rate;
-}
-
-/*
- * Check the DLL lock state, and return tue if running in unlock mode.
- * This is needed to compensate for the shifted DLL value in unlock mode.
- */
-static u32 omap2_dll_force_needed(void)
-{
-	u32 dll_state = SDRC_DLLA_CTRL;		/* dlla and dllb are a set */
-
-	if ((dll_state & (1 << 2)) == (1 << 2))
-		return 1;
-	else
-		return 0;
-}
-
-static u32 omap2_reprogram_sdrc(u32 level, u32 force)
-{
-	u32 slow_dll_ctrl, fast_dll_ctrl, m_type;
-	u32 prev = curr_perf_level, flags;
-
-	if ((curr_perf_level == level) && !force)
-		return prev;
-
-	m_type = omap2_memory_get_type();
-	slow_dll_ctrl = omap2_memory_get_slow_dll_ctrl();
-	fast_dll_ctrl = omap2_memory_get_fast_dll_ctrl();
-
-	if (level == PRCM_HALF_SPEED) {
-		local_irq_save(flags);
-		PRCM_VOLTSETUP = 0xffff;
-		omap2_sram_reprogram_sdrc(PRCM_HALF_SPEED,
-					  slow_dll_ctrl, m_type);
-		curr_perf_level = PRCM_HALF_SPEED;
-		local_irq_restore(flags);
-	}
-	if (level == PRCM_FULL_SPEED) {
-		local_irq_save(flags);
-		PRCM_VOLTSETUP = 0xffff;
-		omap2_sram_reprogram_sdrc(PRCM_FULL_SPEED,
-					  fast_dll_ctrl, m_type);
-		curr_perf_level = PRCM_FULL_SPEED;
-		local_irq_restore(flags);
-	}
-
-	return prev;
-}
-
-static int omap2_reprogram_dpll(struct clk * clk, unsigned long rate)
-{
-	u32 flags, cur_rate, low, mult, div, valid_rate, done_rate;
-	u32 bypass = 0;
-	struct prcm_config tmpset;
-	int ret = -EINVAL;
-
-	local_irq_save(flags);
-	cur_rate = omap2_get_dpll_rate(&dpll_ck);
-	mult = CM_CLKSEL2_PLL & 0x3;
-
-	if ((rate == (cur_rate / 2)) && (mult == 2)) {
-		omap2_reprogram_sdrc(PRCM_HALF_SPEED, 1);
-	} else if ((rate == (cur_rate * 2)) && (mult == 1)) {
-		omap2_reprogram_sdrc(PRCM_FULL_SPEED, 1);
-	} else if (rate != cur_rate) {
-		valid_rate = omap2_dpll_round_rate(rate);
-		if (valid_rate != rate)
-			goto dpll_exit;
-
-		if ((CM_CLKSEL2_PLL & 0x3) == 1)
-			low = curr_prcm_set->dpll_speed;
-		else
-			low = curr_prcm_set->dpll_speed / 2;
-
-		tmpset.cm_clksel1_pll = CM_CLKSEL1_PLL;
-		tmpset.cm_clksel1_pll &= ~(0x3FFF << 8);
-		div = ((curr_prcm_set->xtal_speed / 1000000) - 1);
-		tmpset.cm_clksel2_pll = CM_CLKSEL2_PLL;
-		tmpset.cm_clksel2_pll &= ~0x3;
-		if (rate > low) {
-			tmpset.cm_clksel2_pll |= 0x2;
-			mult = ((rate / 2) / 1000000);
-			done_rate = PRCM_FULL_SPEED;
-		} else {
-			tmpset.cm_clksel2_pll |= 0x1;
-			mult = (rate / 1000000);
-			done_rate = PRCM_HALF_SPEED;
-		}
-		tmpset.cm_clksel1_pll |= ((div << 8) | (mult << 12));
-
-		/* Worst case */
-		tmpset.base_sdrc_rfr = V24XX_SDRC_RFR_CTRL_BYPASS;
-
-		if (rate == curr_prcm_set->xtal_speed)	/* If asking for 1-1 */
-			bypass = 1;
-
-		omap2_reprogram_sdrc(PRCM_FULL_SPEED, 1); /* For init_mem */
-
-		/* Force dll lock mode */
-		omap2_set_prcm(tmpset.cm_clksel1_pll, tmpset.base_sdrc_rfr,
-			       bypass);
-
-		/* Errata: ret dll entry state */
-		omap2_init_memory_params(omap2_dll_force_needed());
-		omap2_reprogram_sdrc(done_rate, 0);
-	}
-	omap2_clksel_recalc(&dpll_ck);
-	ret = 0;
-
-dpll_exit:
-	local_irq_restore(flags);
-	return(ret);
-}
-
-/* Just return the MPU speed */
-static void omap2_mpu_recalc(struct clk * clk)
-{
-	clk->rate = curr_prcm_set->mpu_speed;
-}
-
-/*
- * Look for a rate equal or less than the target rate given a configuration set.
- *
- * What's not entirely clear is "which" field represents the key field.
- * Some might argue L3-DDR, others ARM, others IVA. This code is simple and
- * just uses the ARM rates.
- */
-static long omap2_round_to_table_rate(struct clk * clk, unsigned long rate)
-{
-	struct prcm_config * ptr;
-	long highest_rate;
-
-	if (clk != &virt_prcm_set)
-		return -EINVAL;
-
-	highest_rate = -EINVAL;
-
-	for (ptr = rate_table; ptr->mpu_speed; ptr++) {
-		if (ptr->xtal_speed != sys_ck.rate)
-			continue;
-
-		highest_rate = ptr->mpu_speed;
-
-		/* Can check only after xtal frequency check */
-		if (ptr->mpu_speed <= rate)
-			break;
-	}
-	return highest_rate;
-}
-
-/*
- * omap2_convert_field_to_div() - turn field value into integer divider
- */
-static u32 omap2_clksel_to_divisor(u32 div_sel, u32 field_val)
-{
-	u32 i;
-	u32 clkout_array[] = {1, 2, 4, 8, 16};
-
-	if ((div_sel & SRC_RATE_SEL_MASK) == CM_SYSCLKOUT_SEL1) {
-		for (i = 0; i < 5; i++) {
-			if (field_val == i)
-				return clkout_array[i];
-		}
-		return ~0;
-	} else
-		return field_val;
-}
-
-/*
- * Returns the CLKSEL divider register value
- * REVISIT: This should be cleaned up to work nicely with void __iomem *
- */
-static u32 omap2_get_clksel(u32 *div_sel, u32 *field_mask,
-			    struct clk *clk)
-{
-	int ret = ~0;
-	u32 reg_val, div_off;
-	u32 div_addr = 0;
-	u32 mask = ~0;
-
-	div_off = clk->rate_offset;
-
-	switch ((*div_sel & SRC_RATE_SEL_MASK)) {
-	case CM_MPU_SEL1:
-		div_addr = (u32)&CM_CLKSEL_MPU;
-		mask = 0x1f;
-		break;
-	case CM_DSP_SEL1:
-		div_addr = (u32)&CM_CLKSEL_DSP;
-		if (cpu_is_omap2420()) {
-			if ((div_off == 0) || (div_off == 8))
-				mask = 0x1f;
-			else if (div_off == 5)
-				mask = 0x3;
-		} else if (cpu_is_omap2430()) {
-			if (div_off == 0)
-				mask = 0x1f;
-			else if (div_off == 5)
-				mask = 0x3;
-		}
-		break;
-	case CM_GFX_SEL1:
-		div_addr = (u32)&CM_CLKSEL_GFX;
-		if (div_off == 0)
-			mask = 0x7;
-		break;
-	case CM_MODEM_SEL1:
-		div_addr = (u32)&CM_CLKSEL_MDM;
-		if (div_off == 0)
-			mask = 0xf;
-		break;
-	case CM_SYSCLKOUT_SEL1:
-		div_addr = (u32)&PRCM_CLKOUT_CTRL;
-		if ((div_off == 3) || (div_off == 11))
-			mask= 0x3;
-		break;
-	case CM_CORE_SEL1:
-		div_addr = (u32)&CM_CLKSEL1_CORE;
-		switch (div_off) {
-		case 0:					/* l3 */
-		case 8:					/* dss1 */
-		case 15:				/* vylnc-2420 */
-		case 20:				/* ssi */
-			mask = 0x1f; break;
-		case 5:					/* l4 */
-			mask = 0x3; break;
-		case 13:				/* dss2 */
-			mask = 0x1; break;
-		case 25:				/* usb */
-			mask = 0x7; break;
-		}
-	}
-
-	*field_mask = mask;
-
-	if (unlikely(mask == ~0))
-		div_addr = 0;
-
-	*div_sel = div_addr;
-
-	if (unlikely(div_addr == 0))
-		return ret;
-
-	/* Isolate field */
-	reg_val = __raw_readl((void __iomem *)div_addr) & (mask << div_off);
-
-	/* Normalize back to divider value */
-	reg_val >>= div_off;
-
-	return reg_val;
-}
-
-/*
- * Return divider to be applied to parent clock.
- * Return 0 on error.
- */
-static u32 omap2_clksel_get_divisor(struct clk *clk)
-{
-	int ret = 0;
-	u32 div, div_sel, div_off, field_mask, field_val;
-
-	/* isolate control register */
-	div_sel = (SRC_RATE_SEL_MASK & clk->flags);
-
-	div_off = clk->rate_offset;
-	field_val = omap2_get_clksel(&div_sel, &field_mask, clk);
-	if (div_sel == 0)
-		return ret;
-
-	div_sel = (SRC_RATE_SEL_MASK & clk->flags);
-	div = omap2_clksel_to_divisor(div_sel, field_val);
-
-	return div;
-}
-
-/* Set the clock rate for a clock source */
-static int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
-
-{
-	int ret = -EINVAL;
-	void __iomem * reg;
-	u32 div_sel, div_off, field_mask, field_val, reg_val, validrate;
-	u32 new_div = 0;
-
-	if (!(clk->flags & CONFIG_PARTICIPANT) && (clk->flags & RATE_CKCTL)) {
-		if (clk == &dpll_ck)
-			return omap2_reprogram_dpll(clk, rate);
-
-		/* Isolate control register */
-		div_sel = (SRC_RATE_SEL_MASK & clk->flags);
-		div_off = clk->rate_offset;
-
-		validrate = omap2_clksel_round_rate(clk, rate, &new_div);
-		if (validrate != rate)
-			return(ret);
-
-		field_val = omap2_get_clksel(&div_sel, &field_mask, clk);
-		if (div_sel == 0)
-			return ret;
-
-		if (clk->flags & CM_SYSCLKOUT_SEL1) {
-			switch (new_div) {
-			case 16:
-				field_val = 4;
-				break;
-			case 8:
-				field_val = 3;
-				break;
-			case 4:
-				field_val = 2;
-				break;
-			case 2:
-				field_val = 1;
-				break;
-			case 1:
-				field_val = 0;
-				break;
-			}
-		} else
-			field_val = new_div;
-
-		reg = (void __iomem *)div_sel;
-
-		reg_val = __raw_readl(reg);
-		reg_val &= ~(field_mask << div_off);
-		reg_val |= (field_val << div_off);
-		__raw_writel(reg_val, reg);
-		wmb();
-		clk->rate = clk->parent->rate / field_val;
-
-		if (clk->flags & DELAYED_APP) {
-			__raw_writel(0x1, (void __iomem *)&PRCM_CLKCFG_CTRL);
-			wmb();
-		}
-		ret = 0;
-	} else if (clk->set_rate != 0)
-		ret = clk->set_rate(clk, rate);
-
-	if (unlikely(ret == 0 && (clk->flags & RATE_PROPAGATES)))
-		propagate_rate(clk);
-
-	return ret;
-}
-
-/* Converts encoded control register address into a full address */
-static u32 omap2_get_src_field(u32 *type_to_addr, u32 reg_offset,
-			       struct clk *src_clk, u32 *field_mask)
-{
-	u32 val = ~0, src_reg_addr = 0, mask = 0;
-
-	/* Find target control register.*/
-	switch ((*type_to_addr & SRC_RATE_SEL_MASK)) {
-	case CM_CORE_SEL1:
-		src_reg_addr = (u32)&CM_CLKSEL1_CORE;
-		if (reg_offset == 13) {			/* DSS2_fclk */
-			mask = 0x1;
-			if (src_clk == &sys_ck)
-				val = 0;
-			if (src_clk == &func_48m_ck)
-				val = 1;
-		} else if (reg_offset == 8) {		/* DSS1_fclk */
-			mask = 0x1f;
-			if (src_clk == &sys_ck)
-				val = 0;
-			else if (src_clk == &core_ck)	/* divided clock */
-				val = 0x10;		/* rate needs fixing */
-		} else if ((reg_offset == 15) && cpu_is_omap2420()){ /*vlnyq*/
-			mask = 0x1F;
-			if(src_clk == &func_96m_ck)
-				val = 0;
-			else if (src_clk == &core_ck)
-				val = 0x10;
-		}
-		break;
-	case CM_CORE_SEL2:
-		src_reg_addr = (u32)&CM_CLKSEL2_CORE;
-		mask = 0x3;
-		if (src_clk == &func_32k_ck)
-			val = 0x0;
-		if (src_clk == &sys_ck)
-			val = 0x1;
-		if (src_clk == &alt_ck)
-			val = 0x2;
-		break;
-	case CM_WKUP_SEL1:
-		src_reg_addr = (u32)&CM_CLKSEL_WKUP;
-		mask = 0x3;
-		if (src_clk == &func_32k_ck)
-			val = 0x0;
-		if (src_clk == &sys_ck)
-			val = 0x1;
-		if (src_clk == &alt_ck)
-			val = 0x2;
-		break;
-	case CM_PLL_SEL1:
-		src_reg_addr = (u32)&CM_CLKSEL1_PLL;
-		mask = 0x1;
-		if (reg_offset == 0x3) {
-			if (src_clk == &apll96_ck)
-				val = 0;
-			if (src_clk == &alt_ck)
-				val = 1;
-		}
-		else if (reg_offset == 0x5) {
-			if (src_clk == &apll54_ck)
-				val = 0;
-			if (src_clk == &alt_ck)
-				val = 1;
-		}
-		break;
-	case CM_PLL_SEL2:
-		src_reg_addr = (u32)&CM_CLKSEL2_PLL;
-		mask = 0x3;
-		if (src_clk == &func_32k_ck)
-			val = 0x0;
-		if (src_clk == &dpll_ck)
-			val = 0x2;
-		break;
-	case CM_SYSCLKOUT_SEL1:
-		src_reg_addr = (u32)&PRCM_CLKOUT_CTRL;
-		mask = 0x3;
-		if (src_clk == &dpll_ck)
-			val = 0;
-		if (src_clk == &sys_ck)
-			val = 1;
-		if (src_clk == &func_96m_ck)
-			val = 2;
-		if (src_clk == &func_54m_ck)
-			val = 3;
-		break;
-	}
-
-	if (val == ~0)			/* Catch errors in offset */
-		*type_to_addr = 0;
-	else
-		*type_to_addr = src_reg_addr;
-	*field_mask = mask;
-
-	return val;
-}
-
-static int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
-{
-	void __iomem * reg;
-	u32 src_sel, src_off, field_val, field_mask, reg_val, rate;
-	int ret = -EINVAL;
-
-	if (unlikely(clk->flags & CONFIG_PARTICIPANT))
-		return ret;
-
-	if (clk->flags & SRC_SEL_MASK) {	/* On-chip SEL collection */
-		src_sel = (SRC_RATE_SEL_MASK & clk->flags);
-		src_off = clk->src_offset;
-
-		if (src_sel == 0)
-			goto set_parent_error;
-
-		field_val = omap2_get_src_field(&src_sel, src_off, new_parent,
-						&field_mask);
-
-		reg = (void __iomem *)src_sel;
-
-		if (clk->usecount > 0)
-			_omap2_clk_disable(clk);
-
-		/* Set new source value (previous dividers if any in effect) */
-		reg_val = __raw_readl(reg) & ~(field_mask << src_off);
-		reg_val |= (field_val << src_off);
-		__raw_writel(reg_val, reg);
-		wmb();
-
-		if (clk->flags & DELAYED_APP) {
-			__raw_writel(0x1, (void __iomem *)&PRCM_CLKCFG_CTRL);
-			wmb();
-		}
-		if (clk->usecount > 0)
-			_omap2_clk_enable(clk);
-
-		clk->parent = new_parent;
-
-		/* SRC_RATE_SEL_MASK clocks follow their parents rates.*/
-		if ((new_parent == &core_ck) && (clk == &dss1_fck))
-			clk->rate = new_parent->rate / 0x10;
-		else
-			clk->rate = new_parent->rate;
-
-		if (unlikely(clk->flags & RATE_PROPAGATES))
-			propagate_rate(clk);
-
-		return 0;
-	} else {
-		clk->parent = new_parent;
-		rate = new_parent->rate;
-		omap2_clk_set_rate(clk, rate);
-		ret = 0;
-	}
-
- set_parent_error:
-	return ret;
-}
-
-/* Sets basic clocks based on the specified rate */
-static int omap2_select_table_rate(struct clk * clk, unsigned long rate)
-{
-	u32 flags, cur_rate, done_rate, bypass = 0;
-	u8 cpu_mask = 0;
-	struct prcm_config *prcm;
-	unsigned long found_speed = 0;
-
-	if (clk != &virt_prcm_set)
-		return -EINVAL;
-
-	/* FIXME: Change cpu_is_omap2420() to cpu_is_omap242x() */
-	if (cpu_is_omap2420())
-		cpu_mask = RATE_IN_242X;
-	else if (cpu_is_omap2430())
-		cpu_mask = RATE_IN_243X;
-
-	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
-		if (!(prcm->flags & cpu_mask))
-			continue;
-
-		if (prcm->xtal_speed != sys_ck.rate)
-			continue;
-
-		if (prcm->mpu_speed <= rate) {
-			found_speed = prcm->mpu_speed;
-			break;
-		}
-	}
-
-	if (!found_speed) {
-		printk(KERN_INFO "Could not set MPU rate to %luMHz\n",
-	 rate / 1000000);
-		return -EINVAL;
-	}
-
-	curr_prcm_set = prcm;
-	cur_rate = omap2_get_dpll_rate(&dpll_ck);
-
-	if (prcm->dpll_speed == cur_rate / 2) {
-		omap2_reprogram_sdrc(PRCM_HALF_SPEED, 1);
-	} else if (prcm->dpll_speed == cur_rate * 2) {
-		omap2_reprogram_sdrc(PRCM_FULL_SPEED, 1);
-	} else if (prcm->dpll_speed != cur_rate) {
-		local_irq_save(flags);
-
-		if (prcm->dpll_speed == prcm->xtal_speed)
-			bypass = 1;
-
-		if ((prcm->cm_clksel2_pll & 0x3) == 2)
-			done_rate = PRCM_FULL_SPEED;
-		else
-			done_rate = PRCM_HALF_SPEED;
-
-		/* MPU divider */
-		CM_CLKSEL_MPU = prcm->cm_clksel_mpu;
-
-		/* dsp + iva1 div(2420), iva2.1(2430) */
-		CM_CLKSEL_DSP = prcm->cm_clksel_dsp;
-
-		CM_CLKSEL_GFX = prcm->cm_clksel_gfx;
-
-		/* Major subsystem dividers */
-		CM_CLKSEL1_CORE = prcm->cm_clksel1_core;
-		if (cpu_is_omap2430())
-			CM_CLKSEL_MDM = prcm->cm_clksel_mdm;
-
-		/* x2 to enter init_mem */
-		omap2_reprogram_sdrc(PRCM_FULL_SPEED, 1);
-
-		omap2_set_prcm(prcm->cm_clksel1_pll, prcm->base_sdrc_rfr,
-			       bypass);
-
-		omap2_init_memory_params(omap2_dll_force_needed());
-		omap2_reprogram_sdrc(done_rate, 0);
-
-		local_irq_restore(flags);
-	}
-	omap2_clksel_recalc(&dpll_ck);
-
-	return 0;
-}
-
-/*-------------------------------------------------------------------------
- * Omap2 clock reset and init functions
- *-------------------------------------------------------------------------*/
-
-#ifdef CONFIG_OMAP_RESET_CLOCKS
-static void __init omap2_clk_disable_unused(struct clk *clk)
-{
-	u32 regval32;
-
-	regval32 = __raw_readl(clk->enable_reg);
-	if ((regval32 & (1 << clk->enable_bit)) == 0)
-		return;
-
-	printk(KERN_INFO "Disabling unused clock \"%s\"\n", clk->name);
-	_omap2_clk_disable(clk);
-}
-#else
-#define omap2_clk_disable_unused	NULL
-#endif
-
-static struct clk_functions omap2_clk_functions = {
-	.clk_enable		= omap2_clk_enable,
-	.clk_disable		= omap2_clk_disable,
-	.clk_round_rate		= omap2_clk_round_rate,
-	.clk_set_rate		= omap2_clk_set_rate,
-	.clk_set_parent		= omap2_clk_set_parent,
-	.clk_disable_unused	= omap2_clk_disable_unused,
-};
-
-static void __init omap2_get_crystal_rate(struct clk *osc, struct clk *sys)
-{
-	u32 div, aplls, sclk = 13000000;
-
-	aplls = CM_CLKSEL1_PLL;
-	aplls &= ((1 << 23) | (1 << 24) | (1 << 25));
-	aplls >>= 23;			/* Isolate field, 0,2,3 */
-
-	if (aplls == 0)
-		sclk = 19200000;
-	else if (aplls == 2)
-		sclk = 13000000;
-	else if (aplls == 3)
-		sclk = 12000000;
-
-	div = PRCM_CLKSRC_CTRL;
-	div &= ((1 << 7) | (1 << 6));
-	div >>= sys->rate_offset;
-
-	osc->rate = sclk * div;
-	sys->rate = sclk;
-}
-
-/*
- * Set clocks for bypass mode for reboot to work.
- */
-void omap2_clk_prepare_for_reboot(void)
-{
-	u32 rate;
-
-	if (vclk == NULL || sclk == NULL)
-		return;
-
-	rate = clk_get_rate(sclk);
-	clk_set_rate(vclk, rate);
-}
-
-/*
- * Switch the MPU rate if specified on cmdline.
- * We cannot do this early until cmdline is parsed.
- */
-static int __init omap2_clk_arch_init(void)
-{
-	if (!mpurate)
-		return -EINVAL;
-
-	if (omap2_select_table_rate(&virt_prcm_set, mpurate))
-		printk(KERN_ERR "Could not find matching MPU rate\n");
-
-	propagate_rate(&osc_ck);		/* update main root fast */
-	propagate_rate(&func_32k_ck);		/* update main root slow */
-
-	printk(KERN_INFO "Switched to new clocking rate (Crystal/DPLL/MPU): "
-	       "%ld.%01ld/%ld/%ld MHz\n",
-	       (sys_ck.rate / 1000000), (sys_ck.rate / 100000) % 10,
-	       (dpll_ck.rate / 1000000), (mpu_ck.rate / 1000000)) ;
-
-	return 0;
-}
-arch_initcall(omap2_clk_arch_init);
-
-int __init omap2_clk_init(void)
-{
-	struct prcm_config *prcm;
-	struct clk ** clkp;
-	u32 clkrate;
-
-	clk_init(&omap2_clk_functions);
-	omap2_get_crystal_rate(&osc_ck, &sys_ck);
-
-	for (clkp = onchip_clks; clkp < onchip_clks + ARRAY_SIZE(onchip_clks);
-	     clkp++) {
-
-		if ((*clkp)->flags & CLOCK_IN_OMAP242X && cpu_is_omap2420()) {
-			clk_register(*clkp);
-			continue;
-		}
-
-		if ((*clkp)->flags & CLOCK_IN_OMAP243X && cpu_is_omap2430()) {
-			clk_register(*clkp);
-			continue;
-		}
-	}
-
-	/* Check the MPU rate set by bootloader */
-	clkrate = omap2_get_dpll_rate(&dpll_ck);
-	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
-		if (prcm->xtal_speed != sys_ck.rate)
-			continue;
-		if (prcm->dpll_speed <= clkrate)
-			 break;
-	}
-	curr_prcm_set = prcm;
-
-	propagate_rate(&osc_ck);		/* update main root fast */
-	propagate_rate(&func_32k_ck);		/* update main root slow */
-
-	printk(KERN_INFO "Clocking rate (Crystal/DPLL/MPU): "
-	       "%ld.%01ld/%ld/%ld MHz\n",
-	       (sys_ck.rate / 1000000), (sys_ck.rate / 100000) % 10,
-	       (dpll_ck.rate / 1000000), (mpu_ck.rate / 1000000)) ;
-
-	/*
-	 * Only enable those clocks we will need, let the drivers
-	 * enable other clocks as necessary
-	 */
-	clk_enable(&sync_32k_ick);
-	clk_enable(&omapctrl_ick);
-
-	/* Force the APLLs always active. The clocks are idled
-	 * automatically by hardware. */
-	clk_enable(&apll96_ck);
-	clk_enable(&apll54_ck);
-
-	if (cpu_is_omap2430())
-		clk_enable(&sdrc_ick);
-
-	/* Avoid sleeping sleeping during omap2_clk_prepare_for_reboot() */
-	vclk = clk_get(NULL, "virt_prcm_set");
-	sclk = clk_get(NULL, "sys_ck");
-
-	return 0;
-}
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
deleted file mode 100644
index 4f79186..0000000
--- a/arch/arm/mach-omap2/clock.h
+++ /dev/null
@@ -1,2111 +0,0 @@
-/*
- *  linux/arch/arm/mach-omap24xx/clock.h
- *
- *  Copyright (C) 2005 Texas Instruments Inc.
- *  Richard Woodruff <r-woodruff2@ti.com>
- *  Created for OMAP2.
- *
- *  Copyright (C) 2004 Nokia corporation
- *  Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
- *  Based on clocks.h by Tony Lindgren, Gordon McNutt and RidgeRun, Inc
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK_H
-#define __ARCH_ARM_MACH_OMAP2_CLOCK_H
-
-static void omap2_sys_clk_recalc(struct clk * clk);
-static void omap2_clksel_recalc(struct clk * clk);
-static void omap2_followparent_recalc(struct clk * clk);
-static void omap2_propagate_rate(struct clk * clk);
-static void omap2_mpu_recalc(struct clk * clk);
-static int omap2_select_table_rate(struct clk * clk, unsigned long rate);
-static long omap2_round_to_table_rate(struct clk * clk, unsigned long rate);
-static void omap2_clk_disable(struct clk *clk);
-static void omap2_sys_clk_recalc(struct clk * clk);
-static u32 omap2_clksel_to_divisor(u32 div_sel, u32 field_val);
-static u32 omap2_clksel_get_divisor(struct clk *clk);
-
-
-#define RATE_IN_242X	(1 << 0)
-#define RATE_IN_243X	(1 << 1)
-
-/* Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
- * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,CM_CLKSEL_DSP
- * CM_CLKSEL_GFX, CM_CLKSEL1_CORE, CM_CLKSEL1_PLL CM_CLKSEL2_PLL, CM_CLKSEL_MDM
- */
-struct prcm_config {
-	unsigned long xtal_speed;	/* crystal rate */
-	unsigned long dpll_speed;	/* dpll: out*xtal*M/(N-1)table_recalc */
-	unsigned long mpu_speed;	/* speed of MPU */
-	unsigned long cm_clksel_mpu;	/* mpu divider */
-	unsigned long cm_clksel_dsp;	/* dsp+iva1 div(2420), iva2.1(2430) */
-	unsigned long cm_clksel_gfx;	/* gfx dividers */
-	unsigned long cm_clksel1_core;	/* major subsystem dividers */
-	unsigned long cm_clksel1_pll;	/* m,n */
-	unsigned long cm_clksel2_pll;	/* dpllx1 or x2 out */
-	unsigned long cm_clksel_mdm;	/* modem dividers 2430 only */
-	unsigned long base_sdrc_rfr;	/* base refresh timing for a set */
-	unsigned char flags;
-};
-
-/* Mask for clksel which support parent settign in set_rate */
-#define SRC_SEL_MASK (CM_CORE_SEL1 | CM_CORE_SEL2 | CM_WKUP_SEL1 | \
-			CM_PLL_SEL1 | CM_PLL_SEL2 | CM_SYSCLKOUT_SEL1)
-
-/* Mask for clksel regs which support rate operations */
-#define SRC_RATE_SEL_MASK (CM_MPU_SEL1 | CM_DSP_SEL1 | CM_GFX_SEL1 | \
-			CM_MODEM_SEL1 | CM_CORE_SEL1 | CM_CORE_SEL2 | \
-			CM_WKUP_SEL1 | CM_PLL_SEL1 | CM_PLL_SEL2 | \
-			CM_SYSCLKOUT_SEL1)
-
-/*
- * The OMAP2 processor can be run at several discrete 'PRCM configurations'.
- * These configurations are characterized by voltage and speed for clocks.
- * The device is only validated for certain combinations. One way to express
- * these combinations is via the 'ratio's' which the clocks operate with
- * respect to each other. These ratio sets are for a given voltage/DPLL
- * setting. All configurations can be described by a DPLL setting and a ratio
- * There are 3 ratio sets for the 2430 and X ratio sets for 2420.
- *
- * 2430 differs from 2420 in that there are no more phase synchronizers used.
- * They both have a slightly different clock domain setup. 2420(iva1,dsp) vs
- * 2430 (iva2.1, NOdsp, mdm)
- */
-
-/* Core fields for cm_clksel, not ratio governed */
-#define RX_CLKSEL_DSS1			(0x10 << 8)
-#define RX_CLKSEL_DSS2			(0x0 << 13)
-#define RX_CLKSEL_SSI			(0x5 << 20)
-
-/*-------------------------------------------------------------------------
- * Voltage/DPLL ratios
- *-------------------------------------------------------------------------*/
-
-/* 2430 Ratio's, 2430-Ratio Config 1 */
-#define R1_CLKSEL_L3			(4 << 0)
-#define R1_CLKSEL_L4			(2 << 5)
-#define R1_CLKSEL_USB			(4 << 25)
-#define R1_CM_CLKSEL1_CORE_VAL		R1_CLKSEL_USB | RX_CLKSEL_SSI | \
-					RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \
-					R1_CLKSEL_L4 | R1_CLKSEL_L3
-#define R1_CLKSEL_MPU			(2 << 0)
-#define R1_CM_CLKSEL_MPU_VAL		R1_CLKSEL_MPU
-#define R1_CLKSEL_DSP			(2 << 0)
-#define R1_CLKSEL_DSP_IF		(2 << 5)
-#define R1_CM_CLKSEL_DSP_VAL		R1_CLKSEL_DSP | R1_CLKSEL_DSP_IF
-#define R1_CLKSEL_GFX			(2 << 0)
-#define R1_CM_CLKSEL_GFX_VAL		R1_CLKSEL_GFX
-#define R1_CLKSEL_MDM			(4 << 0)
-#define R1_CM_CLKSEL_MDM_VAL		R1_CLKSEL_MDM
-
-/* 2430-Ratio Config 2 */
-#define R2_CLKSEL_L3			(6 << 0)
-#define R2_CLKSEL_L4			(2 << 5)
-#define R2_CLKSEL_USB			(2 << 25)
-#define R2_CM_CLKSEL1_CORE_VAL		R2_CLKSEL_USB | RX_CLKSEL_SSI | \
-					RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \
-					R2_CLKSEL_L4 | R2_CLKSEL_L3
-#define R2_CLKSEL_MPU			(2 << 0)
-#define R2_CM_CLKSEL_MPU_VAL		R2_CLKSEL_MPU
-#define R2_CLKSEL_DSP			(2 << 0)
-#define R2_CLKSEL_DSP_IF		(3 << 5)
-#define R2_CM_CLKSEL_DSP_VAL		R2_CLKSEL_DSP | R2_CLKSEL_DSP_IF
-#define R2_CLKSEL_GFX			(2 << 0)
-#define R2_CM_CLKSEL_GFX_VAL		R2_CLKSEL_GFX
-#define R2_CLKSEL_MDM			(6 << 0)
-#define R2_CM_CLKSEL_MDM_VAL		R2_CLKSEL_MDM
-
-/* 2430-Ratio Bootm (BYPASS) */
-#define RB_CLKSEL_L3			(1 << 0)
-#define RB_CLKSEL_L4			(1 << 5)
-#define RB_CLKSEL_USB			(1 << 25)
-#define RB_CM_CLKSEL1_CORE_VAL		RB_CLKSEL_USB | RX_CLKSEL_SSI | \
-					RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \
-					RB_CLKSEL_L4 | RB_CLKSEL_L3
-#define RB_CLKSEL_MPU			(1 << 0)
-#define RB_CM_CLKSEL_MPU_VAL		RB_CLKSEL_MPU
-#define RB_CLKSEL_DSP			(1 << 0)
-#define RB_CLKSEL_DSP_IF		(1 << 5)
-#define RB_CM_CLKSEL_DSP_VAL		RB_CLKSEL_DSP | RB_CLKSEL_DSP_IF
-#define RB_CLKSEL_GFX			(1 << 0)
-#define RB_CM_CLKSEL_GFX_VAL		RB_CLKSEL_GFX
-#define RB_CLKSEL_MDM			(1 << 0)
-#define RB_CM_CLKSEL_MDM_VAL		RB_CLKSEL_MDM
-
-/* 2420 Ratio Equivalents */
-#define RXX_CLKSEL_VLYNQ		(0x12 << 15)
-#define RXX_CLKSEL_SSI			(0x8 << 20)
-
-/* 2420-PRCM III 532MHz core */
-#define RIII_CLKSEL_L3			(4 << 0)	/* 133MHz */
-#define RIII_CLKSEL_L4			(2 << 5)	/* 66.5MHz */
-#define RIII_CLKSEL_USB			(4 << 25)	/* 33.25MHz */
-#define RIII_CM_CLKSEL1_CORE_VAL	RIII_CLKSEL_USB | RXX_CLKSEL_SSI | \
-					RXX_CLKSEL_VLYNQ | RX_CLKSEL_DSS2 | \
-					RX_CLKSEL_DSS1 | RIII_CLKSEL_L4 | \
-					RIII_CLKSEL_L3
-#define RIII_CLKSEL_MPU			(2 << 0)	/* 266MHz */
-#define RIII_CM_CLKSEL_MPU_VAL		RIII_CLKSEL_MPU
-#define RIII_CLKSEL_DSP			(3 << 0)	/* c5x - 177.3MHz */
-#define RIII_CLKSEL_DSP_IF		(2 << 5)	/* c5x - 88.67MHz */
-#define RIII_SYNC_DSP			(1 << 7)	/* Enable sync */
-#define RIII_CLKSEL_IVA			(6 << 8)	/* iva1 - 88.67MHz */
-#define RIII_SYNC_IVA			(1 << 13)	/* Enable sync */
-#define RIII_CM_CLKSEL_DSP_VAL		RIII_SYNC_IVA | RIII_CLKSEL_IVA | \
-					RIII_SYNC_DSP | RIII_CLKSEL_DSP_IF | \
-					RIII_CLKSEL_DSP
-#define RIII_CLKSEL_GFX			(2 << 0)	/* 66.5MHz */
-#define RIII_CM_CLKSEL_GFX_VAL		RIII_CLKSEL_GFX
-
-/* 2420-PRCM II 600MHz core */
-#define RII_CLKSEL_L3			(6 << 0)	/* 100MHz */
-#define RII_CLKSEL_L4			(2 << 5)	/* 50MHz */
-#define RII_CLKSEL_USB			(2 << 25)	/* 50MHz */
-#define RII_CM_CLKSEL1_CORE_VAL		RII_CLKSEL_USB | \
-					RXX_CLKSEL_SSI | RXX_CLKSEL_VLYNQ | \
-					RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \
-					RII_CLKSEL_L4 | RII_CLKSEL_L3
-#define RII_CLKSEL_MPU			(2 << 0)	/* 300MHz */
-#define RII_CM_CLKSEL_MPU_VAL		RII_CLKSEL_MPU
-#define RII_CLKSEL_DSP			(3 << 0)	/* c5x - 200MHz */
-#define RII_CLKSEL_DSP_IF		(2 << 5)	/* c5x - 100MHz */
-#define RII_SYNC_DSP			(0 << 7)	/* Bypass sync */
-#define RII_CLKSEL_IVA			(6 << 8)	/* iva1 - 200MHz */
-#define RII_SYNC_IVA			(0 << 13)	/* Bypass sync */
-#define RII_CM_CLKSEL_DSP_VAL		RII_SYNC_IVA | RII_CLKSEL_IVA | \
-					RII_SYNC_DSP | RII_CLKSEL_DSP_IF | \
-					RII_CLKSEL_DSP
-#define RII_CLKSEL_GFX			(2 << 0)	/* 50MHz */
-#define RII_CM_CLKSEL_GFX_VAL		RII_CLKSEL_GFX
-
-/* 2420-PRCM VII (boot) */
-#define RVII_CLKSEL_L3			(1 << 0)
-#define RVII_CLKSEL_L4			(1 << 5)
-#define RVII_CLKSEL_DSS1		(1 << 8)
-#define RVII_CLKSEL_DSS2		(0 << 13)
-#define RVII_CLKSEL_VLYNQ		(1 << 15)
-#define RVII_CLKSEL_SSI			(1 << 20)
-#define RVII_CLKSEL_USB			(1 << 25)
-
-#define RVII_CM_CLKSEL1_CORE_VAL	RVII_CLKSEL_USB | RVII_CLKSEL_SSI | \
-					RVII_CLKSEL_VLYNQ | RVII_CLKSEL_DSS2 | \
-					RVII_CLKSEL_DSS1 | RVII_CLKSEL_L4 | RVII_CLKSEL_L3
-
-#define RVII_CLKSEL_MPU			(1 << 0) /* all divide by 1 */
-#define RVII_CM_CLKSEL_MPU_VAL		RVII_CLKSEL_MPU
-
-#define RVII_CLKSEL_DSP			(1 << 0)
-#define RVII_CLKSEL_DSP_IF		(1 << 5)
-#define RVII_SYNC_DSP			(0 << 7)
-#define RVII_CLKSEL_IVA			(1 << 8)
-#define RVII_SYNC_IVA			(0 << 13)
-#define RVII_CM_CLKSEL_DSP_VAL		RVII_SYNC_IVA | RVII_CLKSEL_IVA | RVII_SYNC_DSP | \
-					RVII_CLKSEL_DSP_IF | RVII_CLKSEL_DSP
-
-#define RVII_CLKSEL_GFX			(1 << 0)
-#define RVII_CM_CLKSEL_GFX_VAL		RVII_CLKSEL_GFX
-
-/*-------------------------------------------------------------------------
- * 2430 Target modes: Along with each configuration the CPU has several
- * modes which goes along with them. Modes mainly are the addition of
- * describe DPLL combinations to go along with a ratio.
- *-------------------------------------------------------------------------*/
-
-/* Hardware governed */
-#define MX_48M_SRC			(0 << 3)
-#define MX_54M_SRC			(0 << 5)
-#define MX_APLLS_CLIKIN_12		(3 << 23)
-#define MX_APLLS_CLIKIN_13		(2 << 23)
-#define MX_APLLS_CLIKIN_19_2		(0 << 23)
-
-/*
- * 2430 - standalone, 2*ref*M/(n+1), M/N is for exactness not relock speed
- * #2	(ratio1) baseport-target
- * #5a	(ratio1) baseport-target, target DPLL = 266*2 = 532MHz
- */
-#define M5A_DPLL_MULT_12		(133 << 12)
-#define M5A_DPLL_DIV_12			(5 << 8)
-#define M5A_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M5A_DPLL_DIV_12 | M5A_DPLL_MULT_12 | \
-					MX_APLLS_CLIKIN_12
-#define M5A_DPLL_MULT_13		(266 << 12)
-#define M5A_DPLL_DIV_13			(12 << 8)
-#define M5A_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M5A_DPLL_DIV_13 | M5A_DPLL_MULT_13 | \
-					MX_APLLS_CLIKIN_13
-#define M5A_DPLL_MULT_19		(180 << 12)
-#define M5A_DPLL_DIV_19			(12 << 8)
-#define M5A_CM_CLKSEL1_PLL_19_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M5A_DPLL_DIV_19 | M5A_DPLL_MULT_19 | \
-					MX_APLLS_CLIKIN_19_2
-/* #5b	(ratio1) target DPLL = 200*2 = 400MHz */
-#define M5B_DPLL_MULT_12		(50 << 12)
-#define M5B_DPLL_DIV_12			(2 << 8)
-#define M5B_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M5B_DPLL_DIV_12 | M5B_DPLL_MULT_12 | \
-					MX_APLLS_CLIKIN_12
-#define M5B_DPLL_MULT_13		(200 << 12)
-#define M5B_DPLL_DIV_13			(12 << 8)
-
-#define M5B_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M5B_DPLL_DIV_13 | M5B_DPLL_MULT_13 | \
-					MX_APLLS_CLIKIN_13
-#define M5B_DPLL_MULT_19		(125 << 12)
-#define M5B_DPLL_DIV_19			(31 << 8)
-#define M5B_CM_CLKSEL1_PLL_19_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M5B_DPLL_DIV_19 | M5B_DPLL_MULT_19 | \
-					MX_APLLS_CLIKIN_19_2
-/*
- * #4	(ratio2)
- * #3	(ratio2) baseport-target, target DPLL = 330*2 = 660MHz
- */
-#define M3_DPLL_MULT_12			(55 << 12)
-#define M3_DPLL_DIV_12			(1 << 8)
-#define M3_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M3_DPLL_DIV_12 | M3_DPLL_MULT_12 | \
-					MX_APLLS_CLIKIN_12
-#define M3_DPLL_MULT_13			(330 << 12)
-#define M3_DPLL_DIV_13			(12 << 8)
-#define M3_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M3_DPLL_DIV_13 | M3_DPLL_MULT_13 | \
-					MX_APLLS_CLIKIN_13
-#define M3_DPLL_MULT_19			(275 << 12)
-#define M3_DPLL_DIV_19			(15 << 8)
-#define M3_CM_CLKSEL1_PLL_19_VAL	MX_48M_SRC | MX_54M_SRC | \
-					M3_DPLL_DIV_19 | M3_DPLL_MULT_19 | \
-					MX_APLLS_CLIKIN_19_2
-/* boot (boot) */
-#define MB_DPLL_MULT			(1 << 12)
-#define MB_DPLL_DIV			(0 << 8)
-#define MB_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | MB_DPLL_DIV |\
-					MB_DPLL_MULT | MX_APLLS_CLIKIN_12
-
-#define MB_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | MB_DPLL_DIV |\
-					MB_DPLL_MULT | MX_APLLS_CLIKIN_13
-
-#define MB_CM_CLKSEL1_PLL_19_VAL	MX_48M_SRC | MX_54M_SRC | MB_DPLL_DIV |\
-					MB_DPLL_MULT | MX_APLLS_CLIKIN_19
-
-/*
- * 2430 - chassis (sedna)
- * 165 (ratio1) same as above #2
- * 150 (ratio1)
- * 133 (ratio2) same as above #4
- * 110 (ratio2) same as above #3
- * 104 (ratio2)
- * boot (boot)
- */
-
-/*
- * 2420 Equivalent - mode registers
- * PRCM II , target DPLL = 2*300MHz = 600MHz
- */
-#define MII_DPLL_MULT_12		(50 << 12)
-#define MII_DPLL_DIV_12			(1 << 8)
-#define MII_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
-					MII_DPLL_DIV_12 | MII_DPLL_MULT_12 | \
-					MX_APLLS_CLIKIN_12
-#define MII_DPLL_MULT_13		(300 << 12)
-#define MII_DPLL_DIV_13			(12 << 8)
-#define MII_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
-					MII_DPLL_DIV_13 | MII_DPLL_MULT_13 | \
-					MX_APLLS_CLIKIN_13
-
-/* PRCM III target DPLL = 2*266 = 532MHz*/
-#define MIII_DPLL_MULT_12		(133 << 12)
-#define MIII_DPLL_DIV_12		(5 << 8)
-#define MIII_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
-					MIII_DPLL_DIV_12 | MIII_DPLL_MULT_12 | \
-					MX_APLLS_CLIKIN_12
-#define MIII_DPLL_MULT_13		(266 << 12)
-#define MIII_DPLL_DIV_13		(12 << 8)
-#define MIII_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
-					MIII_DPLL_DIV_13 | MIII_DPLL_MULT_13 | \
-					MX_APLLS_CLIKIN_13
-
-/* PRCM VII (boot bypass) */
-#define MVII_CM_CLKSEL1_PLL_12_VAL	MB_CM_CLKSEL1_PLL_12_VAL
-#define MVII_CM_CLKSEL1_PLL_13_VAL	MB_CM_CLKSEL1_PLL_13_VAL
-
-/* High and low operation value */
-#define MX_CLKSEL2_PLL_2x_VAL		(2 << 0)
-#define MX_CLKSEL2_PLL_1x_VAL		(1 << 0)
-
-/*
- * These represent optimal values for common parts, it won't work for all.
- * As long as you scale down, most parameters are still work, they just
- * become sub-optimal. The RFR value goes in the opposite direction. If you
- * don't adjust it down as your clock period increases the refresh interval
- * will not be met. Setting all parameters for complete worst case may work,
- * but may cut memory performance by 2x. Due to errata the DLLs need to be
- * unlocked and their value needs run time calibration.	A dynamic call is
- * need for that as no single right value exists acorss production samples.
- *
- * Only the FULL speed values are given. Current code is such that rate
- * changes must be made at DPLLoutx2. The actual value adjustment for low
- * frequency operation will be handled by omap_set_performance()
- *
- * By having the boot loader boot up in the fastest L4 speed available likely
- * will result in something which you can switch between.
- */
-#define V24XX_SDRC_RFR_CTRL_133MHz	(0x0003de00 | 1)
-#define V24XX_SDRC_RFR_CTRL_100MHz	(0x0002da01 | 1)
-#define V24XX_SDRC_RFR_CTRL_110MHz	(0x0002da01 | 1) /* Need to calc */
-#define V24XX_SDRC_RFR_CTRL_BYPASS	(0x00005000 | 1) /* Need to calc */
-
-/* MPU speed defines */
-#define S12M	12000000
-#define S13M	13000000
-#define S19M	19200000
-#define S26M	26000000
-#define S100M	100000000
-#define S133M	133000000
-#define S150M	150000000
-#define S165M	165000000
-#define S200M	200000000
-#define S266M	266000000
-#define S300M	300000000
-#define S330M	330000000
-#define S400M	400000000
-#define S532M	532000000
-#define S600M	600000000
-#define S660M	660000000
-
-/*-------------------------------------------------------------------------
- * Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
- * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,
- * CM_CLKSEL_DSP, CM_CLKSEL_GFX, CM_CLKSEL1_CORE, CM_CLKSEL1_PLL,
- * CM_CLKSEL2_PLL, CM_CLKSEL_MDM
- *
- * Filling in table based on H4 boards and 2430-SDPs variants available.
- * There are quite a few more rates combinations which could be defined.
- *
- * When multiple values are defined the start up will try and choose the
- * fastest one. If a 'fast' value is defined, then automatically, the /2
- * one should be included as it can be used.	Generally having more that
- * one fast set does not make sense, as static timings need to be changed
- * to change the set.	 The exception is the bypass setting which is
- * availble for low power bypass.
- *
- * Note: This table needs to be sorted, fastest to slowest.
- *-------------------------------------------------------------------------*/
-static struct prcm_config rate_table[] = {
-	/* PRCM II - FAST */
-	{S12M, S600M, S300M, RII_CM_CLKSEL_MPU_VAL,		/* 300MHz ARM */
-		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
-		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_100MHz,
-		RATE_IN_242X},
-
-	{S13M, S600M, S300M, RII_CM_CLKSEL_MPU_VAL,		/* 300MHz ARM */
-		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
-		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_100MHz,
-		RATE_IN_242X},
-
-	/* PRCM III - FAST */
-	{S12M, S532M, S266M, RIII_CM_CLKSEL_MPU_VAL,		/* 266MHz ARM */
-		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
-		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_133MHz,
-		RATE_IN_242X},
-
-	{S13M, S532M, S266M, RIII_CM_CLKSEL_MPU_VAL,		/* 266MHz ARM */
-		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
-		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_133MHz,
-		RATE_IN_242X},
-
-	/* PRCM II - SLOW */
-	{S12M, S300M, S150M, RII_CM_CLKSEL_MPU_VAL,		/* 150MHz ARM */
-		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
-		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_100MHz,
-		RATE_IN_242X},
-
-	{S13M, S300M, S150M, RII_CM_CLKSEL_MPU_VAL,		/* 150MHz ARM */
-		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
-		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_100MHz,
-		RATE_IN_242X},
-
-	/* PRCM III - SLOW */
-	{S12M, S266M, S133M, RIII_CM_CLKSEL_MPU_VAL,		/* 133MHz ARM */
-		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
-		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_133MHz,
-		RATE_IN_242X},
-
-	{S13M, S266M, S133M, RIII_CM_CLKSEL_MPU_VAL,		/* 133MHz ARM */
-		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
-		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_133MHz,
-		RATE_IN_242X},
-
-	/* PRCM-VII (boot-bypass) */
-	{S12M, S12M, S12M, RVII_CM_CLKSEL_MPU_VAL,		/* 12MHz ARM*/
-		RVII_CM_CLKSEL_DSP_VAL, RVII_CM_CLKSEL_GFX_VAL,
-		RVII_CM_CLKSEL1_CORE_VAL, MVII_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_BYPASS,
-		RATE_IN_242X},
-
-	/* PRCM-VII (boot-bypass) */
-	{S13M, S13M, S13M, RVII_CM_CLKSEL_MPU_VAL,		/* 13MHz ARM */
-		RVII_CM_CLKSEL_DSP_VAL, RVII_CM_CLKSEL_GFX_VAL,
-		RVII_CM_CLKSEL1_CORE_VAL, MVII_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_BYPASS,
-		RATE_IN_242X},
-
-	/* PRCM #3 - ratio2 (ES2) - FAST */
-	{S13M, S660M, S330M, R2_CM_CLKSEL_MPU_VAL,		/* 330MHz ARM */
-		R2_CM_CLKSEL_DSP_VAL, R2_CM_CLKSEL_GFX_VAL,
-		R2_CM_CLKSEL1_CORE_VAL, M3_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, R2_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_110MHz,
-		RATE_IN_243X},
-
-	/* PRCM #5a - ratio1 - FAST */
-	{S13M, S532M, S266M, R1_CM_CLKSEL_MPU_VAL,		/* 266MHz ARM */
-		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
-		R1_CM_CLKSEL1_CORE_VAL, M5A_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, R1_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_133MHz,
-		RATE_IN_243X},
-
-	/* PRCM #5b - ratio1 - FAST */
-	{S13M, S400M, S200M, R1_CM_CLKSEL_MPU_VAL,		/* 200MHz ARM */
-		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
-		R1_CM_CLKSEL1_CORE_VAL, M5B_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, R1_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_100MHz,
-		RATE_IN_243X},
-
-	/* PRCM #3 - ratio2 (ES2) - SLOW */
-	{S13M, S330M, S165M, R2_CM_CLKSEL_MPU_VAL,		/* 165MHz ARM */
-		R2_CM_CLKSEL_DSP_VAL, R2_CM_CLKSEL_GFX_VAL,
-		R2_CM_CLKSEL1_CORE_VAL, M3_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_1x_VAL, R2_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_110MHz,
-		RATE_IN_243X},
-
-	/* PRCM #5a - ratio1 - SLOW */
-	{S13M, S266M, S133M, R1_CM_CLKSEL_MPU_VAL,		/* 133MHz ARM */
-		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
-		R1_CM_CLKSEL1_CORE_VAL, M5A_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_1x_VAL, R1_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_133MHz,
-		RATE_IN_243X},
-
-	/* PRCM #5b - ratio1 - SLOW*/
-	{S13M, S200M, S100M, R1_CM_CLKSEL_MPU_VAL,		/* 100MHz ARM */
-		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
-		R1_CM_CLKSEL1_CORE_VAL, M5B_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_1x_VAL, R1_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_100MHz,
-		RATE_IN_243X},
-
-	/* PRCM-boot/bypass */
-	{S13M, S13M, S13M, RB_CM_CLKSEL_MPU_VAL,		/* 13Mhz */
-		RB_CM_CLKSEL_DSP_VAL, RB_CM_CLKSEL_GFX_VAL,
-		RB_CM_CLKSEL1_CORE_VAL, MB_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, RB_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_BYPASS,
-		RATE_IN_243X},
-
-	/* PRCM-boot/bypass */
-	{S12M, S12M, S12M, RB_CM_CLKSEL_MPU_VAL,		/* 12Mhz */
-		RB_CM_CLKSEL_DSP_VAL, RB_CM_CLKSEL_GFX_VAL,
-		RB_CM_CLKSEL1_CORE_VAL, MB_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, RB_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_BYPASS,
-		RATE_IN_243X},
-
-	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
-};
-
-/*-------------------------------------------------------------------------
- * 24xx clock tree.
- *
- * NOTE:In many cases here we are assigning a 'default' parent.	In many
- *	cases the parent is selectable.	The get/set parent calls will also
- *	switch sources.
- *
- *	Many some clocks say always_enabled, but they can be auto idled for
- *	power savings. They will always be available upon clock request.
- *
- *	Several sources are given initial rates which may be wrong, this will
- *	be fixed up in the init func.
- *
- *	Things are broadly separated below by clock domains. It is
- *	noteworthy that most periferals have dependencies on multiple clock
- *	domains. Many get their interface clocks from the L4 domain, but get
- *	functional clocks from fixed sources or other core domain derived
- *	clocks.
- *-------------------------------------------------------------------------*/
-
-/* Base external input clocks */
-static struct clk func_32k_ck = {
-	.name		= "func_32k_ck",
-	.rate		= 32000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | ALWAYS_ENABLED,
-};
-
-/* Typical 12/13MHz in standalone mode, will be 26Mhz in chassis mode */
-static struct clk osc_ck = {		/* (*12, *13, 19.2, *26, 38.4)MHz */
-	.name		= "osc_ck",
-	.rate		= 26000000,		/* fixed up in clock init */
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
-};
-
-/* With out modem likely 12MHz, with modem likely 13MHz */
-static struct clk sys_ck = {		/* (*12, *13, 19.2, 26, 38.4)MHz */
-	.name		= "sys_ck",		/* ~ ref_clk also */
-	.parent		= &osc_ck,
-	.rate		= 13000000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | ALWAYS_ENABLED | RATE_PROPAGATES,
-	.rate_offset	= 6, /* sysclkdiv 1 or 2, already handled or no boot */
-	.recalc		= &omap2_sys_clk_recalc,
-};
-
-static struct clk alt_ck = {		/* Typical 54M or 48M, may not exist */
-	.name		= "alt_ck",
-	.rate		= 54000000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | ALWAYS_ENABLED | RATE_PROPAGATES,
-	.recalc		= &omap2_propagate_rate,
-};
-
-/*
- * Analog domain root source clocks
- */
-
-/* dpll_ck, is broken out in to special cases through clksel */
-static struct clk dpll_ck = {
-	.name		= "dpll_ck",
-	.parent		= &sys_ck,		/* Can be func_32k also */
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES | RATE_CKCTL | CM_PLL_SEL1,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk apll96_ck = {
-	.name		= "apll96_ck",
-	.parent		= &sys_ck,
-	.rate		= 96000000,
-	.flags		= CLOCK_IN_OMAP242X |CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
-	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
-	.enable_bit	= 0x2,
-	.recalc		= &omap2_propagate_rate,
-};
-
-static struct clk apll54_ck = {
-	.name		= "apll54_ck",
-	.parent		= &sys_ck,
-	.rate		= 54000000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
-	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
-	.enable_bit	= 0x6,
-	.recalc		= &omap2_propagate_rate,
-};
-
-/*
- * PRCM digital base sources
- */
-static struct clk func_54m_ck = {
-	.name		= "func_54m_ck",
-	.parent		= &apll54_ck,	/* can also be alt_clk */
-	.rate		= 54000000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES,
-	.src_offset	= 5,
-	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
-	.enable_bit	= 0xff,
-	.recalc		= &omap2_propagate_rate,
-};
-
-static struct clk core_ck = {
-	.name		= "core_ck",
-	.parent		= &dpll_ck,		/* can also be 32k */
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				ALWAYS_ENABLED | RATE_PROPAGATES,
-	.recalc		= &omap2_propagate_rate,
-};
-
-static struct clk sleep_ck = {		/* sys_clk or 32k */
-	.name		= "sleep_ck",
-	.parent		= &func_32k_ck,
-	.rate		= 32000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.recalc		= &omap2_propagate_rate,
-};
-
-static struct clk func_96m_ck = {
-	.name		= "func_96m_ck",
-	.parent		= &apll96_ck,
-	.rate		= 96000000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
-	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
-	.enable_bit	= 0xff,
-	.recalc		= &omap2_propagate_rate,
-};
-
-static struct clk func_48m_ck = {
-	.name		= "func_48m_ck",
-	.parent		= &apll96_ck,	 /* 96M or Alt */
-	.rate		= 48000000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES,
-	.src_offset	= 3,
-	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
-	.enable_bit	= 0xff,
-	.recalc		= &omap2_propagate_rate,
-};
-
-static struct clk func_12m_ck = {
-	.name		= "func_12m_ck",
-	.parent		= &func_48m_ck,
-	.rate		= 12000000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
-	.recalc		= &omap2_propagate_rate,
-	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
-	.enable_bit	= 0xff,
-};
-
-/* Secure timer, only available in secure mode */
-static struct clk wdt1_osc_ck = {
-	.name		= "ck_wdt1_osc",
-	.parent		= &osc_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk sys_clkout = {
-	.name		= "sys_clkout",
-	.parent		= &func_54m_ck,
-	.rate		= 54000000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_SYSCLKOUT_SEL1 | RATE_CKCTL,
-	.src_offset	= 0,
-	.enable_reg	= (void __iomem *)&PRCM_CLKOUT_CTRL,
-	.enable_bit	= 7,
-	.rate_offset	= 3,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/* In 2430, new in 2420 ES2 */
-static struct clk sys_clkout2 = {
-	.name		= "sys_clkout2",
-	.parent		= &func_54m_ck,
-	.rate		= 54000000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_SYSCLKOUT_SEL1 | RATE_CKCTL,
-	.src_offset	= 8,
-	.enable_reg	= (void __iomem *)&PRCM_CLKOUT_CTRL,
-	.enable_bit	= 15,
-	.rate_offset	= 11,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk emul_ck = {
-	.name		= "emul_ck",
-	.parent		= &func_54m_ck,
-	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&PRCM_CLKEMUL_CTRL,
-	.enable_bit	= 0,
-	.recalc		= &omap2_propagate_rate,
-
-};
-
-/*
- * MPU clock domain
- *	Clocks:
- *		MPU_FCLK, MPU_ICLK
- *		INT_M_FCLK, INT_M_I_CLK
- *
- * - Individual clocks are hardware managed.
- * - Base divider comes from: CM_CLKSEL_MPU
- *
- */
-static struct clk mpu_ck = {	/* Control cpu */
-	.name		= "mpu_ck",
-	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | RATE_CKCTL |
-				ALWAYS_ENABLED | CM_MPU_SEL1 | DELAYED_APP |
-				CONFIG_PARTICIPANT | RATE_PROPAGATES,
-	.rate_offset	= 0,	/* bits 0-4 */
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/*
- * DSP (2430-IVA2.1) (2420-UMA+IVA1) clock domain
- * Clocks:
- *	2430: IVA2.1_FCLK, IVA2.1_ICLK
- *	2420: UMA_FCLK, UMA_ICLK, IVA_MPU, IVA_COP
- */
-static struct clk iva2_1_fck = {
-	.name		= "iva2_1_fck",
-	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP243X | RATE_CKCTL | CM_DSP_SEL1 |
-				DELAYED_APP | RATE_PROPAGATES |
-				CONFIG_PARTICIPANT,
-	.rate_offset	= 0,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_DSP,
-	.enable_bit	= 0,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk iva2_1_ick = {
-	.name		= "iva2_1_ick",
-	.parent		= &iva2_1_fck,
-	.flags		= CLOCK_IN_OMAP243X | RATE_CKCTL | CM_DSP_SEL1 |
-				DELAYED_APP | CONFIG_PARTICIPANT,
-	.rate_offset	= 5,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/*
- * Won't be too specific here. The core clock comes into this block
- * it is divided then tee'ed. One branch goes directly to xyz enable
- * controls. The other branch gets further divided by 2 then possibly
- * routed into a synchronizer and out of clocks abc.
- */
-static struct clk dsp_fck = {
-	.name		= "dsp_fck",
-	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1 |
-			DELAYED_APP | CONFIG_PARTICIPANT | RATE_PROPAGATES,
-	.rate_offset	= 0,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_DSP,
-	.enable_bit	= 0,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk dsp_ick = {
-	.name		= "dsp_ick",	 /* apparently ipi and isp */
-	.parent		= &dsp_fck,
-	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1 |
-				DELAYED_APP | CONFIG_PARTICIPANT,
-	.rate_offset = 5,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_DSP,
-	.enable_bit	= 1,		/* for ipi */
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk iva1_ifck = {
-	.name		= "iva1_ifck",
-	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | CM_DSP_SEL1 | RATE_CKCTL |
-			CONFIG_PARTICIPANT | RATE_PROPAGATES | DELAYED_APP,
-	.rate_offset= 8,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_DSP,
-	.enable_bit	= 10,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/* IVA1 mpu/int/i/f clocks are /2 of parent */
-static struct clk iva1_mpu_int_ifck = {
-	.name		= "iva1_mpu_int_ifck",
-	.parent		= &iva1_ifck,
-	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_DSP,
-	.enable_bit	= 8,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/*
- * L3 clock domain
- * L3 clocks are used for both interface and functional clocks to
- * multiple entities. Some of these clocks are completely managed
- * by hardware, and some others allow software control. Hardware
- * managed ones general are based on directly CLK_REQ signals and
- * various auto idle settings. The functional spec sets many of these
- * as 'tie-high' for their enables.
- *
- * I-CLOCKS:
- *	L3-Interconnect, SMS, GPMC, SDRC, OCM_RAM, OCM_ROM, SDMA
- *	CAM, HS-USB.
- * F-CLOCK
- *	SSI.
- *
- * GPMC memories and SDRC have timing and clock sensitive registers which
- * may very well need notification when the clock changes. Currently for low
- * operating points, these are taken care of in sleep.S.
- */
-static struct clk core_l3_ck = {	/* Used for ick and fck, interconnect */
-	.name		= "core_l3_ck",
-	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | ALWAYS_ENABLED | CM_CORE_SEL1 |
-				DELAYED_APP | CONFIG_PARTICIPANT |
-				RATE_PROPAGATES,
-	.rate_offset	= 0,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk usb_l4_ick = {	/* FS-USB interface clock */
-	.name		= "usb_l4_ick",
-	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP |
-				CONFIG_PARTICIPANT,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 0,
-	.rate_offset = 25,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/*
- * SSI is in L3 management domain, its direct parent is core not l3,
- * many core power domain entities are grouped into the L3 clock
- * domain.
- * SSI_SSR_FCLK, SSI_SST_FCLK, SSI_L4_CLIK
- *
- * ssr = core/1/2/3/4/5, sst = 1/2 ssr.
- */
-static struct clk ssi_ssr_sst_fck = {
-	.name		= "ssi_fck",
-	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,	/* bit 1 */
-	.enable_bit	= 1,
-	.rate_offset = 20,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-/*
- * GFX clock domain
- *	Clocks:
- * GFX_FCLK, GFX_ICLK
- * GFX_CG1(2d), GFX_CG2(3d)
- *
- * GFX_FCLK runs from L3, and is divided by (1,2,3,4)
- * The 2d and 3d clocks run at a hardware determined
- * divided value of fclk.
- *
- */
-static struct clk gfx_3d_fck = {
-	.name		= "gfx_3d_fck",
-	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_GFX_SEL1,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_GFX,
-	.enable_bit	= 2,
-	.rate_offset= 0,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk gfx_2d_fck = {
-	.name		= "gfx_2d_fck",
-	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_GFX_SEL1,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_GFX,
-	.enable_bit	= 1,
-	.rate_offset= 0,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk gfx_ick = {
-	.name		= "gfx_ick",		/* From l3 */
-	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_GFX,	/* bit 0 */
-	.enable_bit	= 0,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-/*
- * Modem clock domain (2430)
- *	CLOCKS:
- *		MDM_OSC_CLK
- *		MDM_ICLK
- */
-static struct clk mdm_ick = {		/* used both as a ick and fck */
-	.name		= "mdm_ick",
-	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP243X | RATE_CKCTL | CM_MODEM_SEL1 |
-				DELAYED_APP | CONFIG_PARTICIPANT,
-	.rate_offset	= 0,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_MDM,
-	.enable_bit	= 0,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk mdm_osc_ck = {
-	.name		= "mdm_osc_ck",
-	.rate		= 26000000,
-	.parent		= &osc_ck,
-	.flags		= CLOCK_IN_OMAP243X | RATE_FIXED,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_MDM,
-	.enable_bit	= 1,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-/*
- * L4 clock management domain
- *
- * This domain contains lots of interface clocks from the L4 interface, some
- * functional clocks.	Fixed APLL functional source clocks are managed in
- * this domain.
- */
-static struct clk l4_ck = {		/* used both as an ick and fck */
-	.name		= "l4_ck",
-	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | ALWAYS_ENABLED | CM_CORE_SEL1 |
-				DELAYED_APP | RATE_PROPAGATES,
-	.rate_offset	= 5,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk ssi_l4_ick = {
-	.name		= "ssi_l4_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | RATE_CKCTL,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,	/* bit 1 */
-	.enable_bit	= 1,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-/*
- * DSS clock domain
- * CLOCKs:
- * DSS_L4_ICLK, DSS_L3_ICLK,
- * DSS_CLK1, DSS_CLK2, DSS_54MHz_CLK
- *
- * DSS is both initiator and target.
- */
-static struct clk dss_ick = {		/* Enables both L3,L4 ICLK's */
-	.name		= "dss_ick",
-	.parent		= &l4_ck,	/* really both l3 and l4 */
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | RATE_CKCTL,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 0,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk dss1_fck = {
-	.name		= "dss1_fck",
-	.parent		= &core_ck,		/* Core or sys */
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 0,
-	.rate_offset	= 8,
-	.src_offset	= 8,
-	.recalc		= &omap2_clksel_recalc,
-};
-
-static struct clk dss2_fck = {		/* Alt clk used in power management */
-	.name		= "dss2_fck",
-	.parent		= &sys_ck,		/* fixed at sys_ck or 48MHz */
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_CORE_SEL1 | RATE_FIXED |
-				DELAYED_APP,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 1,
-	.src_offset	= 13,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk dss_54m_fck = {	/* Alt clk used in power management */
-	.name		= "dss_54m_fck",	/* 54m tv clk */
-	.parent		= &func_54m_ck,
-	.rate		= 54000000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 2,
-	.recalc		= &omap2_propagate_rate,
-};
-
-/*
- * CORE power domain ICLK & FCLK defines.
- * Many of the these can have more than one possible parent. Entries
- * here will likely have an L4 interface parent, and may have multiple
- * functional clock parents.
- */
-static struct clk gpt1_ick = {
-	.name		= "gpt1_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,	/* Bit0 */
-	.enable_bit	= 0,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpt1_fck = {
-	.name		= "gpt1_fck",
-	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_WKUP_SEL1,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_WKUP,	/* Bit0 */
-	.enable_bit	= 0,
-	.src_offset	= 0,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpt2_ick = {
-	.name		= "gpt2_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	/* Bit4 */
-	.enable_bit	= 4,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpt2_fck = {
-	.name		= "gpt2_fck",
-	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 4,
-	.src_offset	= 2,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpt3_ick = {
-	.name		= "gpt3_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	/* Bit5 */
-	.enable_bit	= 5,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpt3_fck = {
-	.name		= "gpt3_fck",
-	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 5,
-	.src_offset	= 4,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpt4_ick = {
-	.name		= "gpt4_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	/* Bit6 */
-	.enable_bit	= 6,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpt4_fck = {
-	.name		= "gpt4_fck",
-	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 6,
-	.src_offset	= 6,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpt5_ick = {
-	.name		= "gpt5_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* Bit7 */
-	.enable_bit	= 7,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpt5_fck = {
-	.name		= "gpt5_fck",
-	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 7,
-	.src_offset	= 8,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpt6_ick = {
-	.name		= "gpt6_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_bit	= 8,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit8 */
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpt6_fck = {
-	.name		= "gpt6_fck",
-	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 8,
-	.src_offset	= 10,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpt7_ick = {
-	.name		= "gpt7_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit9 */
-	.enable_bit	= 9,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpt7_fck = {
-	.name		= "gpt7_fck",
-	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 9,
-	.src_offset	= 12,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpt8_ick = {
-	.name		= "gpt8_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit10 */
-	.enable_bit	= 10,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpt8_fck = {
-	.name		= "gpt8_fck",
-	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 10,
-	.src_offset	= 14,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpt9_ick = {
-	.name		= "gpt9_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 11,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpt9_fck = {
-	.name		= "gpt9_fck",
-	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-					CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 11,
-	.src_offset	= 16,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpt10_ick = {
-	.name		= "gpt10_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 12,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpt10_fck = {
-	.name		= "gpt10_fck",
-	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-					CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 12,
-	.src_offset	= 18,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpt11_ick = {
-	.name		= "gpt11_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 13,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpt11_fck = {
-	.name		= "gpt11_fck",
-	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-					CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 13,
-	.src_offset	= 20,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpt12_ick = {
-	.name		= "gpt12_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit14 */
-	.enable_bit	= 14,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpt12_fck = {
-	.name		= "gpt12_fck",
-	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-					CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 14,
-	.src_offset	= 22,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mcbsp1_ick = {
-	.name		= "mcbsp1_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_bit	= 15,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit16 */
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mcbsp1_fck = {
-	.name		= "mcbsp1_fck",
-	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_bit	= 15,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mcbsp2_ick = {
-	.name		= "mcbsp2_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_bit	= 16,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mcbsp2_fck = {
-	.name		= "mcbsp2_fck",
-	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_bit	= 16,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mcbsp3_ick = {
-	.name		= "mcbsp3_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 3,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mcbsp3_fck = {
-	.name		= "mcbsp3_fck",
-	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 3,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mcbsp4_ick = {
-	.name		= "mcbsp4_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 4,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mcbsp4_fck = {
-	.name		= "mcbsp4_fck",
-	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 4,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mcbsp5_ick = {
-	.name		= "mcbsp5_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 5,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mcbsp5_fck = {
-	.name		= "mcbsp5_fck",
-	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 5,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mcspi1_ick = {
-	.name		= "mcspi_ick",
-	.id		= 1,
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 17,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mcspi1_fck = {
-	.name		= "mcspi_fck",
-	.id		= 1,
-	.parent		= &func_48m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 17,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mcspi2_ick = {
-	.name		= "mcspi_ick",
-	.id		= 2,
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 18,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mcspi2_fck = {
-	.name		= "mcspi_fck",
-	.id		= 2,
-	.parent		= &func_48m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 18,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mcspi3_ick = {
-	.name		= "mcspi_ick",
-	.id		= 3,
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 9,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mcspi3_fck = {
-	.name		= "mcspi_fck",
-	.id		= 3,
-	.parent		= &func_48m_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 9,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk uart1_ick = {
-	.name		= "uart1_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 21,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk uart1_fck = {
-	.name		= "uart1_fck",
-	.parent		= &func_48m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 21,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk uart2_ick = {
-	.name		= "uart2_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 22,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk uart2_fck = {
-	.name		= "uart2_fck",
-	.parent		= &func_48m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 22,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk uart3_ick = {
-	.name		= "uart3_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 2,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk uart3_fck = {
-	.name		= "uart3_fck",
-	.parent		= &func_48m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 2,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpios_ick = {
-	.name		= "gpios_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
-	.enable_bit	= 2,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpios_fck = {
-	.name		= "gpios_fck",
-	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_WKUP,
-	.enable_bit	= 2,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mpu_wdt_ick = {
-	.name		= "mpu_wdt_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
-	.enable_bit	= 3,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mpu_wdt_fck = {
-	.name		= "mpu_wdt_fck",
-	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_WKUP,
-	.enable_bit	= 3,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk sync_32k_ick = {
-	.name		= "sync_32k_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
-	.enable_bit	= 1,
-	.recalc		= &omap2_followparent_recalc,
-};
-static struct clk wdt1_ick = {
-	.name		= "wdt1_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
-	.enable_bit	= 4,
-	.recalc		= &omap2_followparent_recalc,
-};
-static struct clk omapctrl_ick = {
-	.name		= "omapctrl_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
-	.enable_bit	= 5,
-	.recalc		= &omap2_followparent_recalc,
-};
-static struct clk icr_ick = {
-	.name		= "icr_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
-	.enable_bit	= 6,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk cam_ick = {
-	.name		= "cam_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 31,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk cam_fck = {
-	.name		= "cam_fck",
-	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 31,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mailboxes_ick = {
-	.name		= "mailboxes_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 30,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk wdt4_ick = {
-	.name		= "wdt4_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 29,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk wdt4_fck = {
-	.name		= "wdt4_fck",
-	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 29,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk wdt3_ick = {
-	.name		= "wdt3_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 28,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk wdt3_fck = {
-	.name		= "wdt3_fck",
-	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 28,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mspro_ick = {
-	.name		= "mspro_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 27,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mspro_fck = {
-	.name		= "mspro_fck",
-	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 27,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mmc_ick = {
-	.name		= "mmc_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 26,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mmc_fck = {
-	.name		= "mmc_fck",
-	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 26,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk fac_ick = {
-	.name		= "fac_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 25,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk fac_fck = {
-	.name		= "fac_fck",
-	.parent		= &func_12m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 25,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk eac_ick = {
-	.name		= "eac_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 24,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk eac_fck = {
-	.name		= "eac_fck",
-	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 24,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk hdq_ick = {
-	.name		= "hdq_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 23,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk hdq_fck = {
-	.name		= "hdq_fck",
-	.parent		= &func_12m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 23,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk i2c2_ick = {
-	.name		= "i2c_ick",
-	.id		= 2,
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 20,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk i2c2_fck = {
-	.name		= "i2c_fck",
-	.id		= 2,
-	.parent		= &func_12m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 20,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk i2chs2_fck = {
-	.name		= "i2chs2_fck",
-	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 20,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk i2c1_ick = {
-	.name		= "i2c_ick",
-	.id		= 1,
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 19,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk i2c1_fck = {
-	.name		= "i2c_fck",
-	.id		= 1,
-	.parent		= &func_12m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 19,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk i2chs1_fck = {
-	.name		= "i2chs1_fck",
-	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 19,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk vlynq_ick = {
-	.name		= "vlynq_ick",
-	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 3,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk vlynq_fck = {
-	.name		= "vlynq_fck",
-	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP242X  | RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 3,
-	.src_offset	= 15,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk sdrc_ick = {
-	.name		= "sdrc_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN3_CORE,
-	.enable_bit	= 2,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk des_ick = {
-	.name		= "des_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
-	.enable_bit	= 0,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk sha_ick = {
-	.name		= "sha_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
-	.enable_bit	= 1,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk rng_ick = {
-	.name		= "rng_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
-	.enable_bit	= 2,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk aes_ick = {
-	.name		= "aes_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
-	.enable_bit	= 3,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk pka_ick = {
-	.name		= "pka_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
-	.enable_bit	= 4,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk usb_fck = {
-	.name		= "usb_fck",
-	.parent		= &func_48m_ck,
-	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 0,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk usbhs_ick = {
-	.name		= "usbhs_ick",
-	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 6,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mmchs1_ick = {
-	.name		= "mmchs1_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 7,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mmchs1_fck = {
-	.name		= "mmchs1_fck",
-	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 7,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mmchs2_ick = {
-	.name		= "mmchs2_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 8,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mmchs2_fck = {
-	.name		= "mmchs2_fck",
-	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 8,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpio5_ick = {
-	.name		= "gpio5_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 10,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk gpio5_fck = {
-	.name		= "gpio5_fck",
-	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 10,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mdm_intc_ick = {
-	.name		= "mdm_intc_ick",
-	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 11,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mmchsdb1_fck = {
-	.name		= "mmchsdb1_fck",
-	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 16,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-static struct clk mmchsdb2_fck = {
-	.name		= "mmchsdb2_fck",
-	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 17,
-	.recalc		= &omap2_followparent_recalc,
-};
-
-/*
- * This clock is a composite clock which does entire set changes then
- * forces a rebalance. It keys on the MPU speed, but it really could
- * be any key speed part of a set in the rate table.
- *
- * to really change a set, you need memory table sets which get changed
- * in sram, pre-notifiers & post notifiers, changing the top set, without
- * having low level display recalc's won't work... this is why dpm notifiers
- * work, isr's off, walk a list of clocks already _off_ and not messing with
- * the bus.
- *
- * This clock should have no parent. It embodies the entire upper level
- * active set. A parent will mess up some of the init also.
- */
-static struct clk virt_prcm_set = {
-	.name		= "virt_prcm_set",
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				VIRTUAL_CLOCK | ALWAYS_ENABLED | DELAYED_APP,
-	.parent		= &mpu_ck,	/* Indexed by mpu speed, no parent */
-	.recalc		= &omap2_mpu_recalc,	/* sets are keyed on mpu rate */
-	.set_rate	= &omap2_select_table_rate,
-	.round_rate	= &omap2_round_to_table_rate,
-};
-
-static struct clk *onchip_clks[] = {
-	/* external root sources */
-	&func_32k_ck,
-	&osc_ck,
-	&sys_ck,
-	&alt_ck,
-	/* internal analog sources */
-	&dpll_ck,
-	&apll96_ck,
-	&apll54_ck,
-	/* internal prcm root sources */
-	&func_54m_ck,
-	&core_ck,
-	&sleep_ck,
-	&func_96m_ck,
-	&func_48m_ck,
-	&func_12m_ck,
-	&wdt1_osc_ck,
-	&sys_clkout,
-	&sys_clkout2,
-	&emul_ck,
-	/* mpu domain clocks */
-	&mpu_ck,
-	/* dsp domain clocks */
-	&iva2_1_fck,		/* 2430 */
-	&iva2_1_ick,
-	&dsp_ick,		/* 2420 */
-	&dsp_fck,
-	&iva1_ifck,
-	&iva1_mpu_int_ifck,
-	/* GFX domain clocks */
-	&gfx_3d_fck,
-	&gfx_2d_fck,
-	&gfx_ick,
-	/* Modem domain clocks */
-	&mdm_ick,
-	&mdm_osc_ck,
-	/* DSS domain clocks */
-	&dss_ick,
-	&dss1_fck,
-	&dss2_fck,
-	&dss_54m_fck,
-	/* L3 domain clocks */
-	&core_l3_ck,
-	&ssi_ssr_sst_fck,
-	&usb_l4_ick,
-	/* L4 domain clocks */
-	&l4_ck,			/* used as both core_l4 and wu_l4 */
-	&ssi_l4_ick,
-	/* virtual meta-group clock */
-	&virt_prcm_set,
-	/* general l4 interface ck, multi-parent functional clk */
-	&gpt1_ick,
-	&gpt1_fck,
-	&gpt2_ick,
-	&gpt2_fck,
-	&gpt3_ick,
-	&gpt3_fck,
-	&gpt4_ick,
-	&gpt4_fck,
-	&gpt5_ick,
-	&gpt5_fck,
-	&gpt6_ick,
-	&gpt6_fck,
-	&gpt7_ick,
-	&gpt7_fck,
-	&gpt8_ick,
-	&gpt8_fck,
-	&gpt9_ick,
-	&gpt9_fck,
-	&gpt10_ick,
-	&gpt10_fck,
-	&gpt11_ick,
-	&gpt11_fck,
-	&gpt12_ick,
-	&gpt12_fck,
-	&mcbsp1_ick,
-	&mcbsp1_fck,
-	&mcbsp2_ick,
-	&mcbsp2_fck,
-	&mcbsp3_ick,
-	&mcbsp3_fck,
-	&mcbsp4_ick,
-	&mcbsp4_fck,
-	&mcbsp5_ick,
-	&mcbsp5_fck,
-	&mcspi1_ick,
-	&mcspi1_fck,
-	&mcspi2_ick,
-	&mcspi2_fck,
-	&mcspi3_ick,
-	&mcspi3_fck,
-	&uart1_ick,
-	&uart1_fck,
-	&uart2_ick,
-	&uart2_fck,
-	&uart3_ick,
-	&uart3_fck,
-	&gpios_ick,
-	&gpios_fck,
-	&mpu_wdt_ick,
-	&mpu_wdt_fck,
-	&sync_32k_ick,
-	&wdt1_ick,
-	&omapctrl_ick,
-	&icr_ick,
-	&cam_fck,
-	&cam_ick,
-	&mailboxes_ick,
-	&wdt4_ick,
-	&wdt4_fck,
-	&wdt3_ick,
-	&wdt3_fck,
-	&mspro_ick,
-	&mspro_fck,
-	&mmc_ick,
-	&mmc_fck,
-	&fac_ick,
-	&fac_fck,
-	&eac_ick,
-	&eac_fck,
-	&hdq_ick,
-	&hdq_fck,
-	&i2c1_ick,
-	&i2c1_fck,
-	&i2chs1_fck,
-	&i2c2_ick,
-	&i2c2_fck,
-	&i2chs2_fck,
-	&vlynq_ick,
-	&vlynq_fck,
-	&sdrc_ick,
-	&des_ick,
-	&sha_ick,
-	&rng_ick,
-	&aes_ick,
-	&pka_ick,
-	&usb_fck,
-	&usbhs_ick,
-	&mmchs1_ick,
-	&mmchs1_fck,
-	&mmchs2_ick,
-	&mmchs2_fck,
-	&gpio5_ick,
-	&gpio5_fck,
-	&mdm_intc_ick,
-	&mmchsdb1_fck,
-	&mmchsdb2_fck,
-};
-
-#endif
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
new file mode 100644
index 0000000..5c24781
--- /dev/null
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -0,0 +1,1176 @@
+/*
+ *  linux/arch/arm/mach-omap2/clock.c
+ *
+ *  Copyright (C) 2005 Texas Instruments Inc.
+ *  Richard Woodruff <r-woodruff2@ti.com>
+ *  Created for OMAP2.
+ *
+ *  Cleaned up and modified to use omap shared clock framework by
+ *  Tony Lindgren <tony@atomide.com>
+ *
+ *  Based on omap1 clock.c, Copyright (C) 2004 - 2005 Nokia corporation
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
+#include "prcm-regs.h"
+#include "memory.h"
+#include "clock24xx.h"
+
+#undef DEBUG
+
+//#define DOWN_VARIABLE_DPLL 1			/* Experimental */
+
+static struct prcm_config *curr_prcm_set;
+static u32 curr_perf_level = PRCM_FULL_SPEED;
+static struct clk *vclk;
+static struct clk *sclk;
+
+/*-------------------------------------------------------------------------
+ * Omap2 specific clock functions
+ *-------------------------------------------------------------------------*/
+
+/* Recalculate SYST_CLK */
+static void omap2_sys_clk_recalc(struct clk * clk)
+{
+	u32 div = PRCM_CLKSRC_CTRL;
+	div &= (1 << 7) | (1 << 6);	/* Test if ext clk divided by 1 or 2 */
+	div >>= clk->rate_offset;
+	clk->rate = (clk->parent->rate / div);
+	propagate_rate(clk);
+}
+
+static u32 omap2_get_dpll_rate(struct clk * tclk)
+{
+	long long dpll_clk;
+	int dpll_mult, dpll_div, amult;
+
+	dpll_mult = (CM_CLKSEL1_PLL >> 12) & 0x03ff;	/* 10 bits */
+	dpll_div = (CM_CLKSEL1_PLL >> 8) & 0x0f;	/* 4 bits */
+	dpll_clk = (long long)tclk->parent->rate * dpll_mult;
+	do_div(dpll_clk, dpll_div + 1);
+	amult = CM_CLKSEL2_PLL & 0x3;
+	dpll_clk *= amult;
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
+		clk->rate = clk->parent->rate;
+
+	propagate_rate(clk);
+}
+
+static void omap2_set_osc_ck(int enable)
+{
+	if (enable)
+		PRCM_CLKSRC_CTRL &= ~(0x3 << 3);
+	else
+		PRCM_CLKSRC_CTRL |= 0x3 << 3;
+}
+
+/* Enable an APLL if off */
+static void omap2_clk_fixed_enable(struct clk *clk)
+{
+	u32 cval, i=0;
+
+	if (clk->enable_bit == 0xff)			/* Parent will do it */
+		return;
+
+	cval = CM_CLKEN_PLL;
+
+	if ((cval & (0x3 << clk->enable_bit)) == (0x3 << clk->enable_bit))
+		return;
+
+	cval &= ~(0x3 << clk->enable_bit);
+	cval |= (0x3 << clk->enable_bit);
+	CM_CLKEN_PLL = cval;
+
+	if (clk == &apll96_ck)
+		cval = (1 << 8);
+	else if (clk == &apll54_ck)
+		cval = (1 << 6);
+
+	while (!(CM_IDLEST_CKGEN & cval)) {		/* Wait for lock */
+		++i;
+		udelay(1);
+		if (i == 100000) {
+			printk(KERN_ERR "Clock %s didn't lock\n", clk->name);
+			break;
+		}
+	}
+}
+
+static void omap2_clk_wait_ready(struct clk *clk)
+{
+	unsigned long reg, other_reg, st_reg;
+	u32 bit;
+	int i;
+
+	reg = (unsigned long) clk->enable_reg;
+	if (reg == (unsigned long) &CM_FCLKEN1_CORE ||
+	    reg == (unsigned long) &CM_FCLKEN2_CORE)
+		other_reg = (reg & ~0xf0) | 0x10;
+	else if (reg == (unsigned long) &CM_ICLKEN1_CORE ||
+		 reg == (unsigned long) &CM_ICLKEN2_CORE)
+		other_reg = (reg & ~0xf0) | 0x00;
+	else
+		return;
+
+	/* No check for DSS or cam clocks */
+	if ((reg & 0x0f) == 0) {
+		if (clk->enable_bit <= 1 || clk->enable_bit == 31)
+			return;
+	}
+
+	/* Check if both functional and interface clocks
+	 * are running. */
+	bit = 1 << clk->enable_bit;
+	if (!(__raw_readl(other_reg) & bit))
+		return;
+	st_reg = (other_reg & ~0xf0) | 0x20;
+	i = 0;
+	while (!(__raw_readl(st_reg) & bit)) {
+		i++;
+		if (i == 100000) {
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
+ */
+static int _omap2_clk_enable(struct clk * clk)
+{
+	u32 regval32;
+
+	if (clk->flags & ALWAYS_ENABLED)
+		return 0;
+
+	if (unlikely(clk == &osc_ck)) {
+		omap2_set_osc_ck(1);
+		return 0;
+	}
+
+	if (unlikely(clk->enable_reg == 0)) {
+		printk(KERN_ERR "clock.c: Enable for %s without enable code\n",
+		       clk->name);
+		return 0;
+	}
+
+	if (clk->enable_reg == (void __iomem *)&CM_CLKEN_PLL) {
+		omap2_clk_fixed_enable(clk);
+		return 0;
+	}
+
+	regval32 = __raw_readl(clk->enable_reg);
+	regval32 |= (1 << clk->enable_bit);
+	__raw_writel(regval32, clk->enable_reg);
+	wmb();
+
+	omap2_clk_wait_ready(clk);
+
+	return 0;
+}
+
+/* Stop APLL */
+static void omap2_clk_fixed_disable(struct clk *clk)
+{
+	u32 cval;
+
+	if(clk->enable_bit == 0xff)		/* let parent off do it */
+		return;
+
+	cval = CM_CLKEN_PLL;
+	cval &= ~(0x3 << clk->enable_bit);
+	CM_CLKEN_PLL = cval;
+}
+
+/* Disables clock without considering parent dependencies or use count */
+static void _omap2_clk_disable(struct clk *clk)
+{
+	u32 regval32;
+
+	if (unlikely(clk == &osc_ck)) {
+		omap2_set_osc_ck(0);
+		return;
+	}
+
+	if (clk->enable_reg == 0)
+		return;
+
+	if (clk->enable_reg == (void __iomem *)&CM_CLKEN_PLL) {
+		omap2_clk_fixed_disable(clk);
+		return;
+	}
+
+	regval32 = __raw_readl(clk->enable_reg);
+	regval32 &= ~(1 << clk->enable_bit);
+	__raw_writel(regval32, clk->enable_reg);
+	wmb();
+}
+
+static int omap2_clk_enable(struct clk *clk)
+{
+	int ret = 0;
+
+	if (clk->usecount++ == 0) {
+		if (likely((u32)clk->parent))
+			ret = omap2_clk_enable(clk->parent);
+
+		if (unlikely(ret != 0)) {
+			clk->usecount--;
+			return ret;
+		}
+
+		ret = _omap2_clk_enable(clk);
+
+		if (unlikely(ret != 0) && clk->parent) {
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
+ */
+static u32 omap2_dpll_round_rate(unsigned long target_rate)
+{
+	u32 high, low;
+
+	if ((CM_CLKSEL2_PLL & 0x3) == 1) {	/* DPLL clockout */
+		high = curr_prcm_set->dpll_speed * 2;
+		low = curr_prcm_set->dpll_speed;
+	} else {				/* DPLL clockout x 2 */
+		high = curr_prcm_set->dpll_speed;
+		low = curr_prcm_set->dpll_speed / 2;
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
+ */
+static void omap2_clksel_recalc(struct clk * clk)
+{
+	u32 fixed = 0, div = 0;
+
+	if (clk == &dpll_ck) {
+		clk->rate = omap2_get_dpll_rate(clk);
+		fixed = 1;
+		div = 0;
+	}
+
+	if (clk == &iva1_mpu_int_ifck) {
+		div = 2;
+		fixed = 1;
+	}
+
+	if ((clk == &dss1_fck) && ((CM_CLKSEL1_CORE & (0x1f << 8)) == 0)) {
+		clk->rate = sys_ck.rate;
+		return;
+	}
+
+	if (!fixed) {
+		div = omap2_clksel_get_divisor(clk);
+		if (div == 0)
+			return;
+	}
+
+	if (div != 0) {
+		if (unlikely(clk->rate == clk->parent->rate / div))
+			return;
+		clk->rate = clk->parent->rate / div;
+	}
+
+	if (unlikely(clk->flags & RATE_PROPAGATES))
+		propagate_rate(clk);
+}
+
+/*
+ * Finds best divider value in an array based on the source and target
+ * rates. The divider array must be sorted with smallest divider first.
+ */
+static inline u32 omap2_divider_from_table(u32 size, u32 *div_array,
+					   u32 src_rate, u32 tgt_rate)
+{
+	int i, test_rate;
+
+	if (div_array == NULL)
+		return ~1;
+
+	for (i=0; i < size; i++) {
+		test_rate = src_rate / *div_array;
+		if (test_rate <= tgt_rate)
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
+ * Note that this will not work for clocks which are part of CONFIG_PARTICIPANT,
+ * they are only settable as part of virtual_prcm set.
+ */
+static u32 omap2_clksel_round_rate(struct clk *tclk, u32 target_rate,
+	u32 *new_div)
+{
+	u32 gfx_div[] = {2, 3, 4};
+	u32 sysclkout_div[] = {1, 2, 4, 8, 16};
+	u32 dss1_div[] = {1, 2, 3, 4, 5, 6, 8, 9, 12, 16};
+	u32 vylnq_div[] = {1, 2, 3, 4, 6, 8, 9, 12, 16, 18};
+	u32 best_div = ~0, asize = 0;
+	u32 *div_array = NULL;
+
+	switch (tclk->flags & SRC_RATE_SEL_MASK) {
+	case CM_GFX_SEL1:
+		asize = 3;
+		div_array = gfx_div;
+		break;
+	case CM_PLL_SEL1:
+		return omap2_dpll_round_rate(target_rate);
+	case CM_SYSCLKOUT_SEL1:
+		asize = 5;
+		div_array = sysclkout_div;
+		break;
+	case CM_CORE_SEL1:
+		if(tclk == &dss1_fck){
+			if(tclk->parent == &core_ck){
+				asize = 10;
+				div_array = dss1_div;
+			} else {
+				*new_div = 0; /* fixed clk */
+				return(tclk->parent->rate);
+			}
+		} else if((tclk == &vlynq_fck) && cpu_is_omap2420()){
+			if(tclk->parent == &core_ck){
+				asize = 10;
+				div_array = vylnq_div;
+			} else {
+				*new_div = 0; /* fixed clk */
+				return(tclk->parent->rate);
+			}
+		}
+		break;
+	}
+
+	best_div = omap2_divider_from_table(asize, div_array,
+	 tclk->parent->rate, target_rate);
+	if (best_div == ~0){
+		*new_div = 1;
+		return best_div; /* signal error */
+	}
+
+	*new_div = best_div;
+	return (tclk->parent->rate / best_div);
+}
+
+/* Given a clock and a rate apply a clock specific rounding function */
+static long omap2_clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	u32 new_div = 0;
+	int valid_rate;
+
+	if (clk->flags & RATE_FIXED)
+		return clk->rate;
+
+	if (clk->flags & RATE_CKCTL) {
+		valid_rate = omap2_clksel_round_rate(clk, rate, &new_div);
+		return valid_rate;
+	}
+
+	if (clk->round_rate != 0)
+		return clk->round_rate(clk, rate);
+
+	return clk->rate;
+}
+
+/*
+ * Check the DLL lock state, and return tue if running in unlock mode.
+ * This is needed to compensate for the shifted DLL value in unlock mode.
+ */
+static u32 omap2_dll_force_needed(void)
+{
+	u32 dll_state = SDRC_DLLA_CTRL;		/* dlla and dllb are a set */
+
+	if ((dll_state & (1 << 2)) == (1 << 2))
+		return 1;
+	else
+		return 0;
+}
+
+static u32 omap2_reprogram_sdrc(u32 level, u32 force)
+{
+	u32 slow_dll_ctrl, fast_dll_ctrl, m_type;
+	u32 prev = curr_perf_level, flags;
+
+	if ((curr_perf_level == level) && !force)
+		return prev;
+
+	m_type = omap2_memory_get_type();
+	slow_dll_ctrl = omap2_memory_get_slow_dll_ctrl();
+	fast_dll_ctrl = omap2_memory_get_fast_dll_ctrl();
+
+	if (level == PRCM_HALF_SPEED) {
+		local_irq_save(flags);
+		PRCM_VOLTSETUP = 0xffff;
+		omap2_sram_reprogram_sdrc(PRCM_HALF_SPEED,
+					  slow_dll_ctrl, m_type);
+		curr_perf_level = PRCM_HALF_SPEED;
+		local_irq_restore(flags);
+	}
+	if (level == PRCM_FULL_SPEED) {
+		local_irq_save(flags);
+		PRCM_VOLTSETUP = 0xffff;
+		omap2_sram_reprogram_sdrc(PRCM_FULL_SPEED,
+					  fast_dll_ctrl, m_type);
+		curr_perf_level = PRCM_FULL_SPEED;
+		local_irq_restore(flags);
+	}
+
+	return prev;
+}
+
+static int omap2_reprogram_dpll(struct clk * clk, unsigned long rate)
+{
+	u32 flags, cur_rate, low, mult, div, valid_rate, done_rate;
+	u32 bypass = 0;
+	struct prcm_config tmpset;
+	int ret = -EINVAL;
+
+	local_irq_save(flags);
+	cur_rate = omap2_get_dpll_rate(&dpll_ck);
+	mult = CM_CLKSEL2_PLL & 0x3;
+
+	if ((rate == (cur_rate / 2)) && (mult == 2)) {
+		omap2_reprogram_sdrc(PRCM_HALF_SPEED, 1);
+	} else if ((rate == (cur_rate * 2)) && (mult == 1)) {
+		omap2_reprogram_sdrc(PRCM_FULL_SPEED, 1);
+	} else if (rate != cur_rate) {
+		valid_rate = omap2_dpll_round_rate(rate);
+		if (valid_rate != rate)
+			goto dpll_exit;
+
+		if ((CM_CLKSEL2_PLL & 0x3) == 1)
+			low = curr_prcm_set->dpll_speed;
+		else
+			low = curr_prcm_set->dpll_speed / 2;
+
+		tmpset.cm_clksel1_pll = CM_CLKSEL1_PLL;
+		tmpset.cm_clksel1_pll &= ~(0x3FFF << 8);
+		div = ((curr_prcm_set->xtal_speed / 1000000) - 1);
+		tmpset.cm_clksel2_pll = CM_CLKSEL2_PLL;
+		tmpset.cm_clksel2_pll &= ~0x3;
+		if (rate > low) {
+			tmpset.cm_clksel2_pll |= 0x2;
+			mult = ((rate / 2) / 1000000);
+			done_rate = PRCM_FULL_SPEED;
+		} else {
+			tmpset.cm_clksel2_pll |= 0x1;
+			mult = (rate / 1000000);
+			done_rate = PRCM_HALF_SPEED;
+		}
+		tmpset.cm_clksel1_pll |= ((div << 8) | (mult << 12));
+
+		/* Worst case */
+		tmpset.base_sdrc_rfr = V24XX_SDRC_RFR_CTRL_BYPASS;
+
+		if (rate == curr_prcm_set->xtal_speed)	/* If asking for 1-1 */
+			bypass = 1;
+
+		omap2_reprogram_sdrc(PRCM_FULL_SPEED, 1); /* For init_mem */
+
+		/* Force dll lock mode */
+		omap2_set_prcm(tmpset.cm_clksel1_pll, tmpset.base_sdrc_rfr,
+			       bypass);
+
+		/* Errata: ret dll entry state */
+		omap2_init_memory_params(omap2_dll_force_needed());
+		omap2_reprogram_sdrc(done_rate, 0);
+	}
+	omap2_clksel_recalc(&dpll_ck);
+	ret = 0;
+
+dpll_exit:
+	local_irq_restore(flags);
+	return(ret);
+}
+
+/* Just return the MPU speed */
+static void omap2_mpu_recalc(struct clk * clk)
+{
+	clk->rate = curr_prcm_set->mpu_speed;
+}
+
+/*
+ * Look for a rate equal or less than the target rate given a configuration set.
+ *
+ * What's not entirely clear is "which" field represents the key field.
+ * Some might argue L3-DDR, others ARM, others IVA. This code is simple and
+ * just uses the ARM rates.
+ */
+static long omap2_round_to_table_rate(struct clk * clk, unsigned long rate)
+{
+	struct prcm_config * ptr;
+	long highest_rate;
+
+	if (clk != &virt_prcm_set)
+		return -EINVAL;
+
+	highest_rate = -EINVAL;
+
+	for (ptr = rate_table; ptr->mpu_speed; ptr++) {
+		if (ptr->xtal_speed != sys_ck.rate)
+			continue;
+
+		highest_rate = ptr->mpu_speed;
+
+		/* Can check only after xtal frequency check */
+		if (ptr->mpu_speed <= rate)
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
+	u32 clkout_array[] = {1, 2, 4, 8, 16};
+
+	if ((div_sel & SRC_RATE_SEL_MASK) == CM_SYSCLKOUT_SEL1) {
+		for (i = 0; i < 5; i++) {
+			if (field_val == i)
+				return clkout_array[i];
+		}
+		return ~0;
+	} else
+		return field_val;
+}
+
+/*
+ * Returns the CLKSEL divider register value
+ * REVISIT: This should be cleaned up to work nicely with void __iomem *
+ */
+static u32 omap2_get_clksel(u32 *div_sel, u32 *field_mask,
+			    struct clk *clk)
+{
+	int ret = ~0;
+	u32 reg_val, div_off;
+	u32 div_addr = 0;
+	u32 mask = ~0;
+
+	div_off = clk->rate_offset;
+
+	switch ((*div_sel & SRC_RATE_SEL_MASK)) {
+	case CM_MPU_SEL1:
+		div_addr = (u32)&CM_CLKSEL_MPU;
+		mask = 0x1f;
+		break;
+	case CM_DSP_SEL1:
+		div_addr = (u32)&CM_CLKSEL_DSP;
+		if (cpu_is_omap2420()) {
+			if ((div_off == 0) || (div_off == 8))
+				mask = 0x1f;
+			else if (div_off == 5)
+				mask = 0x3;
+		} else if (cpu_is_omap2430()) {
+			if (div_off == 0)
+				mask = 0x1f;
+			else if (div_off == 5)
+				mask = 0x3;
+		}
+		break;
+	case CM_GFX_SEL1:
+		div_addr = (u32)&CM_CLKSEL_GFX;
+		if (div_off == 0)
+			mask = 0x7;
+		break;
+	case CM_MODEM_SEL1:
+		div_addr = (u32)&CM_CLKSEL_MDM;
+		if (div_off == 0)
+			mask = 0xf;
+		break;
+	case CM_SYSCLKOUT_SEL1:
+		div_addr = (u32)&PRCM_CLKOUT_CTRL;
+		if ((div_off == 3) || (div_off == 11))
+			mask= 0x3;
+		break;
+	case CM_CORE_SEL1:
+		div_addr = (u32)&CM_CLKSEL1_CORE;
+		switch (div_off) {
+		case 0:					/* l3 */
+		case 8:					/* dss1 */
+		case 15:				/* vylnc-2420 */
+		case 20:				/* ssi */
+			mask = 0x1f; break;
+		case 5:					/* l4 */
+			mask = 0x3; break;
+		case 13:				/* dss2 */
+			mask = 0x1; break;
+		case 25:				/* usb */
+			mask = 0x7; break;
+		}
+	}
+
+	*field_mask = mask;
+
+	if (unlikely(mask == ~0))
+		div_addr = 0;
+
+	*div_sel = div_addr;
+
+	if (unlikely(div_addr == 0))
+		return ret;
+
+	/* Isolate field */
+	reg_val = __raw_readl((void __iomem *)div_addr) & (mask << div_off);
+
+	/* Normalize back to divider value */
+	reg_val >>= div_off;
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
+	int ret = 0;
+	u32 div, div_sel, div_off, field_mask, field_val;
+
+	/* isolate control register */
+	div_sel = (SRC_RATE_SEL_MASK & clk->flags);
+
+	div_off = clk->rate_offset;
+	field_val = omap2_get_clksel(&div_sel, &field_mask, clk);
+	if (div_sel == 0)
+		return ret;
+
+	div_sel = (SRC_RATE_SEL_MASK & clk->flags);
+	div = omap2_clksel_to_divisor(div_sel, field_val);
+
+	return div;
+}
+
+/* Set the clock rate for a clock source */
+static int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
+
+{
+	int ret = -EINVAL;
+	void __iomem * reg;
+	u32 div_sel, div_off, field_mask, field_val, reg_val, validrate;
+	u32 new_div = 0;
+
+	if (!(clk->flags & CONFIG_PARTICIPANT) && (clk->flags & RATE_CKCTL)) {
+		if (clk == &dpll_ck)
+			return omap2_reprogram_dpll(clk, rate);
+
+		/* Isolate control register */
+		div_sel = (SRC_RATE_SEL_MASK & clk->flags);
+		div_off = clk->rate_offset;
+
+		validrate = omap2_clksel_round_rate(clk, rate, &new_div);
+		if (validrate != rate)
+			return(ret);
+
+		field_val = omap2_get_clksel(&div_sel, &field_mask, clk);
+		if (div_sel == 0)
+			return ret;
+
+		if (clk->flags & CM_SYSCLKOUT_SEL1) {
+			switch (new_div) {
+			case 16:
+				field_val = 4;
+				break;
+			case 8:
+				field_val = 3;
+				break;
+			case 4:
+				field_val = 2;
+				break;
+			case 2:
+				field_val = 1;
+				break;
+			case 1:
+				field_val = 0;
+				break;
+			}
+		} else
+			field_val = new_div;
+
+		reg = (void __iomem *)div_sel;
+
+		reg_val = __raw_readl(reg);
+		reg_val &= ~(field_mask << div_off);
+		reg_val |= (field_val << div_off);
+		__raw_writel(reg_val, reg);
+		wmb();
+		clk->rate = clk->parent->rate / field_val;
+
+		if (clk->flags & DELAYED_APP) {
+			__raw_writel(0x1, (void __iomem *)&PRCM_CLKCFG_CTRL);
+			wmb();
+		}
+		ret = 0;
+	} else if (clk->set_rate != 0)
+		ret = clk->set_rate(clk, rate);
+
+	if (unlikely(ret == 0 && (clk->flags & RATE_PROPAGATES)))
+		propagate_rate(clk);
+
+	return ret;
+}
+
+/* Converts encoded control register address into a full address */
+static u32 omap2_get_src_field(u32 *type_to_addr, u32 reg_offset,
+			       struct clk *src_clk, u32 *field_mask)
+{
+	u32 val = ~0, src_reg_addr = 0, mask = 0;
+
+	/* Find target control register.*/
+	switch ((*type_to_addr & SRC_RATE_SEL_MASK)) {
+	case CM_CORE_SEL1:
+		src_reg_addr = (u32)&CM_CLKSEL1_CORE;
+		if (reg_offset == 13) {			/* DSS2_fclk */
+			mask = 0x1;
+			if (src_clk == &sys_ck)
+				val = 0;
+			if (src_clk == &func_48m_ck)
+				val = 1;
+		} else if (reg_offset == 8) {		/* DSS1_fclk */
+			mask = 0x1f;
+			if (src_clk == &sys_ck)
+				val = 0;
+			else if (src_clk == &core_ck)	/* divided clock */
+				val = 0x10;		/* rate needs fixing */
+		} else if ((reg_offset == 15) && cpu_is_omap2420()){ /*vlnyq*/
+			mask = 0x1F;
+			if(src_clk == &func_96m_ck)
+				val = 0;
+			else if (src_clk == &core_ck)
+				val = 0x10;
+		}
+		break;
+	case CM_CORE_SEL2:
+		src_reg_addr = (u32)&CM_CLKSEL2_CORE;
+		mask = 0x3;
+		if (src_clk == &func_32k_ck)
+			val = 0x0;
+		if (src_clk == &sys_ck)
+			val = 0x1;
+		if (src_clk == &alt_ck)
+			val = 0x2;
+		break;
+	case CM_WKUP_SEL1:
+		src_reg_addr = (u32)&CM_CLKSEL_WKUP;
+		mask = 0x3;
+		if (src_clk == &func_32k_ck)
+			val = 0x0;
+		if (src_clk == &sys_ck)
+			val = 0x1;
+		if (src_clk == &alt_ck)
+			val = 0x2;
+		break;
+	case CM_PLL_SEL1:
+		src_reg_addr = (u32)&CM_CLKSEL1_PLL;
+		mask = 0x1;
+		if (reg_offset == 0x3) {
+			if (src_clk == &apll96_ck)
+				val = 0;
+			if (src_clk == &alt_ck)
+				val = 1;
+		}
+		else if (reg_offset == 0x5) {
+			if (src_clk == &apll54_ck)
+				val = 0;
+			if (src_clk == &alt_ck)
+				val = 1;
+		}
+		break;
+	case CM_PLL_SEL2:
+		src_reg_addr = (u32)&CM_CLKSEL2_PLL;
+		mask = 0x3;
+		if (src_clk == &func_32k_ck)
+			val = 0x0;
+		if (src_clk == &dpll_ck)
+			val = 0x2;
+		break;
+	case CM_SYSCLKOUT_SEL1:
+		src_reg_addr = (u32)&PRCM_CLKOUT_CTRL;
+		mask = 0x3;
+		if (src_clk == &dpll_ck)
+			val = 0;
+		if (src_clk == &sys_ck)
+			val = 1;
+		if (src_clk == &func_96m_ck)
+			val = 2;
+		if (src_clk == &func_54m_ck)
+			val = 3;
+		break;
+	}
+
+	if (val == ~0)			/* Catch errors in offset */
+		*type_to_addr = 0;
+	else
+		*type_to_addr = src_reg_addr;
+	*field_mask = mask;
+
+	return val;
+}
+
+static int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
+{
+	void __iomem * reg;
+	u32 src_sel, src_off, field_val, field_mask, reg_val, rate;
+	int ret = -EINVAL;
+
+	if (unlikely(clk->flags & CONFIG_PARTICIPANT))
+		return ret;
+
+	if (clk->flags & SRC_SEL_MASK) {	/* On-chip SEL collection */
+		src_sel = (SRC_RATE_SEL_MASK & clk->flags);
+		src_off = clk->src_offset;
+
+		if (src_sel == 0)
+			goto set_parent_error;
+
+		field_val = omap2_get_src_field(&src_sel, src_off, new_parent,
+						&field_mask);
+
+		reg = (void __iomem *)src_sel;
+
+		if (clk->usecount > 0)
+			_omap2_clk_disable(clk);
+
+		/* Set new source value (previous dividers if any in effect) */
+		reg_val = __raw_readl(reg) & ~(field_mask << src_off);
+		reg_val |= (field_val << src_off);
+		__raw_writel(reg_val, reg);
+		wmb();
+
+		if (clk->flags & DELAYED_APP) {
+			__raw_writel(0x1, (void __iomem *)&PRCM_CLKCFG_CTRL);
+			wmb();
+		}
+		if (clk->usecount > 0)
+			_omap2_clk_enable(clk);
+
+		clk->parent = new_parent;
+
+		/* SRC_RATE_SEL_MASK clocks follow their parents rates.*/
+		if ((new_parent == &core_ck) && (clk == &dss1_fck))
+			clk->rate = new_parent->rate / 0x10;
+		else
+			clk->rate = new_parent->rate;
+
+		if (unlikely(clk->flags & RATE_PROPAGATES))
+			propagate_rate(clk);
+
+		return 0;
+	} else {
+		clk->parent = new_parent;
+		rate = new_parent->rate;
+		omap2_clk_set_rate(clk, rate);
+		ret = 0;
+	}
+
+ set_parent_error:
+	return ret;
+}
+
+/* Sets basic clocks based on the specified rate */
+static int omap2_select_table_rate(struct clk * clk, unsigned long rate)
+{
+	u32 flags, cur_rate, done_rate, bypass = 0;
+	u8 cpu_mask = 0;
+	struct prcm_config *prcm;
+	unsigned long found_speed = 0;
+
+	if (clk != &virt_prcm_set)
+		return -EINVAL;
+
+	/* FIXME: Change cpu_is_omap2420() to cpu_is_omap242x() */
+	if (cpu_is_omap2420())
+		cpu_mask = RATE_IN_242X;
+	else if (cpu_is_omap2430())
+		cpu_mask = RATE_IN_243X;
+
+	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
+		if (!(prcm->flags & cpu_mask))
+			continue;
+
+		if (prcm->xtal_speed != sys_ck.rate)
+			continue;
+
+		if (prcm->mpu_speed <= rate) {
+			found_speed = prcm->mpu_speed;
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
+	curr_prcm_set = prcm;
+	cur_rate = omap2_get_dpll_rate(&dpll_ck);
+
+	if (prcm->dpll_speed == cur_rate / 2) {
+		omap2_reprogram_sdrc(PRCM_HALF_SPEED, 1);
+	} else if (prcm->dpll_speed == cur_rate * 2) {
+		omap2_reprogram_sdrc(PRCM_FULL_SPEED, 1);
+	} else if (prcm->dpll_speed != cur_rate) {
+		local_irq_save(flags);
+
+		if (prcm->dpll_speed == prcm->xtal_speed)
+			bypass = 1;
+
+		if ((prcm->cm_clksel2_pll & 0x3) == 2)
+			done_rate = PRCM_FULL_SPEED;
+		else
+			done_rate = PRCM_HALF_SPEED;
+
+		/* MPU divider */
+		CM_CLKSEL_MPU = prcm->cm_clksel_mpu;
+
+		/* dsp + iva1 div(2420), iva2.1(2430) */
+		CM_CLKSEL_DSP = prcm->cm_clksel_dsp;
+
+		CM_CLKSEL_GFX = prcm->cm_clksel_gfx;
+
+		/* Major subsystem dividers */
+		CM_CLKSEL1_CORE = prcm->cm_clksel1_core;
+		if (cpu_is_omap2430())
+			CM_CLKSEL_MDM = prcm->cm_clksel_mdm;
+
+		/* x2 to enter init_mem */
+		omap2_reprogram_sdrc(PRCM_FULL_SPEED, 1);
+
+		omap2_set_prcm(prcm->cm_clksel1_pll, prcm->base_sdrc_rfr,
+			       bypass);
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
+/*-------------------------------------------------------------------------
+ * Omap2 clock reset and init functions
+ *-------------------------------------------------------------------------*/
+
+#ifdef CONFIG_OMAP_RESET_CLOCKS
+static void __init omap2_clk_disable_unused(struct clk *clk)
+{
+	u32 regval32;
+
+	regval32 = __raw_readl(clk->enable_reg);
+	if ((regval32 & (1 << clk->enable_bit)) == 0)
+		return;
+
+	printk(KERN_INFO "Disabling unused clock \"%s\"\n", clk->name);
+	_omap2_clk_disable(clk);
+}
+#else
+#define omap2_clk_disable_unused	NULL
+#endif
+
+static struct clk_functions omap2_clk_functions = {
+	.clk_enable		= omap2_clk_enable,
+	.clk_disable		= omap2_clk_disable,
+	.clk_round_rate		= omap2_clk_round_rate,
+	.clk_set_rate		= omap2_clk_set_rate,
+	.clk_set_parent		= omap2_clk_set_parent,
+	.clk_disable_unused	= omap2_clk_disable_unused,
+};
+
+static void __init omap2_get_crystal_rate(struct clk *osc, struct clk *sys)
+{
+	u32 div, aplls, sclk = 13000000;
+
+	aplls = CM_CLKSEL1_PLL;
+	aplls &= ((1 << 23) | (1 << 24) | (1 << 25));
+	aplls >>= 23;			/* Isolate field, 0,2,3 */
+
+	if (aplls == 0)
+		sclk = 19200000;
+	else if (aplls == 2)
+		sclk = 13000000;
+	else if (aplls == 3)
+		sclk = 12000000;
+
+	div = PRCM_CLKSRC_CTRL;
+	div &= ((1 << 7) | (1 << 6));
+	div >>= sys->rate_offset;
+
+	osc->rate = sclk * div;
+	sys->rate = sclk;
+}
+
+/*
+ * Set clocks for bypass mode for reboot to work.
+ */
+void omap2_clk_prepare_for_reboot(void)
+{
+	u32 rate;
+
+	if (vclk == NULL || sclk == NULL)
+		return;
+
+	rate = clk_get_rate(sclk);
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
+	       "%ld.%01ld/%ld/%ld MHz\n",
+	       (sys_ck.rate / 1000000), (sys_ck.rate / 100000) % 10,
+	       (dpll_ck.rate / 1000000), (mpu_ck.rate / 1000000)) ;
+
+	return 0;
+}
+arch_initcall(omap2_clk_arch_init);
+
+int __init omap2_clk_init(void)
+{
+	struct prcm_config *prcm;
+	struct clk ** clkp;
+	u32 clkrate;
+
+	clk_init(&omap2_clk_functions);
+	omap2_get_crystal_rate(&osc_ck, &sys_ck);
+
+	for (clkp = onchip_clks; clkp < onchip_clks + ARRAY_SIZE(onchip_clks);
+	     clkp++) {
+
+		if ((*clkp)->flags & CLOCK_IN_OMAP242X && cpu_is_omap2420()) {
+			clk_register(*clkp);
+			continue;
+		}
+
+		if ((*clkp)->flags & CLOCK_IN_OMAP243X && cpu_is_omap2430()) {
+			clk_register(*clkp);
+			continue;
+		}
+	}
+
+	/* Check the MPU rate set by bootloader */
+	clkrate = omap2_get_dpll_rate(&dpll_ck);
+	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
+		if (prcm->xtal_speed != sys_ck.rate)
+			continue;
+		if (prcm->dpll_speed <= clkrate)
+			 break;
+	}
+	curr_prcm_set = prcm;
+
+	propagate_rate(&osc_ck);		/* update main root fast */
+	propagate_rate(&func_32k_ck);		/* update main root slow */
+
+	printk(KERN_INFO "Clocking rate (Crystal/DPLL/MPU): "
+	       "%ld.%01ld/%ld/%ld MHz\n",
+	       (sys_ck.rate / 1000000), (sys_ck.rate / 100000) % 10,
+	       (dpll_ck.rate / 1000000), (mpu_ck.rate / 1000000)) ;
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
+	vclk = clk_get(NULL, "virt_prcm_set");
+	sclk = clk_get(NULL, "sys_ck");
+
+	return 0;
+}
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
new file mode 100644
index 0000000..4f79186
--- /dev/null
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -0,0 +1,2111 @@
+/*
+ *  linux/arch/arm/mach-omap24xx/clock.h
+ *
+ *  Copyright (C) 2005 Texas Instruments Inc.
+ *  Richard Woodruff <r-woodruff2@ti.com>
+ *  Created for OMAP2.
+ *
+ *  Copyright (C) 2004 Nokia corporation
+ *  Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ *  Based on clocks.h by Tony Lindgren, Gordon McNutt and RidgeRun, Inc
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK_H
+#define __ARCH_ARM_MACH_OMAP2_CLOCK_H
+
+static void omap2_sys_clk_recalc(struct clk * clk);
+static void omap2_clksel_recalc(struct clk * clk);
+static void omap2_followparent_recalc(struct clk * clk);
+static void omap2_propagate_rate(struct clk * clk);
+static void omap2_mpu_recalc(struct clk * clk);
+static int omap2_select_table_rate(struct clk * clk, unsigned long rate);
+static long omap2_round_to_table_rate(struct clk * clk, unsigned long rate);
+static void omap2_clk_disable(struct clk *clk);
+static void omap2_sys_clk_recalc(struct clk * clk);
+static u32 omap2_clksel_to_divisor(u32 div_sel, u32 field_val);
+static u32 omap2_clksel_get_divisor(struct clk *clk);
+
+
+#define RATE_IN_242X	(1 << 0)
+#define RATE_IN_243X	(1 << 1)
+
+/* Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
+ * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,CM_CLKSEL_DSP
+ * CM_CLKSEL_GFX, CM_CLKSEL1_CORE, CM_CLKSEL1_PLL CM_CLKSEL2_PLL, CM_CLKSEL_MDM
+ */
+struct prcm_config {
+	unsigned long xtal_speed;	/* crystal rate */
+	unsigned long dpll_speed;	/* dpll: out*xtal*M/(N-1)table_recalc */
+	unsigned long mpu_speed;	/* speed of MPU */
+	unsigned long cm_clksel_mpu;	/* mpu divider */
+	unsigned long cm_clksel_dsp;	/* dsp+iva1 div(2420), iva2.1(2430) */
+	unsigned long cm_clksel_gfx;	/* gfx dividers */
+	unsigned long cm_clksel1_core;	/* major subsystem dividers */
+	unsigned long cm_clksel1_pll;	/* m,n */
+	unsigned long cm_clksel2_pll;	/* dpllx1 or x2 out */
+	unsigned long cm_clksel_mdm;	/* modem dividers 2430 only */
+	unsigned long base_sdrc_rfr;	/* base refresh timing for a set */
+	unsigned char flags;
+};
+
+/* Mask for clksel which support parent settign in set_rate */
+#define SRC_SEL_MASK (CM_CORE_SEL1 | CM_CORE_SEL2 | CM_WKUP_SEL1 | \
+			CM_PLL_SEL1 | CM_PLL_SEL2 | CM_SYSCLKOUT_SEL1)
+
+/* Mask for clksel regs which support rate operations */
+#define SRC_RATE_SEL_MASK (CM_MPU_SEL1 | CM_DSP_SEL1 | CM_GFX_SEL1 | \
+			CM_MODEM_SEL1 | CM_CORE_SEL1 | CM_CORE_SEL2 | \
+			CM_WKUP_SEL1 | CM_PLL_SEL1 | CM_PLL_SEL2 | \
+			CM_SYSCLKOUT_SEL1)
+
+/*
+ * The OMAP2 processor can be run at several discrete 'PRCM configurations'.
+ * These configurations are characterized by voltage and speed for clocks.
+ * The device is only validated for certain combinations. One way to express
+ * these combinations is via the 'ratio's' which the clocks operate with
+ * respect to each other. These ratio sets are for a given voltage/DPLL
+ * setting. All configurations can be described by a DPLL setting and a ratio
+ * There are 3 ratio sets for the 2430 and X ratio sets for 2420.
+ *
+ * 2430 differs from 2420 in that there are no more phase synchronizers used.
+ * They both have a slightly different clock domain setup. 2420(iva1,dsp) vs
+ * 2430 (iva2.1, NOdsp, mdm)
+ */
+
+/* Core fields for cm_clksel, not ratio governed */
+#define RX_CLKSEL_DSS1			(0x10 << 8)
+#define RX_CLKSEL_DSS2			(0x0 << 13)
+#define RX_CLKSEL_SSI			(0x5 << 20)
+
+/*-------------------------------------------------------------------------
+ * Voltage/DPLL ratios
+ *-------------------------------------------------------------------------*/
+
+/* 2430 Ratio's, 2430-Ratio Config 1 */
+#define R1_CLKSEL_L3			(4 << 0)
+#define R1_CLKSEL_L4			(2 << 5)
+#define R1_CLKSEL_USB			(4 << 25)
+#define R1_CM_CLKSEL1_CORE_VAL		R1_CLKSEL_USB | RX_CLKSEL_SSI | \
+					RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \
+					R1_CLKSEL_L4 | R1_CLKSEL_L3
+#define R1_CLKSEL_MPU			(2 << 0)
+#define R1_CM_CLKSEL_MPU_VAL		R1_CLKSEL_MPU
+#define R1_CLKSEL_DSP			(2 << 0)
+#define R1_CLKSEL_DSP_IF		(2 << 5)
+#define R1_CM_CLKSEL_DSP_VAL		R1_CLKSEL_DSP | R1_CLKSEL_DSP_IF
+#define R1_CLKSEL_GFX			(2 << 0)
+#define R1_CM_CLKSEL_GFX_VAL		R1_CLKSEL_GFX
+#define R1_CLKSEL_MDM			(4 << 0)
+#define R1_CM_CLKSEL_MDM_VAL		R1_CLKSEL_MDM
+
+/* 2430-Ratio Config 2 */
+#define R2_CLKSEL_L3			(6 << 0)
+#define R2_CLKSEL_L4			(2 << 5)
+#define R2_CLKSEL_USB			(2 << 25)
+#define R2_CM_CLKSEL1_CORE_VAL		R2_CLKSEL_USB | RX_CLKSEL_SSI | \
+					RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \
+					R2_CLKSEL_L4 | R2_CLKSEL_L3
+#define R2_CLKSEL_MPU			(2 << 0)
+#define R2_CM_CLKSEL_MPU_VAL		R2_CLKSEL_MPU
+#define R2_CLKSEL_DSP			(2 << 0)
+#define R2_CLKSEL_DSP_IF		(3 << 5)
+#define R2_CM_CLKSEL_DSP_VAL		R2_CLKSEL_DSP | R2_CLKSEL_DSP_IF
+#define R2_CLKSEL_GFX			(2 << 0)
+#define R2_CM_CLKSEL_GFX_VAL		R2_CLKSEL_GFX
+#define R2_CLKSEL_MDM			(6 << 0)
+#define R2_CM_CLKSEL_MDM_VAL		R2_CLKSEL_MDM
+
+/* 2430-Ratio Bootm (BYPASS) */
+#define RB_CLKSEL_L3			(1 << 0)
+#define RB_CLKSEL_L4			(1 << 5)
+#define RB_CLKSEL_USB			(1 << 25)
+#define RB_CM_CLKSEL1_CORE_VAL		RB_CLKSEL_USB | RX_CLKSEL_SSI | \
+					RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \
+					RB_CLKSEL_L4 | RB_CLKSEL_L3
+#define RB_CLKSEL_MPU			(1 << 0)
+#define RB_CM_CLKSEL_MPU_VAL		RB_CLKSEL_MPU
+#define RB_CLKSEL_DSP			(1 << 0)
+#define RB_CLKSEL_DSP_IF		(1 << 5)
+#define RB_CM_CLKSEL_DSP_VAL		RB_CLKSEL_DSP | RB_CLKSEL_DSP_IF
+#define RB_CLKSEL_GFX			(1 << 0)
+#define RB_CM_CLKSEL_GFX_VAL		RB_CLKSEL_GFX
+#define RB_CLKSEL_MDM			(1 << 0)
+#define RB_CM_CLKSEL_MDM_VAL		RB_CLKSEL_MDM
+
+/* 2420 Ratio Equivalents */
+#define RXX_CLKSEL_VLYNQ		(0x12 << 15)
+#define RXX_CLKSEL_SSI			(0x8 << 20)
+
+/* 2420-PRCM III 532MHz core */
+#define RIII_CLKSEL_L3			(4 << 0)	/* 133MHz */
+#define RIII_CLKSEL_L4			(2 << 5)	/* 66.5MHz */
+#define RIII_CLKSEL_USB			(4 << 25)	/* 33.25MHz */
+#define RIII_CM_CLKSEL1_CORE_VAL	RIII_CLKSEL_USB | RXX_CLKSEL_SSI | \
+					RXX_CLKSEL_VLYNQ | RX_CLKSEL_DSS2 | \
+					RX_CLKSEL_DSS1 | RIII_CLKSEL_L4 | \
+					RIII_CLKSEL_L3
+#define RIII_CLKSEL_MPU			(2 << 0)	/* 266MHz */
+#define RIII_CM_CLKSEL_MPU_VAL		RIII_CLKSEL_MPU
+#define RIII_CLKSEL_DSP			(3 << 0)	/* c5x - 177.3MHz */
+#define RIII_CLKSEL_DSP_IF		(2 << 5)	/* c5x - 88.67MHz */
+#define RIII_SYNC_DSP			(1 << 7)	/* Enable sync */
+#define RIII_CLKSEL_IVA			(6 << 8)	/* iva1 - 88.67MHz */
+#define RIII_SYNC_IVA			(1 << 13)	/* Enable sync */
+#define RIII_CM_CLKSEL_DSP_VAL		RIII_SYNC_IVA | RIII_CLKSEL_IVA | \
+					RIII_SYNC_DSP | RIII_CLKSEL_DSP_IF | \
+					RIII_CLKSEL_DSP
+#define RIII_CLKSEL_GFX			(2 << 0)	/* 66.5MHz */
+#define RIII_CM_CLKSEL_GFX_VAL		RIII_CLKSEL_GFX
+
+/* 2420-PRCM II 600MHz core */
+#define RII_CLKSEL_L3			(6 << 0)	/* 100MHz */
+#define RII_CLKSEL_L4			(2 << 5)	/* 50MHz */
+#define RII_CLKSEL_USB			(2 << 25)	/* 50MHz */
+#define RII_CM_CLKSEL1_CORE_VAL		RII_CLKSEL_USB | \
+					RXX_CLKSEL_SSI | RXX_CLKSEL_VLYNQ | \
+					RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \
+					RII_CLKSEL_L4 | RII_CLKSEL_L3
+#define RII_CLKSEL_MPU			(2 << 0)	/* 300MHz */
+#define RII_CM_CLKSEL_MPU_VAL		RII_CLKSEL_MPU
+#define RII_CLKSEL_DSP			(3 << 0)	/* c5x - 200MHz */
+#define RII_CLKSEL_DSP_IF		(2 << 5)	/* c5x - 100MHz */
+#define RII_SYNC_DSP			(0 << 7)	/* Bypass sync */
+#define RII_CLKSEL_IVA			(6 << 8)	/* iva1 - 200MHz */
+#define RII_SYNC_IVA			(0 << 13)	/* Bypass sync */
+#define RII_CM_CLKSEL_DSP_VAL		RII_SYNC_IVA | RII_CLKSEL_IVA | \
+					RII_SYNC_DSP | RII_CLKSEL_DSP_IF | \
+					RII_CLKSEL_DSP
+#define RII_CLKSEL_GFX			(2 << 0)	/* 50MHz */
+#define RII_CM_CLKSEL_GFX_VAL		RII_CLKSEL_GFX
+
+/* 2420-PRCM VII (boot) */
+#define RVII_CLKSEL_L3			(1 << 0)
+#define RVII_CLKSEL_L4			(1 << 5)
+#define RVII_CLKSEL_DSS1		(1 << 8)
+#define RVII_CLKSEL_DSS2		(0 << 13)
+#define RVII_CLKSEL_VLYNQ		(1 << 15)
+#define RVII_CLKSEL_SSI			(1 << 20)
+#define RVII_CLKSEL_USB			(1 << 25)
+
+#define RVII_CM_CLKSEL1_CORE_VAL	RVII_CLKSEL_USB | RVII_CLKSEL_SSI | \
+					RVII_CLKSEL_VLYNQ | RVII_CLKSEL_DSS2 | \
+					RVII_CLKSEL_DSS1 | RVII_CLKSEL_L4 | RVII_CLKSEL_L3
+
+#define RVII_CLKSEL_MPU			(1 << 0) /* all divide by 1 */
+#define RVII_CM_CLKSEL_MPU_VAL		RVII_CLKSEL_MPU
+
+#define RVII_CLKSEL_DSP			(1 << 0)
+#define RVII_CLKSEL_DSP_IF		(1 << 5)
+#define RVII_SYNC_DSP			(0 << 7)
+#define RVII_CLKSEL_IVA			(1 << 8)
+#define RVII_SYNC_IVA			(0 << 13)
+#define RVII_CM_CLKSEL_DSP_VAL		RVII_SYNC_IVA | RVII_CLKSEL_IVA | RVII_SYNC_DSP | \
+					RVII_CLKSEL_DSP_IF | RVII_CLKSEL_DSP
+
+#define RVII_CLKSEL_GFX			(1 << 0)
+#define RVII_CM_CLKSEL_GFX_VAL		RVII_CLKSEL_GFX
+
+/*-------------------------------------------------------------------------
+ * 2430 Target modes: Along with each configuration the CPU has several
+ * modes which goes along with them. Modes mainly are the addition of
+ * describe DPLL combinations to go along with a ratio.
+ *-------------------------------------------------------------------------*/
+
+/* Hardware governed */
+#define MX_48M_SRC			(0 << 3)
+#define MX_54M_SRC			(0 << 5)
+#define MX_APLLS_CLIKIN_12		(3 << 23)
+#define MX_APLLS_CLIKIN_13		(2 << 23)
+#define MX_APLLS_CLIKIN_19_2		(0 << 23)
+
+/*
+ * 2430 - standalone, 2*ref*M/(n+1), M/N is for exactness not relock speed
+ * #2	(ratio1) baseport-target
+ * #5a	(ratio1) baseport-target, target DPLL = 266*2 = 532MHz
+ */
+#define M5A_DPLL_MULT_12		(133 << 12)
+#define M5A_DPLL_DIV_12			(5 << 8)
+#define M5A_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
+					M5A_DPLL_DIV_12 | M5A_DPLL_MULT_12 | \
+					MX_APLLS_CLIKIN_12
+#define M5A_DPLL_MULT_13		(266 << 12)
+#define M5A_DPLL_DIV_13			(12 << 8)
+#define M5A_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
+					M5A_DPLL_DIV_13 | M5A_DPLL_MULT_13 | \
+					MX_APLLS_CLIKIN_13
+#define M5A_DPLL_MULT_19		(180 << 12)
+#define M5A_DPLL_DIV_19			(12 << 8)
+#define M5A_CM_CLKSEL1_PLL_19_VAL	MX_48M_SRC | MX_54M_SRC | \
+					M5A_DPLL_DIV_19 | M5A_DPLL_MULT_19 | \
+					MX_APLLS_CLIKIN_19_2
+/* #5b	(ratio1) target DPLL = 200*2 = 400MHz */
+#define M5B_DPLL_MULT_12		(50 << 12)
+#define M5B_DPLL_DIV_12			(2 << 8)
+#define M5B_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
+					M5B_DPLL_DIV_12 | M5B_DPLL_MULT_12 | \
+					MX_APLLS_CLIKIN_12
+#define M5B_DPLL_MULT_13		(200 << 12)
+#define M5B_DPLL_DIV_13			(12 << 8)
+
+#define M5B_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
+					M5B_DPLL_DIV_13 | M5B_DPLL_MULT_13 | \
+					MX_APLLS_CLIKIN_13
+#define M5B_DPLL_MULT_19		(125 << 12)
+#define M5B_DPLL_DIV_19			(31 << 8)
+#define M5B_CM_CLKSEL1_PLL_19_VAL	MX_48M_SRC | MX_54M_SRC | \
+					M5B_DPLL_DIV_19 | M5B_DPLL_MULT_19 | \
+					MX_APLLS_CLIKIN_19_2
+/*
+ * #4	(ratio2)
+ * #3	(ratio2) baseport-target, target DPLL = 330*2 = 660MHz
+ */
+#define M3_DPLL_MULT_12			(55 << 12)
+#define M3_DPLL_DIV_12			(1 << 8)
+#define M3_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
+					M3_DPLL_DIV_12 | M3_DPLL_MULT_12 | \
+					MX_APLLS_CLIKIN_12
+#define M3_DPLL_MULT_13			(330 << 12)
+#define M3_DPLL_DIV_13			(12 << 8)
+#define M3_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
+					M3_DPLL_DIV_13 | M3_DPLL_MULT_13 | \
+					MX_APLLS_CLIKIN_13
+#define M3_DPLL_MULT_19			(275 << 12)
+#define M3_DPLL_DIV_19			(15 << 8)
+#define M3_CM_CLKSEL1_PLL_19_VAL	MX_48M_SRC | MX_54M_SRC | \
+					M3_DPLL_DIV_19 | M3_DPLL_MULT_19 | \
+					MX_APLLS_CLIKIN_19_2
+/* boot (boot) */
+#define MB_DPLL_MULT			(1 << 12)
+#define MB_DPLL_DIV			(0 << 8)
+#define MB_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | MB_DPLL_DIV |\
+					MB_DPLL_MULT | MX_APLLS_CLIKIN_12
+
+#define MB_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | MB_DPLL_DIV |\
+					MB_DPLL_MULT | MX_APLLS_CLIKIN_13
+
+#define MB_CM_CLKSEL1_PLL_19_VAL	MX_48M_SRC | MX_54M_SRC | MB_DPLL_DIV |\
+					MB_DPLL_MULT | MX_APLLS_CLIKIN_19
+
+/*
+ * 2430 - chassis (sedna)
+ * 165 (ratio1) same as above #2
+ * 150 (ratio1)
+ * 133 (ratio2) same as above #4
+ * 110 (ratio2) same as above #3
+ * 104 (ratio2)
+ * boot (boot)
+ */
+
+/*
+ * 2420 Equivalent - mode registers
+ * PRCM II , target DPLL = 2*300MHz = 600MHz
+ */
+#define MII_DPLL_MULT_12		(50 << 12)
+#define MII_DPLL_DIV_12			(1 << 8)
+#define MII_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
+					MII_DPLL_DIV_12 | MII_DPLL_MULT_12 | \
+					MX_APLLS_CLIKIN_12
+#define MII_DPLL_MULT_13		(300 << 12)
+#define MII_DPLL_DIV_13			(12 << 8)
+#define MII_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
+					MII_DPLL_DIV_13 | MII_DPLL_MULT_13 | \
+					MX_APLLS_CLIKIN_13
+
+/* PRCM III target DPLL = 2*266 = 532MHz*/
+#define MIII_DPLL_MULT_12		(133 << 12)
+#define MIII_DPLL_DIV_12		(5 << 8)
+#define MIII_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
+					MIII_DPLL_DIV_12 | MIII_DPLL_MULT_12 | \
+					MX_APLLS_CLIKIN_12
+#define MIII_DPLL_MULT_13		(266 << 12)
+#define MIII_DPLL_DIV_13		(12 << 8)
+#define MIII_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
+					MIII_DPLL_DIV_13 | MIII_DPLL_MULT_13 | \
+					MX_APLLS_CLIKIN_13
+
+/* PRCM VII (boot bypass) */
+#define MVII_CM_CLKSEL1_PLL_12_VAL	MB_CM_CLKSEL1_PLL_12_VAL
+#define MVII_CM_CLKSEL1_PLL_13_VAL	MB_CM_CLKSEL1_PLL_13_VAL
+
+/* High and low operation value */
+#define MX_CLKSEL2_PLL_2x_VAL		(2 << 0)
+#define MX_CLKSEL2_PLL_1x_VAL		(1 << 0)
+
+/*
+ * These represent optimal values for common parts, it won't work for all.
+ * As long as you scale down, most parameters are still work, they just
+ * become sub-optimal. The RFR value goes in the opposite direction. If you
+ * don't adjust it down as your clock period increases the refresh interval
+ * will not be met. Setting all parameters for complete worst case may work,
+ * but may cut memory performance by 2x. Due to errata the DLLs need to be
+ * unlocked and their value needs run time calibration.	A dynamic call is
+ * need for that as no single right value exists acorss production samples.
+ *
+ * Only the FULL speed values are given. Current code is such that rate
+ * changes must be made at DPLLoutx2. The actual value adjustment for low
+ * frequency operation will be handled by omap_set_performance()
+ *
+ * By having the boot loader boot up in the fastest L4 speed available likely
+ * will result in something which you can switch between.
+ */
+#define V24XX_SDRC_RFR_CTRL_133MHz	(0x0003de00 | 1)
+#define V24XX_SDRC_RFR_CTRL_100MHz	(0x0002da01 | 1)
+#define V24XX_SDRC_RFR_CTRL_110MHz	(0x0002da01 | 1) /* Need to calc */
+#define V24XX_SDRC_RFR_CTRL_BYPASS	(0x00005000 | 1) /* Need to calc */
+
+/* MPU speed defines */
+#define S12M	12000000
+#define S13M	13000000
+#define S19M	19200000
+#define S26M	26000000
+#define S100M	100000000
+#define S133M	133000000
+#define S150M	150000000
+#define S165M	165000000
+#define S200M	200000000
+#define S266M	266000000
+#define S300M	300000000
+#define S330M	330000000
+#define S400M	400000000
+#define S532M	532000000
+#define S600M	600000000
+#define S660M	660000000
+
+/*-------------------------------------------------------------------------
+ * Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
+ * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,
+ * CM_CLKSEL_DSP, CM_CLKSEL_GFX, CM_CLKSEL1_CORE, CM_CLKSEL1_PLL,
+ * CM_CLKSEL2_PLL, CM_CLKSEL_MDM
+ *
+ * Filling in table based on H4 boards and 2430-SDPs variants available.
+ * There are quite a few more rates combinations which could be defined.
+ *
+ * When multiple values are defined the start up will try and choose the
+ * fastest one. If a 'fast' value is defined, then automatically, the /2
+ * one should be included as it can be used.	Generally having more that
+ * one fast set does not make sense, as static timings need to be changed
+ * to change the set.	 The exception is the bypass setting which is
+ * availble for low power bypass.
+ *
+ * Note: This table needs to be sorted, fastest to slowest.
+ *-------------------------------------------------------------------------*/
+static struct prcm_config rate_table[] = {
+	/* PRCM II - FAST */
+	{S12M, S600M, S300M, RII_CM_CLKSEL_MPU_VAL,		/* 300MHz ARM */
+		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
+		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_12_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_100MHz,
+		RATE_IN_242X},
+
+	{S13M, S600M, S300M, RII_CM_CLKSEL_MPU_VAL,		/* 300MHz ARM */
+		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
+		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_100MHz,
+		RATE_IN_242X},
+
+	/* PRCM III - FAST */
+	{S12M, S532M, S266M, RIII_CM_CLKSEL_MPU_VAL,		/* 266MHz ARM */
+		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
+		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_12_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_133MHz,
+		RATE_IN_242X},
+
+	{S13M, S532M, S266M, RIII_CM_CLKSEL_MPU_VAL,		/* 266MHz ARM */
+		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
+		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_133MHz,
+		RATE_IN_242X},
+
+	/* PRCM II - SLOW */
+	{S12M, S300M, S150M, RII_CM_CLKSEL_MPU_VAL,		/* 150MHz ARM */
+		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
+		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_12_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_100MHz,
+		RATE_IN_242X},
+
+	{S13M, S300M, S150M, RII_CM_CLKSEL_MPU_VAL,		/* 150MHz ARM */
+		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
+		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_100MHz,
+		RATE_IN_242X},
+
+	/* PRCM III - SLOW */
+	{S12M, S266M, S133M, RIII_CM_CLKSEL_MPU_VAL,		/* 133MHz ARM */
+		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
+		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_12_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_133MHz,
+		RATE_IN_242X},
+
+	{S13M, S266M, S133M, RIII_CM_CLKSEL_MPU_VAL,		/* 133MHz ARM */
+		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
+		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_133MHz,
+		RATE_IN_242X},
+
+	/* PRCM-VII (boot-bypass) */
+	{S12M, S12M, S12M, RVII_CM_CLKSEL_MPU_VAL,		/* 12MHz ARM*/
+		RVII_CM_CLKSEL_DSP_VAL, RVII_CM_CLKSEL_GFX_VAL,
+		RVII_CM_CLKSEL1_CORE_VAL, MVII_CM_CLKSEL1_PLL_12_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_BYPASS,
+		RATE_IN_242X},
+
+	/* PRCM-VII (boot-bypass) */
+	{S13M, S13M, S13M, RVII_CM_CLKSEL_MPU_VAL,		/* 13MHz ARM */
+		RVII_CM_CLKSEL_DSP_VAL, RVII_CM_CLKSEL_GFX_VAL,
+		RVII_CM_CLKSEL1_CORE_VAL, MVII_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_BYPASS,
+		RATE_IN_242X},
+
+	/* PRCM #3 - ratio2 (ES2) - FAST */
+	{S13M, S660M, S330M, R2_CM_CLKSEL_MPU_VAL,		/* 330MHz ARM */
+		R2_CM_CLKSEL_DSP_VAL, R2_CM_CLKSEL_GFX_VAL,
+		R2_CM_CLKSEL1_CORE_VAL, M3_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, R2_CM_CLKSEL_MDM_VAL,
+		V24XX_SDRC_RFR_CTRL_110MHz,
+		RATE_IN_243X},
+
+	/* PRCM #5a - ratio1 - FAST */
+	{S13M, S532M, S266M, R1_CM_CLKSEL_MPU_VAL,		/* 266MHz ARM */
+		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
+		R1_CM_CLKSEL1_CORE_VAL, M5A_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, R1_CM_CLKSEL_MDM_VAL,
+		V24XX_SDRC_RFR_CTRL_133MHz,
+		RATE_IN_243X},
+
+	/* PRCM #5b - ratio1 - FAST */
+	{S13M, S400M, S200M, R1_CM_CLKSEL_MPU_VAL,		/* 200MHz ARM */
+		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
+		R1_CM_CLKSEL1_CORE_VAL, M5B_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, R1_CM_CLKSEL_MDM_VAL,
+		V24XX_SDRC_RFR_CTRL_100MHz,
+		RATE_IN_243X},
+
+	/* PRCM #3 - ratio2 (ES2) - SLOW */
+	{S13M, S330M, S165M, R2_CM_CLKSEL_MPU_VAL,		/* 165MHz ARM */
+		R2_CM_CLKSEL_DSP_VAL, R2_CM_CLKSEL_GFX_VAL,
+		R2_CM_CLKSEL1_CORE_VAL, M3_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_1x_VAL, R2_CM_CLKSEL_MDM_VAL,
+		V24XX_SDRC_RFR_CTRL_110MHz,
+		RATE_IN_243X},
+
+	/* PRCM #5a - ratio1 - SLOW */
+	{S13M, S266M, S133M, R1_CM_CLKSEL_MPU_VAL,		/* 133MHz ARM */
+		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
+		R1_CM_CLKSEL1_CORE_VAL, M5A_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_1x_VAL, R1_CM_CLKSEL_MDM_VAL,
+		V24XX_SDRC_RFR_CTRL_133MHz,
+		RATE_IN_243X},
+
+	/* PRCM #5b - ratio1 - SLOW*/
+	{S13M, S200M, S100M, R1_CM_CLKSEL_MPU_VAL,		/* 100MHz ARM */
+		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
+		R1_CM_CLKSEL1_CORE_VAL, M5B_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_1x_VAL, R1_CM_CLKSEL_MDM_VAL,
+		V24XX_SDRC_RFR_CTRL_100MHz,
+		RATE_IN_243X},
+
+	/* PRCM-boot/bypass */
+	{S13M, S13M, S13M, RB_CM_CLKSEL_MPU_VAL,		/* 13Mhz */
+		RB_CM_CLKSEL_DSP_VAL, RB_CM_CLKSEL_GFX_VAL,
+		RB_CM_CLKSEL1_CORE_VAL, MB_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, RB_CM_CLKSEL_MDM_VAL,
+		V24XX_SDRC_RFR_CTRL_BYPASS,
+		RATE_IN_243X},
+
+	/* PRCM-boot/bypass */
+	{S12M, S12M, S12M, RB_CM_CLKSEL_MPU_VAL,		/* 12Mhz */
+		RB_CM_CLKSEL_DSP_VAL, RB_CM_CLKSEL_GFX_VAL,
+		RB_CM_CLKSEL1_CORE_VAL, MB_CM_CLKSEL1_PLL_12_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, RB_CM_CLKSEL_MDM_VAL,
+		V24XX_SDRC_RFR_CTRL_BYPASS,
+		RATE_IN_243X},
+
+	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
+};
+
+/*-------------------------------------------------------------------------
+ * 24xx clock tree.
+ *
+ * NOTE:In many cases here we are assigning a 'default' parent.	In many
+ *	cases the parent is selectable.	The get/set parent calls will also
+ *	switch sources.
+ *
+ *	Many some clocks say always_enabled, but they can be auto idled for
+ *	power savings. They will always be available upon clock request.
+ *
+ *	Several sources are given initial rates which may be wrong, this will
+ *	be fixed up in the init func.
+ *
+ *	Things are broadly separated below by clock domains. It is
+ *	noteworthy that most periferals have dependencies on multiple clock
+ *	domains. Many get their interface clocks from the L4 domain, but get
+ *	functional clocks from fixed sources or other core domain derived
+ *	clocks.
+ *-------------------------------------------------------------------------*/
+
+/* Base external input clocks */
+static struct clk func_32k_ck = {
+	.name		= "func_32k_ck",
+	.rate		= 32000,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				RATE_FIXED | ALWAYS_ENABLED,
+};
+
+/* Typical 12/13MHz in standalone mode, will be 26Mhz in chassis mode */
+static struct clk osc_ck = {		/* (*12, *13, 19.2, *26, 38.4)MHz */
+	.name		= "osc_ck",
+	.rate		= 26000000,		/* fixed up in clock init */
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				RATE_FIXED | RATE_PROPAGATES,
+};
+
+/* With out modem likely 12MHz, with modem likely 13MHz */
+static struct clk sys_ck = {		/* (*12, *13, 19.2, 26, 38.4)MHz */
+	.name		= "sys_ck",		/* ~ ref_clk also */
+	.parent		= &osc_ck,
+	.rate		= 13000000,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				RATE_FIXED | ALWAYS_ENABLED | RATE_PROPAGATES,
+	.rate_offset	= 6, /* sysclkdiv 1 or 2, already handled or no boot */
+	.recalc		= &omap2_sys_clk_recalc,
+};
+
+static struct clk alt_ck = {		/* Typical 54M or 48M, may not exist */
+	.name		= "alt_ck",
+	.rate		= 54000000,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				RATE_FIXED | ALWAYS_ENABLED | RATE_PROPAGATES,
+	.recalc		= &omap2_propagate_rate,
+};
+
+/*
+ * Analog domain root source clocks
+ */
+
+/* dpll_ck, is broken out in to special cases through clksel */
+static struct clk dpll_ck = {
+	.name		= "dpll_ck",
+	.parent		= &sys_ck,		/* Can be func_32k also */
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				RATE_PROPAGATES | RATE_CKCTL | CM_PLL_SEL1,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk apll96_ck = {
+	.name		= "apll96_ck",
+	.parent		= &sys_ck,
+	.rate		= 96000000,
+	.flags		= CLOCK_IN_OMAP242X |CLOCK_IN_OMAP243X |
+				RATE_FIXED | RATE_PROPAGATES,
+	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
+	.enable_bit	= 0x2,
+	.recalc		= &omap2_propagate_rate,
+};
+
+static struct clk apll54_ck = {
+	.name		= "apll54_ck",
+	.parent		= &sys_ck,
+	.rate		= 54000000,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				RATE_FIXED | RATE_PROPAGATES,
+	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
+	.enable_bit	= 0x6,
+	.recalc		= &omap2_propagate_rate,
+};
+
+/*
+ * PRCM digital base sources
+ */
+static struct clk func_54m_ck = {
+	.name		= "func_54m_ck",
+	.parent		= &apll54_ck,	/* can also be alt_clk */
+	.rate		= 54000000,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES,
+	.src_offset	= 5,
+	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
+	.enable_bit	= 0xff,
+	.recalc		= &omap2_propagate_rate,
+};
+
+static struct clk core_ck = {
+	.name		= "core_ck",
+	.parent		= &dpll_ck,		/* can also be 32k */
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				ALWAYS_ENABLED | RATE_PROPAGATES,
+	.recalc		= &omap2_propagate_rate,
+};
+
+static struct clk sleep_ck = {		/* sys_clk or 32k */
+	.name		= "sleep_ck",
+	.parent		= &func_32k_ck,
+	.rate		= 32000,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.recalc		= &omap2_propagate_rate,
+};
+
+static struct clk func_96m_ck = {
+	.name		= "func_96m_ck",
+	.parent		= &apll96_ck,
+	.rate		= 96000000,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				RATE_FIXED | RATE_PROPAGATES,
+	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
+	.enable_bit	= 0xff,
+	.recalc		= &omap2_propagate_rate,
+};
+
+static struct clk func_48m_ck = {
+	.name		= "func_48m_ck",
+	.parent		= &apll96_ck,	 /* 96M or Alt */
+	.rate		= 48000000,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES,
+	.src_offset	= 3,
+	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
+	.enable_bit	= 0xff,
+	.recalc		= &omap2_propagate_rate,
+};
+
+static struct clk func_12m_ck = {
+	.name		= "func_12m_ck",
+	.parent		= &func_48m_ck,
+	.rate		= 12000000,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				RATE_FIXED | RATE_PROPAGATES,
+	.recalc		= &omap2_propagate_rate,
+	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
+	.enable_bit	= 0xff,
+};
+
+/* Secure timer, only available in secure mode */
+static struct clk wdt1_osc_ck = {
+	.name		= "ck_wdt1_osc",
+	.parent		= &osc_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk sys_clkout = {
+	.name		= "sys_clkout",
+	.parent		= &func_54m_ck,
+	.rate		= 54000000,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				CM_SYSCLKOUT_SEL1 | RATE_CKCTL,
+	.src_offset	= 0,
+	.enable_reg	= (void __iomem *)&PRCM_CLKOUT_CTRL,
+	.enable_bit	= 7,
+	.rate_offset	= 3,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+/* In 2430, new in 2420 ES2 */
+static struct clk sys_clkout2 = {
+	.name		= "sys_clkout2",
+	.parent		= &func_54m_ck,
+	.rate		= 54000000,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				CM_SYSCLKOUT_SEL1 | RATE_CKCTL,
+	.src_offset	= 8,
+	.enable_reg	= (void __iomem *)&PRCM_CLKOUT_CTRL,
+	.enable_bit	= 15,
+	.rate_offset	= 11,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk emul_ck = {
+	.name		= "emul_ck",
+	.parent		= &func_54m_ck,
+	.flags		= CLOCK_IN_OMAP242X,
+	.enable_reg	= (void __iomem *)&PRCM_CLKEMUL_CTRL,
+	.enable_bit	= 0,
+	.recalc		= &omap2_propagate_rate,
+
+};
+
+/*
+ * MPU clock domain
+ *	Clocks:
+ *		MPU_FCLK, MPU_ICLK
+ *		INT_M_FCLK, INT_M_I_CLK
+ *
+ * - Individual clocks are hardware managed.
+ * - Base divider comes from: CM_CLKSEL_MPU
+ *
+ */
+static struct clk mpu_ck = {	/* Control cpu */
+	.name		= "mpu_ck",
+	.parent		= &core_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | RATE_CKCTL |
+				ALWAYS_ENABLED | CM_MPU_SEL1 | DELAYED_APP |
+				CONFIG_PARTICIPANT | RATE_PROPAGATES,
+	.rate_offset	= 0,	/* bits 0-4 */
+	.recalc		= &omap2_clksel_recalc,
+};
+
+/*
+ * DSP (2430-IVA2.1) (2420-UMA+IVA1) clock domain
+ * Clocks:
+ *	2430: IVA2.1_FCLK, IVA2.1_ICLK
+ *	2420: UMA_FCLK, UMA_ICLK, IVA_MPU, IVA_COP
+ */
+static struct clk iva2_1_fck = {
+	.name		= "iva2_1_fck",
+	.parent		= &core_ck,
+	.flags		= CLOCK_IN_OMAP243X | RATE_CKCTL | CM_DSP_SEL1 |
+				DELAYED_APP | RATE_PROPAGATES |
+				CONFIG_PARTICIPANT,
+	.rate_offset	= 0,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN_DSP,
+	.enable_bit	= 0,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk iva2_1_ick = {
+	.name		= "iva2_1_ick",
+	.parent		= &iva2_1_fck,
+	.flags		= CLOCK_IN_OMAP243X | RATE_CKCTL | CM_DSP_SEL1 |
+				DELAYED_APP | CONFIG_PARTICIPANT,
+	.rate_offset	= 5,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+/*
+ * Won't be too specific here. The core clock comes into this block
+ * it is divided then tee'ed. One branch goes directly to xyz enable
+ * controls. The other branch gets further divided by 2 then possibly
+ * routed into a synchronizer and out of clocks abc.
+ */
+static struct clk dsp_fck = {
+	.name		= "dsp_fck",
+	.parent		= &core_ck,
+	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1 |
+			DELAYED_APP | CONFIG_PARTICIPANT | RATE_PROPAGATES,
+	.rate_offset	= 0,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN_DSP,
+	.enable_bit	= 0,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk dsp_ick = {
+	.name		= "dsp_ick",	 /* apparently ipi and isp */
+	.parent		= &dsp_fck,
+	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1 |
+				DELAYED_APP | CONFIG_PARTICIPANT,
+	.rate_offset = 5,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN_DSP,
+	.enable_bit	= 1,		/* for ipi */
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk iva1_ifck = {
+	.name		= "iva1_ifck",
+	.parent		= &core_ck,
+	.flags		= CLOCK_IN_OMAP242X | CM_DSP_SEL1 | RATE_CKCTL |
+			CONFIG_PARTICIPANT | RATE_PROPAGATES | DELAYED_APP,
+	.rate_offset= 8,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN_DSP,
+	.enable_bit	= 10,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+/* IVA1 mpu/int/i/f clocks are /2 of parent */
+static struct clk iva1_mpu_int_ifck = {
+	.name		= "iva1_mpu_int_ifck",
+	.parent		= &iva1_ifck,
+	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN_DSP,
+	.enable_bit	= 8,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+/*
+ * L3 clock domain
+ * L3 clocks are used for both interface and functional clocks to
+ * multiple entities. Some of these clocks are completely managed
+ * by hardware, and some others allow software control. Hardware
+ * managed ones general are based on directly CLK_REQ signals and
+ * various auto idle settings. The functional spec sets many of these
+ * as 'tie-high' for their enables.
+ *
+ * I-CLOCKS:
+ *	L3-Interconnect, SMS, GPMC, SDRC, OCM_RAM, OCM_ROM, SDMA
+ *	CAM, HS-USB.
+ * F-CLOCK
+ *	SSI.
+ *
+ * GPMC memories and SDRC have timing and clock sensitive registers which
+ * may very well need notification when the clock changes. Currently for low
+ * operating points, these are taken care of in sleep.S.
+ */
+static struct clk core_l3_ck = {	/* Used for ick and fck, interconnect */
+	.name		= "core_l3_ck",
+	.parent		= &core_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				RATE_CKCTL | ALWAYS_ENABLED | CM_CORE_SEL1 |
+				DELAYED_APP | CONFIG_PARTICIPANT |
+				RATE_PROPAGATES,
+	.rate_offset	= 0,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk usb_l4_ick = {	/* FS-USB interface clock */
+	.name		= "usb_l4_ick",
+	.parent		= &core_l3_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP |
+				CONFIG_PARTICIPANT,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
+	.enable_bit	= 0,
+	.rate_offset = 25,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+/*
+ * SSI is in L3 management domain, its direct parent is core not l3,
+ * many core power domain entities are grouped into the L3 clock
+ * domain.
+ * SSI_SSR_FCLK, SSI_SST_FCLK, SSI_L4_CLIK
+ *
+ * ssr = core/1/2/3/4/5, sst = 1/2 ssr.
+ */
+static struct clk ssi_ssr_sst_fck = {
+	.name		= "ssi_fck",
+	.parent		= &core_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,	/* bit 1 */
+	.enable_bit	= 1,
+	.rate_offset = 20,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+/*
+ * GFX clock domain
+ *	Clocks:
+ * GFX_FCLK, GFX_ICLK
+ * GFX_CG1(2d), GFX_CG2(3d)
+ *
+ * GFX_FCLK runs from L3, and is divided by (1,2,3,4)
+ * The 2d and 3d clocks run at a hardware determined
+ * divided value of fclk.
+ *
+ */
+static struct clk gfx_3d_fck = {
+	.name		= "gfx_3d_fck",
+	.parent		= &core_l3_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				RATE_CKCTL | CM_GFX_SEL1,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN_GFX,
+	.enable_bit	= 2,
+	.rate_offset= 0,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk gfx_2d_fck = {
+	.name		= "gfx_2d_fck",
+	.parent		= &core_l3_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				RATE_CKCTL | CM_GFX_SEL1,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN_GFX,
+	.enable_bit	= 1,
+	.rate_offset= 0,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk gfx_ick = {
+	.name		= "gfx_ick",		/* From l3 */
+	.parent		= &core_l3_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				RATE_CKCTL,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN_GFX,	/* bit 0 */
+	.enable_bit	= 0,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+/*
+ * Modem clock domain (2430)
+ *	CLOCKS:
+ *		MDM_OSC_CLK
+ *		MDM_ICLK
+ */
+static struct clk mdm_ick = {		/* used both as a ick and fck */
+	.name		= "mdm_ick",
+	.parent		= &core_ck,
+	.flags		= CLOCK_IN_OMAP243X | RATE_CKCTL | CM_MODEM_SEL1 |
+				DELAYED_APP | CONFIG_PARTICIPANT,
+	.rate_offset	= 0,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN_MDM,
+	.enable_bit	= 0,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk mdm_osc_ck = {
+	.name		= "mdm_osc_ck",
+	.rate		= 26000000,
+	.parent		= &osc_ck,
+	.flags		= CLOCK_IN_OMAP243X | RATE_FIXED,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN_MDM,
+	.enable_bit	= 1,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+/*
+ * L4 clock management domain
+ *
+ * This domain contains lots of interface clocks from the L4 interface, some
+ * functional clocks.	Fixed APLL functional source clocks are managed in
+ * this domain.
+ */
+static struct clk l4_ck = {		/* used both as an ick and fck */
+	.name		= "l4_ck",
+	.parent		= &core_l3_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				RATE_CKCTL | ALWAYS_ENABLED | CM_CORE_SEL1 |
+				DELAYED_APP | RATE_PROPAGATES,
+	.rate_offset	= 5,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk ssi_l4_ick = {
+	.name		= "ssi_l4_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | RATE_CKCTL,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,	/* bit 1 */
+	.enable_bit	= 1,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+/*
+ * DSS clock domain
+ * CLOCKs:
+ * DSS_L4_ICLK, DSS_L3_ICLK,
+ * DSS_CLK1, DSS_CLK2, DSS_54MHz_CLK
+ *
+ * DSS is both initiator and target.
+ */
+static struct clk dss_ick = {		/* Enables both L3,L4 ICLK's */
+	.name		= "dss_ick",
+	.parent		= &l4_ck,	/* really both l3 and l4 */
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | RATE_CKCTL,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_bit	= 0,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk dss1_fck = {
+	.name		= "dss1_fck",
+	.parent		= &core_ck,		/* Core or sys */
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 0,
+	.rate_offset	= 8,
+	.src_offset	= 8,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk dss2_fck = {		/* Alt clk used in power management */
+	.name		= "dss2_fck",
+	.parent		= &sys_ck,		/* fixed at sys_ck or 48MHz */
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				RATE_CKCTL | CM_CORE_SEL1 | RATE_FIXED |
+				DELAYED_APP,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 1,
+	.src_offset	= 13,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk dss_54m_fck = {	/* Alt clk used in power management */
+	.name		= "dss_54m_fck",	/* 54m tv clk */
+	.parent		= &func_54m_ck,
+	.rate		= 54000000,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				RATE_FIXED | RATE_PROPAGATES,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 2,
+	.recalc		= &omap2_propagate_rate,
+};
+
+/*
+ * CORE power domain ICLK & FCLK defines.
+ * Many of the these can have more than one possible parent. Entries
+ * here will likely have an L4 interface parent, and may have multiple
+ * functional clock parents.
+ */
+static struct clk gpt1_ick = {
+	.name		= "gpt1_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,	/* Bit0 */
+	.enable_bit	= 0,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpt1_fck = {
+	.name		= "gpt1_fck",
+	.parent		= &func_32k_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				CM_WKUP_SEL1,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN_WKUP,	/* Bit0 */
+	.enable_bit	= 0,
+	.src_offset	= 0,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpt2_ick = {
+	.name		= "gpt2_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	/* Bit4 */
+	.enable_bit	= 4,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpt2_fck = {
+	.name		= "gpt2_fck",
+	.parent		= &func_32k_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				CM_CORE_SEL2,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 4,
+	.src_offset	= 2,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpt3_ick = {
+	.name		= "gpt3_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	/* Bit5 */
+	.enable_bit	= 5,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpt3_fck = {
+	.name		= "gpt3_fck",
+	.parent		= &func_32k_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				CM_CORE_SEL2,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 5,
+	.src_offset	= 4,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpt4_ick = {
+	.name		= "gpt4_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	/* Bit6 */
+	.enable_bit	= 6,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpt4_fck = {
+	.name		= "gpt4_fck",
+	.parent		= &func_32k_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				CM_CORE_SEL2,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 6,
+	.src_offset	= 6,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpt5_ick = {
+	.name		= "gpt5_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* Bit7 */
+	.enable_bit	= 7,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpt5_fck = {
+	.name		= "gpt5_fck",
+	.parent		= &func_32k_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				CM_CORE_SEL2,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 7,
+	.src_offset	= 8,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpt6_ick = {
+	.name		= "gpt6_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_bit	= 8,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit8 */
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpt6_fck = {
+	.name		= "gpt6_fck",
+	.parent		= &func_32k_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				CM_CORE_SEL2,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 8,
+	.src_offset	= 10,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpt7_ick = {
+	.name		= "gpt7_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit9 */
+	.enable_bit	= 9,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpt7_fck = {
+	.name		= "gpt7_fck",
+	.parent		= &func_32k_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				CM_CORE_SEL2,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 9,
+	.src_offset	= 12,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpt8_ick = {
+	.name		= "gpt8_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit10 */
+	.enable_bit	= 10,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpt8_fck = {
+	.name		= "gpt8_fck",
+	.parent		= &func_32k_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				CM_CORE_SEL2,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 10,
+	.src_offset	= 14,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpt9_ick = {
+	.name		= "gpt9_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_bit	= 11,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpt9_fck = {
+	.name		= "gpt9_fck",
+	.parent		= &func_32k_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+					CM_CORE_SEL2,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 11,
+	.src_offset	= 16,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpt10_ick = {
+	.name		= "gpt10_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_bit	= 12,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpt10_fck = {
+	.name		= "gpt10_fck",
+	.parent		= &func_32k_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+					CM_CORE_SEL2,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 12,
+	.src_offset	= 18,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpt11_ick = {
+	.name		= "gpt11_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_bit	= 13,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpt11_fck = {
+	.name		= "gpt11_fck",
+	.parent		= &func_32k_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+					CM_CORE_SEL2,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 13,
+	.src_offset	= 20,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpt12_ick = {
+	.name		= "gpt12_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit14 */
+	.enable_bit	= 14,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpt12_fck = {
+	.name		= "gpt12_fck",
+	.parent		= &func_32k_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+					CM_CORE_SEL2,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 14,
+	.src_offset	= 22,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mcbsp1_ick = {
+	.name		= "mcbsp1_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_bit	= 15,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit16 */
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mcbsp1_fck = {
+	.name		= "mcbsp1_fck",
+	.parent		= &func_96m_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_bit	= 15,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mcbsp2_ick = {
+	.name		= "mcbsp2_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_bit	= 16,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mcbsp2_fck = {
+	.name		= "mcbsp2_fck",
+	.parent		= &func_96m_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_bit	= 16,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mcbsp3_ick = {
+	.name		= "mcbsp3_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
+	.enable_bit	= 3,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mcbsp3_fck = {
+	.name		= "mcbsp3_fck",
+	.parent		= &func_96m_ck,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_bit	= 3,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mcbsp4_ick = {
+	.name		= "mcbsp4_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
+	.enable_bit	= 4,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mcbsp4_fck = {
+	.name		= "mcbsp4_fck",
+	.parent		= &func_96m_ck,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_bit	= 4,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mcbsp5_ick = {
+	.name		= "mcbsp5_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
+	.enable_bit	= 5,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mcbsp5_fck = {
+	.name		= "mcbsp5_fck",
+	.parent		= &func_96m_ck,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_bit	= 5,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mcspi1_ick = {
+	.name		= "mcspi_ick",
+	.id		= 1,
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_bit	= 17,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mcspi1_fck = {
+	.name		= "mcspi_fck",
+	.id		= 1,
+	.parent		= &func_48m_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 17,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mcspi2_ick = {
+	.name		= "mcspi_ick",
+	.id		= 2,
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_bit	= 18,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mcspi2_fck = {
+	.name		= "mcspi_fck",
+	.id		= 2,
+	.parent		= &func_48m_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 18,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mcspi3_ick = {
+	.name		= "mcspi_ick",
+	.id		= 3,
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
+	.enable_bit	= 9,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mcspi3_fck = {
+	.name		= "mcspi_fck",
+	.id		= 3,
+	.parent		= &func_48m_ck,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_bit	= 9,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk uart1_ick = {
+	.name		= "uart1_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_bit	= 21,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk uart1_fck = {
+	.name		= "uart1_fck",
+	.parent		= &func_48m_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 21,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk uart2_ick = {
+	.name		= "uart2_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_bit	= 22,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk uart2_fck = {
+	.name		= "uart2_fck",
+	.parent		= &func_48m_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 22,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk uart3_ick = {
+	.name		= "uart3_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
+	.enable_bit	= 2,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk uart3_fck = {
+	.name		= "uart3_fck",
+	.parent		= &func_48m_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_bit	= 2,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpios_ick = {
+	.name		= "gpios_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
+	.enable_bit	= 2,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpios_fck = {
+	.name		= "gpios_fck",
+	.parent		= &func_32k_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN_WKUP,
+	.enable_bit	= 2,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mpu_wdt_ick = {
+	.name		= "mpu_wdt_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
+	.enable_bit	= 3,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mpu_wdt_fck = {
+	.name		= "mpu_wdt_fck",
+	.parent		= &func_32k_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN_WKUP,
+	.enable_bit	= 3,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk sync_32k_ick = {
+	.name		= "sync_32k_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
+	.enable_bit	= 1,
+	.recalc		= &omap2_followparent_recalc,
+};
+static struct clk wdt1_ick = {
+	.name		= "wdt1_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
+	.enable_bit	= 4,
+	.recalc		= &omap2_followparent_recalc,
+};
+static struct clk omapctrl_ick = {
+	.name		= "omapctrl_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
+	.enable_bit	= 5,
+	.recalc		= &omap2_followparent_recalc,
+};
+static struct clk icr_ick = {
+	.name		= "icr_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
+	.enable_bit	= 6,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk cam_ick = {
+	.name		= "cam_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_bit	= 31,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk cam_fck = {
+	.name		= "cam_fck",
+	.parent		= &func_96m_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 31,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mailboxes_ick = {
+	.name		= "mailboxes_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_bit	= 30,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk wdt4_ick = {
+	.name		= "wdt4_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_bit	= 29,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk wdt4_fck = {
+	.name		= "wdt4_fck",
+	.parent		= &func_32k_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 29,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk wdt3_ick = {
+	.name		= "wdt3_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_bit	= 28,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk wdt3_fck = {
+	.name		= "wdt3_fck",
+	.parent		= &func_32k_ck,
+	.flags		= CLOCK_IN_OMAP242X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 28,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mspro_ick = {
+	.name		= "mspro_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_bit	= 27,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mspro_fck = {
+	.name		= "mspro_fck",
+	.parent		= &func_96m_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 27,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mmc_ick = {
+	.name		= "mmc_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_bit	= 26,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mmc_fck = {
+	.name		= "mmc_fck",
+	.parent		= &func_96m_ck,
+	.flags		= CLOCK_IN_OMAP242X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 26,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk fac_ick = {
+	.name		= "fac_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_bit	= 25,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk fac_fck = {
+	.name		= "fac_fck",
+	.parent		= &func_12m_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 25,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk eac_ick = {
+	.name		= "eac_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_bit	= 24,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk eac_fck = {
+	.name		= "eac_fck",
+	.parent		= &func_96m_ck,
+	.flags		= CLOCK_IN_OMAP242X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 24,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk hdq_ick = {
+	.name		= "hdq_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_bit	= 23,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk hdq_fck = {
+	.name		= "hdq_fck",
+	.parent		= &func_12m_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 23,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk i2c2_ick = {
+	.name		= "i2c_ick",
+	.id		= 2,
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_bit	= 20,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk i2c2_fck = {
+	.name		= "i2c_fck",
+	.id		= 2,
+	.parent		= &func_12m_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 20,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk i2chs2_fck = {
+	.name		= "i2chs2_fck",
+	.parent		= &func_96m_ck,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_bit	= 20,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk i2c1_ick = {
+	.name		= "i2c_ick",
+	.id		= 1,
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_bit	= 19,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk i2c1_fck = {
+	.name		= "i2c_fck",
+	.id		= 1,
+	.parent		= &func_12m_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 19,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk i2chs1_fck = {
+	.name		= "i2chs1_fck",
+	.parent		= &func_96m_ck,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_bit	= 19,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk vlynq_ick = {
+	.name		= "vlynq_ick",
+	.parent		= &core_l3_ck,
+	.flags		= CLOCK_IN_OMAP242X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
+	.enable_bit	= 3,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk vlynq_fck = {
+	.name		= "vlynq_fck",
+	.parent		= &func_96m_ck,
+	.flags		= CLOCK_IN_OMAP242X  | RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
+	.enable_bit	= 3,
+	.src_offset	= 15,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk sdrc_ick = {
+	.name		= "sdrc_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN3_CORE,
+	.enable_bit	= 2,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk des_ick = {
+	.name		= "des_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
+	.enable_bit	= 0,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk sha_ick = {
+	.name		= "sha_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
+	.enable_bit	= 1,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk rng_ick = {
+	.name		= "rng_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
+	.enable_bit	= 2,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk aes_ick = {
+	.name		= "aes_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
+	.enable_bit	= 3,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk pka_ick = {
+	.name		= "pka_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
+	.enable_bit	= 4,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk usb_fck = {
+	.name		= "usb_fck",
+	.parent		= &func_48m_ck,
+	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_bit	= 0,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk usbhs_ick = {
+	.name		= "usbhs_ick",
+	.parent		= &core_l3_ck,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
+	.enable_bit	= 6,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mmchs1_ick = {
+	.name		= "mmchs1_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
+	.enable_bit	= 7,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mmchs1_fck = {
+	.name		= "mmchs1_fck",
+	.parent		= &func_96m_ck,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_bit	= 7,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mmchs2_ick = {
+	.name		= "mmchs2_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
+	.enable_bit	= 8,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mmchs2_fck = {
+	.name		= "mmchs2_fck",
+	.parent		= &func_96m_ck,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_bit	= 8,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpio5_ick = {
+	.name		= "gpio5_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
+	.enable_bit	= 10,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk gpio5_fck = {
+	.name		= "gpio5_fck",
+	.parent		= &func_32k_ck,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_bit	= 10,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mdm_intc_ick = {
+	.name		= "mdm_intc_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
+	.enable_bit	= 11,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mmchsdb1_fck = {
+	.name		= "mmchsdb1_fck",
+	.parent		= &func_32k_ck,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_bit	= 16,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+static struct clk mmchsdb2_fck = {
+	.name		= "mmchsdb2_fck",
+	.parent		= &func_32k_ck,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
+	.enable_bit	= 17,
+	.recalc		= &omap2_followparent_recalc,
+};
+
+/*
+ * This clock is a composite clock which does entire set changes then
+ * forces a rebalance. It keys on the MPU speed, but it really could
+ * be any key speed part of a set in the rate table.
+ *
+ * to really change a set, you need memory table sets which get changed
+ * in sram, pre-notifiers & post notifiers, changing the top set, without
+ * having low level display recalc's won't work... this is why dpm notifiers
+ * work, isr's off, walk a list of clocks already _off_ and not messing with
+ * the bus.
+ *
+ * This clock should have no parent. It embodies the entire upper level
+ * active set. A parent will mess up some of the init also.
+ */
+static struct clk virt_prcm_set = {
+	.name		= "virt_prcm_set",
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				VIRTUAL_CLOCK | ALWAYS_ENABLED | DELAYED_APP,
+	.parent		= &mpu_ck,	/* Indexed by mpu speed, no parent */
+	.recalc		= &omap2_mpu_recalc,	/* sets are keyed on mpu rate */
+	.set_rate	= &omap2_select_table_rate,
+	.round_rate	= &omap2_round_to_table_rate,
+};
+
+static struct clk *onchip_clks[] = {
+	/* external root sources */
+	&func_32k_ck,
+	&osc_ck,
+	&sys_ck,
+	&alt_ck,
+	/* internal analog sources */
+	&dpll_ck,
+	&apll96_ck,
+	&apll54_ck,
+	/* internal prcm root sources */
+	&func_54m_ck,
+	&core_ck,
+	&sleep_ck,
+	&func_96m_ck,
+	&func_48m_ck,
+	&func_12m_ck,
+	&wdt1_osc_ck,
+	&sys_clkout,
+	&sys_clkout2,
+	&emul_ck,
+	/* mpu domain clocks */
+	&mpu_ck,
+	/* dsp domain clocks */
+	&iva2_1_fck,		/* 2430 */
+	&iva2_1_ick,
+	&dsp_ick,		/* 2420 */
+	&dsp_fck,
+	&iva1_ifck,
+	&iva1_mpu_int_ifck,
+	/* GFX domain clocks */
+	&gfx_3d_fck,
+	&gfx_2d_fck,
+	&gfx_ick,
+	/* Modem domain clocks */
+	&mdm_ick,
+	&mdm_osc_ck,
+	/* DSS domain clocks */
+	&dss_ick,
+	&dss1_fck,
+	&dss2_fck,
+	&dss_54m_fck,
+	/* L3 domain clocks */
+	&core_l3_ck,
+	&ssi_ssr_sst_fck,
+	&usb_l4_ick,
+	/* L4 domain clocks */
+	&l4_ck,			/* used as both core_l4 and wu_l4 */
+	&ssi_l4_ick,
+	/* virtual meta-group clock */
+	&virt_prcm_set,
+	/* general l4 interface ck, multi-parent functional clk */
+	&gpt1_ick,
+	&gpt1_fck,
+	&gpt2_ick,
+	&gpt2_fck,
+	&gpt3_ick,
+	&gpt3_fck,
+	&gpt4_ick,
+	&gpt4_fck,
+	&gpt5_ick,
+	&gpt5_fck,
+	&gpt6_ick,
+	&gpt6_fck,
+	&gpt7_ick,
+	&gpt7_fck,
+	&gpt8_ick,
+	&gpt8_fck,
+	&gpt9_ick,
+	&gpt9_fck,
+	&gpt10_ick,
+	&gpt10_fck,
+	&gpt11_ick,
+	&gpt11_fck,
+	&gpt12_ick,
+	&gpt12_fck,
+	&mcbsp1_ick,
+	&mcbsp1_fck,
+	&mcbsp2_ick,
+	&mcbsp2_fck,
+	&mcbsp3_ick,
+	&mcbsp3_fck,
+	&mcbsp4_ick,
+	&mcbsp4_fck,
+	&mcbsp5_ick,
+	&mcbsp5_fck,
+	&mcspi1_ick,
+	&mcspi1_fck,
+	&mcspi2_ick,
+	&mcspi2_fck,
+	&mcspi3_ick,
+	&mcspi3_fck,
+	&uart1_ick,
+	&uart1_fck,
+	&uart2_ick,
+	&uart2_fck,
+	&uart3_ick,
+	&uart3_fck,
+	&gpios_ick,
+	&gpios_fck,
+	&mpu_wdt_ick,
+	&mpu_wdt_fck,
+	&sync_32k_ick,
+	&wdt1_ick,
+	&omapctrl_ick,
+	&icr_ick,
+	&cam_fck,
+	&cam_ick,
+	&mailboxes_ick,
+	&wdt4_ick,
+	&wdt4_fck,
+	&wdt3_ick,
+	&wdt3_fck,
+	&mspro_ick,
+	&mspro_fck,
+	&mmc_ick,
+	&mmc_fck,
+	&fac_ick,
+	&fac_fck,
+	&eac_ick,
+	&eac_fck,
+	&hdq_ick,
+	&hdq_fck,
+	&i2c1_ick,
+	&i2c1_fck,
+	&i2chs1_fck,
+	&i2c2_ick,
+	&i2c2_fck,
+	&i2chs2_fck,
+	&vlynq_ick,
+	&vlynq_fck,
+	&sdrc_ick,
+	&des_ick,
+	&sha_ick,
+	&rng_ick,
+	&aes_ick,
+	&pka_ick,
+	&usb_fck,
+	&usbhs_ick,
+	&mmchs1_ick,
+	&mmchs1_fck,
+	&mmchs2_ick,
+	&mmchs2_fck,
+	&gpio5_ick,
+	&gpio5_fck,
+	&mdm_intc_ick,
+	&mmchsdb1_fck,
+	&mmchsdb2_fck,
+};
+
+#endif
-- 
1.5.3.6


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
