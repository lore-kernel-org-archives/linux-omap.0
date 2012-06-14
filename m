From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 05/10] ARM: OMAP3: cpuidle: next C-state decision depends on the PM QoS MPU and CORE constraints
Date: Thu, 14 Jun 2012 17:05:56 +0200
Message-ID: <1339686361-11526-6-git-send-email-j-pihet@ti.com>
References: <1339686361-11526-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:45266 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756017Ab2FNPGS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 11:06:18 -0400
Received: by mail-we0-f174.google.com with SMTP id u7so1326961wey.19
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 08:06:17 -0700 (PDT)
In-Reply-To: <1339686361-11526-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

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
 arch/arm/mach-omap2/cpuidle34xx.c |   64 ++++++++++++++++++++++++-------------
 1 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index ef8d7d4..1f33b8e 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -92,8 +92,8 @@ static int _cpuidle_deny_idle(struct powerdomain *pwrdm,
 }
 
 static int __omap3_enter_idle(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-				int index)
+			      struct cpuidle_driver *drv,
+			      int index)
 {
 	struct omap3_idle_statedata *cx = &omap3_idle_data[index];
 	u32 mpu_state = cx->mpu_state, core_state = cx->core_state;
@@ -150,10 +150,14 @@ return_sleep_time:
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
+				   struct cpuidle_driver *drv,
+				   int index)
 {
 	return cpuidle_wrap_enter(dev, drv, index, __omap3_enter_idle);
 }
@@ -168,8 +172,10 @@ static inline int omap3_enter_idle(struct cpuidle_device *dev,
  * to the caller. Else, this function searches for a lower c-state which is
  * still valid (as defined in omap3_power_states[]) and returns its index.
  *
- * A state is valid if the 'valid' field is enabled and
- * if it satisfies the enable_off_mode condition.
+ * A state is valid if:
+ * . it satisfies the enable_off_mode flag,
+ * . the next state for MPU and CORE power domains is not lower than the
+ *   state programmed by the per-device PM QoS.
  */
 static int next_valid_state(struct cpuidle_device *dev,
 			    struct cpuidle_driver *drv, int index)
@@ -177,6 +183,8 @@ static int next_valid_state(struct cpuidle_device *dev,
 	struct omap3_idle_statedata *cx = &omap3_idle_data[index];
 	u32 mpu_deepest_state = PWRDM_FUNC_PWRST_CSWR;
 	u32 core_deepest_state = PWRDM_FUNC_PWRST_CSWR;
+	u32 mpu_pm_qos_next_state = mpu_pd->wkup_lat_next_state;
+	u32 core_pm_qos_next_state = core_pd->wkup_lat_next_state;
 	int idx;
 	int next_index = -1;
 
@@ -193,7 +201,9 @@ static int next_valid_state(struct cpuidle_device *dev,
 
 	/* Check if current state is valid */
 	if ((cx->mpu_state >= mpu_deepest_state) &&
-	    (cx->core_state >= core_deepest_state))
+	    (cx->core_state >= core_deepest_state) &&
+	    (cx->mpu_state >= mpu_pm_qos_next_state) &&
+	    (cx->core_state >= core_pm_qos_next_state))
 		return index;
 
 	/*
@@ -203,7 +213,9 @@ static int next_valid_state(struct cpuidle_device *dev,
 	for (idx = index - 1; idx >= 0; idx--) {
 		cx =  &omap3_idle_data[idx];
 		if ((cx->mpu_state >= mpu_deepest_state) &&
-		    (cx->core_state >= core_deepest_state)) {
+		    (cx->core_state >= core_deepest_state) &&
+		    (cx->mpu_state >= mpu_pm_qos_next_state) &&
+		    (cx->core_state >= core_pm_qos_next_state)) {
 			next_index = idx;
 			break;
 		}
@@ -224,12 +236,15 @@ static int next_valid_state(struct cpuidle_device *dev,
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
@@ -245,19 +260,13 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
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
-	cx = &omap3_idle_data[index];
+	cx = &omap3_idle_data[new_state_idx];
 	core_next_state = cx->core_state;
 	per_next_state = per_saved_state = pwrdm_read_next_func_pwrst(per_pd);
 	if ((per_next_state == PWRDM_FUNC_PWRST_OFF) &&
@@ -268,8 +277,6 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	if (per_next_state != per_saved_state)
 		omap_set_pwrdm_state(per_pd, per_next_state);
 
-	new_state_idx = next_valid_state(dev, drv, index);
-
 select_state:
 	ret = omap3_enter_idle(dev, drv, new_state_idx);
 
@@ -282,6 +289,19 @@ select_state:
 
 DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
 
+/*
+ * Note about the latency related fields of the cpuidle_driver struct:
+ *
+ * - exit_latency = sleep + wake-up latencies of the MPU,
+ *  which include the MPU itself and the peripherals needed
+ *  for the MPU to execute instructions (e.g. main memory,
+ *  caches, IRQ controller, MMU etc). Some of those peripherals
+ *  can belong to other power domains than the MPU subsystem and so
+ *  the corresponding latencies must be included in this figure
+ *
+ * - target_residency: required amount of time in the C state
+ *  to break even on energy cost
+ */
 struct cpuidle_driver omap3_idle_driver = {
 	.name = 	"omap3_idle",
 	.owner = 	THIS_MODULE,
-- 
1.7.7.6

