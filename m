From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/7] gpmc: fix GPMC code to boot on 3430
Date: Wed, 19 Sep 2007 15:10:04 -0600
Message-ID: <20070919211139.226868275@pwsan.com>
References: <20070919210959.062447046@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=fix_gpmc_for_3430_clock.patch
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

The GPMC clock name in OMAP3430 is gpmc_fck.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/gpmc.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux-omap/arch/arm/mach-omap2/gpmc.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/gpmc.c	2007-09-18 23:44:07.000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/gpmc.c	2007-09-18 23:51:18.000000000 -0600
@@ -395,7 +395,11 @@
 {
 	u32 l;
 
-	gpmc_l3_clk = clk_get(NULL, "core_l3_ck");
+	if (cpu_is_omap24xx())
+		gpmc_l3_clk = clk_get(NULL, "core_l3_ck");
+	else if (cpu_is_omap34xx())
+		gpmc_l3_clk = clk_get(NULL, "gpmc_fck");
+
 	BUG_ON(IS_ERR(gpmc_l3_clk));
 
 	l = gpmc_read_reg(GPMC_REVISION);

-- 
