From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/36] musb_hdrc: Search and replace wCsr with csr
Date: Thu, 16 Aug 2007 02:40:26 -0700
Message-ID: <11872572672740-git-send-email-tony@atomide.com>
References: <11872572591844-git-send-email-tony@atomide.com>
	<11872572612810-git-send-email-tony@atomide.com>
	<11872572643880-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11872572643880-git-send-email-tony@atomide.com>
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

Search and replace wCsr with csr. Also manually
fix remaining RxCsr comments.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_gadget.c |   56 +++++++++++++++++++-------------------
 drivers/usb/musb/musb_host.c   |   58 ++++++++++++++++++++--------------------
 drivers/usb/musb/musbhsdma.c   |   20 +++++++-------
 3 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 2cb3353..b27096a 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -622,7 +622,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 				c = musb->dma_controller;
 				channel = musb_ep->dma;
 
-	/* We use DMA Req mode 0 in RxCsr, and DMA controller operates in
+	/* We use DMA Req mode 0 in rx_csr, and DMA controller operates in
 	 * mode 0 only. So we do not get endpoint interrupts due to DMA
 	 * completion. We only get interrupts from DMA controller.
 	 *
@@ -635,7 +635,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	 * that last pckate should trigger an overflow fault.)  But in mode 1,
 	 * we don't get DMA completion interrrupt for short packets.
 	 *
-	 * Theoretically, we could enable DMAReq interrupt (RxCsr_DMAMODE = 1),
+	 * Theoretically, we could enable DMAReq interrupt (MUSB_RXCSR_DMAMODE = 1),
 	 * to get endpoint interrupt on every DMA req, but that didn't seem
 	 * to work reliably.
 	 *
@@ -1235,7 +1235,7 @@ int musb_gadget_set_halt(struct usb_ep *ep, int value)
 	void __iomem		*epio = musb->endpoints[epnum].regs;
 	void __iomem		*mbase;
 	unsigned long		flags;
-	u16			wCsr;
+	u16			csr;
 	struct musb_request	*request = NULL;
 	int			status = 0;
 
@@ -1255,8 +1255,8 @@ int musb_gadget_set_halt(struct usb_ep *ep, int value)
 	/* cannot portably stall with non-empty FIFO */
 	request = to_musb_request(next_request(musb_ep));
 	if (value && musb_ep->is_in) {
-		wCsr = musb_readw(epio, MUSB_TXCSR);
-		if (wCsr & MUSB_TXCSR_FIFONOTEMPTY) {
+		csr = musb_readw(epio, MUSB_TXCSR);
+		if (csr & MUSB_TXCSR_FIFONOTEMPTY) {
 			DBG(3, "%s fifo busy, cannot halt\n", ep->name);
 			spin_unlock_irqrestore(&musb->lock, flags);
 			return -EAGAIN;
@@ -1267,29 +1267,29 @@ int musb_gadget_set_halt(struct usb_ep *ep, int value)
 	/* set/clear the stall and toggle bits */
 	DBG(2, "%s: %s stall\n", ep->name, value ? "set" : "clear");
 	if (musb_ep->is_in) {
-		wCsr = musb_readw(epio, MUSB_TXCSR);
-		if (wCsr & MUSB_TXCSR_FIFONOTEMPTY)
-			wCsr |= MUSB_TXCSR_FLUSHFIFO;
-		wCsr |= MUSB_TXCSR_P_WZC_BITS
+		csr = musb_readw(epio, MUSB_TXCSR);
+		if (csr & MUSB_TXCSR_FIFONOTEMPTY)
+			csr |= MUSB_TXCSR_FLUSHFIFO;
+		csr |= MUSB_TXCSR_P_WZC_BITS
 			| MUSB_TXCSR_CLRDATATOG;
 		if (value)
-			wCsr |= MUSB_TXCSR_P_SENDSTALL;
+			csr |= MUSB_TXCSR_P_SENDSTALL;
 		else
-			wCsr &= ~(MUSB_TXCSR_P_SENDSTALL
+			csr &= ~(MUSB_TXCSR_P_SENDSTALL
 				| MUSB_TXCSR_P_SENTSTALL);
-		wCsr &= ~MUSB_TXCSR_TXPKTRDY;
-		musb_writew(epio, MUSB_TXCSR, wCsr);
+		csr &= ~MUSB_TXCSR_TXPKTRDY;
+		musb_writew(epio, MUSB_TXCSR, csr);
 	} else {
-		wCsr = musb_readw(epio, MUSB_RXCSR);
-		wCsr |= MUSB_RXCSR_P_WZC_BITS
+		csr = musb_readw(epio, MUSB_RXCSR);
+		csr |= MUSB_RXCSR_P_WZC_BITS
 			| MUSB_RXCSR_FLUSHFIFO
 			| MUSB_RXCSR_CLRDATATOG;
 		if (value)
-			wCsr |= MUSB_RXCSR_P_SENDSTALL;
+			csr |= MUSB_RXCSR_P_SENDSTALL;
 		else
-			wCsr &= ~(MUSB_RXCSR_P_SENDSTALL
+			csr &= ~(MUSB_RXCSR_P_SENDSTALL
 				| MUSB_RXCSR_P_SENTSTALL);
-		musb_writew(epio, MUSB_RXCSR, wCsr);
+		musb_writew(epio, MUSB_RXCSR, csr);
 	}
 
 done:
@@ -1335,7 +1335,7 @@ static void musb_gadget_fifo_flush(struct usb_ep *ep)
 	void __iomem	*epio = musb->endpoints[nEnd].regs;
 	void __iomem	*mbase;
 	unsigned long	flags;
-	u16		wCsr, wIntrTxE;
+	u16		csr, wIntrTxE;
 
 	mbase = musb->mregs;
 
@@ -1347,18 +1347,18 @@ static void musb_gadget_fifo_flush(struct usb_ep *ep)
 	musb_writew(mbase, MUSB_INTRTXE, wIntrTxE & ~(1 << nEnd));
 
 	if (musb_ep->is_in) {
-		wCsr = musb_readw(epio, MUSB_TXCSR);
-		if (wCsr & MUSB_TXCSR_FIFONOTEMPTY) {
-			wCsr |= MUSB_TXCSR_FLUSHFIFO | MUSB_TXCSR_P_WZC_BITS;
-			musb_writew(epio, MUSB_TXCSR, wCsr);
+		csr = musb_readw(epio, MUSB_TXCSR);
+		if (csr & MUSB_TXCSR_FIFONOTEMPTY) {
+			csr |= MUSB_TXCSR_FLUSHFIFO | MUSB_TXCSR_P_WZC_BITS;
+			musb_writew(epio, MUSB_TXCSR, csr);
 			/* REVISIT may be inappropriate w/o FIFONOTEMPTY ... */
-			musb_writew(epio, MUSB_TXCSR, wCsr);
+			musb_writew(epio, MUSB_TXCSR, csr);
 		}
 	} else {
-		wCsr = musb_readw(epio, MUSB_RXCSR);
-		wCsr |= MUSB_RXCSR_FLUSHFIFO | MUSB_RXCSR_P_WZC_BITS;
-		musb_writew(epio, MUSB_RXCSR, wCsr);
-		musb_writew(epio, MUSB_RXCSR, wCsr);
+		csr = musb_readw(epio, MUSB_RXCSR);
+		csr |= MUSB_RXCSR_FLUSHFIFO | MUSB_RXCSR_P_WZC_BITS;
+		musb_writew(epio, MUSB_RXCSR, csr);
+		musb_writew(epio, MUSB_RXCSR, csr);
 	}
 
 	/* re-enable interrupt */
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 795e13e..f5b5445 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -471,7 +471,7 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *pUrb,
 {
 	u16 wRxCount;
 	u8 *pBuffer;
-	u16 wCsr;
+	u16 csr;
 	u8 bDone = FALSE;
 	u32			length;
 	int			do_flush = 0;
@@ -544,16 +544,16 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *pUrb,
 
 	musb_read_fifo(hw_ep, length, pBuffer);
 
-	wCsr = musb_readw(epio, MUSB_RXCSR);
-	wCsr |= MUSB_RXCSR_H_WZC_BITS;
+	csr = musb_readw(epio, MUSB_RXCSR);
+	csr |= MUSB_RXCSR_H_WZC_BITS;
 	if (unlikely(do_flush))
-		musb_h_flush_rxfifo(hw_ep, wCsr);
+		musb_h_flush_rxfifo(hw_ep, csr);
 	else {
 		/* REVISIT this assumes AUTOCLEAR is never set */
-		wCsr &= ~(MUSB_RXCSR_RXPKTRDY | MUSB_RXCSR_H_REQPKT);
+		csr &= ~(MUSB_RXCSR_RXPKTRDY | MUSB_RXCSR_H_REQPKT);
 		if (!bDone)
-			wCsr |= MUSB_RXCSR_H_REQPKT;
-		musb_writew(epio, MUSB_RXCSR, wCsr);
+			csr |= MUSB_RXCSR_H_REQPKT;
+		musb_writew(epio, MUSB_RXCSR, csr);
 	}
 
 	return bDone;
@@ -672,11 +672,11 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 
 	/* OUT/transmit/EP0 or IN/receive? */
 	if (is_out) {
-		u16	wCsr;
+		u16	csr;
 		u16	wIntrTxE;
 		u16	wLoadCount;
 
-		wCsr = musb_readw(epio, MUSB_TXCSR);
+		csr = musb_readw(epio, MUSB_TXCSR);
 
 		/* disable interrupt in case we flush */
 		wIntrTxE = musb_readw(mbase, MUSB_INTRTXE);
@@ -684,7 +684,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 
 		/* general endpoint setup */
 		if (epnum) {
-			u16	csr = wCsr;
+			u16	csr = csr;
 
 			/* ASSERT:  TXCSR_DMAENAB was already cleared */
 
@@ -710,13 +710,13 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			musb_writew(epio, MUSB_TXCSR, csr);
 			/* REVISIT may need to clear FLUSHFIFO ... */
 			musb_writew(epio, MUSB_TXCSR, csr);
-			wCsr = musb_readw(epio, MUSB_TXCSR);
+			csr = musb_readw(epio, MUSB_TXCSR);
 		} else {
 			/* endpoint 0: just flush */
 			musb_writew(epio, MUSB_CSR0,
-				wCsr | MUSB_CSR0_FLUSHFIFO);
+				csr | MUSB_CSR0_FLUSHFIFO);
 			musb_writew(epio, MUSB_CSR0,
-				wCsr | MUSB_CSR0_FLUSHFIFO);
+				csr | MUSB_CSR0_FLUSHFIFO);
 		}
 
 		/* target addr and (for multipoint) hub addr/port */
@@ -763,13 +763,13 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 		if (pDmaChannel) {
 
 			/* clear previous state */
-			wCsr = musb_readw(epio, MUSB_TXCSR);
-			wCsr &= ~(MUSB_TXCSR_AUTOSET
+			csr = musb_readw(epio, MUSB_TXCSR);
+			csr &= ~(MUSB_TXCSR_AUTOSET
 				| MUSB_TXCSR_DMAMODE
 				| MUSB_TXCSR_DMAENAB);
-                        wCsr |= MUSB_TXCSR_MODE;
+                        csr |= MUSB_TXCSR_MODE;
 			musb_writew(epio, MUSB_TXCSR,
-				wCsr | MUSB_TXCSR_MODE);
+				csr | MUSB_TXCSR_MODE);
 
 			qh->segsize = min(dwLength, pDmaChannel->max_len);
 
@@ -780,16 +780,16 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 
 
 			if (pDmaChannel->desired_mode == 0) {
-				wCsr &= ~(MUSB_TXCSR_AUTOSET
+				csr &= ~(MUSB_TXCSR_AUTOSET
 					| MUSB_TXCSR_DMAMODE);
-				wCsr |= (MUSB_TXCSR_DMAENAB);
+				csr |= (MUSB_TXCSR_DMAENAB);
 					// against programming guide
 			} else
-				wCsr |= (MUSB_TXCSR_AUTOSET
+				csr |= (MUSB_TXCSR_AUTOSET
 					| MUSB_TXCSR_DMAENAB
 					| MUSB_TXCSR_DMAMODE);
 
-			musb_writew(epio, MUSB_TXCSR, wCsr);
+			musb_writew(epio, MUSB_TXCSR, csr);
 
 			bDmaOk = dma_controller->channel_program(
 					pDmaChannel, packet_sz,
@@ -816,13 +816,13 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			 * assume CPPI setup succeeds.
 			 * defer enabling dma.
 			 */
-			wCsr = musb_readw(epio, MUSB_TXCSR);
-			wCsr &= ~(MUSB_TXCSR_AUTOSET
+			csr = musb_readw(epio, MUSB_TXCSR);
+			csr &= ~(MUSB_TXCSR_AUTOSET
 					| MUSB_TXCSR_DMAMODE
 					| MUSB_TXCSR_DMAENAB);
-			wCsr |= MUSB_TXCSR_MODE;
+			csr |= MUSB_TXCSR_MODE;
 			musb_writew(epio, MUSB_TXCSR,
-				wCsr | MUSB_TXCSR_MODE);
+				csr | MUSB_TXCSR_MODE);
 
 			pDmaChannel->actual_len = 0L;
 			qh->segsize = dwLength;
@@ -856,15 +856,15 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			/* PIO to load FIFO */
 			qh->segsize = wLoadCount;
 			musb_write_fifo(hw_ep, wLoadCount, pBuffer);
-			wCsr = musb_readw(epio, MUSB_TXCSR);
-			wCsr &= ~(MUSB_TXCSR_DMAENAB
+			csr = musb_readw(epio, MUSB_TXCSR);
+			csr &= ~(MUSB_TXCSR_DMAENAB
 				| MUSB_TXCSR_DMAMODE
 				| MUSB_TXCSR_AUTOSET);
 			/* write CSR */
-			wCsr |= MUSB_TXCSR_MODE;
+			csr |= MUSB_TXCSR_MODE;
 
 			if (epnum)
-				musb_writew(epio, MUSB_TXCSR, wCsr);
+				musb_writew(epio, MUSB_TXCSR, csr);
 		}
 
 		/* re-enable interrupt */
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 864ede0..7641f1a 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -179,29 +179,29 @@ static void configure_channel(struct dma_channel *pChannel,
 	struct musb_dma_controller *pController = pImplChannel->pController;
 	u8 *mbase = pController->pCoreBase;
 	u8 bChannel = pImplChannel->bIndex;
-	u16 wCsr = 0;
+	u16 csr = 0;
 
 	DBG(4, "%p, pkt_sz %d, addr 0x%x, len %d, mode %d\n",
 	    pChannel, packet_sz, dma_addr, dwLength, mode);
 
 	if (mode) {
-		wCsr |= 1 << MUSB_HSDMA_MODE1_SHIFT;
+		csr |= 1 << MUSB_HSDMA_MODE1_SHIFT;
 		if (dwLength < packet_sz) {
 			return FALSE;
 		}
 		if (packet_sz >= 64) {
-			wCsr |=
+			csr |=
 			    MGC_HSDMA_BURSTMODE_INCR16 << MUSB_HSDMA_BURSTMODE_SHIFT;
 		} else if (packet_sz >= 32) {
-			wCsr |=
+			csr |=
 			    MGC_HSDMA_BURSTMODE_INCR8 << MUSB_HSDMA_BURSTMODE_SHIFT;
 		} else if (packet_sz >= 16) {
-			wCsr |=
+			csr |=
 			    MGC_HSDMA_BURSTMODE_INCR4 << MUSB_HSDMA_BURSTMODE_SHIFT;
 		}
 	}
 
-	wCsr |= (pImplChannel->epnum << MUSB_HSDMA_ENDPOINT_SHIFT)
+	csr |= (pImplChannel->epnum << MUSB_HSDMA_ENDPOINT_SHIFT)
 		| (1 << MUSB_HSDMA_ENABLE_SHIFT)
 		| (1 << MUSB_HSDMA_IRQENABLE_SHIFT)
 		| (pImplChannel->bTransmit ? (1 << MUSB_HSDMA_TRANSMIT_SHIFT) : 0);
@@ -217,7 +217,7 @@ static void configure_channel(struct dma_channel *pChannel,
 	/* control (this should start things) */
 	musb_writew(mbase,
 		    MGC_HSDMA_CHANNEL_OFFSET(bChannel, MGC_O_HSDMA_CONTROL),
-		    wCsr);
+		    csr);
 }
 
 static int dma_channel_program(struct dma_channel * pChannel,
@@ -302,7 +302,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 	u8 *mbase = pController->pCoreBase;
 	struct dma_channel *pChannel;
 	u8 bChannel;
-	u16 wCsr;
+	u16 csr;
 	u32 dwAddress;
 	u8 bIntr;
 	irqreturn_t retval = IRQ_NONE;
@@ -317,11 +317,11 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 					&(pController->aChannel[bChannel]);
 			pChannel = &pImplChannel->Channel;
 
-			wCsr = musb_readw(mbase,
+			csr = musb_readw(mbase,
 				       MGC_HSDMA_CHANNEL_OFFSET(bChannel,
 							MGC_O_HSDMA_CONTROL));
 
-			if (wCsr & (1 << MUSB_HSDMA_BUSERROR_SHIFT)) {
+			if (csr & (1 << MUSB_HSDMA_BUSERROR_SHIFT)) {
 				pImplChannel->Channel.status =
 				    MGC_DMA_STATUS_BUS_ABORT;
 			} else {
-- 
1.5.2.3
