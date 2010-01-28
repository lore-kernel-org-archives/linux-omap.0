From: Sanjeev Premi <premi@ti.com>
Subject: [PATCHv3] omap3: cpuidle: Update statistics for correct state
Date: Thu, 28 Jan 2010 23:16:43 +0530
Message-ID: <1264700803-23625-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54114 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756367Ab0A1Rqx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jan 2010 12:46:53 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o0SHkkFg021286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 28 Jan 2010 11:46:48 -0600
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

This revision takes in changes suggested by Kevin Hilman.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   98 ++++++++++++++++++++++++++++++++++---
 arch/arm/mach-omap2/pm.h          |    4 ++
 arch/arm/mach-omap2/pm34xx.c      |    4 ++
 3 files changed, 98 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 12f0cbf..ff1ad3d 100644
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
@@ -104,13 +106,6 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
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
 
@@ -141,6 +136,67 @@ return_sleep_time:
 }
 
 /**
+ * next_valid_state - Find next valid c-state
+ * @dev: cpuidle device
+ * @state: Currently selected c-state
+ *
+ * If the current state is valid, it is returned back to the caller.
+ * Else, this function searches for a lower c-state which is still
+ * valid (as defined in omap3_power_states[]).
+ */
+static struct cpuidle_state *next_valid_state(struct cpuidle_device *dev,
+						struct cpuidle_state *curr)
+{
+	struct cpuidle_state *next = NULL;
+	struct omap3_processor_cx *cx;
+
+	cx = (struct omap3_processor_cx *)cpuidle_get_statedata(curr);
+
+	/* Check if current state is valid */
+	if (cx->valid) {
+		return curr;
+	} else {
+		u8 idx = OMAP3_STATE_MAX;
+
+		/*
+		 * Reach the current state starting at highest C-state
+		 */
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
+		WARN_ON(next == NULL);
+
+		/*
+		 * Drop to next valid state.
+		 * Start search from the next (lower) state.
+		 */
+		idx--;
+		for (; idx >= OMAP3_STATE_C1; idx--) {
+			struct omap3_processor_cx *cx;
+
+			cx = cpuidle_get_statedata(&dev->states[idx]);
+			if (cx->valid) {
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
+/**
  * omap3_enter_idle_bm - Checks for any bus activity
  * @dev: cpuidle device
  * @state: The target state to be programmed
@@ -152,7 +208,7 @@ return_sleep_time:
 static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 			       struct cpuidle_state *state)
 {
-	struct cpuidle_state *new_state = state;
+	struct cpuidle_state *new_state = next_valid_state(dev, state);
 
 	if ((state->flags & CPUIDLE_FLAG_CHECK_BM) && omap3_idle_bm_check()) {
 		BUG_ON(!dev->safe_state);
@@ -165,6 +221,30 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 
 DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
 
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
+		struct omap3_processor_cx *cx = &omap3_power_states[i];
+
+		if (enable_off_mode) {
+			cx->valid = 1;
+		} else {
+			if ((cx->mpu_state == PWRDM_POWER_OFF) ||
+				(cx->core_state	== PWRDM_POWER_OFF))
+				cx->valid = 0;
+		}
+	}
+}
+
 /* omap3_init_power_states - Initialises the OMAP3 specific C states.
  *
  * Below is the desciption of each C state.
@@ -302,6 +382,8 @@ int __init omap3_idle_init(void)
 		return -EINVAL;
 	dev->state_count = count;
 
+	omap3_cpuidle_update_states();
+
 	if (cpuidle_register_device(dev)) {
 		printk(KERN_ERR "%s: CPUidle register device failed\n",
 		       __func__);
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 7a9c2d0..09c0144 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -37,6 +37,10 @@ extern int omap2_pm_debug;
 #define omap2_pm_debug				0
 #endif
 
+#if defined(CONFIG_CPU_IDLE)
+extern void omap3_cpuidle_update_states(void);
+#endif
+
 #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
 extern void pm_dbg_update_time(struct powerdomain *pwrdm, int prev);
 extern int pm_dbg_regset_save(int reg_set);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 5087b15..5320229 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -941,6 +941,10 @@ void omap3_pm_off_mode_enable(int enable)
 	else
 		state = PWRDM_POWER_RET;
 
+#ifdef CONFIG_CPU_IDLE
+	omap3_cpuidle_update_states();
+#endif
+
 	list_for_each_entry(pwrst, &pwrst_list, node) {
 		pwrst->next_state = state;
 		set_pwrdm_state(pwrst->pwrdm, state);
-- 
1.6.2.2

