From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents
Date: Fri, 24 Jun 2011 21:53:45 +0530
Message-ID: <1308932625-17632-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34868 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799Ab1FXQZ3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 12:25:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sanjeev Premi <premi@ti.com>, Paul Walmsley <paul@pwsan.com>

The current selection of the GPTIMER on was result of
a hardware issue in early versions of the Beagleboards
(Ax and B1 thru B4). [1] [2]

Its been long since the hardware issue has been fixed.
This patch uses GPTIMER 1 for all newer board revisions
incl. Beagleboard XM.

 [1] http://thread.gmane.org/gmane.comp.hardware.beagleboard.general/91
 [2] Errata #7 at http://elinux.org/BeagleBoard#Errata

Signed-off-by: Sanjeev Premi <premi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---

  * The patch has been boot tested with Beagleboard-XM.
    Verified that GPTIMER1 is indeed being used.

  * Browsing through the code, it appears that similar
    change could be applied for these boards:
     - devkit8000
     - omap3stalker
     - omap3touchbook
    However, I don't have access to any of these;
    or information on their revisions.
    I can update this patch based on confirmations.

 arch/arm/mach-omap2/board-omap3beagle.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 4b113b2..edc1596 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -509,7 +509,10 @@ static void __init omap3_beagle_init_irq(void)
 {
 	omap_init_irq();
 #ifdef CONFIG_OMAP_32K_TIMER
-	omap2_gp_clockevent_set_gptimer(12);
+	if (omap3_beagle_version == OMAP3BEAGLE_BOARD_AXBX)
+		omap2_gp_clockevent_set_gptimer(12);
+	else
+		omap2_gp_clockevent_set_gptimer(1);
 #endif
 }
 
-- 
1.7.2.2

