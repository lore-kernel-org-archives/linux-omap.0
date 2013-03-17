From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCHv2 6/7] usb: musb: omap2430: turn off vbus on cable disconnect
Date: Sun, 17 Mar 2013 20:23:26 +0200
Message-ID: <1363544607-17634-7-git-send-email-notasas@gmail.com>
References: <1363544607-17634-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:43408 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932756Ab3CQSXw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 17 Mar 2013 14:23:52 -0400
In-Reply-To: <1363544607-17634-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, NeilBrown <neilb@suse.de>, kishon <kishon@ti.com>, Grazvydas Ignotas <notasas@gmail.com>

On USB_EVENT_ID event the musb glue enables VBUS by calling
omap2430_musb_set_vbus(musb, 1) that sets the session bit, but on
USB_EVENT_NONE reverse action is never made, and that breaks PM.

Disable VBUS on USB_EVENT_NONE to be sure musb session is ended
on cable unplug so that PM works.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/usb/musb/omap2430.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index ec460ea..780a750 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -291,6 +291,7 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 
 		musb->xceiv->last_event = USB_EVENT_NONE;
 		if (musb->gadget_driver) {
+			omap2430_musb_set_vbus(musb, 0);
 			pm_runtime_mark_last_busy(dev);
 			pm_runtime_put_autosuspend(dev);
 		}
-- 
1.7.9.5

