From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 18/27] omap2 clock: separate clksel set_rate code into its
	own function
Date: Mon, 27 Aug 2007 02:39:14 -0600
Message-ID: <20070827084123.871547313@pwsan.com>
References: <20070827083856.549249288@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=split_set_rate.patch
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

Simplify omap2_clk_set_rate() by separating out the clksel set_rate code into
its own function, omap2_clksel_set_rate().  Clksel clocks use this function
by placing its function pointer in their .set_rate fields.  Convert 
existing clksel clocks accordingly.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |   75 ++++++++++++++++++++++++--------------------
 arch/arm/mach-omap2/clock.h |   65 ++++++++++++++++++++++++++------------
 2 files changed, 87 insertions(+), 53 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c	2007-08-27 02:19:40.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.c	2007-08-27 02:19:40.000000000 -0600
@@ -787,46 +787,55 @@
 	return omap2_clksel_to_divisor(clk, field_val);
 }
 
+static int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
+{
+	u32 field_mask, field_val, reg_val, validrate, new_div = 0;
+	void __iomem *div_addr;
+
+	validrate = omap2_clksel_round_rate_div(clk, rate, &new_div);
+	if (validrate != rate)
+		return -EINVAL;
+
+	div_addr = omap2_get_clksel(clk, &field_mask);
+	if (div_addr == 0)
+		return -EINVAL;
+
+	field_val = omap2_divisor_to_clksel(clk, new_div);
+	if (field_val == ~0)
+		return -EINVAL;
+
+	reg_val = cm_read_reg(div_addr);
+	reg_val &= ~field_mask;
+	reg_val |= (field_val << mask_to_shift(field_mask));
+	cm_write_reg(reg_val, div_addr);
+	wmb();
+
+	clk->rate = clk->parent->rate / new_div;
+
+	if (clk->flags & DELAYED_APP) {
+		prm_write_reg(OMAP24XX_VALID_CONFIG, OMAP24XX_PRCM_CLKCFG_CTRL);
+		wmb();
+	}
+
+	return 0;
+}
+
+
 /* Set the clock rate for a clock source */
 static int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
 {
 	int ret = -EINVAL;
-	u32 field_mask, field_val, reg_val, new_div = 0;
-	unsigned long validrate;
-	void __iomem *div_addr;
 
-	if (!(clk->flags & CONFIG_PARTICIPANT) && (clk->flags & RATE_CKCTL)) {
-		if (clk == &dpll_ck)
-			return omap2_reprogram_dpll(clk, rate);
-
-		validrate = omap2_clksel_round_rate_div(clk, rate, &new_div);
-		if (validrate != rate)
-			return ret;
-
-		div_addr = omap2_get_clksel(clk, &field_mask);
-		if (div_addr == 0)
-			return ret;
-
-		field_val = omap2_divisor_to_clksel(clk, new_div);
-		if (field_val == ~0)
-			return ret;
-
-		reg_val = cm_read_reg(div_addr);
-		reg_val &= ~field_mask;
-		reg_val |= (field_val << mask_to_shift(field_mask));
-		cm_write_reg(reg_val, div_addr);
-		wmb();
-		clk->rate = clk->parent->rate / new_div;
+	pr_debug("clock: set_rate for clock %s to rate %ld\n", clk->name, rate);
 
-		if (clk->flags & DELAYED_APP) {
-			prm_write_reg(OMAP24XX_VALID_CONFIG,
-				      OMAP24XX_PRCM_CLKCFG_CTRL);
-			wmb();
-		}
-		ret = 0;
-	} else if (clk->set_rate != 0) {
+	/* CONFIG_PARTICIPANT clocks are changed only in sets via the
+	   rate table mechanism, driven by mpu_speed  */
+	if (clk->flags & CONFIG_PARTICIPANT)
+		return -EINVAL;
+
+	/* dpll_ck, core_ck, virt_prcm_set; plus all clksel clocks */
+	if (clk->set_rate != 0)
 		ret = clk->set_rate(clk, rate);
-	}
 
 	if (unlikely(ret == 0 && (clk->flags & RATE_PROPAGATES)))
 		propagate_rate(clk);
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h	2007-08-27 02:19:40.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.h	2007-08-27 02:19:40.000000000 -0600
@@ -40,7 +40,8 @@
 static void omap2_dpll_recalc(struct clk *clk);
 static void omap2_fixed_divisor_recalc(struct clk *clk);
 static long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate);
