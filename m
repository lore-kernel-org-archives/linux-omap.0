From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [PATCH] OMAP3: PM: Remove duplicate code
Date: Tue, 23 Jun 2009 11:21:51 +0300
Message-ID: <1245745311-20319-1-git-send-email-ext-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34713 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbZFWIWc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jun 2009 04:22:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7a4a525..d45295d 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -913,24 +913,6 @@ static void __init prcm_setup_regs(void)
 	/* Clear any pending PRCM interrupts */
 	prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 
-	/* Don't attach IVA interrupts */
-	prm_write_mod_reg(0, WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
-	prm_write_mod_reg(0, CORE_MOD, OMAP3430_PM_IVAGRPSEL1);
-	prm_write_mod_reg(0, CORE_MOD, OMAP3430ES2_PM_IVAGRPSEL3);
-	prm_write_mod_reg(0, OMAP3430_PER_MOD, OMAP3430_PM_IVAGRPSEL);
-		
-	/* Clear any pending 'reset' flags */
-	prm_write_mod_reg(0xffffffff, MPU_MOD, RM_RSTST);
-	prm_write_mod_reg(0xffffffff, CORE_MOD, RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430_PER_MOD, RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430_EMU_MOD, RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430_NEON_MOD, RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430_DSS_MOD, RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430ES2_USBHOST_MOD, RM_RSTST);
-
-	/* Clear any pending PRCM interrupts */
-	prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
-
 	omap3_iva_idle();
 	omap3_d2d_idle();
 }
-- 
1.6.0.4

