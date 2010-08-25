From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH] OMAP2: add cpuidle and cpufreq events tracing
Date: Wed, 25 Aug 2010 17:21:22 +0200
Message-ID: <AANLkTim-n+3sTzrxKStniAjHFWxGx4xVAf=FkZ4U282f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:40444 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab0HYPVY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Aug 2010 11:21:24 -0400
Received: by qyk9 with SMTP id 9so4959339qyk.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Aug 2010 08:21:23 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

>From 28198d2d297216fd9fa3e00513e9470f50761c19 Mon Sep 17 00:00:00 2001
From: Jean Pihet <jean.pihet@newoldbits.com>
Date: Wed, 25 Aug 2010 17:05:48 +0200
Subject: [PATCH] OMAP2: add cpuidle and cpufreq events tracing

Add the cpuidle power_start and power_end events. The state
parameter of power_start has the following meaning:
- -1: from the suspend handler (omap3_pm_suspend),
- 1: from the default idle handler (omap3_pm_idle),
- other values are the C-states from the cpuidle handler
   (omap3_enter_idle).

Add the cpufreq power_frequency event, with the state
parameter being the target CPU frequency.

Cf. http://omappedia.org/wiki/Power_Management_Debug_and_Profiling
for more details on PM debug and profiling.

Signed-off-by: Jean Pihet <jpihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    2 ++
 arch/arm/mach-omap2/pm34xx.c      |    4 ++++
 arch/arm/plat-omap/cpu-omap.c     |    5 ++++-
 3 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c
b/arch/arm/mach-omap2/cpuidle34xx.c
index 3d3d035..6113bd9 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -24,6 +24,7 @@

 #include <linux/sched.h>
 #include <linux/cpuidle.h>
+#include <trace/events/power.h>

 #include <plat/prcm.h>
 #include <plat/irqs.h>
@@ -130,6 +131,7 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	local_irq_disable();
 	local_fiq_disable();

+	trace_power_start(POWER_CSTATE, cx->type, smp_processor_id());
 	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
 	pwrdm_set_next_pwrst(core_pd, core_state);

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index f25bc3d..ea3b816 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -28,6 +28,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <trace/events/power.h>

 #include <plat/sram.h>
 #include <plat/clockdomain.h>
@@ -588,6 +589,7 @@ static void omap3_pm_idle(void)
 	if (omap_irq_pending() || need_resched())
 		goto out;

+	trace_power_start(POWER_CSTATE, 1, smp_processor_id());
 	omap_sram_idle();

 out:
@@ -628,6 +630,8 @@ static int omap3_pm_suspend(void)
 		omap2_pm_wakeup_on_timer(wakeup_timer_seconds,
 					 wakeup_timer_milliseconds);

+	trace_power_start(POWER_CSTATE, -1, smp_processor_id());
+
 	/* Read current next_pwrsts */
 	list_for_each_entry(pwrst, &pwrst_list, node)
 		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst->pwrdm);
diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index df08829..cc4e41f 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -25,6 +25,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <trace/events/power.h>

 #include <mach/hardware.h>
 #include <plat/clock.h>
@@ -116,8 +117,10 @@ static int omap_target(struct cpufreq_policy *policy,
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 #elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
 	freq = target_freq * 1000;
-	if (opp_find_freq_ceil(mpu_dev, &freq))
+	if (opp_find_freq_ceil(mpu_dev, &freq)) {
+		trace_power_frequency(POWER_PSTATE, freq, smp_processor_id());
 		omap_pm_cpu_set_freq(freq);
+	}
 #endif
 	return ret;
 }
-- 
1.7.1
