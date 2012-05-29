From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/6] usb: gadget: omap_udc: remove possiblity of NULL pointer de-reference
Date: Tue, 29 May 2012 15:15:59 +0300
Message-ID: <1338293761-9457-5-git-send-email-balbi@ti.com>
References: <1338293761-9457-1-git-send-email-balbi@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1338293761-9457-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

when allocating a request, it's better programming
practice to make sure we return NULL if allocation
failed.

This will ensure that, if struct usb_request isn't
the first member on our structure, we don't cheat
the gadget driver into thinking allocating worked
because pointer isn't 0.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/gadget/omap_udc.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index 814aafb..f13bcdc 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -268,10 +268,12 @@ omap_alloc_request(struct usb_ep *ep, gfp_t gfp_flags)
 	struct omap_req	*req;
 
 	req = kzalloc(sizeof(*req), gfp_flags);
-	if (req) {
-		req->req.dma = DMA_ADDR_INVALID;
-		INIT_LIST_HEAD(&req->queue);
-	}
+	if (!req)
+		return NULL;
+
+	req->req.dma = DMA_ADDR_INVALID;
+	INIT_LIST_HEAD(&req->queue);
+
 	return &req->req;
 }
 
-- 
1.7.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
