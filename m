From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] usb: musb: gadget: Fix out-of-sync runtime pm calls
Date: Fri, 29 Apr 2011 16:17:35 +0300
Message-ID: <1304083055-2809-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52792 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755645Ab1D2NRo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Apr 2011 09:17:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Hema HK <hemahk@ti.com>, Jarkko Nikula <jhnikula@gmail.com>

If cable is not connected to peripheral only board when initializing the
gadget driver, then runtime pm calls are out-of-sync and the musb cannot
idle with omap2430.c. This was noted on Nokia N900 where musb prevented the
CPU to be able to enter deeper retention idle state.

This was working in 2.6.38 before runtime pm conversions but there musb
smart standby/idle modes were configured statically where they are now
updated runtime depending on use and cable status.

Reason for out-of-sync is that runtime pm is activated in function
musb_gadget.c: usb_gadget_probe_driver but suspended only in OTG mode if
cable is not connected when initializing. In peripheral only mode this leads
to out-of-sync runtime pm since runtime pm remain active and is activated
another time in omap2430.c: musb_otg_notifications for VBUS Connect event
and thus cannot suspend for VBUS Disconnect event since the use count remains
active.

Fix this by moving cable status check and pm_runtime_put call in
usb_gadget_probe_driver out of is_otg_enabled block.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
IMHO this is for 2.6.39 as this fixes PM regression on OMAP2+ boards that use
musb in peripheral mode.
---
 drivers/usb/musb/musb_gadget.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 6dfbf9f..f47c201 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1887,11 +1887,9 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
 			otg_set_vbus(musb->xceiv, 1);
 
 		hcd->self.uses_pio_for_control = 1;
-
-		if (musb->xceiv->last_event == USB_EVENT_NONE)
-			pm_runtime_put(musb->controller);
-
 	}
+	if (musb->xceiv->last_event == USB_EVENT_NONE)
+		pm_runtime_put(musb->controller);
 
 	return 0;
 
-- 
1.7.0.4

