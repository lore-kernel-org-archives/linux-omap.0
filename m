From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] OMAP3: PM: Remove duplicate code blocks
Date: Mon,  2 Nov 2009 20:23:38 +0530
Message-ID: <1257173618-15120-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37755 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754044AbZKBOxi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Nov 2009 09:53:38 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA2EreSi017881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 2 Nov 2009 08:53:42 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch removes code blocks that are repeated
in function prcm_setup_regs().

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fd103a1..11cfe59 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -957,24 +957,6 @@ static void __init prcm_setup_regs(void)
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
1.6.2.2

