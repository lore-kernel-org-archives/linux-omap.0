From: Xunlei Pang <xlpang-KN7UnAbNpbg@public.gmane.org>
Subject: [PATCH 7/8] s390: time: Provide read_boot_clock64() and read_persistent_clock64()
Date: Wed, 11 Mar 2015 11:24:36 +0800
Message-ID: <1426044277-22170-3-git-send-email-xlpang@126.com>
References: <1426044277-22170-1-git-send-email-xlpang@126.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426044277-22170-1-git-send-email-xlpang-KN7UnAbNpbg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux390-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Xunlei Pang <pang.xunlei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Xunlei Pang <pang.xunlei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

As part of addressing "y2038 problem" for in-kernel uses, this
patch converts read_boot_clock() to read_boot_clock64() and
read_persistent_clock() to read_persistent_clock64() using
timespec64.

Since S390 is a 64bit architecture, also rename some timespec
to timespec64 in time.c and the related references.

Signed-off-by: Xunlei Pang <pang.xunlei-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/s390/include/asm/timex.h | 4 ++--
 arch/s390/kernel/debug.c      | 4 ++--
 arch/s390/kernel/time.c       | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
index 98eb2a5..8b08be3 100644
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -108,10 +108,10 @@ int get_sync_clock(unsigned long long *clock);
 void init_cpu_timer(void);
 unsigned long long monotonic_clock(void);
 
-void tod_to_timeval(__u64, struct timespec *);
+void tod_to_timeval(__u64, struct timespec64 *);
 
 static inline
-void stck_to_timespec(unsigned long long stck, struct timespec *ts)
+void stck_to_timespec64(unsigned long long stck, struct timespec64 *ts)
 {
 	tod_to_timeval(stck - TOD_UNIX_EPOCH, ts);
 }
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index c1f21ac..20ff016 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -1457,14 +1457,14 @@ int
 debug_dflt_header_fn(debug_info_t * id, struct debug_view *view,
 			 int area, debug_entry_t * entry, char *out_buf)
 {
-	struct timespec time_spec;
+	struct timespec64 time_spec;
 	char *except_str;
 	unsigned long caller;
 	int rc = 0;
 	unsigned int level;
 
 	level = entry->id.fields.level;
-	stck_to_timespec(entry->id.stck, &time_spec);
+	stck_to_timespec64(entry->id.stck, &time_spec);
 
 	if (entry->id.fields.exception)
 		except_str = "*";
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 20660dd..e4df144 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -76,7 +76,7 @@ unsigned long long monotonic_clock(void)
 }
 EXPORT_SYMBOL(monotonic_clock);
 
-void tod_to_timeval(__u64 todval, struct timespec *xt)
+void tod_to_timeval(__u64 todval, struct timespec64 *xt)
 {
 	unsigned long long sec;
 
@@ -181,12 +181,12 @@ static void timing_alert_interrupt(struct ext_code ext_code,
 static void etr_reset(void);
 static void stp_reset(void);
 
-void read_persistent_clock(struct timespec *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
 	tod_to_timeval(get_tod_clock() - TOD_UNIX_EPOCH, ts);
 }
 
-void read_boot_clock(struct timespec *ts)
+void read_boot_clock64(struct timespec64 *ts)
 {
 	tod_to_timeval(sched_clock_base_cc - TOD_UNIX_EPOCH, ts);
 }
-- 
1.9.1
