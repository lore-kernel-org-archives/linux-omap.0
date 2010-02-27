From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC v3][PATCH 5/6] OMAP3: PRCM: Consider UART4 for 3630 chip in prcm_setup_regs
Date: Sat, 27 Feb 2010 14:46:10 -0600
Message-ID: <1267303571-3674-6-git-send-email-saaguirre@ti.com>
References: <1267303571-3674-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47799 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030845Ab0B0Up7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 27 Feb 2010 15:45:59 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1RKjxlt018749
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 27 Feb 2010 14:45:59 -0600
In-Reply-To: <1267303571-3674-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sergio Aguirre <saaguirre@ti.com>

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fee2efb..81082f2 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -734,6 +734,9 @@ static void __init omap3_d2d_idle(void)
 
 static void __init prcm_setup_regs(void)
 {
+	u32 omap3630_auto_uart4 = cpu_is_omap3630() ? OMAP3630_AUTO_UART4 : 0;
+	u32 omap3630_en_uart4 = cpu_is_omap3630() ? OMAP3630_EN_UART4 : 0;
+
 	/* XXX Reset all wkdeps. This should be done when initializing
 	 * powerdomains */
 	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, PM_WKDEP);
@@ -820,6 +823,7 @@ static void __init prcm_setup_regs(void)
 		CM_AUTOIDLE);
 
 	cm_write_mod_reg(
+		omap3630_auto_uart4 |
 		OMAP3430_AUTO_GPIO6 |
 		OMAP3430_AUTO_GPIO5 |
 		OMAP3430_AUTO_GPIO4 |
@@ -899,14 +903,14 @@ static void __init prcm_setup_regs(void)
 			  OMAP3430_EN_GPIO4 | OMAP3430_EN_GPIO5 |
 			  OMAP3430_EN_GPIO6 | OMAP3430_EN_UART3 |
 			  OMAP3430_EN_MCBSP2 | OMAP3430_EN_MCBSP3 |
-			  OMAP3430_EN_MCBSP4,
+			  OMAP3430_EN_MCBSP4 | omap3630_en_uart4,
 			  OMAP3430_PER_MOD, PM_WKEN);
 	/* and allow them to wake up MPU */
 	prm_write_mod_reg(OMAP3430_GRPSEL_GPIO2 | OMAP3430_EN_GPIO3 |
 			  OMAP3430_GRPSEL_GPIO4 | OMAP3430_EN_GPIO5 |
 			  OMAP3430_GRPSEL_GPIO6 | OMAP3430_EN_UART3 |
 			  OMAP3430_EN_MCBSP2 | OMAP3430_EN_MCBSP3 |
-			  OMAP3430_EN_MCBSP4,
+			  OMAP3430_EN_MCBSP4 | omap3630_en_uart4,
 			  OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
 
 	/* Don't attach IVA interrupts */
-- 
1.6.3.3

