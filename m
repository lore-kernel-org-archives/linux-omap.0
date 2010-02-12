From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv6 4/9] OMAP3: PM: Removed pwrdm state hacking from omap_sram_idle
Date: Fri, 12 Feb 2010 20:27:40 +0200
Message-ID: <1265999265-4363-5-git-send-email-tero.kristo@nokia.com>
References: <>
 <1265999265-4363-1-git-send-email-tero.kristo@nokia.com>
 <1265999265-4363-2-git-send-email-tero.kristo@nokia.com>
 <1265999265-4363-3-git-send-email-tero.kristo@nokia.com>
 <1265999265-4363-4-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53940 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757178Ab0BLQjn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 11:39:43 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o1CGdeQ6031377
	for <linux-omap@vger.kernel.org>; Fri, 12 Feb 2010 18:39:41 +0200
Received: from localhost.localdomain (sokoban.nmp.nokia.com [172.22.215.13])
	by mgw-sa01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o1CGdVLv021112
	for <linux-omap@vger.kernel.org>; Fri, 12 Feb 2010 18:39:36 +0200
In-Reply-To: <1265999265-4363-4-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Following hacks will be moved inside cpuidle in subsequent patch:

- CAM domain prevents idle completely
- PER should not go OFF if core remains active

This simplifies the design and allows cpuidle to keep better track of which
power states system will actually enter.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   19 ++-----------------
 1 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c2d80fc..cdbedcf 100644
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
 	core_next_state = omap3_pwrdm_read_next_pwrst(core_pwrdm);
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
@@ -554,8 +543,6 @@ void omap_sram_idle(void)
 		}
 		omap2_gpio_resume_after_idle();
 		omap_uart_resume_idle(2);
-		if (per_state_modified)
-			pwrdm_set_next_pwrst(per_pwrdm, PWRDM_POWER_OFF);
 	}
 
 	/* Disable IO-PAD and IO-CHAIN wakeup */
@@ -564,7 +551,6 @@ void omap_sram_idle(void)
 		omap3_disable_io_chain();
 	}
 
-
 	pwrdm_post_transition();
 }
 
@@ -1239,7 +1225,6 @@ static int __init omap3_pm_init(void)
 	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
 	per_pwrdm = pwrdm_lookup("per_pwrdm");
 	core_pwrdm = pwrdm_lookup("core_pwrdm");
-	cam_pwrdm = pwrdm_lookup("cam_pwrdm");
 
 	neon_clkdm = clkdm_lookup("neon_clkdm");
 	mpu_clkdm = clkdm_lookup("mpu_clkdm");
-- 
1.5.4.3

