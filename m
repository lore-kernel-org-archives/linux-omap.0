From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 7/7] usb: musb: only print info message if probe() is successful
Date: Thu, 21 Jan 2010 15:33:58 +0200
Message-ID: <1264080838-9452-8-git-send-email-felipe.balbi@nokia.com>
References: <1264080838-9452-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1264080838-9452-1-git-send-email-felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

we were printing the info about musb probe too early where
it was still possible for things to go wrong. Move the
down right before the return 0 statement. While at that
also convert pr_info to dev_info.

Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/musb_core.c |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index de7b377..0f13ded 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2004,19 +2004,6 @@ bad_config:
 		musb->irq_wake = 0;
 	}
 
-	pr_info("%s: USB %s mode controller at %p using %s, IRQ %d\n",
-			musb_driver_name,
-			({char *s;
-			switch (musb->board_mode) {
-			case MUSB_HOST:		s = "Host"; break;
-			case MUSB_PERIPHERAL:	s = "Peripheral"; break;
-			default:		s = "OTG"; break;
-			}; s; }),
-			ctrl,
-			(is_dma_capable() && musb->dma_controller)
-				? "DMA" : "PIO",
-			musb->nIrq);
-
 	/* host side needs more setup */
 	if (is_host_enabled(musb)) {
 		struct usb_hcd	*hcd = musb_to_hcd(musb);
@@ -2079,6 +2066,18 @@ bad_config:
 	if (status)
 		goto fail2;
 
+	dev_info(dev, "USB %s mode controller at %p using %s, IRQ %d\n",
+			({char *s;
+			 switch (musb->board_mode) {
+			 case MUSB_HOST:		s = "Host"; break;
+			 case MUSB_PERIPHERAL:	s = "Peripheral"; break;
+			 default:		s = "OTG"; break;
+			 }; s; }),
+			ctrl,
+			(is_dma_capable() && musb->dma_controller)
+			? "DMA" : "PIO",
+			musb->nIrq);
+
 	return 0;
 
 fail2:
-- 
1.6.6.rc0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
