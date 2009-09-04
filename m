From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 2/3] USB: musb: omap: Fix wrong xceivr passing to twl4030
Date: Fri,  4 Sep 2009 18:04:59 -0500
Message-ID: <1252105499-19003-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50652 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934455AbZIDXKx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Sep 2009 19:10:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, david-b@pacbell.net, ajay.gupta@ti.com, gadiyar@ti.com, felipe.balbi@nokia.com, Vikram Pandita <vikram.pandita@ti.com>

Wrong pointer was getting passed to twl4030 transceiver.

Call path is:
otg_set_suspend -> twl4030_set_suspend

drivers/usb/otg/twl4030-usb.c: twl4030_set_suspend() uses:
	struct twl4030_usb *twl = xceiv_to_twl(x);

and xceiv_to_twl is container_of()

So the same pointer needs to be passed to otg_set_suspend() as has
been used for otg_set_transceiver.

A crash is seen without this patch, as twl pointer access is worng

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 drivers/usb/musb/omap2430.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index b957575..ea7a798 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -269,7 +269,7 @@ int musb_platform_suspend(struct musb *musb)
 	l |= ENABLEWAKEUP;	/* enable wakeup */
 	omap_writel(l, OTG_SYSCONFIG);
 
-	otg_set_suspend(musb->xceiv, 1);
+	otg_set_suspend(otg_get_transceiver(), 1);
 
 	if (musb->set_clock)
 		musb->set_clock(musb->clock, 0);
@@ -286,7 +286,7 @@ int musb_platform_resume(struct musb *musb)
 	if (!musb->clock)
 		return 0;
 
-	otg_set_suspend(musb->xceiv, 0);
+	otg_set_suspend(otg_get_transceiver(), 0);
 
 	if (musb->set_clock)
 		musb->set_clock(musb->clock, 1);
-- 
1.6.3.3.334.g916e1

