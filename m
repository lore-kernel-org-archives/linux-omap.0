From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 35/43] ARM: OMAP2+: clock: use driver API instead of direct memory read/write
Date: Fri, 25 Oct 2013 18:57:29 +0300
Message-ID: <1382716658-6964-36-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36445 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755011Ab3JYQAk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Oct 2013 12:00:40 -0400
In-Reply-To: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Clock nodes shall use the services provided by underlying drivers to access
the hardware registers instead of direct memory read/write. Thus, change
all the code to use the new omap2_clk_readl / omap2_clk_writel APIs for this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clkt_clksel.c |   10 +++++-----
 arch/arm/mach-omap2/clkt_dpll.c   |    6 +++---
 arch/arm/mach-omap2/clkt_iclk.c   |   20 ++++++++++++--------
 arch/arm/mach-omap2/clock.c       |   24 ++++++++++++------------
 arch/arm/mach-omap2/clock36xx.c   |    7 ++++---
 arch/arm/mach-omap2/dpll3xxx.c    |   37 ++++++++++++++++++++-----------------
 arch/arm/mach-omap2/dpll44xx.c    |   12 ++++++------
 7 files changed, 62 insertions(+), 54 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2/clkt_clksel.c
index 0ec9f6f..7ee2610 100644
--- a/arch/arm/mach-omap2/clkt_clksel.c
+++ b/arch/arm/mach-omap2/clkt_clksel.c
@@ -97,12 +97,12 @@ static void _write_clksel_reg(struct clk_hw_omap *clk, u32 field_val)
 {
 	u32 v;
 
-	v = __raw_readl(clk->clksel_reg);
+	v = omap2_clk_readl(clk, clk->clksel_reg);
 	v &= ~clk->clksel_mask;
 	v |= field_val << __ffs(clk->clksel_mask);
-	__raw_writel(v, clk->clksel_reg);
+	omap2_clk_writel(v, clk, clk->clksel_reg);
 
-	v = __raw_readl(clk->clksel_reg); /* OCP barrier */
+	v = omap2_clk_readl(clk, clk->clksel_reg); /* OCP barrier */
 }
 
 /**
@@ -204,7 +204,7 @@ static u32 _read_divisor(struct clk_hw_omap *clk)
 	if (!clk->clksel || !clk->clksel_mask)
 		return 0;
 
-	v = __raw_readl(clk->clksel_reg);
+	v = omap2_clk_readl(clk, clk->clksel_reg);
 	v &= clk->clksel_mask;
 	v >>= __ffs(clk->clksel_mask);
 
@@ -320,7 +320,7 @@ u8 omap2_clksel_find_parent_index(struct clk_hw *hw)
 	WARN((!clk->clksel || !clk->clksel_mask),
 	     "clock: %s: attempt to call on a non-clksel clock", clk_name);
 
-	r = __raw_readl(clk->clksel_reg) & clk->clksel_mask;
+	r = omap2_clk_readl(clk, clk->clksel_reg) & clk->clksel_mask;
 	r >>= __ffs(clk->clksel_mask);
 
 	for (clks = clk->clksel; clks->parent && !found; clks++) {
diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index 924c230..47f9562 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -196,7 +196,7 @@ u8 omap2_init_dpll_parent(struct clk_hw *hw)
 	if (!dd)
 		return -EINVAL;
 
-	v = __raw_readl(dd->control_reg);
+	v = omap2_clk_readl(clk, dd->control_reg);
 	v &= dd->enable_mask;
 	v >>= __ffs(dd->enable_mask);
 
@@ -243,7 +243,7 @@ unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk)
 		return 0;
 
 	/* Return bypass rate if DPLL is bypassed */
-	v = __raw_readl(dd->control_reg);
+	v = omap2_clk_readl(clk, dd->control_reg);
 	v &= dd->enable_mask;
 	v >>= __ffs(dd->enable_mask);
 
@@ -262,7 +262,7 @@ unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk)
 			return __clk_get_rate(dd->clk_bypass);
 	}
 
