From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 11/18] omap2: convert clock.c to use new PRCM functions and
	symbolic constants
Date: Wed, 16 May 2007 18:11:43 -0600
Message-ID: <20070517005444.223716935@pwsan.com>
References: <20070517001132.652728079@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline;
	filename=0011-omap2-convert-clock.c-to-use-new-PRCM-functions-and.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Replace magic numbers, prcm-regs.h-sourced defines, and local defines
with the new PRCM register and register bit defines.  Also convert
register read/write code to use {cm,prm}_{read,write}_{,mod}_reg().

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |  269 ++++++++++++++++++++++++++-----------------
 1 files changed, 161 insertions(+), 108 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 1d02406..8cacfa4 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -29,13 +29,20 @@
 #include <asm/arch/sram.h>
 #include <asm/div64.h>
 
-#include "prcm-regs.h"
 #include "memory.h"
 #include "clock.h"
+#include "prm.h"
+#include "prm_regbits_24xx.h"
+#include "cm.h"
+#include "cm_regbits_24xx.h"
 #include "sdrc.h"
 
 #undef DEBUG
 
+/* SET_PERFORMANCE_LEVEL PARAMETERS */
+#define PRCM_HALF_SPEED		1
+#define PRCM_FULL_SPEED		2
+
 //#define DOWN_VARIABLE_DPLL 1			/* Experimental */
 
 static struct prcm_config *curr_prcm_set;
