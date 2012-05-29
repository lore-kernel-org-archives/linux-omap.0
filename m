From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 5/6] usb: gadget: omap_udc: kfree(NULL) is safe
Date: Tue, 29 May 2012 15:16:00 +0300
Message-ID: <1338293761-9457-6-git-send-email-balbi@ti.com>
References: <1338293761-9457-1-git-send-email-balbi@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1338293761-9457-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

we don't need to check for _req because
kfree(NULL) is safe. Also, if someone
actually passes a NULL pointer to be freed
by usb_ep_free_request(), he deserves any
issue he faces.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/gadget/omap_udc.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index f13bcdc..50e8490 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -282,8 +282,7 @@ omap_free_request(struct usb_ep *ep, struct usb_request *_req)
 {
 	struct omap_req	*req = container_of(_req, struct omap_req, req);
 
-	if (_req)
-		kfree(req);
+	kfree(req);
 }
 
 /*-------------------------------------------------------------------------*/
-- 
1.7.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
