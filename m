From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 3/8] arm: time: Remove the persistent clock support for ARM architecture
Date: Wed, 13 Jun 2018 19:32:30 +0800
Message-ID: <ec57a4f5d7ba300540b99236e6eef1b551b152dc.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, john.stultz@linaro.org, daniel.lezcano@linaro.org, arnd@arndb.de, tony@atomide.com, aaro.koskinen@iki.fi, linux@armlinux.org.uk, mark.rutland@arm.com, marc.zyngier@arm.com
Cc: baolin.wang@linaro.org, broonie@kernel.org, paulmck@linux.vnet.ibm.com, mlichvar@redhat.com, rdunlap@infradead.org, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, thierry.reding@gmail.com, jonathanh@nvidia.com, heiko@sntech.de, linus.walleij@linaro.org, viresh.kumar@linaro.org, mingo@kernel.org, hpa@zytor.com, peterz@infradead.org, douly.fnst@cn.fujitsu.com, len.brown@intel.com, rajvi.jingar@intel.com, alexandre.belloni@bootlin.com, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We have introduced the persistent clock framework to support the OS time
compensating from persistent clock, and we will convert all drivers to
use common persistent clock framework instead of the persistent clock
support used only for the ARM architecture. So we can remove these code
with converting the Omap 32k counter and tegra20 timer.

Moreover there are no drivers will register read_boot_clock64(), so
remove it too.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm/include/asm/mach/time.h    |    4 ----
 arch/arm/kernel/time.c              |   36 ----------------------------
 arch/arm/plat-omap/Kconfig          |    1 +
 arch/arm/plat-omap/counter_32k.c    |   44 ++++++-----------------------------
 drivers/clocksource/tegra20_timer.c |   12 +++++++---
 5 files changed, 17 insertions(+), 80 deletions(-)

diff --git a/arch/arm/include/asm/mach/time.h b/arch/arm/include/asm/mach/time.h
index 0f79e4d..3cbcafc 100644
--- a/arch/arm/include/asm/mach/time.h
+++ b/arch/arm/include/asm/mach/time.h
@@ -12,8 +12,4 @@
 
 extern void timer_tick(void);
 
-typedef void (*clock_access_fn)(struct timespec64 *);
-extern int register_persistent_clock(clock_access_fn read_boot,
-				     clock_access_fn read_persistent);
-
 #endif
diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index cf2701c..713905c 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -76,42 +76,6 @@ void timer_tick(void)
 }
 #endif
 
-static void dummy_clock_access(struct timespec64 *ts)
-{
-	ts->tv_sec = 0;
-	ts->tv_nsec = 0;
-}
-
-static clock_access_fn __read_persistent_clock = dummy_clock_access;
-static clock_access_fn __read_boot_clock = dummy_clock_access;
-
-void read_persistent_clock64(struct timespec64 *ts)
-{
-	__read_persistent_clock(ts);
-}
-
-void read_boot_clock64(struct timespec64 *ts)
-{
-	__read_boot_clock(ts);
-}
-
-int __init register_persistent_clock(clock_access_fn read_boot,
-				     clock_access_fn read_persistent)
-{
-	/* Only allow the clockaccess functions to be registered once */
-	if (__read_persistent_clock == dummy_clock_access &&
-	    __read_boot_clock == dummy_clock_access) {
-		if (read_boot)
-			__read_boot_clock = read_boot;
-		if (read_persistent)
-			__read_persistent_clock = read_persistent;
-
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
 void __init time_init(void)
 {
 	if (machine_desc->init_time) {
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index c0a242c..073a80f 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 config ARCH_OMAP
+	select PERSISTENT_CLOCK
 	bool
 
 if ARCH_OMAP
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 2438b96..5d52f7c 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -19,8 +19,7 @@
 #include <linux/io.h>
 #include <linux/clocksource.h>
 #include <linux/sched_clock.h>
-
-#include <asm/mach/time.h>
+#include <linux/persistent_clock.h>
 
 #include <plat/counter-32k.h>
 
@@ -44,33 +43,6 @@ static u64 notrace omap_32k_read_sched_clock(void)
 }
 
 /**
- * omap_read_persistent_clock64 -  Return time from a persistent clock.
- *
- * Reads the time from a source which isn't disabled during PM, the
- * 32k sync timer.  Convert the cycles elapsed since last read into
- * nsecs and adds to a monotonically increasing timespec64.
- */
-static struct timespec64 persistent_ts;
-static cycles_t cycles;
-static unsigned int persistent_mult, persistent_shift;
-
-static void omap_read_persistent_clock64(struct timespec64 *ts)
-{
-	unsigned long long nsecs;
-	cycles_t last_cycles;
-
-	last_cycles = cycles;
-	cycles = sync32k_cnt_reg ? readl_relaxed(sync32k_cnt_reg) : 0;
-
-	nsecs = clocksource_cyc2ns(cycles - last_cycles,
-					persistent_mult, persistent_shift);
-
-	timespec64_add_ns(&persistent_ts, nsecs);
-
-	*ts = persistent_ts;
-}
-
-/**
  * omap_init_clocksource_32k - setup and register counter 32k as a
  * kernel clocksource
  * @pbase: base addr of counter_32k module
@@ -95,13 +67,6 @@ int __init omap_init_clocksource_32k(void __iomem *vbase)
 	else
 		sync32k_cnt_reg = vbase + OMAP2_32KSYNCNT_CR_OFF_LOW;
 
-	/*
-	 * 120000 rough estimate from the calculations in
-	 * __clocksource_update_freq_scale.
-	 */
-	clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
-			32768, NSEC_PER_SEC, 120000);
-
 	ret = clocksource_mmio_init(sync32k_cnt_reg, "32k_counter", 32768,
 				250, 32, clocksource_mmio_readl_up);
 	if (ret) {
@@ -110,7 +75,12 @@ int __init omap_init_clocksource_32k(void __iomem *vbase)
 	}
 
 	sched_clock_register(omap_32k_read_sched_clock, 32, 32768);
-	register_persistent_clock(NULL, omap_read_persistent_clock64);
+	/*
+	 * 120000 rough estimate from the calculations in
+	 * __clocksource_update_freq_scale.
+	 */
+	persistent_clock_init_and_register(omap_32k_read_sched_clock,
+					   CLOCKSOURCE_MASK(32), 32768, 120000);
 	pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
 
 	return 0;
diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index c337a81..97a34cb 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -124,7 +124,7 @@ static u64 tegra_rtc_read_ms(void)
 }
 
 /*
- * tegra_read_persistent_clock64 -  Return time from a persistent clock.
+ * read_persistent_clock64 -  Return time from a persistent clock.
  *
  * Reads the time from a source which isn't disabled during PM, the
  * 32k sync timer.  Convert the cycles elapsed since last read into
@@ -133,10 +133,16 @@ static u64 tegra_rtc_read_ms(void)
  * tegra_rtc driver could be executing to avoid race conditions
  * on the RTC shadow register
  */
-static void tegra_read_persistent_clock64(struct timespec64 *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
 	u64 delta;
 
+	if (!rtc_base) {
+		ts->tv_sec = 0;
+		ts->tv_nsec = 0;
+		return;
+	}
+
 	last_persistent_ms = persistent_ms;
 	persistent_ms = tegra_rtc_read_ms();
 	delta = persistent_ms - last_persistent_ms;
@@ -259,6 +265,6 @@ static int __init tegra20_init_rtc(struct device_node *np)
 	else
 		clk_prepare_enable(clk);
 
-	return register_persistent_clock(NULL, tegra_read_persistent_clock64);
+	return 0;
 }
 TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
-- 
1.7.9.5
