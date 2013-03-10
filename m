From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 3/7] usb: otg: twl4030-usb: don't switch the phy on/off needlessly
Date: Sun, 10 Mar 2013 03:07:57 +0200
Message-ID: <1362877681-8102-4-git-send-email-notasas@gmail.com>
References: <1362877681-8102-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f181.google.com ([209.85.215.181]:34694 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab3CJBIR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Mar 2013 20:08:17 -0500
In-Reply-To: <1362877681-8102-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, NeilBrown <neilb@suse.de>, Grazvydas Ignotas <notasas@gmail.com>

With runtime_pm in place there is no longer need to turn the phy
on/off in OTG layer on cable connect/disconnect, OMAP glue does
this through otg.set_suspend() callback after it's called through
omap_musb_mailbox() on VBUS/ID interrupt. Not doing this will save
power when cable is connected but no gadget driver is loaded.

This will also have side effect of automatic USB charging no longer
working without twl4030_charger driver, so be sure to enable it if
charging is needed.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/usb/otg/twl4030-usb.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 0ea576a..90a19ff 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -506,12 +506,6 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 		 * USB_LINK_VBUS state.  musb_hdrc won't care until it
 		 * starts to handle softconnect right.
 		 */
-		if (status == OMAP_MUSB_VBUS_OFF ||
-				status == OMAP_MUSB_ID_FLOAT)
-			twl4030_phy_suspend(twl, 0);
-		else
-			twl4030_phy_resume(twl);
-
 		omap_musb_mailbox(twl->linkstat);
 	}
 	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
-- 
1.7.9.5

