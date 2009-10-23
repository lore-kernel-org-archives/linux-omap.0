From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 02/11] OMAP3: Disable Smartreflex before pwrdm enters RET
Date: Fri, 23 Oct 2009 19:03:46 +0300
Message-ID: <1256313835-2391-3-git-send-email-tero.kristo@nokia.com>
References: <>
 <1256313835-2391-1-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-2-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21471 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbZJWQSa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 12:18:30 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9NGIRW2001485
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 19:18:32 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-da02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9NGIPi6022176
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 19:18:28 +0300
In-Reply-To: <1256313835-2391-2-git-send-email-tero.kristo@nokia.com>
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
 arch/arm/mach-omap2/pm34xx.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 8353764..6782792 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -403,11 +403,17 @@ void omap_sram_idle(void)
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
@@ -480,10 +486,16 @@ void omap_sram_idle(void)
 			prm_clear_mod_reg_bits(OMAP3430_AUTO_RET,
 						OMAP3430_GR_MOD,
 						OMAP3_PRM_VOLTCTRL_OFFSET);
-		/* Enable smartreflex after WFI */
+	}
+
+	/*
+	 * Enable smartreflex after WFI. Only needed if we entered
+	 * retention or off
+	 */
+	if (mpu_next_state <= PWRDM_POWER_RET)
 		enable_smartreflex(SR1);
+	if (core_next_state <= PWRDM_POWER_RET)
 		enable_smartreflex(SR2);
-	}
 
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
-- 
1.5.4.3

