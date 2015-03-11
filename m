From: Xunlei Pang <xlpang-KN7UnAbNpbg@public.gmane.org>
Subject: [PATCH 2/8] time: Add y2038 safe read_persistent_clock64()
Date: Wed, 11 Mar 2015 11:15:09 +0800
Message-ID: <1426043715-22043-3-git-send-email-xlpang@126.com>
References: <1426043715-22043-1-git-send-email-xlpang@126.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426043715-22043-1-git-send-email-xlpang-KN7UnAbNpbg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux390-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Xunlei Pang <pang.xunlei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Xunlei Pang <pang.xunlei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

As part of addressing in-kernel y2038 issues, this patch adds
read_persistent_clock64() and replaces all the call sites of
read_persistent_clock() with this function. This is a __weak
implementation, which simply calls the existing y2038 unsafe
read_persistent_clock().

This allows architecture specific implementations to be converted
independently, and eventually the y2038 unsafe read_persistent_clock()
can be removed after all its architecture specific implementations
have been converted to read_persistent_clock64().

Suggested-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Signed-off-by: Xunlei Pang <pang.xunlei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/mips/lasat/sysctl.c    |  4 ++--
 include/linux/timekeeping.h |  1 +
 kernel/time/timekeeping.c   | 22 ++++++++++++----------
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/mips/lasat/sysctl.c b/arch/mips/lasat/sysctl.c
index 3b7f65c..cf9b4633 100644
--- a/arch/mips/lasat/sysctl.c
+++ b/arch/mips/lasat/sysctl.c
@@ -75,11 +75,11 @@ static int rtctmp;
 int proc_dolasatrtc(struct ctl_table *table, int write,
 		       void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct timespec ts;
+	struct timespec64 ts;
 	int r;
 
 	if (!write) {
-		read_persistent_clock(&ts);
+		read_persistent_clock64(&ts);
 		rtctmp = ts.tv_sec;
 		/* check for time < 0 and set to 0 */
 		if (rtctmp < 0)
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index d53c522..ff56a0f 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -262,6 +262,7 @@ static inline bool has_persistent_clock(void)
 }
 
 extern void read_persistent_clock(struct timespec *ts);
+extern void read_persistent_clock64(struct timespec64 *ts);
 extern void read_boot_clock(struct timespec *ts);
 extern void read_boot_clock64(struct timespec64 *ts);
 extern int update_persistent_clock(struct timespec now);
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 7080c21..0e5a696 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1057,6 +1057,14 @@ void __weak read_persistent_clock(struct timespec *ts)
 	ts->tv_nsec = 0;
 }
 
+void __weak read_persistent_clock64(struct timespec64 *ts64)
+{
+	struct timespec ts;
+
+	read_persistent_clock(&ts);
+	*ts64 = timespec_to_timespec64(ts);
+}
+
 /**
  * read_boot_clock -  Return time of the system start.
  *
@@ -1089,10 +1097,8 @@ void __init timekeeping_init(void)
 	struct clocksource *clock;
 	unsigned long flags;
 	struct timespec64 now, boot, tmp;
-	struct timespec ts;
 
-	read_persistent_clock(&ts);
-	now = timespec_to_timespec64(ts);
+	read_persistent_clock64(&now);
 	if (!timespec64_valid_strict(&now)) {
 		pr_warn("WARNING: Persistent clock returned invalid value!\n"
 			"         Check your CMOS/BIOS settings.\n");
@@ -1163,7 +1169,7 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
  * timekeeping_inject_sleeptime64 - Adds suspend interval to timeekeeping values
  * @delta: pointer to a timespec64 delta value
  *
- * This hook is for architectures that cannot support read_persistent_clock
+ * This hook is for architectures that cannot support read_persistent_clock64
  * because their RTC/persistent clock is only accessible when irqs are enabled.
  *
  * This function should only be called by rtc_resume(), and allows
@@ -1210,12 +1216,10 @@ void timekeeping_resume(void)
 	struct clocksource *clock = tk->tkr.clock;
 	unsigned long flags;
 	struct timespec64 ts_new, ts_delta;
-	struct timespec tmp;
 	cycle_t cycle_now, cycle_delta;
 	bool suspendtime_found = false;
 
-	read_persistent_clock(&tmp);
-	ts_new = timespec_to_timespec64(tmp);
+	read_persistent_clock64(&ts_new);
 
 	clockevents_resume();
 	clocksource_resume();
@@ -1291,10 +1295,8 @@ int timekeeping_suspend(void)
 	unsigned long flags;
 	struct timespec64		delta, delta_delta;
 	static struct timespec64	old_delta;
-	struct timespec tmp;
 
-	read_persistent_clock(&tmp);
-	timekeeping_suspend_time = timespec_to_timespec64(tmp);
+	read_persistent_clock64(&timekeeping_suspend_time);
 
 	/*
 	 * On some systems the persistent_clock can not be detected at
-- 
1.9.1
