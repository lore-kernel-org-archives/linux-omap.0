From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 22/27] omap2 clock: use custom osc_ck enable/disable routines
Date: Mon, 27 Aug 2007 02:39:18 -0600
Message-ID: <20070827084124.264123469@pwsan.com>
References: <20070827083856.549249288@pwsan.com>
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
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c	2007-08-27 02:19:42.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.c	2007-08-27 02:19:44.000000000 -0600
@@ -163,18 +163,26 @@
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
@@ -272,11 +280,6 @@
 	if (clk->flags & (ALWAYS_ENABLED | PARENT_CONTROLS_CLOCK))
 		return 0;
 
-	if (unlikely(clk == &osc_ck)) {
-		omap2_set_osc_ck(1);
-		return 0;
-	}
-
 	if (clk->enable)
 		return clk->enable(clk);
 
@@ -324,11 +327,6 @@
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
--- linux-omap.orig/arch/arm/mach-omap2/clock.h	2007-08-27 02:19:42.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.h	2007-08-27 02:20:15.000000000 -0600
@@ -26,7 +26,6 @@
 #include "prm_regbits_24xx.h"
 #include "cm_regbits_24xx.h"
 
-static void omap2_sys_clk_recalc(struct clk * clk);
 static void omap2_clksel_recalc(struct clk * clk);
 static void omap2_table_mpu_recalc(struct clk *clk);
 static int omap2_select_table_rate(struct clk * clk, unsigned long rate);
@@ -42,6 +41,8 @@
 static long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate);
 static int omap2_clksel_set_rate(struct clk *clk, unsigned long rate);
 static int omap2_reprogram_dpll(struct clk *clk, unsigned long rate);
+static int omap2_enable_osc_ck(struct clk *clk);
+static void omap2_disable_osc_ck(struct clk *clk);
 
 /* Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
  * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,CM_CLKSEL_DSP
@@ -598,6 +599,8 @@
 	.rate		= 26000000,		/* fixed up in clock init */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | RATE_PROPAGATES,
+	.enable		= &omap2_enable_osc_ck,
+	.disable	= &omap2_disable_osc_ck,
 	.recalc		= &propagate_rate,
 };
 

-- 
