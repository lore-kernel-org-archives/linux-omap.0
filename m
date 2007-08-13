From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 48/52] musb_hdrc: Search and replace pRequest with request
Date: Mon, 13 Aug 2007 06:49:23 -0700
Message-ID: <11870130953685-git-send-email-tony@atomide.com>
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
	<11870129934099-git-send-email-tony@atomide.com>
	<1187012995338-git-send-email-tony@atomide.com>
	<1187012998290-git-send-email-tony@atomide.com>
	<1187013000811-git-send-email-tony@atomide.com>
	<11870130023665-git-send-email-tony@atomide.com>
	<11870130052666-git-send-email-tony@atomide.com>
	<1187013007355-git-send-email-tony@atomide.com>
	<11870130103320-git-send-email-tony@atomide.com>
	<11870130122117-git-send-email-tony@atomide.com>
	<11870130153038-git-send-email-tony@atomide.com>
	<11870130183634-git-send-email-tony@atomide.com>
	<11870130203742-git-send-email-tony@atomide.com>
	<1187013022688-git-send-email-tony@atomide.com>
	<1187013024836-git-send-email-tony@atomide.com>
	<11870130272865-git-send-email-tony@atomide.com>
	<1187013029823-git-send-email-tony@atomide.com>
	<11870130314189-git-send-email-tony@atomide.com>
	<11870130343298-git-send-email-tony@atomide.com>
	<11870130371106-git-send-email-tony@atomide.com>
	<11870130411622-git-send-email-tony@atomide.com>
	<1187013048432-git-send-email-tony@atomide.com>
	<11870130521115-git-send-email-tony@atomide.com>
	<11870130543254-git-send-email-tony@atomide.com>
	<11870130573814-git-send-email-tony@atomide.com>
	<1187013062890-git-send-email-tony@atomide.com>
	<11870130643220-git-send-email-tony@atomide.com>
	<1187013066263-git-send-email-tony@atomide.com>
	<11870130701028-git-send-email-tony@atomide.com>
	<1187013072449-git-send-email-tony@atomide.com>
	<11870130741506-git-send-email-tony@atomide.com>
	<11870130771666-git-send-email-tony@atomide.com>
	<11870130793168-git-send-email-tony@atomide.com>
	<11870130811602-git-send-email-tony@atomide.com>
	<1187013084570-git-send-email-tony@atomide.com>
	<11870130862981-git-send-email-tony@atomide.com>
	<11870130891386-git-send-email-tony@atomide.com>
	<11870130913983-git-send-email-tony@atomide.com>
	<11870130932989-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11870130932989-git-send-email-tony@atomide.com>
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

Search and replace pRequest with request

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/g_ep0.c       |   18 ++--
 drivers/usb/musb/musb_gadget.c |  234 ++++++++++++++++++++--------------------
 drivers/usb/musb/musb_host.c   |    8 +-
 3 files changed, 130 insertions(+), 130 deletions(-)

--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -484,31 +484,31 @@ static void ep0_rxstate(struct musb *this)
 static void ep0_txstate(struct musb *musb)
 {
 	void __iomem		*regs = musb->control_ep->regs;
-	struct usb_request	*pRequest = next_ep0_request(musb);
+	struct usb_request	*request = next_ep0_request(musb);
 	u16			wCsrVal = MGC_M_CSR0_TXPKTRDY;
 	u8			*pFifoSource;
 	u8			fifo_count;
 
-	if (!pRequest) {
+	if (!request) {
 		// WARN_ON(1);
 		DBG(2, "odd; csr0 %04x\n", musb_readw(regs, MGC_O_HDRC_CSR0));
 		return;
 	}
 
 	/* load the data */
-	pFifoSource = (u8 *) pRequest->buf + pRequest->actual;
+	pFifoSource = (u8 *) request->buf + request->actual;
 	fifo_count = min((unsigned) MGC_END0_FIFOSIZE,
-		pRequest->length - pRequest->actual);
+		request->length - request->actual);
 	musb_write_fifo(&musb->endpoints[0], fifo_count, pFifoSource);
-	pRequest->actual += fifo_count;
+	request->actual += fifo_count;
 
 	/* update the flags */
 	if (fifo_count < MUSB_MAX_END0_PACKET
-			|| pRequest->actual == pRequest->length) {
+			|| request->actual == request->length) {
 		musb->ep0_state = MGC_END0_STAGE_STATUSOUT;
 		wCsrVal |= MGC_M_CSR0_P_DATAEND;
 	} else
-		pRequest = NULL;
+		request = NULL;
 
 	/* send it out, triggering a "txpktrdy cleared" irq */
 	musb_writew(regs, MGC_O_HDRC_CSR0, wCsrVal);
@@ -518,8 +518,8 @@ static void ep0_txstate(struct musb *musb)
 	 * very precise fault reporting, needed by USB TMC; possible with
 	 * this hardware, but not usable from portable gadget drivers.)
 	 */
