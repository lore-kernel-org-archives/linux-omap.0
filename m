From: David Brownell <david-b@pacbell.net>
Subject: [patch 2/3] musb_hdrc, remove MGC_ReadCsr16()
Date: Thu, 18 Jan 2007 15:38:02 -0800
Message-ID: <200701181538.02914.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

More camelcase fixes:  remove MGC_ReadCsr16.

Note that these changes are not just code cleanup, but they're also
code shrinks and speedups because the endpoint access routines no
longer need to calclate the offsets they're using...

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: o26/drivers/usb/musb/musbdefs.h
===================================================================
--- o26.orig/drivers/usb/musb/musbdefs.h	2007-01-18 06:28:16.000000000 -0800
+++ o26/drivers/usb/musb/musbdefs.h	2007-01-18 06:53:10.000000000 -0800
@@ -232,13 +232,9 @@ enum musb_g_ep0_state {
  * using hw_ep->regs, for all access except writing INDEX
  */
 #ifdef	MUSB_FLAT_REG
-#define MGC_ReadCsr16(_pBase, _bOffset, _bEnd) \
-	musb_readw((_pBase), MGC_END_OFFSET((_bEnd), (_bOffset)))
 #define MGC_WriteCsr16(_pBase, _bOffset, _bEnd, _bData) \
 	musb_writew((_pBase), MGC_END_OFFSET((_bEnd), (_bOffset)), (_bData))
 #else
-#define MGC_ReadCsr16(_pBase, _bOffset, _bEnd) \
-	musb_readw(_pBase, (_bOffset + 0x10))
 #define MGC_WriteCsr16(_pBase, _bOffset, _bEnd, _bData) \
 	musb_writew(_pBase, (_bOffset + 0x10), _bData)
 #endif
Index: o26/drivers/usb/musb/musb_gadget.c
===================================================================
--- o26.orig/drivers/usb/musb/musb_gadget.c	2007-01-18 03:26:20.000000000 -0800
+++ o26/drivers/usb/musb/musb_gadget.c	2007-01-18 06:48:17.000000000 -0800
@@ -240,14 +240,14 @@ static inline int max_ep_writesize(struc
  */
 static void txstate(struct musb *pThis, struct musb_request *req)
 {
-	u8			bEnd;
+	u8			bEnd = req->bEnd;
 	struct musb_ep		*pEnd;
+	void __iomem		*epio = pThis->aLocalEnd[bEnd].regs;
 	struct usb_request	*pRequest;
 	void __iomem		*pBase = pThis->pRegs;
 	u16			wFifoCount = 0, wCsrVal;
 	int			use_dma = 0;
 
-	bEnd = req->bEnd;
 	pEnd = req->ep;
 
 	/* we shouldn't get here while DMA is active ... but we do ... */
@@ -257,7 +257,7 @@ static void txstate(struct musb *pThis, 
 	}
 
 	/* read TXCSR before */
-	wCsrVal = MGC_ReadCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd);
+	wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
 
 	pRequest = &req->request;
 	wFifoCount = min(max_ep_writesize(pThis, pEnd),
@@ -336,7 +336,7 @@ static void txstate(struct musb *pThis, 
 				| wCsrVal);
 
 		/* ensure writebuffer is empty */
-		wCsrVal = MGC_ReadCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd);
+		wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
 
 		/* NOTE host side sets DMAENAB later than this; both are
 		 * OK since the transfer dma glue (between CPPI and Mentor
@@ -383,9 +383,9 @@ static void txstate(struct musb *pThis, 
 	DBG(3, "%s TX/IN %s len %d/%d, txcsr %04x, fifo %d/%d\n",
 			pEnd->end_point.name, use_dma ? "dma" : "pio",
 			pRequest->actual, pRequest->length,
-			MGC_ReadCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd),
+			musb_readw(epio, MGC_O_HDRC_TXCSR),
 			wFifoCount,
-			MGC_ReadCsr16(pBase, MGC_O_HDRC_TXMAXP, bEnd));
+			musb_readw(epio, MGC_O_HDRC_TXMAXP));
 }
 
 /*
@@ -397,14 +397,14 @@ void musb_g_tx(struct musb *pThis, u8 bE
 	u16			wCsrVal;
 	struct usb_request	*pRequest;
 	u8 __iomem		*pBase = pThis->pRegs;
-	struct musb_ep		*pEnd;
+	struct musb_ep		*pEnd = &pThis->aLocalEnd[bEnd].ep_in;
+	void __iomem		*epio = pThis->aLocalEnd[bEnd].regs;
 	struct dma_channel	*dma;
 
 	MGC_SelectEnd(pBase, bEnd);
-	pEnd = &pThis->aLocalEnd[bEnd].ep_in;
 	pRequest = next_request(pEnd);
 
-	wCsrVal = MGC_ReadCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd);
+	wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
 	DBG(4, "<== %s, txcsr %04x\n", pEnd->end_point.name, wCsrVal);
 
 	dma = is_dma_capable() ? pEnd->dma : NULL;
@@ -456,8 +456,7 @@ void musb_g_tx(struct musb *pThis, u8 bE
 				MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd,
 					wCsrVal);
 				/* ensure writebuffer is empty */
-				wCsrVal = MGC_ReadCsr16(pBase,
-						MGC_O_HDRC_TXCSR, bEnd);
+				wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
 				DBG(4, "TXCSR%d %04x, dma off, "
 						"len %Zd, req %p\n",
 					bEnd, wCsrVal,
@@ -506,8 +505,7 @@ void musb_g_tx(struct musb *pThis, u8 bE
 				 * FIXME revisit for stalls too...
 				 */
 				MGC_SelectEnd(pBase, bEnd);
-				wCsrVal = MGC_ReadCsr16(pBase,
-						MGC_O_HDRC_TXCSR, bEnd);
+				wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
 				if (wCsrVal & MGC_M_TXCSR_FIFONOTEMPTY)
 					break;
 				pRequest = pEnd->desc
@@ -569,10 +567,11 @@ static void rxstate(struct musb *pThis, 
 	struct usb_request	*pRequest = &req->request;
 	void __iomem		*pBase = pThis->pRegs;
 	struct musb_ep		*pEnd = &pThis->aLocalEnd[bEnd].ep_out;
+	void __iomem		*epio = pThis->aLocalEnd[bEnd].regs;
 	u16			wFifoCount = 0;
 	u16			wCount = pEnd->wPacketSize;
 
-	wCsrVal = MGC_ReadCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd);
+	wCsrVal = musb_readw(epio, MGC_O_HDRC_RXCSR);
 
 	if (is_cppi_enabled() && pEnd->dma) {
 		struct dma_controller	*c = pThis->pDmaController;
@@ -602,7 +601,7 @@ static void rxstate(struct musb *pThis, 
 	}
 
 	if (wCsrVal & MGC_M_RXCSR_RXPKTRDY) {
-		wCount = MGC_ReadCsr16(pBase, MGC_O_HDRC_RXCOUNT, bEnd);
+		wCount = musb_readw(epio, MGC_O_HDRC_RXCOUNT);
 		if (pRequest->actual < pRequest->length) {
 #ifdef CONFIG_USB_INVENTRA_DMA
 			if (is_dma_capable() && pEnd->dma) {
@@ -731,15 +730,15 @@ void musb_g_rx(struct musb *pThis, u8 bE
 	u16			wCsrVal;
 	struct usb_request	*pRequest;
 	void __iomem		*pBase = pThis->pRegs;
-	struct musb_ep		*pEnd;
+	struct musb_ep		*pEnd = &pThis->aLocalEnd[bEnd].ep_out;
+	void __iomem		*epio = pThis->aLocalEnd[bEnd].regs;
 	struct dma_channel	*dma;
 
 	MGC_SelectEnd(pBase, bEnd);
 
-	pEnd = &pThis->aLocalEnd[bEnd].ep_out;
 	pRequest = next_request(pEnd);
 
-	wCsrVal = MGC_ReadCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd);
+	wCsrVal = musb_readw(epio, MGC_O_HDRC_RXCSR);
 	dma = is_dma_capable() ? pEnd->dma : NULL;
 
 	DBG(4, "<== %s, rxcsr %04x%s %p\n", pEnd->end_point.name,
@@ -794,7 +793,7 @@ void musb_g_rx(struct musb *pThis, u8 bE
 
 		DBG(4, "RXCSR%d %04x, dma off, %04x, len %Zd, req %p\n",
 			bEnd, wCsrVal,
-			MGC_ReadCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd),
+			musb_readw(epio, MGC_O_HDRC_RXCSR),
 			pEnd->dma->dwActualLength, pRequest);
 
 #if defined(CONFIG_USB_INVENTRA_DMA) || defined(CONFIG_USB_TUSB_OMAP_DMA)
@@ -821,7 +820,7 @@ void musb_g_rx(struct musb *pThis, u8 bE
 
 		/* don't start more i/o till the stall clears */
 		MGC_SelectEnd(pBase, bEnd);
-		wCsrVal = MGC_ReadCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd);
+		wCsrVal = musb_readw(epio, MGC_O_HDRC_RXCSR);
 		if (wCsrVal & MGC_M_RXCSR_P_SENDSTALL)
 			goto done;
 	}
@@ -1270,21 +1269,16 @@ done:
  */
 int musb_gadget_set_halt(struct usb_ep *ep, int value)
 {
-	struct musb_ep		*pEnd;
-	u8			bEnd;
-	struct musb		*pThis;
+	struct musb_ep		*pEnd = to_musb_ep(ep);
+	u8			bEnd = pEnd->bEndNumber;
+	struct musb		*pThis = pEnd->pThis;
+	void __iomem		*epio = pThis->aLocalEnd[bEnd].regs;
 	void __iomem		*pBase;
 	unsigned long		flags;
 	u16			wCsr;
 	struct musb_request	*pRequest = NULL;
 	int			status = 0;
 
-	if (!ep)
-		return -EINVAL;
-
-	pEnd = to_musb_ep(ep);
-	bEnd = pEnd->bEndNumber;
-	pThis = pEnd->pThis;
 	pBase = pThis->pRegs;
 
 	spin_lock_irqsave(&pThis->Lock, flags);
@@ -1299,7 +1293,7 @@ int musb_gadget_set_halt(struct usb_ep *
 	/* cannot portably stall with non-empty FIFO */
 	pRequest = to_musb_request(next_request(pEnd));
 	if (value && pEnd->is_in) {
-		wCsr = MGC_ReadCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd);
+		wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
 		if (wCsr & MGC_M_TXCSR_FIFONOTEMPTY) {
 			DBG(3, "%s fifo busy, cannot halt\n", ep->name);
 			spin_unlock_irqrestore(&pThis->Lock, flags);
@@ -1311,7 +1305,7 @@ int musb_gadget_set_halt(struct usb_ep *
 	/* set/clear the stall and toggle bits */
 	DBG(2, "%s: %s stall\n", ep->name, value ? "set" : "clear");
 	if (pEnd->is_in) {
-		wCsr = MGC_ReadCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd);
+		wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
 		if (wCsr & MGC_M_TXCSR_FIFONOTEMPTY)
 			wCsr |= MGC_M_TXCSR_FLUSHFIFO;
 		wCsr |= MGC_M_TXCSR_P_WZC_BITS
@@ -1324,7 +1318,7 @@ int musb_gadget_set_halt(struct usb_ep *
 		wCsr &= ~MGC_M_TXCSR_TXPKTRDY;
 		MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd, wCsr);
 	} else {
-		wCsr = MGC_ReadCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd);
+		wCsr = musb_readw(epio, MGC_O_HDRC_RXCSR);
 		wCsr |= MGC_M_RXCSR_P_WZC_BITS
 			| MGC_M_RXCSR_FLUSHFIFO
 			| MGC_M_RXCSR_CLRDATATOG;
@@ -1351,6 +1345,7 @@ done:
 static int musb_gadget_fifo_status(struct usb_ep *ep)
 {
 	struct musb_ep		*musb_ep = to_musb_ep(ep);
+	void __iomem		*epio = musb_ep->hw_ep->regs;
 	int			retval = -EINVAL;
 
 	if (musb_ep->desc && !musb_ep->is_in) {
@@ -1363,7 +1358,7 @@ static int musb_gadget_fifo_status(struc
 
 		MGC_SelectEnd(mbase, bEnd);
 		/* FIXME return zero unless RXPKTRDY is set */
-		retval = MGC_ReadCsr16(mbase, MGC_O_HDRC_RXCOUNT, bEnd);
+		retval = musb_readw(epio, MGC_O_HDRC_RXCOUNT);
 
 		spin_unlock_irqrestore(&musb->Lock, flags);
 	}
@@ -1373,15 +1368,14 @@ static int musb_gadget_fifo_status(struc
 static void musb_gadget_fifo_flush(struct usb_ep *ep)
 {
 	struct musb_ep	*musb_ep = to_musb_ep(ep);
-	struct musb	*musb;
+	struct musb	*musb = musb_ep->pThis;
+	u8		nEnd = musb_ep->bEndNumber;
+	void __iomem	*epio = musb->aLocalEnd[nEnd].regs;
 	void __iomem	*mbase;
-	u8		nEnd;
 	unsigned long	flags;
 	u16		wCsr, wIntrTxE;
 
-	musb = musb_ep->pThis;
 	mbase = musb->pRegs;
-	nEnd = musb_ep->bEndNumber;
 
 	spin_lock_irqsave(&musb->Lock, flags);
 	MGC_SelectEnd(mbase, (u8) nEnd);
@@ -1391,7 +1385,7 @@ static void musb_gadget_fifo_flush(struc
 	musb_writew(mbase, MGC_O_HDRC_INTRTXE, wIntrTxE & ~(1 << nEnd));
 
 	if (musb_ep->is_in) {
-		wCsr = MGC_ReadCsr16(mbase, MGC_O_HDRC_TXCSR, nEnd);
+		wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
 		if (wCsr & MGC_M_TXCSR_FIFONOTEMPTY) {
 			wCsr |= MGC_M_TXCSR_FLUSHFIFO | MGC_M_TXCSR_P_WZC_BITS;
 			MGC_WriteCsr16(mbase, MGC_O_HDRC_TXCSR, nEnd, wCsr);
@@ -1399,7 +1393,7 @@ static void musb_gadget_fifo_flush(struc
 			MGC_WriteCsr16(mbase, MGC_O_HDRC_TXCSR, nEnd, wCsr);
 		}
 	} else {
-		wCsr = MGC_ReadCsr16(mbase, MGC_O_HDRC_RXCSR, nEnd);
+		wCsr = musb_readw(epio, MGC_O_HDRC_RXCSR);
 		wCsr |= MGC_M_RXCSR_FLUSHFIFO | MGC_M_RXCSR_P_WZC_BITS;
 		MGC_WriteCsr16(mbase, MGC_O_HDRC_RXCSR, nEnd, wCsr);
 		MGC_WriteCsr16(mbase, MGC_O_HDRC_RXCSR, nEnd, wCsr);
Index: o26/drivers/usb/musb/musb_host.c
===================================================================
--- o26.orig/drivers/usb/musb/musb_host.c	2007-01-18 06:28:16.000000000 -0800
+++ o26/drivers/usb/musb/musb_host.c	2007-01-18 06:55:11.000000000 -0800
@@ -292,7 +292,7 @@ static inline void musb_save_toggle(stru
 {
 	struct usb_device	*udev = urb->dev;
 	u16			csr;
-	void __iomem		*hw = ep->musb->pRegs;
+	void __iomem		*epio = ep->regs;
 	struct musb_qh		*qh;
 
 	/* FIXME:  the current Mentor DMA code seems to have
@@ -305,14 +305,12 @@ static inline void musb_save_toggle(stru
 		qh = ep->out_qh;
 
 	if (!is_in) {
-		csr = MGC_ReadCsr16(hw, MGC_O_HDRC_TXCSR,
-				ep->bLocalEnd);
+		csr = musb_readw(epio, MGC_O_HDRC_TXCSR);
 		usb_settoggle(udev, qh->epnum, 1,
 			(csr & MGC_M_TXCSR_H_DATATOGGLE)
 				? 1 : 0);
 	} else {
-		csr = MGC_ReadCsr16(hw, MGC_O_HDRC_RXCSR,
-				ep->bLocalEnd);
+		csr = musb_readw(epio, MGC_O_HDRC_RXCSR);
 		usb_settoggle(udev, qh->epnum, 0,
 			(csr & MGC_M_RXCSR_H_DATATOGGLE)
 				? 1 : 0);
@@ -471,12 +469,13 @@ static u8 musb_host_packet_rx(struct mus
 	int			do_flush = 0;
 	void __iomem		*pBase = pThis->pRegs;
 	struct musb_hw_ep	*pEnd = pThis->aLocalEnd + bEnd;
+	void __iomem		*epio = pEnd->regs;
 	struct musb_qh		*qh = pEnd->in_qh;
 	int			nPipe = pUrb->pipe;
 	void			*buffer = pUrb->transfer_buffer;
 
 	// MGC_SelectEnd(pBase, bEnd);
-	wRxCount = MGC_ReadCsr16(pBase, MGC_O_HDRC_RXCOUNT, bEnd);
+	wRxCount = musb_readw(epio, MGC_O_HDRC_RXCOUNT);
 
 	/* unload FIFO */
 	if (usb_pipeisoc(nPipe)) {
@@ -535,7 +534,7 @@ static u8 musb_host_packet_rx(struct mus
 
 	musb_read_fifo(pEnd, length, pBuffer);
 
-	wCsr = MGC_ReadCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd);
+	wCsr = musb_readw(epio, MGC_O_HDRC_RXCSR);
 	wCsr |= MGC_M_RXCSR_H_WZC_BITS;
 	if (unlikely(do_flush))
 		musb_h_flush_rxfifo(pEnd, wCsr);
@@ -672,7 +671,7 @@ static void musb_ep_program(struct musb 
 		u16	wIntrTxE;
 		u16	wLoadCount;
 
-		wCsr = MGC_ReadCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd);
+		wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
 
 		/* disable interrupt in case we flush */
 		wIntrTxE = musb_readw(pBase, MGC_O_HDRC_INTRTXE);
@@ -710,8 +709,7 @@ static void musb_ep_program(struct musb 
 			/* REVISIT may need to clear FLUSHFIFO ... */
 			MGC_WriteCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd,
 					csr);
-			wCsr = MGC_ReadCsr16(pBase, MGC_O_HDRC_TXCSR,
-					bEnd);
+			wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
 		} else {
 			/* endpoint 0: just flush */
 			MGC_WriteCsr16(pBase, MGC_O_HDRC_CSR0, bEnd,
@@ -764,7 +762,7 @@ static void musb_ep_program(struct musb 
 		if (pDmaChannel) {
 
 			/* clear previous state */
-			wCsr = MGC_ReadCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd);
+			wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
 			wCsr &= ~(MGC_M_TXCSR_AUTOSET
 				| MGC_M_TXCSR_DMAMODE
 				| MGC_M_TXCSR_DMAENAB);
@@ -817,7 +815,7 @@ static void musb_ep_program(struct musb 
 			 * assume CPPI setup succeeds.
 			 * defer enabling dma.
 			 */
-			wCsr = MGC_ReadCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd);
+			wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
 			wCsr &= ~(MGC_M_TXCSR_AUTOSET
 					| MGC_M_TXCSR_DMAMODE
 					| MGC_M_TXCSR_DMAENAB);
@@ -857,7 +855,7 @@ static void musb_ep_program(struct musb 
 			/* PIO to load FIFO */
 			qh->segsize = wLoadCount;
 			musb_write_fifo(pEnd, wLoadCount, pBuffer);
-			wCsr = MGC_ReadCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd);
+			wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
 			wCsr &= ~(MGC_M_TXCSR_DMAENAB
 				| MGC_M_TXCSR_DMAMODE
 				| MGC_M_TXCSR_AUTOSET);
@@ -1042,7 +1040,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *
 	pUrb = next_urb(qh);
 
 	MGC_SelectEnd(pBase, 0);
-	wCsrVal = MGC_ReadCsr16(pBase, MGC_O_HDRC_CSR0, 0);
+	wCsrVal = musb_readw(epio, MGC_O_HDRC_CSR0);
 	wCount = musb_readb(epio, MGC_O_HDRC_COUNT0);
 
 	DBG(4, "<== csr0 %04x, qh %p, count %d, urb %p, stage %d\n",
@@ -1181,7 +1179,7 @@ void musb_host_tx(struct musb *pThis, u8
 	pUrb = next_urb(qh);
 
 	MGC_SelectEnd(pBase, bEnd);
-	wTxCsrVal = MGC_ReadCsr16(pBase, MGC_O_HDRC_TXCSR, bEnd);
+	wTxCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
 
 	/* with CPPI, DMA sometimes triggers "extra" irqs */
 	if (!pUrb) {
@@ -1417,7 +1415,7 @@ void musb_host_rx(struct musb *pThis, u8
 	status = 0;
 	xfer_len = 0;
 
-	wVal = wRxCsrVal = MGC_ReadCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd);
+	wVal = wRxCsrVal = musb_readw(epio, MGC_O_HDRC_RXCSR);
 
 	if (unlikely(!pUrb)) {
 		/* REVISIT -- THIS SHOULD NEVER HAPPEN ... but, at least
@@ -1425,7 +1423,7 @@ void musb_host_rx(struct musb *pThis, u8
 		 * with fifo full.  (Only with DMA??)
 		 */
 		DBG(3, "BOGUS RX%d ready, csr %04x, count %d\n", bEnd, wVal,
-			MGC_ReadCsr16(pBase, MGC_O_HDRC_RXCOUNT, bEnd));
+			musb_readw(epio, MGC_O_HDRC_RXCOUNT));
 		musb_h_flush_rxfifo(pEnd, MGC_M_RXCSR_CLRDATATOG);
 		return;
 	}
@@ -1550,8 +1548,8 @@ void musb_host_rx(struct musb *pThis, u8
 
 		DBG(4, "ep %d dma %s, rxcsr %04x, rxcount %d\n", bEnd,
 			bDone ? "off" : "reset",
-			MGC_ReadCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd),
-			MGC_ReadCsr16(pBase, MGC_O_HDRC_RXCOUNT, bEnd));
+			musb_readw(epio, MGC_O_HDRC_RXCSR),
+			musb_readw(epio, MGC_O_HDRC_RXCOUNT));
 #else
 		bDone = TRUE;
 #endif
@@ -1578,8 +1576,7 @@ void musb_host_rx(struct musb *pThis, u8
 			u16			wRxCount;
 			int			status;
 
-			wRxCount = MGC_ReadCsr16(pBase,
-					MGC_O_HDRC_RXCOUNT, bEnd);
+			wRxCount = musb_readw(epio, MGC_O_HDRC_RXCOUNT);
 
 			DBG(2, "RX%d count %d, buffer 0x%x len %d/%d\n",
 					bEnd, wRxCount,
@@ -1620,7 +1617,7 @@ void musb_host_rx(struct musb *pThis, u8
  *	wait for an interrupt when the pkt is recd. Well, you won't get any!
  */
 
-			wVal = MGC_ReadCsr16(pBase, MGC_O_HDRC_RXCSR, bEnd);
+			wVal = musb_readw(epio, MGC_O_HDRC_RXCSR);
 			wVal &= ~MGC_M_RXCSR_H_REQPKT;
 
 			if (dma->bDesiredMode == 0)
@@ -1923,6 +1920,7 @@ done:
 static int musb_cleanup_urb(struct urb *urb, struct musb_qh *qh, int is_in)
 {
 	struct musb_hw_ep	*ep = qh->hw_ep;
+	void __iomem		*epio = ep->regs;
 	unsigned		hw_end = ep->bLocalEnd;
 	void __iomem		*regs = ep->musb->pRegs;
 	u16			csr;
@@ -1955,7 +1953,7 @@ static int musb_cleanup_urb(struct urb *
 		 */
 	} else {
 // SCRUB (TX)
-		csr = MGC_ReadCsr16(regs, MGC_O_HDRC_TXCSR, hw_end);
+		csr = musb_readw(epio, MGC_O_HDRC_TXCSR);
 		if (csr & MGC_M_TXCSR_FIFONOTEMPTY)
 			csr |= MGC_M_TXCSR_FLUSHFIFO;
 		csr &= ~( MGC_M_TXCSR_AUTOSET
@@ -1969,7 +1967,7 @@ static int musb_cleanup_urb(struct urb *
 		/* REVISIT may need to clear FLUSHFIFO ... */
 		MGC_WriteCsr16(regs, MGC_O_HDRC_TXCSR, 0, csr);
 		/* flush cpu writebuffer */
-		csr = MGC_ReadCsr16(regs, MGC_O_HDRC_TXCSR, hw_end);
+		csr = musb_readw(epio, MGC_O_HDRC_TXCSR);
 	}
 	if (status == 0)
 		musb_advance_schedule(ep->musb, urb, ep, is_in);
