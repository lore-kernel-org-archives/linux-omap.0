From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH] arm: omap: Use only valid power domain states
Date: Mon, 30 Apr 2012 14:25:26 -0700
Message-ID: <1335821126-12994-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:35851 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418Ab2D3VZe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Apr 2012 17:25:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, paul@pwsan.com, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

Some parts of the OMAP code assume that all power
domains support certain states (e.g., RET & OFF).
This isn't always true (e.g., the am35x family of
SoC's) so those assumptions need to be removed.

Remove those assumptions by looking up the deepest
state that a power domain can be in whereever its
being blindly set.  The 'max()' of the deepest
state and what the code formerly wanted to set it
to, is the correct state.  If the code formerly
wanted to set it to PWRDM_POWER_OFF, then the
deepest possible state will be used (i.e., no
need to perform the 'max()').

The code still assumes that ON is a valid state.

Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---

These patches apply on top of Kevin's patch series,
      "[PATCH/RFT 0/8] ARM: OMAP: remove IP checks from SoC family detection"

Tested on an am3517 evm and am37x evm.

 arch/arm/mach-omap2/cpuidle34xx.c |   19 +++++++++++++------
 arch/arm/mach-omap2/pm34xx.c      |   15 +++++++++------
 arch/arm/mach-omap2/powerdomain.c |   25 +++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h |    2 ++
 4 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 5358664..2c91711 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -175,19 +175,25 @@ static int next_valid_state(struct cpuidle_device *dev,
 	struct cpuidle_state_usage *curr_usage = &dev->states_usage[index];
 	struct cpuidle_state *curr = &drv->states[index];
 	struct omap3_idle_statedata *cx = cpuidle_get_statedata(curr_usage);
-	u32 mpu_deepest_state = PWRDM_POWER_RET;
-	u32 core_deepest_state = PWRDM_POWER_RET;
+	u32 mpu_deepest_state, mpu_deepest_possible;
+	u32 core_deepest_state, core_deepest_possible;
 	int next_index = -1;
 
+	mpu_deepest_possible = pwrdm_get_deepest_state(mpu_pd);
+	mpu_deepest_state = max_t(u32, mpu_deepest_possible, PWRDM_POWER_RET);
+
+	core_deepest_possible = pwrdm_get_deepest_state(core_pd);
+	core_deepest_state = max_t(u32, core_deepest_possible, PWRDM_POWER_RET);
+
 	if (enable_off_mode) {
-		mpu_deepest_state = PWRDM_POWER_OFF;
+		mpu_deepest_state = mpu_deepest_possible;
 		/*
 		 * Erratum i583: valable for ES rev < Es1.2 on 3630.
 		 * CORE OFF mode is not supported in a stable form, restrict
 		 * instead the CORE state to RET.
 		 */
 		if (!IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583))
-			core_deepest_state = PWRDM_POWER_OFF;
+			core_deepest_state = core_deepest_possible;
 	}
 
 	/* Check if current state is valid */
@@ -422,8 +428,9 @@ int __init omap3_idle_init(void)
 		pr_warn("%s: core off state C7 disabled due to i583\n",
 			__func__);
 	}
-	cx->mpu_state = PWRDM_POWER_OFF;
-	cx->core_state = PWRDM_POWER_OFF;
+
+	cx->mpu_state = pwrdm_get_deepest_state(mpu_pd);
+	cx->core_state = pwrdm_get_deepest_state(core_pd);
 
 	drv->state_count = OMAP3_NUM_STATES;
 	cpuidle_register_driver(&omap3_idle_driver);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ec92676..40d8d07 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -614,12 +614,11 @@ void omap3_pm_off_mode_enable(int enable)
 	struct power_state *pwrst;
 	u32 state;
 
-	if (enable)
-		state = PWRDM_POWER_OFF;
-	else
-		state = PWRDM_POWER_RET;
-
 	list_for_each_entry(pwrst, &pwrst_list, node) {
+		state = pwrdm_get_deepest_state(pwrst->pwrdm);
+		if (!enable)
+			state = max_t(u32, state, PWRDM_POWER_RET);
+
 		if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583) &&
 				pwrst->pwrdm == core_pwrdm &&
 				state == PWRDM_POWER_OFF) {
@@ -660,6 +659,7 @@ int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state)
 static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 {
 	struct power_state *pwrst;
+	u32 state;
 
 	if (!pwrdm->pwrsts)
 		return 0;
@@ -668,7 +668,10 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_POWER_RET;
+
+	state = pwrdm_get_deepest_state(pwrdm);
+	pwrst->next_state = max_t(u32, state, PWRDM_POWER_RET);
+
 	list_add(&pwrst->node, &pwrst_list);
 
 	if (pwrdm_has_hdwr_sar(pwrdm))
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 96ad3dbe..9c80c19 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -1078,3 +1078,28 @@ bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm)
 
 	return 0;
 }
+
+/**
+ * pwrdm_get_deepest_state - Get deepest valid state domain can enter
+ * @pwrdm: struct powerdomain *
+ *
+ * Find and return the deepest valid state a power domain can be in.
+ * Returns the deepest state that @pwrdm can enter.
+ */
+u32 pwrdm_get_deepest_state(struct powerdomain *pwrdm)
+{
+	u32 valid_states, deepest_state;
+
+	valid_states = pwrdm->pwrsts;
+
+	if (valid_states & PWRSTS_OFF)
+		deepest_state = PWRDM_POWER_OFF;
+	else if (valid_states & PWRSTS_RET)
+		deepest_state = PWRDM_POWER_RET;
+	else if (valid_states & PWRSTS_INACTIVE)
+		deepest_state = PWRDM_POWER_INACTIVE;
+	else
+		deepest_state = PWRDM_POWER_ON;
+
+	return deepest_state;
+}
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 0d72a8a..9688ff1 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -220,6 +220,8 @@ int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
 int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
 bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
 
+u32 pwrdm_get_deepest_state(struct powerdomain *pwrdm);
+
 extern void omap242x_powerdomains_init(void);
 extern void omap243x_powerdomains_init(void);
 extern void omap3xxx_powerdomains_init(void);
-- 
1.7.9.4

