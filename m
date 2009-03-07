From: Sanjeev Premi <premi@ti.com>
Subject: [PATCHv2] PM : cpuidle - Update statistics for correct state
Date: Sun,  8 Mar 2009 01:15:49 +0530
Message-ID: <1236455149-17017-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59051 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755687AbZCGTp7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 7 Mar 2009 14:45:59 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n27Jjp1p016379
	for <linux-omap@vger.kernel.org>; Sat, 7 Mar 2009 13:45:57 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

When 'enable_off_mode' is 0, and (mpu_state < PWRDM_POWER_RET)
the local variables mpu_state and core_state are modified; but
the usage count for the original state selected by the governor
are updated.

This patch updates the 'last_state' in the cpuidle driver to ensure
that statistics for the correct state are updated.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   29 +++++++++++++++++++----------
 1 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 62fbb2e..b138abd 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -76,23 +76,32 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 {
 	struct omap3_processor_cx *cx = cpuidle_get_statedata(state);
 	struct timespec ts_preidle, ts_postidle, ts_idle;
-	u32 mpu_state = cx->mpu_state, core_state = cx->core_state;
-
-	current_cx_state = *cx;
+	u32 mpu_state, core_state;
 
 	/* Used to keep track of the total time in idle */
 	getnstimeofday(&ts_preidle);
 
-	local_irq_disable();
-	local_fiq_disable();
-
+	/*
+	 * Adjust the idle state (if required).
+	 * Also, ensure that usage statistics of correct state are updated.
+	 */
 	if (!enable_off_mode) {
-		if (mpu_state < PWRDM_POWER_RET)
-			mpu_state = PWRDM_POWER_RET;
-		if (core_state < PWRDM_POWER_RET)
-			core_state = PWRDM_POWER_RET;
+		if (cx->type > OMAP3_STATE_C4) {
+			state = &(dev->states[OMAP3_STATE_C4 - 1]);
+			dev->last_state = state ;
+
+			cx = cpuidle_get_statedata(state);
+		}
 	}
 
+	current_cx_state = *cx;
+
+	mpu_state = cx->mpu_state;
+	core_state = cx->core_state;
+
+	local_irq_disable();
+	local_fiq_disable();
+
 	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
 	pwrdm_set_next_pwrst(core_pd, core_state);
 
-- 
1.5.6

