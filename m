From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/14] ARM: OMAP: Timer32K: Move 32k-based sched_clock() to common code
Date: Mon, 17 Mar 2008 11:42:34 +0200
Message-ID: <1205746958-11242-11-git-send-email-tony@atomide.com>
References: omap-upstream-2008-03-17-114234
 <1205746958-11242-1-git-send-email-tony@atomide.com>
 <1205746958-11242-2-git-send-email-tony@atomide.com>
 <1205746958-11242-3-git-send-email-tony@atomide.com>
 <1205746958-11242-4-git-send-email-tony@atomide.com>
 <1205746958-11242-5-git-send-email-tony@atomide.com>
 <1205746958-11242-6-git-send-email-tony@atomide.com>
 <1205746958-11242-7-git-send-email-tony@atomide.com>
 <1205746958-11242-8-git-send-email-tony@atomide.com>
 <1205746958-11242-9-git-send-email-tony@atomide.com>
 <1205746958-11242-10-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:64586 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbYCQJnn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 05:43:43 -0400
In-Reply-To: <1205746958-11242-10-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@mvista.com>, Tony Lindgren <tony@atomide.com>

From: Kevin Hilman <khilman@mvista.com>

Since 32k timer code is moving to OMAP1 specific dir, move the
32k-based sched_clock() into common code where it is based on the 32k
sync counter and can be used even when using MPU timer.

While moving, change the ticks-to-nsecs conversion to use the helper
functions provided by clocksource.h.

Also removed the unused ticks_to_usec, leaving only ticks_to_nsec.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/common.c   |   17 +++++++++++++++++
 arch/arm/plat-omap/timer32k.c |   26 --------------------------
 2 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 4f0f9c4..7f1cae1 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -193,6 +193,23 @@ static struct clocksource clocksource_32k = {
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
diff --git a/arch/arm/plat-omap/timer32k.c b/arch/arm/plat-omap/timer32k.c
index ce034dc..1f7365f 100644
--- a/arch/arm/plat-omap/timer32k.c
+++ b/arch/arm/plat-omap/timer32k.c
@@ -153,32 +153,6 @@ static inline unsigned long omap_32k_sync_timer_read(void)
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
1.5.3.6

