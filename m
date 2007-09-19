From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 6/7] dmtimer: fix source clocks for 3430
Date: Wed, 19 Sep 2007 15:10:05 -0600
Message-ID: <20070919211139.315852628@pwsan.com>
References: <20070919210959.062447046@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=fix_timer_for_3430_clock.patch
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

Fix dmtimer source clock names for OMAP3430.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/plat-omap/dmtimer.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-omap/arch/arm/plat-omap/dmtimer.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/dmtimer.c	2007-09-19 10:40:13.000000000 -0600
+++ linux-omap/arch/arm/plat-omap/dmtimer.c	2007-09-19 12:55:15.000000000 -0600
@@ -162,12 +162,11 @@
 
 static const char *omap3_dm_source_names[] __initdata = {
 	"sys_ck",
-	"func_32k_ck",
-	"alt_ck",
+	"omap_32k_fck",
 	NULL
 };
 
-static struct clk **omap3_dm_source_clocks[3];
+static struct clk **omap3_dm_source_clocks[2];
 static const int dm_timer_count = ARRAY_SIZE(omap3_dm_timers);
 
 #else

-- 
