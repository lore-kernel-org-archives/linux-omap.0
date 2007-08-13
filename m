From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 51/52] musb_hdrc: Search and replace wPacketSize with
	packet_sz
Date: Mon, 13 Aug 2007 06:49:26 -0700
Message-ID: <11870131044061-git-send-email-tony@atomide.com>
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
	<11870130953685-git-send-email-tony@atomide.com>
	<118701309984-git-send-email-tony@atomide.com>
	<11870131023809-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11870131023809-git-send-email-tony@atomide.com>
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

Search and replace wPacketSize with packet_sz

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_gadget.c |   38 +++++++++++++++++++-------------------
 drivers/usb/musb/musb_gadget.h |    2 +-
 drivers/usb/musb/musb_host.c   |   20 ++++++++++----------
 drivers/usb/musb/musbhsdma.c   |   24 ++++++++++++------------
 4 files changed, 42 insertions(+), 42 deletions(-)

--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -205,7 +205,7 @@ static inline int max_ep_writesize(struct musb *musb, struct musb_ep *ep)
 	if (can_bulk_split(musb, ep->type))
 		return ep->hw_ep->max_packet_sz_tx;
 	else
-		return ep->wPacketSize;
+		return ep->packet_sz;
 }
 
 
@@ -287,7 +287,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 	}
 
 	DBG(4, "hw_ep%d, maxpacket %d, fifo count %d, txcsr %03x\n",
-			epnum, musb_ep->wPacketSize, fifo_count,
+			epnum, musb_ep->packet_sz, fifo_count,
 			csr);
 
 #ifndef	CONFIG_USB_INVENTRA_FIFO
@@ -305,13 +305,13 @@ static void txstate(struct musb *musb, struct musb_request *req)
 			/* setup DMA, then program endpoint CSR */
 			request_size = min(request->length,
 						musb_ep->dma->max_len);
-			if (request_size <= musb_ep->wPacketSize)
+			if (request_size <= musb_ep->packet_sz)
 				musb_ep->dma->desired_mode = 0;
 			else
 				musb_ep->dma->desired_mode = 1;
 
 			use_dma = use_dma && c->channel_program(
-					musb_ep->dma, musb_ep->wPacketSize,
+					musb_ep->dma, musb_ep->packet_sz,
 					musb_ep->dma->desired_mode,
 					request->dma, request_size);
 			if (use_dma) {
@@ -359,7 +359,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 		 * except for the last-packet-is-already-short case.
 		 */
 		use_dma = use_dma && c->channel_program(
-				musb_ep->dma, musb_ep->wPacketSize,
+				musb_ep->dma, musb_ep->packet_sz,
 				0,
 				request->dma,
 				request->length);
@@ -372,7 +372,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 		}
 #elif defined(CONFIG_USB_TUSB_OMAP_DMA)
 		use_dma = use_dma && c->channel_program(
-				musb_ep->dma, musb_ep->wPacketSize,
+				musb_ep->dma, musb_ep->packet_sz,
 				request->zero,
 				request->dma,
 				request->length);
@@ -483,13 +483,13 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 				if ((request->zero
 						&& request->length
 						&& (request->length
-							% musb_ep->wPacketSize)
+							% musb_ep->packet_sz)
 							== 0)
 #ifdef CONFIG_USB_INVENTRA_DMA
 					|| (is_dma &&
 						((!dma->desired_mode) ||
 						    (request->actual &
-						    (musb_ep->wPacketSize - 1))))
+						    (musb_ep->packet_sz - 1))))
 #endif
 				) {
 					/* on dma completion, fifo may not
@@ -578,7 +578,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	struct musb_ep		*musb_ep = &musb->endpoints[epnum].ep_out;
 	void __iomem		*epio = musb->endpoints[epnum].regs;
 	u16			fifo_count = 0;
-	u16			len = musb_ep->wPacketSize;
+	u16			len = musb_ep->packet_sz;
 
 	csr = musb_readw(epio, MGC_O_HDRC_RXCSR);
 
@@ -592,7 +592,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 		 * faults will be handled correctly.
 		 */
 		if (c->channel_program(channel,
-				musb_ep->wPacketSize,
+				musb_ep->packet_sz,
 				!request->short_not_ok,
 				request->dma + request->actual,
 				request->length - request->actual)) {
@@ -665,14 +665,14 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 #else
 					transfer_size = len;
 #endif
-					if (transfer_size <= musb_ep->wPacketSize)
+					if (transfer_size <= musb_ep->packet_sz)
 						musb_ep->dma->desired_mode = 0;
 					else
 						musb_ep->dma->desired_mode = 1;
 
 					use_dma = c->channel_program(
 							channel,
-							musb_ep->wPacketSize,
+							musb_ep->packet_sz,
 							channel->desired_mode,
 							request->dma
 							+ request->actual,
@@ -688,7 +688,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 			DBG(3, "%s OUT/RX pio fifo %d/%d, maxpacket %d\n",
 					musb_ep->end_point.name,
 					len, fifo_count,
-					musb_ep->wPacketSize);
+					musb_ep->packet_sz);
 
 			fifo_count = min(len, fifo_count);
 
@@ -700,7 +700,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 				int ret;
 
 				ret = c->channel_program(channel,
-						musb_ep->wPacketSize,
+						musb_ep->packet_sz,
 						channel->desired_mode,
 						dma_addr,
 						fifo_count);
@@ -725,7 +725,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	}
 
 	/* reach the end or short packet detected */
-	if (request->actual == request->length || len < musb_ep->wPacketSize)
+	if (request->actual == request->length || len < musb_ep->packet_sz)
 		musb_g_giveback(musb_ep, request, 0);
 }
 
