From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv6 2/9] OMAP3: PM: Added support for INACTIVE and ON states in omap_sram_idle
Date: Fri, 12 Feb 2010 20:27:38 +0200
Message-ID: <1265999265-4363-3-git-send-email-tero.kristo@nokia.com>
References: <>
 <1265999265-4363-1-git-send-email-tero.kristo@nokia.com>
 <1265999265-4363-2-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25044 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757112Ab0BLQji (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 11:39:38 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o1CGdYic022894
	for <linux-omap@vger.kernel.org>; Fri, 12 Feb 2010 18:39:36 +0200
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-sa01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o1CGdVLt021112
	for <linux-omap@vger.kernel.org>; Fri, 12 Feb 2010 18:39:34 +0200
In-Reply-To: <1265999265-4363-2-git-send-email-tero.kristo@nokia.com>
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

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index f20d3d8..c2d80fc 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -383,9 +383,10 @@ void omap_sram_idle(void)
 	pwrdm_clear_all_prev_pwrst(core_pwrdm);
 	pwrdm_clear_all_prev_pwrst(per_pwrdm);
 
-	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
+	mpu_next_state = omap3_pwrdm_read_next_pwrst(mpu_pwrdm);
 	switch (mpu_next_state) {
 	case PWRDM_POWER_ON:
+	case PWRDM_POWER_INACTIVE:
 	case PWRDM_POWER_RET:
 		/* No need to save context */
 		save_state = 0;
@@ -403,11 +404,11 @@ void omap_sram_idle(void)
 
 	/* NEON control */
 	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
-		pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
+		omap3_pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
 
 	/* PER */
-	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
-	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
+	per_next_state = omap3_pwrdm_read_next_pwrst(per_pwrdm);
+	core_next_state = omap3_pwrdm_read_next_pwrst(core_pwrdm);
 	if (per_next_state < PWRDM_POWER_ON) {
 		omap2_gpio_prepare_for_idle(per_next_state);
 		if (per_next_state == PWRDM_POWER_OFF) {
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
@@ -730,7 +731,7 @@ static int omap3_pm_suspend(void)
 
 	/* Read current next_pwrsts */
 	list_for_each_entry(pwrst, &pwrst_list, node)
-		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst->pwrdm);
+		pwrst->saved_state = omap3_pwrdm_read_next_pwrst(pwrst->pwrdm);
 	/* Set ones wanted by suspend */
 	list_for_each_entry(pwrst, &pwrst_list, node) {
 		if (set_pwrdm_state(pwrst->pwrdm, pwrst->next_state))
-- 
1.5.4.3

