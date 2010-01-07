From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH] OMAP3 PM: Disable SR only during Device Retention/OFF
Date: Thu,  7 Jan 2010 11:22:06 +0530
Message-ID: <1262843526-22578-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37037 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751144Ab0AGFtX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 00:49:23 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o075nJ9t002763
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 6 Jan 2010 23:49:21 -0600
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id o075nHfj009110
	for <linux-omap@vger.kernel.org>; Thu, 7 Jan 2010 11:19:18 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Currently in omap_sram_idle function, SR is disabled whenever next state 
is retention/OFF w/o checking whether system can really enter retention/off.
This patch adds another condition to disable SR. Basically FCLK register for
Core and PER are checked before disabling SR. THis will give some more power
savings in MP3 usecase (where Core enters retention where as PER does not).

Tested OMAP3430 ZOOM2

Signed-off-by: Vishwanath BS <Vishwanath.bs@ti.com>
---
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 3868cdf..13c5dfb
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -479,6 +479,7 @@ void omap_sram_idle(void)
 	int mpu_logic_state, mpu_mem_state, core_logic_state, core_mem_state;
 	u32 sdrc_pwr = 0;
 	int per_state_modified = 0;
+	u32 fclk_status;
 
 	if (!_omap_sram_idle)
 		return;
@@ -545,15 +546,6 @@ void omap_sram_idle(void)
 	if (pwrdm_read_pwrst(cam_pwrdm) == PWRDM_POWER_ON)
 		omap2_clkdm_deny_idle(mpu_pwrdm->pwrdm_clkdms[0]);
 
-	/*
-	 * Disable smartreflex before entering WFI.
-	 * Only needed if we are going to enter retention or off.
-	 */
-	if (mpu_next_state <= PWRDM_POWER_RET)
-		disable_smartreflex(SR1);
-	if (core_next_state <= PWRDM_POWER_RET)
-		disable_smartreflex(SR2);
-
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
 		omap_uart_prepare_idle(0, core_next_state & core_logic_state);
@@ -600,6 +592,21 @@ void omap_sram_idle(void)
 	omap3_intc_prepare_idle();
 
 	/*
+	 * Disable smartreflex before entering WFI.
+	 * Only needed if we are going to enter retention or off.
+	 */
+	fclk_status = cm_read_mod_reg(OMAP3430_PER_MOD, CM_FCLKEN) |
+			cm_read_mod_reg(CORE_MOD, CM_FCLKEN1) |
+			cm_read_mod_reg(CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
+
+	if (!fclk_status) {
+		if (mpu_next_state <= PWRDM_POWER_RET)
+			disable_smartreflex(SR1);
+		if (core_next_state <= PWRDM_POWER_RET)
+			disable_smartreflex(SR2);
+	}
+
+	/*
 	* On EMU/HS devices ROM code restores a SRDC value
 	* from scratchpad which has automatic self refresh on timeout
 	* of AUTO_CNT = 1 enabled. This takes care of errata 1.142.
@@ -685,11 +692,12 @@ void omap_sram_idle(void)
 	 * Enable smartreflex after WFI. Only needed if we entered
 	 * retention or off
 	 */
-	if (mpu_next_state <= PWRDM_POWER_RET)
-		enable_smartreflex(SR1);
-	if (core_next_state <= PWRDM_POWER_RET)
-		enable_smartreflex(SR2);
-
+	if (!fclk_status) {
+		if (mpu_next_state <= PWRDM_POWER_RET)
+			enable_smartreflex(SR1);
+		if (core_next_state <= PWRDM_POWER_RET)
+			enable_smartreflex(SR2);
+	}
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		if (per_next_state == PWRDM_POWER_OFF) {
