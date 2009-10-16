From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 07/17] OMAP3: Disable Smartreflex before pwrdm enters RET
Date: Fri, 16 Oct 2009 13:49:00 +0300
Message-ID: <1255690150-16853-8-git-send-email-tero.kristo@nokia.com>
References: <>
 <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-6-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-7-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32269 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756440AbZJPLEX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 07:04:23 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9GB2f4a011809
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 14:02:55 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-sa02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9GB2fa1022261
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 14:02:50 +0300
In-Reply-To: <1255690150-16853-7-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Smartreflex for the corresponding powerdomain (MPU/CORE) must be disabled
before the domain enters retention, otherwise the device may hang. This is
caused by overlapping smartreflex / auto retention command on the voltage
channel resulting in incorrect voltage.

This fix has been confirmed from TI.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 3e5ae14..5854fa7 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -531,11 +531,17 @@ void omap_sram_idle(void)
 	if (pwrdm_read_pwrst(cam_pwrdm) == PWRDM_POWER_ON)
 		omap2_clkdm_deny_idle(mpu_pwrdm->pwrdm_clkdms[0]);
 
-	/* CORE */
-	if (core_next_state < PWRDM_POWER_ON) {
-		/* Disable smartreflex before entering WFI */
+	/*
+	 * Disable smartreflex before entering WFI.
+	 * Only needed if we are going to enter retention or off.
+	 */
+	if (mpu_next_state <= PWRDM_POWER_RET)
 		disable_smartreflex(SR1);
+	if (core_next_state <= PWRDM_POWER_RET)
 		disable_smartreflex(SR2);
+
+	/* CORE */
+	if (core_next_state < PWRDM_POWER_ON) {
 		omap_uart_prepare_idle(0);
 		omap_uart_prepare_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF) {
@@ -608,10 +614,17 @@ void omap_sram_idle(void)
 			prm_clear_mod_reg_bits(OMAP3430_AUTO_RET,
 						OMAP3430_GR_MOD,
 						OMAP3_PRM_VOLTCTRL_OFFSET);
-		/* Enable smartreflex after WFI */
+	}
+
+	/*
+	 * Enable smartreflex after WFI. Only needed if we
+	 * entered retention or off.
+	 */
+	if (mpu_next_state <= PWRDM_POWER_RET)
 		enable_smartreflex(SR1);
+	if (core_next_state <= PWRDM_POWER_RET)
 		enable_smartreflex(SR2);
-	}
+
 	if (core_saved_state != core_next_state)
 		pwrdm_set_next_pwrst(core_pwrdm, core_saved_state);
 
-- 
1.5.4.3

