From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 8/9] usb: gadget: net2280: use generic map/unmap routines
Date: Mon, 19 Dec 2011 12:30:30 +0200
Message-ID: <1324290632-23758-9-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/net2280.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/net2280.c b/drivers/usb/gadget/net2280.c
index cf1f364..59d4794 100644
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
+	if (req->mapped)
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
+		ret = usb_gadget_map_request(&dev->gadget, &req->req,
+				ep->is_in);
+		if (ret)
+			return ret;
 	}
 
 #if 0
-- 
1.7.8.rc3
