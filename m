From: Xunlei Pang <xlpang-KN7UnAbNpbg@public.gmane.org>
Subject: [PATCH 1/8] time: Add y2038 safe read_boot_clock64()
Date: Wed, 11 Mar 2015 11:15:08 +0800
Message-ID: <1426043715-22043-2-git-send-email-xlpang@126.com>
References: <1426043715-22043-1-git-send-email-xlpang@126.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426043715-22043-1-git-send-email-xlpang-KN7UnAbNpbg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux390-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Xunlei Pang <pang.xunlei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Xunlei Pang <pang.xunlei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

As part of addressing in-kernel y2038 issues, this patch adds
read_boot_clock64() and replaces all the call sites of read_boot_clock()
with this function. This is a __weak implementation, which simply
calls the existing y2038 unsafe read_boot_clock().

This allows architecture specific implementations to be converted
independently, and eventually the y2038 unsafe read_boot_clock()
can be removed after all its architecture specific implementations
have been converted to read_boot_clock64().

Suggested-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Signed-off-by: Xunlei Pang <pang.xunlei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 include/linux/timekeeping.h |  1 +
 kernel/time/timekeeping.c   | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 3eaae47..d53c522 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -263,6 +263,7 @@ static inline bool has_persistent_clock(void)
 
 extern void read_persistent_clock(struct timespec *ts);
 extern void read_boot_clock(struct timespec *ts);
+extern void read_boot_clock64(struct timespec64 *ts);
 extern int update_persistent_clock(struct timespec now);
 
 
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 91db941..7080c21 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1072,6 +1072,14 @@ void __weak read_boot_clock(struct timespec *ts)
 	ts->tv_nsec = 0;
 }
 
+void __weak read_boot_clock64(struct timespec64 *ts64)
+{
+	struct timespec ts;
+
+	read_boot_clock(&ts);
+	*ts64 = timespec_to_timespec64(ts);
+}
+
 /*
  * timekeeping_init - Initializes the clocksource and common timekeeping values
  */
@@ -1093,8 +1101,7 @@ void __init timekeeping_init(void)
 	} else if (now.tv_sec || now.tv_nsec)
 		persistent_clock_exist = true;
 
-	read_boot_clock(&ts);
-	boot = timespec_to_timespec64(ts);
+	read_boot_clock64(&boot);
 	if (!timespec64_valid_strict(&boot)) {
 		pr_warn("WARNING: Boot clock returned invalid value!\n"
 			"         Check your CMOS/BIOS settings.\n");
-- 
1.9.1
