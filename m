From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [patch v2.6.39 3/3] usb: musb: gadget: do not poke with gadget's list_head
Date: Thu, 17 Feb 2011 13:30:21 +0200
Message-ID: <1297942221-22995-4-git-send-email-balbi@ti.com>
References: <1297942221-22995-1-git-send-email-balbi@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297942221-22995-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Hema Kalliguddi <hemahk-l0cyMroinI0@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

struct usb_request's list_head is supposed to be
used only by gadget drivers, but musb is abusing
that. Give struct musb_request its own list_head
and prevent musb from poking into other driver's
business.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_core.h       |    4 +-
 drivers/usb/musb/musb_gadget.c     |   37 +++++++++++++++++++----------------
 drivers/usb/musb/musb_gadget.h     |    7 ++++-
 drivers/usb/musb/musb_gadget_ep0.c |   24 +++++++++++++---------
 4 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index d74a811..2c8dde6 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -328,7 +328,7 @@ struct musb_hw_ep {
 #endif
 };
 
-static inline struct usb_request *next_in_request(struct musb_hw_ep *hw_ep)
+static inline struct musb_request *next_in_request(struct musb_hw_ep *hw_ep)
 {
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
 	return next_request(&hw_ep->ep_in);
@@ -337,7 +337,7 @@ static inline struct usb_request *next_in_request(struct musb_hw_ep *hw_ep)
 #endif
 }
 
-static inline struct usb_request *next_out_request(struct musb_hw_ep *hw_ep)
+static inline struct musb_request *next_out_request(struct musb_hw_ep *hw_ep)
 {
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
 	return next_request(&hw_ep->ep_out);
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 86decba..0f59bf9 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -189,7 +189,7 @@ __acquires(ep->musb->lock)
 
 	req = to_musb_request(request);
 
-	list_del(&request->list);
+	list_del(&req->list);
 	if (req->request.status == -EINPROGRESS)
 		req->request.status = status;
 	musb = req->musb;
@@ -251,9 +251,8 @@ static void nuke(struct musb_ep *ep, const int status)
 		ep->dma = NULL;
 	}
 
-	while (!list_empty(&(ep->req_list))) {
-		req = container_of(ep->req_list.next, struct musb_request,
-				request.list);
+	while (!list_empty(&ep->req_list)) {
+		req = list_first_entry(&ep->req_list, struct musb_request, list);
 		musb_g_giveback(ep, &req->request, status);
 	}
 }
@@ -485,6 +484,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 void musb_g_tx(struct musb *musb, u8 epnum)
 {
 	u16			csr;
+	struct musb_request	*req;
 	struct usb_request	*request;
 	u8 __iomem		*mbase = musb->mregs;
 	struct musb_ep		*musb_ep = &musb->endpoints[epnum].ep_in;
@@ -492,7 +492,8 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 	struct dma_channel	*dma;
 
 	musb_ep_select(mbase, epnum);
-	request = next_request(musb_ep);
+	req = next_request(musb_ep);
+	request = &req->request;
 
 	csr = musb_readw(epio, MUSB_TXCSR);
 	DBG(4, "<== %s, txcsr %04x\n", musb_ep->end_point.name, csr);
@@ -571,15 +572,15 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 
 		if (request->actual == request->length) {
 			musb_g_giveback(musb_ep, request, 0);
-			request = musb_ep->desc ? next_request(musb_ep) : NULL;
-			if (!request) {
+			req = musb_ep->desc ? next_request(musb_ep) : NULL;
+			if (!req) {
 				DBG(4, "%s idle now\n",
 					musb_ep->end_point.name);
 				return;
 			}
 		}
 
-		txstate(musb, to_musb_request(request));
+		txstate(musb, req);
 	}
 }
 
