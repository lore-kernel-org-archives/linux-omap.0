From: Robert Lee <rob.lee@linaro.org>
Subject: [PATCH v7 3/9] ARM: exynos: Consolidate time keeping and irq enable
Date: Wed, 29 Feb 2012 18:42:52 -0600
Message-ID: <1330562578-3410-4-git-send-email-rob.lee@linaro.org>
References: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48575 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965862Ab2CAAnS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 19:43:18 -0500
Received: by mail-gy0-f174.google.com with SMTP id r11so14604ghr.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 16:43:18 -0800 (PST)
In-Reply-To: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rjw@sisk.pl, len.brown@intel.com
Cc: khilman@ti.com, robherring2@gmail.com, Baohua.Song@csr.com, amit.kucheria@linaro.org, nicolas.ferre@atmel.com, linux@maxim.org.za, kgene.kim@samsung.com, amit.kachhap@linaro.org, magnus.damm@gmail.com, nsekhar@ti.com, daniel.lezcano@linaro.org, mturquette@linaro.org, vincent.guittot@linaro.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com, nicolas.pitre@linaro.org, linux@arm.linux.org.uk, jean.pihet@newoldbits.com, venki@google.com, ccross@google.com, g.trinabh@gmail.com, kernel@wantstofly.org, lethal@linux-sh.org, jon-hunter@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org

Enable core cpuidle timekeeping and irq enabling and remove that
handling from this code.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |   53 ++++-----------------------------------
 1 files changed, 6 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 9bf6743..7794fed 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -20,6 +20,7 @@
 #include <asm/smp_scu.h>
 #include <asm/suspend.h>
 #include <asm/unified.h>
+#include <asm/cpuidle.h>
 #include <mach/regs-pmu.h>
 #include <mach/pmu.h>
 
@@ -34,22 +35,12 @@
 
 #define S5P_CHECK_AFTR		0xFCBA0D10
 
-static int exynos4_enter_idle(struct cpuidle_device *dev,
-			struct cpuidle_driver *drv,
-			      int index);
 static int exynos4_enter_lowpower(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index);
 
 static struct cpuidle_state exynos4_cpuidle_set[] = {
-	[0] = {
-		.enter			= exynos4_enter_idle,
-		.exit_latency		= 1,
-		.target_residency	= 100000,
-		.flags			= CPUIDLE_FLAG_TIME_VALID,
-		.name			= "C0",
-		.desc			= "ARM clock gating(WFI)",
-	},
+	[0] = ARM_CPUIDLE_WFI_STATE,
 	[1] = {
 		.enter			= exynos4_enter_lowpower,
 		.exit_latency		= 300,
@@ -63,8 +54,9 @@ static struct cpuidle_state exynos4_cpuidle_set[] = {
 static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);
 
 static struct cpuidle_driver exynos4_idle_driver = {
-	.name		= "exynos4_idle",
-	.owner		= THIS_MODULE,
+	.name			= "exynos4_idle",
+	.owner			= THIS_MODULE,
+	.en_core_tk_irqen	= 1,
 };
 
 /* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
@@ -103,13 +95,8 @@ static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index)
 {
-	struct timeval before, after;
-	int idle_time;
 	unsigned long tmp;
 
-	local_irq_disable();
-	do_gettimeofday(&before);
-
 	exynos4_set_wakeupmask();
 
 	/* Set value of power down register for aftr mode */
@@ -148,34 +135,6 @@ static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
 	/* Clear wakeup state register */
 	__raw_writel(0x0, S5P_WAKEUP_STAT);
 
-	do_gettimeofday(&after);
-
-	local_irq_enable();
-	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
-		    (after.tv_usec - before.tv_usec);
-
-	dev->last_residency = idle_time;
-	return index;
-}
-
-static int exynos4_enter_idle(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-				int index)
-{
-	struct timeval before, after;
-	int idle_time;
-
-	local_irq_disable();
-	do_gettimeofday(&before);
-
-	cpu_do_idle();
-
-	do_gettimeofday(&after);
-	local_irq_enable();
-	idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
-		    (after.tv_usec - before.tv_usec);
-
-	dev->last_residency = idle_time;
 	return index;
 }
 
@@ -190,7 +149,7 @@ static int exynos4_enter_lowpower(struct cpuidle_device *dev,
 		new_index = drv->safe_state_index;
 
 	if (new_index == 0)
-		return exynos4_enter_idle(dev, drv, new_index);
+		return arm_cpuidle_simple_enter(dev, drv, new_index);
 	else
 		return exynos4_enter_core0_aftr(dev, drv, new_index);
 }
-- 
1.7.1

