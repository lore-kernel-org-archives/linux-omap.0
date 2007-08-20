From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 17/28] omap2 clock: use the struct clk round_rate field for
	clksel rate rounding code
Date: Mon, 20 Aug 2007 03:54:04 -0600
Message-ID: <20070820095531.641340970@pwsan.com>
References: <20070820095347.933473149@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=split_round_rate.patch
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

The OMAP clock framework struct clk contains a field, .round_rate,
that is intended to contain a function pointer to rate rounding code.
Take advantage of it by converting all clksel clocks' round_rate field
to point to omap2_clksel_round_rate().  Rename the existing
omap2_clksel_round_rate() to omap2_clksel_round_rate_div(), to signify
that it returns divisor information as well, and set up
omap2_clksel_round_rate() as a wrapper for the clock framework to use.
Simplify omap2_clk_round_rate() accordingly.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |   42 ++++++++++++++++++++++++++++++------------
 arch/arm/mach-omap2/clock.h |   21 +++++++++++++++++++++
 2 files changed, 51 insertions(+), 12 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -471,7 +471,7 @@ const static struct clksel *omap2_get_cl
 }
 
 /**
- * omap2_clksel_round_rate - find divisor for the given clock and target rate.
+ * omap2_clksel_round_rate_div - find divisor for the given clock and rate
  * @clk: OMAP struct clk to use
  * @target_rate: desired clock rate
  * @new_div: ptr to where we should store the divisor
@@ -483,15 +483,16 @@ const static struct clksel *omap2_get_cl
  *
  * Returns the rounded clock rate or returns 0xffffffff on error.
  */
