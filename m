From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 25/28] omap2 clock: Standardize DPLL rate recalculation with
	struct dpll_data
Date: Mon, 20 Aug 2007 03:54:12 -0600
Message-ID: <20070820095532.428776464@pwsan.com>
References: <20070820095347.933473149@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=add-dpll-params-to-24xx.h
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Introduce a new data structure, struct dpll_data, that contains DPLL
multiplier, divider, and autoidle information.  Update existing DPLL code
to use struct dpll_data.  The goal here is to set up something that will be
usable for OMAP3430 clock tree.  Note that this does not affect the SRAM DPLL 
assembly code - the DPLL register addresses are still hard-coded there.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c       |   61 ++++++++++++++++++++++++++------------
 arch/arm/mach-omap2/clock.h       |   10 ++++++
 include/asm-arm/arch-omap/clock.h |    9 +++++
 3 files changed, 61 insertions(+), 19 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -112,20 +112,38 @@ static void omap2_init_clksel_parent(str
 	return;
 }
 
-static u32 omap2_get_dpll_rate(struct clk * tclk)
+/* Returns the DPLL rate */
+static u32 omap2_get_dpll_rate(struct clk *clk)
+{
+ 	long long dpll_clk;
+ 	u32 dpll_mult, dpll_div, dpll;
+ 	const struct dpll_data *dd;
+
+ 	dd = clk->dpll_data;
+ 	/* REVISIT: What do we return on error? */
+ 	if (!dd)
+ 		return 0;
+
+ 	dpll = cm_read_reg(dd->mult_div1_reg);
+ 	dpll_mult = dpll & dd->mult_mask;
+ 	dpll_mult >>= convert_mask_to_shift(dd->mult_mask);
+ 	dpll_div = dpll & dd->div1_mask;
+ 	dpll_div >>= convert_mask_to_shift(dd->div1_mask);
+
+ 	dpll_clk = (long long)clk->parent->rate * dpll_mult;
+ 	do_div(dpll_clk, dpll_div + 1);
+
+	return dpll_clk;
+}
+
+/* This actually returns the rate of core_ck, not dpll_ck. */
+static u32 omap2_get_dpll_rate_24xx(struct clk *tclk)
 {
 	long long dpll_clk;
-	int dpll_mult, dpll_div, amult;
-	u32 dpll;
+	u8 amult;
 
-	dpll = cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
+	dpll_clk = omap2_get_dpll_rate(tclk);
 
-	dpll_mult = dpll & OMAP24XX_DPLL_MULT_MASK;
-	dpll_mult >>= OMAP24XX_DPLL_MULT_SHIFT;		/* 10 bits */
-	dpll_div = dpll & OMAP24XX_DPLL_DIV_MASK;
-	dpll_div >>= OMAP24XX_DPLL_DIV_SHIFT;		/* 4 bits */
-	dpll_clk = (long long)tclk->parent->rate * dpll_mult;
-	do_div(dpll_clk, dpll_div + 1);
 	amult = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
 	amult &= OMAP24XX_CORE_CLK_SRC_MASK;
 	dpll_clk *= amult;
@@ -396,7 +414,7 @@ static u32 omap2_dpll_round_rate(unsigne
 
 static void omap2_dpll_recalc(struct clk *clk)
 {
-	clk->rate = omap2_get_dpll_rate(clk);
+	clk->rate = omap2_get_dpll_rate_24xx(clk);
 
 	propagate_rate(clk);
 }
@@ -559,10 +577,11 @@ static int omap2_reprogram_dpll(struct c
 	u32 flags, cur_rate, low, mult, div, valid_rate, done_rate;
 	u32 bypass = 0;
 	struct prcm_config tmpset;
+	const struct dpll_data *dd;
 	int ret = -EINVAL;
 
 	local_irq_save(flags);
-	cur_rate = omap2_get_dpll_rate(&dpll_ck);
+	cur_rate = omap2_get_dpll_rate_24xx(&dpll_ck);
 	mult = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
 	mult &= OMAP24XX_CORE_CLK_SRC_MASK;
 
@@ -580,9 +599,13 @@ static int omap2_reprogram_dpll(struct c
 		else
 			low = curr_prcm_set->dpll_speed / 2;
 
-		tmpset.cm_clksel1_pll = cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
-		tmpset.cm_clksel1_pll &= ~(OMAP24XX_DPLL_MULT_MASK |
-					   OMAP24XX_DPLL_DIV_MASK);
+		dd = clk->dpll_data;
+		if (!dd)
+			goto dpll_exit;
+
+		tmpset.cm_clksel1_pll = cm_read_reg(dd->mult_div1_reg);
+		tmpset.cm_clksel1_pll &= ~(dd->mult_mask |
+					   dd->div1_mask);
 		div = ((curr_prcm_set->xtal_speed / 1000000) - 1);
 		tmpset.cm_clksel2_pll = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
 		tmpset.cm_clksel2_pll &= ~OMAP24XX_CORE_CLK_SRC_MASK;
@@ -595,8 +618,8 @@ static int omap2_reprogram_dpll(struct c
 			mult = (rate / 1000000);
 			done_rate = CORE_CLK_SRC_DPLL;
 		}
-		tmpset.cm_clksel1_pll |= (div << OMAP24XX_DPLL_DIV_SHIFT);
-		tmpset.cm_clksel1_pll |= (mult << OMAP24XX_DPLL_MULT_SHIFT);
+		tmpset.cm_clksel1_pll |= (div << convert_mask_to_shift(dd->mult_mask));
+		tmpset.cm_clksel1_pll |= (mult << convert_mask_to_shift(dd->div1_mask));
 
 		/* Worst case */
 		tmpset.base_sdrc_rfr = V24XX_SDRC_RFR_CTRL_BYPASS;
@@ -950,7 +973,7 @@ static int omap2_select_table_rate(struc
 	}
 
 	curr_prcm_set = prcm;
-	cur_rate = omap2_get_dpll_rate(&dpll_ck);
+	cur_rate = omap2_get_dpll_rate_24xx(&dpll_ck);
 
 	if (prcm->dpll_speed == cur_rate / 2) {
 		omap2_reprogram_sdrc(CORE_CLK_SRC_DPLL, 1);
@@ -1137,7 +1160,7 @@ int __init omap2_clk_init(void)
 	}
 
 	/* Check the MPU rate set by bootloader */
-	clkrate = omap2_get_dpll_rate(&dpll_ck);
+	clkrate = omap2_get_dpll_rate_24xx(&dpll_ck);
 	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
 		if (!(prcm->flags & cpu_mask))
 			continue;
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -632,9 +632,19 @@ static struct clk alt_ck = {		/* Typical
 /* REVISIT: Rate changes on dpll_ck trigger a full set change.	...
  * deal with this
  */
+
+static const struct dpll_data dpll_dd = {
+	.mult_div1_reg		= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+	.mult_mask		= OMAP24XX_DPLL_MULT_MASK,
+	.div1_mask		= OMAP24XX_DPLL_DIV_MASK,
+	.auto_idle_mask		= OMAP24XX_AUTO_DPLL_MASK,
+	.auto_idle_val		= 0x3, /* stop DPLL upon idle */
+};
+
 static struct clk dpll_ck = {
 	.name		= "dpll_ck",
 	.parent		= &sys_ck,		/* Can be func_32k also */
+	.dpll_data	= &dpll_dd,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_PROPAGATES | ALWAYS_ENABLED,
 	.recalc		= &omap2_dpll_recalc,
Index: linux-omap/include/asm-arm/arch-omap/clock.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/clock.h
+++ linux-omap/include/asm-arm/arch-omap/clock.h
@@ -29,6 +29,14 @@ struct clksel {
 	const struct clksel_rate *rates;
 };
 
+struct dpll_data {
+	void __iomem		*mult_div1_reg;
+	u32			mult_mask;
+	u32			div1_mask;
+	u32			auto_idle_mask;
+	u8			auto_idle_val;
+};
+
 #endif
 
 struct clk {
@@ -53,6 +61,7 @@ struct clk {
 	void __iomem		*clksel_reg;
 	u32			clksel_mask;
 	const struct clksel	*clksel;
+	const struct dpll_data	*dpll_data;
 #else
 	__u8			rate_offset;
 	__u8			src_offset;

-- 