-	v = __raw_readl(dd->mult_div1_reg);
+	v = omap2_clk_readl(clk, dd->mult_div1_reg);
 	dpll_mult = v & dd->mult_mask;
 	dpll_mult >>= __ffs(dd->mult_mask);
 	dpll_div = v & dd->div1_mask;
diff --git a/arch/arm/mach-omap2/clkt_iclk.c b/arch/arm/mach-omap2/clkt_iclk.c
index f10eb03..333f0a6 100644
--- a/arch/arm/mach-omap2/clkt_iclk.c
+++ b/arch/arm/mach-omap2/clkt_iclk.c
@@ -25,25 +25,29 @@
 /* XXX */
 void omap2_clkt_iclk_allow_idle(struct clk_hw_omap *clk)
 {
-	u32 v, r;
+	u32 v;
+	void __iomem *r;
 
-	r = ((__force u32)clk->enable_reg ^ (CM_AUTOIDLE ^ CM_ICLKEN));
+	r = (__force void __iomem *)
+		((__force u32)clk->enable_reg ^ (CM_AUTOIDLE ^ CM_ICLKEN));
 
-	v = __raw_readl((__force void __iomem *)r);
+	v = omap2_clk_readl(clk, r);
 	v |= (1 << clk->enable_bit);
-	__raw_writel(v, (__force void __iomem *)r);
+	omap2_clk_writel(v, clk, r);
 }
 
 /* XXX */
 void omap2_clkt_iclk_deny_idle(struct clk_hw_omap *clk)
 {
-	u32 v, r;
+	u32 v;
+	void __iomem *r;
 
-	r = ((__force u32)clk->enable_reg ^ (CM_AUTOIDLE ^ CM_ICLKEN));
+	r = (__force void __iomem *)
+		((__force u32)clk->enable_reg ^ (CM_AUTOIDLE ^ CM_ICLKEN));
 
-	v = __raw_readl((__force void __iomem *)r);
+	v = omap2_clk_readl(clk, r);
 	v &= ~(1 << clk->enable_bit);
-	__raw_writel(v, (__force void __iomem *)r);
+	omap2_clk_writel(v, clk, r);
 }
 
 /* Public data */
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 560c49b..dd7a739 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -118,14 +118,14 @@ unsigned long omap_fixed_divisor_recalc(struct clk_hw *hw,
  * elapsed.  XXX Deprecated - should be moved into drivers for the
  * individual IP block that the IDLEST register exists in.
  */
-static int _wait_idlest_generic(void __iomem *reg, u32 mask, u8 idlest,
-				const char *name)
+static int _wait_idlest_generic(struct clk_hw_omap *clk, void __iomem *reg,
+				u32 mask, u8 idlest, const char *name)
 {
 	int i = 0, ena = 0;
 
 	ena = (idlest) ? 0 : mask;
 
-	omap_test_timeout(((__raw_readl(reg) & mask) == ena),
+	omap_test_timeout(((omap2_clk_readl(clk, reg) & mask) == ena),
 			  MAX_MODULE_ENABLE_WAIT, i);
 
 	if (i < MAX_MODULE_ENABLE_WAIT)
@@ -158,7 +158,7 @@ static void _omap2_module_wait_ready(struct clk_hw_omap *clk)
 	/* Not all modules have multiple clocks that their IDLEST depends on */
 	if (clk->ops->find_companion) {
 		clk->ops->find_companion(clk, &companion_reg, &other_bit);
-		if (!(__raw_readl(companion_reg) & (1 << other_bit)))
+		if (!(omap2_clk_readl(clk, companion_reg) & (1 << other_bit)))
 			return;
 	}
 
@@ -166,8 +166,8 @@ static void _omap2_module_wait_ready(struct clk_hw_omap *clk)
 	r = cm_split_idlest_reg(idlest_reg, &prcm_mod, &idlest_reg_id);
 	if (r) {
 		/* IDLEST register not in the CM module */
-		_wait_idlest_generic(idlest_reg, (1 << idlest_bit), idlest_val,
-				     __clk_get_name(clk->hw.clk));
+		_wait_idlest_generic(clk, idlest_reg, (1 << idlest_bit),
+				     idlest_val, __clk_get_name(clk->hw.clk));
 	} else {
 		cm_wait_module_ready(prcm_mod, idlest_reg_id, idlest_bit);
 	};
@@ -329,13 +329,13 @@ int omap2_dflt_clk_enable(struct clk_hw *hw)
 	}
 
 	/* FIXME should not have INVERT_ENABLE bit here */
-	v = __raw_readl(clk->enable_reg);
+	v = omap2_clk_readl(clk, clk->enable_reg);
 	if (clk->flags & INVERT_ENABLE)
 		v &= ~(1 << clk->enable_bit);
 	else
 		v |= (1 << clk->enable_bit);
-	__raw_writel(v, clk->enable_reg);
-	v = __raw_readl(clk->enable_reg); /* OCP barrier */
+	omap2_clk_writel(v, clk, clk->enable_reg);
+	v = omap2_clk_readl(clk, clk->enable_reg); /* OCP barrier */
 
 	if (clk->ops && clk->ops->find_idlest)
 		_omap2_module_wait_ready(clk);
@@ -373,12 +373,12 @@ void omap2_dflt_clk_disable(struct clk_hw *hw)
 		return;
 	}
 
-	v = __raw_readl(clk->enable_reg);
+	v = omap2_clk_readl(clk, clk->enable_reg);
 	if (clk->flags & INVERT_ENABLE)
 		v |= (1 << clk->enable_bit);
 	else
 		v &= ~(1 << clk->enable_bit);
-	__raw_writel(v, clk->enable_reg);
+	omap2_clk_writel(v, clk, clk->enable_reg);
 	/* No OCP barrier needed here since it is a disable operation */
 
 	if (clkdm_control && clk->clkdm)
@@ -474,7 +474,7 @@ int omap2_dflt_clk_is_enabled(struct clk_hw *hw)
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
 	u32 v;
 
-	v = __raw_readl(clk->enable_reg);
+	v = omap2_clk_readl(clk, clk->enable_reg);
 
 	if (clk->flags & INVERT_ENABLE)
 		v ^= BIT(clk->enable_bit);
diff --git a/arch/arm/mach-omap2/clock36xx.c b/arch/arm/mach-omap2/clock36xx.c
index bbd6a3f..91ccb96 100644
--- a/arch/arm/mach-omap2/clock36xx.c
+++ b/arch/arm/mach-omap2/clock36xx.c
@@ -43,6 +43,7 @@ int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk_hw *clk)
 	struct clk_divider *parent;
 	struct clk_hw *parent_hw;
 	u32 dummy_v, orig_v;
