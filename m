From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] OMAP3: PM: Enable wake-up from McBSP2, 3 and 4 modules
Date: Thu, 26 Nov 2009 15:18:50 +0200
Message-ID: <1259241530-26109-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:51634 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760435AbZKZNS5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Nov 2009 08:18:57 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com

Wake-up from McBSP ports are needed, especially when the THRESHOLD
dma mode is in use for audio playback.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 81ed252..6b17647 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -878,12 +878,16 @@ static void __init prcm_setup_regs(void)
 	/* Enable wakeups in PER */
 	prm_write_mod_reg(OMAP3430_EN_GPIO2 | OMAP3430_EN_GPIO3 |
 			  OMAP3430_EN_GPIO4 | OMAP3430_EN_GPIO5 |
-			  OMAP3430_EN_GPIO6 | OMAP3430_EN_UART3,
+			  OMAP3430_EN_GPIO6 | OMAP3430_EN_UART3 |
+			  OMAP3430_EN_MCBSP2 | OMAP3430_EN_MCBSP3 |
+			  OMAP3430_EN_MCBSP4,
 			  OMAP3430_PER_MOD, PM_WKEN);
 	/* and allow them to wake up MPU */
 	prm_write_mod_reg(OMAP3430_GRPSEL_GPIO2 | OMAP3430_EN_GPIO3 |
 			  OMAP3430_GRPSEL_GPIO4 | OMAP3430_EN_GPIO5 |
-			  OMAP3430_GRPSEL_GPIO6 | OMAP3430_EN_UART3,
+			  OMAP3430_GRPSEL_GPIO6 | OMAP3430_EN_UART3 |
+			  OMAP3430_EN_MCBSP2 | OMAP3430_EN_MCBSP3 |
+			  OMAP3430_EN_MCBSP4,
 			  OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
 
 	/* Don't attach IVA interrupts */
-- 
1.6.5.3

