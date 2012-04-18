From: jean.pihet@newoldbits.com
Subject: [PATCH 4/6] ARM: OMAP3: cpuidle: next C-state decision depends on the PM QoS MPU and CORE constraints
Date: Wed, 18 Apr 2012 15:45:18 +0200
Message-ID: <1334756720-29166-5-git-send-email-j-pihet@ti.com>
References: <1334756720-29166-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:59177 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479Ab2DRNpu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Apr 2012 09:45:50 -0400
Received: by mail-we0-f174.google.com with SMTP id x9so4728703wej.19
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 06:45:49 -0700 (PDT)
In-Reply-To: <1334756720-29166-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org
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
Reviewed-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   59 ++++++++++++++++++++-----------------
 arch/arm/mach-omap2/pm.h          |   17 +++++++++-
 2 files changed, 47 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index ff2dea3..2f95cfc 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -39,7 +39,7 @@
 #ifdef CONFIG_CPU_IDLE
 
 /*
- * The latencies/thresholds for various C states have
+ * The MPU latencies/thresholds for various C states have
  * to be configured from the respective board files.
  * These are some default values (which might not provide
  * the best power savings) used on boards which do not
@@ -74,22 +74,21 @@ struct omap3_idle_statedata omap3_idle_data[OMAP3_NUM_STATES];
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
 }
 
 static int __omap3_enter_idle(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-				int index)
+			      struct cpuidle_driver *drv, int index)
 {
 	struct omap3_idle_statedata *cx =
 			cpuidle_get_statedata(&dev->states_usage[index]);
@@ -147,10 +146,13 @@ return_sleep_time:
  *
  * Called from the CPUidle framework to program the device to the
  * specified target state selected by the governor.
+ *
+ * Note: this function does not check for any pending activity or dependency
+ * between power domains states, so the caller shall check the parameters
+ * correctness.
  */
 static inline int omap3_enter_idle(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-				int index)
+				   struct cpuidle_driver *drv, int index)
 {
 	return cpuidle_wrap_enter(dev, drv, index, __omap3_enter_idle);
 }
@@ -165,18 +167,22 @@ static inline int omap3_enter_idle(struct cpuidle_device *dev,
  * to the caller. Else, this function searches for a lower c-state which is
  * still valid (as defined in omap3_power_states[]) and returns its index.
  *
- * A state is valid if the 'valid' field is enabled and
- * if it satisfies the enable_off_mode condition.
+ * A state is valid if:
+ * . the 'valid' field is enabled,
+ * . it satisfies the enable_off_mode flag,
+ * . the next state for MPU and CORE power domains is not lower than the
+ *   state programmed by the per-device PM QoS.
  */
 static int next_valid_state(struct cpuidle_device *dev,
-			struct cpuidle_driver *drv,
-				int index)
+			    struct cpuidle_driver *drv, int index)
 {
 	struct cpuidle_state_usage *curr_usage = &dev->states_usage[index];
 	struct cpuidle_state *curr = &drv->states[index];
 	struct omap3_idle_statedata *cx = cpuidle_get_statedata(curr_usage);
 	u32 mpu_deepest_state = PWRDM_FUNC_PWRST_CSWR;
 	u32 core_deepest_state = PWRDM_FUNC_PWRST_CSWR;
+	u32 mpu_pm_qos_next_state = mpu_pd->wkup_lat_next_state;
+	u32 core_pm_qos_next_state = core_pd->wkup_lat_next_state;
 	int next_index = -1;
 
 	if (enable_off_mode) {
@@ -193,7 +199,9 @@ static int next_valid_state(struct cpuidle_device *dev,
 	/* Check if current state is valid */
 	if ((cx->valid) &&
 	    (cx->mpu_state >= mpu_deepest_state) &&
-	    (cx->core_state >= core_deepest_state)) {
+	    (cx->core_state >= core_deepest_state) &&
+	    (cx->mpu_state >= mpu_pm_qos_next_state) &&
+	    (cx->core_state >= core_pm_qos_next_state)) {
 		return index;
 	} else {
 		int idx = OMAP3_NUM_STATES - 1;
@@ -218,7 +226,9 @@ static int next_valid_state(struct cpuidle_device *dev,
 			cx = cpuidle_get_statedata(&dev->states_usage[idx]);
 			if ((cx->valid) &&
 			    (cx->mpu_state >= mpu_deepest_state) &&
-			    (cx->core_state >= core_deepest_state)) {
+			    (cx->core_state >= core_deepest_state) &&
+			    (cx->mpu_state >= mpu_pm_qos_next_state) &&
+			    (cx->core_state >= core_pm_qos_next_state)) {
 				next_index = idx;
 				break;
 			}
@@ -239,12 +249,15 @@ static int next_valid_state(struct cpuidle_device *dev,
  * @drv: cpuidle driver
  * @index: array index of target state to be programmed
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
-				struct cpuidle_driver *drv,
-			       int index)
+			       struct cpuidle_driver *drv, int index)
 {
 	int new_state_idx;
 	u32 core_next_state, per_next_state = 0, per_saved_state = 0;
@@ -260,19 +273,13 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 		goto select_state;
 	}
 
-	/*
-	 * FIXME: we currently manage device-specific idle states
-	 *        for PER and CORE in combination with CPU-specific
-	 *        idle states.  This is wrong, and device-specific
-	 *        idle management needs to be separated out into
-	 *        its own code.
-	 */
+	new_state_idx = next_valid_state(dev, drv, index);
 
 	/*
 	 * Prevent PER off if CORE is not in retention or off as this
 	 * would disable PER wakeups completely.
 	 */
-	cx = cpuidle_get_statedata(&dev->states_usage[index]);
+	cx = cpuidle_get_statedata(&dev->states_usage[new_state_idx]);
 	core_next_state = cx->core_state;
 	per_next_state = per_saved_state = pwrdm_read_next_func_pwrst(per_pd);
 	if ((per_next_state == PWRDM_FUNC_PWRST_OFF) &&
@@ -283,8 +290,6 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	if (per_next_state != per_saved_state)
 		omap_set_pwrdm_state(per_pd, per_next_state);
 
-	new_state_idx = next_valid_state(dev, drv, index);
-
 select_state:
 	ret = omap3_enter_idle(dev, drv, new_state_idx);
 
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 36fa90b..c0b196b 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -45,9 +45,22 @@ static inline int omap4_opp_init(void)
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
1.7.7.6

