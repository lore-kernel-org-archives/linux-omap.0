From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 11/11] OMAP3: pm: do not enable PRCM MPU interrupts manually
Date: Tue, 5 Jul 2011 13:27:57 +0300
Message-ID: <1309861677-2769-12-git-send-email-t-kristo@ti.com>
References: <1309861677-2769-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57145 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755351Ab1GEK2S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jul 2011 06:28:18 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p65ASH46018761
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 5 Jul 2011 05:28:17 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p65ASHWb007986
	for <linux-omap@vger.kernel.org>; Tue, 5 Jul 2011 05:28:17 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p65ASGNp028556
	for <linux-omap@vger.kernel.org>; Tue, 5 Jul 2011 05:28:17 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1309861677-2769-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is handled automatically by the PRCM chain interrupt mechanism now.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 34feff4..8b05f14 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -618,10 +618,6 @@ static void __init prcm_setup_regs(void)
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
 