+	struct clk_hw_omap *omap_clk = to_clk_hw_omap(clk);
 	int ret;
 
 	/* Clear PWRDN bit of HSDIVIDER */
@@ -53,15 +54,15 @@ int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk_hw *clk)
 
 	/* Restore the dividers */
 	if (!ret) {
-		orig_v = __raw_readl(parent->reg);
+		orig_v = omap2_clk_readl(omap_clk, parent->reg);
 		dummy_v = orig_v;
 
 		/* Write any other value different from the Read value */
 		dummy_v ^= (1 << parent->shift);
-		__raw_writel(dummy_v, parent->reg);
+		omap2_clk_writel(dummy_v, omap_clk, parent->reg);
 
 		/* Write the original divider */
-		__raw_writel(orig_v, parent->reg);
+		omap2_clk_writel(orig_v, omap_clk, parent->reg);
 	}
 
 	return ret;
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 3a0296c..3185ced 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -50,10 +50,10 @@ static void _omap3_dpll_write_clken(struct clk_hw_omap *clk, u8 clken_bits)
 
 	dd = clk->dpll_data;
 
-	v = __raw_readl(dd->control_reg);
+	v = omap2_clk_readl(clk, dd->control_reg);
 	v &= ~dd->enable_mask;
 	v |= clken_bits << __ffs(dd->enable_mask);
