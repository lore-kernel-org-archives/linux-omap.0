From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 3/9] OMAP3: PM: remove serial resume / idle calls from idle path
Date: Wed, 29 Jun 2011 12:04:57 +0300
Message-ID: <1309338303-2086-4-git-send-email-t-kristo@ti.com>
References: <1309338303-2086-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40687 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754130Ab1F2JFQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jun 2011 05:05:16 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5T95Guw019041
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:16 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep35.itg.ti.com (8.13.7/8.13.8) with ESMTP id p5T95GXf001798
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:16 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5T95FL7009148
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:15 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1309338303-2086-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is no longer needed as it will be handled within serial driver itself.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 89cf027..e626a3d 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -335,18 +335,9 @@ void omap_sram_idle(void)
 		omap3_enable_io_chain();
 	}
 
-	/* Block console output in case it is on one of the OMAP UARTs */
-	if (!is_suspending())
-		if (per_next_state < PWRDM_POWER_ON ||
-		    core_next_state < PWRDM_POWER_ON)
-			if (!console_trylock())
-				goto console_still_active;
-
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		per_going_off = (per_next_state == PWRDM_POWER_OFF) ? 1 : 0;
-		omap_uart_prepare_idle(2);
-		omap_uart_prepare_idle(3);
 		omap2_gpio_prepare_for_idle(per_going_off);
 		if (per_next_state == PWRDM_POWER_OFF)
 				omap3_per_save_context();
@@ -354,8 +345,6 @@ void omap_sram_idle(void)
 
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
-		omap_uart_prepare_idle(0);
-		omap_uart_prepare_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF) {
 			omap3_core_save_context();
 			omap3_cm_save_context();
@@ -402,8 +391,6 @@ void omap_sram_idle(void)
 			omap3_sram_restore_context();
 			omap2_sms_restore_context();
 		}
-		omap_uart_resume_idle(0);
-		omap_uart_resume_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF)
 			omap2_prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
 					       OMAP3430_GR_MOD,
@@ -417,14 +404,8 @@ void omap_sram_idle(void)
 		omap2_gpio_resume_after_idle();
 		if (per_prev_state == PWRDM_POWER_OFF)
 			omap3_per_restore_context();
-		omap_uart_resume_idle(2);
-		omap_uart_resume_idle(3);
 	}
 
-	if (!is_suspending())
-		console_unlock();
-
-console_still_active:
 	/* Disable IO-PAD and IO-CHAIN wakeup */
 	if (omap3_has_io_wakeup() &&
 	    (per_next_state < PWRDM_POWER_ON ||
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

