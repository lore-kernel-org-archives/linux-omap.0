From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/5] ARM: smp: Select local timers vs dummy timer support runtime
Date: Sat, 12 Feb 2011 16:59:43 +0530
Message-ID: <1297510187-31547-2-git-send-email-santosh.shilimkar@ti.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46420 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245Ab1BLLam (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 12 Feb 2011 06:30:42 -0500
In-Reply-To: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <linux@arm.linux.org.uk>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Kukjin Kim <kgene.kim@samsung.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Colin Cross <ccross@android.com>, Erik Gilling <konkers@android.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

The current code support of dummy timers in absence of local
timer is compile time. This is an attempt to convert it to runtime
so that on few SOC version if the local timers aren't supported
kernel can switch to dummy timers. OMAP4430 ES1.0 does suffer from
this limitation.

This patch should not have any functional impact on affected
files.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@codeaurora.org>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Colin Cross <ccross@android.com>
Cc: Erik Gilling <konkers@android.com>
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/include/asm/localtimer.h   |    8 +++++++-
 arch/arm/kernel/smp.c               |    7 +++----
 arch/arm/mach-msm/timer.c           |    3 ++-
 arch/arm/mach-omap2/timer-mpu.c     |    3 ++-
 arch/arm/mach-realview/localtimer.c |    3 ++-
 arch/arm/mach-s5pv310/localtimer.c  |    3 ++-
 arch/arm/mach-shmobile/localtimer.c |    3 ++-
 arch/arm/mach-tegra/localtimer.c    |    3 ++-
 arch/arm/mach-ux500/localtimer.c    |    3 ++-
 arch/arm/mach-vexpress/localtimer.c |    3 ++-
 10 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
index 6bc63ab..080d74f 100644
--- a/arch/arm/include/asm/localtimer.h
+++ b/arch/arm/include/asm/localtimer.h
@@ -44,8 +44,14 @@ int local_timer_ack(void);
 /*
  * Setup a local timer interrupt for a CPU.
  */
-void local_timer_setup(struct clock_event_device *);
+int local_timer_setup(struct clock_event_device *);
 
+#else
+
+static inline int local_timer_setup(struct clock_event_device *evt)
+{
+	return -ENXIO;
+}
 #endif
 
 #endif
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 4539ebc..7b9cc53 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -474,13 +474,12 @@ static void smp_timer_broadcast(const struct cpumask *mask)
 #define smp_timer_broadcast	NULL
 #endif
 
-#ifndef CONFIG_LOCAL_TIMERS
 static void broadcast_timer_set_mode(enum clock_event_mode mode,
 	struct clock_event_device *evt)
 {
 }
 
-static void local_timer_setup(struct clock_event_device *evt)
+static void dummy_timer_setup(struct clock_event_device *evt)
 {
 	evt->name	= "dummy_timer";
 	evt->features	= CLOCK_EVT_FEAT_ONESHOT |
@@ -492,7 +491,6 @@ static void local_timer_setup(struct clock_event_device *evt)
 
 	clockevents_register_device(evt);
 }
-#endif
 
 void __cpuinit percpu_timer_setup(void)
 {
@@ -502,7 +500,8 @@ void __cpuinit percpu_timer_setup(void)
 	evt->cpumask = cpumask_of(cpu);
 	evt->broadcast = smp_timer_broadcast;
 
-	local_timer_setup(evt);
+	if (local_timer_setup(evt))
+		dummy_timer_setup(evt);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index c105d28..ae85aa9 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -255,7 +255,7 @@ static void __init msm_timer_init(void)
 }
 
 #ifdef CONFIG_SMP
-void __cpuinit local_timer_setup(struct clock_event_device *evt)
+int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
 	struct msm_clock *clock = &msm_clocks[MSM_GLOBAL_TIMER];
 
@@ -287,6 +287,7 @@ void __cpuinit local_timer_setup(struct clock_event_device *evt)
 	gic_enable_ppi(clock->irq.irq);
 
 	clockevents_register_device(evt);
+	return 0;
 }
 
 inline int local_timer_ack(void)
