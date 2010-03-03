From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] OMAP3: PM: Enable wake-up from McBSP2, 3 and 4 modules
Date: Wed,  3 Mar 2010 15:08:05 +0200
Message-ID: <1267621689-30337-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1267621689-30337-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:32549 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912Ab0CCNIi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Mar 2010 08:08:38 -0500
In-Reply-To: <1267621689-30337-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, tony@atomide.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk, jhnikula@gmail.com, ext-eero.nurkkala@nokia.com

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

