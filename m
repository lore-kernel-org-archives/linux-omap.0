From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv2] OMAP3: CPUIdle: prevent CORE from going off if doing so would reset an active clockdomain
Date: Fri, 21 Jan 2011 12:37:05 +0200
Message-ID: <1295606225-11834-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:51836 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001Ab1AUJbl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Jan 2011 04:31:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

On OMAP3 SoCs, if the CORE powerdomain enters off-mode, many other
parts of the chip will be reset.  If those parts of the chip are busy,
the reset will disrupt them, causing unpredictable and generally
undesirable results. This reset is caused by the core domain wakeup
(COREDOMAINWKUP_RST), and it can occur for example in a case where
some peripheral domain is in retention or inactive state and core
enters off. This will result in the peripheral domain being reset.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   40 +++++++++++++++++++++++++++++++++++-
 1 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index f3e043f..d31b858 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -61,7 +61,7 @@ struct omap3_processor_cx {
 struct omap3_processor_cx omap3_power_states[OMAP3_MAX_STATES];
 struct omap3_processor_cx current_cx_state;
 struct powerdomain *mpu_pd, *core_pd, *per_pd;
-struct powerdomain *cam_pd;
+struct powerdomain *cam_pd, *dss_pd, *iva2_pd, *sgx_pd, *usb_pd;
 
 /*
  * The latencies/thresholds for various C states have
@@ -235,7 +235,7 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 {
 	struct cpuidle_state *new_state = next_valid_state(dev, state);
 	u32 core_next_state, per_next_state = 0, per_saved_state = 0;
-	u32 cam_state;
+	u32 cam_state, dss_state, iva2_state, sgx_state, usb_state;
 	struct omap3_processor_cx *cx;
 	int ret;
 
@@ -256,6 +256,8 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	 *        its own code.
 	 */
 
+	/* XXX Add CORE-active check here */
+
 	/*
 	 * Prevent idle completely if CAM is active.
 	 * CAM does not have wakeup capability in OMAP3.
@@ -275,6 +277,36 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	    (core_next_state > PWRDM_POWER_RET))
 		per_next_state = PWRDM_POWER_RET;
 
+	/* XXX Add prevent-PER-off check here */
+
+	/*
+	 * If we are attempting CORE off, check if any other powerdomains
+	 * are at retention or higher. CORE off causes chipwide reset which
+	 * would reset these domains also.
+	 */
+	if (core_next_state == PWRDM_POWER_OFF) {
+		iva2_state = pwrdm_read_pwrst(iva2_pd);
+		sgx_state = pwrdm_read_pwrst(sgx_pd);
+		usb_state = pwrdm_read_pwrst(usb_pd);
+		dss_state = pwrdm_read_pwrst(dss_pd);
+
+		if (cam_state > PWRDM_POWER_OFF ||
+		    dss_state > PWRDM_POWER_OFF ||
+		    iva2_state > PWRDM_POWER_OFF ||
+		    per_next_state > PWRDM_POWER_OFF ||
+		    sgx_state > PWRDM_POWER_OFF ||
+		    usb_state > PWRDM_POWER_OFF)
+			core_next_state = PWRDM_POWER_RET;
+	}
+
+	/* Fallback to new target core/mpu state */
+	while (cx->core_state < core_next_state) {
+		state--;
+		cx = cpuidle_get_statedata(state);
+	}
+
+	new_state = state;
+
 	/* Are we changing PER target state? */
 	if (per_next_state != per_saved_state)
 		pwrdm_set_next_pwrst(per_pd, per_next_state);
@@ -489,6 +521,10 @@ int __init omap3_idle_init(void)
 	core_pd = pwrdm_lookup("core_pwrdm");
 	per_pd = pwrdm_lookup("per_pwrdm");
 	cam_pd = pwrdm_lookup("cam_pwrdm");
+	dss_pd = pwrdm_lookup("dss_pwrdm");
+	iva2_pd = pwrdm_lookup("iva2_pwrdm");
+	sgx_pd = pwrdm_lookup("sgx_pwrdm");
+	usb_pd = pwrdm_lookup("usbhost_pwrdm");
 
 	omap_init_power_states();
 	cpuidle_register_driver(&omap3_idle_driver);
-- 
1.7.1

