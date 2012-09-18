From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 4/8] ARM: OMAP3: cpuidle: next C-state decision depends on the PM QoS MPU and CORE constraints
Date: Tue, 18 Sep 2012 10:52:08 +0200
Message-ID: <1347958332-2205-5-git-send-email-j-pihet@ti.com>
References: <1347958332-2205-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36927 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756944Ab2IRIwa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Sep 2012 04:52:30 -0400
Received: by wibhr14 with SMTP id hr14so3637834wib.1
        for <linux-omap@vger.kernel.org>; Tue, 18 Sep 2012 01:52:29 -0700 (PDT)
In-Reply-To: <1347958332-2205-1-git-send-email-j-pihet@ti.com>
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
 . it satisfies the enable_off_mode flag,
 . the next state for MPU and CORE power domains is not lower than the
   next state calculated by the per-device PM QoS.

Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   49 +++++++++++++++++++++++++------------
 1 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 4ca37d2..ca6cb71 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -76,8 +76,8 @@ static struct omap3_idle_statedata omap3_idle_data[] = {
 static struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
 
 static int __omap3_enter_idle(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-				int index)
+			      struct cpuidle_driver *drv,
+			      int index)
 {
 	struct omap3_idle_statedata *cx = &omap3_idle_data[index];
 	u32 mpu_state = cx->mpu_state, core_state = cx->core_state;
@@ -134,10 +134,14 @@ return_sleep_time:
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
@@ -152,8 +156,10 @@ static inline int omap3_enter_idle(struct cpuidle_device *dev,
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
@@ -161,6 +167,8 @@ static int next_valid_state(struct cpuidle_device *dev,
 	struct omap3_idle_statedata *cx = &omap3_idle_data[index];
 	u32 mpu_deepest_state = PWRDM_FUNC_PWRST_CSWR;
 	u32 core_deepest_state = PWRDM_FUNC_PWRST_CSWR;
+	u32 mpu_pm_qos_next_state = mpu_pd->wkup_lat_next_state;
+	u32 core_pm_qos_next_state = core_pd->wkup_lat_next_state;
 	int idx;
 	int next_index = 0; /* C1 is the default value */
 
@@ -177,7 +185,9 @@ static int next_valid_state(struct cpuidle_device *dev,
 
 	/* Check if current state is valid */
 	if ((cx->mpu_state >= mpu_deepest_state) &&
-	    (cx->core_state >= core_deepest_state))
+	    (cx->core_state >= core_deepest_state) &&
+	    (cx->mpu_state >= mpu_pm_qos_next_state) &&
+	    (cx->core_state >= core_pm_qos_next_state))
 		return index;
 
 	/*
@@ -187,7 +197,9 @@ static int next_valid_state(struct cpuidle_device *dev,
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
@@ -223,14 +235,6 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	else
 		new_state_idx = next_valid_state(dev, drv, index);
 
-	/*
-	 * FIXME: we currently manage device-specific idle states
-	 *        for PER and CORE in combination with CPU-specific
-	 *        idle states.  This is wrong, and device-specific
-	 *        idle management needs to be separated out into
-	 *        its own code.
-	 */
-
 	/* Program PER state */
 	cx = &omap3_idle_data[new_state_idx];
 	core_next_state = cx->core_state;
@@ -264,6 +268,19 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 
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

