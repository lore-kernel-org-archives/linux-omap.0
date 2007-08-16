From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 8/36] musb_hdrc: Search and replace pUrb with urb
Date: Thu, 16 Aug 2007 02:40:31 -0700
Message-ID: <1187257278289-git-send-email-tony@atomide.com>
References: <11872572591844-git-send-email-tony@atomide.com>
	<11872572612810-git-send-email-tony@atomide.com>
	<11872572643880-git-send-email-tony@atomide.com>
	<11872572672740-git-send-email-tony@atomide.com>
	<11872572693807-git-send-email-tony@atomide.com>
	<11872572713057-git-send-email-tony@atomide.com>
	<11872572743878-git-send-email-tony@atomide.com>
	<11872572762670-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11872572762670-git-send-email-tony@atomide.com>
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

Search and replace pUrb with urb

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c |  190 +++++++++++++++++++++---------------------
 1 files changed, 95 insertions(+), 95 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 32376f4..3b94630 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -104,7 +104,7 @@
 /*************************** Forwards ***************************/
 
 static void musb_ep_program(struct musb *musb, u8 epnum,
-			struct urb *pUrb, unsigned int nOut,
+			struct urb *urb, unsigned int nOut,
 			u8 * pBuffer, u32 dwLength);
 
 /*
@@ -466,7 +466,7 @@ static inline u16 musb_h_flush_rxfifo(struct musb_hw_ep *hw_ep, u16 csr)
 /*
  * PIO RX for a packet (or part of it).
  */
-static u8 musb_host_packet_rx(struct musb *musb, struct urb *pUrb,
+static u8 musb_host_packet_rx(struct musb *musb, struct urb *urb,
 		u8 epnum, u8 bIsochError)
 {
 	u16 wRxCount;
@@ -478,14 +478,14 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *pUrb,
 	struct musb_hw_ep	*hw_ep = musb->endpoints + epnum;
 	void __iomem		*epio = hw_ep->regs;
 	struct musb_qh		*qh = hw_ep->in_qh;
-	int			nPipe = pUrb->pipe;
-	void			*buffer = pUrb->transfer_buffer;
+	int			nPipe = urb->pipe;
+	void			*buffer = urb->transfer_buffer;
 
 	// musb_ep_select(mbase, epnum);
 	wRxCount = musb_readw(epio, MUSB_RXCOUNT);
 	DBG(3, "RX%d count %d, buffer %p len %d/%d\n", epnum, wRxCount,
-			pUrb->transfer_buffer, qh->offset,
-			pUrb->transfer_buffer_length);
+			urb->transfer_buffer, qh->offset,
+			urb->transfer_buffer_length);
 
 	/* unload FIFO */
 	if (usb_pipeisoc(nPipe)) {
@@ -494,52 +494,52 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *pUrb,
 
 		if (bIsochError) {
 			status = -EILSEQ;
-			pUrb->error_count++;
+			urb->error_count++;
 		}
 
-		d = pUrb->iso_frame_desc + qh->iso_idx;
+		d = urb->iso_frame_desc + qh->iso_idx;
 		pBuffer = buffer + d->offset;
 		length = d->length;
 		if (wRxCount > length) {
 			if (status == 0) {
 				status = -EOVERFLOW;
-				pUrb->error_count++;
+				urb->error_count++;
 			}
 			DBG(2, "** OVERFLOW %d into %d\n", wRxCount, length);
 			do_flush = 1;
 		} else
 			length = wRxCount;
-		pUrb->actual_length += length;
+		urb->actual_length += length;
 		d->actual_length = length;
 
 		d->status = status;
 
 		/* see if we are done */
-		bDone = (++qh->iso_idx >= pUrb->number_of_packets);
+		bDone = (++qh->iso_idx >= urb->number_of_packets);
 	} else {
 		/* non-isoch */
 		pBuffer = buffer + qh->offset;
-		length = pUrb->transfer_buffer_length - qh->offset;
+		length = urb->transfer_buffer_length - qh->offset;
 		if (wRxCount > length) {
-			if (pUrb->status == -EINPROGRESS)
-				pUrb->status = -EOVERFLOW;
+			if (urb->status == -EINPROGRESS)
+				urb->status = -EOVERFLOW;
 			DBG(2, "** OVERFLOW %d into %d\n", wRxCount, length);
 			do_flush = 1;
 		} else
 			length = wRxCount;
-		pUrb->actual_length += length;
+		urb->actual_length += length;
 		qh->offset += length;
 
 		/* see if we are done */
-		bDone = (pUrb->actual_length == pUrb->transfer_buffer_length)
+		bDone = (urb->actual_length == urb->transfer_buffer_length)
 			|| (wRxCount < qh->maxpacket)
-			|| (pUrb->status != -EINPROGRESS);
+			|| (urb->status != -EINPROGRESS);
 		if (bDone
-				&& (pUrb->status == -EINPROGRESS)
-				&& (pUrb->transfer_flags & URB_SHORT_NOT_OK)
-				&& (pUrb->actual_length
-					< pUrb->transfer_buffer_length))
-			pUrb->status = -EREMOTEIO;
+				&& (urb->status == -EINPROGRESS)
+				&& (urb->transfer_flags & URB_SHORT_NOT_OK)
+				&& (urb->actual_length
+					< urb->transfer_buffer_length))
+			urb->status = -EREMOTEIO;
 	}
 
 	musb_read_fifo(hw_ep, length, pBuffer);
