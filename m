From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 9/9] usb: gadget: goku: use generic map/unmap routines
Date: Mon, 19 Dec 2011 12:30:31 +0200
Message-ID: <1324290632-23758-10-git-send-email-balbi@ti.com>
References: <1324290632-23758-1-git-send-email-balbi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1324290632-23758-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Thomas Dahlmann <dahlmann.thomas@arcor.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "open list:DESIGNWARE USB3 D..." <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:AMD GEODE CS5536..." <linux-geode@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

those routines have everything we need to map/unmap
USB requests and it's better to use them.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/goku_udc.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/goku_udc.c b/drivers/usb/gadget/goku_udc.c
index 5af70fcc..bc47735 100644
--- a/drivers/usb/gadget/goku_udc.c
+++ b/drivers/usb/gadget/goku_udc.c
@@ -310,12 +310,8 @@ done(struct goku_ep *ep, struct goku_request *req, int status)
 		status = req->req.status;
 
 	dev = ep->dev;
-	if (req->mapped) {
-		pci_unmap_single(dev->pdev, req->req.dma, req->req.length,
-			ep->is_in ? PCI_DMA_TODEVICE : PCI_DMA_FROMDEVICE);
-		req->req.dma = DMA_ADDR_INVALID;
-		req->mapped = 0;
-	}
+	if (req->mapped)
+		usb_gadget_unmap_request(&dev->gadget, &req->req, ep->is_in);
 
 #ifndef USB_TRACE
 	if (status && status != -ESHUTDOWN)
@@ -736,10 +732,11 @@ goku_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 		return -EBUSY;
 
 	/* set up dma mapping in case the caller didn't */
-	if (ep->dma && _req->dma == DMA_ADDR_INVALID) {
-		_req->dma = pci_map_single(dev->pdev, _req->buf, _req->length,
-			ep->is_in ? PCI_DMA_TODEVICE : PCI_DMA_FROMDEVICE);
-		req->mapped = 1;
+	if (ep->dma) {
+		status = usb_gadget_map_request(&dev->gadget, &req->req,
+				ep->is_in);
+		if (status)
+			return status;
 	}
 
 #ifdef USB_TRACE
-- 
1.7.8.rc3
