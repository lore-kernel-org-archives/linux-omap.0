From: Sanjeev Premi <premi@ti.com>
Subject: [PATCHv2 1/1] omap3: cpuidle: Update statistics for correct state
Date: Tue, 24 Nov 2009 23:20:39 +0530
Message-ID: <1259085039-13305-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40288 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933692AbZKXRug (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Nov 2009 12:50:36 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAOHoeRh017887
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2009 11:50:42 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

When 'enable_off_mode' is 0, the target power state for MPU
and CORE was locally changed to PWRDM_POWER_RET but, the
statistics are updated for idle state originally selected
by the governor.

This patch 'invalidates' the idle states that lead either of
MPU or Core to PWRDM_POWER_OFF state when 'enable_off_mode'
is '0'. The states are valid once 'enable_off_mode' is set
to '1'.

Added function next_valid_state() to check if current state
is valid; else get the next valid state. It is called from
omap3_enter_idle_bm().

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   98 ++++++++++++++++++++++++++++++++++---
 arch/arm/mach-omap2/pm.h          |    1 +
 arch/arm/mach-omap2/pm34xx.c      |    4 ++
 3 files changed, 95 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index fdfa1d5..308865c 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -45,6 +45,8 @@
 #define OMAP3_STATE_C6 5 /* C6 - MPU OFF + Core RET */
 #define OMAP3_STATE_C7 6 /* C7 - MPU OFF + Core OFF */
 
+#define OMAP3_STATE_MAX OMAP3_STATE_C7
+
 struct omap3_processor_cx {
 	u8 valid;
 	u8 type;
@@ -128,13 +130,6 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	local_irq_disable();
 	local_fiq_disable();
 
-	if (!enable_off_mode) {
-		if (mpu_state < PWRDM_POWER_RET)
-			mpu_state = PWRDM_POWER_RET;
-		if (core_state < PWRDM_POWER_RET)
-			core_state = PWRDM_POWER_RET;
-	}
-
 	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
 	pwrdm_set_next_pwrst(core_pd, core_state);
 
@@ -164,6 +159,65 @@ return_sleep_time:
 	return (u32)timespec_to_ns(&ts_idle)/1000;
 }
 
+
+/* next_valid_state - Find next valid c-state
+ * @dev: cpuidle device
+ * @state: Currently selected c-state
+ *
+ * If the current state is valid, it is returned back to the caller.
+ * Else, this function searches for a lower c-state which is still
+ * valid (as defined in omap3_power_states[]).
+ */
+static struct cpuidle_state* next_valid_state(struct cpuidle_device *dev,
+						struct cpuidle_state *curr)
+{
+	struct cpuidle_state *next = NULL;
+	struct omap3_processor_cx *cx;
+
+	cx = (struct omap3_processor_cx *)cpuidle_get_statedata(curr);
+
+	/* Check if current state is valid */
+	if (cx->valid) {
+		next = curr;
+	}
+	else {
+		u8 idx = OMAP3_STATE_MAX;
+
+		/* Reach the current state starting at highest C-state */
+		for (; idx >= OMAP3_STATE_C1; idx--) {
+			if (&dev->states[idx] == curr) {
+				next = &dev->states[idx];
+				break;
+			}
+		}
+
+		/*
+		 * Should never hit this condition.
+		 */
+		BUG_ON(next == NULL);
+
+		/* Drop to next valid state.
+		 * Start search from the next (lower) state.
+		 */
+		idx--;
+		for (; idx >= OMAP3_STATE_C1; idx--) {
+			if (((struct omap3_processor_cx *)
+				cpuidle_get_statedata(
+					&dev->states[idx]))->valid) {
+				next = &dev->states[idx];
+				break;
+			}
+		}
+		/*
+		 * C1 and C2 are always valid.
+		 * So, no need to check for 'next==NULL' outside this loop.
+		 */
+	}
+
+	return next;
+}
+
+
 /**
  * omap3_enter_idle_bm - Checks for any bus activity
  * @dev: cpuidle device
@@ -176,7 +230,7 @@ return_sleep_time:
 static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 			       struct cpuidle_state *state)
 {
-	struct cpuidle_state *new_state = state;
+	struct cpuidle_state *new_state= next_valid_state(dev, state);
 
 	if ((state->flags & CPUIDLE_FLAG_CHECK_BM) && omap3_idle_bm_check()) {
 		BUG_ON(!dev->safe_state);
@@ -207,6 +261,32 @@ void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
 	return;
 }
 
+/**
+ * omap3_cpuidle_update_states - Update the cpuidle states.
+ *
+ * Currently, this function toggles the validity of idle states based upon
+ * the flag 'enable_off_mode'. When the flag is set all states are valid.
+ * Else, states leading to OFF state set to be invalid.
+ */
+void omap3_cpuidle_update_states(void)
+{
+	int i;
+
+	for (i = OMAP3_STATE_C1; i < OMAP3_MAX_STATES; i++) {
+		if (enable_off_mode) {
+			omap3_power_states[i].valid = 1;
+		}
+		else {
+			if ((omap3_power_states[i].mpu_state
+					== PWRDM_POWER_OFF)
+				|| (omap3_power_states[i].core_state
+					== PWRDM_POWER_OFF))
+			omap3_power_states[i].valid = 0;
+		}
+	}
+}
+
+
 /* omap3_init_power_states - Initialises the OMAP3 specific C states.
  *
  * Below is the desciption of each C state.
@@ -365,6 +445,8 @@ int __init omap3_idle_init(void)
 		return -EINVAL;
 	dev->state_count = count;
 
+	omap3_cpuidle_update_states();
+
 	if (cpuidle_register_device(dev)) {
 		printk(KERN_ERR "%s: CPUidle register device failed\n",
 		       __func__);
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index b9421e8..9351490 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -51,6 +51,7 @@ struct cpuidle_params {
 extern void omap3_pm_init_vc(struct prm_setup_vc *setup_vc);
 #ifdef CONFIG_CPU_IDLE
 extern void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params);
+extern void omap3_cpuidle_update_states(void);
 #else
 static inline void omap3_pm_init_cpuidle(
 			struct cpuidle_params *cpuidle_board_params)
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 90c4949..d9f0626 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -981,6 +981,10 @@ void omap3_pm_off_mode_enable(int enable)
 	else
 		state = PWRDM_POWER_RET;
 
+#ifdef CONFIG_CPU_IDLE
+	omap3_cpuidle_update_states();
+#endif
+
 #ifdef CONFIG_OMAP_PM_SRF
 	resource_lock_opp(VDD1_OPP);
 	resource_lock_opp(VDD2_OPP);
-- 
1.6.2.2