@@ -624,7 +624,7 @@ musb_rx_reinit(struct musb *musb, struct musb_qh *qh, struct musb_hw_ep *ep)
  * Context: irqs blocked, controller lock held
  */
 static void musb_ep_program(struct musb *musb, u8 epnum,
-			struct urb *pUrb, unsigned int is_out,
+			struct urb *urb, unsigned int is_out,
 			u8 * pBuffer, u32 dwLength)
 {
 	struct dma_controller	*dma_controller;
@@ -646,7 +646,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 	DBG(3, "%s hw%d urb %p spd%d dev%d ep%d%s "
 				"h_addr%02x h_port%02x bytes %d\n",
 			is_out ? "-->" : "<--",
-			epnum, pUrb, pUrb->dev->speed,
+			epnum, urb, urb->dev->speed,
 			qh->addr_reg, qh->epnum, is_out ? "out" : "in",
 			qh->h_addr_reg, qh->h_port_reg,
 			dwLength);
@@ -699,7 +699,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 					);
 			csr |= MUSB_TXCSR_MODE;
 
-			if (usb_gettoggle(pUrb->dev,
+			if (usb_gettoggle(urb->dev,
 					qh->epnum, 1))
 				csr |= MUSB_TXCSR_H_WR_DATATOGGLE
 					| MUSB_TXCSR_H_DATATOGGLE;
@@ -794,7 +794,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			bDmaOk = dma_controller->channel_program(
 					pDmaChannel, packet_sz,
 					pDmaChannel->desired_mode,
-					pUrb->transfer_dma,
+					urb->transfer_dma,
 					qh->segsize);
 			if (bDmaOk) {
 				wLoadCount = 0;
@@ -832,10 +832,10 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			 */
 			bDmaOk = dma_controller->channel_program(
 					pDmaChannel, packet_sz,
-					(pUrb->transfer_flags
+					(urb->transfer_flags
 							& URB_ZERO_PACKET)
 						== URB_ZERO_PACKET,
-					pUrb->transfer_dma,
+					urb->transfer_dma,
 					qh->segsize);
 			if (bDmaOk) {
 				wLoadCount = 0;
@@ -878,7 +878,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			musb_rx_reinit(musb, qh, hw_ep);
 
 			/* init new state: toggle and NYET, maybe DMA later */
-			if (usb_gettoggle(pUrb->dev, qh->epnum, 0))
+			if (usb_gettoggle(urb->dev, qh->epnum, 0))
 				csr = MUSB_RXCSR_H_WR_DATATOGGLE
 					| MUSB_RXCSR_H_DATATOGGLE;
 			else
@@ -917,9 +917,9 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 				 */
 				bDmaOk = dma_controller->channel_program(
 						pDmaChannel, packet_sz,
-						!(pUrb->transfer_flags
+						!(urb->transfer_flags
 							& URB_SHORT_NOT_OK),
-						pUrb->transfer_dma,
+						urb->transfer_dma,
 						qh->segsize);
 				if (!bDmaOk) {
 					dma_controller->channel_release(
@@ -943,7 +943,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
  * Return TRUE until it's time to start the status stage.
  */
 static int musb_h_ep0_continue(struct musb *musb,
-				u16 len, struct urb *pUrb)
+				u16 len, struct urb *urb)
 {
 	int			 bMore = FALSE;
 	u8 *pFifoDest = NULL;
@@ -954,25 +954,25 @@ static int musb_h_ep0_continue(struct musb *musb,
 
 	switch (musb->ep0_stage) {
 	case MGC_END0_IN:
-		pFifoDest = pUrb->transfer_buffer + pUrb->actual_length;
-		fifo_count = min(len, ((u16) (pUrb->transfer_buffer_length
-					- pUrb->actual_length)));
+		pFifoDest = urb->transfer_buffer + urb->actual_length;
+		fifo_count = min(len, ((u16) (urb->transfer_buffer_length
+					- urb->actual_length)));
 		if (fifo_count < len)
-			pUrb->status = -EOVERFLOW;
+			urb->status = -EOVERFLOW;
 
 		musb_read_fifo(hw_ep, fifo_count, pFifoDest);
 
-		pUrb->actual_length += fifo_count;
+		urb->actual_length += fifo_count;
 		if (len < qh->maxpacket) {
 			/* always terminate on short read; it's
 			 * rarely reported as an error.
 			 */
-		} else if (pUrb->actual_length <
-				pUrb->transfer_buffer_length)
+		} else if (urb->actual_length <
+				urb->transfer_buffer_length)
 			bMore = TRUE;
 		break;
 	case MGC_END0_START:
-		request = (struct usb_ctrlrequest *) pUrb->setup_packet;
+		request = (struct usb_ctrlrequest *) urb->setup_packet;
 
 		if (!request->wLength) {
 			DBG(4, "start no-DATA\n");
@@ -990,17 +990,17 @@ static int musb_h_ep0_continue(struct musb *musb,
 		/* FALLTHROUGH */
 	case MGC_END0_OUT:
 		fifo_count = min(qh->maxpacket, ((u16)
-				(pUrb->transfer_buffer_length
-				- pUrb->actual_length)));
+				(urb->transfer_buffer_length
+				- urb->actual_length)));
 
 		if (fifo_count) {
-			pFifoDest = (u8 *) (pUrb->transfer_buffer
-					+ pUrb->actual_length);
+			pFifoDest = (u8 *) (urb->transfer_buffer
+					+ urb->actual_length);
 			DBG(3, "Sending %d bytes to %p\n",
 					fifo_count, pFifoDest);
 			musb_write_fifo(hw_ep, fifo_count, pFifoDest);
 
-			pUrb->actual_length += fifo_count;
+			urb->actual_length += fifo_count;
 			bMore = TRUE;
 		}
 		break;
@@ -1020,7 +1020,7 @@ static int musb_h_ep0_continue(struct musb *musb,
  */
 irqreturn_t musb_h_ep0_irq(struct musb *musb)
 {
-	struct urb		*pUrb;
+	struct urb		*urb;
 	u16			csr, len;
 	int			status = 0;
 	void __iomem		*mbase = musb->mregs;
@@ -1031,7 +1031,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 	irqreturn_t		retval = IRQ_NONE;
 
 	/* ep0 only has one queue, "in" */
-	pUrb = next_urb(qh);
+	urb = next_urb(qh);
 
 	musb_ep_select(mbase, 0);
 	csr = musb_readw(epio, MUSB_CSR0);
@@ -1040,7 +1040,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 			: 0;
 
 	DBG(4, "<== csr0 %04x, qh %p, count %d, urb %p, stage %d\n",
-		csr, qh, len, pUrb, musb->ep0_stage);
+		csr, qh, len, urb, musb->ep0_stage);
 
 	/* if we just did status stage, we are done */
 	if (MGC_END0_STATUS == musb->ep0_stage) {
@@ -1074,8 +1074,8 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 	if (status) {
 		DBG(6, "aborting\n");
 		retval = IRQ_HANDLED;
-		if (pUrb)
-			pUrb->status = status;
+		if (urb)
+			urb->status = status;
 		bComplete = TRUE;
 
 		/* use the proper sequence to abort the transfer */
@@ -1098,7 +1098,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 		musb_writew(epio, MUSB_CSR0, 0);
 	}
 
-	if (unlikely(!pUrb)) {
+	if (unlikely(!urb)) {
 		/* stop endpoint since we have no place for its data, this
 		 * SHOULD NEVER HAPPEN! */
 		ERR("no URB for end 0\n");
@@ -1112,14 +1112,14 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 
 	if (!bComplete) {
 		/* call common logic and prepare response */
-		if (musb_h_ep0_continue(musb, len, pUrb)) {
+		if (musb_h_ep0_continue(musb, len, urb)) {
 			/* more packets required */
 			csr = (MGC_END0_IN == musb->ep0_stage)
 				?  MUSB_CSR0_H_REQPKT : MUSB_CSR0_TXPKTRDY;
 		} else {
 			/* data transfer complete; perform status phase */
-			if (usb_pipeout(pUrb->pipe)
-					|| !pUrb->transfer_buffer_length)
+			if (usb_pipeout(urb->pipe)
+					|| !urb->transfer_buffer_length)
 				csr = MUSB_CSR0_H_STATUSPKT
 					| MUSB_CSR0_H_REQPKT;
 			else
@@ -1139,7 +1139,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 
 	/* call completion handler if done */
 	if (bComplete)
-		musb_advance_schedule(musb, pUrb, hw_ep, 1);
+		musb_advance_schedule(musb, urb, hw_ep, 1);
 done:
 	return retval;
 }
@@ -1169,7 +1169,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 	u16			tx_csr;
 	size_t			wLength = 0;
 	u8			*pBuffer = NULL;
-	struct urb		*pUrb;
+	struct urb		*urb;
 	struct musb_hw_ep	*hw_ep = musb->endpoints + epnum;
 	void __iomem		*epio = hw_ep->regs;
 	struct musb_qh		*qh = hw_ep->out_qh;
@@ -1177,18 +1177,18 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 	void __iomem		*mbase = musb->mregs;
 	struct dma_channel	*dma;
 
-	pUrb = next_urb(qh);
+	urb = next_urb(qh);
 
 	musb_ep_select(mbase, epnum);
 	tx_csr = musb_readw(epio, MUSB_TXCSR);
 
 	/* with CPPI, DMA sometimes triggers "extra" irqs */
-	if (!pUrb) {
+	if (!urb) {
 		DBG(4, "extra TX%d ready, csr %04x\n", epnum, tx_csr);
 		goto finish;
 	}
 
-	nPipe = pUrb->pipe;
+	nPipe = urb->pipe;
 	dma = is_dma_capable() ? hw_ep->tx_channel : NULL;
 	DBG(4, "OUT/TX%d end, csr %04x%s\n", epnum, tx_csr,
 			dma ? ", dma" : "");
@@ -1268,13 +1268,13 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 		if (usb_pipeisoc(nPipe)) {
 			struct usb_iso_packet_descriptor	*d;
 
-			d = pUrb->iso_frame_desc + qh->iso_idx;
+			d = urb->iso_frame_desc + qh->iso_idx;
 			d->actual_length = qh->segsize;
-			if (++qh->iso_idx >= pUrb->number_of_packets) {
+			if (++qh->iso_idx >= urb->number_of_packets) {
 				bDone = TRUE;
 			} else if (!dma) {
 				d++;
-				pBuffer = pUrb->transfer_buffer + d->offset;
+				pBuffer = urb->transfer_buffer + d->offset;
 				wLength = d->length;
 			}
 		} else if (dma) {
@@ -1283,14 +1283,14 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 			/* see if we need to send more data, or ZLP */
 			if (qh->segsize < qh->maxpacket)
 				bDone = TRUE;
-			else if (qh->offset == pUrb->transfer_buffer_length
-					&& !(pUrb-> transfer_flags
+			else if (qh->offset == urb->transfer_buffer_length
+					&& !(urb-> transfer_flags
 							& URB_ZERO_PACKET))
 				bDone = TRUE;
 			if (!bDone) {
-				pBuffer = pUrb->transfer_buffer
+				pBuffer = urb->transfer_buffer
 						+ qh->offset;
-				wLength = pUrb->transfer_buffer_length
+				wLength = urb->transfer_buffer_length
 						- qh->offset;
 			}
 		}
@@ -1299,17 +1299,17 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 	/* urb->status != -EINPROGRESS means request has been faulted,
 	 * so we must abort this transfer after cleanup
 	 */
-	if (pUrb->status != -EINPROGRESS) {
+	if (urb->status != -EINPROGRESS) {
 		bDone = TRUE;
 		if (status == 0)
-			status = pUrb->status;
+			status = urb->status;
 	}
 
 	if (bDone) {
 		/* set status */
-		pUrb->status = status;
-		pUrb->actual_length = qh->offset;
-		musb_advance_schedule(musb, pUrb, hw_ep, USB_DIR_OUT);
+		urb->status = status;
+		urb->actual_length = qh->offset;
+		musb_advance_schedule(musb, urb, hw_ep, USB_DIR_OUT);
 
 	} else if (!(tx_csr & MUSB_TXCSR_DMAENAB)) {
 		// WARN_ON(!pBuffer);
@@ -1379,7 +1379,7 @@ finish:
  */
 void musb_host_rx(struct musb *musb, u8 epnum)
 {
-	struct urb		*pUrb;
+	struct urb		*urb;
 	struct musb_hw_ep	*hw_ep = musb->endpoints + epnum;
 	void __iomem		*epio = hw_ep->regs;
 	struct musb_qh		*qh = hw_ep->in_qh;
@@ -1394,14 +1394,14 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 
 	musb_ep_select(mbase, epnum);
 
-	pUrb = next_urb(qh);
+	urb = next_urb(qh);
 	dma = is_dma_capable() ? hw_ep->rx_channel : NULL;
 	status = 0;
 	xfer_len = 0;
 
 	wVal = rx_csr = musb_readw(epio, MUSB_RXCSR);
 
-	if (unlikely(!pUrb)) {
+	if (unlikely(!urb)) {
 		/* REVISIT -- THIS SHOULD NEVER HAPPEN ... but, at least
 		 * usbtest #11 (unlinks) triggers it regularly, sometimes
 		 * with fifo full.  (Only with DMA??)
@@ -1412,10 +1412,10 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 		return;
 	}
 
-	nPipe = pUrb->pipe;
+	nPipe = urb->pipe;
 
 	DBG(5, "<== hw %d rxcsr %04x, urb actual %d (+dma %zd)\n",
-		epnum, rx_csr, pUrb->actual_length,
+		epnum, rx_csr, urb->actual_length,
 		dma ? dma->actual_len : 0);
 
 	/* check for errors, concurrent stall & unlink is not really
@@ -1516,9 +1516,9 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 		musb_writew(hw_ep->regs, MUSB_RXCSR, wVal);
 
 #ifdef CONFIG_USB_INVENTRA_DMA
-		/* bDone if pUrb buffer is full or short packet is recd */
-		bDone = ((pUrb->actual_length + xfer_len) >=
-				pUrb->transfer_buffer_length)
+		/* bDone if urb buffer is full or short packet is recd */
+		bDone = ((urb->actual_length + xfer_len) >=
+				urb->transfer_buffer_length)
 			|| (dma->actual_len & (qh->maxpacket - 1));
 
 		/* send IN token for next packet, without AUTOREQ */
@@ -1535,7 +1535,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 #else
 		bDone = TRUE;
 #endif
-	} else if (pUrb->status == -EINPROGRESS) {
+	} else if (urb->status == -EINPROGRESS) {
 		/* if no errors, be sure a packet is ready for unloading */
 		if (unlikely(!(rx_csr & MUSB_RXCSR_RXPKTRDY))) {
 			status = -EPROTO;
@@ -1562,10 +1562,10 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 
 			DBG(2, "RX%d count %d, buffer 0x%x len %d/%d\n",
 					epnum, wRxCount,
-					pUrb->transfer_dma
-						+ pUrb->actual_length,
+					urb->transfer_dma
+						+ urb->actual_length,
 					qh->offset,
-					pUrb->transfer_buffer_length);
+					urb->transfer_buffer_length);
 
 			c = musb->dma_controller;
 
@@ -1574,10 +1574,10 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 			/* because of the issue below, mode 1 will
 			 * only rarely behave with correct semantics.
 			 */
-			if ((pUrb->transfer_flags &
+			if ((urb->transfer_flags &
 						URB_SHORT_NOT_OK)
-				&& (pUrb->transfer_buffer_length -
-						pUrb->actual_length)
+				&& (urb->transfer_buffer_length -
+						urb->actual_length)
 					> qh->maxpacket)
 				dma->desired_mode = 1;
 #endif
@@ -1618,11 +1618,11 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 			status = c->channel_program(
 				dma, qh->maxpacket,
 				dma->desired_mode,
-				pUrb->transfer_dma
-					+ pUrb->actual_length,
+				urb->transfer_dma
+					+ urb->actual_length,
 				(dma->desired_mode == 0)
 					? wRxCount
-					: pUrb->transfer_buffer_length);
+					: urb->transfer_buffer_length);
 
 			if (!status) {
 				c->channel_release(dma);
@@ -1633,19 +1633,19 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 #endif	/* Mentor DMA */
 
 		if (!dma) {
-			bDone = musb_host_packet_rx(musb, pUrb,
+			bDone = musb_host_packet_rx(musb, urb,
 					epnum, bIsochError);
 			DBG(6, "read %spacket\n", bDone ? "last " : "");
 		}
 	}
 
 finish:
-	pUrb->actual_length += xfer_len;
+	urb->actual_length += xfer_len;
 	qh->offset += xfer_len;
 	if (bDone) {
-		if (pUrb->status == -EINPROGRESS)
-			pUrb->status = status;
-		musb_advance_schedule(musb, pUrb, hw_ep, USB_DIR_IN);
+		if (urb->status == -EINPROGRESS)
+			urb->status = status;
+		musb_advance_schedule(musb, urb, hw_ep, USB_DIR_IN);
 	}
 }
 
@@ -1833,7 +1833,7 @@ static int musb_urb_enqueue(
 		 * transfer scheduling logic to try some other qh, e.g. try
 		 * for 2 msec first:
 		 *
-		 * interval = (USB_SPEED_HIGH == pUrb->dev->speed) ? 16 : 2;
+		 * interval = (USB_SPEED_HIGH == urb->dev->speed) ? 16 : 2;
 		 *
 		 * The downside of disabling this is that transfer scheduling
 		 * gets VERY unfair for nonperiodic transfers; a misbehaving
-- 
1.5.2.3
