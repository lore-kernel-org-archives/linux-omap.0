From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH 4/4] ARM: OMAP3PLUS PM: Add IO Daisychain support via hwmod mux
Date: Tue, 4 Oct 2011 23:22:04 +0530
Message-ID: <1317750724-32553-5-git-send-email-vishwanath.bs@ti.com>
References: <1317750724-32553-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58504 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933289Ab1JDR7M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Oct 2011 13:59:12 -0400
In-Reply-To: <1317750724-32553-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

IO Daisychain feature has to be triggered whenever there is a change in
device's mux configuration.
The patch also removes IO Daisychain control from OMAP3 CPUIdle path since
it is not required anymore as it has handled via hwmod mux.

omap3_enable_io_chain is renamed as omap3_trigger_wuclk_ctrl as it is not really
enabling daisychain feature rather it triggers WUCLK CTRL.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    9 +++++++--
 arch/arm/mach-omap2/pm.c         |    9 +++++++++
 arch/arm/mach-omap2/pm.h         |    3 ++-
 arch/arm/mach-omap2/pm34xx.c     |   26 ++------------------------
 4 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 84cc0bd..070f3f5 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -151,6 +151,7 @@
 #include "prm44xx.h"
 #include "prminst44xx.h"
 #include "mux.h"
+#include "pm.h"
 
 /* Maximum microseconds to wait for OMAP module to softreset */
 #define MAX_MODULE_SOFTRESET_WAIT	10000
@@ -1462,8 +1463,10 @@ static int _enable(struct omap_hwmod *oh)
 	/* Mux pins for device runtime if populated */
 	if (oh->mux && (!oh->mux->enabled ||
 			((oh->_state == _HWMOD_STATE_IDLE) &&
-			 oh->mux->pads_dynamic)))
+			 oh->mux->pads_dynamic))) {
 		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
+		omap_trigger_wuclk_ctrl();
+	}
 
 	_add_initiator_dep(oh, mpu_oh);
 
@@ -1553,8 +1556,10 @@ static int _idle(struct omap_hwmod *oh)
 		clkdm_hwmod_disable(oh->clkdm, oh);
 
 	/* Mux pins for device idle if populated */
-	if (oh->mux && oh->mux->pads_dynamic)
+	if (oh->mux && oh->mux->pads_dynamic) {
 		omap_hwmod_mux(oh->mux, _HWMOD_STATE_IDLE);
+		omap_trigger_wuclk_ctrl();
+	}
 
 	oh->_state = _HWMOD_STATE_IDLE;
 
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 3feb359..c3295fe 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -95,6 +95,15 @@ static void omap2_init_processor_devices(void)
 	}
 }
 
+void omap_trigger_wuclk_ctrl(void)
+{
+	if (cpu_is_omap34xx())
+		omap3_trigger_wuclk_ctrl();
+
+	if (cpu_is_omap44xx())
+		omap4_trigger_wuclk_ctrl();
+}
+
 /* Types of sleep_switch used in omap_set_pwrdm_state */
 #define FORCEWAKEUP_SWITCH	0
 #define LOWPOWERSTATE_SWITCH	1
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 2e09d72..9784d81 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -21,8 +21,9 @@ extern void omap_sram_idle(void);
 extern int omap3_can_sleep(void);
 extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
-extern void omap3_enable_io_chain(void);
+extern void omap3_trigger_wuclk_ctrl(void);
 extern void omap4_trigger_wuclk_ctrl(void);
+extern void omap_trigger_wuclk_ctrl(void);
 
 #if defined(CONFIG_PM_OPP)
 extern int omap3_opp_init(void);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 6c80988..6417ccb 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -95,11 +95,11 @@ static inline void omap3_per_restore_context(void)
 	omap_gpio_restore_context();
 }
 
-void omap3_enable_io_chain(void)
+void omap3_trigger_wuclk_ctrl(void)
 {
 	int timeout = 0;
 
-	if (omap_rev() >= OMAP3430_REV_ES3_1) {
+	if ((omap_rev() >= OMAP3430_REV_ES3_1) && omap3_has_io_wakeup()) {
 		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
 				     PM_WKEN);
 		/* Do a readback to assure write has been done */
@@ -119,13 +119,6 @@ void omap3_enable_io_chain(void)
 	}
 }
 
-static void omap3_disable_io_chain(void)
-{
-	if (omap_rev() >= OMAP3430_REV_ES3_1)
-		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
-				       PM_WKEN);
-}
-
 static void omap3_core_save_context(void)
 {
 	omap3_ctrl_save_padconf();
@@ -372,12 +365,6 @@ void omap_sram_idle(void)
 	/* Enable IO-PAD and IO-CHAIN wakeups */
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
 	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
-	if (omap3_has_io_wakeup() &&
-	    (per_next_state < PWRDM_POWER_ON ||
-	     core_next_state < PWRDM_POWER_ON)) {
-		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
-		omap3_enable_io_chain();
-	}
 
 	/* Block console output in case it is on one of the OMAP UARTs */
 	if (!is_suspending())
@@ -469,15 +456,6 @@ void omap_sram_idle(void)
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
-- 
1.7.0.4