@@ -807,7 +807,7 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 		/* Autoclear doesn't clear RxPktRdy for short packets */
 		if ((dma->desired_mode == 0)
 				|| (dma->actual_len
-					& (musb_ep->wPacketSize - 1))) {
+					& (musb_ep->packet_sz - 1))) {
 			/* ack the read! */
 			csr &= ~MGC_M_RXCSR_RXPKTRDY;
 			musb_writew(epio, MGC_O_HDRC_RXCSR, csr);
@@ -816,7 +816,7 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 		/* incomplete, and not short? wait for next IN packet */
                 if ((request->actual < request->length)
 				&& (musb_ep->dma->actual_len
-					== musb_ep->wPacketSize))
+					== musb_ep->packet_sz))
 			goto done;
 #endif
 		musb_g_giveback(musb_ep, request, 0);
@@ -887,7 +887,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 	tmp = le16_to_cpu(desc->wMaxPacketSize);
 	if (tmp & ~0x07ff)
 		goto fail;
-	musb_ep->wPacketSize = tmp;
+	musb_ep->packet_sz = tmp;
 
 	/* enable the interrupts for the endpoint, set the endpoint
 	 * packet size (or fail), set the mode, clear the fifo
@@ -983,7 +983,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 			}; s; }),
 			musb_ep->is_in ? "IN" : "OUT",
 			musb_ep->dma ? "dma, " : "",
-			musb_ep->wPacketSize);
+			musb_ep->packet_sz);
 
 	schedule_work(&musb->irq_work);
 
--- a/drivers/usb/musb/musb_gadget.h
+++ b/drivers/usb/musb/musb_gadget.h
@@ -67,7 +67,7 @@ struct musb_ep {
 	/* ... when enabled/disabled ... */
 	u8				type;
 	u8				is_in;
-	u16				wPacketSize;
+	u16				packet_sz;
 	const struct usb_endpoint_descriptor	*desc;
 	struct dma_channel		*dma;
 
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -634,14 +634,14 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 	struct musb_hw_ep	*hw_ep = musb->endpoints + epnum;
 	void __iomem		*epio = hw_ep->regs;
 	struct musb_qh		*qh;
-	u16			wPacketSize;
+	u16			packet_sz;
 
 	if (!is_out || hw_ep->is_shared_fifo)
 		qh = hw_ep->in_qh;
 	else
 		qh = hw_ep->out_qh;
 
