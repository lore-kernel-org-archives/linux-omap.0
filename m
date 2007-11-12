From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 3/4] ARM: OMAP: Remove MPU-timer based sched_clock()
Date: Mon, 12 Nov 2007 15:24:04 -0800
Message-ID: <20071112232414.658134414@mvista.com>
References: <20071112232401.723638265@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=remove-MPU-sched-clock.patch
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

Remove MPU-timer based sched_clock() in favor of the common one based
on 32k sync timer which works across all OMAP1/2/3 platforms.

Using 32k based one also gives a valid sched_clock() very early in the
boot process.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 arch/arm/mach-omap1/time.c |   16 ----------------
 1 file changed, 16 deletions(-)

Index: dev/arch/arm/mach-omap1/time.c
===================================================================
--- dev.orig/arch/arm/mach-omap1/time.c
+++ dev/arch/arm/mach-omap1/time.c
@@ -260,22 +260,6 @@ static void __init omap_init_clocksource
 		printk(err, clocksource_mpu.name);
 }
 
-
-/*
- * Scheduler clock - returns current time in nanosec units.
- */
-unsigned long long sched_clock(void)
-{
-	unsigned long ticks = 0 - omap_mpu_timer_read(1);
-	unsigned long long ticks64;
-
-	ticks64 = omap_mpu_timer2_overflows;
-	ticks64 <<= 32;
-	ticks64 |= ticks;
-
-	return cycles_2_ns(ticks64);
-}
-
 /*
  * ---------------------------------------------------------------------------
  * Timer initialization

--
