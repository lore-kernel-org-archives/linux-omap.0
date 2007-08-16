From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/36]_csr
Date: Thu, 16 Aug 2007 02:40:25 -0700
Message-ID: <11872572643880-git-send-email-tony@atomide.com>
References: <11872572591844-git-send-email-tony@atomide.com>
	<11872572612810-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11872572612810-git-send-email-tony@atomide.com>
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

Search and replace w[RT]xCsrVal with [rt]_csr

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c |   50 +++++++++++++++++++++---------------------
 1 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index cd91e13..795e13e 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1166,7 +1166,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 {
 	int			nPipe;
 	u8			bDone = FALSE;
-	u16			wTxCsrVal;
+	u16			tx_csr;
 	size_t			wLength = 0;
 	u8			*pBuffer = NULL;
 	struct urb		*pUrb;
@@ -1180,34 +1180,34 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 	pUrb = next_urb(qh);
 
 	musb_ep_select(mbase, epnum);
-	wTxCsrVal = musb_readw(epio, MUSB_TXCSR);
+	tx_csr = musb_readw(epio, MUSB_TXCSR);
 
 	/* with CPPI, DMA sometimes triggers "extra" irqs */
 	if (!pUrb) {
-		DBG(4, "extra TX%d ready, csr %04x\n", epnum, wTxCsrVal);
+		DBG(4, "extra TX%d ready, csr %04x\n", epnum, tx_csr);
 		goto finish;
 	}
 
 	nPipe = pUrb->pipe;
 	dma = is_dma_capable() ? hw_ep->tx_channel : NULL;
-	DBG(4, "OUT/TX%d end, csr %04x%s\n", epnum, wTxCsrVal,
+	DBG(4, "OUT/TX%d end, csr %04x%s\n", epnum, tx_csr,
 			dma ? ", dma" : "");
 
 	/* check for errors */
-	if (wTxCsrVal & MUSB_TXCSR_H_RXSTALL) {
+	if (tx_csr & MUSB_TXCSR_H_RXSTALL) {
 		/* dma was disabled, fifo flushed */
 		DBG(3, "TX end %d stall\n", epnum);
 
 		/* stall; record URB status */
 		status = -EPIPE;
 
-	} else if (wTxCsrVal & MUSB_TXCSR_H_ERROR) {
+	} else if (tx_csr & MUSB_TXCSR_H_ERROR) {
 		/* (NON-ISO) dma was disabled, fifo flushed */
 		DBG(3, "TX 3strikes on ep=%d\n", epnum);
 
 		status = -ETIMEDOUT;
 
-	} else if (wTxCsrVal & MUSB_TXCSR_H_NAKTIMEOUT) {
+	} else if (tx_csr & MUSB_TXCSR_H_NAKTIMEOUT) {
 		DBG(6, "TX end=%d device not responding\n", epnum);
 
 		/* NOTE:  this code path would be a good place to PAUSE a
@@ -1234,7 +1234,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 		 * usb core; the dma engine should already be stopped.
 		 */
 		musb_h_tx_flush_fifo(hw_ep);
-		wTxCsrVal &= ~(MUSB_TXCSR_AUTOSET
+		tx_csr &= ~(MUSB_TXCSR_AUTOSET
 				| MUSB_TXCSR_DMAENAB
 				| MUSB_TXCSR_H_ERROR
 				| MUSB_TXCSR_H_RXSTALL
@@ -1242,9 +1242,9 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 				);
 
 		musb_ep_select(mbase, epnum);
-		musb_writew(epio, MUSB_TXCSR, wTxCsrVal);
+		musb_writew(epio, MUSB_TXCSR, tx_csr);
 		/* REVISIT may need to clear FLUSHFIFO ... */
-		musb_writew(epio, MUSB_TXCSR, wTxCsrVal);
+		musb_writew(epio, MUSB_TXCSR, tx_csr);
 		musb_writeb(epio, MUSB_TXINTERVAL, 0);
 
 		bDone = TRUE;
@@ -1252,7 +1252,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 
 	/* second cppi case */
 	if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
-		DBG(4, "extra TX%d ready, csr %04x\n", epnum, wTxCsrVal);
+		DBG(4, "extra TX%d ready, csr %04x\n", epnum, tx_csr);
 		goto finish;
 
 	}
@@ -1311,7 +1311,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 		pUrb->actual_length = qh->offset;
 		musb_advance_schedule(musb, pUrb, hw_ep, USB_DIR_OUT);
 
-	} else if (!(wTxCsrVal & MUSB_TXCSR_DMAENAB)) {
+	} else if (!(tx_csr & MUSB_TXCSR_DMAENAB)) {
 		// WARN_ON(!pBuffer);
 
 		/* REVISIT:  some docs say that when hw_ep->tx_double_buffered,
@@ -1386,7 +1386,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 	size_t			xfer_len;
 	void __iomem		*mbase = musb->mregs;
 	int			nPipe;
-	u16			wRxCsrVal, wVal;
+	u16			rx_csr, wVal;
 	u8			bIsochError = FALSE;
 	u8			bDone = FALSE;
 	u32			status;
@@ -1399,7 +1399,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 	status = 0;
 	xfer_len = 0;
 
-	wVal = wRxCsrVal = musb_readw(epio, MUSB_RXCSR);
+	wVal = rx_csr = musb_readw(epio, MUSB_RXCSR);
 
 	if (unlikely(!pUrb)) {
 		/* REVISIT -- THIS SHOULD NEVER HAPPEN ... but, at least
@@ -1415,24 +1415,24 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 	nPipe = pUrb->pipe;
 
 	DBG(5, "<== hw %d rxcsr %04x, urb actual %d (+dma %zd)\n",
-		epnum, wRxCsrVal, pUrb->actual_length,
+		epnum, rx_csr, pUrb->actual_length,
 		dma ? dma->actual_len : 0);
 
 	/* check for errors, concurrent stall & unlink is not really
 	 * handled yet! */
-	if (wRxCsrVal & MUSB_RXCSR_H_RXSTALL) {
+	if (rx_csr & MUSB_RXCSR_H_RXSTALL) {
 		DBG(3, "RX end %d STALL\n", epnum);
 
 		/* stall; record URB status */
 		status = -EPIPE;
 
-	} else if (wRxCsrVal & MUSB_RXCSR_H_ERROR) {
+	} else if (rx_csr & MUSB_RXCSR_H_ERROR) {
 		DBG(3, "end %d RX proto error\n", epnum);
 
 		status = -EPROTO;
 		musb_writeb(epio, MUSB_RXINTERVAL, 0);
 
-	} else if (wRxCsrVal & MUSB_RXCSR_DATAERROR) {
+	} else if (rx_csr & MUSB_RXCSR_DATAERROR) {
 
 		if (USB_ENDPOINT_XFER_ISOC != qh->type) {
 			/* NOTE this code path would be a good place to PAUSE a
@@ -1472,7 +1472,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 
 	if (unlikely(dma_channel_status(dma) == MGC_DMA_STATUS_BUSY)) {
 		/* SHOULD NEVER HAPPEN ... but at least DaVinci has done it */
-		ERR("RX%d dma busy, csr %04x\n", epnum, wRxCsrVal);
+		ERR("RX%d dma busy, csr %04x\n", epnum, rx_csr);
 		goto finish;
 	}
 
@@ -1484,7 +1484,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 	/* FIXME this is _way_ too much in-line logic for Mentor DMA */
 
 #ifndef CONFIG_USB_INVENTRA_DMA
-	if (wRxCsrVal & MUSB_RXCSR_H_REQPKT)  {
+	if (rx_csr & MUSB_RXCSR_H_REQPKT)  {
 		/* REVISIT this happened for a while on some short reads...
 		 * the cleanup still needs investigation... looks bad...
 		 * and also duplicates dma cleanup code above ... plus,
@@ -1497,16 +1497,16 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 			bDone = TRUE;
 		}
 
-		DBG(2, "RXCSR%d %04x, reqpkt, len %zd%s\n", epnum, wRxCsrVal,
+		DBG(2, "RXCSR%d %04x, reqpkt, len %zd%s\n", epnum, rx_csr,
 				xfer_len, dma ? ", dma" : "");
-		wRxCsrVal &= ~MUSB_RXCSR_H_REQPKT;
+		rx_csr &= ~MUSB_RXCSR_H_REQPKT;
 
 		musb_ep_select(mbase, epnum);
 		musb_writew(epio, MUSB_RXCSR,
-				MUSB_RXCSR_H_WZC_BITS | wRxCsrVal);
+				MUSB_RXCSR_H_WZC_BITS | rx_csr);
 	}
 #endif
-	if (dma && (wRxCsrVal & MUSB_RXCSR_DMAENAB)) {
+	if (dma && (rx_csr & MUSB_RXCSR_DMAENAB)) {
 		xfer_len = dma->actual_len;
 
 		wVal &= ~(MUSB_RXCSR_DMAENAB
@@ -1537,7 +1537,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 #endif
 	} else if (pUrb->status == -EINPROGRESS) {
 		/* if no errors, be sure a packet is ready for unloading */
-		if (unlikely(!(wRxCsrVal & MUSB_RXCSR_RXPKTRDY))) {
+		if (unlikely(!(rx_csr & MUSB_RXCSR_RXPKTRDY))) {
 			status = -EPROTO;
 			ERR("Rx interrupt with no errors or packet!\n");
 
-- 
1.5.2.3
