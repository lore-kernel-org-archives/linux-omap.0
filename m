From: jean.pihet@newoldbits.com
Subject: [PATCH 6/8] OMAP3: cpuidle: next C-state decision depends on the PM QoS MPU and CORE constraints
Date: Wed, 21 Sep 2011 18:24:16 +0200
Message-ID: <1316622258-3892-7-git-send-email-j-pihet@ti.com>
References: <1316621649-3622-1-git-send-email-j-pihet@ti.com>
 <1316622258-3892-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f42.google.com ([209.85.215.42]:61336 "EHLO
	mail-ew0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab1IUQ0C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 12:26:02 -0400
Received: by mail-ew0-f42.google.com with SMTP id 1so1809483ewy.1
        for <linux-omap@vger.kernel.org>; Wed, 21 Sep 2011 09:26:01 -0700 (PDT)
In-Reply-To: <1316622258-3892-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.co>
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

The MPU latency figures for cpuidle include the MPU itself and also
the peripherals needed for the MPU to execute instructions (e.g.
main memory, caches, IRQ controller, MMU etc). On OMAP3 those
peripherals belong to the MPU and CORE power domains and so the
cpuidle C-states are a combination of MPU and CORE states.

This patch implements the relation between the cpuidle and per-
device PM QoS frameworks in the OMAP3 specific idle callbacks.

The chosen C-state shall satisfy the following conditions:
 . the 'valid' field is enabled,
 . it satisfies the enable_off_mode flag,
 . the next state for MPU and CORE power domains is not lower than the
   next state calculated by the per-device PM QoS.

Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   49 ++++++++++++++++++++++---------------
 arch/arm/mach-omap2/pm.h          |   17 +++++++++++-
 2 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 4bf6e6e..1b8e0da 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -37,7 +37,7 @@
 #ifdef CONFIG_CPU_IDLE
 
 /*
- * The latencies/thresholds for various C states have
+ * The MPU latencies/thresholds for various C states have
  * to be configured from the respective board files.
  * These are some default values (which might not provide
  * the best power savings) used on boards which do not
@@ -72,14 +72,14 @@ struct omap3_idle_statedata omap3_idle_data[OMAP3_NUM_STATES];
 struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
 
 static int _cpuidle_allow_idle(struct powerdomain *pwrdm,
-				struct clockdomain *clkdm)
+			       struct clockdomain *clkdm)
 {
 	clkdm_allow_idle(clkdm);
 	return 0;
 }
 
 static int _cpuidle_deny_idle(struct powerdomain *pwrdm,
-				struct clockdomain *clkdm)
+			      struct clockdomain *clkdm)
 {
 	clkdm_deny_idle(clkdm);
 	return 0;
@@ -92,9 +92,13 @@ static int _cpuidle_deny_idle(struct powerdomain *pwrdm,
  *
  * Called from the CPUidle framework to program the device to the
  * specified target state selected by the governor.
+ *
+ * Note: this function does not check for any pending activity or dependency
+ * between power domains states, so the caller shall check the parameters
+ * correctness.
  */
 static int omap3_enter_idle(struct cpuidle_device *dev,
-			struct cpuidle_state *state)
+			    struct cpuidle_state *state)
 {
 	struct omap3_idle_statedata *cx = cpuidle_get_statedata(state);
 	struct timespec ts_preidle, ts_postidle, ts_idle;
@@ -146,8 +150,11 @@ return_sleep_time:
  * Else, this function searches for a lower c-state which is still
  * valid.
  *
- * A state is valid if the 'valid' field is enabled and
- * if it satisfies the enable_off_mode condition.
+ * A state is valid if:
+ * . the 'valid' field is enabled,
+ * . it satisfies the enable_off_mode flag,
+ * . the next state for MPU and CORE power domains is not lower than the
+ *   state programmed by the per-device PM QoS.
  */
 static struct cpuidle_state *next_valid_state(struct cpuidle_device *dev,
 					      struct cpuidle_state *curr)
@@ -156,6 +163,8 @@ static struct cpuidle_state *next_valid_state(struct cpuidle_device *dev,
 	struct omap3_idle_statedata *cx = cpuidle_get_statedata(curr);
 	u32 mpu_deepest_state = PWRDM_POWER_RET;
 	u32 core_deepest_state = PWRDM_POWER_RET;
+	u32 mpu_pm_qos_next_state = mpu_pd->wkup_lat_next_state;
+	u32 core_pm_qos_next_state = core_pd->wkup_lat_next_state;
 
 	if (enable_off_mode) {
 		mpu_deepest_state = PWRDM_POWER_OFF;
@@ -171,7 +180,9 @@ static struct cpuidle_state *next_valid_state(struct cpuidle_device *dev,
 	/* Check if current state is valid */
 	if ((cx->valid) &&
 	    (cx->mpu_state >= mpu_deepest_state) &&
-	    (cx->core_state >= core_deepest_state)) {
+	    (cx->core_state >= core_deepest_state) &&
+	    (cx->mpu_state >= mpu_pm_qos_next_state) &&
+	    (cx->core_state >= core_pm_qos_next_state)) {
 		return curr;
 	} else {
 		int idx = OMAP3_NUM_STATES - 1;
@@ -196,7 +207,9 @@ static struct cpuidle_state *next_valid_state(struct cpuidle_device *dev,
 			cx = cpuidle_get_statedata(&dev->states[idx]);
 			if ((cx->valid) &&
 			    (cx->mpu_state >= mpu_deepest_state) &&
-			    (cx->core_state >= core_deepest_state)) {
+			    (cx->core_state >= core_deepest_state) &&
+			    (cx->mpu_state >= mpu_pm_qos_next_state) &&
+			    (cx->core_state >= core_pm_qos_next_state)) {
 				next = &dev->states[idx];
 				break;
 			}
@@ -215,8 +228,12 @@ static struct cpuidle_state *next_valid_state(struct cpuidle_device *dev,
  * @dev: cpuidle device
  * @state: The target state to be programmed
  *
- * This function checks for any pending activity and then programs
- * the device to the specified or a safer state.
+ * Called from the CPUidle framework to program the device to the
+ * specified target state selected by the governor.
+ *
+ * This function checks for any pending activity or dependency between
+ * power domains states and then programs the device to the specified
+ * or a safer state.
  */
 static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 			       struct cpuidle_state *state)
@@ -241,19 +258,13 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 		goto select_state;
 	}
 
-	/*
-	 * FIXME: we currently manage device-specific idle states
-	 *        for PER and CORE in combination with CPU-specific
-	 *        idle states.  This is wrong, and device-specific
-	 *        idle management needs to be separated out into
-	 *        its own code.
-	 */
+	new_state = next_valid_state(dev, state);
 
 	/*
 	 * Prevent PER off if CORE is not in retention or off as this
 	 * would disable PER wakeups completely.
 	 */
-	cx = cpuidle_get_statedata(state);
+	cx = cpuidle_get_statedata(new_state);
 	core_next_state = cx->core_state;
 	per_next_state = per_saved_state = pwrdm_read_next_pwrst(per_pd);
 	if ((per_next_state == PWRDM_POWER_OFF) &&
@@ -264,8 +275,6 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	if (per_next_state != per_saved_state)
 		pwrdm_set_next_pwrst(per_pd, per_next_state);
 
-	new_state = next_valid_state(dev, state);
-
 select_state:
 	dev->last_state = new_state;
 	ret = omap3_enter_idle(dev, new_state);
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 4e166ad..aca3b6c 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -43,9 +43,22 @@ static inline int omap4_opp_init(void)
  * omap3_pm_init_cpuidle
  */
 struct cpuidle_params {
-	u32 exit_latency;	/* exit_latency = sleep + wake-up latencies */
+	/*
+	 * exit_latency = sleep + wake-up latencies of the MPU,
+	 * which include the MPU itself and the peripherals needed
+	 * for the MPU to execute instructions (e.g. main memory,
+	 * caches, IRQ controller, MMU etc). Some of those peripherals
+	 * can belong to other power domains than the MPU subsystem and so
+	 * the corresponding latencies must be included in this figure.
+	 */
+	u32 exit_latency;
+	/*
+	 * target_residency: required amount of time in the C state
+	 * to break even on energy cost
+	 */
 	u32 target_residency;
-	u8 valid;		/* validates the C-state */
+	/* validates the C-state on the given board */
+	u8 valid;
 };
 
 #if defined(CONFIG_PM) && defined(CONFIG_CPU_IDLE)
-- 
1.7.4.1

