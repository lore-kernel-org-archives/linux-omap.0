From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 5/6] OMAP3: PM: Enable IO / IO-CHAIN wakeups for PER
Date: Tue, 11 May 2010 16:47:10 -0700
Message-ID: <1273621631-9148-6-git-send-email-khilman@deeprootsystems.com>
References: <1273621631-9148-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38417 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991Ab0EKXrb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 19:47:31 -0400
Received: by mail-vw0-f46.google.com with SMTP id 17so1655954vws.19
        for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 16:47:30 -0700 (PDT)
In-Reply-To: <1273621631-9148-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Mike Chan <mike@android.com>

From: Mike Chan <mike@android.com>

IO events can also come from GPIO modules, which reside in the PER domain.
It is possible for the PER to enter RET while CORE is still in ON.
If GPIO 2-6 are enabled for IO-pad wakeups, the PER domain will not
wakeup in this case, unless we enable it.

Signed-off-by: Mike Chan <mike@android.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e76af5b..eec0916 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -379,9 +379,16 @@ void omap_sram_idle(void)
 	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
 		pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
 
-	/* PER */
+	/* Enable IO-PAD and IO-CHAIN wakeups */
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
 	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
+	if (per_next_state < PWRDM_POWER_ON ||
+			core_next_state < PWRDM_POWER_ON) {
+		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
+		omap3_enable_io_chain();
+	}
+
+	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		omap_uart_prepare_idle(2);
 		omap2_gpio_prepare_for_retention();
@@ -406,10 +413,8 @@ void omap_sram_idle(void)
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
@@ -471,7 +476,8 @@ void omap_sram_idle(void)
 	}
 
 	/* Disable IO-PAD and IO-CHAIN wakeup */
-	if (core_next_state < PWRDM_POWER_ON) {
+	if (per_next_state < PWRDM_POWER_ON ||
+			core_next_state < PWRDM_POWER_ON) {
 		prm_clear_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
 		omap3_disable_io_chain();
 	}
-- 
1.7.0.2

