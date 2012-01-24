From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 8/9] usb: gadget: net2280: use generic map/unmap routines
Date: Tue, 24 Jan 2012 13:45:29 +0200
Message-ID: <1327405543-27589-9-git-send-email-balbi@ti.com>
References: <1327405543-27589-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1327405543-27589-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Thomas Dahlmann <dahlmann.thomas-KvP5wT2u2U0@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "open list:DESIGNWARE USB3 D..." <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:AMD GEODE CS5536..." <linux-geode-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

those routines have everything we need to map/unmap
USB requests and it's better to use them.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/gadget/net2280.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/net2280.c b/drivers/usb/gadget/net2280.c
index cdedd13..a5ccabc 100644
--- a/drivers/usb/gadget/net2280.c
+++ b/drivers/usb/gadget/net2280.c
@@ -806,12 +806,8 @@ done (struct net2280_ep *ep, struct net2280_request *req, int status)
 		status = req->req.status;
 
 	dev = ep->dev;
-	if (req->mapped) {
-		pci_unmap_single (dev->pdev, req->req.dma, req->req.length,
-			ep->is_in ? PCI_DMA_TODEVICE : PCI_DMA_FROMDEVICE);
-		req->req.dma = DMA_ADDR_INVALID;
-		req->mapped = 0;
-	}
+	if (ep->dma)
+		usb_gadget_unmap_request(&dev->gadget, &req->req, ep->is_in);
 
 	if (status && status != -ESHUTDOWN)
 		VDEBUG (dev, "complete %s req %p stat %d len %u/%u\n",
@@ -857,10 +853,13 @@ net2280_queue (struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 		return -EOPNOTSUPP;
 
 	/* set up dma mapping in case the caller didn't */
-	if (ep->dma && _req->dma == DMA_ADDR_INVALID) {
-		_req->dma = pci_map_single (dev->pdev, _req->buf, _req->length,
-			ep->is_in ? PCI_DMA_TODEVICE : PCI_DMA_FROMDEVICE);
-		req->mapped = 1;
+	if (ep->dma) {
+		int ret;
+
+		ret = usb_gadget_map_request(&dev->gadget, _req,
+				ep->is_in);
+		if (ret)
+			return ret;
 	}
 
 #if 0
-- 
1.7.8.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
