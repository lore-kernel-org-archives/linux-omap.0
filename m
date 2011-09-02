From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 7/8] OMAP2+: cpuidle only influences the MPU state
Date: Fri,  2 Sep 2011 15:13:23 +0200
Message-ID: <1314969204-21704-8-git-send-email-j-pihet@ti.com>
References: <1314969204-21704-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44822 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab1IBNNz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 09:13:55 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so1943107wyh.19
        for <linux-omap@vger.kernel.org>; Fri, 02 Sep 2011 06:13:54 -0700 (PDT)
In-Reply-To: <1314969204-21704-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.co>
Cc: Jean Pihet <j-pihet@ti.com>

Since cpuidle is a CPU centric framework it decides the MPU
next power state based on the MPU exit_latency and target_residency
figures.

The rest of the power domains get their next power state programmed
from the devices PM QoS framework, via the devices wake-up latency
constraints.

Note: the exit_latency and target_residency figures of the MPU
include the MPU itself and the peripherals needed for the MPU to
execute instructions (e.g. main memory, caches, IRQ controller,
MMU etc). Some of those peripherals can belong to other power domains
than the MPU subsystem and so the corresponding latencies must be
included in this figure.

Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constraints
on MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   42 +++++++++++-------------------------
 arch/arm/mach-omap2/pm.h          |   17 +++++++++++++-
 2 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 4bf6e6e..b43d1d2 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -37,26 +37,26 @@
 #ifdef CONFIG_CPU_IDLE
 
 /*
- * The latencies/thresholds for various C states have
+ * The MPU latencies/thresholds for various C states have
  * to be configured from the respective board files.
  * These are some default values (which might not provide
  * the best power savings) used on boards which do not
  * pass these details from the board file.
  */
 static struct cpuidle_params cpuidle_params_table[] = {
-	/* C1 */
+	/* C1 . MPU WFI + Core active */
 	{2 + 2, 5, 1},
-	/* C2 */
+	/* C2 . MPU WFI + Core inactive */
 	{10 + 10, 30, 1},
-	/* C3 */
+	/* C3 . MPU CSWR + Core inactive */
 	{50 + 50, 300, 1},
-	/* C4 */
+	/* C4 . MPU OFF + Core inactive */
 	{1500 + 1800, 4000, 1},
-	/* C5 */
+	/* C5 . MPU RET + Core RET */
 	{2500 + 7500, 12000, 1},
-	/* C6 */
+	/* C6 . MPU OFF + Core RET */
 	{3000 + 8500, 15000, 1},
-	/* C7 */
+	/* C7 . MPU OFF + Core OFF */
 	{10000 + 30000, 300000, 1},
 };
 #define OMAP3_NUM_STATES ARRAY_SIZE(cpuidle_params_table)
