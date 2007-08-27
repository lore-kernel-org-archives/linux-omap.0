From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 09/27] omap2 clock: convert omap2_clksel_round_rate to use
	new clksel struct
Date: Mon, 27 Aug 2007 02:39:05 -0600
Message-ID: <20070827084122.960009635@pwsan.com>
References: <20070827083856.549249288@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=convert_clksel_round_rate.patch
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

Convert omap2_clksel_round_rate() to use the new clksel struct data.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |   98 ++++++++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 48 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c	2007-08-27 02:19:30.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.c	2007-08-27 02:19:32.000000000 -0600
@@ -87,8 +87,6 @@
 static struct clk *sclk;
 static u8 cpu_mask;
 
-static u32 sysclkout_div[] = {1, 2, 4, 8, 16};
-
 /*-------------------------------------------------------------------------
  * Omap2 specific clock functions
  *-------------------------------------------------------------------------*/
@@ -530,62 +528,66 @@
 	return clks;
 }
 
-/*
- * Find divisor for the given clock and target rate.
+/**
+ * omap2_clksel_round_rate - find divisor for the given clock and target rate.
+ * @clk: OMAP struct clk to use
+ * @target_rate: desired clock rate
+ * @new_div: ptr to where we should store the divisor
  *
+ * Finds 'best' divider value in an array based on the source and target
+ * rates.  The divider array must be sorted with smallest divider first.
  * Note that this will not work for clocks which are part of CONFIG_PARTICIPANT,
  * they are only settable as part of virtual_prcm set.
+ *
+ * Returns the rounded clock rate or returns 0xffffffff on error.
  */
-static u32 omap2_clksel_round_rate(struct clk *tclk, u32 target_rate,
-	u32 *new_div)
+static u32 omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate,
+				   u32 *new_div)
 {
-	u32 gfx_div[] = {2, 3, 4};
-	u32 dss1_div[] = {1, 2, 3, 4, 5, 6, 8, 9, 12, 16};
-	u32 vlynq_div[] = {1, 2, 3, 4, 6, 8, 9, 12, 16, 18};
-	u32 best_div = ~0, asize = 0;
-	u32 *div_array = NULL;
+	unsigned long test_rate;
+	const struct clksel *clks;
+	const struct clksel_rate *clkr;
+	u32 last_div = 0;
 
-	switch (tclk->flags & SRC_RATE_SEL_MASK) {
-	case CM_GFX_SEL1:
-		asize = ARRAY_SIZE(gfx_div);
-		div_array = gfx_div;
-		break;
-	case CM_PLL_SEL1:
-		return omap2_dpll_round_rate(target_rate);
-	case CM_SYSCLKOUT_SEL1:
-		asize = ARRAY_SIZE(sysclkout_div);
-		div_array = sysclkout_div;
-		break;
-	case CM_CORE_SEL1:
-		if (tclk == &dss1_fck) {
-			if (tclk->parent == &core_ck) {
-				asize = ARRAY_SIZE(dss1_div);
-				div_array = dss1_div;
-			} else {
-				*new_div = 0; /* fixed clk */
-				return(tclk->parent->rate);
-			}
-		} else if ((tclk == &vlynq_fck) && cpu_is_omap2420()) {
-			if (tclk->parent == &core_ck) {
-				asize = ARRAY_SIZE(vlynq_div);
-				div_array = vlynq_div;
-			} else {
-				*new_div = 0; /* fixed clk */
-				return (tclk->parent->rate);
-			}
-		}
-		break;
+	printk(KERN_INFO "clock: clksel_round_rate for %s target_rate %ld\n",
+	       clk->name, target_rate);
+
+	*new_div = 1;
+
+	clks = omap2_get_clksel_by_parent(clk, clk->parent);
+	if (clks == NULL)
+		return ~0;
+
+	for (clkr = clks->rates; clkr->div; clkr++) {
+		if (!(clkr->flags & cpu_mask))
+		    continue;
+
+		/* Sanity check */
+		if (clkr->div <= last_div)
+			printk(KERN_ERR "clock: clksel_rate table not sorted "
+			       "for clock %s", clk->name);
+
+		last_div = clkr->div;
+
+		test_rate = clk->parent->rate / clkr->div;
+
+		if (test_rate <= target_rate)
+			break; /* found it */
 	}
 
-	best_div = omap2_divider_from_table(asize, div_array,
-					    tclk->parent->rate, target_rate);
-	if (best_div == ~0) {
-		*new_div = 1;
-		return best_div; /* signal error */
+	if (!clkr->div) {
+		printk(KERN_ERR "clock: Could not find divisor for target "
+		       "rate %ld for clock %s parent %s\n", target_rate,
+		       clk->name, clk->parent->name);
+		return ~0;
 	}
 
-	*new_div = best_div;
-	return (tclk->parent->rate / best_div);
+	*new_div = clkr->div;
+
+	printk(KERN_INFO "clock: new_div = %d, new_rate = %ld\n", *new_div,
+	       (clk->parent->rate / clkr->div));
+
+	return (clk->parent->rate / clkr->div);
 }
 
 /* Given a clock and a rate apply a clock specific rounding function */

-- 
