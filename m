From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHV2 REPOST 6/7] ARM: OMAP3 PM: Remove IO Daisychain control from cpuidle
Date: Wed, 14 Dec 2011 21:31:16 +0530
Message-ID: <1323878477-21122-7-git-send-email-vishwanath.bs@ti.com>
References: <1323878477-21122-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38127 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045Ab1LNQKs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 11:10:48 -0500
In-Reply-To: <1323878477-21122-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

As IO Daisy chain sequence is triggered via hwmod mux, there is no need to
control it from cpuidle path for OMAP3.

Also as omap3_disable_io_chain is no longer being used, just remove the function.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Tested-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c       |   17 -----------------
 arch/arm/mach-omap2/prm2xxx_3xxx.c |    8 --------
 arch/arm/mach-omap2/prm2xxx_3xxx.h |    7 -------
 3 files changed, 0 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 258d871..175102c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -302,13 +302,6 @@ void omap_sram_idle(void)
 	/* Enable IO-PAD and IO-CHAIN wakeups */
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
 	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
-	if (omap3_has_io_wakeup() &&
-	    (per_next_state < PWRDM_POWER_ON ||
-	     core_next_state < PWRDM_POWER_ON)) {
-		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
-		if (omap3_has_io_chain_ctrl())
-			omap3_trigger_wuclk_ctrl();
-	}
 
 	/* Block console output in case it is on one of the OMAP UARTs */
 	if (!is_suspending())
@@ -406,16 +399,6 @@ void omap_sram_idle(void)
 		console_unlock();
 
 console_still_active:
-	/* Disable IO-PAD and IO-CHAIN wakeup */
-	if (omap3_has_io_wakeup() &&
-	    (per_next_state < PWRDM_POWER_ON ||
-	     core_next_state < PWRDM_POWER_ON)) {
-		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
-					     PM_WKEN);
-		if (omap3_has_io_chain_ctrl())
-			omap3_disable_io_chain();
-	}
-
 	clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
 }
 
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 6db5935..688e74c 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -252,14 +252,6 @@ void omap3_trigger_wuclk_ctrl(void)
 			     PM_WKEN);
 }
 
-/* OMAP3 Daisychain disable sequence */
-void omap3_disable_io_chain(void)
-{
-	if (omap_rev() >= OMAP3430_REV_ES3_1)
-		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
-			PM_WKEN);
-}
-
 static int __init omap3xxx_prcm_init(void)
 {
 	if (cpu_is_omap34xx())
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index e6f8206..6287dc4 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -295,12 +295,6 @@ static inline void omap3_trigger_wuclk_ctrl(void)
 		"not suppose to be used on omap4\n");
 	return 0;
 }
-static inline void omap3_disable_io_chain(void)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
-		"not suppose to be used on omap4\n");
-	return 0;
-}
 #else
 /* Power/reset management domain register get/set */
 extern u32 omap2_prm_read_mod_reg(s16 module, u16 idx);
@@ -315,7 +309,6 @@ extern int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift);
 extern int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift);
 extern int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift, u8 st_shift);
 extern void omap3_trigger_wuclk_ctrl(void);
-extern void omap3_disable_io_chain(void);
 
 /* OMAP3-specific VP functions */
 u32 omap3_prm_vp_check_txdone(u8 vp_id);
-- 
1.7.0.4

