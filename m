From: Rob Herring <robherring2@gmail.com>
Subject: [PATCH] ARM: smp_twd: convert to use CLKSRC_OF init
Date: Thu,  7 Feb 2013 14:53:05 -0600
Message-ID: <1360270385-24335-1-git-send-email-robherring2@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:35107 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757676Ab3BGUxV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Feb 2013 15:53:21 -0500
Received: by mail-oa0-f47.google.com with SMTP id o17so3365826oag.34
        for <linux-omap@vger.kernel.org>; Thu, 07 Feb 2013 12:53:20 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: arm@kernel.org, Rob Herring <rob.herring@calxeda.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.linux@gmail.com>, Shiraz Hashim <shiraz.hashim@st.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, spear-devel@list.st.com

From: Rob Herring <rob.herring@calxeda.com>

Now that we have OF based init with CLKSRC_OF, convert smp_twd init
function to use it and covert all callers of
twd_local_timer_of_register.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Shiraz Hashim <shiraz.hashim@st.com>
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: John Stultz <johnstul@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-omap@vger.kernel.org
Cc: spear-devel@list.st.com
---

This is dependent on my previous series:

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-February/148313.html

 arch/arm/Kconfig                    |    1 +
 arch/arm/include/asm/smp_twd.h      |    8 --------
 arch/arm/kernel/smp_twd.c           |   17 ++++-------------
 arch/arm/mach-highbank/highbank.c   |    5 ++---
 arch/arm/mach-imx/mach-imx6q.c      |    3 +--
 arch/arm/mach-omap2/timer.c         |    2 +-
 arch/arm/mach-spear13xx/spear13xx.c |    3 +--
 arch/arm/mach-ux500/timer.c         |    2 +-
 arch/arm/mach-vexpress/v2m.c        |    4 ++--
 drivers/clocksource/tegra20_timer.c |    3 ---
 10 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index bd30fe6..d530b60 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1570,6 +1570,7 @@ config ARM_ARCH_TIMER
 config HAVE_ARM_TWD
 	bool
 	depends on SMP
+	select CLKSRC_OF if OF
 	help
 	  This options enables support for the ARM timer and watchdog unit
 
diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index 0f01f46..7b2899c 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -34,12 +34,4 @@ struct twd_local_timer name __initdata = {	\
 
 int twd_local_timer_register(struct twd_local_timer *);
 
-#ifdef CONFIG_HAVE_ARM_TWD
-void twd_local_timer_of_register(void);
-#else
-static inline void twd_local_timer_of_register(void)
-{
-}
-#endif
-
 #endif
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index dc9bb01..963852e 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -376,22 +376,10 @@ int __init twd_local_timer_register(struct twd_local_timer *tlt)
 }
 
 #ifdef CONFIG_OF
