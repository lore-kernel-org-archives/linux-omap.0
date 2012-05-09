From: jean.pihet@newoldbits.com
Subject: [PATCH 1/2] ARM: OMAP3: PM: cpuidle: optimize the PER latency in C1 state
Date: Wed,  9 May 2012 12:55:11 +0200
Message-ID: <1336560912-26753-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56624 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507Ab2EIKz2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 06:55:28 -0400
Received: by wgbdr13 with SMTP id dr13so138775wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 03:55:27 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

One of the main contributors of the low power code latency is
the PER power domain. To optimize the high-performance and
low-latency C1 state, prevent any PER state which is lower
than the CORE state in C1.

Reported and suggested by Kevin Hilman.

Reported-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   38 +++++++++++++++++++-----------------
 1 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 5358664..353dd8d 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -247,19 +247,18 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
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
@@ -269,24 +268,28 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	 *        its own code.
 	 */
 
-	/*
-	 * Prevent PER off if CORE is not in retention or off as this
-	 * would disable PER wakeups completely.
-	 */
-	cx = cpuidle_get_statedata(&dev->states_usage[index]);
+	/* Program PER state */
+	cx = cpuidle_get_statedata(&dev->states_usage[new_state_idx]);
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
@@ -372,7 +375,6 @@ int __init omap3_idle_init(void)
 
 	/* C1 . MPU WFI + Core active */
 	_fill_cstate(drv, 0, "MPU ON + CORE ON");
-	(&drv->states[0])->enter = omap3_enter_idle;
 	drv->safe_state_index = 0;
 	cx = _fill_cstate_usage(dev, 0);
 	cx->valid = 1;	/* C1 is always valid */
-- 
1.7.7.6

