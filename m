From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 6/6] ARM: OMAP3 PM: Remove IO Daisychain control from cpuidle
Date: Wed, 29 Feb 2012 16:27:01 +0200
Message-ID: <1330525621-29836-7-git-send-email-t-kristo@ti.com>
References: <1330525621-29836-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33331 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758051Ab2B2O10 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 09:27:26 -0500
In-Reply-To: <1330525621-29836-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

From: Vishwanath BS <vishwanath.bs@ti.com>

As IO Daisy chain sequence is triggered via hwmod mux, there is no need to
control it from cpuidle path for OMAP3.

Also as omap3_disable_io_chain is no longer being used, just remove the
function.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Tested-by: Govindraj.R <govindraj.raja@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c       |   17 -----------------
 arch/arm/mach-omap2/prm2xxx_3xxx.c |    8 --------
 arch/arm/mach-omap2/prm2xxx_3xxx.h |    7 -------
 3 files changed, 0 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e6c2d39..94d572d 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -291,13 +291,6 @@ void omap_sram_idle(void)
 	/* Enable IO-PAD and IO-CHAIN wakeups */
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
 	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
-	if (omap3_has_io_wakeup() &&
-	    (per_next_state < PWRDM_POWER_ON ||
-	     core_next_state < PWRDM_POWER_ON)) {
-		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
-		if (omap3_has_io_chain_ctrl())
-			omap3_trigger_io_chain();
-	}
 
 	pwrdm_pre_transition();
 
@@ -376,16 +369,6 @@ void omap_sram_idle(void)
 			omap3_per_restore_context();
 	}
 
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
index fc98781..d6b848c 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -325,14 +325,6 @@ void omap3_trigger_io_chain(void)
 				     PM_WKEN);
 }
 
-/* OMAP3 Daisychain disable sequence */
-void omap3_disable_io_chain(void)
-{
-	if (omap_rev() >= OMAP3430_REV_ES3_1)
-		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK,
-					     WKUP_MOD, PM_WKEN);
-}
-
 static int __init omap3xxx_prcm_init(void)
 {
 	if (cpu_is_omap34xx())
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 15973aa..391b844 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -295,12 +295,6 @@ static inline void omap3_trigger_io_chain(void)
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
 extern void omap3_trigger_io_chain(void);
-extern void omap3_disable_io_chain(void);
 
 /* OMAP3-specific VP functions */
 u32 omap3_prm_vp_check_txdone(u8 vp_id);
-- 
1.7.4.1

