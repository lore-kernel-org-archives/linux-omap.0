From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 24/28] omap2 clock: replace omap2_get_crystal_rate() with
	clock-specific recalc code
Date: Mon, 20 Aug 2007 03:54:11 -0600
Message-ID: <20070820095532.333952593@pwsan.com>
References: <20070820095347.933473149@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline; filename=use_custom_osc_sys_recalc.patch
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

The OMAP2 clock framework currently uses a nonstandard function to
assign the osc_ck and sys_ck rates, omap2_get_crystal_rate().  By
using custom recalc code for these clocks, we can get rid of it and
rely on the existing clock tree recalculation process.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |   44 ++++++++++++++++++++++++--------------------
 arch/arm/mach-omap2/clock.h |   10 +++++-----
 2 files changed, 29 insertions(+), 25 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -112,21 +112,6 @@ static void omap2_init_clksel_parent(str
 	return;
 }
 
-/* Recalculate SYST_CLK */
-static void omap2_sys_clk_recalc(struct clk * clk)
-{
-	u32 div;
-
-	if (!cpu_is_omap34xx()) {
-		div = prm_read_reg(OMAP24XX_PRCM_CLKSRC_CTRL);
-		/* Test if ext clk divided by 1 or 2 */
-		div &= OMAP_SYSCLKDIV_MASK;
-		div >>= OMAP_SYSCLKDIV_SHIFT;
-		clk->rate = (clk->parent->rate / div);
-	}
-	propagate_rate(clk);
-}
-
 static u32 omap2_get_dpll_rate(struct clk * tclk)
 {
 	long long dpll_clk;
@@ -1044,9 +1029,9 @@ static struct clk_functions omap2_clk_fu
 	.clk_disable_unused	= omap2_clk_disable_unused,
 };
 
-static void __init omap2_get_crystal_rate(struct clk *osc, struct clk *sys)
+static u32 omap2_get_apll_clkin(void)
 {
-	u32 div, aplls, sclk = 13000000;
+	u32 aplls, sclk = 0;
 
 	aplls = cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
 	aplls &= OMAP24XX_APLLS_CLKIN_MASK;
@@ -1059,12 +1044,30 @@ static void __init omap2_get_crystal_rat
 	else if (aplls == APLLS_CLKIN_12MHZ)
 		sclk = 12000000;
 
+	return sclk;
+}
+
+static u32 omap2_get_sysclkdiv(void)
+{
+	u32 div;
+
 	div = prm_read_reg(OMAP24XX_PRCM_CLKSRC_CTRL);
 	div &= OMAP_SYSCLKDIV_MASK;
 	div >>= OMAP_SYSCLKDIV_SHIFT;
 
-	osc->rate = sclk * div;
-	sys->rate = sclk;
+	return div;
+}
+
+static void omap2_osc_clk_recalc(struct clk *clk)
+{
+	clk->rate = omap2_get_apll_clkin() * omap2_get_sysclkdiv();
+	propagate_rate(clk);
+}
+
+static void omap2_sys_clk_recalc(struct clk *clk)
+{
+	clk->rate = clk->parent->rate / omap2_get_sysclkdiv();
+	propagate_rate(clk);
 }
 
 /*
@@ -1116,7 +1119,8 @@ int __init omap2_clk_init(void)
 		cpu_mask = RATE_IN_243X;
 
 	clk_init(&omap2_clk_functions);
-	omap2_get_crystal_rate(&osc_ck, &sys_ck);
+
+	omap2_osc_clk_recalc(&osc_ck);
 
 	for (clkp = onchip_clks; clkp < onchip_clks + ARRAY_SIZE(onchip_clks);
 	     clkp++) {
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -36,6 +36,8 @@ static void omap2_init_clksel_parent(str
 static u32 omap2_clksel_get_divisor(struct clk *clk);
 static u32 omap2_clksel_to_divisor(struct clk *clk, u32 field_val);
 static u32 omap2_divisor_to_clksel(struct clk *clk, u32 div);
+static void omap2_osc_clk_recalc(struct clk *clk);
+static void omap2_sys_clk_recalc(struct clk *clk);
 static void omap2_dpll_recalc(struct clk *clk);
 static void omap2_fixed_divisor_recalc(struct clk *clk);
 static int omap2_clk_fixed_enable(struct clk *clk);
@@ -598,21 +600,19 @@ static struct clk func_32k_ck = {
 /* Typical 12/13MHz in standalone mode, will be 26Mhz in chassis mode */
 static struct clk osc_ck = {		/* (*12, *13, 19.2, *26, 38.4)MHz */
 	.name		= "osc_ck",
-	.rate		= 26000000,		/* fixed up in clock init */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
+				RATE_PROPAGATES,
 	.enable		= &omap2_enable_osc_ck,
 	.disable	= &omap2_disable_osc_ck,
-	.recalc		= &propagate_rate,
+	.recalc		= &omap2_osc_clk_recalc,
 };
 
 /* With out modem likely 12MHz, with modem likely 13MHz */
 static struct clk sys_ck = {		/* (*12, *13, 19.2, 26, 38.4)MHz */
 	.name		= "sys_ck",		/* ~ ref_clk also */
 	.parent		= &osc_ck,
-	.rate		= 13000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | ALWAYS_ENABLED | RATE_PROPAGATES,
+				ALWAYS_ENABLED | RATE_PROPAGATES,
 	.recalc		= &omap2_sys_clk_recalc,
 };
 

-- 
