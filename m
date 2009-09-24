From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP: timekeeping: time should not stop during suspend
Date: Thu, 24 Sep 2009 16:35:48 -0700
Message-ID: <1253835348-12640-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:26257 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbZIXXfr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Sep 2009 19:35:47 -0400
Received: by qw-out-2122.google.com with SMTP id 5so779989qwd.37
        for <linux-omap@vger.kernel.org>; Thu, 24 Sep 2009 16:35:51 -0700 (PDT)
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

This patch uses the 32k sync timer as a the persistent clock the 32k
sync timer value converted to seconds.

NOTE: This does *NOT* handle wrapping of the 32k sync timer, so
      wrapping of the 32k sync timer during suspend may cause
      problems.  Also, there are not interrupts when the 32k sync
      timer wraps, so something else has to be done.

Reported-by: Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Tested on OMAP3 using PM branch.
If no issues, I will queue for 2.6.32-rc fixes

 arch/arm/plat-omap/common.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index b3f70e6..3e4325b 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -178,6 +178,21 @@ unsigned long long sched_clock(void)
 	return ret;
 }
 
+/**
+ * read_persistent_clock -  Return time in seconds from the persistent clock.
+ */
+unsigned long read_persistent_clock(void)
+{
+	unsigned long long ret;
+	cycle_t cycles;
+
+	cycles = clocksource_32k.read(&clocksource_32k);
+	ret = (cycles * clocksource_32k.mult_orig) >> clocksource_32k.shift;
+	do_div(ret, NSEC_PER_SEC);
+
+	return (unsigned long)ret;
+}
+
 static int __init omap_init_clocksource_32k(void)
 {
 	static char err[] __initdata = KERN_ERR
-- 
1.6.4.3

