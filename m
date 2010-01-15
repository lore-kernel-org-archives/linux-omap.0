From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv3 4/6] OMAP3: PM: Removed pwrdm state hacking from omap_sram_idle
Date: Fri, 15 Jan 2010 14:46:55 +0200
Message-ID: <1263559617-663-5-git-send-email-tero.kristo@nokia.com>
References: <>
 <1263559617-663-1-git-send-email-tero.kristo@nokia.com>
 <1263559617-663-2-git-send-email-tero.kristo@nokia.com>
 <1263559617-663-3-git-send-email-tero.kristo@nokia.com>
 <1263559617-663-4-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45167 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab0AOKzc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 05:55:32 -0500
In-Reply-To: <1263559617-663-4-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com

From: Tero Kristo <tero.kristo@nokia.com>

Following hacks will be moved inside cpuidle in subsequent patch:

- CAM domain prevents idle completely
- PER should not go OFF if core remains active

This simplifies the design and allows cpuidle to keep better track of which
power states system will actually enter.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   18 ++----------------
 1 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7cc3293..549be95 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -93,7 +93,6 @@ static int (*_omap_save_secure_sram)(u32 *addr);
 
 static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
 static struct powerdomain *core_pwrdm, *per_pwrdm;
-static struct powerdomain *cam_pwrdm;
 
 static struct prm_setup_vc prm_setup = {
 	.clksetup = 0xff,
@@ -373,7 +372,6 @@ void omap_sram_idle(void)
 	int core_next_state = PWRDM_POWER_ON;
 	int core_prev_state, per_prev_state;
 	u32 sdrc_pwr = 0;
-	int per_state_modified = 0;
 
 	if (!_omap_sram_idle)
 		return;
@@ -411,20 +409,11 @@ void omap_sram_idle(void)
 	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
 	if (per_next_state < PWRDM_POWER_ON) {
 		omap2_gpio_prepare_for_idle(per_next_state);
-		if (per_next_state == PWRDM_POWER_OFF) {
-			if (core_next_state == PWRDM_POWER_ON) {
-				per_next_state = PWRDM_POWER_RET;
-				pwrdm_set_next_pwrst(per_pwrdm, per_next_state);
-				per_state_modified = 1;
-			} else
-				omap3_per_save_context();
-		}
+		if (per_next_state == PWRDM_POWER_OFF)
+			omap3_per_save_context();
 		omap_uart_prepare_idle(2);
 	}
 
-	if (pwrdm_read_pwrst(cam_pwrdm) == PWRDM_POWER_ON)
-		omap2_clkdm_deny_idle(mpu_pwrdm->pwrdm_clkdms[0]);
-
 	/*
 	 * Disable smartreflex before entering WFI.
 	 * Only needed if we are going to enter retention or off.
@@ -553,8 +542,6 @@ void omap_sram_idle(void)
 		}
 		omap2_gpio_resume_after_idle();
 		omap_uart_resume_idle(2);
-		if (per_state_modified)
-			pwrdm_set_next_pwrst(per_pwrdm, PWRDM_POWER_OFF);
 	}
 
 	/* Disable IO-PAD and IO-CHAIN wakeup */
@@ -1171,7 +1158,6 @@ static int __init omap3_pm_init(void)
 	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
 	per_pwrdm = pwrdm_lookup("per_pwrdm");
 	core_pwrdm = pwrdm_lookup("core_pwrdm");
-	cam_pwrdm = pwrdm_lookup("cam_pwrdm");
 
 	omap_push_sram_idle();
 #ifdef CONFIG_SUSPEND
-- 
1.5.4.3

