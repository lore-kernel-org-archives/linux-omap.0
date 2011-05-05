From: jean.pihet@newoldbits.com
Subject: [PATCH 4/4] OMAP3: cpuidle: change the power domains modes determination logic
Date: Thu,  5 May 2011 17:12:39 +0200
Message-ID: <1304608359-18061-5-git-send-email-j-pihet@ti.com>
References: <1304608359-18061-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45463 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754287Ab1EEPM4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 11:12:56 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so1692761wya.19
        for <linux-omap@vger.kernel.org>; Thu, 05 May 2011 08:12:55 -0700 (PDT)
In-Reply-To: <1304608359-18061-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

The achievable power modes of the power domains in cpuidle
depends on the system wide 'enable_off_mode' knob in debugfs.
Upon changing enable_off_mode, do not change the C-states
'valid' field but instead dynamically restrict the power modes
when entering idle.

The C-states 'valid' field is just used to enable/disable some
C-states at init and shall not be changed later on.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   58 +++++++++++++++---------------------
 arch/arm/mach-omap2/pm.h          |    4 --
 arch/arm/mach-omap2/pm34xx.c      |   12 -------
 3 files changed, 24 insertions(+), 50 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 5621b6e..402fd4d 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -141,22 +141,40 @@ return_sleep_time:
 }
 
 /**
- * next_valid_state - Find next valid c-state
+ * next_valid_state - Find next valid C-state
  * @dev: cpuidle device
- * @state: Currently selected c-state
+ * @state: Currently selected C-state
  *
  * If the current state is valid, it is returned back to the caller.
  * Else, this function searches for a lower c-state which is still
  * valid.
+ *
+ * A state is valid if the 'valid' field is enabled and
+ * if it satisfies the enable_off_mode condition.
  */
 static struct cpuidle_state *next_valid_state(struct cpuidle_device *dev,
 					      struct cpuidle_state *curr)
 {
 	struct cpuidle_state *next = NULL;
 	struct omap3_idle_statedata *cx = cpuidle_get_statedata(curr);
+	u32 mpu_deepest_state = PWRDM_POWER_RET;
+	u32 core_deepest_state = PWRDM_POWER_RET;
+
+	if (enable_off_mode) {
+		mpu_deepest_state = PWRDM_POWER_OFF;
+		/*
+		 * Erratum i583: valable for ES rev < Es1.2 on 3630.
+		 * CORE OFF mode is not supported in a stable form, restrict
+		 * instead the CORE state to RET.
+		 */
+		if (!IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583))
+			core_deepest_state = PWRDM_POWER_OFF;
+	}
 
 	/* Check if current state is valid */
-	if (cx->valid) {
+	if ((cx->valid) &&
+	    (cx->mpu_state >= mpu_deepest_state) &&
+	    (cx->core_state >= core_deepest_state)) {
 		return curr;
 	} else {
 		u8 idx = OMAP3_STATE_MAX;
@@ -179,7 +197,9 @@ static struct cpuidle_state *next_valid_state(struct cpuidle_device *dev,
 		idx--;
 		for (; idx >= OMAP3_STATE_MIN; idx--) {
 			cx = cpuidle_get_statedata(&dev->states[idx]);
-			if (cx->valid) {
+			if ((cx->valid) &&
+			    (cx->mpu_state >= mpu_deepest_state) &&
+			    (cx->core_state >= core_deepest_state)) {
 				next = &dev->states[idx];
 				break;
 			}
@@ -262,31 +282,6 @@ select_state:
 
 DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
 
-/**
- * omap3_cpuidle_update_states() - Update the cpuidle states
- * @mpu_deepest_state:	Enable states up to and including this for mpu domain
- * @core_deepest_state:	Enable states up to and including this for core domain
- *
- * This goes through the list of states available and enables and disables the
- * validity of C states based on deepest state that can be achieved for the
- * variable domain
- */
-void omap3_cpuidle_update_states(u32 mpu_deepest_state, u32 core_deepest_state)
-{
-	int i;
-
-	for (i = OMAP3_STATE_MIN; i < OMAP3_NB_STATES; i++) {
-		struct omap3_idle_statedata *cx = &omap3_idle_data[i];
-
-		if ((cx->mpu_state >= mpu_deepest_state) &&
-		    (cx->core_state >= core_deepest_state)) {
-			cx->valid = 1;
-		} else {
-			cx->valid = 0;
-		}
-	}
-}
-
 void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
 {
 	int i;
@@ -400,11 +395,6 @@ int __init omap3_idle_init(void)
 
 	dev->state_count = OMAP3_NB_STATES;
 
-	if (enable_off_mode)
-		omap3_cpuidle_update_states(PWRDM_POWER_OFF, PWRDM_POWER_OFF);
-	else
-		omap3_cpuidle_update_states(PWRDM_POWER_RET, PWRDM_POWER_RET);
-
 	if (cpuidle_register_device(dev)) {
 		printk(KERN_ERR "%s: CPUidle register device failed\n",
 		       __func__);
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 32dbc13..45bcfce 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -78,10 +78,6 @@ extern u32 sleep_while_idle;
 #define sleep_while_idle 0
 #endif
 
-#if defined(CONFIG_CPU_IDLE)
-extern void omap3_cpuidle_update_states(u32, u32);
-#endif
-
 #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
 extern void pm_dbg_update_time(struct powerdomain *pwrdm, int prev);
 extern int pm_dbg_regset_save(int reg_set);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 0c5e3a4..caf9f6c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -779,18 +779,6 @@ void omap3_pm_off_mode_enable(int enable)
 	else
 		state = PWRDM_POWER_RET;
 
-#ifdef CONFIG_CPU_IDLE
-	/*
-	 * Erratum i583: implementation for ES rev < Es1.2 on 3630. We cannot
-	 * enable OFF mode in a stable form for previous revisions, restrict
-	 * instead to RET
-	 */
-	if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583))
-		omap3_cpuidle_update_states(state, PWRDM_POWER_RET);
-	else
-		omap3_cpuidle_update_states(state, state);
-#endif
-
 	list_for_each_entry(pwrst, &pwrst_list, node) {
 		if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583) &&
 				pwrst->pwrdm == core_pwrdm &&
-- 
1.7.2.5

