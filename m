From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/52] musb_hdrc: Search and replace wFifoCount with
	fifo_count
Date: Mon, 13 Aug 2007 06:48:45 -0700
Message-ID: <11870129934099-git-send-email-tony@atomide.com>
References: musb <11870129672745-git-send-email-tony@atomide.com>
	<11870129702817-git-send-email-tony@atomide.com>
	<11870129721700-git-send-email-tony@atomide.com>
	<1187012975431-git-send-email-tony@atomide.com>
	<11870129782148-git-send-email-tony@atomide.com>
	<1187012980445-git-send-email-tony@atomide.com>
	<11870129834092-git-send-email-tony@atomide.com>
	<11870129861917-git-send-email-tony@atomide.com>
	<118701298833-git-send-email-tony@atomide.com>
	<11870129901657-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11870129901657-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Search and replace wFifoCount with fifo_count

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/g_ep0.c       |   10 +++++-----
 drivers/usb/musb/musb_gadget.c |   26 +++++++++++++-------------
 drivers/usb/musb/musb_host.c   |   20 ++++++++++----------
 3 files changed, 28 insertions(+), 28 deletions(-)

--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -487,7 +487,7 @@ static void ep0_txstate(struct musb *musb)
 	struct usb_request	*pRequest = next_ep0_request(musb);
 	u16			wCsrVal = MGC_M_CSR0_TXPKTRDY;
 	u8			*pFifoSource;
