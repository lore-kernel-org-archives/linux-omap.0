From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2] OMAP: timekeeping: time should not stop during suspend
Date: Tue, 17 Nov 2009 15:41:13 -0800
Message-ID: <1258501273-17595-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:60402 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756271AbZKQXlL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 18:41:11 -0500
Received: by pwi3 with SMTP id 3so312285pwi.21
        for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2009 15:41:17 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jon Hunter <jon-hunter@ti.com>

During suspend, the kernel timekeeping subsystem is shut down.  Before
suspend and upon resume, it uses a weak function
read_persistent_clock() to determine the amount of time that elapsed
during suspend.

This function was not implemented on OMAP, so from the timekeeping
subsystem perspective (and thus userspace as well) it appeared that no
time elapsed during suspend.

This patch uses the 32k sync timer as a the persistent clock the 32k
sync timer value converted to seconds.

NOTE: This does *NOT* handle wrapping of the 32k sync timer, so
      wrapping of the 32k sync timer during suspend may cause
      problems.  Also, there are not interrupts when the 32k sync
      timer wraps, so something else has to be done.

Reported-by: Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Since v1 of this patch, the signature of this function changed.

Also note that forthcoming omap_device patches will depend on this
function instead of getnstimeofday() since the timekeeping subsystem
is suspended when we want to do omap_device timing measurements.

 arch/arm/plat-omap/common.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index cc050b3..8057966 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -172,6 +172,25 @@ unsigned long long sched_clock(void)
 				  clocksource_32k.mult, clocksource_32k.shift);
 }
 
+/**
+ * read_persistent_clock -  Return time from the persistent clock.
+ *
+ * Reads the time from a source which isn't disabled during PM: 32k sync
+ * Returns a timespec with tv_sec=0 and tv_nsec=0 if unsupported.
+ *
+ */
+void read_persistent_clock(struct timespec *ts)
+{
+	unsigned long long nsecs;
+	cycle_t cycles;
+
+	ts->tv_sec = ts->tv_nsec = 0;
+	cycles = clocksource_32k.read(&clocksource_32k);
+	nsecs = clocksource_cyc2ns(cycles,
+				   clocksource_32k.mult, clocksource_32k.shift);
+	timespec_add_ns(ts, nsecs);
+}
+
 static int __init omap_init_clocksource_32k(void)
 {
 	static char err[] __initdata = KERN_ERR
-- 
1.6.5.1

