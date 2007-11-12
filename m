From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 2/4] ARM: OMAP: Move 32k-based sched_clock() to common code
Date: Mon, 12 Nov 2007 15:24:03 -0800
Message-ID: <20071112232414.316266427@mvista.com>
References: <20071112232401.723638265@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=sched-clock-32k.patch
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

Since 32k timer code is moving to OMAP1 specific dir, move the
32k-based sched_clock() into common code where it is based on the 32k
sync counter and can be used even when using MPU timer.

While moving, change the ticks-to-nsecs conversion to use the helper
functions provided by clocksource.h.

Also removed the unused ticks_to_usec, leaving only ticks_to_nsec.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 arch/arm/plat-omap/common.c   |   17 +++++++++++++++++
 arch/arm/plat-omap/timer32k.c |   26 --------------------------
 2 files changed, 17 insertions(+), 26 deletions(-)

Index: dev/arch/arm/plat-omap/common.c
===================================================================
--- dev.orig/arch/arm/plat-omap/common.c
+++ dev/arch/arm/plat-omap/common.c
@@ -213,6 +213,23 @@ static struct clocksource clocksource_32
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+/*
+ * Rounds down to nearest nsec.
+ */
+unsigned long long omap_32k_ticks_to_nsecs(unsigned long ticks_32k)
+{
+	return cyc2ns(&clocksource_32k, ticks_32k);
+}
+
+/*
+ * Returns current time from boot in nsecs. It's OK for this to wrap
+ * around for now, as it's just a relative time stamp.
+ */
+unsigned long long sched_clock(void)
+{
+	return omap_32k_ticks_to_nsecs(omap_32k_read());
+}
+
 static int __init omap_init_clocksource_32k(void)
 {
 	static char err[] __initdata = KERN_ERR
Index: dev/arch/arm/plat-omap/timer32k.c
===================================================================
--- dev.orig/arch/arm/plat-omap/timer32k.c
+++ dev/arch/arm/plat-omap/timer32k.c
@@ -159,32 +159,6 @@ static inline unsigned long omap_32k_syn
 	return omap_readl(TIMER_32K_SYNCHRONIZED);
 }
 
-/*
- * Rounds down to nearest usec. Note that this will overflow for larger values.
- */
-static inline unsigned long omap_32k_ticks_to_usecs(unsigned long ticks_32k)
-{
-	return (ticks_32k * 5*5*5*5*5*5) >> 9;
-}
-
-/*
- * Rounds down to nearest nsec.
- */
-static inline unsigned long long
-omap_32k_ticks_to_nsecs(unsigned long ticks_32k)
-{
-	return (unsigned long long) ticks_32k * 1000 * 5*5*5*5*5*5 >> 9;
-}
-
-/*
- * Returns current time from boot in nsecs. It's OK for this to wrap
- * around for now, as it's just a relative time stamp.
- */
-unsigned long long sched_clock(void)
-{
-	return omap_32k_ticks_to_nsecs(omap_32k_sync_timer_read());
-}
-
 static irqreturn_t omap_32k_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = &clockevent_32k_timer;

--
