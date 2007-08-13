From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/52] musb_hdrc: Search and replace pEnd with musb_ep when
	struct musb_ep
Date: Mon, 13 Aug 2007 06:48:38 -0700
Message-ID: <1187012975431-git-send-email-tony@atomide.com>
References: musb <11870129672745-git-send-email-tony@atomide.com>
	<11870129702817-git-send-email-tony@atomide.com>
	<11870129721700-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11870129721700-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Search and replace pEnd with musb_ep when struct musb_ep

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/g_ep0.c       |   18 ++--
 drivers/usb/musb/musb_gadget.c |  266 ++++++++++++++++++++--------------------
 2 files changed, 142 insertions(+), 142 deletions(-)

--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -257,7 +257,7 @@ __acquires(musb->Lock)
 				break;
 			case USB_RECIP_ENDPOINT:{
 				const u8 bEnd = pControlRequest->wIndex & 0x0f;
-				struct musb_ep *pEnd;
+				struct musb_ep *musb_ep;
 
 				if (bEnd == 0
 						|| bEnd >= MUSB_C_NUM_EPS
@@ -266,15 +266,15 @@ __acquires(musb->Lock)
 					break;
 
 				if (pControlRequest->wIndex & USB_DIR_IN)
-					pEnd = &musb->aLocalEnd[bEnd].ep_in;
+					musb_ep = &musb->aLocalEnd[bEnd].ep_in;
 				else
-					pEnd = &musb->aLocalEnd[bEnd].ep_out;
-				if (!pEnd->desc)
+					musb_ep = &musb->aLocalEnd[bEnd].ep_out;
+				if (!musb_ep->desc)
 					break;
 
 				/* REVISIT do it directly, no locking games */
 				spin_unlock(&musb->Lock);
-				musb_gadget_set_halt(&pEnd->end_point, 0);
+				musb_gadget_set_halt(&musb_ep->end_point, 0);
 				spin_lock(&musb->Lock);
 
 				/* select ep0 again */
@@ -366,7 +366,7 @@ stall:
 			case USB_RECIP_ENDPOINT:{
 				const u8		bEnd =
 					pControlRequest->wIndex & 0x0f;
-				struct musb_ep		*pEnd;
+				struct musb_ep		*musb_ep;
 				struct musb_hw_ep	*ep;
 				void __iomem		*regs;
 				int			is_in;
@@ -382,10 +382,10 @@ stall:
 				regs = ep->regs;
 				is_in = pControlRequest->wIndex & USB_DIR_IN;
 				if (is_in)
-					pEnd = &ep->ep_in;
+					musb_ep = &ep->ep_in;
 				else
-					pEnd = &ep->ep_out;
-				if (!pEnd->desc)
+					musb_ep = &ep->ep_out;
+				if (!musb_ep->desc)
 					break;
 
 				MGC_SelectEnd(pBase, bEnd);
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -253,16 +253,16 @@ static inline int max_ep_writesize(struct musb *musb, struct musb_ep *ep)
 static void txstate(struct musb *musb, struct musb_request *req)
 {
 	u8			bEnd = req->bEnd;
-	struct musb_ep		*pEnd;
+	struct musb_ep		*musb_ep;
 	void __iomem		*epio = musb->aLocalEnd[bEnd].regs;
 	struct usb_request	*pRequest;
 	u16			wFifoCount = 0, wCsrVal;
 	int			use_dma = 0;
 
-	pEnd = req->ep;
+	musb_ep = req->ep;
 
 	/* we shouldn't get here while DMA is active ... but we do ... */
-	if (dma_channel_status(pEnd->dma) == MGC_DMA_STATUS_BUSY) {
+	if (dma_channel_status(musb_ep->dma) == MGC_DMA_STATUS_BUSY) {
 		DBG(4, "dma pending...\n");
 		return;
 	}
@@ -271,27 +271,27 @@ static void txstate(struct musb *musb, struct musb_request *req)
 	wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
 
 	pRequest = &req->request;
-	wFifoCount = min(max_ep_writesize(musb, pEnd),
+	wFifoCount = min(max_ep_writesize(musb, musb_ep),
 			(int)(pRequest->length - pRequest->actual));
 
 	if (wCsrVal & MGC_M_TXCSR_TXPKTRDY) {
 		DBG(5, "%s old packet still ready , txcsr %03x\n",
-				pEnd->end_point.name, wCsrVal);
+				musb_ep->end_point.name, wCsrVal);
 		return;
 	}
 
 	if (wCsrVal & MGC_M_TXCSR_P_SENDSTALL) {
 		DBG(5, "%s stalling, txcsr %03x\n",
-				pEnd->end_point.name, wCsrVal);
+				musb_ep->end_point.name, wCsrVal);
 		return;
 	}
 
 	DBG(4, "hw_ep%d, maxpacket %d, fifo count %d, txcsr %03x\n",
-			bEnd, pEnd->wPacketSize, wFifoCount,
+			bEnd, musb_ep->wPacketSize, wFifoCount,
 			wCsrVal);
 
 #ifndef	CONFIG_USB_INVENTRA_FIFO
-	if (is_dma_capable() && pEnd->dma) {
+	if (is_dma_capable() && musb_ep->dma) {
 		struct dma_controller	*c = musb->pDmaController;
 
 		use_dma = (pRequest->dma != DMA_ADDR_INVALID);
@@ -304,18 +304,18 @@ static void txstate(struct musb *musb, struct musb_request *req)
 
 			/* setup DMA, then program endpoint CSR */
 			request_size = min(pRequest->length,
-						pEnd->dma->dwMaxLength);
-			if (request_size <= pEnd->wPacketSize)
-				pEnd->dma->bDesiredMode = 0;
+						musb_ep->dma->dwMaxLength);
+			if (request_size <= musb_ep->wPacketSize)
+				musb_ep->dma->bDesiredMode = 0;
 			else
-				pEnd->dma->bDesiredMode = 1;
+				musb_ep->dma->bDesiredMode = 1;
 
 			use_dma = use_dma && c->channel_program(
-					pEnd->dma, pEnd->wPacketSize,
-					pEnd->dma->bDesiredMode,
+					musb_ep->dma, musb_ep->wPacketSize,
+					musb_ep->dma->bDesiredMode,
 					pRequest->dma, request_size);
 			if (use_dma) {
-				if (pEnd->dma->bDesiredMode == 0) {
+				if (musb_ep->dma->bDesiredMode == 0) {
 					/* ASSERT: DMAENAB is clear */
 					wCsrVal &= ~(MGC_M_TXCSR_AUTOSET |
 							MGC_M_TXCSR_DMAMODE);
@@ -359,20 +359,20 @@ static void txstate(struct musb *musb, struct musb_request *req)
 		 * except for the last-packet-is-already-short case.
 		 */
 		use_dma = use_dma && c->channel_program(
-				pEnd->dma, pEnd->wPacketSize,
+				musb_ep->dma, musb_ep->wPacketSize,
 				0,
 				pRequest->dma,
 				pRequest->length);
 		if (!use_dma) {
-			c->channel_release(pEnd->dma);
-			pEnd->dma = NULL;
+			c->channel_release(musb_ep->dma);
+			musb_ep->dma = NULL;
 			/* ASSERT: DMAENAB clear */
 			wCsrVal &= ~(MGC_M_TXCSR_DMAMODE | MGC_M_TXCSR_MODE);
 			/* invariant: prequest->buf is non-null */
 		}
 #elif defined(CONFIG_USB_TUSB_OMAP_DMA)
 		use_dma = use_dma && c->channel_program(
-				pEnd->dma, pEnd->wPacketSize,
+				musb_ep->dma, musb_ep->wPacketSize,
 				pRequest->zero,
 				pRequest->dma,
 				pRequest->length);
@@ -381,7 +381,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 #endif
 
 	if (!use_dma) {
-		musb_write_fifo(pEnd->hw_ep, wFifoCount,
+		musb_write_fifo(musb_ep->hw_ep, wFifoCount,
 				(u8 *) (pRequest->buf + pRequest->actual));
 		pRequest->actual += wFifoCount;
 		wCsrVal |= MGC_M_TXCSR_TXPKTRDY;
@@ -391,7 +391,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 
 	/* host may already have the data when this message shows... */
 	DBG(3, "%s TX/IN %s len %d/%d, txcsr %04x, fifo %d/%d\n",
-			pEnd->end_point.name, use_dma ? "dma" : "pio",
+			musb_ep->end_point.name, use_dma ? "dma" : "pio",
 			pRequest->actual, pRequest->length,
 			musb_readw(epio, MGC_O_HDRC_TXCSR),
 			wFifoCount,
@@ -407,17 +407,17 @@ void musb_g_tx(struct musb *musb, u8 bEnd)
 	u16			wCsrVal;
 	struct usb_request	*pRequest;
 	u8 __iomem		*pBase = musb->pRegs;
-	struct musb_ep		*pEnd = &musb->aLocalEnd[bEnd].ep_in;
+	struct musb_ep		*musb_ep = &musb->aLocalEnd[bEnd].ep_in;
 	void __iomem		*epio = musb->aLocalEnd[bEnd].regs;
 	struct dma_channel	*dma;
 
 	MGC_SelectEnd(pBase, bEnd);
-	pRequest = next_request(pEnd);
+	pRequest = next_request(musb_ep);
 
 	wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
-	DBG(4, "<== %s, txcsr %04x\n", pEnd->end_point.name, wCsrVal);
+	DBG(4, "<== %s, txcsr %04x\n", musb_ep->end_point.name, wCsrVal);
 
-	dma = is_dma_capable() ? pEnd->dma : NULL;
+	dma = is_dma_capable() ? musb_ep->dma : NULL;
 	do {
 		/* REVISIT for high bandwidth, MGC_M_TXCSR_P_INCOMPTX
 		 * probably rates reporting as a host error
@@ -432,7 +432,7 @@ void musb_g_tx(struct musb *musb, u8 bEnd)
 			}
 
 			if (pRequest)
-				musb_g_giveback(pEnd, pRequest, -EPIPE);
+				musb_g_giveback(musb_ep, pRequest, -EPIPE);
 
 			break;
 		}
@@ -450,7 +450,7 @@ void musb_g_tx(struct musb *musb, u8 bEnd)
 			/* SHOULD NOT HAPPEN ... has with cppi though, after
 			 * changing SENDSTALL (and other cases); harmless?
 			 */
-			DBG(5, "%s dma still busy?\n", pEnd->end_point.name);
+			DBG(5, "%s dma still busy?\n", musb_ep->end_point.name);
 			break;
 		}
 
@@ -466,11 +466,11 @@ void musb_g_tx(struct musb *musb, u8 bEnd)
 				musb_writew(epio, MGC_O_HDRC_TXCSR, wCsrVal);
 				/* ensure writebuffer is empty */
 				wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
-				pRequest->actual += pEnd->dma->dwActualLength;
+				pRequest->actual += musb_ep->dma->dwActualLength;
 				DBG(4, "TXCSR%d %04x, dma off, "
 						"len %Zd, req %p\n",
 					bEnd, wCsrVal,
-					pEnd->dma->dwActualLength,
+					musb_ep->dma->dwActualLength,
 					pRequest);
 			}
 
@@ -483,13 +483,13 @@ void musb_g_tx(struct musb *musb, u8 bEnd)
 				if ((pRequest->zero
 						&& pRequest->length
 						&& (pRequest->length
-							% pEnd->wPacketSize)
+							% musb_ep->wPacketSize)
 							== 0)
 #ifdef CONFIG_USB_INVENTRA_DMA
 					|| (is_dma &&
 						((!dma->bDesiredMode) ||
 						    (pRequest->actual &
-						    (pEnd->wPacketSize - 1))))
+						    (musb_ep->wPacketSize - 1))))
 #endif
 				) {
 					/* on dma completion, fifo may not
@@ -506,7 +506,7 @@ void musb_g_tx(struct musb *musb, u8 bEnd)
 				}
 
 				/* ... or if not, then complete it */
-				musb_g_giveback(pEnd, pRequest, 0);
+				musb_g_giveback(musb_ep, pRequest, 0);
 
 				/* kickstart next transfer if appropriate;
 				 * the packet that just completed might not
@@ -518,12 +518,12 @@ void musb_g_tx(struct musb *musb, u8 bEnd)
 				wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
 				if (wCsrVal & MGC_M_TXCSR_FIFONOTEMPTY)
 					break;
-				pRequest = pEnd->desc
-						? next_request(pEnd)
+				pRequest = musb_ep->desc
+						? next_request(musb_ep)
 						: NULL;
 				if (!pRequest) {
 					DBG(4, "%s idle now\n",
-							pEnd->end_point.name);
+							musb_ep->end_point.name);
 					break;
 				}
 			}
@@ -575,16 +575,16 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	u16			wCsrVal = 0;
 	const u8		bEnd = req->bEnd;
 	struct usb_request	*pRequest = &req->request;
-	struct musb_ep		*pEnd = &musb->aLocalEnd[bEnd].ep_out;
+	struct musb_ep		*musb_ep = &musb->aLocalEnd[bEnd].ep_out;
 	void __iomem		*epio = musb->aLocalEnd[bEnd].regs;
 	u16			wFifoCount = 0;
-	u16			wCount = pEnd->wPacketSize;
+	u16			wCount = musb_ep->wPacketSize;
 
 	wCsrVal = musb_readw(epio, MGC_O_HDRC_RXCSR);
 
-	if (is_cppi_enabled() && pEnd->dma) {
+	if (is_cppi_enabled() && musb_ep->dma) {
 		struct dma_controller	*c = musb->pDmaController;
-		struct dma_channel	*channel = pEnd->dma;
+		struct dma_channel	*channel = musb_ep->dma;
 
 		/* NOTE:  CPPI won't actually stop advancing the DMA
 		 * queue after short packet transfers, so this is almost
@@ -592,7 +592,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 		 * faults will be handled correctly.
 		 */
 		if (c->channel_program(channel,
-				pEnd->wPacketSize,
+				musb_ep->wPacketSize,
 				!pRequest->short_not_ok,
 				pRequest->dma + pRequest->actual,
 				pRequest->length - pRequest->actual)) {
@@ -613,13 +613,13 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 		wCount = musb_readw(epio, MGC_O_HDRC_RXCOUNT);
 		if (pRequest->actual < pRequest->length) {
 #ifdef CONFIG_USB_INVENTRA_DMA
-			if (is_dma_capable() && pEnd->dma) {
+			if (is_dma_capable() && musb_ep->dma) {
 				struct dma_controller	*c;
 				struct dma_channel	*channel;
 				int			use_dma = 0;
 
 				c = musb->pDmaController;
-				channel = pEnd->dma;
+				channel = musb_ep->dma;
 
 	/* We use DMA Req mode 0 in RxCsr, and DMA controller operates in
 	 * mode 0 only. So we do not get endpoint interrupts due to DMA
@@ -665,14 +665,14 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 #else
 					transfer_size = wCount;
 #endif
-					if (transfer_size <= pEnd->wPacketSize)
-						pEnd->dma->bDesiredMode = 0;
+					if (transfer_size <= musb_ep->wPacketSize)
+						musb_ep->dma->bDesiredMode = 0;
 					else
-						pEnd->dma->bDesiredMode = 1;
+						musb_ep->dma->bDesiredMode = 1;
 
 					use_dma = c->channel_program(
 							channel,
-							pEnd->wPacketSize,
+							musb_ep->wPacketSize,
 							channel->bDesiredMode,
 							pRequest->dma
 							+ pRequest->actual,
@@ -686,21 +686,21 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 
 			wFifoCount = pRequest->length - pRequest->actual;
 			DBG(3, "%s OUT/RX pio fifo %d/%d, maxpacket %d\n",
-					pEnd->end_point.name,
+					musb_ep->end_point.name,
 					wCount, wFifoCount,
-					pEnd->wPacketSize);
+					musb_ep->wPacketSize);
 
 			wFifoCount = min(wCount, wFifoCount);
 
 #ifdef	CONFIG_USB_TUSB_OMAP_DMA
-			if (tusb_dma_omap() && pEnd->dma) {
+			if (tusb_dma_omap() && musb_ep->dma) {
 				struct dma_controller *c = musb->pDmaController;
-				struct dma_channel *channel = pEnd->dma;
+				struct dma_channel *channel = musb_ep->dma;
 				u32 dma_addr = pRequest->dma + pRequest->actual;
 				int ret;
 
 				ret = c->channel_program(channel,
-						pEnd->wPacketSize,
+						musb_ep->wPacketSize,
 						channel->bDesiredMode,
 						dma_addr,
 						wFifoCount);
@@ -709,7 +709,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 			}
 #endif
 
-			musb_read_fifo(pEnd->hw_ep, wFifoCount, (u8 *)
+			musb_read_fifo(musb_ep->hw_ep, wFifoCount, (u8 *)
 					(pRequest->buf + pRequest->actual));
 			pRequest->actual += wFifoCount;
 
@@ -725,8 +725,8 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	}
 
 	/* reach the end or short packet detected */
-	if (pRequest->actual == pRequest->length || wCount < pEnd->wPacketSize)
-		musb_g_giveback(pEnd, pRequest, 0);
+	if (pRequest->actual == pRequest->length || wCount < musb_ep->wPacketSize)
+		musb_g_giveback(musb_ep, pRequest, 0);
 }
 
 /*
@@ -737,25 +737,25 @@ void musb_g_rx(struct musb *musb, u8 bEnd)
 	u16			wCsrVal;
 	struct usb_request	*pRequest;
 	void __iomem		*pBase = musb->pRegs;
-	struct musb_ep		*pEnd = &musb->aLocalEnd[bEnd].ep_out;
+	struct musb_ep		*musb_ep = &musb->aLocalEnd[bEnd].ep_out;
 	void __iomem		*epio = musb->aLocalEnd[bEnd].regs;
 	struct dma_channel	*dma;
 
 	MGC_SelectEnd(pBase, bEnd);
 
-	pRequest = next_request(pEnd);
+	pRequest = next_request(musb_ep);
 
 	wCsrVal = musb_readw(epio, MGC_O_HDRC_RXCSR);
-	dma = is_dma_capable() ? pEnd->dma : NULL;
+	dma = is_dma_capable() ? musb_ep->dma : NULL;
 
-	DBG(4, "<== %s, rxcsr %04x%s %p\n", pEnd->end_point.name,
+	DBG(4, "<== %s, rxcsr %04x%s %p\n", musb_ep->end_point.name,
 			wCsrVal, dma ? " (dma)" : "", pRequest);
 
 	if (wCsrVal & MGC_M_RXCSR_P_SENTSTALL) {
 		if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
 			dma->bStatus = MGC_DMA_STATUS_CORE_ABORT;
 			(void) musb->pDmaController->channel_abort(dma);
-			pRequest->actual += pEnd->dma->dwActualLength;
+			pRequest->actual += musb_ep->dma->dwActualLength;
 		}
 
 		wCsrVal |= MGC_M_RXCSR_P_WZC_BITS;
@@ -763,7 +763,7 @@ void musb_g_rx(struct musb *musb, u8 bEnd)
 		musb_writew(epio, MGC_O_HDRC_RXCSR, wCsrVal);
 
 		if (pRequest)
-			musb_g_giveback(pEnd, pRequest, -EPIPE);
+			musb_g_giveback(musb_ep, pRequest, -EPIPE);
 		goto done;
 	}
 
@@ -772,20 +772,20 @@ void musb_g_rx(struct musb *musb, u8 bEnd)
 		wCsrVal &= ~MGC_M_RXCSR_P_OVERRUN;
 		musb_writew(epio, MGC_O_HDRC_RXCSR, wCsrVal);
 
-		DBG(3, "%s iso overrun on %p\n", pEnd->name, pRequest);
+		DBG(3, "%s iso overrun on %p\n", musb_ep->name, pRequest);
 		if (pRequest && pRequest->status == -EINPROGRESS)
 			pRequest->status = -EOVERFLOW;
 	}
 	if (wCsrVal & MGC_M_RXCSR_INCOMPRX) {
 		/* REVISIT not necessarily an error */
-		DBG(4, "%s, incomprx\n", pEnd->end_point.name);
+		DBG(4, "%s, incomprx\n", musb_ep->end_point.name);
 	}
 
 	if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
 		/* "should not happen"; likely RXPKTRDY pending for DMA */
 		DBG((wCsrVal & MGC_M_RXCSR_DMAENAB) ? 4 : 1,
 			"%s busy, csr %04x\n",
-			pEnd->end_point.name, wCsrVal);
+			musb_ep->end_point.name, wCsrVal);
 		goto done;
 	}
 
@@ -796,18 +796,18 @@ void musb_g_rx(struct musb *musb, u8 bEnd)
 		musb_writew(epio, MGC_O_HDRC_RXCSR,
 			MGC_M_RXCSR_P_WZC_BITS | wCsrVal);
 
-		pRequest->actual += pEnd->dma->dwActualLength;
+		pRequest->actual += musb_ep->dma->dwActualLength;
 
 		DBG(4, "RXCSR%d %04x, dma off, %04x, len %Zd, req %p\n",
 			bEnd, wCsrVal,
 			musb_readw(epio, MGC_O_HDRC_RXCSR),
-			pEnd->dma->dwActualLength, pRequest);
+			musb_ep->dma->dwActualLength, pRequest);
 
 #if defined(CONFIG_USB_INVENTRA_DMA) || defined(CONFIG_USB_TUSB_OMAP_DMA)
 		/* Autoclear doesn't clear RxPktRdy for short packets */
 		if ((dma->bDesiredMode == 0)
 				|| (dma->dwActualLength
-					& (pEnd->wPacketSize - 1))) {
+					& (musb_ep->wPacketSize - 1))) {
 			/* ack the read! */
 			wCsrVal &= ~MGC_M_RXCSR_RXPKTRDY;
 			musb_writew(epio, MGC_O_HDRC_RXCSR, wCsrVal);
@@ -815,13 +815,13 @@ void musb_g_rx(struct musb *musb, u8 bEnd)
 
 		/* incomplete, and not short? wait for next IN packet */
                 if ((pRequest->actual < pRequest->length)
-				&& (pEnd->dma->dwActualLength
-					== pEnd->wPacketSize))
+				&& (musb_ep->dma->dwActualLength
+					== musb_ep->wPacketSize))
 			goto done;
 #endif
-		musb_g_giveback(pEnd, pRequest, 0);
+		musb_g_giveback(musb_ep, pRequest, 0);
 
-		pRequest = next_request(pEnd);
+		pRequest = next_request(musb_ep);
 		if (!pRequest)
 			goto done;
 
@@ -838,8 +838,8 @@ void musb_g_rx(struct musb *musb, u8 bEnd)
 		rxstate(musb, to_musb_request(pRequest));
 	else
 		DBG(3, "packet waiting for %s%s request\n",
-				pEnd->desc ? "" : "inactive ",
-				pEnd->end_point.name);
+				musb_ep->desc ? "" : "inactive ",
+				musb_ep->end_point.name);
 
 done:
 	return;
@@ -851,7 +851,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 			const struct usb_endpoint_descriptor *desc)
 {
 	unsigned long		flags;
-	struct musb_ep		*pEnd;
+	struct musb_ep		*musb_ep;
 	struct musb_hw_ep	*hw_ep;
 	void __iomem		*regs;
 	struct musb		*musb;
@@ -864,20 +864,20 @@ static int musb_gadget_enable(struct usb_ep *ep,
 	if (!ep || !desc)
 		return -EINVAL;
 
-	pEnd = to_musb_ep(ep);
-	hw_ep = pEnd->hw_ep;
+	musb_ep = to_musb_ep(ep);
+	hw_ep = musb_ep->hw_ep;
 	regs = hw_ep->regs;
-	musb = pEnd->musb;
+	musb = musb_ep->musb;
 	pBase = musb->pRegs;
-	bEnd = pEnd->bEndNumber;
+	bEnd = musb_ep->bEndNumber;
 
 	spin_lock_irqsave(&musb->Lock, flags);
 
-	if (pEnd->desc) {
+	if (musb_ep->desc) {
 		status = -EBUSY;
 		goto fail;
 	}
-	pEnd->type = desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK;
+	musb_ep->type = desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK;
 
 	/* check direction and (later) maxpacket size against endpoint */
 	if ((desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK) != bEnd)
@@ -887,7 +887,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 	tmp = le16_to_cpu(desc->wMaxPacketSize);
 	if (tmp & ~0x07ff)
 		goto fail;
-	pEnd->wPacketSize = tmp;
+	musb_ep->wPacketSize = tmp;
 
 	/* enable the interrupts for the endpoint, set the endpoint
 	 * packet size (or fail), set the mode, clear the fifo
@@ -897,8 +897,8 @@ static int musb_gadget_enable(struct usb_ep *ep,
 		u16 wIntrTxE = musb_readw(pBase, MGC_O_HDRC_INTRTXE);
 
 		if (hw_ep->bIsSharedFifo)
-			pEnd->is_in = 1;
-		if (!pEnd->is_in)
+			musb_ep->is_in = 1;
+		if (!musb_ep->is_in)
 			goto fail;
 		if (tmp > hw_ep->wMaxPacketSizeTx)
 			goto fail;
@@ -915,7 +915,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 		if (musb_readw(regs, MGC_O_HDRC_TXCSR)
 				& MGC_M_TXCSR_FIFONOTEMPTY)
 			csr |= MGC_M_TXCSR_FLUSHFIFO;
-		if (pEnd->type == USB_ENDPOINT_XFER_ISOC)
+		if (musb_ep->type == USB_ENDPOINT_XFER_ISOC)
 			csr |= MGC_M_TXCSR_P_ISO;
 
 		/* set twice in case of double buffering */
@@ -927,8 +927,8 @@ static int musb_gadget_enable(struct usb_ep *ep,
 		u16 wIntrRxE = musb_readw(pBase, MGC_O_HDRC_INTRRXE);
 
 		if (hw_ep->bIsSharedFifo)
-			pEnd->is_in = 0;
-		if (pEnd->is_in)
+			musb_ep->is_in = 0;
+		if (musb_ep->is_in)
 			goto fail;
 		if (tmp > hw_ep->wMaxPacketSizeRx)
 			goto fail;
@@ -949,9 +949,9 @@ static int musb_gadget_enable(struct usb_ep *ep,
 		}
 
 		csr = MGC_M_RXCSR_FLUSHFIFO | MGC_M_RXCSR_CLRDATATOG;
-		if (pEnd->type == USB_ENDPOINT_XFER_ISOC)
+		if (musb_ep->type == USB_ENDPOINT_XFER_ISOC)
 			csr |= MGC_M_RXCSR_P_ISO;
-		else if (pEnd->type == USB_ENDPOINT_XFER_INT)
+		else if (musb_ep->type == USB_ENDPOINT_XFER_INT)
 			csr |= MGC_M_RXCSR_DISNYET;
 
 		/* set twice in case of double buffering */
@@ -965,25 +965,25 @@ static int musb_gadget_enable(struct usb_ep *ep,
 	if (is_dma_capable() && musb->pDmaController) {
 		struct dma_controller	*c = musb->pDmaController;
 
-		pEnd->dma = c->channel_alloc(c, hw_ep,
+		musb_ep->dma = c->channel_alloc(c, hw_ep,
 				(desc->bEndpointAddress & USB_DIR_IN));
 	} else
-		pEnd->dma = NULL;
+		musb_ep->dma = NULL;
 
-	pEnd->desc = desc;
-	pEnd->busy = 0;
+	musb_ep->desc = desc;
+	musb_ep->busy = 0;
 	status = 0;
 
 	pr_debug("%s periph: enabled %s for %s %s, %smaxpacket %d\n",
-			musb_driver_name, pEnd->end_point.name,
-			({ char *s; switch (pEnd->type) {
+			musb_driver_name, musb_ep->end_point.name,
+			({ char *s; switch (musb_ep->type) {
 			case USB_ENDPOINT_XFER_BULK:	s = "bulk"; break;
 			case USB_ENDPOINT_XFER_INT:	s = "int"; break;
 			default:			s = "iso"; break;
 			}; s; }),
-			pEnd->is_in ? "IN" : "OUT",
-			pEnd->dma ? "dma, " : "",
-			pEnd->wPacketSize);
+			musb_ep->is_in ? "IN" : "OUT",
+			musb_ep->dma ? "dma, " : "",
+			musb_ep->wPacketSize);
 
 	schedule_work(&musb->irq_work);
 
@@ -1000,20 +1000,20 @@ static int musb_gadget_disable(struct usb_ep *ep)
 	unsigned long	flags;
 	struct musb	*musb;
 	u8		bEnd;
-	struct musb_ep	*pEnd;
+	struct musb_ep	*musb_ep;
 	void __iomem	*epio;
 	int		status = 0;
 
-	pEnd = to_musb_ep(ep);
-	musb = pEnd->musb;
-	bEnd = pEnd->bEndNumber;
+	musb_ep = to_musb_ep(ep);
+	musb = musb_ep->musb;
+	bEnd = musb_ep->bEndNumber;
 	epio = musb->aLocalEnd[bEnd].regs;
 
 	spin_lock_irqsave(&musb->Lock, flags);
 	MGC_SelectEnd(musb->pRegs, bEnd);
 
 	/* zero the endpoint sizes */
-	if (pEnd->is_in) {
+	if (musb_ep->is_in) {
 		u16 wIntrTxE = musb_readw(musb->pRegs, MGC_O_HDRC_INTRTXE);
 		wIntrTxE &= ~(1 << bEnd);
 		musb_writew(musb->pRegs, MGC_O_HDRC_INTRTXE, wIntrTxE);
@@ -1025,16 +1025,16 @@ static int musb_gadget_disable(struct usb_ep *ep)
 		musb_writew(epio, MGC_O_HDRC_RXMAXP, 0);
 	}
 
-	pEnd->desc = NULL;
+	musb_ep->desc = NULL;
 
 	/* abort all pending DMA and requests */
-	nuke(pEnd, -ESHUTDOWN);
+	nuke(musb_ep, -ESHUTDOWN);
 
 	schedule_work(&musb->irq_work);
 
 	spin_unlock_irqrestore(&(musb->Lock), flags);
 
-	DBG(2, "%s\n", pEnd->end_point.name);
+	DBG(2, "%s\n", musb_ep->end_point.name);
 
 	return status;
 }
@@ -1096,7 +1096,7 @@ static void musb_ep_restart(struct musb *musb, struct musb_request *req)
 static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 			gfp_t gfp_flags)
 {
-	struct musb_ep		*pEnd;
+	struct musb_ep		*musb_ep;
 	struct musb_request	*pRequest;
 	struct musb		*musb;
 	int			status = 0;
@@ -1107,13 +1107,13 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 	if (!req->buf)
 		return -ENODATA;
 
-	pEnd = to_musb_ep(ep);
-	musb = pEnd->musb;
+	musb_ep = to_musb_ep(ep);
+	musb = musb_ep->musb;
 
 	pRequest = to_musb_request(req);
 	pRequest->musb = musb;
 
-	if (pRequest->ep != pEnd)
+	if (pRequest->ep != musb_ep)
 		return -EINVAL;
 
 	DBG(4, "<== to %s request=%p\n", ep->name, req);
@@ -1121,10 +1121,10 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 	/* request is mine now... */
 	pRequest->request.actual = 0;
 	pRequest->request.status = -EINPROGRESS;
-	pRequest->bEnd = pEnd->bEndNumber;
-	pRequest->bTx = pEnd->is_in;
+	pRequest->bEnd = musb_ep->bEndNumber;
+	pRequest->bTx = musb_ep->is_in;
 
-	if (is_dma_capable() && pEnd->dma) {
+	if (is_dma_capable() && musb_ep->dma) {
 		if (pRequest->request.dma == DMA_ADDR_INVALID) {
 			pRequest->request.dma = dma_map_single(
 					musb->controller,
@@ -1151,7 +1151,7 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 	spin_lock_irqsave(&musb->Lock, lockflags);
 
 	/* don't queue if the ep is down */
-	if (!pEnd->desc) {
+	if (!musb_ep->desc) {
 		DBG(4, "req %p queued to %s while ep %s\n",
 				req, ep->name, "disabled");
 		status = -ESHUTDOWN;
@@ -1159,10 +1159,10 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 	}
 
 	/* add pRequest to the list */
-	list_add_tail(&(pRequest->request.list), &(pEnd->req_list));
+	list_add_tail(&(pRequest->request.list), &(musb_ep->req_list));
 
 	/* it this is the head of the queue, start i/o ... */
-	if (!pEnd->busy && &pRequest->request.list == pEnd->req_list.next)
+	if (!musb_ep->busy && &pRequest->request.list == musb_ep->req_list.next)
 		musb_ep_restart(musb, pRequest);
 
 cleanup:
@@ -1172,18 +1172,18 @@ cleanup:
 
 static int musb_gadget_dequeue(struct usb_ep *ep, struct usb_request *pRequest)
 {
-	struct musb_ep		*pEnd = to_musb_ep(ep);
+	struct musb_ep		*musb_ep = to_musb_ep(ep);
 	struct usb_request	*r;
 	unsigned long		flags;
 	int			status = 0;
-	struct musb		*musb = pEnd->musb;
+	struct musb		*musb = musb_ep->musb;
 
-	if (!ep || !pRequest || to_musb_request(pRequest)->ep != pEnd)
+	if (!ep || !pRequest || to_musb_request(pRequest)->ep != musb_ep)
 		return -EINVAL;
 
 	spin_lock_irqsave(&musb->Lock, flags);
 
-	list_for_each_entry(r, &pEnd->req_list, list) {
+	list_for_each_entry(r, &musb_ep->req_list, list) {
 		if (r == pRequest)
 			break;
 	}
@@ -1194,25 +1194,25 @@ static int musb_gadget_dequeue(struct usb_ep *ep, struct usb_request *pRequest)
 	}
 
 	/* if the hardware doesn't have the request, easy ... */
-	if (pEnd->req_list.next != &pRequest->list || pEnd->busy)
-		musb_g_giveback(pEnd, pRequest, -ECONNRESET);
+	if (musb_ep->req_list.next != &pRequest->list || musb_ep->busy)
+		musb_g_giveback(musb_ep, pRequest, -ECONNRESET);
 
 	/* ... else abort the dma transfer ... */
-	else if (is_dma_capable() && pEnd->dma) {
+	else if (is_dma_capable() && musb_ep->dma) {
 		struct dma_controller	*c = musb->pDmaController;
 
-		MGC_SelectEnd(musb->pRegs, pEnd->bEndNumber);
+		MGC_SelectEnd(musb->pRegs, musb_ep->bEndNumber);
 		if (c->channel_abort)
-			status = c->channel_abort(pEnd->dma);
+			status = c->channel_abort(musb_ep->dma);
 		else
 			status = -EBUSY;
 		if (status == 0)
-			musb_g_giveback(pEnd, pRequest, -ECONNRESET);
+			musb_g_giveback(musb_ep, pRequest, -ECONNRESET);
 	} else {
 		/* NOTE: by sticking to easily tested hardware/driver states,
 		 * we leave counting of in-flight packets imprecise.
 		 */
-		musb_g_giveback(pEnd, pRequest, -ECONNRESET);
+		musb_g_giveback(musb_ep, pRequest, -ECONNRESET);
 	}
 
 done:
@@ -1228,9 +1228,9 @@ done:
  */
 int musb_gadget_set_halt(struct usb_ep *ep, int value)
 {
-	struct musb_ep		*pEnd = to_musb_ep(ep);
-	u8			bEnd = pEnd->bEndNumber;
-	struct musb		*musb = pEnd->musb;
+	struct musb_ep		*musb_ep = to_musb_ep(ep);
+	u8			bEnd = musb_ep->bEndNumber;
+	struct musb		*musb = musb_ep->musb;
 	void __iomem		*epio = musb->aLocalEnd[bEnd].regs;
 	void __iomem		*pBase;
 	unsigned long		flags;
@@ -1244,7 +1244,7 @@ int musb_gadget_set_halt(struct usb_ep *ep, int value)
 
 	spin_lock_irqsave(&musb->Lock, flags);
 
-	if ((USB_ENDPOINT_XFER_ISOC == pEnd->type)) {
+	if ((USB_ENDPOINT_XFER_ISOC == musb_ep->type)) {
 		status = -EINVAL;
 		goto done;
 	}
@@ -1252,8 +1252,8 @@ int musb_gadget_set_halt(struct usb_ep *ep, int value)
 	MGC_SelectEnd(pBase, bEnd);
 
 	/* cannot portably stall with non-empty FIFO */
-	pRequest = to_musb_request(next_request(pEnd));
-	if (value && pEnd->is_in) {
+	pRequest = to_musb_request(next_request(musb_ep));
+	if (value && musb_ep->is_in) {
 		wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
 		if (wCsr & MGC_M_TXCSR_FIFONOTEMPTY) {
 			DBG(3, "%s fifo busy, cannot halt\n", ep->name);
@@ -1265,7 +1265,7 @@ int musb_gadget_set_halt(struct usb_ep *ep, int value)
 
 	/* set/clear the stall and toggle bits */
 	DBG(2, "%s: %s stall\n", ep->name, value ? "set" : "clear");
-	if (pEnd->is_in) {
+	if (musb_ep->is_in) {
 		wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
 		if (wCsr & MGC_M_TXCSR_FIFONOTEMPTY)
 			wCsr |= MGC_M_TXCSR_FLUSHFIFO;
@@ -1294,7 +1294,7 @@ int musb_gadget_set_halt(struct usb_ep *ep, int value)
 done:
 
 	/* maybe start the first request in the queue */
-	if (!pEnd->busy && !value && pRequest) {
+	if (!musb_ep->busy && !value && pRequest) {
 		DBG(3, "restarting the request\n");
 		musb_ep_restart(musb, pRequest);
 	}
-- 
1.5.2.3