-const static struct of_device_id twd_of_match[] __initconst = {
-	{ .compatible = "arm,cortex-a9-twd-timer",	},
-	{ .compatible = "arm,cortex-a5-twd-timer",	},
-	{ .compatible = "arm,arm11mp-twd-timer",	},
-	{ },
-};
-
-void __init twd_local_timer_of_register(void)
+static void __init twd_local_timer_of_register(struct device_node *np)
 {
-	struct device_node *np;
 	int err;
 
-	np = of_find_matching_node(NULL, twd_of_match);
-	if (!np)
-		return;
-
 	twd_ppi = irq_of_parse_and_map(np, 0);
 	if (!twd_ppi) {
 		err = -EINVAL;
@@ -409,4 +397,7 @@ void __init twd_local_timer_of_register(void)
 out:
 	WARN(err, "twd_local_timer_of_register failed (%d)\n", err);
 }
+CLOCKSOURCE_OF_DECLARE(arm_twd_a9, "arm,cortex-a9-twd-timer", twd_local_timer_of_register);
+CLOCKSOURCE_OF_DECLARE(arm_twd_a5, "arm,cortex-a5-twd-timer", twd_local_timer_of_register);
+CLOCKSOURCE_OF_DECLARE(arm_twd_11mp, "arm,arm11mp-twd-timer", twd_local_timer_of_register);
 #endif
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 70abc27..6abf987 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -31,7 +31,6 @@
 #include <asm/cacheflush.h>
 #include <asm/cputype.h>
 #include <asm/smp_plat.h>
-#include <asm/smp_twd.h>
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/timer-sp.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -118,10 +117,10 @@ static void __init highbank_timer_init(void)
 	sp804_clocksource_and_sched_clock_init(timer_base + 0x20, "timer1");
 	sp804_clockevents_init(timer_base, irq, "timer0");
 
-	twd_local_timer_of_register();
-
 	arch_timer_of_register();
 	arch_timer_sched_clock_init();
+
+	clocksource_of_init();
 }
 
 static void highbank_power_off(void)
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 1786b2d..089cb10 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -26,7 +26,6 @@
 #include <linux/regmap.h>
 #include <linux/micrel_phy.h>
 #include <linux/mfd/syscon.h>
-#include <asm/smp_twd.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -227,7 +226,7 @@ static void __init imx6q_init_irq(void)
 static void __init imx6q_timer_init(void)
 {
 	mx6q_clocks_init();
-	twd_local_timer_of_register();
+	clocksource_of_init();
 	imx_print_silicon_rev("i.MX6Q", imx6q_revision());
 }
 
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 2822833..9317861 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -597,7 +597,7 @@ void __init omap4_local_timer_init(void)
 		int err;
 
 		if (of_have_populated_dt()) {
-			twd_local_timer_of_register();
+			clocksource_of_init();
 			return;
 		}
 
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index c7d2b4a..ea5a693 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -20,7 +20,6 @@
 #include <linux/of.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/map.h>
-#include <asm/smp_twd.h>
 #include <mach/dma.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
@@ -179,5 +178,5 @@ void __init spear13xx_timer_init(void)
 	clk_put(pclk);
 
 	spear_setup_of_timer();
-	twd_local_timer_of_register();
+	clocksource_of_init();
 }
diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index a6af0b8..e9c57f2 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -32,7 +32,7 @@ static void __init ux500_twd_init(void)
 	twd_local_timer = &u8500_twd_local_timer;
 
 	if (of_have_populated_dt())
-		twd_local_timer_of_register();
+		clocksource_of_init();
 	else {
 		err = twd_local_timer_register(twd_local_timer);
 		if (err)
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 915683c..e5f5fe7 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -435,6 +435,7 @@ static void __init v2m_dt_timer_init(void)
 
 	vexpress_clk_of_init();
 
+	clocksource_of_init();
 	do {
 		node = of_find_compatible_node(node, NULL, "arm,sp804");
 	} while (node && vexpress_get_site_by_node(node) != VEXPRESS_SITE_MB);
@@ -445,8 +446,7 @@ static void __init v2m_dt_timer_init(void)
 				irq_of_parse_and_map(node, 0));
 	}
 
-	if (arch_timer_of_register() != 0)
-		twd_local_timer_of_register();
+	arch_timer_of_register();
 
 	if (arch_timer_sched_clock_init() != 0)
 		versatile_sched_clock_init(vexpress_get_24mhz_clock_base(),
diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index 15cc723..2e4d8a6 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -218,9 +218,6 @@ static void __init tegra20_init_timer(struct device_node *np)
 	tegra_clockevent.irq = tegra_timer_irq.irq;
 	clockevents_config_and_register(&tegra_clockevent, 1000000,
 					0x1, 0x1fffffff);
-#ifdef CONFIG_HAVE_ARM_TWD
-	twd_local_timer_of_register();
-#endif
 }
 CLOCKSOURCE_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra20_init_timer);
 
-- 
1.7.10.4

