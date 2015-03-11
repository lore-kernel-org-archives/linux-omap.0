From: Xunlei Pang <xlpang@126.com>
Subject: [PATCH 6/8] ARM: time: Provide read_boot_clock64() and read_persistent_clock64()
Date: Wed, 11 Mar 2015 11:24:35 +0800
Message-ID: <1426044277-22170-2-git-send-email-xlpang@126.com>
References: <1426044277-22170-1-git-send-email-xlpang@126.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426044277-22170-1-git-send-email-xlpang@126.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rtc-linux@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>, Alessandro Zummo <a.zummo@towertech.it>, John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-tegra@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ralf Baechle <ralf@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>, Xunlei Pang <pang.xunlei@linaro.org>
List-Id: linux-omap@vger.kernel.org

From: Xunlei Pang <pang.xunlei@linaro.org>

As part of addressing "y2038 problem" for in-kernel uses, this
patch converts read_boot_clock() to read_boot_clock64() and
read_persistent_clock() to read_persistent_clock64() using
timespec64 by converting clock_access_fn to use timespec64.

Signed-off-by: Xunlei Pang <pang.xunlei@linaro.org>
---
 arch/arm/include/asm/mach/time.h    |  3 +--
 arch/arm/kernel/time.c              |  6 +++---
 arch/arm/plat-omap/counter_32k.c    | 10 +---------
 drivers/clocksource/tegra20_timer.c | 10 +---------
 4 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/arch/arm/include/asm/mach/time.h b/arch/arm/include/asm/mach/time.h
index 90c12e1..0f79e4d 100644
--- a/arch/arm/include/asm/mach/time.h
+++ b/arch/arm/include/asm/mach/time.h
@@ -12,8 +12,7 @@
 
 extern void timer_tick(void);
 
-struct timespec;
-typedef void (*clock_access_fn)(struct timespec *);
+typedef void (*clock_access_fn)(struct timespec64 *);
 extern int register_persistent_clock(clock_access_fn read_boot,
 				     clock_access_fn read_persistent);
 
diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index 0cc7e58..a66e37e 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -76,7 +76,7 @@ void timer_tick(void)
 }
 #endif
 
-static void dummy_clock_access(struct timespec *ts)
+static void dummy_clock_access(struct timespec64 *ts)
 {
 	ts->tv_sec = 0;
 	ts->tv_nsec = 0;
@@ -85,12 +85,12 @@ static void dummy_clock_access(struct timespec *ts)
 static clock_access_fn __read_persistent_clock = dummy_clock_access;
 static clock_access_fn __read_boot_clock = dummy_clock_access;;
 
-void read_persistent_clock(struct timespec *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
 	__read_persistent_clock(ts);
 }
 
-void read_boot_clock(struct timespec *ts)
+void read_boot_clock64(struct timespec64 *ts)
 {
 	__read_boot_clock(ts);
 }
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index d422e36..aee17ff 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -70,14 +70,6 @@ static void omap_read_persistent_clock64(struct timespec64 *ts)
 	*ts = persistent_ts;
 }
 
-static void omap_read_persistent_clock(struct timespec *ts)
-{
-	struct timespec64 ts64;
-
-	omap_read_persistent_clock64(&ts64);
-	*ts = timespec64_to_timespec(ts64);
-}
-
 /**
  * omap_init_clocksource_32k - setup and register counter 32k as a
  * kernel clocksource
@@ -118,7 +110,7 @@ int __init omap_init_clocksource_32k(void __iomem *vbase)
 	}
 
 	sched_clock_register(omap_32k_read_sched_clock, 32, 32768);
-	register_persistent_clock(NULL, omap_read_persistent_clock);
+	register_persistent_clock(NULL, omap_read_persistent_clock64);
 	pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
 
 	return 0;
diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index 7fc7fb9..8547742 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -141,14 +141,6 @@ static void tegra_read_persistent_clock64(struct timespec64 *ts)
 	*ts = persistent_ts;
 }
 
-static void tegra_read_persistent_clock(struct timespec *ts)
-{
-	struct timespec ts64;
-
-	tegra_read_persistent_clock64(&ts64);
-	*ts = timespec64_to_timespec(ts64);
-}
-
 static unsigned long tegra_delay_timer_read_counter_long(void)
 {
 	return readl(timer_reg_base + TIMERUS_CNTR_1US);
@@ -259,7 +251,7 @@ static void __init tegra20_init_rtc(struct device_node *np)
 	else
 		clk_prepare_enable(clk);
 
-	register_persistent_clock(NULL, tegra_read_persistent_clock);
+	register_persistent_clock(NULL, tegra_read_persistent_clock64);
 }
 CLOCKSOURCE_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
 
-- 
1.9.1
