From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 13/13] OMAP: timekeeping: time should not stop during suspend
Date: Fri,  8 Jan 2010 09:59:31 -0800
Message-ID: <1262973571-25796-14-git-send-email-khilman@deeprootsystems.com>
References: <1262973571-25796-1-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-2-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-3-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-4-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-5-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-6-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-7-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-8-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-9-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-10-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-11-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-12-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-13-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:49737 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811Ab0AHR76 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 12:59:58 -0500
Received: by mail-pz0-f171.google.com with SMTP id 1so3897523pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 08 Jan 2010 09:59:58 -0800 (PST)
In-Reply-To: <1262973571-25796-13-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

During suspend, the kernel timekeeping subsystem is shut down.  Before
suspend and upon resume, it uses a weak function
read_persistent_clock() to determine the amount of time that elapsed
during suspend.

This function was not implemented on OMAP, so from the timekeeping
subsystem perspective (and thus userspace as well) it appeared that no
time elapsed during suspend.

This patch uses the 32k sync timer as a the persistent clock.

NOTE: This does *NOT* fully handle wrapping of the 32k sync timer, so
      more than one wrapping of the 32k sync timer during suspend may
      cause problems.  Also note there are not interrupts when the 32k
      sync timer wraps, so something else has to be done.

Reported-by: Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/common.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index bf1eaf3..dddc027 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -172,6 +172,32 @@ unsigned long long sched_clock(void)
 				  clocksource_32k.mult, clocksource_32k.shift);
 }
 
+/**
+ * read_persistent_clock -  Return time from a persistent clock.
+ *
+ * Reads the time from a source which isn't disabled during PM, the
+ * 32k sync timer.  Convert the cycles elapsed since last read into
+ * nsecs and adds to a monotonically increasing timespec.
+ */
+static struct timespec persistent_ts;
+static cycles_t cycles, last_cycles;
+void read_persistent_clock(struct timespec *ts)
+{
+	unsigned long long nsecs;
+	cycles_t delta;
+	struct timespec *tsp = &persistent_ts;
+
+	last_cycles = cycles;
+	cycles = clocksource_32k.read(&clocksource_32k);
+	delta = cycles - last_cycles;
+
+	nsecs = clocksource_cyc2ns(delta,
+				   clocksource_32k.mult, clocksource_32k.shift);
+
+	timespec_add_ns(tsp, nsecs);
+	*ts = *tsp;
+}
+
 static int __init omap_init_clocksource_32k(void)
 {
 	static char err[] __initdata = KERN_ERR
-- 
1.6.6.rc2.1.g42108

