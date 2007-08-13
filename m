From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 39/52] musb_hdrc: Search and replace dwActualLength with
	actual_len
Date: Mon, 13 Aug 2007 06:49:14 -0700
Message-ID: <11870130741506-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1187013072449-git-send-email-tony@atomide.com>
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

Search and replace dwActualLength with actual_len

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/cppi_dma.c      |    4 ++--
 drivers/usb/musb/dma.h           |    4 ++--
 drivers/usb/musb/musb_gadget.c   |   14 +++++++-------
 drivers/usb/musb/musb_host.c     |   18 +++++++++---------
 drivers/usb/musb/musbhsdma.c     |   14 +++++++-------
 drivers/usb/musb/tusb6010_omap.c |   10 +++++-----
 6 files changed, 32 insertions(+), 32 deletions(-)

--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -1229,7 +1229,7 @@ void cppi_completion(struct musb *musb, u32 rx, u32 tx)
 
 					hw_ep = txChannel->hw_ep;
 
-					txChannel->Channel.dwActualLength =
+					txChannel->Channel.actual_len =
 						txChannel->actualLen;
 
 					/* Peripheral role never repurposes the
@@ -1292,7 +1292,7 @@ void cppi_completion(struct musb *musb, u32 rx, u32 tx)
 
 			hw_ep = rxChannel->hw_ep;
 
-			rxChannel->Channel.dwActualLength =
+			rxChannel->Channel.actual_len =
 					rxChannel->actualLen;
 			core_rxirq_disable(regBase, chanNum + 1);
 			musb_dma_completion(musb, chanNum + 1, 0);
--- a/drivers/usb/musb/dma.h
+++ b/drivers/usb/musb/dma.h
@@ -103,7 +103,7 @@ struct dma_controller;
  * @private_data: channel-private data
  * @wMaxLength: the maximum number of bytes the channel can move in one
  *	transaction (typically representing many USB maximum-sized packets)
- * @dwActualLength: how many bytes have been transferred
+ * @actual_len: how many bytes have been transferred
  * @bStatus: current channel status (updated e.g. on interrupt)
  * @bDesiredMode: TRUE if mode 1 is desired; FALSE if mode 0 is desired
  *
@@ -114,7 +114,7 @@ struct dma_channel {
 	void			*private_data;
 	// FIXME not void* private_data, but a dma_controller *
 	size_t			max_len;
-	size_t			dwActualLength;
+	size_t			actual_len;
 	enum dma_channel_status	bStatus;
 	u8			bDesiredMode;
 };
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -466,11 +466,11 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 				musb_writew(epio, MGC_O_HDRC_TXCSR, wCsrVal);
 				/* ensure writebuffer is empty */
 				wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
-				pRequest->actual += musb_ep->dma->dwActualLength;
+				pRequest->actual += musb_ep->dma->actual_len;
 				DBG(4, "TXCSR%d %04x, dma off, "
 						"len %Zd, req %p\n",
 					epnum, wCsrVal,
-					musb_ep->dma->dwActualLength,
+					musb_ep->dma->actual_len,
 					pRequest);
 			}
 
@@ -755,7 +755,7 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 		if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
 			dma->bStatus = MGC_DMA_STATUS_CORE_ABORT;
 			(void) musb->dma_controller->channel_abort(dma);
-			pRequest->actual += musb_ep->dma->dwActualLength;
+			pRequest->actual += musb_ep->dma->actual_len;
 		}
 
 		wCsrVal |= MGC_M_RXCSR_P_WZC_BITS;
@@ -796,17 +796,17 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 		musb_writew(epio, MGC_O_HDRC_RXCSR,
 			MGC_M_RXCSR_P_WZC_BITS | wCsrVal);
 
