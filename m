From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 15/16] OMAP3: pm: do not enable PRCM MPU interrupts manually
Date: Fri, 16 Sep 2011 19:05:49 +0300
Message-ID: <1316189150-21448-16-git-send-email-t-kristo@ti.com>
References: <1316189150-21448-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57292 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755332Ab1IPQGi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Sep 2011 12:06:38 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1316189150-21448-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm@lists.arm.linux.org.uk

This is handled automatically by the PRCM chain interrupt mechanism now.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 4571993..5765949 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -642,10 +642,6 @@ static void __init prcm_setup_regs(void)
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


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