-	__raw_writel(v, dd->control_reg);
+	omap2_clk_writel(v, clk, dd->control_reg);
 }
 
 /* _omap3_wait_dpll_status: wait for a DPLL to enter a specific state */
@@ -69,8 +69,8 @@ static int _omap3_wait_dpll_status(struct clk_hw_omap *clk, u8 state)
 
 	state <<= __ffs(dd->idlest_mask);
 
-	while (((__raw_readl(dd->idlest_reg) & dd->idlest_mask) != state) &&
-	       i < MAX_DPLL_WAIT_TRIES) {
+	while (((omap2_clk_readl(clk, dd->idlest_reg) & dd->idlest_mask)
+		!= state) && i < MAX_DPLL_WAIT_TRIES) {
 		i++;
 		udelay(1);
 	}
@@ -147,7 +147,7 @@ static int _omap3_noncore_dpll_lock(struct clk_hw_omap *clk)
 	state <<= __ffs(dd->idlest_mask);
 
 	/* Check if already locked */
-	if ((__raw_readl(dd->idlest_reg) & dd->idlest_mask) == state)
+	if ((omap2_clk_readl(clk, dd->idlest_reg) & dd->idlest_mask) == state)
 		goto done;
 
 	ai = omap3_dpll_autoidle_read(clk);
@@ -311,14 +311,14 @@ static int omap3_noncore_dpll_program(struct clk_hw_omap *clk, u16 freqsel)
 	 * only since freqsel field is no longer present on other devices.
 	 */
 	if (cpu_is_omap343x()) {
-		v = __raw_readl(dd->control_reg);
+		v = omap2_clk_readl(clk, dd->control_reg);
 		v &= ~dd->freqsel_mask;
 		v |= freqsel << __ffs(dd->freqsel_mask);
-		__raw_writel(v, dd->control_reg);
+		omap2_clk_writel(v, clk, dd->control_reg);
 	}
 
 	/* Set DPLL multiplier, divider */
-	v = __raw_readl(dd->mult_div1_reg);
+	v = omap2_clk_readl(clk, dd->mult_div1_reg);
 	v &= ~(dd->mult_mask | dd->div1_mask);
 	v |= dd->last_rounded_m << __ffs(dd->mult_mask);
 	v |= (dd->last_rounded_n - 1) << __ffs(dd->div1_mask);
@@ -336,11 +336,11 @@ static int omap3_noncore_dpll_program(struct clk_hw_omap *clk, u16 freqsel)
 		v |= sd_div << __ffs(dd->sddiv_mask);
 	}
 
-	__raw_writel(v, dd->mult_div1_reg);
+	omap2_clk_writel(v, clk, dd->mult_div1_reg);
 
 	/* Set 4X multiplier and low-power mode */
 	if (dd->m4xen_mask || dd->lpmode_mask) {
-		v = __raw_readl(dd->control_reg);
+		v = omap2_clk_readl(clk, dd->control_reg);
 
 		if (dd->m4xen_mask) {
 			if (dd->last_rounded_m4xen)
@@ -356,7 +356,7 @@ static int omap3_noncore_dpll_program(struct clk_hw_omap *clk, u16 freqsel)
 				v &= ~dd->lpmode_mask;
 		}
 
-		__raw_writel(v, dd->control_reg);
+		omap2_clk_writel(v, clk, dd->control_reg);
 	}
 
 	/* We let the clock framework set the other output dividers later */
@@ -554,7 +554,7 @@ u32 omap3_dpll_autoidle_read(struct clk_hw_omap *clk)
 	if (!dd->autoidle_reg)
 		return -EINVAL;
 
-	v = __raw_readl(dd->autoidle_reg);
+	v = omap2_clk_readl(clk, dd->autoidle_reg);
 	v &= dd->autoidle_mask;
 	v >>= __ffs(dd->autoidle_mask);
 
@@ -588,10 +588,10 @@ void omap3_dpll_allow_idle(struct clk_hw_omap *clk)
 	 * by writing 0x5 instead of 0x1.  Add some mechanism to
 	 * optionally enter this mode.
 	 */