@@ -64,7 +64,6 @@ static struct cpuidle_params cpuidle_params_table[] = {
 /* Mach specific information to be recorded in the C-state driver_data */
 struct omap3_idle_statedata {
 	u32 mpu_state;
-	u32 core_state;
 	u8 valid;
 };
 struct omap3_idle_statedata omap3_idle_data[OMAP3_NUM_STATES];
@@ -98,7 +97,7 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 {
 	struct omap3_idle_statedata *cx = cpuidle_get_statedata(state);
 	struct timespec ts_preidle, ts_postidle, ts_idle;
-	u32 mpu_state = cx->mpu_state, core_state = cx->core_state;
+	u32 mpu_state = cx->mpu_state;
 
 	/* Used to keep track of the total time in idle */
 	getnstimeofday(&ts_preidle);
@@ -107,7 +106,6 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	local_fiq_disable();
 
 	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
-	pwrdm_set_next_pwrst(core_pd, core_state);
 
 	if (omap_irq_pending() || need_resched())
 		goto return_sleep_time;
@@ -156,6 +154,7 @@ static struct cpuidle_state *next_valid_state(struct cpuidle_device *dev,
 	struct omap3_idle_statedata *cx = cpuidle_get_statedata(curr);
 	u32 mpu_deepest_state = PWRDM_POWER_RET;
 	u32 core_deepest_state = PWRDM_POWER_RET;
+	u32 core_next_state = pwrdm_read_next_pwrst(core_pd);
 
 	if (enable_off_mode) {
 		mpu_deepest_state = PWRDM_POWER_OFF;
@@ -171,7 +170,7 @@ static struct cpuidle_state *next_valid_state(struct cpuidle_device *dev,
 	/* Check if current state is valid */
 	if ((cx->valid) &&
 	    (cx->mpu_state >= mpu_deepest_state) &&
-	    (cx->core_state >= core_deepest_state)) {
+	    (core_next_state >= core_deepest_state)) {
 		return curr;
 	} else {
 		int idx = OMAP3_NUM_STATES - 1;
@@ -196,7 +195,7 @@ static struct cpuidle_state *next_valid_state(struct cpuidle_device *dev,
 			cx = cpuidle_get_statedata(&dev->states[idx]);
 			if ((cx->valid) &&
 			    (cx->mpu_state >= mpu_deepest_state) &&
-			    (cx->core_state >= core_deepest_state)) {
+			    (core_next_state >= core_deepest_state)) {
 				next = &dev->states[idx];
 				break;
 			}
@@ -242,19 +241,11 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	}
 
 	/*
-	 * FIXME: we currently manage device-specific idle states
-	 *        for PER and CORE in combination with CPU-specific
-	 *        idle states.  This is wrong, and device-specific
-	 *        idle management needs to be separated out into
-	 *        its own code.
-	 */
-
-	/*
 	 * Prevent PER off if CORE is not in retention or off as this
 	 * would disable PER wakeups completely.
 	 */
 	cx = cpuidle_get_statedata(state);
-	core_next_state = cx->core_state;
+	core_next_state = pwrdm_read_next_pwrst(core_pd);
 	per_next_state = per_saved_state = pwrdm_read_next_pwrst(per_pd);
 	if ((per_next_state == PWRDM_POWER_OFF) &&
 	    (core_next_state > PWRDM_POWER_RET))
@@ -346,32 +337,26 @@ int __init omap3_idle_init(void)
 	dev->safe_state = &dev->states[0];
 	cx->valid = 1;	/* C1 is always valid */
 	cx->mpu_state = PWRDM_POWER_ON;
-	cx->core_state = PWRDM_POWER_ON;
 
 	/* C2 . MPU WFI + Core inactive */
 	cx = _fill_cstate(dev, 1, "MPU ON + CORE ON");
 	cx->mpu_state = PWRDM_POWER_ON;
-	cx->core_state = PWRDM_POWER_ON;
 
 	/* C3 . MPU CSWR + Core inactive */
 	cx = _fill_cstate(dev, 2, "MPU RET + CORE ON");
 	cx->mpu_state = PWRDM_POWER_RET;
-	cx->core_state = PWRDM_POWER_ON;
 
 	/* C4 . MPU OFF + Core inactive */
 	cx = _fill_cstate(dev, 3, "MPU OFF + CORE ON");
 	cx->mpu_state = PWRDM_POWER_OFF;
-	cx->core_state = PWRDM_POWER_ON;
 
 	/* C5 . MPU RET + Core RET */
 	cx = _fill_cstate(dev, 4, "MPU RET + CORE RET");
 	cx->mpu_state = PWRDM_POWER_RET;
-	cx->core_state = PWRDM_POWER_RET;
 
 	/* C6 . MPU OFF + Core RET */
 	cx = _fill_cstate(dev, 5, "MPU OFF + CORE RET");
 	cx->mpu_state = PWRDM_POWER_OFF;
-	cx->core_state = PWRDM_POWER_RET;
 
 	/* C7 . MPU OFF + Core OFF */
 	cx = _fill_cstate(dev, 6, "MPU OFF + CORE OFF");
@@ -386,7 +371,6 @@ int __init omap3_idle_init(void)
 			__func__);
 	}
 	cx->mpu_state = PWRDM_POWER_OFF;
-	cx->core_state = PWRDM_POWER_OFF;
 
 	dev->state_count = OMAP3_NUM_STATES;
 	if (cpuidle_register_device(dev)) {
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

