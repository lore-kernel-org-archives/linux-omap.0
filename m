From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 39/59] omap: namespace cleanup to drivers/usb/gadget/omap_udc.c
Date: Wed, 12 Nov 2008 00:56:58 +0200
Message-ID: <1226444238-14614-40-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
 <1226444238-14614-5-git-send-email-me@felipebalbi.com>
 <1226444238-14614-6-git-send-email-me@felipebalbi.com>
 <1226444238-14614-7-git-send-email-me@felipebalbi.com>
 <1226444238-14614-8-git-send-email-me@felipebalbi.com>
 <1226444238-14614-9-git-send-email-me@felipebalbi.com>
 <1226444238-14614-10-git-send-email-me@felipebalbi.com>
 <1226444238-14614-11-git-send-email-me@felipebalbi.com>
 <1226444238-14614-12-git-send-email-me@felipebalbi.com>
 <1226444238-14614-13-git-send-email-me@felipebalbi.com>
 <1226444238-14614-14-git-send-email-me@felipebalbi.com>
 <1226444238-14614-15-git-send-email-me@felipebalbi.com>
 <1226444238-14614-16-git-send-email-me@felipebalbi.com>
 <1226444238-14614-17-git-send-email-me@felipebalbi.com>
 <1226444238-14614-18-git-send-email-me@felipebalbi.com>
 <1226444238-14614-19-git-send-email-me@felipebalbi.com>
 <1226444238-14614-20-git-send-email-me@felipebalbi.com>
 <1226444238-14614-21-git-send-email-me@felipebalbi.com>
 <1226444238-14614-22-git-send-email-me@felipebalbi.com>
 <1226444238-14614-23-git-send-email-me@felipebalbi.com>
 <1226444238-14614-24-git-send-email-me@felipebalbi.com>
 <1226444238-14614-25-git-send-email-me@felipebalbi.com>
 <1226444238-14614-26-git-send-email-me@felipebalbi.com>
 <1226444238-14614-27-git-send-email-me@felipebalbi.com>
 <1226444238-14614-28-git-send-email-me@felipebalbi.com>
 <1226444238-14614-29-git-send-email-me@felipebalbi.com>
 <1226444238-14614-30-git-send-email-me@felipebalbi.com>
 <1226444238-14614-31-git-send-email-me@felipebalbi.com>
 <1226444238-14614-32-git-send-email-me@felipebalbi.com>
 <1226444238-14614-33-git-send-email-me@felipebalbi.com>
 <1226444238-14614-34-git-send-email-me@felipebalbi.com>
 <1226444238-14614-35-git-send-email-me@felipebalbi.com>
 <1226444238-14614-36-git-send-email-me@felipebalbi.com>
 <1226444238-14614-37-git-send-email-me@felipebalbi.com>
 <1226444238-14614-38-git-send-email-me@felipebalbi.com>
 <1226444238-14614-39-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:34804 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbYKKXKj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:10:39 -0500
In-Reply-To: <1226444238-14614-39-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/gadget/omap_udc.c |  406 ++++++++++++++++++++--------------------
 1 files changed, 203 insertions(+), 203 deletions(-)

diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index 34e9e39..767d599 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -136,7 +136,7 @@ static void use_ep(struct omap_ep *ep, u16 select)
 
 	if (ep->bEndpointAddress & USB_DIR_IN)
 		num |= UDC_EP_DIR;
-	omap_writew(num | select, UDC_EP_NUM);
+	__raw_writew(num | select, UDC_EP_NUM);
 	/* when select, MUST deselect later !! */
 }
 
@@ -144,9 +144,9 @@ static inline void deselect_ep(void)
 {
 	u16 w;
 
-	w = omap_readw(UDC_EP_NUM);
+	w = __raw_readw(UDC_EP_NUM);
 	w &= ~UDC_EP_SEL;
-	omap_writew(w, UDC_EP_NUM);
+	__raw_writew(w, UDC_EP_NUM);
 	/* 6 wait states before TX will happen */
 }
 
@@ -221,7 +221,7 @@ static int omap_ep_enable(struct usb_ep *_ep,
 	ep->has_dma = 0;
 	ep->lch = -1;
 	use_ep(ep, UDC_EP_SEL);
-	omap_writew(udc->clr_halt, UDC_CTRL);
+	__raw_writew(udc->clr_halt, UDC_CTRL);
 	ep->ackwait = 0;
 	deselect_ep();
 
@@ -237,7 +237,7 @@ static int omap_ep_enable(struct usb_ep *_ep,
 	if (desc->bmAttributes != USB_ENDPOINT_XFER_ISOC
 			&& !ep->has_dma
 			&& !(ep->bEndpointAddress & USB_DIR_IN)) {
-		omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
+		__raw_writew(UDC_SET_FIFO_EN, UDC_CTRL);
 		ep->ackwait = 1 + ep->double_buf;
 	}
 
@@ -264,7 +264,7 @@ static int omap_ep_disable(struct usb_ep *_ep)
 	nuke (ep, -ESHUTDOWN);
 	ep->ep.maxpacket = ep->maxpacket;
 	ep->has_dma = 0;
-	omap_writew(UDC_SET_HALT, UDC_CTRL);
+	__raw_writew(UDC_SET_HALT, UDC_CTRL);
 	list_del_init(&ep->iso);
 	del_timer(&ep->timer);
 
@@ -365,13 +365,13 @@ write_packet(u8 *buf, struct omap_req *req, unsigned max)
 	if (likely((((int)buf) & 1) == 0)) {
 		wp = (u16 *)buf;
 		while (max >= 2) {
-			omap_writew(*wp++, UDC_DATA);
+			__raw_writew(*wp++, UDC_DATA);
 			max -= 2;
 		}
 		buf = (u8 *)wp;
 	}
 	while (max--)
-		omap_writeb(*buf++, UDC_DATA);
+		__raw_writeb(*buf++, UDC_DATA);
 	return len;
 }
 
@@ -390,13 +390,13 @@ static int write_fifo(struct omap_ep *ep, struct omap_req *req)
 	prefetch(buf);
 
 	/* PIO-IN isn't double buffered except for iso */
-	ep_stat = omap_readw(UDC_STAT_FLG);
+	ep_stat = __raw_readw(UDC_STAT_FLG);
 	if (ep_stat & UDC_FIFO_UNWRITABLE)
 		return 0;
 
 	count = ep->ep.maxpacket;
 	count = write_packet(buf, req, count);
-	omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
+	__raw_writew(UDC_SET_FIFO_EN, UDC_CTRL);
 	ep->ackwait = 1;
 
 	/* last packet is often short (sometimes a zlp) */
@@ -430,13 +430,13 @@ read_packet(u8 *buf, struct omap_req *req, unsigned avail)
 	if (likely((((int)buf) & 1) == 0)) {
 		wp = (u16 *)buf;
 		while (avail >= 2) {
-			*wp++ = omap_readw(UDC_DATA);
+			*wp++ = __raw_readw(UDC_DATA);
 			avail -= 2;
 		}
 		buf = (u8 *)wp;
 	}
 	while (avail--)
-		*buf++ = omap_readb(UDC_DATA);
+		*buf++ = __raw_readb(UDC_DATA);
 	return len;
 }
 
@@ -451,7 +451,7 @@ static int read_fifo(struct omap_ep *ep, struct omap_req *req)
 	prefetchw(buf);
 
 	for (;;) {
-		u16	ep_stat = omap_readw(UDC_STAT_FLG);
+		u16	ep_stat = __raw_readw(UDC_STAT_FLG);
 
 		is_last = 0;
 		if (ep_stat & FIFO_EMPTY) {
@@ -465,7 +465,7 @@ static int read_fifo(struct omap_ep *ep, struct omap_req *req)
 		if (ep_stat & UDC_FIFO_FULL)
 			avail = ep->ep.maxpacket;
 		else  {
-			avail = omap_readw(UDC_RXFSTAT);
+			avail = __raw_readw(UDC_RXFSTAT);
 			ep->fnf = ep->double_buf;
 		}
 		count = read_packet(buf, req, avail);
@@ -478,7 +478,7 @@ static int read_fifo(struct omap_ep *ep, struct omap_req *req)
 				req->req.status = -EOVERFLOW;
 				avail -= count;
 				while (avail--)
-					omap_readw(UDC_DATA);
+					__raw_readw(UDC_DATA);
 			}
 		} else if (req->req.length == req->req.actual)
 			is_last = 1;
