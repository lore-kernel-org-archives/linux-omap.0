From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC][PATCH 8/9] ARM: OMAP3: cpuidle - use omap3_idle_data directly
Date: Fri, 23 Mar 2012 10:26:33 +0100
Message-ID: <1332494794-7810-8-git-send-email-daniel.lezcano@linaro.org>
References: <1332494794-7810-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:55187 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757884Ab2CWJ0q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 05:26:46 -0400
Received: by mail-wi0-f178.google.com with SMTP id hq7so1792606wib.1
        for <linux-omap@vger.kernel.org>; Fri, 23 Mar 2012 02:26:45 -0700 (PDT)
In-Reply-To: <1332494794-7810-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

We are storing the 'omap3_idle_data' in the private data field
if the cpuidle device. As we are using this variable only in this file,
that does not really make sense. Let's use the global variable directly
instead dereferencing pointers in an idle critical loop.

As the table is initialized statically, let's remove the initialization at
startup too.

Also, that simplfies the code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   60 ++++---------------------------------
 1 files changed, 6 insertions(+), 54 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 34e1e34..726f0bf 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -106,8 +106,7 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index)
 {
-	struct omap3_idle_statedata *cx =
-			cpuidle_get_statedata(&dev->states_usage[index]);
+	struct omap3_idle_statedata *cx = &omap3_idle_data[index];
 	struct timespec ts_preidle, ts_postidle, ts_idle;
 	u32 mpu_state = cx->mpu_state, core_state = cx->core_state;
 	int idle_time;
@@ -208,7 +207,7 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	 * Prevent PER off if CORE is not in retention or off as this
 	 * would disable PER wakeups completely.
 	 */
-	cx = cpuidle_get_statedata(&dev->states_usage[index]);
+	cx = &omap3_idle_data[index];
 	core_next_state = cx->core_state;
 	per_next_state = per_saved_state = pwrdm_read_next_pwrst(per_pd);
 	if ((per_next_state == PWRDM_POWER_OFF) &&
@@ -295,19 +294,6 @@ struct cpuidle_driver omap3_idle_driver = {
 	.state_count = OMAP3_NUM_STATES,
 };
 
-/* Helper to register the driver_data */
-static inline struct omap3_idle_statedata *_fill_cstate_usage(
-					struct cpuidle_device *dev,
-					int idx)
-{
-	struct omap3_idle_statedata *cx = &omap3_idle_data[idx];
-	struct cpuidle_state_usage *state_usage = &dev->states_usage[idx];
-
-	cpuidle_set_statedata(state_usage, cx);
-
-	return cx;
-}
-
 /**
  * omap3_idle_init - Init routine for OMAP3 idle
  *
@@ -318,48 +304,12 @@ int __init omap3_idle_init(void)
 {
 	struct cpuidle_device *dev;
 	struct cpuidle_driver *drv = &omap3_idle_driver;
-	struct omap3_idle_statedata *cx;
 
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
 	core_pd = pwrdm_lookup("core_pwrdm");
 	per_pd = pwrdm_lookup("per_pwrdm");
 	cam_pd = pwrdm_lookup("cam_pwrdm");
 
-
-	dev = &per_cpu(omap3_idle_dev, smp_processor_id());
-
-	/* C1 . MPU WFI + Core active */
-	cx = _fill_cstate_usage(dev, 0);
-	cx->mpu_state = PWRDM_POWER_ON;
-	cx->core_state = PWRDM_POWER_ON;
-
-	/* C2 . MPU WFI + Core inactive */
-	cx = _fill_cstate_usage(dev, 1);
-	cx->mpu_state = PWRDM_POWER_ON;
-	cx->core_state = PWRDM_POWER_ON;
-
-	/* C3 . MPU CSWR + Core inactive */
-	cx = _fill_cstate_usage(dev, 2);
-	cx->mpu_state = PWRDM_POWER_RET;
-	cx->core_state = PWRDM_POWER_ON;
-
-	/* C4 . MPU OFF + Core inactive */
-	cx = _fill_cstate_usage(dev, 3);
-	cx->mpu_state = PWRDM_POWER_OFF;
-	cx->core_state = PWRDM_POWER_ON;
-
-	/* C5 . MPU RET + Core RET */
-	cx = _fill_cstate_usage(dev, 4);
-	cx->mpu_state = PWRDM_POWER_RET;
-	cx->core_state = PWRDM_POWER_RET;
-
-	/* C6 . MPU OFF + Core RET */
-	cx = _fill_cstate_usage(dev, 5);
-	cx->mpu_state = PWRDM_POWER_OFF;
-	cx->core_state = PWRDM_POWER_RET;
-
-	/* C7 . MPU OFF + Core OFF */
-	cx = _fill_cstate_usage(dev, 6);
 	/*
 	 * Erratum i583: implementation for ES rev < Es1.2 on 3630. We cannot
 	 * enable OFF mode in a stable form for previous revisions.
@@ -370,11 +320,13 @@ int __init omap3_idle_init(void)
 		pr_warn("%s: core off state C7 disabled due to i583\n",
 			__func__);
 	}
-	cx->mpu_state = PWRDM_POWER_OFF;
-	cx->core_state = PWRDM_POWER_OFF;
 
 	cpuidle_register_driver(&omap3_idle_driver);
 
+	dev = &per_cpu(omap3_idle_dev, smp_processor_id());
+	dev->cpu = 0;
+	dev->state_count = drv->state_count;
+
 	if (cpuidle_register_device(dev)) {
 		printk(KERN_ERR "%s: CPUidle register device failed\n",
 		       __func__);
-- 
1.7.5.4

