From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 04/27] omap2 clock: remove superfluous omap2_propagate_rate()
Date: Mon, 27 Aug 2007 02:39:00 -0600
Message-ID: <20070827084122.444363672@pwsan.com>
References: <20070827083856.549249288@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=fixed_rate_clocks_can_use_propagate_rate.patch
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

omap2_propagate_rate() seems completely superfluous.  It handles two
cases.  The first case is for non-fixed rate clocks.  It assigns the
parent's rate to the clock, and continues propagating the rate
downwards.  This can be handled by adding a RATE_PROPAGATES clock flag
to the clock, if it wasn't there already, and by using
followparent_recalc() directly as the recalc function.  The second
case is for fixed rate clocks.  Here all we need to do is to call
propagate_rate() directly, so, use that for the recalc function.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |    8 --------
 arch/arm/mach-omap2/clock.h |   17 ++++++++---------
 2 files changed, 8 insertions(+), 17 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -143,14 +143,6 @@ static void omap2_fixed_divisor_recalc(s
 		propagate_rate(clk);
 }
 
-static void omap2_propagate_rate(struct clk * clk)
-{
-	if (!(clk->flags & RATE_FIXED))
-		clk->rate = clk->parent->rate;
-
-	propagate_rate(clk);
-}
-
 static void omap2_set_osc_ck(int enable)
 {
 	u32 pcc;
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -24,7 +24,6 @@
 
 static void omap2_sys_clk_recalc(struct clk * clk);
 static void omap2_clksel_recalc(struct clk * clk);
-static void omap2_propagate_rate(struct clk * clk);
 static void omap2_mpu_recalc(struct clk * clk);
 static int omap2_select_table_rate(struct clk * clk, unsigned long rate);
 static long omap2_round_to_table_rate(struct clk * clk, unsigned long rate);
@@ -621,7 +620,7 @@ static struct clk alt_ck = {		/* Typical
 	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | ALWAYS_ENABLED | RATE_PROPAGATES,
-	.recalc		= &omap2_propagate_rate,
+	.recalc		= &propagate_rate,
 };
 
 /*
@@ -646,7 +645,7 @@ static struct clk apll96_ck = {
 				RATE_FIXED | RATE_PROPAGATES,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP24XX_EN_96M_PLL_SHIFT,
-	.recalc		= &omap2_propagate_rate,
+	.recalc		= &propagate_rate,
 };
 
 static struct clk apll54_ck = {
@@ -657,7 +656,7 @@ static struct clk apll54_ck = {
 				RATE_FIXED | RATE_PROPAGATES,
 	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP24XX_EN_54M_PLL_SHIFT,
-	.recalc		= &omap2_propagate_rate,
+	.recalc		= &propagate_rate,
 };
 
 /*
@@ -671,7 +670,7 @@ static struct clk func_54m_ck = {
 				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
 	.src_offset	= OMAP24XX_54M_SOURCE_SHIFT,
-	.recalc		= &omap2_propagate_rate,
+	.recalc		= &propagate_rate,
 };
 
 static struct clk core_ck = {
@@ -679,7 +678,7 @@ static struct clk core_ck = {
 	.parent		= &dpll_ck,		/* can also be 32k */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				ALWAYS_ENABLED | RATE_PROPAGATES,
-	.recalc		= &omap2_propagate_rate,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk func_96m_ck = {
@@ -689,7 +688,7 @@ static struct clk func_96m_ck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
-	.recalc		= &omap2_propagate_rate,
+	.recalc		= &propagate_rate,
 };
 
 static struct clk func_48m_ck = {
@@ -700,7 +699,7 @@ static struct clk func_48m_ck = {
 				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
 	.src_offset	= OMAP24XX_48M_SOURCE_SHIFT,
-	.recalc		= &omap2_propagate_rate,
+	.recalc		= &propagate_rate,
 };
 
 static struct clk func_12m_ck = {
@@ -752,7 +751,7 @@ static struct clk emul_ck = {
 	.flags		= CLOCK_IN_OMAP242X,
 	.enable_reg	= OMAP24XX_PRCM_CLKEMUL_CTRL,
 	.enable_bit	= OMAP24XX_EMULATION_EN_SHIFT,
-	.recalc		= &omap2_propagate_rate,
+	.recalc		= &followparent_recalc,
 
 };
 

-- 
