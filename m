From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC part1/2 merge v2][PATCH 05/11] OMAP3: PRCM: Consider UART4 for 3630 chip in prcm_setup_regs
Date: Mon,  8 Mar 2010 11:20:48 -0600
Message-ID: <1268068854-13429-6-git-send-email-saaguirre@ti.com>
References: <1268068854-13429-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48354 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642Ab0CHRUA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 12:20:00 -0500
In-Reply-To: <1268068854-13429-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Sergio Aguirre <saaguirre@ti.com>

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