-
+static int omap2_clksel_set_rate(struct clk *clk, unsigned long rate);
+static int omap2_reprogram_dpll(struct clk *clk, unsigned long rate);
 
 /* Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
  * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,CM_CLKSEL_DSP
@@ -643,6 +644,7 @@
 				RATE_PROPAGATES | RATE_CKCTL | CM_PLL_SEL1 |
 				ALWAYS_ENABLED,
 	.recalc		= &omap2_dpll_recalc,
+	.set_rate	= &omap2_reprogram_dpll,
 };
 
 static struct clk apll96_ck = {
@@ -738,7 +740,8 @@
 	.clksel_mask	= OMAP2430_96M_SOURCE,
 	.clksel		= func_96m_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 /* func_48m_ck */
@@ -770,7 +773,8 @@
 	.clksel_mask	= OMAP24XX_48M_SOURCE,
 	.clksel		= func_48m_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk func_12m_ck = {
@@ -839,6 +843,8 @@
 	.clksel_mask	= OMAP24XX_CLKOUT_SOURCE_MASK,
 	.clksel		= common_clkout_src_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static const struct clksel_rate common_clkout_rates[] = {
@@ -865,7 +871,8 @@
 	.clksel_mask	= OMAP24XX_CLKOUT_DIV_MASK,
 	.clksel		= sys_clkout_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 /* In 2430, new in 2420 ES2 */
@@ -881,6 +888,8 @@
 	.clksel_mask	= OMAP2420_CLKOUT2_SOURCE_MASK,
 	.clksel		= common_clkout_src_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static const struct clksel sys_clkout2_clksel[] = {
@@ -898,6 +907,8 @@
 	.clksel_mask	= OMAP2420_CLKOUT2_DIV_MASK,
 	.clksel		= sys_clkout2_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk emul_ck = {
@@ -945,7 +956,8 @@
 	.clksel_mask	= OMAP24XX_CLKSEL_MPU_MASK,
 	.clksel		= mpu_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate     = &omap2_clksel_round_rate
+	.round_rate     = &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 /*
@@ -987,7 +999,8 @@
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_MASK,
 	.clksel		= iva2_1_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 /* iva2_1_ick */
@@ -1012,8 +1025,8 @@
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_IF_MASK,
 	.clksel		= iva2_1_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate
-
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 /*
@@ -1049,7 +1062,8 @@
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_MASK,
 	.clksel		= dsp_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static const struct clksel_rate dsp_ick_core_rates[] = {
@@ -1104,7 +1118,8 @@
 	.clksel_mask	= OMAP2420_CLKSEL_IVA_MASK,
 	.clksel		= iva1_ifck_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 /* IVA1 mpu/int/i/f clocks are /2 of parent */
@@ -1164,7 +1179,8 @@
 	.clksel_mask	= OMAP24XX_CLKSEL_L3_MASK,
 	.clksel		= core_l3_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 /* usb_l4_ick */
@@ -1192,7 +1208,8 @@
 	.clksel_mask	= OMAP24XX_CLKSEL_USB_MASK,
 	.clksel		= usb_l4_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 /*
@@ -1230,7 +1247,8 @@
 	.clksel_mask	= OMAP24XX_CLKSEL_SSI_MASK,
 	.clksel		= ssi_ssr_sst_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 /*
@@ -1274,7 +1292,8 @@
 	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
 	.clksel		= gfx_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk gfx_2d_fck = {
@@ -1288,7 +1307,8 @@
 	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
 	.clksel		= gfx_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk gfx_ick = {
@@ -1331,7 +1351,8 @@
 	.clksel_mask	= OMAP2430_CLKSEL_MDM_MASK,
 	.clksel		= mdm_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk mdm_osc_ck = {
@@ -1371,7 +1392,8 @@
 	.clksel_mask	= OMAP24XX_CLKSEL_L4_MASK,
 	.clksel		= l4_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk ssi_l4_ick = {
@@ -1439,7 +1461,8 @@
 	.clksel_mask	= OMAP24XX_CLKSEL_DSS1_MASK,
 	.clksel		= dss1_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static const struct clksel_rate dss2_fck_sys_rates[] = {
@@ -1530,7 +1553,8 @@
 	.clksel_mask	= OMAP24XX_CLKSEL_GPT1_MASK,
 	.clksel		= gpt_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk gpt2_ick = {
@@ -2317,7 +2341,8 @@
 	.clksel_mask	= OMAP2420_CLKSEL_VLYNQ_MASK,
 	.clksel		= vlynq_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk sdrc_ick = {

-- 
