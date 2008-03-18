From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/17] ARM: OMAP2: Remove old 24xx specific clock functions
Date: Tue, 18 Mar 2008 16:02:10 +0200
Message-ID: <1205848935-12078-13-git-send-email-tony@atomide.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <1205848935-12078-12-git-send-email-tony@atomide.com>
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

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock24xx.c |  722 ---------------------------------------
 1 files changed, 0 insertions(+), 722 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index f2b12b6..0c8ae09 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -108,29 +108,6 @@ static u32 omap2_get_dpll_rate_24xx(struct clk *tclk)
 	return dpll_clk;
 }
 
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
-#ifdef OLD_CK
-static void omap2_set_osc_ck(int enable)
-{
-	if (enable)
-		PRCM_CLKSRC_CTRL &= ~(0x3 << 3);
-	else
-		PRCM_CLKSRC_CTRL |= 0x3 << 3;
-}
-#endif	/* OLD_CK */
-
 /* Enable an APLL if off */
 static int omap2_clk_fixed_enable(struct clk *clk)
 {
@@ -162,84 +139,6 @@ static int omap2_clk_fixed_enable(struct clk *clk)
 	return 0;
 }
 
-#ifdef OLD_CK
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
-#endif	/* OLD_CK */
-
 /* Stop APLL */
 static void omap2_clk_fixed_disable(struct clk *clk)
 {
@@ -250,65 +149,6 @@ static void omap2_clk_fixed_disable(struct clk *clk)
 	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
 }
 
-#ifdef OLD_CK
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
-#endif	/* OLD_CK */
-
 /*
  * Uses the current prcm set to tell if a rate is valid.
  * You can go slower, but not faster within a given rate set.
@@ -342,195 +182,6 @@ static u32 omap2_dpll_round_rate(unsigned long target_rate)
 
 }
 
-#ifdef OLD_CK
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
-#endif	/* OLD_CK */
-
 static void omap2_dpll_recalc(struct clk *clk)
 {
 	clk->rate = omap2_get_dpll_rate_24xx(clk);
@@ -655,359 +306,6 @@ static long omap2_round_to_table_rate(struct clk *clk, unsigned long rate)
 	return highest_rate;
 }
 
-#ifdef OLD_CK
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
-#endif	/* OLD_CK */
-
 /* Sets basic clocks based on the specified rate */
 static int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 {
@@ -1089,26 +387,6 @@ static int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 	return 0;
 }
 
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
 static struct clk_functions omap2_clk_functions = {
 	.clk_enable		= omap2_clk_enable,
 	.clk_disable		= omap2_clk_disable,
-- 
1.5.3.6


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
