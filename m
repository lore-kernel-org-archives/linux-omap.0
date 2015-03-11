From: Xunlei Pang <xlpang@126.com>
Subject: [PATCH 5/8] ARM: tegra: clock: Provide y2038-safe tegra_read_persistent_clock() replacement
Date: Wed, 11 Mar 2015 11:24:34 +0800
Message-ID: <1426044277-22170-1-git-send-email-xlpang@126.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from m15-112.126.com ([220.181.15.112]:43441 "EHLO m15-112.126.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408AbbCKD15 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Mar 2015 23:27:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>, Alessandro Zummo <a.zummo@towertech.it>, John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-tegra@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ralf Baechle <ralf@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>, Xunlei Pang <pang.xunlei@linaro.org>

From: Xunlei Pang <pang.xunlei@linaro.org>

As part of addressing "y2038 problem" for in-kernel uses, this
patch adds the y2038-safe tegra_read_persistent_clock64() using
timespec64.

Because we rely on some subsequent changes to convert arm multiarch
support, tegra_read_persistent_clock() will be removed then.

Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
 drivers/clocksource/tegra20_timer.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index d2616ef..7fc7fb9 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -51,7 +51,7 @@
 static void __iomem *timer_reg_base;
 static void __iomem *rtc_base;
 
-static struct timespec persistent_ts;
+static struct timespec64 persistent_ts;
 static u64 persistent_ms, last_persistent_ms;
 
 static struct delay_timer tegra_delay_timer;
@@ -120,26 +120,33 @@ static u64 tegra_rtc_read_ms(void)
 }
 
 /*
- * tegra_read_persistent_clock -  Return time from a persistent clock.
+ * tegra_read_persistent_clock64 -  Return time from a persistent clock.
  *
  * Reads the time from a source which isn't disabled during PM, the
  * 32k sync timer.  Convert the cycles elapsed since last read into
- * nsecs and adds to a monotonically increasing timespec.
+ * nsecs and adds to a monotonically increasing timespec64.
  * Care must be taken that this funciton is not called while the
  * tegra_rtc driver could be executing to avoid race conditions
  * on the RTC shadow register
  */
-static void tegra_read_persistent_clock(struct timespec *ts)
+static void tegra_read_persistent_clock64(struct timespec64 *ts)
 {
 	u64 delta;
-	struct timespec *tsp = &persistent_ts;
 
 	last_persistent_ms = persistent_ms;
 	persistent_ms = tegra_rtc_read_ms();
 	delta = persistent_ms - last_persistent_ms;
 
-	timespec_add_ns(tsp, delta * NSEC_PER_MSEC);
-	*ts = *tsp;
+	timespec64_add_ns(&persistent_ts, delta * NSEC_PER_MSEC);
+	*ts = persistent_ts;
+}
+
+static void tegra_read_persistent_clock(struct timespec *ts)
+{
+	struct timespec ts64;
+
+	tegra_read_persistent_clock64(&ts64);
+	*ts = timespec64_to_timespec(ts64);
 }
 
 static unsigned long tegra_delay_timer_read_counter_long(void)
-- 
1.9.1


