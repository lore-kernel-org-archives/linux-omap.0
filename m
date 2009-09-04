From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 3/3] USB: musb: omap: Enable MUSB clocks before xceiver resume
Date: Fri,  4 Sep 2009 18:05:16 -0500
Message-ID: <1252105516-19040-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50666 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934470AbZIDXLH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Sep 2009 19:11:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, david-b@pacbell.net, ajay.gupta@ti.com, gadiyar@ti.com, felipe.balbi@nokia.com, Vikram Pandita <vikram.pandita@ti.com>

Enable MUSB clocks before the xceiver resume is called.
As soon as xceiver resume is called, xceiver communicates an
interrupt to MUSB over ULPI bus and the interrupt handler crashes
as the clocks are not enabled on going to resume.

So enable the MUSB clocks so that its ready to handle interrupts
from the xceiver

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 drivers/usb/musb/omap2430.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index ea7a798..67dabe1 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -286,13 +286,18 @@ int musb_platform_resume(struct musb *musb)
 	if (!musb->clock)
 		return 0;
 
-	otg_set_suspend(otg_get_transceiver(), 0);
-
+	/* Keep MUSB clock enabled
+	 * this is needed when phy xvr is enabled, MUSB gets
+	 * an interrupt and system crashes.
+	 * So enable clock before calling phy resume
+	 */
 	if (musb->set_clock)
 		musb->set_clock(musb->clock, 1);
 	else
 		clk_enable(musb->clock);
 
+	otg_set_suspend(otg_get_transceiver(), 0);
+
 	l = omap_readl(OTG_SYSCONFIG);
 	l &= ~ENABLEWAKEUP;	/* disable wakeup */
 	omap_writel(l, OTG_SYSCONFIG);
-- 
1.6.3.3.334.g916e1

