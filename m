From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv5 8/9] OMAP3: CPUidle: Fixed off-mode support to fall-back to proper C state
Date: Tue,  2 Feb 2010 16:52:26 +0200
Message-ID: <1265122347-2233-9-git-send-email-tero.kristo@nokia.com>
References: <>
 <1265122347-2233-1-git-send-email-tero.kristo@nokia.com>
 <1265122347-2233-2-git-send-email-tero.kristo@nokia.com>
 <1265122347-2233-3-git-send-email-tero.kristo@nokia.com>
 <1265122347-2233-4-git-send-email-tero.kristo@nokia.com>
 <1265122347-2233-5-git-send-email-tero.kristo@nokia.com>
 <1265122347-2233-6-git-send-email-tero.kristo@nokia.com>
 <1265122347-2233-7-git-send-email-tero.kristo@nokia.com>
 <1265122347-2233-8-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:52494 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755955Ab0BBNFD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 08:05:03 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o12D4v5p029899
	for <linux-omap@vger.kernel.org>; Tue, 2 Feb 2010 15:05:01 +0200
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-sa02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o12D2wJj029178
	for <linux-omap@vger.kernel.org>; Tue, 2 Feb 2010 15:03:08 +0200
In-Reply-To: <1265122347-2233-8-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

If off-mode is disabled, cpuidle now falls back to proper C state. Previously
the state was just simply hacked inside omap3_enter_idle which resulted
in wrong state residencies to be reported.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 38bd70c..dbb7315 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -115,13 +115,6 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	local_irq_disable();
 	local_fiq_disable();
 
-	if (!enable_off_mode) {
-		if (mpu_state < PWRDM_POWER_RET)
-			mpu_state = PWRDM_POWER_RET;
-		if (core_state < PWRDM_POWER_RET)
-			core_state = PWRDM_POWER_RET;
-	}
-
 	omap3_pwrdm_set_next_pwrst(mpu_pd, mpu_state);
 	omap3_pwrdm_set_next_pwrst(core_pd, core_state);
 
@@ -155,7 +148,7 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 {
 	struct cpuidle_state *new_state = state;
 	u32 per_state = 0, saved_per_state = 0, cam_state, usb_state;
-	u32 iva2_state, sgx_state, dss_state, new_core_state;
+	u32 iva2_state, sgx_state, dss_state, new_core_state, new_mpu_state;
 	struct omap3_processor_cx *cx;
 	int ret;
 
@@ -167,6 +160,14 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 		}
 		cx = cpuidle_get_statedata(state);
 		new_core_state = cx->core_state;
+		new_mpu_state = cx->mpu_state;
+
+		if (!enable_off_mode) {
+			if (new_mpu_state < PWRDM_POWER_RET)
+				new_mpu_state = PWRDM_POWER_RET;
+			if (new_core_state < PWRDM_POWER_RET)
+				new_core_state = PWRDM_POWER_RET;
+		}
 
 		/* Check if CORE is active, if yes, fallback to inactive */
 		if (!pwrdm_can_idle(core_pd))
@@ -221,8 +222,9 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 				new_core_state = PWRDM_POWER_RET;
 		}
 
-		/* Fallback to new target core state */
-		while (cx->core_state < new_core_state) {
+		/* Fallback to new target core/mpu state */
+		while (cx->core_state < new_core_state ||
+		       cx->mpu_state < new_mpu_state) {
 			state--;
 			cx = cpuidle_get_statedata(state);
 		}
-- 
1.5.4.3

