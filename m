From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv4 3/8] OMAP3: PM: Added support for INACTIVE and ON states for powerdomains
Date: Fri, 22 Jan 2010 19:55:46 +0200
Message-ID: <1264182951-9205-4-git-send-email-tero.kristo@nokia.com>
References: <>
 <1264182951-9205-1-git-send-email-tero.kristo@nokia.com>
 <1264182951-9205-2-git-send-email-tero.kristo@nokia.com>
 <1264182951-9205-3-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21295 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755669Ab0AVQFW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jan 2010 11:05:22 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o0MG4xuB000328
	for <linux-omap@vger.kernel.org>; Fri, 22 Jan 2010 18:05:19 +0200
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-da01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o0MG51XL002591
	for <linux-omap@vger.kernel.org>; Fri, 22 Jan 2010 18:05:05 +0200
In-Reply-To: <1264182951-9205-3-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Previously omap_sram_idle() did not know about the difference between ON and
INACTIVE states, which complicated the state handling in these cases. Now,
the following changes are done in the idle logic:

- Check for IO-chain arming is changed to reflect desired state (RET)
- UART clocks will be disabled if we attempt to enter INACTIVE (this allows
  the state change to actually happen)

Also, due to changes to pwrdm_set_next_pwrst() the behavior of
set_pwrdm_state() is modified accordingly.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   29 ++++++++++++++---------------
 1 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 190f25c..dceb18f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -386,6 +386,7 @@ void omap_sram_idle(void)
 	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
 	switch (mpu_next_state) {
 	case PWRDM_POWER_ON:
+	case PWRDM_POWER_INACTIVE:
 	case PWRDM_POWER_RET:
 		/* No need to save context */
 		save_state = 0;
@@ -452,9 +453,11 @@ void omap_sram_idle(void)
 						OMAP3430_GR_MOD,
 						OMAP3_PRM_VOLTCTRL_OFFSET);
 		}
-		/* Enable IO-PAD and IO-CHAIN wakeups */
-		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
-		omap3_enable_io_chain();
+		if (core_next_state <= PWRDM_POWER_RET) {
+			/* Enable IO-PAD and IO-CHAIN wakeups */
+			prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
+			omap3_enable_io_chain();
+		}
 	}
 	omap3_intc_prepare_idle();
 
@@ -556,15 +559,13 @@ void omap_sram_idle(void)
 	}
 
 	/* Disable IO-PAD and IO-CHAIN wakeup */
-	if (core_next_state < PWRDM_POWER_ON) {
+	if (core_next_state <= PWRDM_POWER_RET) {
 		prm_clear_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
 		omap3_disable_io_chain();
 	}
 
 
 	pwrdm_post_transition();
-
-	omap2_clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
 }
 
 int omap3_can_sleep(void)
@@ -582,7 +583,6 @@ int omap3_can_sleep(void)
 int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 {
 	u32 cur_state;
-	int sleep_switch = 0;
 	int ret = 0;
 
 	if (pwrdm == NULL || IS_ERR(pwrdm))
@@ -598,12 +598,6 @@ int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 	if (cur_state == state)
 		return ret;
 
-	if (pwrdm_read_pwrst(pwrdm) < PWRDM_POWER_ON) {
-		omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
-		sleep_switch = 1;
-		pwrdm_wait_transition(pwrdm);
-	}
-
 	ret = pwrdm_set_next_pwrst(pwrdm, state);
 	if (ret) {
 		printk(KERN_ERR "Unable to set state of powerdomain: %s\n",
@@ -611,8 +605,13 @@ int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 		goto err;
 	}
 
-	if (sleep_switch) {
-		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
+	cur_state = pwrdm_read_pwrst(pwrdm);
+	if (cur_state < PWRDM_POWER_ON && cur_state != state) {
+		/* Force wakeup */
+		omap2_clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
+		pwrdm_wait_transition(pwrdm);
+		if (state < PWRDM_POWER_ON)
+			omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
 		pwrdm_wait_transition(pwrdm);
 		pwrdm_state_switch(pwrdm);
 	}
-- 
1.5.4.3

