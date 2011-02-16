From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH 2/3] OMAP3 PM: Update only enabled C states
Date: Wed, 16 Feb 2011 14:31:13 +0530
Message-ID: <1297846874-18286-3-git-send-email-vishwanath.bs@ti.com>
References: <1297846874-18286-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49635 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754343Ab1BPI6Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 03:58:16 -0500
In-Reply-To: <1297846874-18286-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: patches@linaro.org, Vishwanath BS <vishwanath.bs@ti.com>

Currently function omap3_cpuidle_update_states updates valid flag of all the C 
states which includes the one which are disabled at init. So it's not really 
possible to selectively disable some of the C states using valid flag.
This is fixed now by adding another flag called enabled which will be 
initialized at omap_init_power_states. So update_states will operated only on 
enabled C states.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   29 +++++++++++++++++++++++------
 1 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 1e4ec7f..40c020a
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -51,6 +51,7 @@
 
 struct omap3_processor_cx {
 	u8 valid;
+	u8 enabled;
 	u8 type;
 	u32 sleep_latency;
 	u32 wakeup_latency;
@@ -341,12 +342,13 @@ void omap3_cpuidle_update_states(u32 mpu_deepest_state, u32 core_deepest_state)
 
 	for (i = OMAP3_STATE_C1; i < OMAP3_MAX_STATES; i++) {
 		struct omap3_processor_cx *cx = &omap3_power_states[i];
-
-		if ((cx->mpu_state >= mpu_deepest_state) &&
-		    (cx->core_state >= core_deepest_state)) {
-			cx->valid = 1;
-		} else {
-			cx->valid = 0;
+		if (cx->enabled) {
+			if ((cx->mpu_state >= mpu_deepest_state) &&
+			    (cx->core_state >= core_deepest_state)) {
+				cx->valid = 1;
+			} else {
+				cx->valid = 0;
+			}
 		}
 	}
 }
@@ -387,6 +389,8 @@ void omap_init_power_states(void)
 	/* C1 . MPU WFI + Core active */
 	omap3_power_states[OMAP3_STATE_C1].valid =
 			cpuidle_params_table[OMAP3_STATE_C1].valid;
+	omap3_power_states[OMAP3_STATE_C1].enabled =
+			cpuidle_params_table[OMAP3_STATE_C1].valid;
 	omap3_power_states[OMAP3_STATE_C1].type = OMAP3_STATE_C1;
 	omap3_power_states[OMAP3_STATE_C1].sleep_latency =
 			cpuidle_params_table[OMAP3_STATE_C1].sleep_latency;
@@ -401,6 +405,8 @@ void omap_init_power_states(void)
 	/* C2 . MPU WFI + Core inactive */
 	omap3_power_states[OMAP3_STATE_C2].valid =
 			cpuidle_params_table[OMAP3_STATE_C2].valid;
+	omap3_power_states[OMAP3_STATE_C2].enabled =
+			cpuidle_params_table[OMAP3_STATE_C2].valid;
 	omap3_power_states[OMAP3_STATE_C2].type = OMAP3_STATE_C2;
 	omap3_power_states[OMAP3_STATE_C2].sleep_latency =
 			cpuidle_params_table[OMAP3_STATE_C2].sleep_latency;
@@ -416,6 +422,8 @@ void omap_init_power_states(void)
 	/* C3 . MPU CSWR + Core inactive */
 	omap3_power_states[OMAP3_STATE_C3].valid =
 			cpuidle_params_table[OMAP3_STATE_C3].valid;
+	omap3_power_states[OMAP3_STATE_C3].enabled =
+			cpuidle_params_table[OMAP3_STATE_C3].valid;
 	omap3_power_states[OMAP3_STATE_C3].type = OMAP3_STATE_C3;
 	omap3_power_states[OMAP3_STATE_C3].sleep_latency =
 			cpuidle_params_table[OMAP3_STATE_C3].sleep_latency;
@@ -431,6 +439,8 @@ void omap_init_power_states(void)
 	/* C4 . MPU OFF + Core inactive */
 	omap3_power_states[OMAP3_STATE_C4].valid =
 			cpuidle_params_table[OMAP3_STATE_C4].valid;
+	omap3_power_states[OMAP3_STATE_C4].enabled =
+			cpuidle_params_table[OMAP3_STATE_C4].valid;
 	omap3_power_states[OMAP3_STATE_C4].type = OMAP3_STATE_C4;
 	omap3_power_states[OMAP3_STATE_C4].sleep_latency =
 			cpuidle_params_table[OMAP3_STATE_C4].sleep_latency;
@@ -446,6 +456,8 @@ void omap_init_power_states(void)
 	/* C5 . MPU CSWR + Core CSWR*/
 	omap3_power_states[OMAP3_STATE_C5].valid =
 			cpuidle_params_table[OMAP3_STATE_C5].valid;
+	omap3_power_states[OMAP3_STATE_C5].enabled =
+			cpuidle_params_table[OMAP3_STATE_C5].valid;
 	omap3_power_states[OMAP3_STATE_C5].type = OMAP3_STATE_C5;
 	omap3_power_states[OMAP3_STATE_C5].sleep_latency =
 			cpuidle_params_table[OMAP3_STATE_C5].sleep_latency;
@@ -461,6 +473,8 @@ void omap_init_power_states(void)
 	/* C6 . MPU OFF + Core CSWR */
 	omap3_power_states[OMAP3_STATE_C6].valid =
 			cpuidle_params_table[OMAP3_STATE_C6].valid;
+	omap3_power_states[OMAP3_STATE_C6].enabled =
+			cpuidle_params_table[OMAP3_STATE_C6].valid;
 	omap3_power_states[OMAP3_STATE_C6].type = OMAP3_STATE_C6;
 	omap3_power_states[OMAP3_STATE_C6].sleep_latency =
 			cpuidle_params_table[OMAP3_STATE_C6].sleep_latency;
@@ -476,6 +490,8 @@ void omap_init_power_states(void)
 	/* C7 . MPU OFF + Core OFF */
 	omap3_power_states[OMAP3_STATE_C7].valid =
 			cpuidle_params_table[OMAP3_STATE_C7].valid;
+	omap3_power_states[OMAP3_STATE_C7].enabled =
+			cpuidle_params_table[OMAP3_STATE_C7].valid;
 	omap3_power_states[OMAP3_STATE_C7].type = OMAP3_STATE_C7;
 	omap3_power_states[OMAP3_STATE_C7].sleep_latency =
 			cpuidle_params_table[OMAP3_STATE_C7].sleep_latency;
@@ -495,6 +511,7 @@ void omap_init_power_states(void)
 	 */
 	if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583)) {
 		omap3_power_states[OMAP3_STATE_C7].valid = 0;
+		omap3_power_states[OMAP3_STATE_C7].enabled = 0;
 		cpuidle_params_table[OMAP3_STATE_C7].valid = 0;
 		pr_warn("%s: core off state C7 disabled due to i583\n",
 				__func__);
-- 
1.7.0.4

