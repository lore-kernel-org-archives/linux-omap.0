From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 05/13] OMAP3: PM: Remove duplicate code blocks
Date: Fri,  8 Jan 2010 09:59:23 -0800
Message-ID: <1262973571-25796-6-git-send-email-khilman@deeprootsystems.com>
References: <1262973571-25796-1-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-2-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-3-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-4-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-5-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:63991 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671Ab0AHR7o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 12:59:44 -0500
Received: by mail-pz0-f171.google.com with SMTP id 1so3897390pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 08 Jan 2010 09:59:43 -0800 (PST)
In-Reply-To: <1262973571-25796-5-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

From: Sanjeev Premi <premi@ti.com>

This patch removes code blocks that are repeated
in function prcm_setup_regs().

Signed-off-by: Sanjeev Premi <premi@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index af83555..d6cab33 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -910,24 +910,6 @@ static void __init prcm_setup_regs(void)
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
1.6.6.rc2.1.g42108

