From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 1/2] ARM: OMAP: Need to enable 32k-sync clock
Date: Tue, 13 Nov 2007 14:45:42 -0800
Message-ID: <20071113224626.653078724@mvista.com>
References: <20071113224541.567151514@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=use-sync-32k-clock.patch
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

When CONFIG_OMAP_RESET_CLOCKS=y is enabled on OMAP3, the 32k sync
clock is disabled, resulting in a crash when any access to it is done,
including a sched_clock().

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 arch/arm/plat-omap/common.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: dev/arch/arm/plat-omap/common.c
===================================================================
--- dev.orig/arch/arm/plat-omap/common.c
+++ dev/arch/arm/plat-omap/common.c
@@ -236,6 +236,12 @@ static int __init omap_init_clocksource_
 			"%s: can't register clocksource!\n";
 
 	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
+		struct clk *sync_32k_ick;
+
+		sync_32k_ick = clk_get(NULL, "omap_32ksync_ick");
+		if (sync_32k_ick)
+			clk_enable(sync_32k_ick);
+
 		clocksource_32k.mult = clocksource_hz2mult(32768,
 					    clocksource_32k.shift);
 

--
