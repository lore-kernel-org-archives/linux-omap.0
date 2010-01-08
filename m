From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 10/13] OMAP3: PM: Enable wake-up from McBSP2, 3 and 4 modules
Date: Fri,  8 Jan 2010 09:59:28 -0800
Message-ID: <1262973571-25796-11-git-send-email-khilman@deeprootsystems.com>
References: <1262973571-25796-1-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-2-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-3-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-4-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-5-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-6-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-7-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-8-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-9-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-10-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:49737 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786Ab0AHR7y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 12:59:54 -0500
Received: by pzk1 with SMTP id 1so3897523pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 08 Jan 2010 09:59:53 -0800 (PST)
In-Reply-To: <1262973571-25796-10-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>

From: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Wake-up from McBSP ports are needed, especially when the THRESHOLD
dma mode is in use for audio playback.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index d6cab33..96075bf 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -884,12 +884,16 @@ static void __init prcm_setup_regs(void)
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
1.6.6.rc2.1.g42108

