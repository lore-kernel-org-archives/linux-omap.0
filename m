From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 13/17][V2] ARM: OMAP3: cpuidle - use omap3_idle_data directly
Date: Wed,  4 Apr 2012 22:12:47 +0200
Message-ID: <1333570371-1389-14-git-send-email-daniel.lezcano@linaro.org>
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:51590 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190Ab2DDUNT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 16:13:19 -0400
Received: by mail-wi0-f172.google.com with SMTP id hj6so944928wib.1
        for <linux-omap@vger.kernel.org>; Wed, 04 Apr 2012 13:13:18 -0700 (PDT)
In-Reply-To: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, khilman@ti.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rob.lee@linaro.org, linaro-dev@lists.linaro.org, patches@linaro.org

We are storing the 'omap3_idle_data' in the private data field
of the cpuidle device. As we are using this variable only in this file,
that does not really make sense. Let's use the global variable directly
instead dereferencing pointers in an idle critical loop.

As the table is initialized statically, let's remove the initialization at
startup too.

Also, that simplfies the code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   65 ++++--------------------------------
 1 files changed, 8 insertions(+), 57 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 332b636..e4738eb 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -97,8 +97,7 @@ static int __omap3_enter_idle(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index)
 {
-	struct omap3_idle_statedata *cx =
-			cpuidle_get_statedata(&dev->states_usage[index]);
+	struct omap3_idle_statedata *cx = &omap3_idle_data[index];
 	u32 mpu_state = cx->mpu_state, core_state = cx->core_state;
 
 	local_fiq_disable();
@@ -178,9 +177,8 @@ static int next_valid_state(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 				int index)
 {
-	struct cpuidle_state_usage *curr_usage = &dev->states_usage[index];
 	struct cpuidle_state *curr = &drv->states[index];
-	struct omap3_idle_statedata *cx = cpuidle_get_statedata(curr_usage);
+	struct omap3_idle_statedata *cx = &omap3_idle_data[index];
 	u32 mpu_deepest_state = PWRDM_POWER_RET;
 	u32 core_deepest_state = PWRDM_POWER_RET;
 	int next_index = -1;
@@ -220,7 +218,7 @@ static int next_valid_state(struct cpuidle_device *dev,
 		 */
 		idx--;
 		for (; idx >= 0; idx--) {
-			cx = cpuidle_get_statedata(&dev->states_usage[idx]);
+			cx =  &omap3_idle_data[idx];
 			if ((cx->mpu_state >= mpu_deepest_state) &&
 			    (cx->core_state >= core_deepest_state)) {
 				next_index = idx;
@@ -277,7 +275,7 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	 * Prevent PER off if CORE is not in retention or off as this
 	 * would disable PER wakeups completely.
 	 */
-	cx = cpuidle_get_statedata(&dev->states_usage[index]);
+	cx = &omap3_idle_data[index];
 	core_next_state = cx->core_state;
 	per_next_state = per_saved_state = pwrdm_read_next_pwrst(per_pd);
 	if ((per_next_state == PWRDM_POWER_OFF) &&
@@ -367,19 +365,6 @@ struct cpuidle_driver omap3_idle_driver = {
 	.safe_state_index = 0,
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
@@ -390,48 +375,12 @@ int __init omap3_idle_init(void)
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
@@ -442,11 +391,13 @@ int __init omap3_idle_init(void)
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

