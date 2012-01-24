From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 7/9] usb: gadget: net2272: use generic map/umap routines
Date: Tue, 24 Jan 2012 13:45:28 +0200
Message-ID: <1327405543-27589-8-git-send-email-balbi@ti.com>
References: <1327405543-27589-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1327405543-27589-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Thomas Dahlmann <dahlmann.thomas@arcor.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "open list:DESIGNWARE USB3 D..." <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:AMD GEODE CS5536..." <linux-geode@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

those routines have everything we need to map/unmap
USB requests and it's better to use them.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/gadget/net2272.c |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/net2272.c b/drivers/usb/gadget/net2272.c
index 7322d29..01ae56f 100644
--- a/drivers/usb/gadget/net2272.c
+++ b/drivers/usb/gadget/net2272.c
@@ -385,12 +385,9 @@ net2272_done(struct net2272_ep *ep, struct net2272_request *req, int status)
 		status = req->req.status;
 
 	dev = ep->dev;
-	if (use_dma && req->mapped) {
-		dma_unmap_single(dev->dev, req->req.dma, req->req.length,
-			ep->is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-		req->req.dma = DMA_ADDR_INVALID;
-		req->mapped = 0;
-	}
+	if (use_dma && ep->dma)
+		usb_gadget_unmap_request(&dev->gadget, &req->req,
+				ep->is_in);
 
 	if (status && status != -ESHUTDOWN)
 		dev_vdbg(dev->dev, "complete %s req %p stat %d len %u/%u buf %p\n",
@@ -850,10 +847,11 @@ net2272_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 		return -ESHUTDOWN;
 
 	/* set up dma mapping in case the caller didn't */
-	if (use_dma && ep->dma && _req->dma == DMA_ADDR_INVALID) {
-		_req->dma = dma_map_single(dev->dev, _req->buf, _req->length,
-			ep->is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-		req->mapped = 1;
+	if (use_dma && ep->dma) {
+		status = usb_gadget_map_request(&dev->gadget, _req,
+				ep->is_in);
+		if (status)
+			return status;
 	}
 
 	dev_vdbg(dev->dev, "%s queue req %p, len %d buf %p dma %08llx %s\n",
-- 
1.7.8.2
