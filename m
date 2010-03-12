From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv7 3/7] OMAP3: CPUidle: Fixed support for ON / INACTIVE states
Date: Fri, 12 Mar 2010 17:39:13 +0200
Message-ID: <1268408357-15621-3-git-send-email-tero.kristo@nokia.com>
References: <>
 <1268408357-15621-1-git-send-email-tero.kristo@nokia.com>
 <1268408357-15621-2-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53994 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757962Ab0CLNyw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 08:54:52 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o2CDrj2f007397
	for <linux-omap@vger.kernel.org>; Fri, 12 Mar 2010 07:54:51 -0600
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-da01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o2CDsV8k003701
	for <linux-omap@vger.kernel.org>; Fri, 12 Mar 2010 15:54:34 +0200
In-Reply-To: <1268408357-15621-2-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

New powerdomain support code for INACTIVE state removes the need to control
clockdomains directly from cpuidle. Also, cpuidle state definitions can now
directly support ON / INACTIVE simplifying the implementation.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   36 ++++++------------------------------
 1 files changed, 6 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 3d3d035..9445e1e 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -93,20 +93,6 @@ static int omap3_idle_bm_check(void)
 	return 0;
 }
 
-static int _cpuidle_allow_idle(struct powerdomain *pwrdm,
-				struct clockdomain *clkdm)
-{
-	omap2_clkdm_allow_idle(clkdm);
-	return 0;
-}
-
-static int _cpuidle_deny_idle(struct powerdomain *pwrdm,
-				struct clockdomain *clkdm)
-{
-	omap2_clkdm_deny_idle(clkdm);
-	return 0;
-}
-
 /**
  * omap3_enter_idle - Programs OMAP3 to enter the specified state
  * @dev: cpuidle device
@@ -130,25 +116,15 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	local_irq_disable();
 	local_fiq_disable();
 
-	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
-	pwrdm_set_next_pwrst(core_pd, core_state);
+	omap3_pwrdm_set_next_pwrst(mpu_pd, mpu_state);
+	omap3_pwrdm_set_next_pwrst(core_pd, core_state);
 
 	if (omap_irq_pending() || need_resched())
 		goto return_sleep_time;
 
-	if (cx->type == OMAP3_STATE_C1) {
-		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_deny_idle);
-		pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
-	}
-
 	/* Execute ARM wfi */
 	omap_sram_idle();
 
-	if (cx->type == OMAP3_STATE_C1) {
-		pwrdm_for_each_clkdm(mpu_pd, _cpuidle_allow_idle);
-		pwrdm_for_each_clkdm(core_pd, _cpuidle_allow_idle);
-	}
-
 return_sleep_time:
 	getnstimeofday(&ts_postidle);
 	ts_idle = timespec_sub(ts_postidle, ts_preidle);
@@ -326,8 +302,8 @@ void omap_init_power_states(void)
 			cpuidle_params_table[OMAP3_STATE_C2].wake_latency;
 	omap3_power_states[OMAP3_STATE_C2].threshold =
 			cpuidle_params_table[OMAP3_STATE_C2].threshold;
-	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_ON;
-	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_INACTIVE;
+	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_INACTIVE;
 	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID;
 
 	/* C3 . MPU CSWR + Core inactive */
@@ -341,7 +317,7 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C3].threshold =
 			cpuidle_params_table[OMAP3_STATE_C3].threshold;
 	omap3_power_states[OMAP3_STATE_C3].mpu_state = PWRDM_POWER_RET;
-	omap3_power_states[OMAP3_STATE_C3].core_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C3].core_state = PWRDM_POWER_INACTIVE;
 	omap3_power_states[OMAP3_STATE_C3].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
 
@@ -356,7 +332,7 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C4].threshold =
 			cpuidle_params_table[OMAP3_STATE_C4].threshold;
 	omap3_power_states[OMAP3_STATE_C4].mpu_state = PWRDM_POWER_OFF;
-	omap3_power_states[OMAP3_STATE_C4].core_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C4].core_state = PWRDM_POWER_INACTIVE;
 	omap3_power_states[OMAP3_STATE_C4].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
 
-- 
1.5.4.3

