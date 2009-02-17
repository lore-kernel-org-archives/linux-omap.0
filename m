From: Aaro Koskinen <Aaro.Koskinen@nokia.com>
Subject: [PATCH] ARM: OMAP: sched_clock() corrected
Date: Tue, 17 Feb 2009 20:21:15 +0200
Message-ID: <1234894875-10268-1-git-send-email-Aaro.Koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:55225 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbZBQSZw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Feb 2009 13:25:52 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1HIPSqJ026740
	for <linux-omap@vger.kernel.org>; Tue, 17 Feb 2009 20:25:48 +0200
Received: from localhost.localdomain (esdhcp042201.research.nokia.com [172.21.42.201])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n1HILFrP010691
	for <linux-omap@vger.kernel.org>; Tue, 17 Feb 2009 20:21:16 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

After my OMAP3 board has been running for a while, I'm seeing weird
latency traces like this:

      sh-1574    0d.h2  153us : do_timer (tick_do_update_jiffies64)
      sh-1574    0d.h2  153us : update_wall_time (do_timer)
      sh-1574    0d.h2  153us!: omap_32k_read (update_wall_time)
      sh-1574    0d.h2 1883us : update_xtime_cache (update_wall_time)
      sh-1574    0d.h2 1883us : clocksource_get_next (update_wall_time)
      sh-1574    0d.h2 1883us+: _spin_lock_irqsave (clocksource_get_next)

and after a while:

      sh-17818   0d.h3  153us : do_timer (tick_do_update_jiffies64)
      sh-17818   0d.h3  153us : update_wall_time (do_timer)
      sh-17818   0d.h3  153us!: omap_32k_read (update_wall_time)
      sh-17818   0d.h3 1915us : update_xtime_cache (update_wall_time)
      sh-17818   0d.h3 1915us+: clocksource_get_next (update_wall_time)
      sh-17818   0d.h3 1945us : _spin_lock_irqsave (clocksource_get_next)

Turns out that sched_clock() is using cyc2ns(), which returns NTP
adjusted time. The sched_clock() frequency should not be adjusted. The
patch deletes omap_32k_ticks_to_nsecs() and rewrites sched_clock()
to do the conversion using the constant multiplier.

Signed-off-by: Aaro Koskinen <Aaro.Koskinen@nokia.com>
---
 arch/arm/plat-omap/common.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 8c53125..2866612 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -220,20 +220,16 @@ static struct clocksource clocksource_32k = {
 };
 
 /*
- * Rounds down to nearest nsec.
- */
-unsigned long long omap_32k_ticks_to_nsecs(unsigned long ticks_32k)
-{
-	return cyc2ns(&clocksource_32k, ticks_32k);
-}
-
-/*
  * Returns current time from boot in nsecs. It's OK for this to wrap
  * around for now, as it's just a relative time stamp.
  */
 unsigned long long sched_clock(void)
 {
-	return omap_32k_ticks_to_nsecs(omap_32k_read());
+	unsigned long long ret;
+
+	ret = (unsigned long long)omap_32k_read();
+	ret = (ret * clocksource_32k.mult_orig) >> clocksource_32k.shift;
+	return ret;
 }
 
 static int __init omap_init_clocksource_32k(void)
-- 
1.5.4.3