@@ -572,10 +572,10 @@ static void next_in_dma(struct omap_ep *ep, struct omap_req *req)
 
 	omap_start_dma(ep->lch);
 	ep->dma_counter = omap_get_dma_src_pos(ep->lch);
-	w = omap_readw(UDC_DMA_IRQ_EN);
+	w = __raw_readw(UDC_DMA_IRQ_EN);
 	w |= UDC_TX_DONE_IE(ep->dma_channel);
-	omap_writew(w, UDC_DMA_IRQ_EN);
-	omap_writew(UDC_TXN_START | txdma_ctrl, UDC_TXDMA(ep->dma_channel));
+	__raw_writew(w, UDC_DMA_IRQ_EN);
+	__raw_writew(UDC_TXN_START | txdma_ctrl, UDC_TXDMA(ep->dma_channel));
 	req->dma_bytes = length;
 }
 
@@ -599,9 +599,9 @@ static void finish_in_dma(struct omap_ep *ep, struct omap_req *req, int status)
 
 	/* tx completion */
 	omap_stop_dma(ep->lch);
-	w = omap_readw(UDC_DMA_IRQ_EN);
+	w = __raw_readw(UDC_DMA_IRQ_EN);
 	w &= ~UDC_TX_DONE_IE(ep->dma_channel);
-	omap_writew(w, UDC_DMA_IRQ_EN);
+	__raw_writew(w, UDC_DMA_IRQ_EN);
 	done(ep, req, status);
 }
 
@@ -638,12 +638,12 @@ static void next_out_dma(struct omap_ep *ep, struct omap_req *req)
 		0, 0);
 	ep->dma_counter = omap_get_dma_dst_pos(ep->lch);
 
-	omap_writew(UDC_RXN_STOP | (packets - 1), UDC_RXDMA(ep->dma_channel));
-	w = omap_readw(UDC_DMA_IRQ_EN);
+	__raw_writew(UDC_RXN_STOP | (packets - 1), UDC_RXDMA(ep->dma_channel));
+	w = __raw_readw(UDC_DMA_IRQ_EN);
 	w |= UDC_RX_EOT_IE(ep->dma_channel);
-	omap_writew(w, UDC_DMA_IRQ_EN);
-	omap_writew(ep->bEndpointAddress & 0xf, UDC_EP_NUM);
-	omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
+	__raw_writew(w, UDC_DMA_IRQ_EN);
+	__raw_writew(ep->bEndpointAddress & 0xf, UDC_EP_NUM);
+	__raw_writew(UDC_SET_FIFO_EN, UDC_CTRL);
 
 	omap_start_dma(ep->lch);
 }
@@ -670,15 +670,15 @@ finish_out_dma(struct omap_ep *ep, struct omap_req *req, int status, int one)
 		return;
 
 	/* rx completion */
-	w = omap_readw(UDC_DMA_IRQ_EN);
+	w = __raw_readw(UDC_DMA_IRQ_EN);
 	w &= ~UDC_RX_EOT_IE(ep->dma_channel);
-	omap_writew(w, UDC_DMA_IRQ_EN);
+	__raw_writew(w, UDC_DMA_IRQ_EN);
 	done(ep, req, status);
 }
 
 static void dma_irq(struct omap_udc *udc, u16 irq_src)
 {
-	u16		dman_stat = omap_readw(UDC_DMAN_STAT);
+	u16		dman_stat = __raw_readw(UDC_DMAN_STAT);
 	struct omap_ep	*ep;
 	struct omap_req	*req;
 
@@ -692,7 +692,7 @@ static void dma_irq(struct omap_udc *udc, u16 irq_src)
 						struct omap_req, queue);
 			finish_in_dma(ep, req, 0);
 		}
-		omap_writew(UDC_TXN_DONE, UDC_IRQ_SRC);
+		__raw_writew(UDC_TXN_DONE, UDC_IRQ_SRC);
 
 		if (!list_empty (&ep->queue)) {
 			req = container_of(ep->queue.next,
@@ -711,7 +711,7 @@ static void dma_irq(struct omap_udc *udc, u16 irq_src)
 					struct omap_req, queue);
 			finish_out_dma(ep, req, 0, dman_stat & UDC_DMA_RX_SB);
 		}
-		omap_writew(UDC_RXN_EOT, UDC_IRQ_SRC);
+		__raw_writew(UDC_RXN_EOT, UDC_IRQ_SRC);
 
 		if (!list_empty (&ep->queue)) {
 			req = container_of(ep->queue.next,
@@ -725,7 +725,7 @@ static void dma_irq(struct omap_udc *udc, u16 irq_src)
 		ep->irqs++;
 		/* omap15xx does this unasked... */
 		VDBG("%s, RX_CNT irq?\n", ep->ep.name);
-		omap_writew(UDC_RXN_CNT, UDC_IRQ_SRC);
+		__raw_writew(UDC_RXN_CNT, UDC_IRQ_SRC);
 	}
 }
 
@@ -748,9 +748,9 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
 
 	is_in = ep->bEndpointAddress & USB_DIR_IN;
 	if (is_in)
-		reg = omap_readw(UDC_TXDMA_CFG);
+		reg = __raw_readw(UDC_TXDMA_CFG);
 	else
-		reg = omap_readw(UDC_RXDMA_CFG);
+		reg = __raw_readw(UDC_RXDMA_CFG);
 	reg |= UDC_DMA_REQ;		/* "pulse" activated */
 
 	ep->dma_channel = 0;
