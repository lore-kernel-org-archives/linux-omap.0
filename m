From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/4] 3430 clock: 3430 clock: combine div2_rates
Date: Tue, 04 Dec 2007 02:26:07 -0700
Message-ID: <20071204092736.952538577@pwsan.com>
References: <20071204092605.831497615@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=3430_coalesce_div2_rates.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap@vger.kernel.org
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Several 3430 clocks have separate, identical clksel_rate structures
that pass through the full parent rate, or divide it by 2 - combine
these structures.

Signed-off-by: Paul Walmsley <paul@pwsan.com>


---
 arch/arm/mach-omap2/clock34xx.h |   18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock34xx.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock34xx.h	2007-11-30 17:56:56.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/clock34xx.h	2007-11-30 17:57:10.000000000 -0700
@@ -151,14 +151,14 @@
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static const struct clksel_rate sys_osc_rates[] = {
+static const struct clksel_rate div2_rates[] = {
 	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
 	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
 	{ .div = 0 }
 };
 
 static const struct clksel sys_clksel[] = {
-	{ .parent = &osc_sys_ck, .rates = sys_osc_rates },
+	{ .parent = &osc_sys_ck, .rates = div2_rates },
 	{ .parent = NULL }
 };
 
@@ -307,12 +307,6 @@
 	{ .div = 0 }
 };
 
-static const struct clksel_rate div2_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 0 },
-};
-
 static const struct clksel div2_dpll3m2_clksel[] = {
 	{ .parent = &dpll3_ck, .rates = div2_rates },
 	{ .parent = NULL }
@@ -1362,14 +1356,8 @@
 /* REVISIT: Technically the TRM claims that this is CORE_CLK based,
  * but l4_ick makes more sense to me */
 
-static const struct clksel_rate usb_l4_l4_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
-	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
-	{ .div = 0 }
-};
-
 static const struct clksel usb_l4_clksel[] = {
-	{ .parent = &l4_ick, .rates = usb_l4_l4_rates },
+	{ .parent = &l4_ick, .rates = div2_rates },
 	{ .parent = NULL },
 };
 

-- 
