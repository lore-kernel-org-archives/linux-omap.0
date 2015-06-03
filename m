From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
Date: Wed, 3 Jun 2015 15:32:45 -0500
Message-ID: <1433363565-17725-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47757 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756356AbbFCUfi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Jun 2015 16:35:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Hi Tony and Russell,

AM43xx, even though it's a single processor A9, it still has TWD and global
timer. I was doing some profiling with RT v4.0 and latency is 3.5x lower just
by switching from gptimer to twd/global.

The only problem is that currently, is_smp() check prevents me from using twd
with AM43xx (that's why it's commented below, for testing purposes).

In the hopes that we can start a, hopefully, small thread around the subject,
I'm sending this HACK which I used to get TWD and global timer enabled so I
could measure latencies with cyclictest.

Is it so that TWD shouldn't be available on UP integrations of ARM's Cortex-A
processors ?

Regards

 arch/arm/boot/dts/am4372.dtsi       | 19 +++++++++++++++++++
 arch/arm/kernel/smp_twd.c           |  3 +++
 arch/arm/mach-omap2/Kconfig         |  4 ++++
 arch/arm/mach-omap2/board-generic.c |  2 +-
 arch/arm/mach-omap2/timer.c         | 20 +++++++++-----------
 5 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 1943fc333e7c..e782927d1c44 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -50,6 +50,25 @@
 		      <0x48240100 0x0100>;
 	};
 
+	scu@48240000 {
+		compatible = "arm,cortex-a9-scu";
+		reg = <0x48240000 0x100>;
+	};
+
+	global-timer@48240200 {
+		compatible = "arm,cortex-a9-global-timer";
+		reg = <0x48240200 0x100>;
+		interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&dpll_mpu_m2_ck>;
+	};
+
+	local-timer@48240200 {
+		compatible = "arm,cortex-a9-twd-timer";
+		reg = <0x48240600 0x100>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&dpll_mpu_ck>;
+	};
+
 	l2-cache-controller@48242000 {
 		compatible = "arm,pl310-cache";
 		reg = <0x48242000 0x1000>;
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 172c6a05d27f..43c053d836e7 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -388,8 +389,10 @@ static void __init twd_local_timer_of_register(struct device_node *np)
 {
 	int err;
 
+#if 0
 	if (!is_smp() || !setup_max_cpus)
 		return;
+#endif
 
 	twd_ppi = irq_of_parse_and_map(np, 0);
 	if (!twd_ppi) {
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 2b8e47788062..80984f87b020 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -60,6 +60,10 @@ config SOC_AM43XX
 	select ARM_GIC
 	select MACH_OMAP_GENERIC
 	select MIGHT_HAVE_CACHE_L2X0
+	select HAVE_ARM_SCU
+	select HAVE_ARM_TWD
+	select ARM_GLOBAL_TIMER
+	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 
 config SOC_DRA7XX
 	bool "TI DRA7XX"
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 34ff14b7beab..8acb3b4c84e3 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -279,7 +279,7 @@ DT_MACHINE_START(AM43_DT, "Generic AM43 (Flattened Device Tree)")
 	.init_late	= am43xx_init_late,
 	.init_irq	= omap_gic_of_init,
 	.init_machine	= omap_generic_init,
-	.init_time	= omap3_gptimer_timer_init,
+	.init_time	= omap4_local_timer_init,
 	.dt_compat	= am43_boards_compat,
 	.restart	= omap44xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index cef67af9e9b8..0031f56f50b1 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -655,20 +655,18 @@ static OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_ck", "ti,timer-alwon",
 static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, OMAP44XX_LOCAL_TWD_BASE, 29);
 void __init omap4_local_timer_init(void)
 {
+	int err;
+
 	omap4_sync32k_timer_init();
 	/* Local timers are not supprted on OMAP4430 ES1.0 */
-	if (omap_rev() != OMAP4430_REV_ES1_0) {
-		int err;
-
-		if (of_have_populated_dt()) {
-			clocksource_of_init();
-			return;
-		}
-
-		err = twd_local_timer_register(&twd_local_timer);
-		if (err)
-			pr_err("twd_local_timer_register failed %d\n", err);
+	if (of_have_populated_dt()) {
+		clocksource_of_init();
+		return;
 	}
+
+	err = twd_local_timer_register(&twd_local_timer);
+	if (err)
+		pr_err("twd_local_timer_register failed %d\n", err);
 }
 #else
 void __init omap4_local_timer_init(void)
-- 
2.4.0.rc3

