From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 02/04] OMAP3: PM: Prevent AUTO_RET and AUTO_OFF being enabled simultaneously
Date: Tue, 16 Jun 2009 17:22:32 +0530
Message-ID: <1245153154-1876-2-git-send-email-rnayak@ti.com>
References: <1245153154-1876-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58212 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756034AbZFPLwm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Jun 2009 07:52:42 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5GBqdlj019668
	for <linux-omap@vger.kernel.org>; Tue, 16 Jun 2009 06:52:45 -0500
In-Reply-To: <1245153154-1876-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: dderrick@ti.com, r-woodruff2@ti.com, Rajendra Nayak <rnayak@ti.com>

There is a design requirement in OMAP3 that Auto_RET and AUTO_OFF
should not be set together. The PRCM FSM  has been coded assuming
that SW will set either auto_ret or auto_off bit depending on
whether the core has been programmed to go into open switched
logic retention state or OFF state. They are mutually exclusive.
A similar issue will exist if SW sets  auto_ret= auto_off=1 and
auto_sleep = 1 in the PRM voltage CTRL register

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a9ef670..d4225b4 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -392,6 +392,10 @@ void omap_sram_idle(void)
 					     OMAP3_PRM_VOLTCTRL_OFFSET);
 			omap3_core_save_context();
 			omap3_prcm_save_context();
+		} else if (core_next_state == PWRDM_POWER_RET) {
+			prm_set_mod_reg_bits(OMAP3430_AUTO_RET,
+						OMAP3430_GR_MOD,
+						OMAP3_PRM_VOLTCTRL_OFFSET);
 		}
 		/* Enable IO-PAD and IO-CHAIN wakeups */
 		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
@@ -446,6 +450,10 @@ void omap_sram_idle(void)
 			prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF,
 					       OMAP3430_GR_MOD,
 					       OMAP3_PRM_VOLTCTRL_OFFSET);
+		else if (core_next_state == PWRDM_POWER_RET)
+			prm_clear_mod_reg_bits(OMAP3430_AUTO_RET,
+						OMAP3430_GR_MOD,
+						OMAP3_PRM_VOLTCTRL_OFFSET);
 		/* Enable smartreflex after WFI */
 		enable_smartreflex(SR1);
 		enable_smartreflex(SR2);
@@ -1128,10 +1136,6 @@ static void __init configure_vc(void)
 				OMAP3430_GR_MOD,
 				OMAP3_PRM_VC_I2C_CFG_OFFSET);
 
-	/* Setup value for voltctrl */
-	prm_write_mod_reg(OMAP3430_AUTO_RET,
-			  OMAP3430_GR_MOD, OMAP3_PRM_VOLTCTRL_OFFSET);
-
 	/* Write setup times */
 	prm_write_mod_reg(prm_setup.clksetup, OMAP3430_GR_MOD,
 			OMAP3_PRM_CLKSETUP_OFFSET);
-- 
1.5.4.7

