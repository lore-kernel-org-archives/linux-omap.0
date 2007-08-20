From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 22/28] omap2 clock: use custom osc_ck enable/disable routines
Date: Mon, 20 Aug 2007 03:54:09 -0600
Message-ID: <20070820095532.141359115@pwsan.com>
References: <20070820095347.933473149@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=use_custom_osc_ck_enable.patch
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

Now that we're paying attention to the .enable/.disable fields in struct 
clk, convert the osc_ck enable and disable code to use this standard
mechanism.  (osc_ck enable/disable does not technically enable or disable
the osc_ck; it actually enables/disables autoidling.)

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |   32 +++++++++++++++-----------------
 arch/arm/mach-omap2/clock.h |    5 ++++-
 2 files changed, 19 insertions(+), 18 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -162,18 +162,26 @@ static void omap2_fixed_divisor_recalc(s
 		propagate_rate(clk);
 }
 
-static void omap2_set_osc_ck(int enable)
+static int omap2_enable_osc_ck(struct clk *clk)
 {
 	u32 pcc;
 
 	pcc = prm_read_reg(OMAP24XX_PRCM_CLKSRC_CTRL);
 
-	if (enable)
-		prm_write_reg(pcc & ~OMAP_AUTOEXTCLKMODE_MASK,
-			      OMAP24XX_PRCM_CLKSRC_CTRL);
-	else
-		prm_write_reg(pcc | OMAP_AUTOEXTCLKMODE_MASK,
-			      OMAP24XX_PRCM_CLKSRC_CTRL);
+	prm_write_reg(pcc & ~OMAP_AUTOEXTCLKMODE_MASK,
+		      OMAP24XX_PRCM_CLKSRC_CTRL);
+
+	return 0;
+}
+
+static void omap2_disable_osc_ck(struct clk *clk)
+{
+	u32 pcc;
+
+	pcc = prm_read_reg(OMAP24XX_PRCM_CLKSRC_CTRL);
+
+	prm_write_reg(pcc | OMAP_AUTOEXTCLKMODE_MASK,
+		      OMAP24XX_PRCM_CLKSRC_CTRL);
 }
 
 /*
@@ -271,11 +279,6 @@ static int _omap2_clk_enable(struct clk 
 	if (clk->flags & (ALWAYS_ENABLED | PARENT_CONTROLS_CLOCK))
 		return 0;
 
-	if (unlikely(clk == &osc_ck)) {
-		omap2_set_osc_ck(1);
-		return 0;
-	}
-
 	if (clk->enable)
 		return clk->enable(clk);
 
@@ -323,11 +326,6 @@ static void _omap2_clk_disable(struct cl
 		return;
 	}
 
-	if (unlikely(clk == &osc_ck)) {
-		omap2_set_osc_ck(0);
-		return;
-	}
-
 	if (clk->enable_reg == 0) {
 		/*
 		 * 'Independent' here refers to a clock which is not
Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -26,7 +26,6 @@
 #include "prm_regbits_24xx.h"
 #include "cm_regbits_24xx.h"
 
-static void omap2_sys_clk_recalc(struct clk * clk);
 static void omap2_clksel_recalc(struct clk * clk);
 static void omap2_table_mpu_recalc(struct clk *clk);
 static int omap2_select_table_rate(struct clk * clk, unsigned long rate);
@@ -42,6 +41,8 @@ static void omap2_fixed_divisor_recalc(s
 static long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate);
 static int omap2_clksel_set_rate(struct clk *clk, unsigned long rate);
 static int omap2_reprogram_dpll(struct clk * clk, unsigned long rate);
+static int omap2_enable_osc_ck(struct clk *clk);
+static void omap2_disable_osc_ck(struct clk *clk);
 
 /* Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
  * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,CM_CLKSEL_DSP
@@ -598,6 +599,8 @@ static struct clk osc_ck = {		/* (*12, *
 	.rate		= 26000000,		/* fixed up in clock init */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | RATE_PROPAGATES,
+	.enable		= &omap2_enable_osc_ck,
+	.disable	= &omap2_disable_osc_ck,
 	.recalc		= &propagate_rate,
 };
 

-- 
