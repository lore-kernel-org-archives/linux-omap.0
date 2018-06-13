From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 2/8] clocksource: sprd: Add one persistent timer for Spreadtrum platform
Date: Wed, 13 Jun 2018 19:32:29 +0800
Message-ID: <95ec43d6f335e31d6e1da4eb0db522008728363b.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, john.stultz@linaro.org, daniel.lezcano@linaro.org, arnd@arndb.de, tony@atomide.com, aaro.koskinen@iki.fi, linux@armlinux.org.uk, mark.rutland@arm.com, marc.zyngier@arm.com
Cc: baolin.wang@linaro.org, broonie@kernel.org, paulmck@linux.vnet.ibm.com, mlichvar@redhat.com, rdunlap@infradead.org, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, thierry.reding@gmail.com, jonathanh@nvidia.com, heiko@sntech.de, linus.walleij@linaro.org, viresh.kumar@linaro.org, mingo@kernel.org, hpa@zytor.com, peterz@infradead.org, douly.fnst@cn.fujitsu.com, len.brown@intel.com, rajvi.jingar@intel.com, alexandre.belloni@bootlin.com, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Spreadtrum SC9860 platform, we need one persistent timer to calculate
the suspend time to compensate the OS time.

This patch registers one Spreadtrum AON timer as persistent timer, which
runs at 32bit and periodic mode.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/clocksource/Kconfig      |    1 +
 drivers/clocksource/timer-sprd.c |   80 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index dec0dd8..7f11c6c 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -455,6 +455,7 @@ config SPRD_TIMER
 	depends on (ARCH_SPRD || COMPILE_TEST)
 	default ARCH_SPRD
 	select TIMER_OF
+	select PERSISTENT_CLOCK
 	help
 	  Enables support for the Spreadtrum timer driver.
 
diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/timer-sprd.c
index ef9ebea..c6f657a 100644
--- a/drivers/clocksource/timer-sprd.c
+++ b/drivers/clocksource/timer-sprd.c
@@ -3,8 +3,11 @@
  * Copyright (C) 2017 Spreadtrum Communications Inc.
  */
 
+#include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/of_address.h>
+#include <linux/persistent_clock.h>
 
 #include "timer-of.h"
 
@@ -157,3 +160,80 @@ static int __init sprd_timer_init(struct device_node *np)
 }
 
 TIMER_OF_DECLARE(sc9860_timer, "sprd,sc9860-timer", sprd_timer_init);
+
+void __iomem *pbase;
+
+static u64 sprd_persistent_timer_read(void)
+{
+	return ~(u64)readl_relaxed(pbase + TIMER_VALUE_SHDW_LO) &
+		CLOCKSOURCE_MASK(32);
+}
+
+static void sprd_persistent_timer_disable(void)
+{
+	sprd_timer_disable(pbase);
+}
+
+static void sprd_persistent_timer_enable(void)
+{
+	sprd_timer_disable(pbase);
+	sprd_timer_update_counter(pbase, TIMER_VALUE_LO_MASK);
+	sprd_timer_enable(pbase, TIMER_CTL_PERIOD_MODE);
+}
+
+static int __init sprd_persistent_timer_init(struct device_node *np)
+{
+	struct clk *clk;
+	u32 freq;
+	int ret;
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("Can't get timer clock for %pOF\n", np);
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("Failed to enable clock for %pOF\n", np);
+		clk_put(clk);
+		return ret;
+	}
+
+	freq = clk_get_rate(clk);
+	if (!freq) {
+		pr_err("Failed to get clock rate for %pOF\n", np);
+		ret = -EINVAL;
+		goto clk_rate_err;
+	}
+
+	pbase = of_io_request_and_map(np, 0, of_node_full_name(np));
+	if (IS_ERR(pbase)) {
+		pr_err("Can't map timer registers for %pOF\n", np);
+		ret = PTR_ERR(pbase);
+		goto clk_rate_err;
+	}
+
+	sprd_persistent_timer_enable();
+
+	ret = persistent_clock_init_and_register(sprd_persistent_timer_read,
+						 CLOCKSOURCE_MASK(32), freq, 0);
+	if (ret) {
+		pr_err("Failed to register persistent clock for %pOF\n", np);
+		goto persist_err;
+	}
+
+	return 0;
+
+persist_err:
+	sprd_persistent_timer_disable();
+	iounmap(pbase);
+clk_rate_err:
+	clk_disable_unprepare(clk);
+	clk_put(clk);
+
+	return ret;
+}
+
+TIMER_OF_DECLARE(sc9860_persistent_timer, "sprd,sc9860-persistent-timer",
+		 sprd_persistent_timer_init);
-- 
1.7.9.5
