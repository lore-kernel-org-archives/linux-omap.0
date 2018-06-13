From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 4/8] clocksource: arm_arch_timer: Register the persistent clock
Date: Wed, 13 Jun 2018 19:32:31 +0800
Message-ID: <5b450836ee0db88de27d47e43368de02c550425b.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, john.stultz@linaro.org, daniel.lezcano@linaro.org, arnd@arndb.de, tony@atomide.com, aaro.koskinen@iki.fi, linux@armlinux.org.uk, mark.rutland@arm.com, marc.zyngier@arm.com
Cc: baolin.wang@linaro.org, broonie@kernel.org, paulmck@linux.vnet.ibm.com, mlichvar@redhat.com, rdunlap@infradead.org, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, thierry.reding@gmail.com, jonathanh@nvidia.com, heiko@sntech.de, linus.walleij@linaro.org, viresh.kumar@linaro.org, mingo@kernel.org, hpa@zytor.com, peterz@infradead.org, douly.fnst@cn.fujitsu.com, len.brown@intel.com, rajvi.jingar@intel.com, alexandre.belloni@bootlin.com, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Register the persistent clock to compensate the suspend time for OS time,
if the ARM counter clocksource will not be stopped in suspend state.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/clocksource/Kconfig          |    1 +
 drivers/clocksource/arm_arch_timer.c |   10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 7f11c6c..5e51fcf 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -308,6 +308,7 @@ config ARC_TIMERS_64BIT
 
 config ARM_ARCH_TIMER
 	bool
+	select PERSISTENT_CLOCK
 	select TIMER_OF if OF
 	select TIMER_ACPI if ACPI
 
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 57cb2f0..671be63 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -32,6 +32,7 @@
 #include <asm/virt.h>
 
 #include <clocksource/arm_arch_timer.h>
+#include <linux/persistent_clock.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt) "arch_timer: " fmt
@@ -950,6 +951,15 @@ static void __init arch_counter_register(unsigned type)
 
 	/* 56 bits minimum, so we assume worst case rollover */
 	sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
+
+	/*
+	 * Register the persistent clock if the clocksource will not be stopped
+	 * in suspend state.
+	 */
+	if (!arch_counter_suspend_stop)
+		persistent_clock_init_and_register(arch_timer_read_counter,
+						   CLOCKSOURCE_MASK(56),
+						   arch_timer_rate, 0);
 }
 
 static void arch_timer_stop(struct clock_event_device *clk)
-- 
1.7.9.5
