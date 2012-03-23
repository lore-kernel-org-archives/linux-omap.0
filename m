From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC][PATCH 2/9] ARM: OMAP3: cpuidle - remove next_valid_state function
Date: Fri, 23 Mar 2012 10:26:27 +0100
Message-ID: <1332494794-7810-2-git-send-email-daniel.lezcano@linaro.org>
References: <1332494794-7810-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:35436 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757411Ab2CWJ0h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 05:26:37 -0400
Received: by wejx9 with SMTP id x9so2495385wej.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Mar 2012 02:26:36 -0700 (PDT)
In-Reply-To: <1332494794-7810-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

As we will be able to remove C-states from userspace with the sysfs
API, this function is no longer needed. We remove it and that simplifies
the code for more consolidation.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   85 +------------------------------------
 1 files changed, 2 insertions(+), 83 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index d67431a..65b4e7aa 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -164,84 +164,6 @@ return_sleep_time:
 }
 
 /**
- * next_valid_state - Find next valid C-state
- * @dev: cpuidle device
- * @drv: cpuidle driver
- * @index: Index of currently selected c-state
- *
- * If the state corresponding to index is valid, index is returned back
- * to the caller. Else, this function searches for a lower c-state which is
- * still valid (as defined in omap3_power_states[]) and returns its index.
- *
- * A state is valid if the 'valid' field is enabled and
- * if it satisfies the enable_off_mode condition.
- */
-static int next_valid_state(struct cpuidle_device *dev,
-			struct cpuidle_driver *drv,
-				int index)
-{
-	struct cpuidle_state_usage *curr_usage = &dev->states_usage[index];
-	struct cpuidle_state *curr = &drv->states[index];
-	struct omap3_idle_statedata *cx = cpuidle_get_statedata(curr_usage);
-	u32 mpu_deepest_state = PWRDM_POWER_RET;
-	u32 core_deepest_state = PWRDM_POWER_RET;
-	int next_index = -1;
-
-	if (enable_off_mode) {
-		mpu_deepest_state = PWRDM_POWER_OFF;
-		/*
-		 * Erratum i583: valable for ES rev < Es1.2 on 3630.
-		 * CORE OFF mode is not supported in a stable form, restrict
-		 * instead the CORE state to RET.
-		 */
-		if (!IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583))
-			core_deepest_state = PWRDM_POWER_OFF;
-	}
-
-	/* Check if current state is valid */
-	if ((cx->valid) &&
-	    (cx->mpu_state >= mpu_deepest_state) &&
-	    (cx->core_state >= core_deepest_state)) {
-		return index;
-	} else {
-		int idx = OMAP3_NUM_STATES - 1;
-
-		/* Reach the current state starting at highest C-state */
-		for (; idx >= 0; idx--) {
-			if (&drv->states[idx] == curr) {
-				next_index = idx;
-				break;
-			}
-		}
-
-		/* Should never hit this condition */
-		WARN_ON(next_index == -1);
-
-		/*
-		 * Drop to next valid state.
-		 * Start search from the next (lower) state.
-		 */
-		idx--;
-		for (; idx >= 0; idx--) {
-			cx = cpuidle_get_statedata(&dev->states_usage[idx]);
-			if ((cx->valid) &&
-			    (cx->mpu_state >= mpu_deepest_state) &&
-			    (cx->core_state >= core_deepest_state)) {
-				next_index = idx;
-				break;
-			}
-		}
-		/*
-		 * C1 is always valid.
-		 * So, no need to check for 'next_index == -1' outside
-		 * this loop.
-		 */
-	}
-
-	return next_index;
-}
-
-/**
  * omap3_enter_idle_bm - Checks for any bus activity
  * @dev: cpuidle device
  * @drv: cpuidle driver
@@ -254,7 +176,6 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 			       int index)
 {
-	int new_state_idx;
 	u32 core_next_state, per_next_state = 0, per_saved_state = 0, cam_state;
 	struct omap3_idle_statedata *cx;
 	int ret;
@@ -265,7 +186,7 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	 */
 	cam_state = pwrdm_read_pwrst(cam_pd);
 	if (cam_state == PWRDM_POWER_ON) {
-		new_state_idx = drv->safe_state_index;
+		index = drv->safe_state_index;
 		goto select_state;
 	}
 
@@ -292,10 +213,8 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	if (per_next_state != per_saved_state)
 		pwrdm_set_next_pwrst(per_pd, per_next_state);
 
-	new_state_idx = next_valid_state(dev, drv, index);
-
 select_state:
-	ret = omap3_enter_idle(dev, drv, new_state_idx);
+	ret = omap3_enter_idle(dev, drv, index);
 
 	/* Restore original PER state if it was modified */
 	if (per_next_state != per_saved_state)
-- 
1.7.5.4