@@ -778,7 +778,7 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
 		status = omap_request_dma(dma_channel,
 			ep->ep.name, dma_error, ep, &ep->lch);
 		if (status == 0) {
-			omap_writew(reg, UDC_TXDMA_CFG);
+			__raw_writew(reg, UDC_TXDMA_CFG);
 			/* EMIFF or SDRC */
 			omap_set_dma_src_burst_mode(ep->lch,
 						OMAP_DMA_DATA_BURST_4);
@@ -799,7 +799,7 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
 		status = omap_request_dma(dma_channel,
 			ep->ep.name, dma_error, ep, &ep->lch);
 		if (status == 0) {
-			omap_writew(reg, UDC_RXDMA_CFG);
+			__raw_writew(reg, UDC_RXDMA_CFG);
 			/* TIPB */
 			omap_set_dma_src_params(ep->lch,
 				OMAP_DMA_PORT_TIPB,
@@ -846,7 +846,7 @@ just_restart:
 			(is_in ? write_fifo : read_fifo)(ep, req);
 			deselect_ep();
 			if (!is_in) {
-				omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
+				__raw_writew(UDC_SET_FIFO_EN, UDC_CTRL);
 				ep->ackwait = 1 + ep->double_buf;
 			}
 			/* IN: 6 wait states before it'll tx */
@@ -880,7 +880,7 @@ static void dma_channel_release(struct omap_ep *ep)
 
 	/* wait till current packet DMA finishes, and fifo empties */
 	if (ep->bEndpointAddress & USB_DIR_IN) {
-		omap_writew((omap_readw(UDC_TXDMA_CFG) & ~mask) | UDC_DMA_REQ,
+		__raw_writew((__raw_readw(UDC_TXDMA_CFG) & ~mask) | UDC_DMA_REQ,
 					UDC_TXDMA_CFG);
 
 		if (req) {
@@ -888,17 +888,17 @@ static void dma_channel_release(struct omap_ep *ep)
 
 			/* clear FIFO; hosts probably won't empty it */
 			use_ep(ep, UDC_EP_SEL);
-			omap_writew(UDC_CLR_EP, UDC_CTRL);
+			__raw_writew(UDC_CLR_EP, UDC_CTRL);
 			deselect_ep();
 		}
-		while (omap_readw(UDC_TXDMA_CFG) & mask)
+		while (__raw_readw(UDC_TXDMA_CFG) & mask)
 			udelay(10);
 	} else {
-		omap_writew((omap_readw(UDC_RXDMA_CFG) & ~mask) | UDC_DMA_REQ,
+		__raw_writew((__raw_readw(UDC_RXDMA_CFG) & ~mask) | UDC_DMA_REQ,
 					UDC_RXDMA_CFG);
 
 		/* dma empties the fifo */
-		while (omap_readw(UDC_RXDMA_CFG) & mask)
+		while (__raw_readw(UDC_RXDMA_CFG) & mask)
 			udelay(10);
 		if (req)
 			finish_out_dma(ep, req, -ECONNRESET, 0);
@@ -988,9 +988,9 @@ omap_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 	if (is_iso) {
 		u16 w;
 
-		w = omap_readw(UDC_IRQ_EN);
+		w = __raw_readw(UDC_IRQ_EN);
 		w |= UDC_SOF_IE;
-		omap_writew(w, UDC_IRQ_EN);
+		__raw_writew(w, UDC_IRQ_EN);
 	} else if (list_empty(&ep->queue) && !ep->stopped && !ep->ackwait) {
 		int	is_in;
 
@@ -1009,23 +1009,23 @@ omap_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 				 * requests to non-control endpoints
 				 */
 				if (udc->ep0_set_config) {
-					u16	irq_en = omap_readw(UDC_IRQ_EN);
+					u16	irq_en = __raw_readw(UDC_IRQ_EN);
 
 					irq_en |= UDC_DS_CHG_IE | UDC_EP0_IE;
 					if (!udc->ep0_reset_config)
 						irq_en |= UDC_EPN_RX_IE
 							| UDC_EPN_TX_IE;
-					omap_writew(irq_en, UDC_IRQ_EN);
+					__raw_writew(irq_en, UDC_IRQ_EN);
 				}
 
 				/* STATUS for zero length DATA stages is
 				 * always an IN ... even for IN transfers,
 				 * a weird case which seem to stall OMAP.
 				 */
-				omap_writew(UDC_EP_SEL | UDC_EP_DIR, UDC_EP_NUM);
-				omap_writew(UDC_CLR_EP, UDC_CTRL);
-				omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
-				omap_writew(UDC_EP_DIR, UDC_EP_NUM);
+				__raw_writew(UDC_EP_SEL | UDC_EP_DIR, UDC_EP_NUM);
+				__raw_writew(UDC_CLR_EP, UDC_CTRL);
+				__raw_writew(UDC_SET_FIFO_EN, UDC_CTRL);
+				__raw_writew(UDC_EP_DIR, UDC_EP_NUM);
 
 				/* cleanup */
 				udc->ep0_pending = 0;
@@ -1034,11 +1034,11 @@ omap_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 
 			/* non-empty DATA stage */
 			} else if (is_in) {
-				omap_writew(UDC_EP_SEL | UDC_EP_DIR, UDC_EP_NUM);
+				__raw_writew(UDC_EP_SEL | UDC_EP_DIR, UDC_EP_NUM);
 			} else {
 				if (udc->ep0_setup)
 					goto irq_wait;
-				omap_writew(UDC_EP_SEL, UDC_EP_NUM);
+				__raw_writew(UDC_EP_SEL, UDC_EP_NUM);
 			}
 		} else {
 			is_in = ep->bEndpointAddress & USB_DIR_IN;
@@ -1054,7 +1054,7 @@ omap_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 				req = NULL;
 			deselect_ep();
 			if (!is_in) {
-				omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
+				__raw_writew(UDC_SET_FIFO_EN, UDC_CTRL);
 				ep->ackwait = 1 + ep->double_buf;
 			}
 			/* IN: 6 wait states before it'll tx */
@@ -1122,9 +1122,9 @@ static int omap_ep_set_halt(struct usb_ep *_ep, int value)
 		else if (value) {
 			if (ep->udc->ep0_set_config) {
 				WARNING("error changing config?\n");
-				omap_writew(UDC_CLR_CFG, UDC_SYSCON2);
+				__raw_writew(UDC_CLR_CFG, UDC_SYSCON2);
 			}
-			omap_writew(UDC_STALL_CMD, UDC_SYSCON2);
+			__raw_writew(UDC_STALL_CMD, UDC_SYSCON2);
 			ep->udc->ep0_pending = 0;
 			status = 0;
 		} else /* NOP */
@@ -1151,8 +1151,8 @@ static int omap_ep_set_halt(struct usb_ep *_ep, int value)
 				channel = 0;
 
 			use_ep(ep, UDC_EP_SEL);
-			if (omap_readw(UDC_STAT_FLG) & UDC_NON_ISO_FIFO_EMPTY) {
-				omap_writew(UDC_SET_HALT, UDC_CTRL);
+			if (__raw_readw(UDC_STAT_FLG) & UDC_NON_ISO_FIFO_EMPTY) {
+				__raw_writew(UDC_SET_HALT, UDC_CTRL);
 				status = 0;
 			} else
 				status = -EAGAIN;
@@ -1162,10 +1162,10 @@ static int omap_ep_set_halt(struct usb_ep *_ep, int value)
 				dma_channel_claim(ep, channel);
 		} else {
 			use_ep(ep, 0);
-			omap_writew(ep->udc->clr_halt, UDC_CTRL);
+			__raw_writew(ep->udc->clr_halt, UDC_CTRL);
 			ep->ackwait = 0;
 			if (!(ep->bEndpointAddress & USB_DIR_IN)) {
-				omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
+				__raw_writew(UDC_SET_FIFO_EN, UDC_CTRL);
 				ep->ackwait = 1 + ep->double_buf;
 			}
 		}
@@ -1197,7 +1197,7 @@ static struct usb_ep_ops omap_ep_ops = {
 
 static int omap_get_frame(struct usb_gadget *gadget)
 {
-	u16	sof = omap_readw(UDC_SOF);
+	u16	sof = __raw_readw(UDC_SOF);
 	return (sof & UDC_TS_OK) ? (sof & UDC_TS) : -EL2NSYNC;
 }
 
@@ -1216,7 +1216,7 @@ static int omap_wakeup(struct usb_gadget *gadget)
 		 */
 		if (udc->devstat & (UDC_B_HNP_ENABLE|UDC_R_WK_OK)) {
 			DBG("remote wakeup...\n");
-			omap_writew(UDC_RMT_WKP, UDC_SYSCON2);
+			__raw_writew(UDC_RMT_WKP, UDC_SYSCON2);
 			retval = 0;
 		}
 
@@ -1239,12 +1239,12 @@ omap_set_selfpowered(struct usb_gadget *gadget, int is_selfpowered)
 
 	udc = container_of(gadget, struct omap_udc, gadget);
 	spin_lock_irqsave(&udc->lock, flags);
-	syscon1 = omap_readw(UDC_SYSCON1);
+	syscon1 = __raw_readw(UDC_SYSCON1);
 	if (is_selfpowered)
 		syscon1 |= UDC_SELF_PWR;
 	else
 		syscon1 &= ~UDC_SELF_PWR;
-	omap_writew(syscon1, UDC_SYSCON1);
+	__raw_writew(syscon1, UDC_SYSCON1);
 	spin_unlock_irqrestore(&udc->lock, flags);
 
 	return 0;
@@ -1259,17 +1259,17 @@ static void pullup_enable(struct omap_udc *udc)
 {
 	u16 w;
 
-	w = omap_readw(UDC_SYSCON1);
+	w = __raw_readw(UDC_SYSCON1);
 	w |= UDC_PULLUP_EN;
-	omap_writew(w, UDC_SYSCON1);
+	__raw_writew(w, UDC_SYSCON1);
 	if (!gadget_is_otg(&udc->gadget) && !cpu_is_omap15xx()) {
 		u32 l;
 
-		l = omap_readl(OTG_CTRL);
+		l = __raw_readl(OTG_CTRL);
 		l |= OTG_BSESSVLD;
-		omap_writel(l, OTG_CTRL);
+		__raw_writel(l, OTG_CTRL);
 	}
-	omap_writew(UDC_DS_CHG_IE, UDC_IRQ_EN);
+	__raw_writew(UDC_DS_CHG_IE, UDC_IRQ_EN);
 }
 
 static void pullup_disable(struct omap_udc *udc)
@@ -1279,14 +1279,14 @@ static void pullup_disable(struct omap_udc *udc)
 	if (!gadget_is_otg(&udc->gadget) && !cpu_is_omap15xx()) {
 		u32 l;
 
-		l = omap_readl(OTG_CTRL);
+		l = __raw_readl(OTG_CTRL);
 		l &= ~OTG_BSESSVLD;
-		omap_writel(l, OTG_CTRL);
+		__raw_writel(l, OTG_CTRL);
 	}
-	omap_writew(UDC_DS_CHG_IE, UDC_IRQ_EN);
-	w = omap_readw(UDC_SYSCON1);
+	__raw_writew(UDC_DS_CHG_IE, UDC_IRQ_EN);
+	w = __raw_readw(UDC_SYSCON1);
 	w &= ~UDC_PULLUP_EN;
-	omap_writew(w, UDC_SYSCON1);
+	__raw_writew(w, UDC_SYSCON1);
 }
 
 static struct omap_udc *udc;
@@ -1322,12 +1322,12 @@ static int omap_vbus_session(struct usb_gadget *gadget, int is_active)
 	udc->vbus_active = (is_active != 0);
 	if (cpu_is_omap15xx()) {
 		/* "software" detect, ignored if !VBUS_MODE_1510 */
-		l = omap_readl(FUNC_MUX_CTRL_0);
+		l = __raw_readl(FUNC_MUX_CTRL_0);
 		if (is_active)
 			l |= VBUS_CTRL_1510;
 		else
 			l &= ~VBUS_CTRL_1510;
-		omap_writel(l, FUNC_MUX_CTRL_0);
+		__raw_writel(l, FUNC_MUX_CTRL_0);
 	}
 	if (udc->dc_clk != NULL && is_active) {
 		if (!udc->clk_requested) {
@@ -1397,9 +1397,9 @@ static void nuke(struct omap_ep *ep, int status)
 		dma_channel_release(ep);
 
 	use_ep(ep, 0);
-	omap_writew(UDC_CLR_EP, UDC_CTRL);
+	__raw_writew(UDC_CLR_EP, UDC_CTRL);
 	if (ep->bEndpointAddress && ep->bmAttributes != USB_ENDPOINT_XFER_ISOC)
-		omap_writew(UDC_SET_HALT, UDC_CTRL);
+		__raw_writew(UDC_SET_HALT, UDC_CTRL);
 
 	while (!list_empty(&ep->queue)) {
 		req = list_entry(ep->queue.next, struct omap_req, queue);
@@ -1427,8 +1427,8 @@ static void update_otg(struct omap_udc *udc)
 	if (!gadget_is_otg(&udc->gadget))
 		return;
 
-	if (omap_readl(OTG_CTRL) & OTG_ID)
-		devstat = omap_readw(UDC_DEVSTAT);
+	if (__raw_readl(OTG_CTRL) & OTG_ID)
+		devstat = __raw_readw(UDC_DEVSTAT);
 	else
 		devstat = 0;
 
@@ -1442,10 +1442,10 @@ static void update_otg(struct omap_udc *udc)
 	if (udc->gadget.b_hnp_enable) {
 		u32 l;
 
-		l = omap_readl(OTG_CTRL);
+		l = __raw_readl(OTG_CTRL);
 		l |= OTG_B_HNPEN | OTG_B_BUSREQ;
 		l &= ~OTG_PULLUP;
-		omap_writel(l, OTG_CTRL);
+		__raw_writel(l, OTG_CTRL);
 	}
 }
 
@@ -1464,7 +1464,7 @@ static void ep0_irq(struct omap_udc *udc, u16 irq_src)
 
 		nuke(ep0, 0);
 		if (ack) {
-			omap_writew(ack, UDC_IRQ_SRC);
+			__raw_writew(ack, UDC_IRQ_SRC);
 			irq_src = UDC_SETUP;
 		}
 	}
@@ -1484,9 +1484,9 @@ static void ep0_irq(struct omap_udc *udc, u16 irq_src)
 	if (irq_src & UDC_EP0_TX) {
 		int	stat;
 
-		omap_writew(UDC_EP0_TX, UDC_IRQ_SRC);
-		omap_writew(UDC_EP_SEL|UDC_EP_DIR, UDC_EP_NUM);
-		stat = omap_readw(UDC_STAT_FLG);
+		__raw_writew(UDC_EP0_TX, UDC_IRQ_SRC);
+		__raw_writew(UDC_EP_SEL|UDC_EP_DIR, UDC_EP_NUM);
+		stat = __raw_readw(UDC_STAT_FLG);
 		if (stat & UDC_ACK) {
 			if (udc->ep0_in) {
 				/* write next IN packet from response,
@@ -1494,26 +1494,26 @@ static void ep0_irq(struct omap_udc *udc, u16 irq_src)
 				 */
 				if (req)
 					stat = write_fifo(ep0, req);
-				omap_writew(UDC_EP_DIR, UDC_EP_NUM);
+				__raw_writew(UDC_EP_DIR, UDC_EP_NUM);
 				if (!req && udc->ep0_pending) {
-					omap_writew(UDC_EP_SEL, UDC_EP_NUM);
-					omap_writew(UDC_CLR_EP, UDC_CTRL);
-					omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
-					omap_writew(0, UDC_EP_NUM);
+					__raw_writew(UDC_EP_SEL, UDC_EP_NUM);
+					__raw_writew(UDC_CLR_EP, UDC_CTRL);
+					__raw_writew(UDC_SET_FIFO_EN, UDC_CTRL);
+					__raw_writew(0, UDC_EP_NUM);
 					udc->ep0_pending = 0;
 				} /* else:  6 wait states before it'll tx */
 			} else {
 				/* ack status stage of OUT transfer */
-				omap_writew(UDC_EP_DIR, UDC_EP_NUM);
+				__raw_writew(UDC_EP_DIR, UDC_EP_NUM);
 				if (req)
 					done(ep0, req, 0);
 			}
 			req = NULL;
 		} else if (stat & UDC_STALL) {
-			omap_writew(UDC_CLR_HALT, UDC_CTRL);
-			omap_writew(UDC_EP_DIR, UDC_EP_NUM);
+			__raw_writew(UDC_CLR_HALT, UDC_CTRL);
+			__raw_writew(UDC_EP_DIR, UDC_EP_NUM);
 		} else {
-			omap_writew(UDC_EP_DIR, UDC_EP_NUM);
+			__raw_writew(UDC_EP_DIR, UDC_EP_NUM);
 		}
 	}
 
@@ -1521,9 +1521,9 @@ static void ep0_irq(struct omap_udc *udc, u16 irq_src)
 	if (irq_src & UDC_EP0_RX) {
 		int	stat;
 
-		omap_writew(UDC_EP0_RX, UDC_IRQ_SRC);
-		omap_writew(UDC_EP_SEL, UDC_EP_NUM);
-		stat = omap_readw(UDC_STAT_FLG);
+		__raw_writew(UDC_EP0_RX, UDC_IRQ_SRC);
+		__raw_writew(UDC_EP_SEL, UDC_EP_NUM);
+		stat = __raw_readw(UDC_STAT_FLG);
 		if (stat & UDC_ACK) {
 			if (!udc->ep0_in) {
 				stat = 0;
@@ -1531,35 +1531,35 @@ static void ep0_irq(struct omap_udc *udc, u16 irq_src)
 				 * reactiviting the fifo; stall on errors.
 				 */
 				if (!req || (stat = read_fifo(ep0, req)) < 0) {
-					omap_writew(UDC_STALL_CMD, UDC_SYSCON2);
+					__raw_writew(UDC_STALL_CMD, UDC_SYSCON2);
 					udc->ep0_pending = 0;
 					stat = 0;
 				} else if (stat == 0)
-					omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
-				omap_writew(0, UDC_EP_NUM);
+					__raw_writew(UDC_SET_FIFO_EN, UDC_CTRL);
+				__raw_writew(0, UDC_EP_NUM);
 
 				/* activate status stage */
 				if (stat == 1) {
 					done(ep0, req, 0);
 					/* that may have STALLed ep0... */
-					omap_writew(UDC_EP_SEL | UDC_EP_DIR,
+					__raw_writew(UDC_EP_SEL | UDC_EP_DIR,
 							UDC_EP_NUM);
-					omap_writew(UDC_CLR_EP, UDC_CTRL);
-					omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
-					omap_writew(UDC_EP_DIR, UDC_EP_NUM);
+					__raw_writew(UDC_CLR_EP, UDC_CTRL);
+					__raw_writew(UDC_SET_FIFO_EN, UDC_CTRL);
+					__raw_writew(UDC_EP_DIR, UDC_EP_NUM);
 					udc->ep0_pending = 0;
 				}
 			} else {
 				/* ack status stage of IN transfer */
-				omap_writew(0, UDC_EP_NUM);
+				__raw_writew(0, UDC_EP_NUM);
 				if (req)
 					done(ep0, req, 0);
 			}
 		} else if (stat & UDC_STALL) {
-			omap_writew(UDC_CLR_HALT, UDC_CTRL);
-			omap_writew(0, UDC_EP_NUM);
+			__raw_writew(UDC_CLR_HALT, UDC_CTRL);
+			__raw_writew(0, UDC_EP_NUM);
 		} else {
-			omap_writew(0, UDC_EP_NUM);
+			__raw_writew(0, UDC_EP_NUM);
 		}
 	}
 
@@ -1574,14 +1574,14 @@ static void ep0_irq(struct omap_udc *udc, u16 irq_src)
 
 		/* read the (latest) SETUP message */
 		do {
-			omap_writew(UDC_SETUP_SEL, UDC_EP_NUM);
+			__raw_writew(UDC_SETUP_SEL, UDC_EP_NUM);
 			/* two bytes at a time */
-			u.word[0] = omap_readw(UDC_DATA);
-			u.word[1] = omap_readw(UDC_DATA);
-			u.word[2] = omap_readw(UDC_DATA);
-			u.word[3] = omap_readw(UDC_DATA);
-			omap_writew(0, UDC_EP_NUM);
-		} while (omap_readw(UDC_IRQ_SRC) & UDC_SETUP);
+			u.word[0] = __raw_readw(UDC_DATA);
+			u.word[1] = __raw_readw(UDC_DATA);
+			u.word[2] = __raw_readw(UDC_DATA);
+			u.word[3] = __raw_readw(UDC_DATA);
+			__raw_writew(0, UDC_EP_NUM);
+		} while (__raw_readw(UDC_IRQ_SRC) & UDC_SETUP);
 
 #define	w_value		le16_to_cpu(u.r.wValue)
 #define	w_index		le16_to_cpu(u.r.wIndex)
@@ -1612,9 +1612,9 @@ static void ep0_irq(struct omap_udc *udc, u16 irq_src)
 			 * later if it fails the request.
 			 */
 			if (udc->ep0_reset_config)
-				omap_writew(UDC_CLR_CFG, UDC_SYSCON2);
+				__raw_writew(UDC_CLR_CFG, UDC_SYSCON2);
 			else
-				omap_writew(UDC_DEV_CFG, UDC_SYSCON2);
+				__raw_writew(UDC_DEV_CFG, UDC_SYSCON2);
 			update_otg(udc);
 			goto delegate;
 		case USB_REQ_CLEAR_FEATURE:
@@ -1632,10 +1632,10 @@ static void ep0_irq(struct omap_udc *udc, u16 irq_src)
 						|| !ep->desc)
 					goto do_stall;
 				use_ep(ep, 0);
-				omap_writew(udc->clr_halt, UDC_CTRL);
+				__raw_writew(udc->clr_halt, UDC_CTRL);
 				ep->ackwait = 0;
 				if (!(ep->bEndpointAddress & USB_DIR_IN)) {
-					omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
+					__raw_writew(UDC_SET_FIFO_EN, UDC_CTRL);
 					ep->ackwait = 1 + ep->double_buf;
 				}
 				/* NOTE:  assumes the host behaves sanely,
@@ -1668,15 +1668,15 @@ static void ep0_irq(struct omap_udc *udc, u16 irq_src)
 			}
 			use_ep(ep, 0);
 			/* can't halt if fifo isn't empty... */
-			omap_writew(UDC_CLR_EP, UDC_CTRL);
-			omap_writew(UDC_SET_HALT, UDC_CTRL);
+			__raw_writew(UDC_CLR_EP, UDC_CTRL);
+			__raw_writew(UDC_SET_HALT, UDC_CTRL);
 			VDBG("%s halted by host\n", ep->name);
 ep0out_status_stage:
 			status = 0;
-			omap_writew(UDC_EP_SEL|UDC_EP_DIR, UDC_EP_NUM);
-			omap_writew(UDC_CLR_EP, UDC_CTRL);
-			omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
-			omap_writew(UDC_EP_DIR, UDC_EP_NUM);
+			__raw_writew(UDC_EP_SEL|UDC_EP_DIR, UDC_EP_NUM);
+			__raw_writew(UDC_CLR_EP, UDC_CTRL);
+			__raw_writew(UDC_SET_FIFO_EN, UDC_CTRL);
+			__raw_writew(UDC_EP_DIR, UDC_EP_NUM);
 			udc->ep0_pending = 0;
 			break;
 		case USB_REQ_GET_STATUS:
@@ -1713,10 +1713,10 @@ intf_status:
 
 zero_status:
 			/* return two zero bytes */
-			omap_writew(UDC_EP_SEL|UDC_EP_DIR, UDC_EP_NUM);
-			omap_writew(0, UDC_DATA);
-			omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
-			omap_writew(UDC_EP_DIR, UDC_EP_NUM);
+			__raw_writew(UDC_EP_SEL|UDC_EP_DIR, UDC_EP_NUM);
+			__raw_writew(0, UDC_DATA);
+			__raw_writew(UDC_SET_FIFO_EN, UDC_CTRL);
+			__raw_writew(UDC_EP_DIR, UDC_EP_NUM);
 			status = 0;
 			VDBG("GET_STATUS, interface %d\n", w_index);
 			/* next, status stage */
@@ -1725,8 +1725,8 @@ zero_status:
 delegate:
 			/* activate the ep0out fifo right away */
 			if (!udc->ep0_in && w_length) {
-				omap_writew(0, UDC_EP_NUM);
-				omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
+				__raw_writew(0, UDC_EP_NUM);
+				__raw_writew(UDC_SET_FIFO_EN, UDC_CTRL);
 			}
 
 			/* gadget drivers see class/vendor specific requests,
@@ -1767,9 +1767,9 @@ do_stall:
 				if (udc->ep0_reset_config)
 					WARNING("error resetting config?\n");
 				else
-					omap_writew(UDC_CLR_CFG, UDC_SYSCON2);
+					__raw_writew(UDC_CLR_CFG, UDC_SYSCON2);
 			}
-			omap_writew(UDC_STALL_CMD, UDC_SYSCON2);
+			__raw_writew(UDC_STALL_CMD, UDC_SYSCON2);
 			udc->ep0_pending = 0;
 		}
 	}
@@ -1783,7 +1783,7 @@ static void devstate_irq(struct omap_udc *udc, u16 irq_src)
 {
 	u16	devstat, change;
 
-	devstat = omap_readw(UDC_DEVSTAT);
+	devstat = __raw_readw(UDC_DEVSTAT);
 	change = devstat ^ udc->devstat;
 	udc->devstat = devstat;
 
@@ -1823,7 +1823,7 @@ static void devstate_irq(struct omap_udc *udc, u16 irq_src)
 				INFO("USB reset done, gadget %s\n",
 					udc->driver->driver.name);
 				/* ep0 traffic is legal from now on */
-				omap_writew(UDC_DS_CHG_IE | UDC_EP0_IE,
+				__raw_writew(UDC_DS_CHG_IE | UDC_EP0_IE,
 						UDC_IRQ_EN);
 			}
 			change &= ~UDC_USB_RESET;
@@ -1868,7 +1868,7 @@ static void devstate_irq(struct omap_udc *udc, u16 irq_src)
 		VDBG("devstat %03x, ignore change %03x\n",
 			devstat,  change);
 
-	omap_writew(UDC_DS_CHG, UDC_IRQ_SRC);
+	__raw_writew(UDC_DS_CHG, UDC_IRQ_SRC);
 }
 
 static irqreturn_t omap_udc_irq(int irq, void *_udc)
@@ -1879,7 +1879,7 @@ static irqreturn_t omap_udc_irq(int irq, void *_udc)
 	unsigned long	flags;
 
 	spin_lock_irqsave(&udc->lock, flags);
-	irq_src = omap_readw(UDC_IRQ_SRC);
+	irq_src = __raw_readw(UDC_IRQ_SRC);
 
 	/* Device state change (usb ch9 stuff) */
 	if (irq_src & UDC_DS_CHG) {
@@ -1923,7 +1923,7 @@ static void pio_out_timer(unsigned long _ep)
 	spin_lock_irqsave(&ep->udc->lock, flags);
 	if (!list_empty(&ep->queue) && ep->ackwait) {
 		use_ep(ep, UDC_EP_SEL);
-		stat_flg = omap_readw(UDC_STAT_FLG);
+		stat_flg = __raw_readw(UDC_STAT_FLG);
 
 		if ((stat_flg & UDC_ACK) && (!(stat_flg & UDC_FIFO_EN)
 				|| (ep->double_buf && HALF_FULL(stat_flg)))) {
@@ -1933,8 +1933,8 @@ static void pio_out_timer(unsigned long _ep)
 			req = container_of(ep->queue.next,
 					struct omap_req, queue);
 			(void) read_fifo(ep, req);
-			omap_writew(ep->bEndpointAddress, UDC_EP_NUM);
-			omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
+			__raw_writew(ep->bEndpointAddress, UDC_EP_NUM);
+			__raw_writew(UDC_SET_FIFO_EN, UDC_CTRL);
 			ep->ackwait = 1 + ep->double_buf;
 		} else
 			deselect_ep();
@@ -1954,20 +1954,20 @@ static irqreturn_t omap_udc_pio_irq(int irq, void *_dev)
 	unsigned long	flags;
 
 	spin_lock_irqsave(&udc->lock, flags);
-	epn_stat = omap_readw(UDC_EPN_STAT);
-	irq_src = omap_readw(UDC_IRQ_SRC);
+	epn_stat = __raw_readw(UDC_EPN_STAT);
+	irq_src = __raw_readw(UDC_IRQ_SRC);
 
 	/* handle OUT first, to avoid some wasteful NAKs */
 	if (irq_src & UDC_EPN_RX) {
 		epnum = (epn_stat >> 8) & 0x0f;
-		omap_writew(UDC_EPN_RX, UDC_IRQ_SRC);
+		__raw_writew(UDC_EPN_RX, UDC_IRQ_SRC);
 		status = IRQ_HANDLED;
 		ep = &udc->ep[epnum];
 		ep->irqs++;
 
-		omap_writew(epnum | UDC_EP_SEL, UDC_EP_NUM);
+		__raw_writew(epnum | UDC_EP_SEL, UDC_EP_NUM);
 		ep->fnf = 0;
-		if (omap_readw(UDC_STAT_FLG) & UDC_ACK) {
+		if (__raw_readw(UDC_STAT_FLG) & UDC_ACK) {
 			ep->ackwait--;
 			if (!list_empty(&ep->queue)) {
 				int stat;
@@ -1979,15 +1979,15 @@ static irqreturn_t omap_udc_pio_irq(int irq, void *_dev)
 			}
 		}
 		/* min 6 clock delay before clearing EP_SEL ... */
-		epn_stat = omap_readw(UDC_EPN_STAT);
-		epn_stat = omap_readw(UDC_EPN_STAT);
-		omap_writew(epnum, UDC_EP_NUM);
+		epn_stat = __raw_readw(UDC_EPN_STAT);
+		epn_stat = __raw_readw(UDC_EPN_STAT);
+		__raw_writew(epnum, UDC_EP_NUM);
 
 		/* enabling fifo _after_ clearing ACK, contrary to docs,
 		 * reduces lossage; timer still needed though (sigh).
 		 */
 		if (ep->fnf) {
-			omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
+			__raw_writew(UDC_SET_FIFO_EN, UDC_CTRL);
 			ep->ackwait = 1 + ep->double_buf;
 		}
 		mod_timer(&ep->timer, PIO_OUT_TIMEOUT);
@@ -1996,13 +1996,13 @@ static irqreturn_t omap_udc_pio_irq(int irq, void *_dev)
 	/* then IN transfers */
 	else if (irq_src & UDC_EPN_TX) {
 		epnum = epn_stat & 0x0f;
-		omap_writew(UDC_EPN_TX, UDC_IRQ_SRC);
+		__raw_writew(UDC_EPN_TX, UDC_IRQ_SRC);
 		status = IRQ_HANDLED;
 		ep = &udc->ep[16 + epnum];
 		ep->irqs++;
 
-		omap_writew(epnum | UDC_EP_DIR | UDC_EP_SEL, UDC_EP_NUM);
-		if (omap_readw(UDC_STAT_FLG) & UDC_ACK) {
+		__raw_writew(epnum | UDC_EP_DIR | UDC_EP_SEL, UDC_EP_NUM);
+		if (__raw_readw(UDC_STAT_FLG) & UDC_ACK) {
 			ep->ackwait = 0;
 			if (!list_empty(&ep->queue)) {
 				req = container_of(ep->queue.next,
@@ -2011,9 +2011,9 @@ static irqreturn_t omap_udc_pio_irq(int irq, void *_dev)
 			}
 		}
 		/* min 6 clock delay before clearing EP_SEL ... */
-		epn_stat = omap_readw(UDC_EPN_STAT);
-		epn_stat = omap_readw(UDC_EPN_STAT);
-		omap_writew(epnum | UDC_EP_DIR, UDC_EP_NUM);
+		epn_stat = __raw_readw(UDC_EPN_STAT);
+		epn_stat = __raw_readw(UDC_EPN_STAT);
+		__raw_writew(epnum | UDC_EP_DIR, UDC_EP_NUM);
 		/* then 6 clocks before it'd tx */
 	}
 
@@ -2041,7 +2041,7 @@ static irqreturn_t omap_udc_iso_irq(int irq, void *_dev)
 		req = list_entry(ep->queue.next, struct omap_req, queue);
 
 		use_ep(ep, UDC_EP_SEL);
-		stat = omap_readw(UDC_STAT_FLG);
+		stat = __raw_readw(UDC_STAT_FLG);
 
 		/* NOTE: like the other controller drivers, this isn't
 		 * currently reporting lost or damaged frames.
@@ -2076,11 +2076,11 @@ static irqreturn_t omap_udc_iso_irq(int irq, void *_dev)
 	if (!pending) {
 		u16 w;
 
-		w = omap_readw(UDC_IRQ_EN);
+		w = __raw_readw(UDC_IRQ_EN);
 		w &= ~UDC_SOF_IE;
-		omap_writew(w, UDC_IRQ_EN);
+		__raw_writew(w, UDC_IRQ_EN);
 	}
-	omap_writew(UDC_IRQ_SOF, UDC_IRQ_SRC);
+	__raw_writew(UDC_IRQ_SOF, UDC_IRQ_SRC);
 
 	spin_unlock_irqrestore(&udc->lock, flags);
 	return IRQ_HANDLED;
@@ -2129,7 +2129,7 @@ int usb_gadget_register_driver (struct usb_gadget_driver *driver)
 		if (ep->bmAttributes == USB_ENDPOINT_XFER_ISOC)
 			continue;
 		use_ep(ep, 0);
-		omap_writew(UDC_SET_HALT, UDC_CTRL);
+		__raw_writew(UDC_SET_HALT, UDC_CTRL);
 	}
 	udc->ep0_pending = 0;
 	udc->ep[0].irqs = 0;
@@ -2153,7 +2153,7 @@ int usb_gadget_register_driver (struct usb_gadget_driver *driver)
 	}
 	DBG("bound to driver %s\n", driver->driver.name);
 
-	omap_writew(UDC_IRQ_SRC_MASK, UDC_IRQ_SRC);
+	__raw_writew(UDC_IRQ_SRC_MASK, UDC_IRQ_SRC);
 
 	/* connect to bus through transceiver */
 	if (udc->transceiver) {
@@ -2250,7 +2250,7 @@ static void proc_ep_show(struct seq_file *s, struct omap_ep *ep)
 	else
 		buf[0] = 0;
 
-	stat_flg = omap_readw(UDC_STAT_FLG);
+	stat_flg = __raw_readw(UDC_STAT_FLG);
 	seq_printf(s,
 		"\n%s %s%s%sirqs %ld stat %04x " EIGHTBITS FOURBITS "%s\n",
 		ep->name, buf,
@@ -2311,7 +2311,7 @@ static int proc_otg_show(struct seq_file *s)
 	u32		trans;
 	char		*ctrl_name;
 
-	tmp = omap_readl(OTG_REV);
+	tmp = __raw_readl(OTG_REV);
 	if (cpu_is_omap24xx()) {
 		/*
 		 * REVISIT: Not clear how this works on OMAP2.  trans
@@ -2324,11 +2324,11 @@ static int proc_otg_show(struct seq_file *s)
 		trans = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
 	} else {
 		ctrl_name = "tranceiver_ctrl";
-		trans = omap_readw(USB_TRANSCEIVER_CTRL);
+		trans = __raw_readw(USB_TRANSCEIVER_CTRL);
 	}
 	seq_printf(s, "\nOTG rev %d.%d, %s %05x\n",
 		tmp >> 4, tmp & 0xf, ctrl_name, trans);
-	tmp = omap_readw(OTG_SYSCON_1);
+	tmp = __raw_readw(OTG_SYSCON_1);
 	seq_printf(s, "otg_syscon1 %08x usb2 %s, usb1 %s, usb0 %s,"
 			FOURBITS "\n", tmp,
 		trx_mode(USB2_TRX_MODE(tmp), trans & CONF_USB2_UNI_R),
@@ -2340,7 +2340,7 @@ static int proc_otg_show(struct seq_file *s)
 		(tmp & HST_IDLE_EN) ? " !host" : "",
 		(tmp & DEV_IDLE_EN) ? " !dev" : "",
 		(tmp & OTG_RESET_DONE) ? " reset_done" : " reset_active");
-	tmp = omap_readl(OTG_SYSCON_2);
+	tmp = __raw_readl(OTG_SYSCON_2);
 	seq_printf(s, "otg_syscon2 %08x%s" EIGHTBITS
 			" b_ase_brst=%d hmc=%d\n", tmp,
 		(tmp & OTG_EN) ? " otg_en" : "",
@@ -2355,7 +2355,7 @@ static int proc_otg_show(struct seq_file *s)
 		(tmp & HMC_TLLATTACH) ? " tllattach" : "",
 		B_ASE_BRST(tmp),
 		OTG_HMC(tmp));
-	tmp = omap_readl(OTG_CTRL);
+	tmp = __raw_readl(OTG_CTRL);
 	seq_printf(s, "otg_ctrl    %06x" EIGHTBITS EIGHTBITS "%s\n", tmp,
 		(tmp & OTG_ASESSVLD) ? " asess" : "",
 		(tmp & OTG_BSESSEND) ? " bsess_end" : "",
@@ -2375,13 +2375,13 @@ static int proc_otg_show(struct seq_file *s)
 		(tmp & OTG_PU_VBUS) ? " pu_vb" : "",
 		(tmp & OTG_PU_ID) ? " pu_id" : ""
 		);
-	tmp = omap_readw(OTG_IRQ_EN);
+	tmp = __raw_readw(OTG_IRQ_EN);
 	seq_printf(s, "otg_irq_en  %04x" "\n", tmp);
-	tmp = omap_readw(OTG_IRQ_SRC);
+	tmp = __raw_readw(OTG_IRQ_SRC);
 	seq_printf(s, "otg_irq_src %04x" "\n", tmp);
-	tmp = omap_readw(OTG_OUTCTRL);
+	tmp = __raw_readw(OTG_OUTCTRL);
 	seq_printf(s, "otg_outctrl %04x" "\n", tmp);
-	tmp = omap_readw(OTG_TEST);
+	tmp = __raw_readw(OTG_TEST);
 	seq_printf(s, "otg_test    %04x" "\n", tmp);
 	return 0;
 }
@@ -2402,7 +2402,7 @@ static int proc_udc_show(struct seq_file *s, void *_)
 		driver_desc,
 		use_dma ?  " (dma)" : "");
 
-	tmp = omap_readw(UDC_REV) & 0xff;
+	tmp = __raw_readw(UDC_REV) & 0xff;
 	seq_printf(s,
 		"UDC rev %d.%d, fifo mode %d, gadget %s\n"
 		"hmc %d, transceiver %s\n",
@@ -2416,16 +2416,16 @@ static int proc_udc_show(struct seq_file *s, void *_)
 				? "external" : "(none)"));
 	if (cpu_class_is_omap1()) {
 		seq_printf(s, "ULPD control %04x req %04x status %04x\n",
-			omap_readw(ULPD_CLOCK_CTRL),
-			omap_readw(ULPD_SOFT_REQ),
-			omap_readw(ULPD_STATUS_REQ));
+			__raw_readw(ULPD_CLOCK_CTRL),
+			__raw_readw(ULPD_SOFT_REQ),
+			__raw_readw(ULPD_STATUS_REQ));
 	}
 
 	/* OTG controller registers */
 	if (!cpu_is_omap15xx())
 		proc_otg_show(s);
 
-	tmp = omap_readw(UDC_SYSCON1);
+	tmp = __raw_readw(UDC_SYSCON1);
 	seq_printf(s, "\nsyscon1     %04x" EIGHTBITS "\n", tmp,
 		(tmp & UDC_CFG_LOCK) ? " cfg_lock" : "",
 		(tmp & UDC_DATA_ENDIAN) ? " data_endian" : "",
@@ -2444,7 +2444,7 @@ static int proc_udc_show(struct seq_file *s, void *_)
 		return 0;
 	}
 
-	tmp = omap_readw(UDC_DEVSTAT);
+	tmp = __raw_readw(UDC_DEVSTAT);
 	seq_printf(s, "devstat     %04x" EIGHTBITS "%s%s\n", tmp,
 		(tmp & UDC_B_HNP_ENABLE) ? " b_hnp" : "",
 		(tmp & UDC_A_HNP_SUPPORT) ? " a_hnp" : "",
@@ -2456,15 +2456,15 @@ static int proc_udc_show(struct seq_file *s, void *_)
 		(tmp & UDC_ADD) ? " ADD" : "",
 		(tmp & UDC_DEF) ? " DEF" : "",
 		(tmp & UDC_ATT) ? " ATT" : "");
-	seq_printf(s, "sof         %04x\n", omap_readw(UDC_SOF));
-	tmp = omap_readw(UDC_IRQ_EN);
+	seq_printf(s, "sof         %04x\n", __raw_readw(UDC_SOF));
+	tmp = __raw_readw(UDC_IRQ_EN);
 	seq_printf(s, "irq_en      %04x" FOURBITS "%s\n", tmp,
 		(tmp & UDC_SOF_IE) ? " sof" : "",
 		(tmp & UDC_EPN_RX_IE) ? " epn_rx" : "",
 		(tmp & UDC_EPN_TX_IE) ? " epn_tx" : "",
 		(tmp & UDC_DS_CHG_IE) ? " ds_chg" : "",
 		(tmp & UDC_EP0_IE) ? " ep0" : "");
-	tmp = omap_readw(UDC_IRQ_SRC);
+	tmp = __raw_readw(UDC_IRQ_SRC);
 	seq_printf(s, "irq_src     %04x" EIGHTBITS "%s%s\n", tmp,
 		(tmp & UDC_TXN_DONE) ? " txn_done" : "",
 		(tmp & UDC_RXN_CNT) ? " rxn_cnt" : "",
@@ -2479,7 +2479,7 @@ static int proc_udc_show(struct seq_file *s, void *_)
 	if (use_dma) {
 		unsigned i;
 
-		tmp = omap_readw(UDC_DMA_IRQ_EN);
+		tmp = __raw_readw(UDC_DMA_IRQ_EN);
 		seq_printf(s, "dma_irq_en  %04x%s" EIGHTBITS "\n", tmp,
 			(tmp & UDC_TX_DONE_IE(3)) ? " tx2_done" : "",
 			(tmp & UDC_RX_CNT_IE(3)) ? " rx2_cnt" : "",
@@ -2493,29 +2493,29 @@ static int proc_udc_show(struct seq_file *s, void *_)
 			(tmp & UDC_RX_CNT_IE(1)) ? " rx0_cnt" : "",
 			(tmp & UDC_RX_EOT_IE(1)) ? " rx0_eot" : "");
 
-		tmp = omap_readw(UDC_RXDMA_CFG);
+		tmp = __raw_readw(UDC_RXDMA_CFG);
 		seq_printf(s, "rxdma_cfg   %04x\n", tmp);
 		if (tmp) {
 			for (i = 0; i < 3; i++) {
 				if ((tmp & (0x0f << (i * 4))) == 0)
 					continue;
 				seq_printf(s, "rxdma[%d]    %04x\n", i,
-						omap_readw(UDC_RXDMA(i + 1)));
+						__raw_readw(UDC_RXDMA(i + 1)));
 			}
 		}
-		tmp = omap_readw(UDC_TXDMA_CFG);
+		tmp = __raw_readw(UDC_TXDMA_CFG);
 		seq_printf(s, "txdma_cfg   %04x\n", tmp);
 		if (tmp) {
 			for (i = 0; i < 3; i++) {
 				if (!(tmp & (0x0f << (i * 4))))
 					continue;
 				seq_printf(s, "txdma[%d]    %04x\n", i,
-						omap_readw(UDC_TXDMA(i + 1)));
+						__raw_readw(UDC_TXDMA(i + 1)));
 			}
 		}
 	}
 
-	tmp = omap_readw(UDC_DEVSTAT);
+	tmp = __raw_readw(UDC_DEVSTAT);
 	if (tmp & UDC_ATT) {
 		proc_ep_show(s, &udc->ep[0]);
 		if (tmp & UDC_ADD) {
@@ -2629,9 +2629,9 @@ omap_ep_setup(char *name, u8 addr, u8 type,
 		name, addr, epn_rxtx, maxp, dbuf ? "x2" : "", buf);
 
 	if (addr & USB_DIR_IN)
-		omap_writew(epn_rxtx, UDC_EP_TX(addr & 0xf));
+		__raw_writew(epn_rxtx, UDC_EP_TX(addr & 0xf));
 	else
-		omap_writew(epn_rxtx, UDC_EP_RX(addr));
+		__raw_writew(epn_rxtx, UDC_EP_RX(addr));
 
 	/* next endpoint's buffer starts after this one's */
 	buf += maxp;
@@ -2670,12 +2670,12 @@ omap_udc_setup(struct platform_device *odev, struct otg_transceiver *xceiv)
 	unsigned	tmp, buf;
 
 	/* abolish any previous hardware state */
-	omap_writew(0, UDC_SYSCON1);
-	omap_writew(0, UDC_IRQ_EN);
-	omap_writew(UDC_IRQ_SRC_MASK, UDC_IRQ_SRC);
-	omap_writew(0, UDC_DMA_IRQ_EN);
-	omap_writew(0, UDC_RXDMA_CFG);
-	omap_writew(0, UDC_TXDMA_CFG);
+	__raw_writew(0, UDC_SYSCON1);
+	__raw_writew(0, UDC_IRQ_EN);
+	__raw_writew(UDC_IRQ_SRC_MASK, UDC_IRQ_SRC);
+	__raw_writew(0, UDC_DMA_IRQ_EN);
+	__raw_writew(0, UDC_RXDMA_CFG);
+	__raw_writew(0, UDC_TXDMA_CFG);
 
 	/* UDC_PULLUP_EN gates the chip clock */
 	// OTG_SYSCON_1 |= DEV_IDLE_EN;
@@ -2709,8 +2709,8 @@ omap_udc_setup(struct platform_device *odev, struct otg_transceiver *xceiv)
 
 	/* initially disable all non-ep0 endpoints */
 	for (tmp = 1; tmp < 15; tmp++) {
-		omap_writew(0, UDC_EP_RX(tmp));
-		omap_writew(0, UDC_EP_TX(tmp));
+		__raw_writew(0, UDC_EP_RX(tmp));
+		__raw_writew(0, UDC_EP_TX(tmp));
 	}
 
 #define OMAP_BULK_EP(name,addr) \
@@ -2795,7 +2795,7 @@ omap_udc_setup(struct platform_device *odev, struct otg_transceiver *xceiv)
 		ERR("unsupported fifo_mode #%d\n", fifo_mode);
 		return -ENODEV;
 	}
-	omap_writew(UDC_CFG_LOCK|UDC_SELF_PWR, UDC_SYSCON1);
+	__raw_writew(UDC_CFG_LOCK|UDC_SELF_PWR, UDC_SYSCON1);
 	INFO("fifo mode %d, %d bytes not used\n", fifo_mode, 2048 - buf);
 	return 0;
 }
@@ -2839,7 +2839,7 @@ static int __init omap_udc_probe(struct platform_device *pdev)
 	}
 
 	INFO("OMAP UDC rev %d.%d%s\n",
-		omap_readw(UDC_REV) >> 4, omap_readw(UDC_REV) & 0xf,
+		__raw_readw(UDC_REV) >> 4, omap_readw(UDC_REV) & 0xf,
 		config->otg ? ", Mini-AB" : "");
 
 	/* use the mode given to us by board init code */
@@ -2854,12 +2854,12 @@ static int __init omap_udc_probe(struct platform_device *pdev)
 			 * know when to turn PULLUP_EN on/off; and that
 			 * means we always "need" the 48MHz clock.
 			 */
-			u32 tmp = omap_readl(FUNC_MUX_CTRL_0);
+			u32 tmp = __raw_readl(FUNC_MUX_CTRL_0);
 			tmp &= ~VBUS_CTRL_1510;
-			omap_writel(tmp, FUNC_MUX_CTRL_0);
+			__raw_writel(tmp, FUNC_MUX_CTRL_0);
 			tmp |= VBUS_MODE_1510;
 			tmp &= ~VBUS_CTRL_1510;
-			omap_writel(tmp, FUNC_MUX_CTRL_0);
+			__raw_writel(tmp, FUNC_MUX_CTRL_0);
 		}
 	} else {
 		/* The transceiver may package some GPIO logic or handle
@@ -2939,7 +2939,7 @@ known:
 #endif
 
 	/* starting with omap1710 es2.0, clear toggle is a separate bit */
-	if (omap_readw(UDC_REV) >= 0x61)
+	if (__raw_readw(UDC_REV) >= 0x61)
 		udc->clr_halt = UDC_RESET_EP | UDC_CLRDATA_TOGGLE;
 	else
 		udc->clr_halt = UDC_RESET_EP;
@@ -3037,7 +3037,7 @@ static int __exit omap_udc_remove(struct platform_device *pdev)
 		put_device(udc->transceiver->dev);
 		udc->transceiver = NULL;
 	}
-	omap_writew(0, UDC_SYSCON1);
+	__raw_writew(0, UDC_SYSCON1);
 
 	remove_proc_file();
 
@@ -3077,7 +3077,7 @@ static int omap_udc_suspend(struct platform_device *dev, pm_message_t message)
 {
 	u32	devstat;
 
-	devstat = omap_readw(UDC_DEVSTAT);
+	devstat = __raw_readw(UDC_DEVSTAT);
 
 	/* we're requesting 48 MHz clock if the pullup is enabled
 	 * (== we're attached to the host) and we're not suspended,
-- 
1.6.0.2.307.gc427