-		pRequest->actual += musb_ep->dma->dwActualLength;
+		pRequest->actual += musb_ep->dma->actual_len;
 
 		DBG(4, "RXCSR%d %04x, dma off, %04x, len %Zd, req %p\n",
 			epnum, wCsrVal,
 			musb_readw(epio, MGC_O_HDRC_RXCSR),
-			musb_ep->dma->dwActualLength, pRequest);
+			musb_ep->dma->actual_len, pRequest);
 
 #if defined(CONFIG_USB_INVENTRA_DMA) || defined(CONFIG_USB_TUSB_OMAP_DMA)
 		/* Autoclear doesn't clear RxPktRdy for short packets */
 		if ((dma->bDesiredMode == 0)
-				|| (dma->dwActualLength
+				|| (dma->actual_len
 					& (musb_ep->wPacketSize - 1))) {
 			/* ack the read! */
 			wCsrVal &= ~MGC_M_RXCSR_RXPKTRDY;
@@ -815,7 +815,7 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 
 		/* incomplete, and not short? wait for next IN packet */
                 if ((pRequest->actual < pRequest->length)
-				&& (musb_ep->dma->dwActualLength
+				&& (musb_ep->dma->actual_len
 					== musb_ep->wPacketSize))
 			goto done;
 #endif
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -824,7 +824,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			musb_writew(epio, MGC_O_HDRC_TXCSR,
 				wCsr | MGC_M_TXCSR_MODE);
 
-			pDmaChannel->dwActualLength = 0L;
+			pDmaChannel->actual_len = 0L;
 			qh->segsize = dwLength;
 
 			/* TX uses "rndis" mode automatically, but needs help
@@ -904,7 +904,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 		if ((is_cppi_enabled() || tusb_dma_omap()) && pDmaChannel) {
 			/* candidate for DMA */
 			if (pDmaChannel) {
-				pDmaChannel->dwActualLength = 0L;
+				pDmaChannel->actual_len = 0L;
 				qh->segsize = dwLength;
 
 				/* AUTOREQ is in a DMA register */
@@ -1260,7 +1260,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 	/* REVISIT this looks wrong... */
 	if (!status || dma || usb_pipeisoc(nPipe)) {
 		if (dma)
-			wLength = dma->dwActualLength;
+			wLength = dma->actual_len;
 		else
 			wLength = qh->segsize;
 		qh->offset += wLength;
@@ -1416,7 +1416,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 
 	DBG(5, "<== hw %d rxcsr %04x, urb actual %d (+dma %zd)\n",
 		epnum, wRxCsrVal, pUrb->actual_length,
-		dma ? dma->dwActualLength : 0);
+		dma ? dma->actual_len : 0);
 
 	/* check for errors, concurrent stall & unlink is not really
 	 * handled yet! */
@@ -1462,7 +1462,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 		if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
 			dma->bStatus = MGC_DMA_STATUS_CORE_ABORT;
 			(void) musb->dma_controller->channel_abort(dma);
-			xfer_len = dma->dwActualLength;
+			xfer_len = dma->actual_len;
 		}
 		musb_h_flush_rxfifo(hw_ep, 0);
 		musb_writeb(epio, MGC_O_HDRC_RXINTERVAL, 0);
@@ -1493,7 +1493,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 		if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
 			dma->bStatus = MGC_DMA_STATUS_CORE_ABORT;
 			(void) musb->dma_controller->channel_abort(dma);
-			xfer_len = dma->dwActualLength;
+			xfer_len = dma->actual_len;
 			bDone = TRUE;
 		}
 
@@ -1507,7 +1507,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 	}
 #endif
 	if (dma && (wRxCsrVal & MGC_M_RXCSR_DMAENAB)) {
-		xfer_len = dma->dwActualLength;
+		xfer_len = dma->actual_len;
 
 		wVal &= ~(MGC_M_RXCSR_DMAENAB
 			| MGC_M_RXCSR_H_AUTOREQ
@@ -1519,7 +1519,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 		/* bDone if pUrb buffer is full or short packet is recd */
 		bDone = ((pUrb->actual_length + xfer_len) >=
 				pUrb->transfer_buffer_length)
-			|| (dma->dwActualLength & (qh->maxpacket - 1));
+			|| (dma->actual_len & (qh->maxpacket - 1));
 
 		/* send IN token for next packet, without AUTOREQ */
 		if (!bDone) {
@@ -1920,7 +1920,7 @@ static int musb_cleanup_urb(struct urb *urb, struct musb_qh *qh, int is_in)
 				"abort %cX%d DMA for urb %p --> %d\n",
 				is_in ? 'R' : 'T', ep->epnum,
 				urb, status);
-			urb->actual_length += dma->dwActualLength;
+			urb->actual_length += dma->actual_len;
 		}
 	}
 
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -148,7 +148,7 @@ static struct dma_channel* dma_channel_allocate(struct dma_controller *c,
 			pChannel->max_len = 0x10000;
 			/* Tx => mode 1; Rx => mode 0 */
 			pChannel->bDesiredMode = bTransmit;
-			pChannel->dwActualLength = 0;
+			pChannel->actual_len = 0;
 			break;
 		}
 	}
