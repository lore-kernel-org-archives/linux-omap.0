From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHv2 6/7] ARM: OMAP3 PM: Remove IO Daisychain control from cpuidle
Date: Fri, 7 Oct 2011 23:17:50 +0530
Message-ID: <1318009671-12813-7-git-send-email-vishwanath.bs@ti.com>
References: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43416 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786Ab1JGRzN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Oct 2011 13:55:13 -0400
In-Reply-To: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

As IO Daisy chain sequence is triggered via hwmod mux, there is no need to
control it from cpuidle path for OMAP3.

Also as omap3_disable_io_chain is no longer being used, just remove the function.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c       |   15 ---------------
 arch/arm/mach-omap2/prm2xxx_3xxx.c |    8 --------
 2 files changed, 0 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c282552..ea78d72 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -341,12 +341,6 @@ void omap_sram_idle(void)
 	/* Enable IO-PAD and IO-CHAIN wakeups */
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
 	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
-	if (omap3_has_io_wakeup() &&
-	    (per_next_state < PWRDM_POWER_ON ||
-	     core_next_state < PWRDM_POWER_ON)) {
-		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
-		omap3_trigger_wuclk_ctrl();
-	}
 
 	/* Block console output in case it is on one of the OMAP UARTs */
 	if (!is_suspending())
@@ -438,15 +432,6 @@ void omap_sram_idle(void)
 		console_unlock();
 
 console_still_active:
-	/* Disable IO-PAD and IO-CHAIN wakeup */
-	if (omap3_has_io_wakeup() &&
-	    (per_next_state < PWRDM_POWER_ON ||
-	     core_next_state < PWRDM_POWER_ON)) {
-		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
-					     PM_WKEN);
-		omap3_disable_io_chain();
-	}
-
 	pwrdm_post_transition();
 
 	clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 915d726..0c70bc4 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -183,11 +183,3 @@ void omap3_trigger_wuclk_ctrl(void)
 				     PM_WKEN);
 	}
 }
-
-/* OMAP3 Daisychain disable sequence */
-void omap3_disable_io_chain(void)
-{
-	if (omap_rev() >= OMAP3430_REV_ES3_1)
-		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
-				       PM_WKEN);
-}
-- 
1.7.0.4

