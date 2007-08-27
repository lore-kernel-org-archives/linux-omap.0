From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 27/27] omap2 clock: add three missing clocks: gpmc_fck,
	sdma_{i, f}ck
Date: Mon, 27 Aug 2007 02:39:23 -0600
Message-ID: <20070827084124.752050297@pwsan.com>
References: <20070827083856.549249288@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=add_24xx_gpmc_sdma_clocks.patch
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

Add three missing clocks: gpmc_fck, sdma_ick, and sdma_fck.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.h |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

Index: linux-omap/arch/arm/mach-omap2/clock.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.h	2007-08-27 02:20:24.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock.h	2007-08-27 02:20:26.000000000 -0600
@@ -2277,6 +2277,27 @@
 	.recalc		= &followparent_recalc,
 };
 
+static struct clk gpmc_fck = {
+	.name		= "gpmc_fck",
+	.parent		= &core_l3_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk sdma_fck = {
+	.name		= "sdma_fck",
+	.parent		= &core_l3_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk sdma_ick = {
+	.name		= "sdma_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk vlynq_ick = {
 	.name		= "vlynq_ick",
 	.parent		= &core_l3_ck,
@@ -2633,6 +2654,9 @@
 	&i2c2_ick,
 	&i2c2_fck,
 	&i2chs2_fck,
+	&gpmc_fck,
+	&sdma_fck,
+	&sdma_ick,
 	&vlynq_ick,
 	&vlynq_fck,
 	&sdrc_ick,

-- 