@@ -160,7 +160,7 @@ static void dma_channel_release(struct dma_channel *pChannel)
 	struct musb_dma_channel *pImplChannel =
 		(struct musb_dma_channel *) pChannel->private_data;
 
-	pChannel->dwActualLength = 0;
+	pChannel->actual_len = 0;
 	pImplChannel->dwStartAddress = 0;
 	pImplChannel->len = 0;
 
@@ -235,7 +235,7 @@ static int dma_channel_program(struct dma_channel * pChannel,
 	BUG_ON(pChannel->bStatus == MGC_DMA_STATUS_UNKNOWN ||
 		pChannel->bStatus == MGC_DMA_STATUS_BUSY);
 
-	pChannel->dwActualLength = 0;
+	pChannel->actual_len = 0;
 	pImplChannel->dwStartAddress = dma_addr;
 	pImplChannel->len = dwLength;
 	pImplChannel->wMaxPacketSize = wPacketSize;
@@ -329,14 +329,14 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 						MGC_HSDMA_CHANNEL_OFFSET(
 							bChannel,
 							MGC_O_HSDMA_ADDRESS));
-				pChannel->dwActualLength =
+				pChannel->actual_len =
 				    dwAddress - pImplChannel->dwStartAddress;
 
 				DBG(2, "ch %p, 0x%x -> 0x%x (%d / %d) %s\n",
 				    pChannel, pImplChannel->dwStartAddress,
-				    dwAddress, pChannel->dwActualLength,
+				    dwAddress, pChannel->actual_len,
 				    pImplChannel->len,
-				    (pChannel->dwActualLength <
+				    (pChannel->actual_len <
 					pImplChannel->len) ?
 					"=> reconfig 0": "=> complete");
 
@@ -349,7 +349,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 				if ((devctl & MGC_M_DEVCTL_HM)
 				    && (pImplChannel->bTransmit)
 				    && ((pChannel->bDesiredMode == 0)
-					|| (pChannel->dwActualLength &
+					|| (pChannel->actual_len &
 					    (pImplChannel->wMaxPacketSize - 1)))
 				   ) {
 					/* Send out the packet */
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -176,8 +176,8 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 		remaining = 0;
 	}
 
-	channel->dwActualLength = chdat->transfer_len - remaining;
-	pio = chdat->len - channel->dwActualLength;
+	channel->actual_len = chdat->transfer_len - remaining;
+	pio = chdat->len - channel->actual_len;
 
 	DBG(2, "DMA remaining %lu/%u\n", remaining, chdat->transfer_len);
 
@@ -196,7 +196,7 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 			consistent_sync(phys_to_virt((u32)chdat->dma_addr),
 					chdat->transfer_len, DMA_FROM_DEVICE);
 		}
-		channel->dwActualLength += pio;
+		channel->actual_len += pio;
 	}
 
 	if (!dmareq_works())
@@ -294,7 +294,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 
 	chdat->packet_sz = packet_sz;
 	chdat->len = len;
-	channel->dwActualLength = 0;
+	channel->actual_len = 0;
 	chdat->dma_addr = (void __iomem *)dma_addr;
 	channel->bStatus = MGC_DMA_STATUS_BUSY;
 
@@ -550,7 +550,7 @@ tusb_omap_dma_allocate(struct dma_controller *c,
 
 	channel->max_len = 0x7fffffff;
 	channel->bDesiredMode = 0;
-	channel->dwActualLength = 0;
+	channel->actual_len = 0;
 
 	if (dmareq_works()) {
 		ret = tusb_omap_dma_allocate_dmareq(chdat);
-- 
1.5.2.3
