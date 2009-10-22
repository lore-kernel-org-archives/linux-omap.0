From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 28/32] OMAP3: PM: decouple PER and CORE context save and restore
Date: Thu, 22 Oct 2009 16:09:49 -0700
Message-ID: <1256252993-24328-29-git-send-email-khilman@deeprootsystems.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:3282 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755604AbZJVXLf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 19:11:35 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1260502qwb.37
        for <linux-omap@vger.kernel.org>; Thu, 22 Oct 2009 16:11:40 -0700 (PDT)
In-Reply-To: <1256252993-24328-28-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |   51 +++++++++++++++++++++++------------------
 1 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ff818aa..d8a6e10 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -338,19 +338,20 @@ static void omap_sram_idle(void)
 	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
 		set_pwrdm_state(neon_pwrdm, mpu_next_state);
 
-	/* CORE & PER */
+	/* PER */
+	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
+	if (per_next_state < PWRDM_POWER_ON) {
+		omap2_gpio_prepare_for_retention();
+		omap_uart_prepare_idle(2);
+		if (per_next_state == PWRDM_POWER_OFF)
+			omap3_per_save_context();
+	}
+
+	/* CORE */
 	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
 	if (core_next_state < PWRDM_POWER_ON) {
-		omap2_gpio_prepare_for_retention();
 		omap_uart_prepare_idle(0);
 		omap_uart_prepare_idle(1);
-		/* PER changes only with core */
-		per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
-		if (per_next_state < PWRDM_POWER_ON) {
-			omap_uart_prepare_idle(2);
-			if (per_next_state == PWRDM_POWER_OFF)
-				omap3_per_save_context();
-		}
 		if (core_next_state == PWRDM_POWER_OFF) {
 			omap3_core_save_context();
 			omap3_prcm_save_context();
@@ -392,14 +393,8 @@ static void omap_sram_idle(void)
 	if (pwrdm_read_prev_pwrst(mpu_pwrdm) == PWRDM_POWER_OFF)
 		restore_table_entry();
 
+	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
-		if (per_next_state < PWRDM_POWER_ON)
-			omap_uart_resume_idle(2);
-		omap_uart_resume_idle(1);
-		omap_uart_resume_idle(0);
-
-		/* Disable IO-PAD wakeup */
-		prm_clear_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
 		core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
 		if (core_prev_state == PWRDM_POWER_OFF) {
 			omap3_core_restore_context();
@@ -407,15 +402,27 @@ static void omap_sram_idle(void)
 			omap3_sram_restore_context();
 			omap2_sms_restore_context();
 		}
-		if (per_next_state < PWRDM_POWER_ON) {
-			per_prev_state =
-				pwrdm_read_prev_pwrst(per_pwrdm);
-			if (per_prev_state == PWRDM_POWER_OFF)
-				omap3_per_restore_context();
-		}
+		omap_uart_resume_idle(0);
+		omap_uart_resume_idle(1);
+		if (core_next_state == PWRDM_POWER_OFF)
+			prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF,
+					       OMAP3430_GR_MOD,
+					       OMAP3_PRM_VOLTCTRL_OFFSET);
+	}
+
+	/* PER */
+	if (per_next_state < PWRDM_POWER_ON) {
+		per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
+		omap_uart_resume_idle(2);
+		if (per_prev_state == PWRDM_POWER_OFF)
+			omap3_per_restore_context();
 		omap2_gpio_resume_after_retention();
 	}
 
+	/* Disable IO-PAD wakeup */
+	if (core_next_state < PWRDM_POWER_ON)
+		prm_clear_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
+
 	pwrdm_post_transition();
 
 }
-- 
1.6.4.3

