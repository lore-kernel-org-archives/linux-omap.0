From: Mike Chan <mike@android.com>
Subject: [PATCH 1/2] omap: pm34xx: Enable IO / IO-CHAIN wakeups for PER
Date: Mon,  3 May 2010 14:26:57 -0700
Message-ID: <1272922018-11388-1-git-send-email-mike@android.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:58913 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757559Ab0ECV1Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 17:27:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-omap@vger.kernel.org, r-woodruff2@ti.com, tony@atomide.com, Mike Chan <mike@android.com>

IO events can also come from GPIO modules, which reside in the PER domain.
It is possible for the PER to enter RET while CORE is still in ON.
If GPIO 2-6 are enabled for IO-pad wakeups, the PER domain will not
wakeup in this case, unless we enable it.

Signed-off-by: Mike Chan <mike@android.com>
---
 arch/arm/mach-omap2/pm34xx.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ea0000b..2b2eaaa 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -371,6 +371,13 @@ void omap_sram_idle(void)
 	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
 		pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
 
+	/* Enable IO-PAD and IO-CHAIN wakeups */
+	if (per_next_state < PWRDM_POWER_ON ||
+			core_next_state < PWRDM_POWER_ON) {
+		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
+		omap3_enable_io_chain();
+	}
+
 	/* PER */
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
 	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
@@ -398,10 +405,8 @@ void omap_sram_idle(void)
 			omap3_core_save_context();
 			omap3_prcm_save_context();
 		}
-		/* Enable IO-PAD and IO-CHAIN wakeups */
-		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
-		omap3_enable_io_chain();
 	}
+
 	omap3_intc_prepare_idle();
 
 	/*
@@ -463,7 +468,8 @@ void omap_sram_idle(void)
 	}
 
 	/* Disable IO-PAD and IO-CHAIN wakeup */
-	if (core_next_state < PWRDM_POWER_ON) {
+	if (per_next_state < PWRDM_POWER_ON ||
+			core_next_state < PWRDM_POWER_ON) {
 		prm_clear_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
 		omap3_disable_io_chain();
 	}
-- 
1.7.0.1

