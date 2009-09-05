From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 1/1] PM : cpuidle - update statistics for correct state
Date: Sat,  5 Sep 2009 15:26:34 +0530
Message-ID: <1252144594-17906-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50321 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbZIEJ4j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Sep 2009 05:56:39 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n859uZ3Q013881
	for <linux-omap@vger.kernel.org>; Sat, 5 Sep 2009 04:56:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

When 'enable_off_mode' is 0, the target power state for MPU
and Core is locally changed to PWRDM_POWER_RET but, the
statistics are updated for idle state originally selected
by the governor.

This patch 'invalidates' the idle states that lead either of
MPU or Core to PWRDM_POWER_OFF state when 'enable_off_mode'
is '0'. The states are valid once 'enable_off_mode' is set
to '1'.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   34 +++++++++++++++++++++++++++-------
 arch/arm/mach-omap2/pm.h          |    2 ++
 arch/arm/mach-omap2/pm34xx.c      |    2 ++
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 7bbec90..19273b3 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -104,13 +104,6 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
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
 
@@ -254,6 +247,31 @@ void omap_init_power_states(void)
 				CPUIDLE_FLAG_CHECK_BM;
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
+					== PWRDM_POWER_RET))
+			omap3_power_states[i].valid = 0;
+		}
+	}
+}
+
 struct cpuidle_driver omap3_idle_driver = {
 	.name = 	"omap3_idle",
 	.owner = 	THIS_MODULE,
@@ -303,6 +321,8 @@ int omap3_idle_init(void)
 		return -EINVAL;
 	dev->state_count = count;
 
+	omap3_cpuidle_update_states();
+
 	if (cpuidle_register_device(dev)) {
 		printk(KERN_ERR "%s: CPUidle register device failed\n",
 		       __func__);
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 498f55d..d18fe49 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -86,6 +86,8 @@ extern void omap34xx_cpu_suspend(u32 *addr, int save_state);
 extern void save_secure_ram_context(u32 *addr);
 extern void omap3_save_scratchpad_contents(void);
 
+extern void omap3_cpuidle_update_states(void);
+
 extern unsigned int omap24xx_idle_loop_suspend_sz;
 extern unsigned int omap34xx_suspend_sz;
 extern unsigned int save_secure_ram_context_sz;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 9ce651a..6ebb4d1 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -968,6 +968,8 @@ void omap3_pm_off_mode_enable(int enable)
 	else
 		state = PWRDM_POWER_RET;
 
+	omap3_cpuidle_update_states();
+
 #ifdef CONFIG_OMAP_PM_SRF
 	resource_lock_opp(VDD1_OPP);
 	resource_lock_opp(VDD2_OPP);
-- 
1.6.2.2

