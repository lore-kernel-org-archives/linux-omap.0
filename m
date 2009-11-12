From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 3/6] OMAP3: CPUidle: Fixed support for ON / INACTIVE states
Date: Thu, 12 Nov 2009 19:02:36 +0200
Message-ID: <1258045359-7962-4-git-send-email-tero.kristo@nokia.com>
References: <>
 <1258045359-7962-1-git-send-email-tero.kristo@nokia.com>
 <1258045359-7962-2-git-send-email-tero.kristo@nokia.com>
 <1258045359-7962-3-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43815 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835AbZKLRU2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 12:20:28 -0500
In-Reply-To: <1258045359-7962-3-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com

From: Tero Kristo <tero.kristo@nokia.com>

New powerdomain code support for INACTIVE state removes the need to control
clockdomains directly from cpuidle. Also, cpuidle state definitions can now
directly support ON / INACTIVE simplifying the implementation.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   32 ++++----------------------------
 1 files changed, 4 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index fdfa1d5..e46345f 100644
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
@@ -141,19 +127,9 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
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
@@ -242,8 +218,8 @@ void omap_init_power_states(void)
 			cpuidle_params_table[OMAP3_STATE_C2].wake_latency;
 	omap3_power_states[OMAP3_STATE_C2].threshold =
 			cpuidle_params_table[OMAP3_STATE_C2].threshold;
-	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_ON;
-	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_INACTIVE;
+	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_INACTIVE;
 	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID;
 
 	/* C3 . MPU CSWR + Core inactive */
@@ -256,7 +232,7 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C3].threshold =
 			cpuidle_params_table[OMAP3_STATE_C3].threshold;
 	omap3_power_states[OMAP3_STATE_C3].mpu_state = PWRDM_POWER_RET;
-	omap3_power_states[OMAP3_STATE_C3].core_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C3].core_state = PWRDM_POWER_INACTIVE;
 	omap3_power_states[OMAP3_STATE_C3].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
 
@@ -270,7 +246,7 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C4].threshold =
 			cpuidle_params_table[OMAP3_STATE_C4].threshold;
 	omap3_power_states[OMAP3_STATE_C4].mpu_state = PWRDM_POWER_OFF;
-	omap3_power_states[OMAP3_STATE_C4].core_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C4].core_state = PWRDM_POWER_INACTIVE;
 	omap3_power_states[OMAP3_STATE_C4].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
 
-- 
1.5.4.3

