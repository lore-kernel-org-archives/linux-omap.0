From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 19/22] omap2 clock: use dedicated omap2_dpll_recalc() for
	DPLL recalc func
Date: Thu, 02 Aug 2007 12:10:21 -0600
Message-ID: <20070802181143.471303581@pwsan.com>
References: <20070802181002.792550043@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=use-dpll-specific-recalc-code.patch
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

dpll_ck is not a clksel clock, and so it does not really fit well into
omap2_clksel_recalc().  Split off its recalc code into its own function,
omap2_dpll_recalc().

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |   17 +++++++++--------
 arch/arm/mach-omap2/clock.h |    3 ++-
 2 files changed, 11 insertions(+), 9 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -387,6 +387,13 @@ static u32 omap2_dpll_round_rate(unsigne
 
 }
 
+static void omap2_dpll_recalc(struct clk *clk)
+{
+	clk->rate = omap2_get_dpll_rate(clk);
+
+	propagate_rate(clk);
+}
+
 /*
  * Used for clocks that are part of CLKSEL_xyz governed clocks.
  * REVISIT: Maybe change to use clk->enable() functions like on omap1?
@@ -396,12 +403,6 @@ static void omap2_clksel_recalc(struct c
 	u32 fixed = 0, div = 0;
 	u32 clksel1_core;
 
-	if (clk == &dpll_ck) {
-		clk->rate = omap2_get_dpll_rate(clk);
-		fixed = 1;
-		div = 0;
-	}
-
 	if (clk == &iva1_mpu_int_ifck) {
 		div = 2;
 		fixed = 1;
@@ -594,7 +595,7 @@ static int omap2_reprogram_dpll(struct c
 		omap2_init_memory_params(omap2_dll_force_needed());
 		omap2_reprogram_sdrc(done_rate, 0);
 	}
-	omap2_clksel_recalc(&dpll_ck);
+	omap2_dpll_recalc(&dpll_ck);
 	ret = 0;
 
 dpll_exit:
@@ -1093,7 +1094,7 @@ static int omap2_select_table_rate(struc
 
 		local_irq_restore(flags);
 	}
-	omap2_clksel_recalc(&dpll_ck);
+	omap2_dpll_recalc(&dpll_ck);
 
 	return 0;
 }
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -33,6 +33,7 @@ static void omap2_clk_disable(struct clk
 static void omap2_sys_clk_recalc(struct clk * clk);
 static u32 omap2_clksel_to_divisor(u32 div_sel, u32 field_val);
 static u32 omap2_clksel_get_divisor(struct clk *clk);
+static void omap2_dpll_recalc(struct clk *clk);
 
 #define RATE_IN_242X	(1 << 0)
 #define RATE_IN_243X	(1 << 1)
@@ -632,7 +633,7 @@ static struct clk dpll_ck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_PROPAGATES | RATE_CKCTL | CM_PLL_SEL1 |
 				ALWAYS_ENABLED,
-	.recalc		= &omap2_clksel_recalc,
+	.recalc		= &omap2_dpll_recalc,
 };
 
 static struct clk apll96_ck = {

-- 