diff --git a/arch/arm/mach-omap2/timer-mpu.c b/arch/arm/mach-omap2/timer-mpu.c
index 954682e..09c73dc 100644
--- a/arch/arm/mach-omap2/timer-mpu.c
+++ b/arch/arm/mach-omap2/timer-mpu.c
@@ -26,9 +26,10 @@
 /*
  * Setup the local clock events for a CPU.
  */
-void __cpuinit local_timer_setup(struct clock_event_device *evt)
+int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
 	evt->irq = OMAP44XX_IRQ_LOCALTIMER;
 	twd_timer_setup(evt);
+	return 0;
 }
 
diff --git a/arch/arm/mach-realview/localtimer.c b/arch/arm/mach-realview/localtimer.c
index 60b4e11..aca29ce 100644
--- a/arch/arm/mach-realview/localtimer.c
+++ b/arch/arm/mach-realview/localtimer.c
@@ -19,8 +19,9 @@
 /*
  * Setup the local clock events for a CPU.
  */
-void __cpuinit local_timer_setup(struct clock_event_device *evt)
+int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
 	evt->irq = IRQ_LOCALTIMER;
 	twd_timer_setup(evt);
+	return 0;
 }
diff --git a/arch/arm/mach-s5pv310/localtimer.c b/arch/arm/mach-s5pv310/localtimer.c
index 2784036..8239c6a 100644
--- a/arch/arm/mach-s5pv310/localtimer.c
+++ b/arch/arm/mach-s5pv310/localtimer.c
@@ -18,8 +18,9 @@
 /*
  * Setup the local clock events for a CPU.
  */
-void __cpuinit local_timer_setup(struct clock_event_device *evt)
+int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
 	evt->irq = IRQ_LOCALTIMER;
 	twd_timer_setup(evt);
+	return 0;
 }
diff --git a/arch/arm/mach-shmobile/localtimer.c b/arch/arm/mach-shmobile/localtimer.c
index 2111c28..ad9ccc9 100644
--- a/arch/arm/mach-shmobile/localtimer.c
+++ b/arch/arm/mach-shmobile/localtimer.c
@@ -18,8 +18,9 @@
 /*
  * Setup the local clock events for a CPU.
  */
-void __cpuinit local_timer_setup(struct clock_event_device *evt)
+int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
 	evt->irq = 29;
 	twd_timer_setup(evt);
+	return 0;
 }
diff --git a/arch/arm/mach-tegra/localtimer.c b/arch/arm/mach-tegra/localtimer.c
index f81ca7c..e91d681 100644
--- a/arch/arm/mach-tegra/localtimer.c
+++ b/arch/arm/mach-tegra/localtimer.c
@@ -18,8 +18,9 @@
 /*
  * Setup the local clock events for a CPU.
  */
-void __cpuinit local_timer_setup(struct clock_event_device *evt)
+int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
 	evt->irq = IRQ_LOCALTIMER;
 	twd_timer_setup(evt);
+	return 0;
 }
diff --git a/arch/arm/mach-ux500/localtimer.c b/arch/arm/mach-ux500/localtimer.c
index 2288f6a..5ba1133 100644
--- a/arch/arm/mach-ux500/localtimer.c
+++ b/arch/arm/mach-ux500/localtimer.c
@@ -21,8 +21,9 @@
 /*
  * Setup the local clock events for a CPU.
  */
-void __cpuinit local_timer_setup(struct clock_event_device *evt)
+int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
 	evt->irq = IRQ_LOCALTIMER;
 	twd_timer_setup(evt);
+	return 0;
 }
diff --git a/arch/arm/mach-vexpress/localtimer.c b/arch/arm/mach-vexpress/localtimer.c
index c0e3a59..e5adbfa 100644
--- a/arch/arm/mach-vexpress/localtimer.c
+++ b/arch/arm/mach-vexpress/localtimer.c
@@ -19,8 +19,9 @@
 /*
  * Setup the local clock events for a CPU.
  */
-void __cpuinit local_timer_setup(struct clock_event_device *evt)
+int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
 	evt->irq = IRQ_LOCALTIMER;
 	twd_timer_setup(evt);
+	return 0;
 }
-- 
1.6.0.4

