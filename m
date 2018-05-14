From: Baolin Wang <baolin.wang@linaro.org>
Subject: [RFC PATCH 08/10] clocksource: time-pistachio: Register the persistent clock
Date: Mon, 14 May 2018 16:55:34 +0800
Message-ID: <e923209285df7043bd52c136ba85507891b4b059.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, john.stultz@linaro.org, daniel.lezcano@linaro.org, arnd@arndb.de, tony@atomide.com, aaro.koskinen@iki.fi, linux@armlinux.org.uk, mark.rutland@arm.com, marc.zyngier@arm.com
Cc: baolin.wang@linaro.org, broonie@kernel.org, paulmck@linux.vnet.ibm.com, mlichvar@redhat.com, rdunlap@infradead.org, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, thierry.reding@gmail.com, jonathanh@nvidia.com, heiko@sntech.de, linus.walleij@linaro.org, viresh.kumar@linaro.org, mingo@kernel.org, hpa@zytor.com, peterz@infradead.org, douly.fnst@cn.fujitsu.com, len.brown@intel.com, rajvi.jingar@intel.com, alexandre.belloni@bootlin.com, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Since the timer on pistachio platform is always available, we can
register it as one persistent clock to compensate the suspend time
for the OS time.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/clocksource/Kconfig          |    1 +
 drivers/clocksource/time-pistachio.c |    3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index ed19757..b45be75 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -255,6 +255,7 @@ config CLKSRC_PISTACHIO
 	bool "Clocksource for Pistachio SoC" if COMPILE_TEST
 	depends on HAS_IOMEM
 	select TIMER_OF
+	select PERSISTENT_CLOCK
 	help
 	  Enables the clocksource for the Pistachio SoC.
 
diff --git a/drivers/clocksource/time-pistachio.c b/drivers/clocksource/time-pistachio.c
index a2dd85d..5c3eb71 100644
--- a/drivers/clocksource/time-pistachio.c
+++ b/drivers/clocksource/time-pistachio.c
@@ -20,6 +20,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/persistent_clock.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/sched_clock.h>
@@ -212,6 +213,8 @@ static int __init pistachio_clksrc_of_init(struct device_node *node)
 
 	raw_spin_lock_init(&pcs_gpt.lock);
 	sched_clock_register(pistachio_read_sched_clock, 32, rate);
+	persistent_clock_init_and_register(pistachio_read_sched_clock,
+					   CLOCKSOURCE_MASK(32), rate, 0);
 	return clocksource_register_hz(&pcs_gpt.cs, rate);
 }
 TIMER_OF_DECLARE(pistachio_gptimer, "img,pistachio-gptimer",
-- 
1.7.9.5