@@ -50,8 +57,9 @@ static struct clk *sclk;
 /* Recalculate SYST_CLK */
 static void omap2_sys_clk_recalc(struct clk * clk)
 {
-	u32 div = PRCM_CLKSRC_CTRL;
-	div &= (1 << 7) | (1 << 6);	/* Test if ext clk divided by 1 or 2 */
+	u32 div = prm_read_reg(OMAP24XX_PRCM_CLKSRC_CTRL);
+	/* Test if ext clk divided by 1 or 2 */
+	div &= (0x3 << OMAP_SYSCLKDIV_SHIFT);
 	div >>= clk->rate_offset;
 	clk->rate = (clk->parent->rate / div);
 	propagate_rate(clk);
@@ -61,12 +69,18 @@ static u32 omap2_get_dpll_rate(struct clk * tclk)
 {
 	long long dpll_clk;
 	int dpll_mult, dpll_div, amult;
+	u32 dpll;
+
+	dpll = cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
 
-	dpll_mult = (CM_CLKSEL1_PLL >> 12) & 0x03ff;	/* 10 bits */
-	dpll_div = (CM_CLKSEL1_PLL >> 8) & 0x0f;	/* 4 bits */
+	dpll_mult = dpll & OMAP24XX_DPLL_MULT_MASK;
+	dpll_mult >>= OMAP24XX_DPLL_MULT_SHIFT;		/* 10 bits */
+	dpll_div = dpll & OMAP24XX_DPLL_DIV_MASK;
+	dpll_div >>= OMAP24XX_DPLL_DIV_SHIFT;		/* 4 bits */
 	dpll_clk = (long long)tclk->parent->rate * dpll_mult;
 	do_div(dpll_clk, dpll_div + 1);
-	amult = CM_CLKSEL2_PLL & 0x3;
+	amult = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+	amult &= OMAP24XX_CORE_CLK_SRC_MASK;
 	dpll_clk *= amult;
 
 	return dpll_clk;
@@ -87,10 +101,16 @@ static void omap2_propagate_rate(struct clk * clk)
 
 static void omap2_set_osc_ck(int enable)
 {
+	u32 pcc;
+
+	pcc = prm_read_reg(OMAP24XX_PRCM_CLKSRC_CTRL);
+
 	if (enable)
-		PRCM_CLKSRC_CTRL &= ~(0x3 << 3);
+		prm_write_reg(pcc & ~OMAP_AUTOEXTCLKMODE_MASK,
+			      OMAP24XX_PRCM_CLKSRC_CTRL);
 	else
-		PRCM_CLKSRC_CTRL |= 0x3 << 3;
+		prm_write_reg(pcc | OMAP_AUTOEXTCLKMODE_MASK,
+			      OMAP24XX_PRCM_CLKSRC_CTRL);
 }
 
 /* Enable an APLL if off */
@@ -101,21 +121,22 @@ static void omap2_clk_fixed_enable(struct clk *clk)
 	if (clk->enable_bit == PARENT_CONTROLS_CLOCK)	/* Parent will do it */
 		return;
 
-	cval = CM_CLKEN_PLL;
+	cval = cm_read_mod_reg(PLL_MOD, CM_CLKEN);
 
 	if ((cval & (0x3 << clk->enable_bit)) == (0x3 << clk->enable_bit))
 		return;
 
 	cval &= ~(0x3 << clk->enable_bit);
 	cval |= (0x3 << clk->enable_bit);
-	CM_CLKEN_PLL = cval;
+	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
 
 	if (clk == &apll96_ck)
-		cval = (1 << 8);
+		cval = OMAP24XX_ST_96M_APLL;
 	else if (clk == &apll54_ck)
-		cval = (1 << 6);
+		cval = OMAP24XX_ST_54M_CLK;
 
-	while (!(CM_IDLEST_CKGEN & cval)) {		/* Wait for lock */
+	/* Wait for lock */
+	while (!(cm_read_mod_reg(PLL_MOD, CM_IDLEST) & cval)) {
 		++i;
 		udelay(1);
 		if (i == 100000) {
@@ -132,12 +153,12 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	int i;
 
 	reg = (unsigned long) clk->enable_reg;
-	if (reg == (unsigned long) &CM_FCLKEN1_CORE ||
-	    reg == (unsigned long) &CM_FCLKEN2_CORE)
-		other_reg = (reg & ~0xf0) | 0x10;
-	else if (reg == (unsigned long) &CM_ICLKEN1_CORE ||
-		 reg == (unsigned long) &CM_ICLKEN2_CORE)
-		other_reg = (reg & ~0xf0) | 0x00;
+	if (reg == (unsigned long)OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1) ||
+	    reg == (unsigned long)OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2))
+		other_reg = (reg & ~0xf0) | 0x10; /* CM_ICLKEN* */
+	else if (reg == (unsigned long)OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1) ||
+		 reg == (unsigned long)OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2))
+		other_reg = (reg & ~0xf0) | 0x00; /* CM_FCLKEN* */
 	else
 		return;
 
@@ -150,11 +171,11 @@ static void omap2_clk_wait_ready(struct clk *clk)
 	/* Check if both functional and interface clocks
 	 * are running. */
 	bit = 1 << clk->enable_bit;
-	if (!(__raw_readl(other_reg) & bit))
+	if (!(cm_read_reg((void __iomem *)other_reg) & bit))
 		return;
-	st_reg = (other_reg & ~0xf0) | 0x20;
+	st_reg = (other_reg & ~0xf0) | 0x20; /* CM_IDLEST* */
 	i = 0;
-	while (!(__raw_readl(st_reg) & bit)) {
+	while (!(cm_read_reg((void __iomem *)st_reg) & bit)) {
 		i++;
 		if (i == 100000) {
 			printk(KERN_ERR "Timeout enabling clock %s\n", clk->name);
@@ -186,14 +207,14 @@ static int _omap2_clk_enable(struct clk * clk)
 		return 0;
 	}
 
-	if (clk->enable_reg == (void __iomem *)&CM_CLKEN_PLL) {
+	if (clk->enable_reg == (void __iomem *)OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN)) {
 		omap2_clk_fixed_enable(clk);
 		return 0;
 	}
 
-	regval32 = __raw_readl(clk->enable_reg);
+	regval32 = cm_read_reg(clk->enable_reg);
 	regval32 |= (1 << clk->enable_bit);
-	__raw_writel(regval32, clk->enable_reg);
+	cm_write_reg(regval32, clk->enable_reg);
 	wmb();
 
 	omap2_clk_wait_ready(clk);
@@ -209,9 +230,9 @@ static void omap2_clk_fixed_disable(struct clk *clk)
 	if (clk->enable_bit == PARENT_CONTROLS_CLOCK)
 		return;		/* let parent off do it */
 
-	cval = CM_CLKEN_PLL;
+	cval = cm_read_mod_reg(PLL_MOD, CM_CLKEN);
 	cval &= ~(0x3 << clk->enable_bit);
-	CM_CLKEN_PLL = cval;
+	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
 }
 
 /* Disables clock without considering parent dependencies or use count */
@@ -227,14 +248,14 @@ static void _omap2_clk_disable(struct clk *clk)
 	if (clk->enable_reg == 0)
 		return;
 
-	if (clk->enable_reg == (void __iomem *)&CM_CLKEN_PLL) {
+	if (clk->enable_reg == (void __iomem *)OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN)) {
 		omap2_clk_fixed_disable(clk);
 		return;
 	}
 
-	regval32 = __raw_readl(clk->enable_reg);
+	regval32 = cm_read_reg(clk->enable_reg);
 	regval32 &= ~(1 << clk->enable_bit);
-	__raw_writel(regval32, clk->enable_reg);
+	cm_write_reg(regval32, clk->enable_reg);
 	wmb();
 }
 
@@ -277,9 +298,12 @@ static void omap2_clk_disable(struct clk *clk)
  */
 static u32 omap2_dpll_round_rate(unsigned long target_rate)
 {
-	u32 high, low;
+	u32 high, low, core_clk_src;
 
-	if ((CM_CLKSEL2_PLL & 0x3) == 1) {	/* DPLL clockout */
+	core_clk_src = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+	core_clk_src &= OMAP24XX_CORE_CLK_SRC_MASK;
+
+	if (core_clk_src == 1) {	/* DPLL clockout */
 		high = curr_prcm_set->dpll_speed * 2;
 		low = curr_prcm_set->dpll_speed;
 	} else {				/* DPLL clockout x 2 */
@@ -308,6 +332,7 @@ static u32 omap2_dpll_round_rate(unsigned long target_rate)
 static void omap2_clksel_recalc(struct clk * clk)
 {
 	u32 fixed = 0, div = 0;
+	u32 clksel1_core;
 
 	if (clk == &dpll_ck) {
 		clk->rate = omap2_get_dpll_rate(clk);
@@ -320,7 +345,10 @@ static void omap2_clksel_recalc(struct clk * clk)
 		fixed = 1;
 	}
 
-	if ((clk == &dss1_fck) && ((CM_CLKSEL1_CORE & (0x1f << 8)) == 0)) {
+	clksel1_core = cm_read_mod_reg(CORE_MOD, CM_CLKSEL1);
+
+	if ((clk == &dss1_fck) &&
+	    (clksel1_core & OMAP24XX_CLKSEL_DSS1_MASK) == 0) {
 		clk->rate = sys_ck.rate;
 		return;
 	}
@@ -471,7 +499,7 @@ static u32 omap2_reprogram_sdrc(u32 level, u32 force)
 
 	if (level == PRCM_HALF_SPEED) {
 		local_irq_save(flags);
-		PRCM_VOLTSETUP = 0xffff;
+		prm_write_reg(0xffff, OMAP24XX_PRCM_VOLTSETUP);
 		omap2_sram_reprogram_sdrc(PRCM_HALF_SPEED,
 					  slow_dll_ctrl, m_type);
 		curr_perf_level = PRCM_HALF_SPEED;
@@ -479,7 +507,7 @@ static u32 omap2_reprogram_sdrc(u32 level, u32 force)
 	}
 	if (level == PRCM_FULL_SPEED) {
 		local_irq_save(flags);
-		PRCM_VOLTSETUP = 0xffff;
+		prm_write_reg(0xffff, OMAP24XX_PRCM_VOLTSETUP);
 		omap2_sram_reprogram_sdrc(PRCM_FULL_SPEED,
 					  fast_dll_ctrl, m_type);
 		curr_perf_level = PRCM_FULL_SPEED;
@@ -498,7 +526,8 @@ static int omap2_reprogram_dpll(struct clk * clk, unsigned long rate)
 
 	local_irq_save(flags);
 	cur_rate = omap2_get_dpll_rate(&dpll_ck);
-	mult = CM_CLKSEL2_PLL & 0x3;
+	mult = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+	mult &= OMAP24XX_CORE_CLK_SRC_MASK;
 
 	if ((rate == (cur_rate / 2)) && (mult == 2)) {
 		omap2_reprogram_sdrc(PRCM_HALF_SPEED, 1);
@@ -509,16 +538,17 @@ static int omap2_reprogram_dpll(struct clk * clk, unsigned long rate)
 		if (valid_rate != rate)
 			goto dpll_exit;
 
-		if ((CM_CLKSEL2_PLL & 0x3) == 1)
+		if (mult == 1)
 			low = curr_prcm_set->dpll_speed;
 		else
 			low = curr_prcm_set->dpll_speed / 2;
 
-		tmpset.cm_clksel1_pll = CM_CLKSEL1_PLL;
+		/* REVISIT: This sets several reserved bits? */
+		tmpset.cm_clksel1_pll = cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
 		tmpset.cm_clksel1_pll &= ~(0x3FFF << 8);
 		div = ((curr_prcm_set->xtal_speed / 1000000) - 1);
-		tmpset.cm_clksel2_pll = CM_CLKSEL2_PLL;
-		tmpset.cm_clksel2_pll &= ~0x3;
+		tmpset.cm_clksel2_pll = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+		tmpset.cm_clksel2_pll &= ~OMAP24XX_CORE_CLK_SRC_MASK;
 		if (rate > low) {
 			tmpset.cm_clksel2_pll |= 0x2;
 			mult = ((rate / 2) / 1000000);
@@ -528,7 +558,8 @@ static int omap2_reprogram_dpll(struct clk * clk, unsigned long rate)
 			mult = (rate / 1000000);
 			done_rate = PRCM_HALF_SPEED;
 		}
-		tmpset.cm_clksel1_pll |= ((div << 8) | (mult << 12));
+		tmpset.cm_clksel1_pll |= (div << OMAP24XX_DPLL_DIV_SHIFT);
+		tmpset.cm_clksel1_pll |= (mult << OMAP24XX_DPLL_MULT_SHIFT);
 
 		/* Worst case */
 		tmpset.base_sdrc_rfr = V24XX_SDRC_RFR_CTRL_BYPASS;
@@ -617,74 +648,87 @@ static u32 omap2_get_clksel(u32 *div_sel, u32 *field_mask,
 {
 	int ret = ~0;
 	u32 reg_val, div_off;
-	u32 div_addr = 0;
+	void __iomem *div_addr = 0;
 	u32 mask = ~0;
 
 	div_off = clk->rate_offset;
 
 	switch ((*div_sel & SRC_RATE_SEL_MASK)) {
 	case CM_MPU_SEL1:
-		div_addr = (u32)&CM_CLKSEL_MPU;
-		mask = 0x1f;
+		div_addr = OMAP_CM_REGADDR(MPU_MOD, CM_CLKSEL);
+		mask = OMAP24XX_CLKSEL_MPU_MASK;
 		break;
 	case CM_DSP_SEL1:
-		div_addr = (u32)&CM_CLKSEL_DSP;
+		div_addr = OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL);
 		if (cpu_is_omap2420()) {
-			if ((div_off == 0) || (div_off == 8))
-				mask = 0x1f;
-			else if (div_off == 5)
-				mask = 0x3;
+			if (div_off == OMAP24XX_CLKSEL_DSP_SHIFT)
+				mask = OMAP24XX_CLKSEL_DSP_MASK;
+			else if (div_off == OMAP2420_CLKSEL_IVA_SHIFT)
+				mask = OMAP2420_CLKSEL_IVA_MASK;
+			else if (div_off == OMAP24XX_CLKSEL_DSP_IF_SHIFT)
+				mask = OMAP24XX_CLKSEL_DSP_IF_MASK;
 		} else if (cpu_is_omap2430()) {
-			if (div_off == 0)
-				mask = 0x1f;
-			else if (div_off == 5)
-				mask = 0x3;
+			if (div_off == OMAP24XX_CLKSEL_DSP_SHIFT)
+				mask = OMAP24XX_CLKSEL_DSP_MASK;
+			else if (div_off == OMAP24XX_CLKSEL_DSP_IF_SHIFT)
+				mask = OMAP24XX_CLKSEL_DSP_IF_MASK;
 		}
-		break;
 	case CM_GFX_SEL1:
-		div_addr = (u32)&CM_CLKSEL_GFX;
-		if (div_off == 0)
-			mask = 0x7;
+		div_addr = OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL);
+		if (div_off == OMAP_CLKSEL_GFX_SHIFT)
+			mask = OMAP_CLKSEL_GFX_MASK;
 		break;
 	case CM_MODEM_SEL1:
-		div_addr = (u32)&CM_CLKSEL_MDM;
-		if (div_off == 0)
-			mask = 0xf;
+		div_addr = OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_CLKSEL);
+		if (div_off == OMAP2430_CLKSEL_MDM_SHIFT)
+			mask = OMAP2430_CLKSEL_MDM_MASK;
 		break;
 	case CM_SYSCLKOUT_SEL1:
-		div_addr = (u32)&PRCM_CLKOUT_CTRL;
-		if ((div_off == 3) || (div_off == 11))
-			mask= 0x3;
+		div_addr = OMAP24XX_PRCM_CLKOUT_CTRL;
+		if (div_off == OMAP24XX_CLKOUT_DIV_SHIFT)
+			mask = OMAP24XX_CLKOUT_DIV_MASK;
+		else if (div_off == OMAP2420_CLKOUT2_DIV_SHIFT)
+			mask = OMAP2420_CLKOUT2_DIV_MASK;
 		break;
 	case CM_CORE_SEL1:
-		div_addr = (u32)&CM_CLKSEL1_CORE;
+		div_addr = OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1);
 		switch (div_off) {
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
+		case OMAP24XX_CLKSEL_L3_SHIFT:
+			mask = OMAP24XX_CLKSEL_L3_MASK;
+			break;
+		case OMAP24XX_CLKSEL_L4_SHIFT:
+			mask = OMAP24XX_CLKSEL_L4_MASK;
+			break;
+		case OMAP24XX_CLKSEL_DSS1_SHIFT:
+			mask = OMAP24XX_CLKSEL_DSS1_MASK;
+			break;
+		case OMAP24XX_CLKSEL_DSS2_SHIFT:
+			mask = OMAP24XX_CLKSEL_DSS2_MASK;
+			break;
+		case OMAP2420_CLKSEL_VLYNQ_SHIFT:
+			mask = OMAP2420_CLKSEL_VLYNQ_MASK;
+			break;
+		case OMAP24XX_CLKSEL_SSI_SHIFT:
+			mask = OMAP24XX_CLKSEL_SSI_MASK;
+			break;
+		case OMAP24XX_CLKSEL_USB_SHIFT:
+			mask = OMAP24XX_CLKSEL_USB_MASK;
+			break;
 		}
 	}
 
-	*field_mask = mask;
+	*field_mask = (mask >> div_off);
 
 	if (unlikely(mask == ~0))
 		div_addr = 0;
 
-	*div_sel = div_addr;
+	*div_sel = (u32)div_addr;
 
 	if (unlikely(div_addr == 0))
 		return ret;
 
 	/* Isolate field */
-	reg_val = __raw_readl((void __iomem *)div_addr) & (mask << div_off);
+	reg_val = cm_read_reg(div_addr) & mask;
 
 	/* Normalize back to divider value */
 	reg_val >>= div_off;
@@ -763,15 +807,16 @@ static int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 
 		reg = (void __iomem *)div_sel;
 
-		reg_val = __raw_readl(reg);
+		reg_val = cm_read_reg(reg);
 		reg_val &= ~(field_mask << div_off);
 		reg_val |= (field_val << div_off);
-		__raw_writel(reg_val, reg);
+		cm_write_reg(reg_val, reg);
 		wmb();
 		clk->rate = clk->parent->rate / field_val;
 
 		if (clk->flags & DELAYED_APP) {
-			__raw_writel(0x1, (void __iomem *)&PRCM_CLKCFG_CTRL);
+			prm_write_reg(OMAP24XX_VALID_CONFIG,
+				      OMAP24XX_PRCM_CLKCFG_CTRL);
 			wmb();
 		}
 		ret = 0;
@@ -788,26 +833,31 @@ static int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 static u32 omap2_get_src_field(u32 *type_to_addr, u32 reg_offset,
 			       struct clk *src_clk, u32 *field_mask)
 {
-	u32 val = ~0, src_reg_addr = 0, mask = 0;
+	u32 val = ~0, mask = 0;
+	void __iomem *src_reg_addr = 0;
 
 	/* Find target control register.*/
 	switch ((*type_to_addr & SRC_RATE_SEL_MASK)) {
 	case CM_CORE_SEL1:
-		src_reg_addr = (u32)&CM_CLKSEL1_CORE;
-		if (reg_offset == 13) {			/* DSS2_fclk */
-			mask = 0x1;
+		src_reg_addr = OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1);
+		if (reg_offset == OMAP24XX_CLKSEL_DSS2_SHIFT) {
+			mask = OMAP24XX_CLKSEL_DSS2_MASK;
+			mask >>= OMAP24XX_CLKSEL_DSS2_SHIFT;
 			if (src_clk == &sys_ck)
 				val = 0;
 			if (src_clk == &func_48m_ck)
 				val = 1;
-		} else if (reg_offset == 8) {		/* DSS1_fclk */
-			mask = 0x1f;
+		} else if (reg_offset == OMAP24XX_CLKSEL_DSS1_SHIFT) {
+			mask = OMAP24XX_CLKSEL_DSS1_MASK;
+			mask >>= OMAP24XX_CLKSEL_DSS1_SHIFT;
 			if (src_clk == &sys_ck)
 				val = 0;
 			else if (src_clk == &core_ck)	/* divided clock */
 				val = 0x10;		/* rate needs fixing */
-		} else if ((reg_offset == 15) && cpu_is_omap2420()){ /*vlnyq*/
-			mask = 0x1F;
+		} else if ((reg_offset == OMAP2420_CLKSEL_VLYNQ_SHIFT) &&
+			   cpu_is_omap2420()){
+			mask = OMAP2420_CLKSEL_VLYNQ_MASK;
+			mask >>= OMAP2420_CLKSEL_VLYNQ_SHIFT;
 			if(src_clk == &func_96m_ck)
 				val = 0;
 			else if (src_clk == &core_ck)
@@ -815,7 +865,7 @@ static u32 omap2_get_src_field(u32 *type_to_addr, u32 reg_offset,
 		}
 		break;
 	case CM_CORE_SEL2:
-		src_reg_addr = (u32)&CM_CLKSEL2_CORE;
+		src_reg_addr = OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2);
 		mask = 0x3;
 		if (src_clk == &func_32k_ck)
 			val = 0x0;
@@ -825,7 +875,7 @@ static u32 omap2_get_src_field(u32 *type_to_addr, u32 reg_offset,
 			val = 0x2;
 		break;
 	case CM_WKUP_SEL1:
-		src_reg_addr = (u32)&CM_CLKSEL_WKUP;
+		src_reg_addr = OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL);
 		mask = 0x3;
 		if (src_clk == &func_32k_ck)
 			val = 0x0;
@@ -835,7 +885,7 @@ static u32 omap2_get_src_field(u32 *type_to_addr, u32 reg_offset,
 			val = 0x2;
 		break;
 	case CM_PLL_SEL1:
-		src_reg_addr = (u32)&CM_CLKSEL1_PLL;
+		src_reg_addr = OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1);
 		mask = 0x1;
 		if (reg_offset == 0x3) {
 			if (src_clk == &apll96_ck)
@@ -851,7 +901,7 @@ static u32 omap2_get_src_field(u32 *type_to_addr, u32 reg_offset,
 		}
 		break;
 	case CM_PLL_SEL2:
-		src_reg_addr = (u32)&CM_CLKSEL2_PLL;
+		src_reg_addr = OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2);
 		mask = 0x3;
 		if (src_clk == &func_32k_ck)
 			val = 0x0;
@@ -859,7 +909,7 @@ static u32 omap2_get_src_field(u32 *type_to_addr, u32 reg_offset,
 			val = 0x2;
 		break;
 	case CM_SYSCLKOUT_SEL1:
-		src_reg_addr = (u32)&PRCM_CLKOUT_CTRL;
+		src_reg_addr = OMAP24XX_PRCM_CLKOUT_CTRL;
 		mask = 0x3;
 		if (src_clk == &dpll_ck)
 			val = 0;
@@ -875,7 +925,7 @@ static u32 omap2_get_src_field(u32 *type_to_addr, u32 reg_offset,
 	if (val == ~0)			/* Catch errors in offset */
 		*type_to_addr = 0;
 	else
-		*type_to_addr = src_reg_addr;
+		*type_to_addr = (u32)src_reg_addr;
 	*field_mask = mask;
 
 	return val;
@@ -912,7 +962,8 @@ static int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 		wmb();
 
 		if (clk->flags & DELAYED_APP) {
-			__raw_writel(0x1, (void __iomem *)&PRCM_CLKCFG_CTRL);
+			prm_write_reg(OMAP24XX_VALID_CONFIG,
+				      OMAP24XX_PRCM_CLKCFG_CTRL);
 			wmb();
 		}
 		if (clk->usecount > 0)
@@ -990,23 +1041,25 @@ static int omap2_select_table_rate(struct clk * clk, unsigned long rate)
 		if (prcm->dpll_speed == prcm->xtal_speed)
 			bypass = 1;
 
-		if ((prcm->cm_clksel2_pll & 0x3) == 2)
+		if ((prcm->cm_clksel2_pll & OMAP24XX_CORE_CLK_SRC_MASK) == 2)
 			done_rate = PRCM_FULL_SPEED;
 		else
 			done_rate = PRCM_HALF_SPEED;
 
 		/* MPU divider */
-		CM_CLKSEL_MPU = prcm->cm_clksel_mpu;
+		cm_write_mod_reg(prcm->cm_clksel_mpu, MPU_MOD, CM_CLKSEL);
 
 		/* dsp + iva1 div(2420), iva2.1(2430) */
-		CM_CLKSEL_DSP = prcm->cm_clksel_dsp;
+		cm_write_mod_reg(prcm->cm_clksel_dsp,
+				 OMAP24XX_DSP_MOD, CM_CLKSEL);
 
-		CM_CLKSEL_GFX = prcm->cm_clksel_gfx;
+		cm_write_mod_reg(prcm->cm_clksel_gfx, GFX_MOD, CM_CLKSEL);
 
 		/* Major subsystem dividers */
-		CM_CLKSEL1_CORE = prcm->cm_clksel1_core;
+		cm_write_mod_reg(prcm->cm_clksel1_core, CORE_MOD, CM_CLKSEL1);
 		if (cpu_is_omap2430())
-			CM_CLKSEL_MDM = prcm->cm_clksel_mdm;
+			cm_write_mod_reg(prcm->cm_clksel_mdm,
+					 OMAP2430_MDM_MOD, CM_CLKSEL);
 
 		/* x2 to enter init_mem */
 		omap2_reprogram_sdrc(PRCM_FULL_SPEED, 1);
@@ -1033,7 +1086,7 @@ static void __init omap2_clk_disable_unused(struct clk *clk)
 {
 	u32 regval32;
 
-	regval32 = __raw_readl(clk->enable_reg);
+	regval32 = cm_read_reg(clk->enable_reg);
 	if ((regval32 & (1 << clk->enable_bit)) == 0)
 		return;
 
@@ -1057,9 +1110,9 @@ static void __init omap2_get_crystal_rate(struct clk *osc, struct clk *sys)
 {
 	u32 div, aplls, sclk = 13000000;
 
-	aplls = CM_CLKSEL1_PLL;
-	aplls &= ((1 << 23) | (1 << 24) | (1 << 25));
-	aplls >>= 23;			/* Isolate field, 0,2,3 */
+	aplls = cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
+	aplls &= OMAP24XX_APLLS_CLKIN_MASK;
+	aplls >>= OMAP24XX_APLLS_CLKIN_SHIFT;	/* Isolate field, 0,2,3 */
 
 	if (aplls == 0)
 		sclk = 19200000;
@@ -1068,8 +1121,8 @@ static void __init omap2_get_crystal_rate(struct clk *osc, struct clk *sys)
 	else if (aplls == 3)
 		sclk = 12000000;
 
-	div = PRCM_CLKSRC_CTRL;
-	div &= ((1 << 7) | (1 << 6));
+	div = prm_read_reg(OMAP24XX_PRCM_CLKSRC_CTRL);
+	div &= OMAP_SYSCLKDIV_MASK;
 	div >>= sys->rate_offset;
 
 	osc->rate = sclk * div;
-- 
1.5.1.3

-- 