-	if (pRequest)
-		musb_g_ep0_giveback(musb, pRequest);
+	if (request)
+		musb_g_ep0_giveback(musb, request);
 }
 
 /*
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -94,13 +94,13 @@ Handling completion
 /*
  * Immediately complete a request.
  *
- * @param pRequest the request to complete
+ * @param request the request to complete
  * @param status the status to complete the request with
  * Context: controller locked, IRQs blocked.
  */
 void musb_g_giveback(
 	struct musb_ep		*ep,
-	struct usb_request	*pRequest,
+	struct usb_request	*request,
 	int status)
 __releases(ep->musb->lock)
 __acquires(ep->musb->lock)
@@ -109,9 +109,9 @@ __acquires(ep->musb->lock)
 	struct musb		*musb;
 	int			busy = ep->busy;
 
-	req = to_musb_request(pRequest);
+	req = to_musb_request(request);
 
-	list_del(&pRequest->list);
+	list_del(&request->list);
 	if (req->request.status == -EINPROGRESS)
 		req->request.status = status;
 	musb = req->musb;
@@ -136,15 +136,15 @@ __acquires(ep->musb->lock)
 						? DMA_TO_DEVICE
 						: DMA_FROM_DEVICE);
 	}
-	if (pRequest->status == 0)
+	if (request->status == 0)
 		DBG(5, "%s done request %p,  %d/%d\n",
-				ep->end_point.name, pRequest,
+				ep->end_point.name, request,
 				req->request.actual, req->request.length);
 	else
 		DBG(2, "%s request %p, %d/%d fault %d\n",
-				ep->end_point.name, pRequest,
+				ep->end_point.name, request,
 				req->request.actual, req->request.length,
-				pRequest->status);
+				request->status);
 	req->request.complete(&req->ep->end_point, &req->request);
 	spin_lock(&musb->lock);
 	ep->busy = busy;
@@ -255,7 +255,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 	u8			epnum = req->epnum;
 	struct musb_ep		*musb_ep;
 	void __iomem		*epio = musb->endpoints[epnum].regs;
-	struct usb_request	*pRequest;
+	struct usb_request	*request;
 	u16			fifo_count = 0, wCsrVal;
 	int			use_dma = 0;
 
@@ -270,9 +270,9 @@ static void txstate(struct musb *musb, struct musb_request *req)
 	/* read TXCSR before */
 	wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
 
