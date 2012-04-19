From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH] arm: omap3: Only access IVA if one exists
Date: Thu, 19 Apr 2012 11:17:45 -0700
Message-ID: <1334859465-14352-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:33228 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556Ab2DSSRt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 14:17:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

prcm_setup_regs() blindly accesses IVA bits
in the PRM and calls omap3_iva_idle() which
does more IVA related register accesses.
Only do this if the IVA hardware actually
exists.

Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/pm34xx.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 703bd10..ec92676 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -583,10 +583,13 @@ static void __init prcm_setup_regs(void)
 			  OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
 
 	/* Don't attach IVA interrupts */
-	omap2_prm_write_mod_reg(0, WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
-	omap2_prm_write_mod_reg(0, CORE_MOD, OMAP3430_PM_IVAGRPSEL1);
-	omap2_prm_write_mod_reg(0, CORE_MOD, OMAP3430ES2_PM_IVAGRPSEL3);
-	omap2_prm_write_mod_reg(0, OMAP3430_PER_MOD, OMAP3430_PM_IVAGRPSEL);
+	if (omap3_has_iva()) {
+		omap2_prm_write_mod_reg(0, WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
+		omap2_prm_write_mod_reg(0, CORE_MOD, OMAP3430_PM_IVAGRPSEL1);
+		omap2_prm_write_mod_reg(0, CORE_MOD, OMAP3430ES2_PM_IVAGRPSEL3);
+		omap2_prm_write_mod_reg(0, OMAP3430_PER_MOD,
+					OMAP3430_PM_IVAGRPSEL);
+	}
 
 	/* Clear any pending 'reset' flags */
 	omap2_prm_write_mod_reg(0xffffffff, MPU_MOD, OMAP2_RM_RSTST);
@@ -600,7 +603,9 @@ static void __init prcm_setup_regs(void)
 	/* Clear any pending PRCM interrupts */
 	omap2_prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 
-	omap3_iva_idle();
+	if (omap3_has_iva())
+		omap3_iva_idle();
+
 	omap3_d2d_idle();
 }
 
-- 
1.7.9.4

