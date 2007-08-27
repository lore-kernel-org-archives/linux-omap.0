From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 14/27] omap2 clock: clean out old code from
	omap2_clksel_recalc()
Date: Mon, 27 Aug 2007 02:39:10 -0600
Message-ID: <20070827084123.471112417@pwsan.com>
References: <20070827083856.549249288@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=convert_clksel_recalc.patch
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

Get rid of now-obsolete code in omap2_clksel_recalc().

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |   24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c	2007-08-27 02:19:37.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.c	2007-08-27 02:19:38.000000000 -0600
@@ -8,6 +8,10 @@
  *  Cleaned up and modified to use omap shared clock framework by
  *  Tony Lindgren <tony@atomide.com>
  *
+ *  Copyright (C) 2007 Texas Instruments, Inc.
+ *  Copyright (C) 2007 Nokia Corporation
+ *  Paul Walmsley
+ *
  *  Based on omap1 clock.c, Copyright (C) 2004 - 2005 Nokia corporation
  *  Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
  *
@@ -38,10 +42,6 @@
 
 #undef DEBUG
 
-/* CM_CLKSEL1_CORE.CLKSEL_VLYNQ options (2420) */
-#define CLKSEL_VLYNQ_96MHZ		0
-#define CLKSEL_VLYNQ_CORECLK_16		0x10
-
 /* CM_CLKEN_PLL.EN_{54,96}M_PLL options (24XX) */
 #define EN_APLL_STOPPED			0
 #define EN_APLL_LOCKED			3
@@ -421,19 +421,9 @@
  */
 static void omap2_clksel_recalc(struct clk * clk)
 {
-	u32 clksel1_core, div = 0;
+	u32 div = 0;
 
-	clksel1_core = cm_read_mod_reg(CORE_MOD, CM_CLKSEL1);
-
-	if ((clk == &dss1_fck) &&
-	    (clksel1_core & OMAP24XX_CLKSEL_DSS1_MASK) == 0) {
-		div = 1;
-	}
-
-	if ((clk == &vlynq_fck) && cpu_is_omap2420() &&
-	    (clksel1_core & OMAP2420_CLKSEL_VLYNQ_MASK) == CLKSEL_VLYNQ_96MHZ) {
-		div = 1;
-	}
+	pr_debug("clock: recalc'ing clksel clk %s\n", clk->name);
 
 	div = omap2_clksel_get_divisor(clk);
 	if (div == 0)
@@ -443,6 +433,8 @@
 		return;
 	clk->rate = clk->parent->rate / div;
 
+	pr_debug("clock: new clock rate is %ld (div %d)\n", clk->rate, div);
+
 	if (unlikely(clk->flags & RATE_PROPAGATES))
 		propagate_rate(clk);
 }

-- 