-	pRequest = &req->request;
+	request = &req->request;
 	fifo_count = min(max_ep_writesize(musb, musb_ep),
-			(int)(pRequest->length - pRequest->actual));
+			(int)(request->length - request->actual));
 
 	if (wCsrVal & MGC_M_TXCSR_TXPKTRDY) {
 		DBG(5, "%s old packet still ready , txcsr %03x\n",
@@ -294,7 +294,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 	if (is_dma_capable() && musb_ep->dma) {
 		struct dma_controller	*c = musb->dma_controller;
 
-		use_dma = (pRequest->dma != DMA_ADDR_INVALID);
+		use_dma = (request->dma != DMA_ADDR_INVALID);
 
 		/* MGC_M_TXCSR_P_ISO is still set correctly */
 
@@ -303,7 +303,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 			size_t request_size;
 
 			/* setup DMA, then program endpoint CSR */
-			request_size = min(pRequest->length,
+			request_size = min(request->length,
 						musb_ep->dma->max_len);
 			if (request_size <= musb_ep->wPacketSize)
 				musb_ep->dma->desired_mode = 0;
@@ -313,7 +313,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 			use_dma = use_dma && c->channel_program(
 					musb_ep->dma, musb_ep->wPacketSize,
 					musb_ep->dma->desired_mode,
-					pRequest->dma, request_size);
+					request->dma, request_size);
 			if (use_dma) {
 				if (musb_ep->dma->desired_mode == 0) {
 					/* ASSERT: DMAENAB is clear */
@@ -361,8 +361,8 @@ static void txstate(struct musb *musb, struct musb_request *req)
 		use_dma = use_dma && c->channel_program(
 				musb_ep->dma, musb_ep->wPacketSize,
 				0,
-				pRequest->dma,
-				pRequest->length);
+				request->dma,
+				request->length);
 		if (!use_dma) {
 			c->channel_release(musb_ep->dma);
 			musb_ep->dma = NULL;
@@ -373,17 +373,17 @@ static void txstate(struct musb *musb, struct musb_request *req)
 #elif defined(CONFIG_USB_TUSB_OMAP_DMA)
 		use_dma = use_dma && c->channel_program(
 				musb_ep->dma, musb_ep->wPacketSize,
-				pRequest->zero,
-				pRequest->dma,
-				pRequest->length);
+				request->zero,
+				request->dma,
+				request->length);
 #endif
 	}
 #endif
 
 	if (!use_dma) {
 		musb_write_fifo(musb_ep->hw_ep, fifo_count,
-				(u8 *) (pRequest->buf + pRequest->actual));
-		pRequest->actual += fifo_count;
+				(u8 *) (request->buf + request->actual));
+		request->actual += fifo_count;
 		wCsrVal |= MGC_M_TXCSR_TXPKTRDY;
 		wCsrVal &= ~MGC_M_TXCSR_P_UNDERRUN;
 		musb_writew(epio, MGC_O_HDRC_TXCSR, wCsrVal);
@@ -392,7 +392,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 	/* host may already have the data when this message shows... */
 	DBG(3, "%s TX/IN %s len %d/%d, txcsr %04x, fifo %d/%d\n",
 			musb_ep->end_point.name, use_dma ? "dma" : "pio",
-			pRequest->actual, pRequest->length,
+			request->actual, request->length,
 			musb_readw(epio, MGC_O_HDRC_TXCSR),
 			fifo_count,
 			musb_readw(epio, MGC_O_HDRC_TXMAXP));
@@ -405,14 +405,14 @@ static void txstate(struct musb *musb, struct musb_request *req)
 void musb_g_tx(struct musb *musb, u8 epnum)
 {
 	u16			wCsrVal;
-	struct usb_request	*pRequest;
+	struct usb_request	*request;
 	u8 __iomem		*mbase = musb->mregs;
 	struct musb_ep		*musb_ep = &musb->endpoints[epnum].ep_in;
 	void __iomem		*epio = musb->endpoints[epnum].regs;
 	struct dma_channel	*dma;
 
 	musb_ep_select(mbase, epnum);
-	pRequest = next_request(musb_ep);
+	request = next_request(musb_ep);
 
 	wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
 	DBG(4, "<== %s, txcsr %04x\n", musb_ep->end_point.name, wCsrVal);
@@ -431,8 +431,8 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 				musb->dma_controller->channel_abort(dma);
 			}
 
-			if (pRequest)
-				musb_g_giveback(musb_ep, pRequest, -EPIPE);
+			if (request)
+				musb_g_giveback(musb_ep, request, -EPIPE);
 
 			break;
 		}
@@ -443,7 +443,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 			wCsrVal &= ~(MGC_M_TXCSR_P_UNDERRUN
 					| MGC_M_TXCSR_TXPKTRDY);
 			musb_writew(epio, MGC_O_HDRC_TXCSR, wCsrVal);
-			DBG(20, "underrun on ep%d, req %p\n", epnum, pRequest);
+			DBG(20, "underrun on ep%d, req %p\n", epnum, request);
 		}
 
 		if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
@@ -454,7 +454,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 			break;
 		}
 