-	v = __raw_readl(dd->autoidle_reg);
+	v = omap2_clk_readl(clk, dd->autoidle_reg);
 	v &= ~dd->autoidle_mask;
 	v |= DPLL_AUTOIDLE_LOW_POWER_STOP << __ffs(dd->autoidle_mask);
-	__raw_writel(v, dd->autoidle_reg);
+	omap2_clk_writel(v, clk, dd->autoidle_reg);
 
 }
 
@@ -614,10 +614,10 @@ void omap3_dpll_deny_idle(struct clk_hw_omap *clk)
 	if (!dd->autoidle_reg)
 		return;
 
-	v = __raw_readl(dd->autoidle_reg);
+	v = omap2_clk_readl(clk, dd->autoidle_reg);
 	v &= ~dd->autoidle_mask;
 	v |= DPLL_AUTOIDLE_DISABLE << __ffs(dd->autoidle_mask);
-	__raw_writel(v, dd->autoidle_reg);
+	omap2_clk_writel(v, clk, dd->autoidle_reg);
 
 }
 
@@ -639,6 +639,9 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
 	struct clk_hw_omap *pclk = NULL;
 	struct clk *parent;
 
+	if (!parent_rate)
+		return 0;
+
 	/* Walk up the parents of clk, looking for a DPLL */
 	do {
 		do {
@@ -660,7 +663,7 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
 
 	WARN_ON(!dd->enable_mask);
 
-	v = __raw_readl(dd->control_reg) & dd->enable_mask;
+	v = omap2_clk_readl(pclk, dd->control_reg) & dd->enable_mask;
 	v >>= __ffs(dd->enable_mask);
 	if ((v != OMAP3XXX_EN_DPLL_LOCKED) || (dd->flags & DPLL_J_TYPE))
 		rate = parent_rate;
diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
index d28b0f7..52f9438 100644
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -42,7 +42,7 @@ int omap4_dpllmx_gatectrl_read(struct clk_hw_omap *clk)
 			OMAP4430_DPLL_CLKOUTX2_GATE_CTRL_MASK :
 			OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
 
-	v = __raw_readl(clk->clksel_reg);
+	v = omap2_clk_readl(clk, clk->clksel_reg);
 	v &= mask;
 	v >>= __ffs(mask);
 
@@ -61,10 +61,10 @@ void omap4_dpllmx_allow_gatectrl(struct clk_hw_omap *clk)
 			OMAP4430_DPLL_CLKOUTX2_GATE_CTRL_MASK :
 			OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
 
-	v = __raw_readl(clk->clksel_reg);
+	v = omap2_clk_readl(clk, clk->clksel_reg);
 	/* Clear the bit to allow gatectrl */
 	v &= ~mask;
-	__raw_writel(v, clk->clksel_reg);
+	omap2_clk_writel(v, clk, clk->clksel_reg);
 }
 
 void omap4_dpllmx_deny_gatectrl(struct clk_hw_omap *clk)
@@ -79,10 +79,10 @@ void omap4_dpllmx_deny_gatectrl(struct clk_hw_omap *clk)
 			OMAP4430_DPLL_CLKOUTX2_GATE_CTRL_MASK :
 			OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
 
-	v = __raw_readl(clk->clksel_reg);
+	v = omap2_clk_readl(clk, clk->clksel_reg);
 	/* Set the bit to deny gatectrl */
 	v |= mask;
-	__raw_writel(v, clk->clksel_reg);
+	omap2_clk_writel(v, clk, clk->clksel_reg);
 }
 
 const struct clk_hw_omap_ops clkhwops_omap4_dpllmx = {
@@ -140,7 +140,7 @@ unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
 	rate = omap2_get_dpll_rate(clk);
 
 	/* regm4xen adds a multiplier of 4 to DPLL calculations */
-	v = __raw_readl(dd->control_reg);
+	v = omap2_clk_readl(clk, dd->control_reg);
 	if (v & OMAP4430_DPLL_REGM4XEN_MASK)
 		rate *= OMAP4430_REGM4XEN_MULT;
 
-- 
1.7.9.5

