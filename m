From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 4/4] ARM: OMAP3: PM: Use .power_on/.power_down to clean omap_sram_idle
Date: Fri, 20 Jul 2012 11:34:44 +0530
Message-ID: <1342764284-8143-5-git-send-email-rnayak@ti.com>
References: <1342764284-8143-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53570 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099Ab2GTGFm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jul 2012 02:05:42 -0400
In-Reply-To: <1342764284-8143-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, t-kristo@ti.com, Rajendra Nayak <rnayak@ti.com>

With .power_on/.power_down hooks now available within the powerdomain
framework, its possible to clean a lot of mpu/core power_on/power_down
related code within omap_sram_idle into respective callbacks for these
powerdomains.

This should atleast also optimise the core domain context save
in CPUidle when attempting deeper C states, to prevent a core
domain context save when a device in core is still active.
The current code in such cases does a blind context save and
tries to put core domain down, even while devices are active.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |  127 +++++++++++++++++++++++-------------------
 1 files changed, 69 insertions(+), 58 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 9bdf53c..f64bcc6 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -266,22 +266,16 @@ static int omap34xx_do_sram_idle(unsigned long save_state)
 
 void omap_sram_idle(void)
 {
-	int mpu_next_state = PWRDM_POWER_ON;
-	int per_next_state = PWRDM_POWER_ON;
-	int core_next_state = PWRDM_POWER_ON;
+	int mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
+	int per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
+	int core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
 	int per_going_off;
-	int core_prev_state;
-	u32 sdrc_pwr = 0;
-
-	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
 
 	/* NEON control */
 	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
 		pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
 
 	/* Enable IO-PAD and IO-CHAIN wakeups */
-	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
-	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
 	if (omap3_has_io_wakeup() &&
 	    (per_next_state < PWRDM_POWER_ON ||
 	     core_next_state < PWRDM_POWER_ON)) {
@@ -298,62 +292,15 @@ void omap_sram_idle(void)
 		omap2_gpio_prepare_for_idle(per_going_off);
 	}
 
-	/* CORE */
-	if (core_next_state < PWRDM_POWER_ON) {
-		if (core_next_state == PWRDM_POWER_OFF) {
-			omap3_core_save_context();
-			omap3_cm_save_context();
-		}
-	}
-
-	omap3_intc_prepare_idle();
-
-	/*
-	 * On EMU/HS devices ROM code restores a SRDC value
-	 * from scratchpad which has automatic self refresh on timeout
-	 * of AUTO_CNT = 1 enabled. This takes care of erratum ID i443.
-	 * Hence store/restore the SDRC_POWER register here.
-	 */
-	if (cpu_is_omap3430() && omap_rev() >= OMAP3430_REV_ES3_0 &&
-	    (omap_type() == OMAP2_DEVICE_TYPE_EMU ||
-	     omap_type() == OMAP2_DEVICE_TYPE_SEC) &&
-	    core_next_state == PWRDM_POWER_OFF)
-		sdrc_pwr = sdrc_read_reg(SDRC_POWER);
-
 	/*
 	 * omap3_arm_context is the location where some ARM context
 	 * get saved. The rest is placed on the stack, and restored
 	 * from there before resuming.
 	 */
-	if (mpu_next_state == PWRDM_POWER_OFF) {
-		omap34xx_save_context(omap3_arm_context);
+	if (mpu_next_state == PWRDM_POWER_OFF)
 		cpu_suspend(1, omap34xx_do_sram_idle);
-	} else {
+	else
 		omap34xx_do_sram_idle(0);
-	}
-
-	/* Restore normal SDRC POWER settings */
-	if (cpu_is_omap3430() && omap_rev() >= OMAP3430_REV_ES3_0 &&
-	    (omap_type() == OMAP2_DEVICE_TYPE_EMU ||
-	     omap_type() == OMAP2_DEVICE_TYPE_SEC) &&
-	    core_next_state == PWRDM_POWER_OFF)
-		sdrc_write_reg(sdrc_pwr, SDRC_POWER);
-
-	/* CORE */
-	if (core_next_state < PWRDM_POWER_ON) {
-		core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
-		if (core_prev_state == PWRDM_POWER_OFF) {
-			omap3_core_restore_context();
-			omap3_cm_restore_context();
-			omap3_sram_restore_context();
-			omap2_sms_restore_context();
-		}
-		if (core_next_state == PWRDM_POWER_OFF)
-			omap2_prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
-					       OMAP3430_GR_MOD,
-					       OMAP3_PRM_VOLTCTRL_OFFSET);
-	}
-	omap3_intc_resume_idle();
 
 	pwrdm_cpu_wakeup();
 
