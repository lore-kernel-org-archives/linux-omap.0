From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [patch-v2.6.39 01/19] usb: musb: gadget: fix list_head usage
Date: Tue,  1 Mar 2011 17:15:22 +0200
Message-ID: <1298992540-5984-2-git-send-email-balbi@ti.com>
References: <1298992540-5984-1-git-send-email-balbi@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1298992540-5984-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

commit ad1adb89a0d9410345d573b6995a1fa9f9b7c74a
(usb: musb: gadget: do not poke with gadget's list_head)
fixed a bug in musb where it was corrupting the list_head
which is supposed to be used by gadget drivers. While
doing that, I forgot to fix the usage in musb_gadget_dequeue()
method. Fix that.

Reported-by: Pavol Kurina <pavol.kurina-A6PwE0y/fKk@public.gmane.org>
Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_gadget.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index da8c93b..2a3aee4 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1274,7 +1274,8 @@ cleanup:
 static int musb_gadget_dequeue(struct usb_ep *ep, struct usb_request *request)
 {
 	struct musb_ep		*musb_ep = to_musb_ep(ep);
-	struct usb_request	*r;
+	struct musb_request	*req = to_musb_request(request);
+	struct musb_request	*r;
 	unsigned long		flags;
 	int			status = 0;
 	struct musb		*musb = musb_ep->musb;
@@ -1285,10 +1286,10 @@ static int musb_gadget_dequeue(struct usb_ep *ep, struct usb_request *request)
 	spin_lock_irqsave(&musb->lock, flags);
 
 	list_for_each_entry(r, &musb_ep->req_list, list) {
-		if (r == request)
+		if (r == req)
 			break;
 	}
-	if (r != request) {
+	if (r != req) {
 		DBG(3, "request %p not queued to %s\n", request, ep->name);
 		status = -EINVAL;
 		goto done;
-- 
1.7.4.rc2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