-	u8			wFifoCount;
+	u8			fifo_count;
 
 	if (!pRequest) {
 		// WARN_ON(1);
@@ -497,13 +497,13 @@ static void ep0_txstate(struct musb *musb)
 
 	/* load the data */
 	pFifoSource = (u8 *) pRequest->buf + pRequest->actual;
-	wFifoCount = min((unsigned) MGC_END0_FIFOSIZE,
+	fifo_count = min((unsigned) MGC_END0_FIFOSIZE,
 		pRequest->length - pRequest->actual);
-	musb_write_fifo(&musb->aLocalEnd[0], wFifoCount, pFifoSource);
-	pRequest->actual += wFifoCount;
+	musb_write_fifo(&musb->aLocalEnd[0], fifo_count, pFifoSource);
+	pRequest->actual += fifo_count;
 
 	/* update the flags */
-	if (wFifoCount < MUSB_MAX_END0_PACKET
+	if (fifo_count < MUSB_MAX_END0_PACKET
 			|| pRequest->actual == pRequest->length) {
 		musb->ep0_state = MGC_END0_STAGE_STATUSOUT;
 		wCsrVal |= MGC_M_CSR0_P_DATAEND;
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -256,7 +256,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 	struct musb_ep		*musb_ep;
 	void __iomem		*epio = musb->aLocalEnd[bEnd].regs;
 	struct usb_request	*pRequest;
-	u16			wFifoCount = 0, wCsrVal;
+	u16			fifo_count = 0, wCsrVal;
 	int			use_dma = 0;
 
 	musb_ep = req->ep;
@@ -271,7 +271,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 	wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
 
 	pRequest = &req->request;
-	wFifoCount = min(max_ep_writesize(musb, musb_ep),
+	fifo_count = min(max_ep_writesize(musb, musb_ep),
 			(int)(pRequest->length - pRequest->actual));
 
 	if (wCsrVal & MGC_M_TXCSR_TXPKTRDY) {
@@ -287,7 +287,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 	}
 
 	DBG(4, "hw_ep%d, maxpacket %d, fifo count %d, txcsr %03x\n",
-			bEnd, musb_ep->wPacketSize, wFifoCount,
+			bEnd, musb_ep->wPacketSize, fifo_count,
 			wCsrVal);
 
 #ifndef	CONFIG_USB_INVENTRA_FIFO
@@ -381,9 +381,9 @@ static void txstate(struct musb *musb, struct musb_request *req)
 #endif
 
 	if (!use_dma) {
-		musb_write_fifo(musb_ep->hw_ep, wFifoCount,
+		musb_write_fifo(musb_ep->hw_ep, fifo_count,
 				(u8 *) (pRequest->buf + pRequest->actual));
-		pRequest->actual += wFifoCount;
+		pRequest->actual += fifo_count;
 		wCsrVal |= MGC_M_TXCSR_TXPKTRDY;
 		wCsrVal &= ~MGC_M_TXCSR_P_UNDERRUN;
 		musb_writew(epio, MGC_O_HDRC_TXCSR, wCsrVal);
@@ -394,7 +394,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 			musb_ep->end_point.name, use_dma ? "dma" : "pio",
 			pRequest->actual, pRequest->length,
 			musb_readw(epio, MGC_O_HDRC_TXCSR),
-			wFifoCount,
+			fifo_count,
 			musb_readw(epio, MGC_O_HDRC_TXMAXP));
 }
 
@@ -577,7 +577,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	struct usb_request	*pRequest = &req->request;
 	struct musb_ep		*musb_ep = &musb->aLocalEnd[bEnd].ep_out;
 	void __iomem		*epio = musb->aLocalEnd[bEnd].regs;
-	u16			wFifoCount = 0;
+	u16			fifo_count = 0;
 	u16			wCount = musb_ep->wPacketSize;
 
 	wCsrVal = musb_readw(epio, MGC_O_HDRC_RXCSR);
@@ -684,13 +684,13 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 			}
 #endif	/* Mentor's USB */
 
-			wFifoCount = pRequest->length - pRequest->actual;
+			fifo_count = pRequest->length - pRequest->actual;
 			DBG(3, "%s OUT/RX pio fifo %d/%d, maxpacket %d\n",
 					musb_ep->end_point.name,
-					wCount, wFifoCount,
+					wCount, fifo_count,
 					musb_ep->wPacketSize);
 
-			wFifoCount = min(wCount, wFifoCount);
+			fifo_count = min(wCount, fifo_count);
 
 #ifdef	CONFIG_USB_TUSB_OMAP_DMA
 			if (tusb_dma_omap() && musb_ep->dma) {
@@ -703,15 +703,15 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 						musb_ep->wPacketSize,
 						channel->bDesiredMode,
 						dma_addr,
-						wFifoCount);
+						fifo_count);
 				if (ret == TRUE)
 					return;
 			}
 #endif
 
-			musb_read_fifo(musb_ep->hw_ep, wFifoCount, (u8 *)
+			musb_read_fifo(musb_ep->hw_ep, fifo_count, (u8 *)
 					(pRequest->buf + pRequest->actual));
-			pRequest->actual += wFifoCount;
+			pRequest->actual += fifo_count;
 
 			/* REVISIT if we left anything in the fifo, flush
 			 * it and report -EOVERFLOW
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -947,7 +947,7 @@ static int musb_h_ep0_continue(struct musb *musb,
 {
 	int			 bMore = FALSE;
 	u8 *pFifoDest = NULL;
-	u16 wFifoCount = 0;
+	u16 fifo_count = 0;
 	struct musb_hw_ep	*hw_ep = musb->control_ep;
 	struct musb_qh		*qh = hw_ep->in_qh;
 	struct usb_ctrlrequest	*pRequest;
@@ -955,14 +955,14 @@ static int musb_h_ep0_continue(struct musb *musb,
 	switch (musb->bEnd0Stage) {
 	case MGC_END0_IN:
 		pFifoDest = pUrb->transfer_buffer + pUrb->actual_length;
-		wFifoCount = min(wCount, ((u16) (pUrb->transfer_buffer_length
+		fifo_count = min(wCount, ((u16) (pUrb->transfer_buffer_length
 					- pUrb->actual_length)));
-		if (wFifoCount < wCount)
+		if (fifo_count < wCount)
 			pUrb->status = -EOVERFLOW;
 
-		musb_read_fifo(hw_ep, wFifoCount, pFifoDest);
+		musb_read_fifo(hw_ep, fifo_count, pFifoDest);
 
-		pUrb->actual_length += wFifoCount;
+		pUrb->actual_length += fifo_count;
 		if (wCount < qh->maxpacket) {
 			/* always terminate on short read; it's
 			 * rarely reported as an error.
@@ -989,18 +989,18 @@ static int musb_h_ep0_continue(struct musb *musb,
 		}
 		/* FALLTHROUGH */
 	case MGC_END0_OUT:
-		wFifoCount = min(qh->maxpacket, ((u16)
+		fifo_count = min(qh->maxpacket, ((u16)
 				(pUrb->transfer_buffer_length
 				- pUrb->actual_length)));
 
-		if (wFifoCount) {
+		if (fifo_count) {
 			pFifoDest = (u8 *) (pUrb->transfer_buffer
 					+ pUrb->actual_length);
 			DBG(3, "Sending %d bytes to %p\n",
-					wFifoCount, pFifoDest);
-			musb_write_fifo(hw_ep, wFifoCount, pFifoDest);
+					fifo_count, pFifoDest);
+			musb_write_fifo(hw_ep, fifo_count, pFifoDest);
 
-			pUrb->actual_length += wFifoCount;
+			pUrb->actual_length += fifo_count;
 			bMore = TRUE;
 		}
 		break;
-- 
1.5.2.3