@@ -374,6 +321,64 @@ void omap_sram_idle(void)
 	clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
 }
 
+int mpu_power_down(struct powerdomain *pwrdm, int next_state)
+{
+	omap3_intc_prepare_idle();
+	if (next_state == PWRDM_POWER_OFF)
+		omap34xx_save_context(omap3_arm_context);
+	return 0;
+}
+
+int mpu_power_on(struct powerdomain *pwrdm, int prev_state)
+{
+	omap3_intc_resume_idle();
+	return 0;
+}
+
+u32 sdrc_pwr;
+int core_attempted_state;
+int core_power_down(struct powerdomain *pwrdm, int next_state)
+{
+	if (next_state == PWRDM_POWER_OFF) {
+		omap3_core_save_context();
+		omap3_cm_save_context();
+
+		/*
+		 * On EMU/HS devices ROM code restores a SRDC value
+		 * from scratchpad which has automatic self refresh on timeout
+		 * of AUTO_CNT = 1 enabled. This takes care of erratum ID i443.
+		 * Hence store/restore the SDRC_POWER register here.
+		 */
+		if (cpu_is_omap3430() && omap_rev() >= OMAP3430_REV_ES3_0 &&
+		    (omap_type() == OMAP2_DEVICE_TYPE_EMU ||
+		     omap_type() == OMAP2_DEVICE_TYPE_SEC))
+			sdrc_pwr = sdrc_read_reg(SDRC_POWER);
+	}
+	core_attempted_state = next_state;
+	return 0;
+}
+
+int core_power_on(struct powerdomain *pwrdm, int prev_state)
+{
+	if (prev_state == PWRDM_POWER_OFF) {
+		omap3_core_restore_context();
+		omap3_cm_restore_context();
+		omap3_sram_restore_context();
+		omap2_sms_restore_context();
+	}
+	if (core_attempted_state == PWRDM_POWER_OFF) {
+		/* Restore normal SDRC POWER settings */
+		if (cpu_is_omap3430() && omap_rev() >= OMAP3430_REV_ES3_0 &&
+		    (omap_type() == OMAP2_DEVICE_TYPE_EMU ||
+		     omap_type() == OMAP2_DEVICE_TYPE_SEC))
+			sdrc_write_reg(sdrc_pwr, SDRC_POWER);
+		omap2_prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
+				       OMAP3430_GR_MOD,
+				       OMAP3_PRM_VOLTCTRL_OFFSET);
+	}
+	return 0;
+}
+
 static void omap3_pm_idle(void)
 {
 	local_fiq_disable();
@@ -734,6 +739,12 @@ int __init omap3_pm_init(void)
 	core_pwrdm = pwrdm_lookup("core_pwrdm");
 	cam_pwrdm = pwrdm_lookup("cam_pwrdm");
 
+	mpu_pwrdm->power_on = mpu_power_on;
+	mpu_pwrdm->power_down = mpu_power_down;
+
+	core_pwrdm->power_on = core_power_on;
+	core_pwrdm->power_down = core_power_down;
+
 	neon_clkdm = clkdm_lookup("neon_clkdm");
 	mpu_clkdm = clkdm_lookup("mpu_clkdm");
 
-- 
1.7.1

