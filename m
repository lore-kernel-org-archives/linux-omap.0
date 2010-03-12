From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv7 6/7] OMAP3: PM: Moved pwrdm state control logic from omap_sram_idle to cpuidle
Date: Fri, 12 Mar 2010 17:39:16 +0200
Message-ID: <1268408357-15621-6-git-send-email-tero.kristo@nokia.com>
References: <>
 <1268408357-15621-1-git-send-email-tero.kristo@nokia.com>
 <1268408357-15621-2-git-send-email-tero.kristo@nokia.com>
 <1268408357-15621-3-git-send-email-tero.kristo@nokia.com>
 <1268408357-15621-4-git-send-email-tero.kristo@nokia.com>
 <1268408357-15621-5-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53982 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757705Ab0CLNym (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 08:54:42 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o2CDrxZ7008613
	for <linux-omap@vger.kernel.org>; Fri, 12 Mar 2010 07:54:41 -0600
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-da01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o2CDsV8n003701
	for <linux-omap@vger.kernel.org>; Fri, 12 Mar 2010 15:54:37 +0200
In-Reply-To: <1268408357-15621-5-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

This simplifies the design and allows cpuidle to keep better track of which
power states system will actually enter.

Following checks are made (and their reasoning):

- If CAM domain is active, prevent idle completely (moved from omap_sram_idle)
  * CAM pwrdm does not have HW wakeup capability
- If PER is likely to remain on, prevent PER off
  * Saves on unnecessary context save/restore
- If CORE domain is active, prevent PER off-mode (moved from omap_sram_idle)
  * PER off in this case would prevent wakeups from PER completely
- Only allow CORE off, if all peripheral domains are off
  * CORE off will cause a chipwide reset

Also, enabled CHECK_BM flag for C2, as this is needed for the camera case.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |  102 ++++++++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/pm34xx.c      |   19 +------
 2 files changed, 98 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 9445e1e..c3f2e03 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -60,7 +60,8 @@ struct omap3_processor_cx {
 
 struct omap3_processor_cx omap3_power_states[OMAP3_MAX_STATES];
 struct omap3_processor_cx current_cx_state;
-struct powerdomain *mpu_pd, *core_pd;
+static struct powerdomain *mpu_pd, *core_pd, *per_pd, *iva2_pd;
+static struct powerdomain *sgx_pd, *usb_pd, *cam_pd, *dss_pd;
 
 /*
  * The latencies/thresholds for various C states have
@@ -209,14 +210,96 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 			       struct cpuidle_state *state)
 {
 	struct cpuidle_state *new_state = next_valid_state(dev, state);
+	u32 per_state = 0, saved_per_state = 0, cam_state, usb_state;
+	u32 iva2_state, sgx_state, dss_state, new_core_state;
+	struct omap3_processor_cx *cx;
+	int ret;
+
+	if (state->flags & CPUIDLE_FLAG_CHECK_BM) {
+		if (omap3_idle_bm_check()) {
+			BUG_ON(!dev->safe_state);
+			new_state = dev->safe_state;
+			goto select_state;
+		}
+		cx = cpuidle_get_statedata(state);
+		new_core_state = cx->core_state;
+
+		/* Check if CORE is active, if yes, fallback to inactive */
+		if (!pwrdm_can_idle(core_pd))
+			new_core_state = PWRDM_POWER_INACTIVE;
+
+		/*
+		 * Prevent idle completely if CAM is active.
+		 * CAM does not have wakeup capability in OMAP3.
+		 */
+		cam_state = pwrdm_read_pwrst(cam_pd);
+		if (cam_state == PWRDM_POWER_ON) {
+			new_state = dev->safe_state;
+			goto select_state;
+		}
+
+		/*
+		 * Check if PER can idle or not. If we are not likely
+		 * to idle, deny PER off. This prevents unnecessary
+		 * context save/restore.
+		 */
+		saved_per_state = omap3_pwrdm_read_next_pwrst(per_pd);
+		if (pwrdm_can_idle(per_pd)) {
+			per_state = saved_per_state;
+			/*
+			 * Prevent PER off if CORE is active as this
+			 * would disable PER wakeups completely
+			 */
+			if (per_state == PWRDM_POWER_OFF &&
+			    new_core_state > PWRDM_POWER_RET)
+				per_state = PWRDM_POWER_RET;
+
+		} else if (saved_per_state == PWRDM_POWER_OFF)
+			per_state = PWRDM_POWER_RET;
+		else
+			per_state = saved_per_state;
+
+		/*
+		 * If we are attempting CORE off, check if any other
+		 * powerdomains are at retention or higher. CORE off causes
+		 * chipwide reset which would reset these domains also.
+		 */
+		if (new_core_state == PWRDM_POWER_OFF) {
+			dss_state = pwrdm_read_pwrst(dss_pd);
+			iva2_state = pwrdm_read_pwrst(iva2_pd);
+			sgx_state = pwrdm_read_pwrst(sgx_pd);
+			usb_state = pwrdm_read_pwrst(usb_pd);
+
+			if (cam_state > PWRDM_POWER_OFF ||
+			    dss_state > PWRDM_POWER_OFF ||
+			    iva2_state > PWRDM_POWER_OFF ||
+			    per_state > PWRDM_POWER_OFF ||
+			    sgx_state > PWRDM_POWER_OFF ||
+			    usb_state > PWRDM_POWER_OFF)
+				new_core_state = PWRDM_POWER_RET;
+		}
 
-	if ((state->flags & CPUIDLE_FLAG_CHECK_BM) && omap3_idle_bm_check()) {
-		BUG_ON(!dev->safe_state);
-		new_state = dev->safe_state;
+		/* Fallback to new target core state */
+		while (cx->core_state < new_core_state) {
+			state--;
+			cx = cpuidle_get_statedata(state);
+		}
+		new_state = state;
+
+		/* Are we changing PER target state? */
+		if (per_state != saved_per_state)
+			omap3_pwrdm_set_next_pwrst(per_pd, per_state);
 	}
 
+select_state:
 	dev->last_state = new_state;
-	return omap3_enter_idle(dev, new_state);
+	ret = omap3_enter_idle(dev, new_state);
+
+	/* Restore potentially tampered PER state */
+	if (per_state != saved_per_state)
+		omap3_pwrdm_set_next_pwrst(per_pd, saved_per_state);
+
+	return ret;
 }
 
 DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
@@ -304,7 +387,8 @@ void omap_init_power_states(void)
 			cpuidle_params_table[OMAP3_STATE_C2].threshold;
 	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_INACTIVE;
 	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_INACTIVE;
-	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID;
+	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID |
+				CPUIDLE_FLAG_CHECK_BM;
 
 	/* C3 . MPU CSWR + Core inactive */
 	omap3_power_states[OMAP3_STATE_C3].valid =
@@ -402,6 +486,12 @@ int __init omap3_idle_init(void)
 
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
 	core_pd = pwrdm_lookup("core_pwrdm");
+	per_pd = pwrdm_lookup("per_pwrdm");
+	iva2_pd = pwrdm_lookup("iva2_pwrdm");
+	sgx_pd = pwrdm_lookup("sgx_pwrdm");
+	usb_pd = pwrdm_lookup("usbhost_pwrdm");
+	cam_pd = pwrdm_lookup("cam_pwrdm");
+	dss_pd = pwrdm_lookup("dss_pwrdm");
 
 	omap_init_power_states();
 	cpuidle_register_driver(&omap3_idle_driver);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index f1f1932..78b0926 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -93,7 +93,6 @@ static int (*_omap_save_secure_sram)(u32 *addr);
 
 static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
 static struct powerdomain *core_pwrdm, *per_pwrdm;
-static struct powerdomain *cam_pwrdm;
 
 static struct prm_setup_vc prm_setup = {
 	.clksetup = 0xff,
@@ -373,7 +372,6 @@ void omap_sram_idle(void)
 	int core_next_state = PWRDM_POWER_ON;
 	int core_prev_state, per_prev_state;
 	u32 sdrc_pwr = 0;
-	int per_state_modified = 0;
 
 	if (!_omap_sram_idle)
 		return;
@@ -411,20 +409,11 @@ void omap_sram_idle(void)
 	core_next_state = omap3_pwrdm_read_next_pwrst(core_pwrdm);
 	if (per_next_state < PWRDM_POWER_ON) {
 		omap2_gpio_prepare_for_idle(per_next_state);
-		if (per_next_state == PWRDM_POWER_OFF) {
-			if (core_next_state == PWRDM_POWER_ON) {
-				per_next_state = PWRDM_POWER_RET;
-				pwrdm_set_next_pwrst(per_pwrdm, per_next_state);
-				per_state_modified = 1;
-			} else
-				omap3_per_save_context();
-		}
+		if (per_next_state == PWRDM_POWER_OFF)
+			omap3_per_save_context();
 		omap_uart_prepare_idle(2);
 	}
 
-	if (pwrdm_read_pwrst(cam_pwrdm) == PWRDM_POWER_ON)
-		omap2_clkdm_deny_idle(mpu_pwrdm->pwrdm_clkdms[0]);
-
 	/*
 	 * Disable smartreflex before entering WFI.
 	 * Only needed if we are going to enter retention or off.
@@ -554,8 +543,6 @@ void omap_sram_idle(void)
 		}
 		omap2_gpio_resume_after_idle();
 		omap_uart_resume_idle(2);
-		if (per_state_modified)
-			pwrdm_set_next_pwrst(per_pwrdm, PWRDM_POWER_OFF);
 	}
 
 	/* Disable IO-PAD and IO-CHAIN wakeup */
@@ -564,7 +551,6 @@ void omap_sram_idle(void)
 		omap3_disable_io_chain();
 	}
 
-
 	pwrdm_post_transition();
 }
 
@@ -1248,7 +1234,6 @@ static int __init omap3_pm_init(void)
 	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
 	per_pwrdm = pwrdm_lookup("per_pwrdm");
 	core_pwrdm = pwrdm_lookup("core_pwrdm");
-	cam_pwrdm = pwrdm_lookup("cam_pwrdm");
 
 	neon_clkdm = clkdm_lookup("neon_clkdm");
 	mpu_clkdm = clkdm_lookup("mpu_clkdm");
-- 
1.5.4.3