-	wPacketSize = qh->maxpacket;
+	packet_sz = qh->maxpacket;
 
 	DBG(3, "%s hw%d urb %p spd%d dev%d ep%d%s "
 				"h_addr%02x h_port%02x bytes %d\n",
@@ -739,12 +739,12 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			musb_writeb(epio, MGC_O_HDRC_TXTYPE, qh->type_reg);
 			if (can_bulk_split(musb, qh->type))
 				musb_writew(epio, MGC_O_HDRC_TXMAXP,
-					wPacketSize
+					packet_sz
 					| ((hw_ep->max_packet_sz_tx /
-						wPacketSize) - 1) << 11);
+						packet_sz) - 1) << 11);
 			else
 				musb_writew(epio, MGC_O_HDRC_TXMAXP,
-					wPacketSize);
+					packet_sz);
 			musb_writeb(epio, MGC_O_HDRC_TXINTERVAL, qh->intv_reg);
 		} else {
 			musb_writeb(epio, MGC_O_HDRC_NAKLIMIT0, qh->intv_reg);
@@ -757,7 +757,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			wLoadCount = min((u32) hw_ep->max_packet_sz_tx,
 						dwLength);
 		else
-			wLoadCount = min((u32) wPacketSize, dwLength);
+			wLoadCount = min((u32) packet_sz, dwLength);
 
 #ifdef CONFIG_USB_INVENTRA_DMA
 		if (pDmaChannel) {
@@ -773,7 +773,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 
 			qh->segsize = min(dwLength, pDmaChannel->max_len);
 
-			if (qh->segsize <= wPacketSize)
+			if (qh->segsize <= packet_sz)
 				pDmaChannel->desired_mode = 0;
 			else
 				pDmaChannel->desired_mode = 1;
@@ -792,7 +792,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			musb_writew(epio, MGC_O_HDRC_TXCSR, wCsr);
 
 			bDmaOk = dma_controller->channel_program(
-					pDmaChannel, wPacketSize,
+					pDmaChannel, packet_sz,
 					pDmaChannel->desired_mode,
 					pUrb->transfer_dma,
 					qh->segsize);
@@ -831,7 +831,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			 * to identify the zero-length-final-packet case.
 			 */
 			bDmaOk = dma_controller->channel_program(
-					pDmaChannel, wPacketSize,
+					pDmaChannel, packet_sz,
 					(pUrb->transfer_flags
 							& URB_ZERO_PACKET)
 						== URB_ZERO_PACKET,
@@ -916,7 +916,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 				 * errors, we dare not queue multiple transfers.
 				 */
 				bDmaOk = dma_controller->channel_program(
-						pDmaChannel, wPacketSize,
+						pDmaChannel, packet_sz,
 						!(pUrb->transfer_flags
 							& URB_SHORT_NOT_OK),
 						pUrb->transfer_dma,
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -171,7 +171,7 @@ static void dma_channel_release(struct dma_channel *pChannel)
 }
 
 static void configure_channel(struct dma_channel *pChannel,
-				u16 wPacketSize, u8 mode,
+				u16 packet_sz, u8 mode,
 				dma_addr_t dma_addr, u32 dwLength)
 {
 	struct musb_dma_channel *pImplChannel =
@@ -182,20 +182,20 @@ static void configure_channel(struct dma_channel *pChannel,
 	u16 wCsr = 0;
 
 	DBG(4, "%p, pkt_sz %d, addr 0x%x, len %d, mode %d\n",
-	    pChannel, wPacketSize, dma_addr, dwLength, mode);
+	    pChannel, packet_sz, dma_addr, dwLength, mode);
 
 	if (mode) {
 		wCsr |= 1 << MGC_S_HSDMA_MODE1;
-		if (dwLength < wPacketSize) {
+		if (dwLength < packet_sz) {
 			return FALSE;
 		}
-		if (wPacketSize >= 64) {
+		if (packet_sz >= 64) {
 			wCsr |=
 			    MGC_HSDMA_BURSTMODE_INCR16 << MGC_S_HSDMA_BURSTMODE;
-		} else if (wPacketSize >= 32) {
+		} else if (packet_sz >= 32) {
 			wCsr |=
 			    MGC_HSDMA_BURSTMODE_INCR8 << MGC_S_HSDMA_BURSTMODE;
-		} else if (wPacketSize >= 16) {
+		} else if (packet_sz >= 16) {
 			wCsr |=
 			    MGC_HSDMA_BURSTMODE_INCR4 << MGC_S_HSDMA_BURSTMODE;
 		}
@@ -221,7 +221,7 @@ static void configure_channel(struct dma_channel *pChannel,
 }
 
 static int dma_channel_program(struct dma_channel * pChannel,
-				u16 wPacketSize, u8 mode,
+				u16 packet_sz, u8 mode,
 				dma_addr_t dma_addr, u32 dwLength)
 {
 	struct musb_dma_channel *pImplChannel =
@@ -230,7 +230,7 @@ static int dma_channel_program(struct dma_channel * pChannel,
 	DBG(2, "ep%d-%s pkt_sz %d, dma_addr 0x%x length %d, mode %d\n",
 		pImplChannel->epnum,
 		pImplChannel->bTransmit ? "Tx" : "Rx",
-		wPacketSize, dma_addr, dwLength, mode);
+		packet_sz, dma_addr, dwLength, mode);
 
 	BUG_ON(pChannel->status == MGC_DMA_STATUS_UNKNOWN ||
 		pChannel->status == MGC_DMA_STATUS_BUSY);
@@ -238,14 +238,14 @@ static int dma_channel_program(struct dma_channel * pChannel,
 	pChannel->actual_len = 0;
 	pImplChannel->dwStartAddress = dma_addr;
 	pImplChannel->len = dwLength;
-	pImplChannel->wMaxPacketSize = wPacketSize;
+	pImplChannel->wMaxPacketSize = packet_sz;
 	pChannel->status = MGC_DMA_STATUS_BUSY;
 
-	if ((mode == 1) && (dwLength >= wPacketSize)) {
-		configure_channel(pChannel, wPacketSize, 1, dma_addr,
+	if ((mode == 1) && (dwLength >= packet_sz)) {
+		configure_channel(pChannel, packet_sz, 1, dma_addr,
 				  dwLength);
 	} else
-		configure_channel(pChannel, wPacketSize, 0, dma_addr,
+		configure_channel(pChannel, packet_sz, 0, dma_addr,
 				  dwLength);
 
 	return TRUE;
-- 
1.5.2.3