-		if (pRequest) {
+		if (request) {
 			u8	is_dma = 0;
 
 			if (dma && (wCsrVal & MGC_M_TXCSR_DMAENAB)) {
@@ -466,29 +466,29 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 				musb_writew(epio, MGC_O_HDRC_TXCSR, wCsrVal);
 				/* ensure writebuffer is empty */
 				wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
-				pRequest->actual += musb_ep->dma->actual_len;
+				request->actual += musb_ep->dma->actual_len;
 				DBG(4, "TXCSR%d %04x, dma off, "
 						"len %Zd, req %p\n",
 					epnum, wCsrVal,
 					musb_ep->dma->actual_len,
-					pRequest);
+					request);
 			}
 
-			if (is_dma || pRequest->actual == pRequest->length) {
+			if (is_dma || request->actual == request->length) {
 
 				/* First, maybe a terminating short packet.
 				 * Some DMA engines might handle this by
 				 * themselves.
 				 */
-				if ((pRequest->zero
-						&& pRequest->length
-						&& (pRequest->length
+				if ((request->zero
+						&& request->length
+						&& (request->length
 							% musb_ep->wPacketSize)
 							== 0)
 #ifdef CONFIG_USB_INVENTRA_DMA
 					|| (is_dma &&
 						((!dma->desired_mode) ||
-						    (pRequest->actual &
+						    (request->actual &
 						    (musb_ep->wPacketSize - 1))))
 #endif
 				) {
@@ -502,11 +502,11 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 					musb_writew(epio, MGC_O_HDRC_TXCSR,
 							MGC_M_TXCSR_MODE
 							| MGC_M_TXCSR_TXPKTRDY);
-					pRequest->zero = 0;
+					request->zero = 0;
 				}
 
 				/* ... or if not, then complete it */
-				musb_g_giveback(musb_ep, pRequest, 0);
+				musb_g_giveback(musb_ep, request, 0);
 
 				/* kickstart next transfer if appropriate;
 				 * the packet that just completed might not
@@ -518,17 +518,17 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 				wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
 				if (wCsrVal & MGC_M_TXCSR_FIFONOTEMPTY)
 					break;
-				pRequest = musb_ep->desc
+				request = musb_ep->desc
 						? next_request(musb_ep)
 						: NULL;
-				if (!pRequest) {
+				if (!request) {
 					DBG(4, "%s idle now\n",
 							musb_ep->end_point.name);
 					break;
 				}
 			}
 
-			txstate(musb, to_musb_request(pRequest));
+			txstate(musb, to_musb_request(request));
 		}
 
 	} while (0);
@@ -574,7 +574,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 {
 	u16			wCsrVal = 0;
 	const u8		epnum = req->epnum;
-	struct usb_request	*pRequest = &req->request;
+	struct usb_request	*request = &req->request;
 	struct musb_ep		*musb_ep = &musb->endpoints[epnum].ep_out;
 	void __iomem		*epio = musb->endpoints[epnum].regs;
 	u16			fifo_count = 0;
@@ -593,9 +593,9 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 		 */
 		if (c->channel_program(channel,
 				musb_ep->wPacketSize,
-				!pRequest->short_not_ok,
-				pRequest->dma + pRequest->actual,
-				pRequest->length - pRequest->actual)) {
+				!request->short_not_ok,
+				request->dma + request->actual,
+				request->length - request->actual)) {
 
 			/* make sure that if an rxpkt arrived after the irq,
 			 * the cppi engine will be ready to take it as soon
@@ -611,7 +611,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 
 	if (wCsrVal & MGC_M_RXCSR_RXPKTRDY) {
 		len = musb_readw(epio, MGC_O_HDRC_RXCOUNT);
-		if (pRequest->actual < pRequest->length) {
+		if (request->actual < request->length) {
 #ifdef CONFIG_USB_INVENTRA_DMA
 			if (is_dma_capable() && musb_ep->dma) {
 				struct dma_controller	*c;
@@ -657,10 +657,10 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 				musb_writew(epio, MGC_O_HDRC_RXCSR,
 						wCsrVal);
 
-				if (pRequest->actual < pRequest->length) {
+				if (request->actual < request->length) {
 					int transfer_size = 0;
 #ifdef USE_MODE1
-					transfer_size = min(pRequest->length,
+					transfer_size = min(request->length,
 							channel->max_len);
 #else
 					transfer_size = len;
@@ -674,8 +674,8 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 							channel,
 							musb_ep->wPacketSize,
 							channel->desired_mode,
-							pRequest->dma
-							+ pRequest->actual,
+							request->dma
+							+ request->actual,
 							transfer_size);
 				}
 
@@ -684,7 +684,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 			}
 #endif	/* Mentor's USB */
 
-			fifo_count = pRequest->length - pRequest->actual;
+			fifo_count = request->length - request->actual;
 			DBG(3, "%s OUT/RX pio fifo %d/%d, maxpacket %d\n",
 					musb_ep->end_point.name,
 					len, fifo_count,
@@ -696,7 +696,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 			if (tusb_dma_omap() && musb_ep->dma) {
 				struct dma_controller *c = musb->dma_controller;
 				struct dma_channel *channel = musb_ep->dma;
-				u32 dma_addr = pRequest->dma + pRequest->actual;
+				u32 dma_addr = request->dma + request->actual;
 				int ret;
 
 				ret = c->channel_program(channel,
@@ -710,8 +710,8 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 #endif
 
 			musb_read_fifo(musb_ep->hw_ep, fifo_count, (u8 *)
-					(pRequest->buf + pRequest->actual));
-			pRequest->actual += fifo_count;
+					(request->buf + request->actual));
+			request->actual += fifo_count;
 
 			/* REVISIT if we left anything in the fifo, flush
 			 * it and report -EOVERFLOW
@@ -725,8 +725,8 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	}
 
 	/* reach the end or short packet detected */
-	if (pRequest->actual == pRequest->length || len < musb_ep->wPacketSize)
-		musb_g_giveback(musb_ep, pRequest, 0);
+	if (request->actual == request->length || len < musb_ep->wPacketSize)
+		musb_g_giveback(musb_ep, request, 0);
 }
 
 /*
@@ -735,7 +735,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 void musb_g_rx(struct musb *musb, u8 epnum)
 {
 	u16			wCsrVal;
-	struct usb_request	*pRequest;
+	struct usb_request	*request;
 	void __iomem		*mbase = musb->mregs;
 	struct musb_ep		*musb_ep = &musb->endpoints[epnum].ep_out;
 	void __iomem		*epio = musb->endpoints[epnum].regs;
@@ -743,27 +743,27 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 
 	musb_ep_select(mbase, epnum);
 
-	pRequest = next_request(musb_ep);
+	request = next_request(musb_ep);
 
 	wCsrVal = musb_readw(epio, MGC_O_HDRC_RXCSR);
 	dma = is_dma_capable() ? musb_ep->dma : NULL;
 
 	DBG(4, "<== %s, rxcsr %04x%s %p\n", musb_ep->end_point.name,
-			wCsrVal, dma ? " (dma)" : "", pRequest);
+			wCsrVal, dma ? " (dma)" : "", request);
 
 	if (wCsrVal & MGC_M_RXCSR_P_SENTSTALL) {
 		if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
 			dma->status = MGC_DMA_STATUS_CORE_ABORT;
 			(void) musb->dma_controller->channel_abort(dma);
-			pRequest->actual += musb_ep->dma->actual_len;
+			request->actual += musb_ep->dma->actual_len;
 		}
 
 		wCsrVal |= MGC_M_RXCSR_P_WZC_BITS;
 		wCsrVal &= ~MGC_M_RXCSR_P_SENTSTALL;
 		musb_writew(epio, MGC_O_HDRC_RXCSR, wCsrVal);
 
-		if (pRequest)
-			musb_g_giveback(musb_ep, pRequest, -EPIPE);
+		if (request)
+			musb_g_giveback(musb_ep, request, -EPIPE);
 		goto done;
 	}
 
@@ -772,9 +772,9 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 		wCsrVal &= ~MGC_M_RXCSR_P_OVERRUN;
 		musb_writew(epio, MGC_O_HDRC_RXCSR, wCsrVal);
 
-		DBG(3, "%s iso overrun on %p\n", musb_ep->name, pRequest);
-		if (pRequest && pRequest->status == -EINPROGRESS)
-			pRequest->status = -EOVERFLOW;
+		DBG(3, "%s iso overrun on %p\n", musb_ep->name, request);
+		if (request && request->status == -EINPROGRESS)
+			request->status = -EOVERFLOW;
 	}
 	if (wCsrVal & MGC_M_RXCSR_INCOMPRX) {
 		/* REVISIT not necessarily an error */
@@ -796,12 +796,12 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 		musb_writew(epio, MGC_O_HDRC_RXCSR,
 			MGC_M_RXCSR_P_WZC_BITS | wCsrVal);
 
-		pRequest->actual += musb_ep->dma->actual_len;
+		request->actual += musb_ep->dma->actual_len;
 
 		DBG(4, "RXCSR%d %04x, dma off, %04x, len %Zd, req %p\n",
 			epnum, wCsrVal,
 			musb_readw(epio, MGC_O_HDRC_RXCSR),
-			musb_ep->dma->actual_len, pRequest);
+			musb_ep->dma->actual_len, request);
 
 #if defined(CONFIG_USB_INVENTRA_DMA) || defined(CONFIG_USB_TUSB_OMAP_DMA)
 		/* Autoclear doesn't clear RxPktRdy for short packets */
@@ -814,15 +814,15 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 		}
 
 		/* incomplete, and not short? wait for next IN packet */
-                if ((pRequest->actual < pRequest->length)
+                if ((request->actual < request->length)
 				&& (musb_ep->dma->actual_len
 					== musb_ep->wPacketSize))
 			goto done;
 #endif
-		musb_g_giveback(musb_ep, pRequest, 0);
+		musb_g_giveback(musb_ep, request, 0);
 
-		pRequest = next_request(musb_ep);
-		if (!pRequest)
+		request = next_request(musb_ep);
+		if (!request)
 			goto done;
 
 		/* don't start more i/o till the stall clears */
@@ -834,8 +834,8 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 
 
 	/* analyze request if the ep is hot */
-	if (pRequest)
-		rxstate(musb, to_musb_request(pRequest));
+	if (request)
+		rxstate(musb, to_musb_request(request));
 	else
 		DBG(3, "packet waiting for %s%s request\n",
 				musb_ep->desc ? "" : "inactive ",
@@ -1046,17 +1046,17 @@ static int musb_gadget_disable(struct usb_ep *ep)
 struct usb_request *musb_alloc_request(struct usb_ep *ep, gfp_t gfp_flags)
 {
 	struct musb_ep		*musb_ep = to_musb_ep(ep);
-	struct musb_request	*pRequest = NULL;
-
-	pRequest = kzalloc(sizeof *pRequest, gfp_flags);
-	if (pRequest) {
-		INIT_LIST_HEAD(&pRequest->request.list);
-		pRequest->request.dma = DMA_ADDR_INVALID;
-		pRequest->epnum = musb_ep->current_epnum;
-		pRequest->ep = musb_ep;
+	struct musb_request	*request = NULL;
+
+	request = kzalloc(sizeof *request, gfp_flags);
+	if (request) {
+		INIT_LIST_HEAD(&request->request.list);
+		request->request.dma = DMA_ADDR_INVALID;
+		request->epnum = musb_ep->current_epnum;
+		request->ep = musb_ep;
 	}
 
-	return &pRequest->request;
+	return &request->request;
 }
 
 /*
@@ -1097,7 +1097,7 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 			gfp_t gfp_flags)
 {
 	struct musb_ep		*musb_ep;
-	struct musb_request	*pRequest;
+	struct musb_request	*request;
 	struct musb		*musb;
 	int			status = 0;
 	unsigned long		lockflags;
@@ -1110,43 +1110,43 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 	musb_ep = to_musb_ep(ep);
 	musb = musb_ep->musb;
 
-	pRequest = to_musb_request(req);
-	pRequest->musb = musb;
+	request = to_musb_request(req);
+	request->musb = musb;
 
-	if (pRequest->ep != musb_ep)
+	if (request->ep != musb_ep)
 		return -EINVAL;
 
 	DBG(4, "<== to %s request=%p\n", ep->name, req);
 
 	/* request is mine now... */
-	pRequest->request.actual = 0;
-	pRequest->request.status = -EINPROGRESS;
-	pRequest->epnum = musb_ep->current_epnum;
-	pRequest->bTx = musb_ep->is_in;
+	request->request.actual = 0;
+	request->request.status = -EINPROGRESS;
+	request->epnum = musb_ep->current_epnum;
+	request->bTx = musb_ep->is_in;
 
 	if (is_dma_capable() && musb_ep->dma) {
-		if (pRequest->request.dma == DMA_ADDR_INVALID) {
-			pRequest->request.dma = dma_map_single(
+		if (request->request.dma == DMA_ADDR_INVALID) {
+			request->request.dma = dma_map_single(
 					musb->controller,
-					pRequest->request.buf,
-					pRequest->request.length,
-					pRequest->bTx
+					request->request.buf,
+					request->request.length,
+					request->bTx
 						? DMA_TO_DEVICE
 						: DMA_FROM_DEVICE);
-			pRequest->mapped = 1;
+			request->mapped = 1;
 		} else {
 			dma_sync_single_for_device(musb->controller,
-					pRequest->request.dma,
-					pRequest->request.length,
-					pRequest->bTx
+					request->request.dma,
+					request->request.length,
+					request->bTx
 						? DMA_TO_DEVICE
 						: DMA_FROM_DEVICE);
-			pRequest->mapped = 0;
+			request->mapped = 0;
 		}
 	} else if (!req->buf) {
 		return -ENODATA;
 	} else
-		pRequest->mapped = 0;
+		request->mapped = 0;
 
 	spin_lock_irqsave(&musb->lock, lockflags);
 
@@ -1158,19 +1158,19 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 		goto cleanup;
 	}
 
-	/* add pRequest to the list */
-	list_add_tail(&(pRequest->request.list), &(musb_ep->req_list));
+	/* add request to the list */
+	list_add_tail(&(request->request.list), &(musb_ep->req_list));
 
 	/* it this is the head of the queue, start i/o ... */
-	if (!musb_ep->busy && &pRequest->request.list == musb_ep->req_list.next)
-		musb_ep_restart(musb, pRequest);
+	if (!musb_ep->busy && &request->request.list == musb_ep->req_list.next)
+		musb_ep_restart(musb, request);
 
 cleanup:
 	spin_unlock_irqrestore(&musb->lock, lockflags);
 	return status;
 }
 
-static int musb_gadget_dequeue(struct usb_ep *ep, struct usb_request *pRequest)
+static int musb_gadget_dequeue(struct usb_ep *ep, struct usb_request *request)
 {
 	struct musb_ep		*musb_ep = to_musb_ep(ep);
 	struct usb_request	*r;
@@ -1178,24 +1178,24 @@ static int musb_gadget_dequeue(struct usb_ep *ep, struct usb_request *pRequest)
 	int			status = 0;
 	struct musb		*musb = musb_ep->musb;
 
-	if (!ep || !pRequest || to_musb_request(pRequest)->ep != musb_ep)
+	if (!ep || !request || to_musb_request(request)->ep != musb_ep)
 		return -EINVAL;
 
 	spin_lock_irqsave(&musb->lock, flags);
 
 	list_for_each_entry(r, &musb_ep->req_list, list) {
-		if (r == pRequest)
+		if (r == request)
 			break;
 	}
-	if (r != pRequest) {
-		DBG(3, "request %p not queued to %s\n", pRequest, ep->name);
+	if (r != request) {
+		DBG(3, "request %p not queued to %s\n", request, ep->name);
 		status = -EINVAL;
 		goto done;
 	}
 
 	/* if the hardware doesn't have the request, easy ... */
-	if (musb_ep->req_list.next != &pRequest->list || musb_ep->busy)
-		musb_g_giveback(musb_ep, pRequest, -ECONNRESET);
+	if (musb_ep->req_list.next != &request->list || musb_ep->busy)
+		musb_g_giveback(musb_ep, request, -ECONNRESET);
 
 	/* ... else abort the dma transfer ... */
 	else if (is_dma_capable() && musb_ep->dma) {
@@ -1207,12 +1207,12 @@ static int musb_gadget_dequeue(struct usb_ep *ep, struct usb_request *pRequest)
 		else
 			status = -EBUSY;
 		if (status == 0)
-			musb_g_giveback(musb_ep, pRequest, -ECONNRESET);
+			musb_g_giveback(musb_ep, request, -ECONNRESET);
 	} else {
 		/* NOTE: by sticking to easily tested hardware/driver states,
 		 * we leave counting of in-flight packets imprecise.
 		 */
-		musb_g_giveback(musb_ep, pRequest, -ECONNRESET);
+		musb_g_giveback(musb_ep, request, -ECONNRESET);
 	}
 
 done:
@@ -1235,7 +1235,7 @@ int musb_gadget_set_halt(struct usb_ep *ep, int value)
 	void __iomem		*mbase;
 	unsigned long		flags;
 	u16			wCsr;
-	struct musb_request	*pRequest = NULL;
+	struct musb_request	*request = NULL;
 	int			status = 0;
 
 	if (!ep)
@@ -1252,7 +1252,7 @@ int musb_gadget_set_halt(struct usb_ep *ep, int value)
 	musb_ep_select(mbase, epnum);
 
 	/* cannot portably stall with non-empty FIFO */
-	pRequest = to_musb_request(next_request(musb_ep));
+	request = to_musb_request(next_request(musb_ep));
 	if (value && musb_ep->is_in) {
 		wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
 		if (wCsr & MGC_M_TXCSR_FIFONOTEMPTY) {
@@ -1294,9 +1294,9 @@ int musb_gadget_set_halt(struct usb_ep *ep, int value)
 done:
 
 	/* maybe start the first request in the queue */
-	if (!musb_ep->busy && !value && pRequest) {
+	if (!musb_ep->busy && !value && request) {
 		DBG(3, "restarting the request\n");
-		musb_ep_restart(musb, pRequest);
+		musb_ep_restart(musb, request);
 	}
 
 	spin_unlock_irqrestore(&musb->lock, flags);
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -950,7 +950,7 @@ static int musb_h_ep0_continue(struct musb *musb,
 	u16 fifo_count = 0;
 	struct musb_hw_ep	*hw_ep = musb->control_ep;
 	struct musb_qh		*qh = hw_ep->in_qh;
-	struct usb_ctrlrequest	*pRequest;
+	struct usb_ctrlrequest	*request;
 
 	switch (musb->ep0_stage) {
 	case MGC_END0_IN:
@@ -972,12 +972,12 @@ static int musb_h_ep0_continue(struct musb *musb,
 			bMore = TRUE;
 		break;
 	case MGC_END0_START:
-		pRequest = (struct usb_ctrlrequest *) pUrb->setup_packet;
+		request = (struct usb_ctrlrequest *) pUrb->setup_packet;
 
-		if (!pRequest->wLength) {
+		if (!request->wLength) {
 			DBG(4, "start no-DATA\n");
 			break;
-		} else if (pRequest->bRequestType & USB_DIR_IN) {
+		} else if (request->bRequestType & USB_DIR_IN) {
 			DBG(4, "start IN-DATA\n");
 			musb->ep0_stage = MGC_END0_IN;
 			bMore = TRUE;
-- 
1.5.2.3
