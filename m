From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv6 3/9] OMAP3: CPUidle: Fixed support for ON / INACTIVE states
Date: Fri, 12 Feb 2010 20:27:39 +0200
Message-ID: <1265999265-4363-4-git-send-email-tero.kristo@nokia.com>
References: <>
 <1265999265-4363-1-git-send-email-tero.kristo@nokia.com>
 <1265999265-4363-2-git-send-email-tero.kristo@nokia.com>
 <1265999265-4363-3-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:64043 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757214Ab0BLQjn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 11:39:43 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o1CGdMDc021705
	for <linux-omap@vger.kernel.org>; Fri, 12 Feb 2010 10:39:42 -0600
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-sa01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o1CGdVLu021112
	for <linux-omap@vger.kernel.org>; Fri, 12 Feb 2010 18:39:35 +0200
In-Reply-To: <1265999265-4363-3-git-send-email-tero.kristo@nokia.com>
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
index 1cfa5a6..86f580b 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -91,20 +91,6 @@ static int omap3_idle_bm_check(void)
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
@@ -135,25 +121,15 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 			core_state = PWRDM_POWER_RET;
 	}
 
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
@@ -246,8 +222,8 @@ void omap_init_power_states(void)
 			cpuidle_params_table[OMAP3_STATE_C2].wake_latency;
 	omap3_power_states[OMAP3_STATE_C2].threshold =
 			cpuidle_params_table[OMAP3_STATE_C2].threshold;
-	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_ON;
-	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_INACTIVE;
+	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_INACTIVE;
 	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID;
 
 	/* C3 . MPU CSWR + Core inactive */
@@ -261,7 +237,7 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C3].threshold =
 			cpuidle_params_table[OMAP3_STATE_C3].threshold;
 	omap3_power_states[OMAP3_STATE_C3].mpu_state = PWRDM_POWER_RET;
-	omap3_power_states[OMAP3_STATE_C3].core_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C3].core_state = PWRDM_POWER_INACTIVE;
 	omap3_power_states[OMAP3_STATE_C3].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
 
@@ -276,7 +252,7 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C4].threshold =
 			cpuidle_params_table[OMAP3_STATE_C4].threshold;
 	omap3_power_states[OMAP3_STATE_C4].mpu_state = PWRDM_POWER_OFF;
-	omap3_power_states[OMAP3_STATE_C4].core_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C4].core_state = PWRDM_POWER_INACTIVE;
 	omap3_power_states[OMAP3_STATE_C4].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
 
-- 
1.5.4.3

