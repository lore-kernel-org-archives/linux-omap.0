From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 5/8] clocksource: timer-ti-32k: Register the persistent clock
Date: Wed, 13 Jun 2018 19:32:32 +0800
Message-ID: <904493423cadb90576a712acdb3b512b4ed44887.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, john.stultz@linaro.org, daniel.lezcano@linaro.org, arnd@arndb.de, tony@atomide.com, aaro.koskinen@iki.fi, linux@armlinux.org.uk, mark.rutland@arm.com, marc.zyngier@arm.com
Cc: baolin.wang@linaro.org, broonie@kernel.org, paulmck@linux.vnet.ibm.com, mlichvar@redhat.com, rdunlap@infradead.org, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, thierry.reding@gmail.com, jonathanh@nvidia.com, heiko@sntech.de, linus.walleij@linaro.org, viresh.kumar@linaro.org, mingo@kernel.org, hpa@zytor.com, peterz@infradead.org, douly.fnst@cn.fujitsu.com, len.brown@intel.com, rajvi.jingar@intel.com, alexandre.belloni@bootlin.com, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Since the 32K counter is always available, then we can register the
persistent clock to compensate the suspend time for the OS time.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/clocksource/Kconfig        |    1 +
 drivers/clocksource/timer-ti-32k.c |    4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5e51fcf..3cd136f 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -262,6 +262,7 @@ config CLKSRC_TI_32K
 	bool "Texas Instruments 32.768 Hz Clocksource" if COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK
 	select TIMER_OF if OF
+	select PERSISTENT_CLOCK
 	help
 	  This option enables support for Texas Instruments 32.768 Hz clocksource
 	  available on many OMAP-like platforms.
diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
index 880a861..353ff9d 100644
--- a/drivers/clocksource/timer-ti-32k.c
+++ b/drivers/clocksource/timer-ti-32k.c
@@ -41,6 +41,7 @@
 #include <linux/clocksource.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/persistent_clock.h>
 
 /*
  * 32KHz clocksource ... always available, on pretty most chips except
@@ -120,6 +121,9 @@ static int __init ti_32k_timer_init(struct device_node *np)
 	}
 
 	sched_clock_register(omap_32k_read_sched_clock, 32, 32768);
+	persistent_clock_init_and_register(omap_32k_read_sched_clock,
+					   CLOCKSOURCE_MASK(32), 32768, 0);
+
 	pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
 
 	return 0;
-- 
1.7.9.5
