From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 6/9] usb: gadget: r8a66597: use generic map/unmap routines
Date: Mon, 19 Dec 2011 12:30:28 +0200
Message-ID: <1324290632-23758-7-git-send-email-balbi@ti.com>
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
 drivers/usb/gadget/r8a66597-udc.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/r8a66597-udc.c b/drivers/usb/gadget/r8a66597-udc.c
index f5b8d21..72a9a67 100644
--- a/drivers/usb/gadget/r8a66597-udc.c
+++ b/drivers/usb/gadget/r8a66597-udc.c
@@ -663,11 +663,7 @@ static int sudmac_alloc_channel(struct r8a66597 *r8a66597,
 	ep->fifoctr = D0FIFOCTR;
 
 	/* dma mapping */
-	req->req.dma = dma_map_single(r8a66597_to_dev(ep->r8a66597),
-				req->req.buf, req->req.length,
-				dma->dir ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
-
-	return 0;
+	return usb_gadget_map_request(&r8a66597->gadget, &req->req, dma->dir);
 }
 
 static void sudmac_free_channel(struct r8a66597 *r8a66597,
@@ -677,9 +673,7 @@ static void sudmac_free_channel(struct r8a66597 *r8a66597,
 	if (!r8a66597_is_sudmac(r8a66597))
 		return;
 
-	dma_unmap_single(r8a66597_to_dev(ep->r8a66597),
-			 req->req.dma, req->req.length,
-			 ep->dma->dir ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	usb_gadget_map_request(&r8a66597->gadget, &req->req, ep->dma->dir);
 
 	r8a66597_bclr(r8a66597, DREQE, ep->fifosel);
 	r8a66597_change_curpipe(r8a66597, 0, 0, ep->fifosel);
-- 
1.7.8.rc3
