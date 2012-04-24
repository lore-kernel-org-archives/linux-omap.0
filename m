From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFT 2/3] ARM: OMAP3: PM: call pre/post transition per powerdomain
Date: Tue, 24 Apr 2012 07:23:39 -0700
Message-ID: <1335277420-29124-3-git-send-email-khilman@ti.com>
References: <1335277420-29124-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:53058 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754679Ab2DXOWz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Apr 2012 10:22:55 -0400
Received: by pbcuo5 with SMTP id uo5so162376pbc.32
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 07:22:54 -0700 (PDT)
In-Reply-To: <1335277420-29124-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

We only need to call the pre/post transtion methods when we know the
power state is changing.  First, split up the pre/post transition
calls to be per-powerdomain, and then make them conditional on whether
the power domain is actually changing states.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 2451b90..74a7f8c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -307,16 +307,19 @@ void omap_sram_idle(void)
 			omap3_enable_io_chain();
 	}
 
-	pwrdm_pre_transition(NULL);
+	if (mpu_next_state < PWRDM_POWER_ON)
+		pwrdm_pre_transition(mpu_pwrdm);
 
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
+		pwrdm_pre_transition(per_pwrdm);
 		per_going_off = (per_next_state == PWRDM_POWER_OFF) ? 1 : 0;
 		omap2_gpio_prepare_for_idle(per_going_off);
 	}
 
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
+		pwrdm_pre_transition(core_pwrdm);
 		if (core_next_state == PWRDM_POWER_OFF) {
 			omap3_core_save_context();
 			omap3_cm_save_context();
@@ -369,15 +372,15 @@ void omap_sram_idle(void)
 			omap2_prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
 					       OMAP3430_GR_MOD,
 					       OMAP3_PRM_VOLTCTRL_OFFSET);
+		pwrdm_post_transition(core_pwrdm);
 	}
 	omap3_intc_resume_idle();
 
-	pwrdm_post_transition(NULL);
-
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
 		omap2_gpio_resume_after_idle();
+		pwrdm_post_transition(per_pwrdm);
 	}
 
 	/* Disable IO-PAD and IO-CHAIN wakeup */
@@ -390,6 +393,9 @@ void omap_sram_idle(void)
 			omap3_disable_io_chain();
 	}
 
+	if (mpu_next_state < PWRDM_POWER_ON)
+		pwrdm_post_transition(mpu_pwrdm);
+
 	clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
 }
 
-- 
1.7.9.2

