From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC][PATCH 5/9] ARM: OMAP3: cpuidle - remove the 'valid' field
Date: Fri, 23 Mar 2012 10:26:30 +0100
Message-ID: <1332494794-7810-5-git-send-email-daniel.lezcano@linaro.org>
References: <1332494794-7810-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:59138 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757411Ab2CWJ0m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 05:26:42 -0400
Received: by wibhj6 with SMTP id hj6so1766390wib.1
        for <linux-omap@vger.kernel.org>; Fri, 23 Mar 2012 02:26:41 -0700 (PDT)
In-Reply-To: <1332494794-7810-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

With the previous changes all the states are valid, except
the last state which can be handled by decreasing the number
of states.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 62e3cfd..39aa1b8 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -67,7 +67,6 @@ static struct cpuidle_params cpuidle_params_table[] = {
 struct omap3_idle_statedata {
 	u32 mpu_state;
 	u32 core_state;
-	u8 valid;
 };
 struct omap3_idle_statedata omap3_idle_data[OMAP3_NUM_STATES];
 
@@ -297,7 +296,6 @@ static inline struct omap3_idle_statedata *_fill_cstate_usage(
 	struct omap3_idle_statedata *cx = &omap3_idle_data[idx];
 	struct cpuidle_state_usage *state_usage = &dev->states_usage[idx];
 
-	cx->valid		= cpuidle_params_table[idx].valid;
 	cpuidle_set_statedata(state_usage, cx);
 
 	return cx;
@@ -325,7 +323,6 @@ int __init omap3_idle_init(void)
 
 	/* C1 . MPU WFI + Core active */
 	cx = _fill_cstate_usage(dev, 0);
-	cx->valid = 1;	/* C1 is always valid */
 	cx->mpu_state = PWRDM_POWER_ON;
 	cx->core_state = PWRDM_POWER_ON;
 
@@ -362,14 +359,13 @@ int __init omap3_idle_init(void)
 	 * We disable C7 state as a result.
 	 */
 	if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583)) {
-		cx->valid = 0;
+		drv->state_count = OMAP3_NUM_STATES - 1;
 		pr_warn("%s: core off state C7 disabled due to i583\n",
 			__func__);
 	}
 	cx->mpu_state = PWRDM_POWER_OFF;
 	cx->core_state = PWRDM_POWER_OFF;
 
-	drv->state_count = OMAP3_NUM_STATES;
 	cpuidle_register_driver(&omap3_idle_driver);
 
 	if (cpuidle_register_device(dev)) {
-- 
1.7.5.4

