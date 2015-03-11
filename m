From: Xunlei Pang <xlpang@126.com>
Subject: [PATCH 8/8] time: Remove read_boot_clock()
Date: Wed, 11 Mar 2015 11:24:37 +0800
Message-ID: <1426044277-22170-4-git-send-email-xlpang@126.com>
References: <1426044277-22170-1-git-send-email-xlpang@126.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426044277-22170-1-git-send-email-xlpang@126.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>, Alessandro Zummo <a.zummo@towertech.it>, John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-tegra@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ralf Baechle <ralf@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>, Xunlei Pang <pang.xunlei@linaro.org>
List-Id: linux-omap@vger.kernel.org

From: Xunlei Pang <pang.xunlei@linaro.org>

Now we have all the read_boot_clock64() for all implementations,
it's time to remove read_boot_clock() completely from the kernel.

Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
read_persistent_clock() and update_persistent_clock() are way more
complex, so we will deal with them gradually in extra patchsets.

 include/linux/timekeeping.h |  1 -
 kernel/time/timekeeping.c   | 14 +++-----------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index a7fa96b..72631e8 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -263,7 +263,6 @@ static inline bool has_persistent_clock(void)
 
 extern void read_persistent_clock(struct timespec *ts);
 extern void read_persistent_clock64(struct timespec64 *ts);
-extern void read_boot_clock(struct timespec *ts);
 extern void read_boot_clock64(struct timespec64 *ts);
 extern int update_persistent_clock(struct timespec now);
 extern int update_persistent_clock64(struct timespec64 now);
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 0e5a696..d0ca908 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1066,28 +1066,20 @@ void __weak read_persistent_clock64(struct timespec64 *ts64)
 }
 
 /**
- * read_boot_clock -  Return time of the system start.
+ * read_boot_clock64 -  Return time of the system start.
  *
  * Weak dummy function for arches that do not yet support it.
  * Function to read the exact time the system has been started.
- * Returns a timespec with tv_sec=0 and tv_nsec=0 if unsupported.
+ * Returns a timespec64 with tv_sec=0 and tv_nsec=0 if unsupported.
  *
  *  XXX - Do be sure to remove it once all arches implement it.
  */
-void __weak read_boot_clock(struct timespec *ts)
+void __weak read_boot_clock64(struct timespec64 *ts)
 {
 	ts->tv_sec = 0;
 	ts->tv_nsec = 0;
 }
 
-void __weak read_boot_clock64(struct timespec64 *ts64)
-{
-	struct timespec ts;
-
-	read_boot_clock(&ts);
-	*ts64 = timespec_to_timespec64(ts);
-}
-
 /*
  * timekeeping_init - Initializes the clocksource and common timekeeping values
  */
-- 
1.9.1
