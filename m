From: Xunlei Pang <xlpang@126.com>
Subject: [PATCH 3/8] time: Add y2038 safe update_persistent_clock64()
Date: Wed, 11 Mar 2015 11:15:10 +0800
Message-ID: <1426043715-22043-4-git-send-email-xlpang@126.com>
References: <1426043715-22043-1-git-send-email-xlpang@126.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426043715-22043-1-git-send-email-xlpang@126.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>, Alessandro Zummo <a.zummo@towertech.it>, John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-tegra@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ralf Baechle <ralf@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>, Xunlei Pang <pang.xunlei@linaro.org>
List-Id: linux-omap@vger.kernel.org

From: Xunlei Pang <pang.xunlei@linaro.org>

As part of addressing in-kernel y2038 issues, this patch adds
update_persistent_clock64() and replaces all the call sites of
update_persistent_clock() with this function. This is a __weak
implementation, which simply calls the existing y2038 unsafe
update_persistent_clock().

This allows architecture specific implementations to be converted
independently, and eventually y2038-unsafe update_persistent_clock()
can be removed after all its architecture specific implementations
have been converted to update_persistent_clock64().

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
 drivers/rtc/systohc.c       |  2 +-
 include/linux/timekeeping.h |  1 +
 kernel/time/ntp.c           | 13 ++++++++++++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/systohc.c b/drivers/rtc/systohc.c
index eb71872..ef3c07a 100644
--- a/drivers/rtc/systohc.c
+++ b/drivers/rtc/systohc.c
@@ -11,7 +11,7 @@
  * rtc_set_ntp_time - Save NTP synchronized time to the RTC
  * @now: Current time of day
  *
- * Replacement for the NTP platform function update_persistent_clock
+ * Replacement for the NTP platform function update_persistent_clock64
  * that stores time for later retrieval by rtc_hctosys.
  *
  * Returns 0 on successful RTC update, -ENODEV if a RTC update is not
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index ff56a0f..a7fa96b 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -266,6 +266,7 @@ extern void read_persistent_clock64(struct timespec64 *ts);
 extern void read_boot_clock(struct timespec *ts);
 extern void read_boot_clock64(struct timespec64 *ts);
 extern int update_persistent_clock(struct timespec now);
+extern int update_persistent_clock64(struct timespec64 now);
 
 
 #endif
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 0f60b08..42d1bc7 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -459,6 +459,16 @@ out:
 	return leap;
 }
 
+#ifdef CONFIG_GENERIC_CMOS_UPDATE
+int __weak update_persistent_clock64(struct timespec64 now64)
+{
+	struct timespec now;
+
+	now = timespec64_to_timespec(now64);
+	return update_persistent_clock(now);
+}
+#endif
+
 #if defined(CONFIG_GENERIC_CMOS_UPDATE) || defined(CONFIG_RTC_SYSTOHC)
 static void sync_cmos_clock(struct work_struct *work);
 
@@ -494,8 +504,9 @@ static void sync_cmos_clock(struct work_struct *work)
 		if (persistent_clock_is_local)
 			adjust.tv_sec -= (sys_tz.tz_minuteswest * 60);
 #ifdef CONFIG_GENERIC_CMOS_UPDATE
-		fail = update_persistent_clock(timespec64_to_timespec(adjust));
+		fail = update_persistent_clock64(adjust);
 #endif
+
 #ifdef CONFIG_RTC_SYSTOHC
 		if (fail == -ENODEV)
 			fail = rtc_set_ntp_time(adjust);
-- 
1.9.1
