From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC][PATCH 4/9] ARM: OMAP3: define cpuidle statically
Date: Fri, 23 Mar 2012 10:26:29 +0100
Message-ID: <1332494794-7810-4-git-send-email-daniel.lezcano@linaro.org>
References: <1332494794-7810-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:35436 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757411Ab2CWJ0j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 05:26:39 -0400
Received: by mail-we0-f174.google.com with SMTP id x9so2495385wej.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Mar 2012 02:26:39 -0700 (PDT)
In-Reply-To: <1332494794-7810-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

Use the new cpuidle API and define in the driver the states.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   85 +++++++++++++++++++++++++-----------
 1 files changed, 59 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 65b4e7aa..62e3cfd 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -228,23 +228,67 @@ DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
 struct cpuidle_driver omap3_idle_driver = {
 	.name = 	"omap3_idle",
 	.owner = 	THIS_MODULE,
+	.states = {
+		{
+			.enter		  = omap3_enter_idle,
+			.exit_latency	  = 2 + 2,
+			.target_residency = 5,
+			.flags		  = CPUIDLE_FLAG_TIME_VALID,
+			.name		  = "C1",
+			.desc		  = "MPU ON + CORE ON",
+		},
+		{
+			.enter		  = omap3_enter_idle_bm,
+			.exit_latency	  = 10 + 10,
+			.target_residency = 30,
+			.flags		  = CPUIDLE_FLAG_TIME_VALID,
+			.name		  = "C2",
+			.desc		  = "MPU ON + CORE ON",
+		},
+		{
+			.enter		  = omap3_enter_idle_bm,
+			.exit_latency	  = 50 + 50,
+			.target_residency = 300,
+			.flags		  = CPUIDLE_FLAG_TIME_VALID,
+			.name		  = "C3",
+			.desc		  = "MPU RET + CORE ON",
+		},
+		{
+			.enter		  = omap3_enter_idle_bm,
+			.exit_latency	  = 1500 + 1800,
+			.target_residency = 4000,
+			.flags		  = CPUIDLE_FLAG_TIME_VALID,
+			.name		  = "C4",
+			.desc		  = "MPU OFF + CORE ON",
+		},
+		{
+			.enter		  = omap3_enter_idle_bm,
+			.exit_latency	  = 2500 + 7500,
+			.target_residency = 12000,
+			.flags		  = CPUIDLE_FLAG_TIME_VALID,
+			.name		  = "C5",
+			.desc		  = "MPU RET + CORE RET",
+		},
+		{
+			.enter		  = omap3_enter_idle_bm,
+			.exit_latency	  = 3000 + 8500,
+			.target_residency = 15000,
+			.flags		  = CPUIDLE_FLAG_TIME_VALID,
+			.name		  = "C6",
+			.desc		  = "MPU OFF + CORE RET",
+		},
+		{
+			.enter		  = omap3_enter_idle_bm,
+			.exit_latency	  = 10000 + 30000,
+			.target_residency = 30000,
+			.flags		  = CPUIDLE_FLAG_TIME_VALID,
+			.name		  = "C7",
+			.desc		  = "MPU OFF + CORE OFF",
+		},
+	},
+	.state_count = OMAP3_NUM_STATES,
 };
 
-/* Helper to fill the C-state common data*/
-static inline void _fill_cstate(struct cpuidle_driver *drv,
-					int idx, const char *descr)
-{
-	struct cpuidle_state *state = &drv->states[idx];
-
-	state->exit_latency	= cpuidle_params_table[idx].exit_latency;
-	state->target_residency	= cpuidle_params_table[idx].target_residency;
-	state->flags		= CPUIDLE_FLAG_TIME_VALID;
-	state->enter		= omap3_enter_idle_bm;
-	sprintf(state->name, "C%d", idx + 1);
-	strncpy(state->desc, descr, CPUIDLE_DESC_LEN);
-
-}
-
 /* Helper to register the driver_data */
 static inline struct omap3_idle_statedata *_fill_cstate_usage(
 					struct cpuidle_device *dev,
@@ -277,50 +321,40 @@ int __init omap3_idle_init(void)
 	cam_pd = pwrdm_lookup("cam_pwrdm");
 
 
-	drv->safe_state_index = -1;
 	dev = &per_cpu(omap3_idle_dev, smp_processor_id());
 
 	/* C1 . MPU WFI + Core active */
-	_fill_cstate(drv, 0, "MPU ON + CORE ON");
-	(&drv->states[0])->enter = omap3_enter_idle;
-	drv->safe_state_index = 0;
 	cx = _fill_cstate_usage(dev, 0);
 	cx->valid = 1;	/* C1 is always valid */
 	cx->mpu_state = PWRDM_POWER_ON;
 	cx->core_state = PWRDM_POWER_ON;
 
 	/* C2 . MPU WFI + Core inactive */
-	_fill_cstate(drv, 1, "MPU ON + CORE ON");
 	cx = _fill_cstate_usage(dev, 1);
 	cx->mpu_state = PWRDM_POWER_ON;
 	cx->core_state = PWRDM_POWER_ON;
 
 	/* C3 . MPU CSWR + Core inactive */
-	_fill_cstate(drv, 2, "MPU RET + CORE ON");
 	cx = _fill_cstate_usage(dev, 2);
 	cx->mpu_state = PWRDM_POWER_RET;
 	cx->core_state = PWRDM_POWER_ON;
 
 	/* C4 . MPU OFF + Core inactive */
-	_fill_cstate(drv, 3, "MPU OFF + CORE ON");
 	cx = _fill_cstate_usage(dev, 3);
 	cx->mpu_state = PWRDM_POWER_OFF;
 	cx->core_state = PWRDM_POWER_ON;
 
 	/* C5 . MPU RET + Core RET */
-	_fill_cstate(drv, 4, "MPU RET + CORE RET");
 	cx = _fill_cstate_usage(dev, 4);
 	cx->mpu_state = PWRDM_POWER_RET;
 	cx->core_state = PWRDM_POWER_RET;
 
 	/* C6 . MPU OFF + Core RET */
-	_fill_cstate(drv, 5, "MPU OFF + CORE RET");
 	cx = _fill_cstate_usage(dev, 5);
 	cx->mpu_state = PWRDM_POWER_OFF;
 	cx->core_state = PWRDM_POWER_RET;
 
 	/* C7 . MPU OFF + Core OFF */
-	_fill_cstate(drv, 6, "MPU OFF + CORE OFF");
 	cx = _fill_cstate_usage(dev, 6);
 	/*
 	 * Erratum i583: implementation for ES rev < Es1.2 on 3630. We cannot
@@ -338,7 +372,6 @@ int __init omap3_idle_init(void)
 	drv->state_count = OMAP3_NUM_STATES;
 	cpuidle_register_driver(&omap3_idle_driver);
 
-	dev->state_count = OMAP3_NUM_STATES;
 	if (cpuidle_register_device(dev)) {
 		printk(KERN_ERR "%s: CPUidle register device failed\n",
 		       __func__);
-- 
1.7.5.4

