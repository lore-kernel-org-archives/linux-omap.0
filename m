From: Robert Lee <rob.lee@linaro.org>
Subject: [PATCH v7 6/9] ARM: omap: Consolidate OMAP3 time keeping and irq enable
Date: Wed, 29 Feb 2012 18:42:55 -0600
Message-ID: <1330562578-3410-7-git-send-email-rob.lee@linaro.org>
References: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35209 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965862Ab2CAAn2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 19:43:28 -0500
Received: by mail-yw0-f46.google.com with SMTP id m54so14052yhm.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 16:43:28 -0800 (PST)
In-Reply-To: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rjw@sisk.pl, len.brown@intel.com
Cc: khilman@ti.com, robherring2@gmail.com, Baohua.Song@csr.com, amit.kucheria@linaro.org, nicolas.ferre@atmel.com, linux@maxim.org.za, kgene.kim@samsung.com, amit.kachhap@linaro.org, magnus.damm@gmail.com, nsekhar@ti.com, daniel.lezcano@linaro.org, mturquette@linaro.org, vincent.guittot@linaro.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com, nicolas.pitre@linaro.org, linux@arm.linux.org.uk, jean.pihet@newoldbits.com, venki@google.com, ccross@google.com, g.trinabh@gmail.com, kernel@wantstofly.org, lethal@linux-sh.org, jon-hunter@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org

Use core cpuidle timekeeping and irqen wrapper and remove that
handling from this code.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   42 +++++++++++++++----------------------
 1 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 464cffd..5358664 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -87,29 +87,14 @@ static int _cpuidle_deny_idle(struct powerdomain *pwrdm,
 	return 0;
 }
 
-/**
- * omap3_enter_idle - Programs OMAP3 to enter the specified state
- * @dev: cpuidle device
- * @drv: cpuidle driver
- * @index: the index of state to be entered
- *
- * Called from the CPUidle framework to program the device to the
- * specified target state selected by the governor.
- */
-static int omap3_enter_idle(struct cpuidle_device *dev,
+static int __omap3_enter_idle(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index)
 {
 	struct omap3_idle_statedata *cx =
 			cpuidle_get_statedata(&dev->states_usage[index]);
-	struct timespec ts_preidle, ts_postidle, ts_idle;
 	u32 mpu_state = cx->mpu_state, core_state = cx->core_state;
-	int idle_time;
-
-	/* Used to keep track of the total time in idle */
-	getnstimeofday(&ts_preidle);
 
-	local_irq_disable();
 	local_fiq_disable();
 
 	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
@@ -148,22 +133,29 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	}
 
 return_sleep_time:
-	getnstimeofday(&ts_postidle);
-	ts_idle = timespec_sub(ts_postidle, ts_preidle);
 
-	local_irq_enable();
 	local_fiq_enable();
 
-	idle_time = ts_idle.tv_nsec / NSEC_PER_USEC + ts_idle.tv_sec * \
-								USEC_PER_SEC;
-
-	/* Update cpuidle counters */
-	dev->last_residency = idle_time;
-
 	return index;
 }
 
 /**
+ * omap3_enter_idle - Programs OMAP3 to enter the specified state
+ * @dev: cpuidle device
+ * @drv: cpuidle driver
+ * @index: the index of state to be entered
+ *
+ * Called from the CPUidle framework to program the device to the
+ * specified target state selected by the governor.
+ */
+static inline int omap3_enter_idle(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv,
+				int index)
+{
+	return cpuidle_wrap_enter(dev, drv, index, __omap3_enter_idle);
+}
+
+/**
  * next_valid_state - Find next valid C-state
  * @dev: cpuidle device
  * @drv: cpuidle driver
-- 
1.7.1

