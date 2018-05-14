From: Baolin Wang <baolin.wang@linaro.org>
Subject: [RFC PATCH 03/10] arm: omap: Convert 32K counter to use persistent clock
Date: Mon, 14 May 2018 16:55:29 +0800
Message-ID: <de967681dbea8c61bd2e33394572d5d7ed6face5.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, john.stultz@linaro.org, daniel.lezcano@linaro.org, arnd@arndb.de, tony@atomide.com, aaro.koskinen@iki.fi, linux@armlinux.org.uk, mark.rutland@arm.com, marc.zyngier@arm.com
Cc: baolin.wang@linaro.org, broonie@kernel.org, paulmck@linux.vnet.ibm.com, mlichvar@redhat.com, rdunlap@infradead.org, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, thierry.reding@gmail.com, jonathanh@nvidia.com, heiko@sntech.de, linus.walleij@linaro.org, viresh.kumar@linaro.org, mingo@kernel.org, hpa@zytor.com, peterz@infradead.org, douly.fnst@cn.fujitsu.com, len.brown@intel.com, rajvi.jingar@intel.com, alexandre.belloni@bootlin.com, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We have introduced the persistent clock framework to support the OS time
compensating from persistent clock, so this patch converts the 32k counter
to use persistent clock framework to save lots of duplicate code.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm/plat-omap/Kconfig       |    1 +
 arch/arm/plat-omap/counter_32k.c |   44 ++++++--------------------------------
 2 files changed, 8 insertions(+), 37 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index afc1a1d..0e4e385 100644
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
-- 
1.7.9.5