@@ -821,6 +822,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 void musb_g_rx(struct musb *musb, u8 epnum)
 {
 	u16			csr;
+	struct musb_request	*req;
 	struct usb_request	*request;
 	void __iomem		*mbase = musb->mregs;
 	struct musb_ep		*musb_ep;
@@ -835,10 +837,12 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 
 	musb_ep_select(mbase, epnum);
 
-	request = next_request(musb_ep);
-	if (!request)
+	req = next_request(musb_ep);
+	if (!req)
 		return;
 
+	request = &req->request;
+
 	csr = musb_readw(epio, MUSB_RXCSR);
 	dma = is_dma_capable() ? musb_ep->dma : NULL;
 
@@ -914,15 +918,15 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 #endif
 		musb_g_giveback(musb_ep, request, 0);
 
-		request = next_request(musb_ep);
-		if (!request)
+		req = next_request(musb_ep);
+		if (!req)
 			return;
 	}
 #if defined(CONFIG_USB_INVENTRA_DMA) || defined(CONFIG_USB_TUSB_OMAP_DMA)
 exit:
 #endif
 	/* Analyze request */
-	rxstate(musb, to_musb_request(request));
+	rxstate(musb, req);
 }
 
 /* ------------------------------------------------------------ */
@@ -1171,7 +1175,6 @@ struct usb_request *musb_alloc_request(struct usb_ep *ep, gfp_t gfp_flags)
 		return NULL;
 	}
 
-	INIT_LIST_HEAD(&request->request.list);
 	request->request.dma = DMA_ADDR_INVALID;
 	request->epnum = musb_ep->current_epnum;
 	request->ep = musb_ep;
@@ -1257,10 +1260,10 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 	}
 
 	/* add request to the list */
-	list_add_tail(&(request->request.list), &(musb_ep->req_list));
+	list_add_tail(&request->list, &musb_ep->req_list);
 
 	/* it this is the head of the queue, start i/o ... */
-	if (!musb_ep->busy && &request->request.list == musb_ep->req_list.next)
+	if (!musb_ep->busy && &request->list == musb_ep->req_list.next)
 		musb_ep_restart(musb, request);
 
 cleanup:
@@ -1349,7 +1352,7 @@ static int musb_gadget_set_halt(struct usb_ep *ep, int value)
 
 	musb_ep_select(mbase, epnum);
 
