From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 02/18][V3] ARM: OMAP4: cpuidle - Declare the states with the driver declaration
Date: Tue, 24 Apr 2012 16:05:23 +0200
Message-ID: <1335276339-11135-3-git-send-email-daniel.lezcano@linaro.org>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:43905 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab2DXOFr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 10:05:47 -0400
Received: by wejx9 with SMTP id x9so434644wej.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 07:05:45 -0700 (PDT)
In-Reply-To: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, khilman@ti.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

The cpuidle API allows to declare statically the states in the driver
structure. Let's use it.
We do no longer need the fill_cstate function called at runtime and
by the way adding more instructions at boot time.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   60 ++++++++++++++++++++----------------
 1 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index ee0bc50..7072c9e 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -132,21 +132,39 @@ struct cpuidle_driver omap4_idle_driver = {
 	.name				= "omap4_idle",
 	.owner				= THIS_MODULE,
 	.en_core_tk_irqen		= 1,
+	.states = {
+		{
+			/* C1 - CPU0 ON + CPU1 ON + MPU ON */
+			.exit_latency = 2 + 2,
+			.target_residency = 5,
+			.flags = CPUIDLE_FLAG_TIME_VALID,
+			.enter = omap4_enter_idle,
+			.name = "C1",
+			.desc = "MPUSS ON"
+		},
+		{
+                        /* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
+			.exit_latency = 328 + 440,
+			.target_residency = 960,
+			.flags = CPUIDLE_FLAG_TIME_VALID,
+			.enter = omap4_enter_idle,
+			.name = "C2",
+			.desc = "MPUSS CSWR",
+		},
+		{
+			/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
+			.exit_latency = 460 + 518,
+			.target_residency = 1100,
+			.flags = CPUIDLE_FLAG_TIME_VALID,
+			.enter = omap4_enter_idle,
+			.name = "C3",
+			.desc = "MPUSS OSWR",
+		},
+	},
+	.state_count = OMAP4_NUM_STATES,
+	.safe_state_index = 0,
 };
 
-static inline void _fill_cstate(struct cpuidle_driver *drv,
-					int idx, const char *descr)
-{
-	struct cpuidle_state *state = &drv->states[idx];
-
-	state->exit_latency	= cpuidle_params_table[idx].exit_latency;
-	state->target_residency	= cpuidle_params_table[idx].target_residency;
-	state->flags		= CPUIDLE_FLAG_TIME_VALID;
-	state->enter		= omap4_enter_idle;
-	sprintf(state->name, "C%d", idx + 1);
-	strncpy(state->desc, descr, CPUIDLE_DESC_LEN);
-}
-
 static inline struct omap4_idle_statedata *_fill_cstate_usage(
 					struct cpuidle_device *dev,
 					int idx)
@@ -171,7 +189,6 @@ int __init omap4_idle_init(void)
 {
 	struct omap4_idle_statedata *cx;
 	struct cpuidle_device *dev;
-	struct cpuidle_driver *drv = &omap4_idle_driver;
 	unsigned int cpu_id = 0;
 
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
@@ -180,41 +197,30 @@ int __init omap4_idle_init(void)
 	if ((!mpu_pd) || (!cpu0_pd) || (!cpu1_pd))
 		return -ENODEV;
 
-
-	drv->safe_state_index = -1;
 	dev = &per_cpu(omap4_idle_dev, cpu_id);
 	dev->cpu = cpu_id;
 
-	/* C1 - CPU0 ON + CPU1 ON + MPU ON */
-	_fill_cstate(drv, 0, "MPUSS ON");
-	drv->safe_state_index = 0;
 	cx = _fill_cstate_usage(dev, 0);
 	cx->cpu_state = PWRDM_POWER_ON;
 	cx->mpu_state = PWRDM_POWER_ON;
 	cx->mpu_logic_state = PWRDM_POWER_RET;
 
-	/* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
-	_fill_cstate(drv, 1, "MPUSS CSWR");
 	cx = _fill_cstate_usage(dev, 1);
 	cx->cpu_state = PWRDM_POWER_OFF;
 	cx->mpu_state = PWRDM_POWER_RET;
 	cx->mpu_logic_state = PWRDM_POWER_RET;
 
-	/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
-	_fill_cstate(drv, 2, "MPUSS OSWR");
 	cx = _fill_cstate_usage(dev, 2);
 	cx->cpu_state = PWRDM_POWER_OFF;
 	cx->mpu_state = PWRDM_POWER_RET;
 	cx->mpu_logic_state = PWRDM_POWER_OFF;
 
-	drv->state_count = OMAP4_NUM_STATES;
 	cpuidle_register_driver(&omap4_idle_driver);
 
-	dev->state_count = OMAP4_NUM_STATES;
 	if (cpuidle_register_device(dev)) {
 		pr_err("%s: CPUidle register device failed\n", __func__);
-			return -EIO;
-		}
+		return -EIO;
+	}
 
 	return 0;
 }
-- 
1.7.5.4

