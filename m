From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 6/6] usb: gadget: omap_udc: use generic map/unmap routines
Date: Tue, 29 May 2012 15:16:01 +0300
Message-ID: <1338293761-9457-7-git-send-email-balbi@ti.com>
References: <1338293761-9457-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:58562 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753868Ab2E2MSJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 May 2012 08:18:09 -0400
Received: by lagv3 with SMTP id v3so2739176lag.3
        for <linux-omap@vger.kernel.org>; Tue, 29 May 2012 05:18:06 -0700 (PDT)
In-Reply-To: <1338293761-9457-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

This patch makes use of the generic map/unmap
routines on the omap_udc driver. Removes
some useless and duplicated code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/omap_udc.c |   46 +++++++----------------------------------
 1 file changed, 7 insertions(+), 39 deletions(-)

diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index 50e8490..b6cc8b1 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -59,8 +59,6 @@
 #define	DRIVER_DESC	"OMAP UDC driver"
 #define	DRIVER_VERSION	"4 October 2004"
 
-#define	DMA_ADDR_INVALID	(~(dma_addr_t)0)
-
 /*
  * The OMAP UDC needs _very_ early endpoint setup:  before enabling the
  * D+ pullup to allow enumeration.  That's too early for the gadget
@@ -271,7 +269,6 @@ omap_alloc_request(struct usb_ep *ep, gfp_t gfp_flags)
 	if (!req)
 		return NULL;
 
-	req->req.dma = DMA_ADDR_INVALID;
 	INIT_LIST_HEAD(&req->queue);
 
 	return &req->req;
@@ -290,6 +287,7 @@ omap_free_request(struct usb_ep *ep, struct usb_request *_req)
 static void
 done(struct omap_ep *ep, struct omap_req *req, int status)
 {
+	struct omap_udc		*udc = ep->udc;
 	unsigned		stopped = ep->stopped;
 
 	list_del_init(&req->queue);
@@ -299,22 +297,9 @@ done(struct omap_ep *ep, struct omap_req *req, int status)
 	else
 		status = req->req.status;
 
-	if (use_dma && ep->has_dma) {
-		if (req->mapped) {
-			dma_unmap_single(ep->udc->gadget.dev.parent,
-				req->req.dma, req->req.length,
-				(ep->bEndpointAddress & USB_DIR_IN)
-					? DMA_TO_DEVICE
-					: DMA_FROM_DEVICE);
-			req->req.dma = DMA_ADDR_INVALID;
-			req->mapped = 0;
-		} else
-			dma_sync_single_for_cpu(ep->udc->gadget.dev.parent,
-				req->req.dma, req->req.length,
-				(ep->bEndpointAddress & USB_DIR_IN)
-					? DMA_TO_DEVICE
-					: DMA_FROM_DEVICE);
-	}
+	if (use_dma && ep->has_dma)
+		usb_gadget_unmap_request(&udc->gadget, &req->req,
+				(ep->bEndpointAddress & USB_DIR_IN));
 
 #ifndef	USB_TRACE
 	if (status && status != -ESHUTDOWN)
@@ -915,26 +900,9 @@ omap_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 	if (!udc->driver || udc->gadget.speed == USB_SPEED_UNKNOWN)
 		return -ESHUTDOWN;
 
-	if (use_dma && ep->has_dma) {
-		if (req->req.dma == DMA_ADDR_INVALID) {
-			req->req.dma = dma_map_single(
-				ep->udc->gadget.dev.parent,
-				req->req.buf,
-				req->req.length,
-				(ep->bEndpointAddress & USB_DIR_IN)
-					? DMA_TO_DEVICE
-					: DMA_FROM_DEVICE);
-			req->mapped = 1;
-		} else {
-			dma_sync_single_for_device(
-				ep->udc->gadget.dev.parent,
-				req->req.dma, req->req.length,
-				(ep->bEndpointAddress & USB_DIR_IN)
-					? DMA_TO_DEVICE
-					: DMA_FROM_DEVICE);
-			req->mapped = 0;
-		}
-	}
+	if (use_dma && ep->has_dma)
+		usb_gadget_map_request(&udc->gadget, &req->req,
+				(ep->bEndpointAddress & USB_DIR_IN));
 
 	VDBG("%s queue req %p, len %d buf %p\n",
 		ep->ep.name, _req, _req->length, _req->buf);
-- 
1.7.10.2

