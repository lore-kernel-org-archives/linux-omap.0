From: jean.pihet@newoldbits.com
Subject: [PATCH 3/4] OMAP3: cpuidle: code rework for improved readability
Date: Thu,  5 May 2011 17:12:38 +0200
Message-ID: <1304608359-18061-4-git-send-email-j-pihet@ti.com>
References: <1304608359-18061-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45463 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754287Ab1EEPMy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 11:12:54 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so1692761wya.19
        for <linux-omap@vger.kernel.org>; Thu, 05 May 2011 08:12:53 -0700 (PDT)
In-Reply-To: <1304608359-18061-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

- fix single and multi-lines comments format
- removed the omap3_idle_bm_check function and replaced the test
   in omap3_enter_idle_bm by the equivalent code
- re-organize omap3_enter_idle_bm code path, assign local variables
   only when needed
- reword some comments

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   52 +++++++++++++-----------------------
 1 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 816b483..5621b6e 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -74,13 +74,6 @@ static struct cpuidle_params cpuidle_params_table[OMAP3_NB_STATES] = {
 	{10000 + 30000, 300000, 1},
 };
 
-static int omap3_idle_bm_check(void)
-{
-	if (!omap3_can_sleep())
-		return 1;
-	return 0;
-}
-
 static int _cpuidle_allow_idle(struct powerdomain *pwrdm,
 				struct clockdomain *clkdm)
 {
@@ -160,9 +153,7 @@ static struct cpuidle_state *next_valid_state(struct cpuidle_device *dev,
 					      struct cpuidle_state *curr)
 {
 	struct cpuidle_state *next = NULL;
-	struct omap3_idle_statedata *cx;
-
-	cx = cpuidle_get_statedata(curr);
+	struct omap3_idle_statedata *cx = cpuidle_get_statedata(curr);
 
 	/* Check if current state is valid */
 	if (cx->valid) {
@@ -170,9 +161,7 @@ static struct cpuidle_state *next_valid_state(struct cpuidle_device *dev,
 	} else {
 		u8 idx = OMAP3_STATE_MAX;
 
-		/*
-		 * Reach the current state starting at highest C-state
-		 */
+		/* Reach the current state starting at highest C-state */
 		for (; idx >= OMAP3_STATE_MIN; idx--) {
 			if (&dev->states[idx] == curr) {
 				next = &dev->states[idx];
@@ -180,9 +169,7 @@ static struct cpuidle_state *next_valid_state(struct cpuidle_device *dev,
 			}
 		}
 
-		/*
-		 * Should never hit this condition.
-		 */
+		/* Should never hit this condition */
 		WARN_ON(next == NULL);
 
 		/*
@@ -217,29 +204,16 @@ static struct cpuidle_state *next_valid_state(struct cpuidle_device *dev,
 static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 			       struct cpuidle_state *state)
 {
-	struct cpuidle_state *new_state = next_valid_state(dev, state);
-	u32 core_next_state, per_next_state = 0, per_saved_state = 0;
-	u32 cam_state;
+	struct cpuidle_state *new_state;
+	u32 core_next_state, per_next_state = 0, per_saved_state = 0, cam_state;
 	struct omap3_idle_statedata *cx;
 	int ret;
 
-	if (omap3_idle_bm_check()) {
-		BUG_ON(!dev->safe_state);
+	if (!omap3_can_sleep()) {
 		new_state = dev->safe_state;
 		goto select_state;
 	}
 
-	cx = cpuidle_get_statedata(state);
-	core_next_state = cx->core_state;
-
-	/*
-	 * FIXME: we currently manage device-specific idle states
-	 *        for PER and CORE in combination with CPU-specific
-	 *        idle states.  This is wrong, and device-specific
-	 *        idle management needs to be separated out into 
-	 *        its own code.
-	 */
-
 	/*
 	 * Prevent idle completely if CAM is active.
 	 * CAM does not have wakeup capability in OMAP3.
@@ -251,9 +225,19 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	}
 
 	/*
+	 * FIXME: we currently manage device-specific idle states
+	 *        for PER and CORE in combination with CPU-specific
+	 *        idle states.  This is wrong, and device-specific
+	 *        idle management needs to be separated out into
+	 *        its own code.
+	 */
+
+	/*
 	 * Prevent PER off if CORE is not in retention or off as this
 	 * would disable PER wakeups completely.
 	 */
+	cx = cpuidle_get_statedata(state);
+	core_next_state = cx->core_state;
 	per_next_state = per_saved_state = pwrdm_read_next_pwrst(per_pd);
 	if ((per_next_state == PWRDM_POWER_OFF) &&
 	    (core_next_state > PWRDM_POWER_RET))
@@ -263,6 +247,8 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	if (per_next_state != per_saved_state)
 		pwrdm_set_next_pwrst(per_pd, per_next_state);
 
+	new_state = next_valid_state(dev, state);
+
 select_state:
 	dev->last_state = new_state;
 	ret = omap3_enter_idle(dev, new_state);
@@ -323,7 +309,7 @@ struct cpuidle_driver omap3_idle_driver = {
 	.owner = 	THIS_MODULE,
 };
 
-/* Fill in the state data from the mach tables and register the driver_data */
+/* Helper to fill the C-state common data and register the driver_data */
 static inline struct omap3_idle_statedata *fill_in_cstates_data(int idx,
 					const char *descr,
 					struct cpuidle_state *state)
-- 
1.7.2.5