-static u32 omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate,
-				   u32 *new_div)
+static u32 omap2_clksel_round_rate_div(struct clk *clk,
+				       unsigned long target_rate,
+				       u32 *new_div)
 {
 	unsigned long test_rate;
 	const struct clksel *clks;
 	const struct clksel_rate *clkr;
 	u32 last_div = 0;
 
-	printk(KERN_INFO "clock: clksel_round_rate for %s target_rate %ld\n",
+	printk(KERN_INFO "clock: clksel_round_rate_div: %s target_rate %ld\n",
 	       clk->name, target_rate);
 
 	*new_div = 1;
@@ -532,20 +533,37 @@ static u32 omap2_clksel_round_rate(struc
 	return (clk->parent->rate / clkr->div);
 }
 
-/* Given a clock and a rate apply a clock specific rounding function */
-static long omap2_clk_round_rate(struct clk *clk, unsigned long rate)
+/**
+ * omap2_clksel_round_rate - find rounded rate for the given clock and rate
+ * @clk: OMAP struct clk to use
+ * @target_rate: desired clock rate
+ *
+ * Compatibility wrapper for OMAP clock framework
+ * Finds best target rate based on the source clock and possible dividers.
+ * rates. The divider array must be sorted with smallest divider first.
+ * Note that this will not work for clocks which are part of CONFIG_PARTICIPANT,
+ * they are only settable as part of virtual_prcm set.
+ *
+ * Returns the rounded clock rate or returns 0xffffffff on error.
+ */
+static long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate)
 {
-	u32 new_div = 0;
+	u32 new_div;
 
-	if (clk->flags & RATE_FIXED)
-		return clk->rate;
+	return omap2_clksel_round_rate_div(clk, target_rate, &new_div);
+}
 
-	if (clk->flags & RATE_CKCTL)
-		return omap2_clksel_round_rate(clk, rate, &new_div);
 
+/* Given a clock and a rate apply a clock specific rounding function */
+static long omap2_clk_round_rate(struct clk *clk, unsigned long rate)
+{
 	if (clk->round_rate != 0)
 		return clk->round_rate(clk, rate);
 
+	if (clk->flags & RATE_FIXED)
+		printk(KERN_ERR "clock: generic omap2_clk_round_rate called "
+		       "on fixed-rate clock %s\n", clk->name);
+
 	return clk->rate;
 }
 
@@ -780,7 +798,7 @@ static int omap2_clk_set_rate(struct clk
 		if (clk == &dpll_ck)
 			return omap2_reprogram_dpll(clk, rate);
 
-		validrate = omap2_clksel_round_rate(clk, rate, &new_div);
+		validrate = omap2_clksel_round_rate_div(clk, rate, &new_div);
 		if (validrate != rate)
 			return ret;
 
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -39,6 +39,8 @@ static u32 omap2_clksel_to_divisor(struc
 static u32 omap2_divisor_to_clksel(struct clk *clk, u32 div);
 static void omap2_dpll_recalc(struct clk *clk);
 static void omap2_fixed_divisor_recalc(struct clk *clk);
+static long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate);
+
 
 /* Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
  * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,CM_CLKSEL_DSP
@@ -736,6 +738,7 @@ static struct clk func_96m_ck = {
 	.clksel_mask	= OMAP2430_96M_SOURCE,
 	.clksel		= func_96m_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate
 };
 
 /* func_48m_ck */
@@ -767,6 +770,7 @@ static struct clk func_48m_ck = {
 	.clksel_mask	= OMAP24XX_48M_SOURCE,
 	.clksel		= func_48m_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate
 };
 
 static struct clk func_12m_ck = {
@@ -861,6 +865,7 @@ static struct clk sys_clkout = {
 	.clksel_mask	= OMAP24XX_CLKOUT_DIV_MASK,
 	.clksel		= sys_clkout_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate
 };
 
 /* In 2430, new in 2420 ES2 */
@@ -940,6 +945,7 @@ static struct clk mpu_ck = {	/* Control 
 	.clksel_mask	= OMAP24XX_CLKSEL_MPU_MASK,
 	.clksel		= mpu_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate     = &omap2_clksel_round_rate
 };
 
 /*
@@ -981,6 +987,7 @@ static struct clk iva2_1_fck = {
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_MASK,
 	.clksel		= iva2_1_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate
 };
 
 /* iva2_1_ick */
@@ -1005,6 +1012,8 @@ static struct clk iva2_1_ick = {
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_IF_MASK,
 	.clksel		= iva2_1_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate
+
 };
 
 /*
@@ -1040,6 +1049,7 @@ static struct clk dsp_fck = {
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_MASK,
 	.clksel		= dsp_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate
 };
 
 static const struct clksel_rate dsp_ick_core_rates[] = {
@@ -1094,6 +1104,7 @@ static struct clk iva1_ifck = {
 	.clksel_mask	= OMAP2420_CLKSEL_IVA_MASK,
 	.clksel		= iva1_ifck_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate
 };
 
 /* IVA1 mpu/int/i/f clocks are /2 of parent */
@@ -1153,6 +1164,7 @@ static struct clk core_l3_ck = {	/* Used
 	.clksel_mask	= OMAP24XX_CLKSEL_L3_MASK,
 	.clksel		= core_l3_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate
 };
 
 /* usb_l4_ick */
@@ -1180,6 +1192,7 @@ static struct clk usb_l4_ick = {	/* FS-U
 	.clksel_mask	= OMAP24XX_CLKSEL_USB_MASK,
 	.clksel		= usb_l4_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate
 };
 
 /*
@@ -1217,6 +1230,7 @@ static struct clk ssi_ssr_sst_fck = {
 	.clksel_mask	= OMAP24XX_CLKSEL_SSI_MASK,
 	.clksel		= ssi_ssr_sst_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate
 };
 
 /*
@@ -1260,6 +1274,7 @@ static struct clk gfx_3d_fck = {
 	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
 	.clksel		= gfx_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate
 };
 
 static struct clk gfx_2d_fck = {
@@ -1273,6 +1288,7 @@ static struct clk gfx_2d_fck = {
 	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
 	.clksel		= gfx_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate
 };
 
 static struct clk gfx_ick = {
@@ -1315,6 +1331,7 @@ static struct clk mdm_ick = {		/* used b
 	.clksel_mask	= OMAP2430_CLKSEL_MDM_MASK,
 	.clksel		= mdm_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate
 };
 
 static struct clk mdm_osc_ck = {
@@ -1354,6 +1371,7 @@ static struct clk l4_ck = {		/* used bot
 	.clksel_mask	= OMAP24XX_CLKSEL_L4_MASK,
 	.clksel		= l4_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate
 };
 
 static struct clk ssi_l4_ick = {
@@ -1421,6 +1439,7 @@ static struct clk dss1_fck = {
 	.clksel_mask	= OMAP24XX_CLKSEL_DSS1_MASK,
 	.clksel		= dss1_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate
 };
 
 static const struct clksel_rate dss2_fck_sys_rates[] = {
@@ -1511,6 +1530,7 @@ static struct clk gpt1_fck = {
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT1_MASK,
 	.clksel		= gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate
 };
 
 static struct clk gpt2_ick = {
@@ -2297,6 +2317,7 @@ static struct clk vlynq_fck = {
 	.clksel_mask	= OMAP2420_CLKSEL_VLYNQ_MASK,
 	.clksel		= vlynq_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate
 };
 
 static struct clk sdrc_ick = {

-- 