-	request = to_musb_request(next_request(musb_ep));
+	request = next_request(musb_ep);
 	if (value) {
 		if (request) {
 			DBG(3, "request in progress, cannot halt %s\n",
diff --git a/drivers/usb/musb/musb_gadget.h b/drivers/usb/musb/musb_gadget.h
index a55354f..66b7c5e 100644
--- a/drivers/usb/musb/musb_gadget.h
+++ b/drivers/usb/musb/musb_gadget.h
@@ -35,6 +35,8 @@
 #ifndef __MUSB_GADGET_H
 #define __MUSB_GADGET_H
 
+#include <linux/list.h>
+
 enum buffer_map_state {
 	UN_MAPPED = 0,
 	PRE_MAPPED,
@@ -43,6 +45,7 @@ enum buffer_map_state {
 
 struct musb_request {
 	struct usb_request	request;
+	struct list_head	list;
 	struct musb_ep		*ep;
 	struct musb		*musb;
 	u8 tx;			/* endpoint direction */
@@ -94,13 +97,13 @@ static inline struct musb_ep *to_musb_ep(struct usb_ep *ep)
 	return ep ? container_of(ep, struct musb_ep, end_point) : NULL;
 }
 
-static inline struct usb_request *next_request(struct musb_ep *ep)
+static inline struct musb_request *next_request(struct musb_ep *ep)
 {
 	struct list_head	*queue = &ep->req_list;
 
 	if (list_empty(queue))
 		return NULL;
-	return container_of(queue->next, struct usb_request, list);
+	return container_of(queue->next, struct musb_request, list);
 }
 
 extern void musb_g_tx(struct musb *musb, u8 epnum);
diff --git a/drivers/usb/musb/musb_gadget_ep0.c b/drivers/usb/musb/musb_gadget_ep0.c
index 6dd03f4..75a542e 100644
--- a/drivers/usb/musb/musb_gadget_ep0.c
+++ b/drivers/usb/musb/musb_gadget_ep0.c
@@ -304,8 +304,7 @@ __acquires(musb->lock)
 				}
 
 				/* Maybe start the first request in the queue */
-				request = to_musb_request(
-						next_request(musb_ep));
+				request = next_request(musb_ep);
 				if (!musb_ep->busy && request) {
 					DBG(3, "restarting the request\n");
 					musb_ep_restart(musb, request);
@@ -491,10 +490,12 @@ stall:
 static void ep0_rxstate(struct musb *musb)
 {
 	void __iomem		*regs = musb->control_ep->regs;
+	struct musb_request	*request;
 	struct usb_request	*req;
 	u16			count, csr;
 
-	req = next_ep0_request(musb);
+	request = next_ep0_request(musb);
+	req = &request->request;
 
 	/* read packet and ack; or stall because of gadget driver bug:
 	 * should have provided the rx buffer before setup() returned.
@@ -544,17 +545,20 @@ static void ep0_rxstate(struct musb *musb)
 static void ep0_txstate(struct musb *musb)
 {
 	void __iomem		*regs = musb->control_ep->regs;
-	struct usb_request	*request = next_ep0_request(musb);
+	struct musb_request	*req = next_ep0_request(musb);
+	struct usb_request	*request;
 	u16			csr = MUSB_CSR0_TXPKTRDY;
 	u8			*fifo_src;
 	u8			fifo_count;
 
-	if (!request) {
+	if (!req) {
 		/* WARN_ON(1); */
 		DBG(2, "odd; csr0 %04x\n", musb_readw(regs, MUSB_CSR0));
 		return;
 	}
 
+	request = &req->request;
+
 	/* load the data */
 	fifo_src = (u8 *) request->buf + request->actual;
 	fifo_count = min((unsigned) MUSB_EP0_FIFOSIZE,
@@ -598,7 +602,7 @@ static void ep0_txstate(struct musb *musb)
 static void
 musb_read_setup(struct musb *musb, struct usb_ctrlrequest *req)
 {
-	struct usb_request	*r;
+	struct musb_request	*r;
 	void __iomem		*regs = musb->control_ep->regs;
 
 	musb_read_fifo(&musb->endpoints[0], sizeof *req, (u8 *)req);
@@ -616,7 +620,7 @@ musb_read_setup(struct musb *musb, struct usb_ctrlrequest *req)
 	/* clean up any leftover transfers */
 	r = next_ep0_request(musb);
 	if (r)
-		musb_g_ep0_giveback(musb, r);
+		musb_g_ep0_giveback(musb, &r->request);
 
 	/* For zero-data requests we want to delay the STATUS stage to
 	 * avoid SETUPEND errors.  If we read data (OUT), delay accepting
@@ -758,11 +762,11 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 	case MUSB_EP0_STAGE_STATUSOUT:
 		/* end of sequence #1: write to host (TX state) */
 		{
-			struct usb_request	*req;
+			struct musb_request	*req;
 
 			req = next_ep0_request(musb);
 			if (req)
-				musb_g_ep0_giveback(musb, req);
+				musb_g_ep0_giveback(musb, &req->request);
 		}
 
 		/*
@@ -961,7 +965,7 @@ musb_g_ep0_queue(struct usb_ep *e, struct usb_request *r, gfp_t gfp_flags)
 	}
 
 	/* add request to the list */
-	list_add_tail(&(req->request.list), &(ep->req_list));
+	list_add_tail(&req->list, &ep->req_list);
 
 	DBG(3, "queue to %s (%s), length=%d\n",
 			ep->name, ep->is_in ? "IN/TX" : "OUT/RX",
-- 
1.7.4.rc2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
