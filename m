From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] OMAP3: PM: Prevent PER from going OFF when CORE is going INA
Date: Mon,  1 Dec 2008 13:32:46 +0200
Message-ID: <1228131166-12076-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:45350 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193AbYLALiE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2008 06:38:04 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mB1BbchE002712
	for <linux-omap@vger.kernel.org>; Mon, 1 Dec 2008 13:37:59 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mB1BbKu1015471
	for <linux-omap@vger.kernel.org>; Mon, 1 Dec 2008 13:37:21 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

OMAP3 can't generate wakeups in this state, thus it is not permitted.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 4a2837a..1186739 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -284,6 +284,7 @@ void omap_sram_idle(void)
 	int core_next_state = PWRDM_POWER_ON;
 	int core_prev_state, per_prev_state;
 	u32 sdrc_pwr = 0;
+	int per_state_modified = 0;
 
 	if (!_omap_sram_idle)
 		return;
@@ -320,15 +321,21 @@ void omap_sram_idle(void)
 
 	/* PER */
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
+	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
 	if (per_next_state < PWRDM_POWER_ON) {
 		omap_uart_prepare_idle(2);
 		omap2_gpio_prepare_for_retention();
-		if (per_next_state == PWRDM_POWER_OFF)
-			omap3_per_save_context();
+		if (per_next_state == PWRDM_POWER_OFF) {
+			if (core_next_state == PWRDM_POWER_ON) {
+				per_next_state = PWRDM_POWER_RET;
+				pwrdm_set_next_pwrst(per_pwrdm, per_next_state);
+				per_state_modified = 1;
+			} else
+				omap3_per_save_context();
+		}
 	}
 
 	/* CORE */
-	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
 	if (core_next_state < PWRDM_POWER_ON) {
 		omap_uart_prepare_idle(0);
 		omap_uart_prepare_idle(1);
@@ -405,6 +412,8 @@ void omap_sram_idle(void)
 			omap3_per_restore_context();
 		omap2_gpio_resume_after_retention();
 		omap_uart_resume_idle(2);
+		if (per_state_modified)
+			pwrdm_set_next_pwrst(per_pwrdm, PWRDM_POWER_OFF);
 	}
 
 	/* Disable IO-PAD wakeup */
-- 
1.5.4.3

