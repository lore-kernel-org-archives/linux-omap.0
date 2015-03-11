From: Xunlei Pang <xlpang@126.com>
Subject: [PATCH 4/8] ARM: OMAP: 32k counter: Provide y2038-safe omap_read_persistent_clock() replacement
Date: Wed, 11 Mar 2015 11:15:11 +0800
Message-ID: <1426043715-22043-5-git-send-email-xlpang@126.com>
References: <1426043715-22043-1-git-send-email-xlpang@126.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from m15-112.126.com ([220.181.15.112]:48968 "EHLO m15-112.126.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277AbbCKDT1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Mar 2015 23:19:27 -0400
In-Reply-To: <1426043715-22043-1-git-send-email-xlpang@126.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>, Alessandro Zummo <a.zummo@towertech.it>, John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-tegra@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ralf Baechle <ralf@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>, Xunlei Pang <pang.xunlei@linaro.org>

From: Xunlei Pang <pang.xunlei@linaro.org>

As part of addressing "y2038 problem" for in-kernel uses, this
patch adds the y2038-safe omap_read_persistent_clock64() using
timespec64.

Because we rely on some subsequent changes to convert arm multiarch
support, omap_read_persistent_clock() will be removed then.

Also remove the needless spinlock, because read_persistent_clock()
doesn't run simultaneously.

Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
 arch/arm/plat-omap/counter_32k.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 61b4d70..d422e36 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -44,24 +44,20 @@ static u64 notrace omap_32k_read_sched_clock(void)
 }
 
 /**
- * omap_read_persistent_clock -  Return time from a persistent clock.
+ * omap_read_persistent_clock64 -  Return time from a persistent clock.
  *
  * Reads the time from a source which isn't disabled during PM, the
  * 32k sync timer.  Convert the cycles elapsed since last read into
- * nsecs and adds to a monotonically increasing timespec.
+ * nsecs and adds to a monotonically increasing timespec64.
  */
-static struct timespec persistent_ts;
+static struct timespec64 persistent_ts;
 static cycles_t cycles;
 static unsigned int persistent_mult, persistent_shift;
-static DEFINE_SPINLOCK(read_persistent_clock_lock);
 
-static void omap_read_persistent_clock(struct timespec *ts)
+static void omap_read_persistent_clock64(struct timespec64 *ts)
 {
 	unsigned long long nsecs;
 	cycles_t last_cycles;
-	unsigned long flags;
-
-	spin_lock_irqsave(&read_persistent_clock_lock, flags);
 
 	last_cycles = cycles;
 	cycles = sync32k_cnt_reg ? readl_relaxed(sync32k_cnt_reg) : 0;
@@ -69,11 +65,17 @@ static void omap_read_persistent_clock(struct timespec *ts)
 	nsecs = clocksource_cyc2ns(cycles - last_cycles,
 					persistent_mult, persistent_shift);
 
-	timespec_add_ns(&persistent_ts, nsecs);
+	timespec64_add_ns(&persistent_ts, nsecs);
 
 	*ts = persistent_ts;
+}
+
+static void omap_read_persistent_clock(struct timespec *ts)
+{
+	struct timespec64 ts64;
 
-	spin_unlock_irqrestore(&read_persistent_clock_lock, flags);
+	omap_read_persistent_clock64(&ts64);
+	*ts = timespec64_to_timespec(ts64);
 }
 
 /**
-- 
1.9.1


