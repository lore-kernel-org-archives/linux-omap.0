From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCHv3 2/3] usb: musb: omap2430: turn off vbus on cable disconnect
Date: Sun, 24 Mar 2013 17:36:54 +0200
Message-ID: <1364139415-16695-3-git-send-email-notasas@gmail.com>
References: <1364139415-16695-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:63289 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932Ab3CXPhH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 24 Mar 2013 11:37:07 -0400
In-Reply-To: <1364139415-16695-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, kishon <kishon@ti.com>, Grazvydas Ignotas <notasas@gmail.com>

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
index 798e029..3551f1a 100644
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

