From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCHv2 7/7] usb: musb: gadget: use platform callback to enable vbus
Date: Sun, 17 Mar 2013 20:23:27 +0200
Message-ID: <1363544607-17634-8-git-send-email-notasas@gmail.com>
References: <1363544607-17634-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f175.google.com ([209.85.215.175]:53696 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932689Ab3CQSXy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 17 Mar 2013 14:23:54 -0400
In-Reply-To: <1363544607-17634-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, NeilBrown <neilb@suse.de>, kishon <kishon@ti.com>, Grazvydas Ignotas <notasas@gmail.com>

On some platform configurations (like OMAP3+twl4030) it's the platform
code that enables VBUS, not OTG transceiver, so call vbus platform
callback instead, it will then call the transceiver if needed.

This fixes a use case where USB cable is plugged first and gadget
driver is loaded later after that.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/usb/musb/musb_gadget.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index ae59ee6..60eef20 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1799,9 +1799,8 @@ static int musb_gadget_start(struct usb_gadget *g,
 		goto err;
 	}
 
-	if ((musb->xceiv->last_event == USB_EVENT_ID)
-				&& otg->set_vbus)
-		otg_set_vbus(otg, 1);
+	if (musb->xceiv->last_event == USB_EVENT_ID)
+		musb_platform_set_vbus(musb, 1);
 
 	hcd->self.uses_pio_for_control = 1;
 
-- 
1.7.9.5

