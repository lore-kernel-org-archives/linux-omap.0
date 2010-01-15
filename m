From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv3 2/6] OMAP3: PM: Added support for INACTIVE and ON states for powerdomains
Date: Fri, 15 Jan 2010 14:46:53 +0200
Message-ID: <1263559617-663-3-git-send-email-tero.kristo@nokia.com>
References: <>
 <1263559617-663-1-git-send-email-tero.kristo@nokia.com>
 <1263559617-663-2-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22089 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622Ab0AOKz3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 05:55:29 -0500
In-Reply-To: <1263559617-663-2-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com

From: Tero Kristo <tero.kristo@nokia.com>

Previously omap_sram_idle() did not know about the difference between ON and
INACTIVE states, which complicated the state handling in these cases. Now,
the following changes are done in the idle logic:

- Check for IO-chain arming is changed to reflect desired state (RET)
- UART clocks will be disabled if we attempt to enter INACTIVE (this allows
  the state change to actually happen)

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a5335f9..7cc3293 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -386,6 +386,7 @@ void omap_sram_idle(void)
 	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
 	switch (mpu_next_state) {
 	case PWRDM_POWER_ON:
+	case PWRDM_POWER_INACTIVE:
 	case PWRDM_POWER_RET:
 		/* No need to save context */
 		save_state = 0;
@@ -452,9 +453,11 @@ void omap_sram_idle(void)
 						OMAP3430_GR_MOD,
 						OMAP3_PRM_VOLTCTRL_OFFSET);
 		}
-		/* Enable IO-PAD and IO-CHAIN wakeups */
-		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
-		omap3_enable_io_chain();
+		if (core_next_state <= PWRDM_POWER_RET) {
+			/* Enable IO-PAD and IO-CHAIN wakeups */
+			prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
+			omap3_enable_io_chain();
+		}
 	}
 	omap3_intc_prepare_idle();
 
@@ -555,15 +558,13 @@ void omap_sram_idle(void)
 	}
 
 	/* Disable IO-PAD and IO-CHAIN wakeup */
-	if (core_next_state < PWRDM_POWER_ON) {
+	if (core_next_state <= PWRDM_POWER_RET) {
 		prm_clear_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
 		omap3_disable_io_chain();
 	}
 
 
 	pwrdm_post_transition();
-
-	omap2_clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
 }
 
 int omap3_can_sleep(void)
@@ -611,7 +612,6 @@ int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 	}
 
 	if (sleep_switch) {
-		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
 		pwrdm_wait_transition(pwrdm);
 		pwrdm_state_switch(pwrdm);
 	}
-- 
1.5.4.3

