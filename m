From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 6/7] usb: musb: omap2430: turn off vbus on cable disconnect
Date: Sun, 10 Mar 2013 03:08:00 +0200
Message-ID: <1362877681-8102-7-git-send-email-notasas@gmail.com>
References: <1362877681-8102-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42]:37294 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713Ab3CJBIW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Mar 2013 20:08:22 -0500
In-Reply-To: <1362877681-8102-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, NeilBrown <neilb@suse.de>, Grazvydas Ignotas <notasas@gmail.com>

On USB_EVENT_ID event the musb glue enables VBUS by calling
omap2430_musb_set_vbus(musb, 1) that sets the session bit, but on
USB_EVENT_NONE reverse action is never made, and that breaks PM.

Disable VBUS unconditionally on USB_EVENT_NONE to be sure musb
session is ended on cable unplug so that PM works.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/usb/musb/omap2430.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 2a39c11..d430677 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -296,6 +296,7 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 			pm_runtime_put_autosuspend(dev);
 		}
 
+		omap2430_musb_set_vbus(musb, 0);
 		if (data->interface_type == MUSB_INTERFACE_UTMI) {
 			if (musb->xceiv->otg->set_vbus)
 				otg_set_vbus(musb->xceiv->otg, 0);
-- 
1.7.9.5

