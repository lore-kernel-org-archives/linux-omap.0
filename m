From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 04/22] omap2 clock: vlynq_fck recalc should be clksel,
	not followparent
Date: Thu, 02 Aug 2007 12:10:06 -0600
Message-ID: <20070802181141.777730274@pwsan.com>
References: <20070802181002.792550043@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=vlynq_recalc_should_be_clksel.patch
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

vlynq_fck is a clksel clock, so its rate is equal to its parent's
rate, divided by whichever divisor is selected.  But its definition in
clock.h specifies omap2_followparent_recalc() as its rate calculation
code, which sets the clock's rate to that of its parent without
accounting for any divisor.  Fix to use omap2_clksel_recalc() instead.
omap2_clksel_recalc() is also missing the appropriate special case to
divide the vlynq_fck rate down; add this in.

Signed-off-by: Paul Walmsley <paul@pwsan.com>


---
 arch/arm/mach-omap2/clock.c |   10 ++++++++++
 arch/arm/mach-omap2/clock.h |    2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h
+++ linux-omap/arch/arm/mach-omap2/clock.h
@@ -1824,7 +1824,7 @@ static struct clk vlynq_fck = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
 	.src_offset	= 15,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk sdrc_ick = {
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -39,6 +39,10 @@
 
 #undef DEBUG
 
+/* CM_CLKSEL1_CORE.CLKSEL_VLYNQ options (2420) */
+#define CLKSEL_VLYNQ_96MHZ		0
+#define CLKSEL_VLYNQ_CORECLK_16		0x10
+
 /* SET_PERFORMANCE_LEVEL PARAMETERS */
 #define PRCM_HALF_SPEED		1
 #define PRCM_FULL_SPEED		2
@@ -358,6 +362,12 @@ static void omap2_clksel_recalc(struct c
 		return;
 	}
 
+	if ((clk == &vlynq_fck) && cpu_is_omap2420() &&
+	    (clksel1_core & OMAP2420_CLKSEL_VLYNQ_MASK) == CLKSEL_VLYNQ_96MHZ) {
+		clk->rate = func_96m_ck.rate;
+		return;
+	}
+
 	if (!fixed) {
 		div = omap2_clksel_get_divisor(clk);
 		if (div == 0)

-- 
