From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv10 07/14] OMAP3: pm: do not enable PRCM MPU interrupts manually
Date: Fri, 9 Dec 2011 16:27:30 +0200
Message-ID: <1323440857-385-8-git-send-email-t-kristo@ti.com>
References: <1323440857-385-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46866 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754138Ab1LIO2T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 09:28:19 -0500
In-Reply-To: <1323440857-385-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com

This is handled automatically by the PRCM chain interrupt mechanism now.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index f6cbb48..9e20ecb 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -668,10 +668,6 @@ static void __init prcm_setup_regs(void)
 			  OMAP3430_GRPSEL_GPT1_MASK |
 			  OMAP3430_GRPSEL_GPT12_MASK,
 			  WKUP_MOD, OMAP3430_PM_MPUGRPSEL);
-	/* For some reason IO doesn't generate wakeup event even if
-	 * it is selected to mpu wakeup goup */
-	omap2_prm_write_mod_reg(OMAP3430_IO_EN_MASK | OMAP3430_WKUP_EN_MASK,
-			  OCP_MOD, OMAP3_PRM_IRQENABLE_MPU_OFFSET);
 
 	/* Enable PM_WKEN to support DSS LPR */
 	omap2_prm_write_mod_reg(OMAP3430_PM_WKEN_DSS_EN_DSS_MASK,
-- 
1.7.4.1

