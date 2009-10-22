From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 29/32] OMAP3: PM: Prevent PER from going OFF when CORE is going INA
Date: Thu, 22 Oct 2009 16:09:50 -0700
Message-ID: <1256252993-24328-30-git-send-email-khilman@deeprootsystems.com>
References: <1256252993-24328-1-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-2-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-3-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-4-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-5-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-6-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-7-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-8-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-9-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-10-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-11-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-12-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-13-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-14-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-15-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-16-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-17-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-18-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-19-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-20-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-21-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-22-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-23-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-24-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-25-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-26-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-27-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-28-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-29-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f194.google.com ([209.85.221.194]:37878 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244AbZJVXLi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 19:11:38 -0400
Received: by mail-qy0-f194.google.com with SMTP id 32so5544712qyk.4
        for <linux-omap@vger.kernel.org>; Thu, 22 Oct 2009 16:11:43 -0700 (PDT)
In-Reply-To: <1256252993-24328-29-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tero Kristo <tero.kristo@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

OMAP3 can't generate wakeups in this state, thus it is not permitted.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index d8a6e10..55567bf 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -308,6 +308,7 @@ static void omap_sram_idle(void)
 	int core_next_state = PWRDM_POWER_ON;
 	int core_prev_state, per_prev_state;
 	u32 sdrc_pwr = 0;
+	int per_state_modified = 0;
 
 	if (!_omap_sram_idle)
 		return;
@@ -340,15 +341,21 @@ static void omap_sram_idle(void)
 
 	/* PER */
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
+	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
 	if (per_next_state < PWRDM_POWER_ON) {
-		omap2_gpio_prepare_for_retention();
 		omap_uart_prepare_idle(2);
-		if (per_next_state == PWRDM_POWER_OFF)
-			omap3_per_save_context();
+		omap2_gpio_prepare_for_retention();
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
@@ -413,10 +420,12 @@ static void omap_sram_idle(void)
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
-		omap_uart_resume_idle(2);
 		if (per_prev_state == PWRDM_POWER_OFF)
 			omap3_per_restore_context();
 		omap2_gpio_resume_after_retention();
+		omap_uart_resume_idle(2);
+		if (per_state_modified)
+			pwrdm_set_next_pwrst(per_pwrdm, PWRDM_POWER_OFF);
 	}
 
 	/* Disable IO-PAD wakeup */
-- 
1.6.4.3

