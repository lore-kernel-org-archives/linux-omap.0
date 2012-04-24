From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 11/18][V3] ARM: OMAP3: cpuidle - remove the 'valid' field
Date: Tue, 24 Apr 2012 16:05:32 +0200
Message-ID: <1335276339-11135-12-git-send-email-daniel.lezcano@linaro.org>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33562 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963Ab2DXOGD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 10:06:03 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so716062wgb.1
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 07:06:02 -0700 (PDT)
In-Reply-To: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, khilman@ti.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

With the previous changes all the states are valid, except
the last state which can be handled by decreasing the number
of states.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index f394ea6..29b4f87 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -67,7 +67,6 @@ static struct cpuidle_params cpuidle_params_table[] = {
 struct omap3_idle_statedata {
 	u32 mpu_state;
 	u32 core_state;
-	u8 valid;
 };
 struct omap3_idle_statedata omap3_idle_data[OMAP3_NUM_STATES];
 
@@ -191,8 +190,7 @@ static int next_valid_state(struct cpuidle_device *dev,
 	}
 
 	/* Check if current state is valid */
-	if ((cx->valid) &&
-	    (cx->mpu_state >= mpu_deepest_state) &&
+	if ((cx->mpu_state >= mpu_deepest_state) &&
 	    (cx->core_state >= core_deepest_state)) {
 		return index;
 	} else {
@@ -216,8 +214,7 @@ static int next_valid_state(struct cpuidle_device *dev,
 		idx--;
 		for (; idx >= 0; idx--) {
 			cx = cpuidle_get_statedata(&dev->states_usage[idx]);
-			if ((cx->valid) &&
-			    (cx->mpu_state >= mpu_deepest_state) &&
+			if ((cx->mpu_state >= mpu_deepest_state) &&
 			    (cx->core_state >= core_deepest_state)) {
 				next_index = idx;
 				break;
@@ -371,7 +368,6 @@ static inline struct omap3_idle_statedata *_fill_cstate_usage(
 	struct omap3_idle_statedata *cx = &omap3_idle_data[idx];
 	struct cpuidle_state_usage *state_usage = &dev->states_usage[idx];
 
-	cx->valid		= cpuidle_params_table[idx].valid;
 	cpuidle_set_statedata(state_usage, cx);
 
 	return cx;
@@ -386,7 +382,6 @@ static inline struct omap3_idle_statedata *_fill_cstate_usage(
 int __init omap3_idle_init(void)
 {
 	struct cpuidle_device *dev;
-	struct cpuidle_driver *drv = &omap3_idle_driver;
 	struct omap3_idle_statedata *cx;
 
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
@@ -399,7 +394,6 @@ int __init omap3_idle_init(void)
 
 	/* C1 . MPU WFI + Core active */
 	cx = _fill_cstate_usage(dev, 0);
-	cx->valid = 1;	/* C1 is always valid */
 	cx->mpu_state = PWRDM_POWER_ON;
 	cx->core_state = PWRDM_POWER_ON;
 
@@ -433,7 +427,6 @@ int __init omap3_idle_init(void)
 	cx->mpu_state = PWRDM_POWER_OFF;
 	cx->core_state = PWRDM_POWER_OFF;
 
-	drv->state_count = OMAP3_NUM_STATES;
 	cpuidle_register_driver(&omap3_idle_driver);
 
 	if (cpuidle_register_device(dev)) {
-- 
1.7.5.4

