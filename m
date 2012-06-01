From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 2/3] ARM: OMAP3: PM: cpuidle: optimize the PER latency in C1 state
Date: Fri,  1 Jun 2012 17:11:07 +0200
Message-ID: <1338563468-31403-3-git-send-email-j-pihet@ti.com>
References: <1338563468-31403-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:51880 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190Ab2FAPLW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jun 2012 11:11:22 -0400
Received: by wgbds11 with SMTP id ds11so639220wgb.1
        for <linux-omap@vger.kernel.org>; Fri, 01 Jun 2012 08:11:21 -0700 (PDT)
In-Reply-To: <1338563468-31403-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org
Cc: Jean Pihet <j-pihet@ti.com>

One of the main contributors of the low power code latency is
the PER power domain. To optimize the high-performance and
low-latency C1 state, prevent any PER state which is lower
than the CORE state in C1.

Reported and suggested by Kevin Hilman.

Reported-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   41 +++++++++++++++++++-----------------
 1 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index f619a92..2e2f1c6 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -222,23 +222,22 @@ static int next_valid_state(struct cpuidle_device *dev,
  * the device to the specified or a safer state.
  */
 static int omap3_enter_idle_bm(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
+			       struct cpuidle_driver *drv,
 			       int index)
 {
 	int new_state_idx;
-	u32 core_next_state, per_next_state = 0, per_saved_state = 0, cam_state;
+	u32 core_next_state, per_next_state = 0, per_saved_state = 0;
 	struct omap3_idle_statedata *cx;
 	int ret;
 
 	/*
-	 * Prevent idle completely if CAM is active.
+	 * Use only C1 if CAM is active.
 	 * CAM does not have wakeup capability in OMAP3.
 	 */
-	cam_state = pwrdm_read_pwrst(cam_pd);
-	if (cam_state == PWRDM_POWER_ON) {
+	if (pwrdm_read_pwrst(cam_pd) == PWRDM_POWER_ON)
 		new_state_idx = drv->safe_state_index;
-		goto select_state;
-	}
+	else
+		new_state_idx = next_valid_state(dev, drv, index);
 
 	/*
 	 * FIXME: we currently manage device-specific idle states
@@ -248,24 +247,28 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	 *        its own code.
 	 */
 
-	/*
-	 * Prevent PER off if CORE is not in retention or off as this
-	 * would disable PER wakeups completely.
-	 */
-	cx = &omap3_idle_data[index];
+	/* Program PER state */
+	cx = &omap3_idle_data[new_state_idx];
 	core_next_state = cx->core_state;
 	per_next_state = per_saved_state = pwrdm_read_next_pwrst(per_pd);
-	if ((per_next_state == PWRDM_POWER_OFF) &&
-	    (core_next_state > PWRDM_POWER_RET))
-		per_next_state = PWRDM_POWER_RET;
+	if (new_state_idx == 0) {
+		/* In C1 do not allow PER state lower than CORE state */
+		if (per_next_state < core_next_state)
+			per_next_state = core_next_state;
+	} else {
+		/*
+		 * Prevent PER OFF if CORE is not in RETention or OFF as this
+		 * would disable PER wakeups completely.
+		 */
+		if ((per_next_state == PWRDM_POWER_OFF) &&
+		    (core_next_state > PWRDM_POWER_RET))
+			per_next_state = PWRDM_POWER_RET;
+	}
 
 	/* Are we changing PER target state? */
 	if (per_next_state != per_saved_state)
 		pwrdm_set_next_pwrst(per_pd, per_next_state);
 
-	new_state_idx = next_valid_state(dev, drv, index);
-
-select_state:
 	ret = omap3_enter_idle(dev, drv, new_state_idx);
 
 	/* Restore original PER state if it was modified */
@@ -282,7 +285,7 @@ struct cpuidle_driver omap3_idle_driver = {
 	.owner = 	THIS_MODULE,
 	.states = {
 		{
-			.enter		  = omap3_enter_idle,
+			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 2 + 2,
 			.target_residency = 5,
 			.flags		  = CPUIDLE_FLAG_TIME_VALID,
-- 
1.7.7.6

