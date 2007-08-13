From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 19/52] musb_hdrc: Search and replace MGC_SelectEnd with
	musb_ep_select
Date: Mon, 13 Aug 2007 06:48:54 -0700
Message-ID: <11870130153038-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11870130122117-git-send-email-tony@atomide.com>
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

Search and replace MGC_SelectEnd with musb_ep_select

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/cppi_dma.c      |    8 ++++----
 drivers/usb/musb/g_ep0.c         |   18 +++++++++---------
 drivers/usb/musb/musb_gadget.c   |   24 ++++++++++++------------
 drivers/usb/musb/musb_host.c     |   24 ++++++++++++------------
 drivers/usb/musb/musb_procfs.c   |    2 +-
 drivers/usb/musb/musbdefs.h      |    6 +++---
 drivers/usb/musb/musbhsdma.c     |    2 +-
 drivers/usb/musb/plat_uds.c      |   10 +++++-----
 drivers/usb/musb/tusb6010_omap.c |    6 +++---
 9 files changed, 50 insertions(+), 50 deletions(-)

--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -357,7 +357,7 @@ cppi_dump_rx(int level, struct cppi_channel *c, const char *tag)
 {
 	void	*__iomem base = c->pController->pCoreBase;
 
-	MGC_SelectEnd(base, c->chNo + 1);
+	musb_ep_select(base, c->chNo + 1);
 
 	DBG(level, "RX DMA%d%s: %d left, csr %04x, "
 			"%08x H%08x S%08x C%08x, "
@@ -386,7 +386,7 @@ cppi_dump_tx(int level, struct cppi_channel *c, const char *tag)
 {
 	void	*__iomem base = c->pController->pCoreBase;
 
-	MGC_SelectEnd(base, c->chNo + 1);
+	musb_ep_select(base, c->chNo + 1);
 
 	DBG(level, "TX DMA%d%s: csr %04x, "
 			"H%08x S%08x C%08x %08x, "
@@ -1094,7 +1094,7 @@ static int cppi_rx_scan(struct cppi *cppi, unsigned ch)
 			 */
 			WARN_ON(rx->activeQueueHead);
 		}
-		MGC_SelectEnd(cppi->pCoreBase, rx->chNo + 1);
+		musb_ep_select(cppi->pCoreBase, rx->chNo + 1);
 		csr = musb_readw(regs, MGC_O_HDRC_RXCSR);
 		if (csr & MGC_M_RXCSR_DMAENAB) {
 			DBG(4, "list%d %p/%p, last %08x%s, csr %04x\n",
@@ -1404,7 +1404,7 @@ static int cppi_channel_abort(struct dma_channel *channel)
 	 * and caller should rely on us not changing it.
 	 * peripheral code is safe ... check host too.
 	 */
-	MGC_SelectEnd(mbase, chNum + 1);
+	musb_ep_select(mbase, chNum + 1);
 
 	if (otgCh->bTransmit) {
 		struct cppi_tx_stateram	*__iomem txState;
--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -127,14 +127,14 @@ static int service_tx_status_request(
 			break;
 		}
 
-		MGC_SelectEnd(mbase, epnum);
+		musb_ep_select(mbase, epnum);
 		if (is_in)
 			tmp = musb_readw(regs, MGC_O_HDRC_TXCSR)
 						& MGC_M_TXCSR_P_SENDSTALL;
 		else
 			tmp = musb_readw(regs, MGC_O_HDRC_RXCSR)
 						& MGC_M_RXCSR_P_SENDSTALL;
-		MGC_SelectEnd(mbase, 0);
+		musb_ep_select(mbase, 0);
 
 		bResult[0] = tmp ? 1 : 0;
 		} break;
@@ -278,7 +278,7 @@ __acquires(musb->lock)
 				spin_lock(&musb->lock);
 
 				/* select ep0 again */
-				MGC_SelectEnd(mbase, 0);
+				musb_ep_select(mbase, 0);
 				handled = 1;
 				} break;
 			default:
@@ -388,7 +388,7 @@ stall:
 				if (!musb_ep->desc)
 					break;
 
-				MGC_SelectEnd(mbase, epnum);
+				musb_ep_select(mbase, epnum);
 				if (is_in) {
 					csr = musb_readw(regs,
 							MGC_O_HDRC_TXCSR);
@@ -411,7 +411,7 @@ stall:
 				}
 
 				/* select ep0 again */
-				MGC_SelectEnd(mbase, 0);
+				musb_ep_select(mbase, 0);
 				handled = 1;
 				} break;
 
@@ -604,7 +604,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 	void __iomem	*regs = musb->endpoints[0].regs;
 	irqreturn_t	retval = IRQ_NONE;
 
-	MGC_SelectEnd(mbase, 0);	/* select ep0 */
+	musb_ep_select(mbase, 0);	/* select ep0 */
 	wCsrVal = musb_readw(regs, MGC_O_HDRC_CSR0);
 	len = musb_readb(regs, MGC_O_HDRC_COUNT0);
 
@@ -769,7 +769,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 
 			handled = forward_to_driver(musb, &setup);
 			if (handled < 0) {
-				MGC_SelectEnd(mbase, 0);
+				musb_ep_select(mbase, 0);
 stall:
 				DBG(3, "stall (%d)\n", handled);
 				musb->ackpend |= MGC_M_CSR0_P_SENDSTALL;
@@ -864,7 +864,7 @@ musb_g_ep0_queue(struct usb_ep *e, struct usb_request *r, gfp_t gfp_flags)
 			ep->name, ep->is_in ? "IN/TX" : "OUT/RX",
 			req->request.length);
 
-	MGC_SelectEnd(musb->mregs, 0);
+	musb_ep_select(musb->mregs, 0);
 
 	/* sequence #1, IN ... start writing the data */
 	if (musb->ep0_state == MGC_END0_STAGE_TX)
@@ -933,7 +933,7 @@ static int musb_g_ep0_halt(struct usb_ep *e, int value)
 	case MGC_END0_STAGE_RX:		/* control-OUT data */
 		status = 0;
 
-		MGC_SelectEnd(base, 0);
+		musb_ep_select(base, 0);
 		csr = musb_readw(regs, MGC_O_HDRC_CSR0);
 		csr |= MGC_M_CSR0_P_SENDSTALL;
 		musb_writew(regs, MGC_O_HDRC_CSR0, csr);
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -411,7 +411,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 	void __iomem		*epio = musb->endpoints[epnum].regs;
 	struct dma_channel	*dma;
 
-	MGC_SelectEnd(mbase, epnum);
+	musb_ep_select(mbase, epnum);
 	pRequest = next_request(musb_ep);
 
 	wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
@@ -514,7 +514,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 				 * REVISIT for double buffering...
 				 * FIXME revisit for stalls too...
 				 */
-				MGC_SelectEnd(mbase, epnum);
+				musb_ep_select(mbase, epnum);
 				wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
 				if (wCsrVal & MGC_M_TXCSR_FIFONOTEMPTY)
 					break;
@@ -741,7 +741,7 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 	void __iomem		*epio = musb->endpoints[epnum].regs;
 	struct dma_channel	*dma;
 
-	MGC_SelectEnd(mbase, epnum);
+	musb_ep_select(mbase, epnum);
 
 	pRequest = next_request(musb_ep);
 
@@ -826,7 +826,7 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 			goto done;
 
 		/* don't start more i/o till the stall clears */
-		MGC_SelectEnd(mbase, epnum);
+		musb_ep_select(mbase, epnum);
 		wCsrVal = musb_readw(epio, MGC_O_HDRC_RXCSR);
 		if (wCsrVal & MGC_M_RXCSR_P_SENDSTALL)
 			goto done;
@@ -892,7 +892,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 	/* enable the interrupts for the endpoint, set the endpoint
 	 * packet size (or fail), set the mode, clear the fifo
 	 */
-	MGC_SelectEnd(mbase, epnum);
+	musb_ep_select(mbase, epnum);
 	if (desc->bEndpointAddress & USB_DIR_IN) {
 		u16 wIntrTxE = musb_readw(mbase, MGC_O_HDRC_INTRTXE);
 
@@ -1010,7 +1010,7 @@ static int musb_gadget_disable(struct usb_ep *ep)
 	epio = musb->endpoints[epnum].regs;
 
 	spin_lock_irqsave(&musb->lock, flags);
-	MGC_SelectEnd(musb->mregs, epnum);
+	musb_ep_select(musb->mregs, epnum);
 
 	/* zero the endpoint sizes */
 	if (musb_ep->is_in) {
@@ -1086,7 +1086,7 @@ static void musb_ep_restart(struct musb *musb, struct musb_request *req)
 		req->bTx ? "TX/IN" : "RX/OUT",
 		&req->request, req->request.length, req->epnum);
 
-	MGC_SelectEnd(musb->mregs, req->epnum);
+	musb_ep_select(musb->mregs, req->epnum);
 	if (req->bTx)
 		txstate(musb, req);
 	else
@@ -1201,7 +1201,7 @@ static int musb_gadget_dequeue(struct usb_ep *ep, struct usb_request *pRequest)
 	else if (is_dma_capable() && musb_ep->dma) {
 		struct dma_controller	*c = musb->pDmaController;
 
-		MGC_SelectEnd(musb->mregs, musb_ep->current_epnum);
+		musb_ep_select(musb->mregs, musb_ep->current_epnum);
 		if (c->channel_abort)
 			status = c->channel_abort(musb_ep->dma);
 		else
@@ -1249,7 +1249,7 @@ int musb_gadget_set_halt(struct usb_ep *ep, int value)
 		goto done;
 	}
 
-	MGC_SelectEnd(mbase, epnum);
+	musb_ep_select(mbase, epnum);
 
 	/* cannot portably stall with non-empty FIFO */
 	pRequest = to_musb_request(next_request(musb_ep));
@@ -1317,7 +1317,7 @@ static int musb_gadget_fifo_status(struct usb_ep *ep)
 
 		spin_lock_irqsave(&musb->lock, flags);
 
-		MGC_SelectEnd(mbase, epnum);
+		musb_ep_select(mbase, epnum);
 		/* FIXME return zero unless RXPKTRDY is set */
 		retval = musb_readw(epio, MGC_O_HDRC_RXCOUNT);
 
@@ -1339,7 +1339,7 @@ static void musb_gadget_fifo_flush(struct usb_ep *ep)
 	mbase = musb->mregs;
 
 	spin_lock_irqsave(&musb->lock, flags);
-	MGC_SelectEnd(mbase, (u8) nEnd);
+	musb_ep_select(mbase, (u8) nEnd);
 
 	/* disable interrupts */
 	wIntrTxE = musb_readw(mbase, MGC_O_HDRC_INTRTXE);
@@ -1799,7 +1799,7 @@ stop_activity(struct musb *musb, struct usb_gadget_driver *driver)
 		for (i = 0, hw_ep = musb->endpoints;
 				i < musb->nr_endpoints;
 				i++, hw_ep++) {
-			MGC_SelectEnd(musb->mregs, i);
+			musb_ep_select(musb->mregs, i);
 			if (hw_ep->bIsSharedFifo /* || !epnum */) {
 				nuke(&hw_ep->ep_in, -ESHUTDOWN);
 			} else {
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -481,7 +481,7 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *pUrb,
 	int			nPipe = pUrb->pipe;
 	void			*buffer = pUrb->transfer_buffer;
 
-	// MGC_SelectEnd(mbase, epnum);
+	// musb_ep_select(mbase, epnum);
 	wRxCount = musb_readw(epio, MGC_O_HDRC_RXCOUNT);
 	DBG(3, "RX%d count %d, buffer %p len %d/%d\n", epnum, wRxCount,
 			pUrb->transfer_buffer, qh->offset,
@@ -651,7 +651,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			qh->h_addr_reg, qh->h_port_reg,
 			dwLength);
 
-	MGC_SelectEnd(mbase, epnum);
+	musb_ep_select(mbase, epnum);
 
 	/* candidate for DMA? */
 	pDmaController = musb->pDmaController;
@@ -1033,7 +1033,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 	/* ep0 only has one queue, "in" */
 	pUrb = next_urb(qh);
 
-	MGC_SelectEnd(mbase, 0);
+	musb_ep_select(mbase, 0);
 	wCsrVal = musb_readw(epio, MGC_O_HDRC_CSR0);
 	len = (wCsrVal & MGC_M_CSR0_RXPKTRDY)
 			? musb_readb(epio, MGC_O_HDRC_COUNT0)
@@ -1179,7 +1179,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 
 	pUrb = next_urb(qh);
 
-	MGC_SelectEnd(mbase, epnum);
+	musb_ep_select(mbase, epnum);
 	wTxCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
 
 	/* with CPPI, DMA sometimes triggers "extra" irqs */
@@ -1217,7 +1217,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 		 * if (bulk && qh->ring.next != &musb->out_bulk), then
 		 * we have a candidate... NAKing is *NOT* an error
 		 */
-		MGC_SelectEnd(mbase, epnum);
+		musb_ep_select(mbase, epnum);
 		musb_writew(epio, MGC_O_HDRC_CSR0,
 				MGC_M_TXCSR_H_WZC_BITS
 				| MGC_M_TXCSR_TXPKTRDY);
@@ -1241,7 +1241,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 				| MGC_M_TXCSR_H_NAKTIMEOUT
 				);
 
-		MGC_SelectEnd(mbase, epnum);
+		musb_ep_select(mbase, epnum);
 		musb_writew(epio, MGC_O_HDRC_TXCSR, wTxCsrVal);
 		/* REVISIT may need to clear FLUSHFIFO ... */
 		musb_writew(epio, MGC_O_HDRC_TXCSR, wTxCsrVal);
@@ -1323,7 +1323,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 		musb_write_fifo(hw_ep, wLength, pBuffer);
 		qh->segsize = wLength;
 
-		MGC_SelectEnd(mbase, epnum);
+		musb_ep_select(mbase, epnum);
 		musb_writew(epio, MGC_O_HDRC_TXCSR,
 				MGC_M_TXCSR_H_WZC_BITS | MGC_M_TXCSR_TXPKTRDY);
 	} else
@@ -1392,7 +1392,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 	u32			status;
 	struct dma_channel	*dma;
 
-	MGC_SelectEnd(mbase, epnum);
+	musb_ep_select(mbase, epnum);
 
 	pUrb = next_urb(qh);
 	dma = is_dma_capable() ? hw_ep->rx_channel : NULL;
@@ -1443,7 +1443,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 			 * we have a candidate... NAKing is *NOT* an error
 			 */
 			DBG(6, "RX end %d NAK timeout\n", epnum);
-			MGC_SelectEnd(mbase, epnum);
+			musb_ep_select(mbase, epnum);
 			musb_writew(epio, MGC_O_HDRC_RXCSR,
 					MGC_M_RXCSR_H_WZC_BITS
 					| MGC_M_RXCSR_H_REQPKT);
@@ -1501,7 +1501,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 				xfer_len, dma ? ", dma" : "");
 		wRxCsrVal &= ~MGC_M_RXCSR_H_REQPKT;
 
-		MGC_SelectEnd(mbase, epnum);
+		musb_ep_select(mbase, epnum);
 		musb_writew(epio, MGC_O_HDRC_RXCSR,
 				MGC_M_RXCSR_H_WZC_BITS | wRxCsrVal);
 	}
@@ -1545,7 +1545,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 
 // SCRUB (RX)
 			/* do the proper sequence to abort the transfer */
-			MGC_SelectEnd(mbase, epnum);
+			musb_ep_select(mbase, epnum);
 			wVal &= ~MGC_M_RXCSR_H_REQPKT;
 			musb_writew(epio, MGC_O_HDRC_RXCSR, wVal);
 			goto finish;
@@ -1908,7 +1908,7 @@ static int musb_cleanup_urb(struct urb *urb, struct musb_qh *qh, int is_in)
 	u16			csr;
 	int			status = 0;
 
-	MGC_SelectEnd(regs, hw_end);
+	musb_ep_select(regs, hw_end);
 
 	if (is_dma_capable()) {
 		struct dma_channel	*dma;
--- a/drivers/usb/musb/musb_procfs.c
+++ b/drivers/usb/musb/musb_procfs.c
@@ -240,7 +240,7 @@ dump_end_info(struct musb *musb, u8 epnum, char *aBuffer, unsigned max)
 	struct musb_hw_ep	*hw_ep = &musb->endpoints[epnum];
 
 	do {
-		MGC_SelectEnd(musb->mregs, epnum);
+		musb_ep_select(musb->mregs, epnum);
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 		if (is_host_active(musb)) {
 			int		dump_rx, dump_tx;
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -218,18 +218,18 @@ enum musb_g_ep0_state {
 
 /* TUSB mapping: "flat" plus ep0 special cases */
 #if	defined(CONFIG_USB_TUSB6010)
-#define MGC_SelectEnd(_mbase, _epnum) \
+#define musb_ep_select(_mbase, _epnum) \
 	musb_writeb((_mbase), MGC_O_HDRC_INDEX, (_epnum))
 #define	MGC_END_OFFSET			MGC_TUSB_OFFSET
 
 /* "flat" mapping: each endpoint has its own i/o address */
 #elif	defined(MUSB_FLAT_REG)
-#define MGC_SelectEnd(_mbase, _epnum)	(((void)(_mbase)),((void)(_epnum)))
+#define musb_ep_select(_mbase, _epnum)	(((void)(_mbase)),((void)(_epnum)))
 #define	MGC_END_OFFSET			MGC_FLAT_OFFSET
 
 /* "indexed" mapping: INDEX register controls register bank select */
 #else
-#define MGC_SelectEnd(_mbase, _epnum) \
+#define musb_ep_select(_mbase, _epnum) \
 	musb_writeb((_mbase), MGC_O_HDRC_INDEX, (_epnum))
 #define	MGC_END_OFFSET			MGC_INDEXED_OFFSET
 #endif
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -353,7 +353,7 @@ static irqreturn_t dma_controller_irq(int irq, void *pPrivateData)
 					    (pImplChannel->wMaxPacketSize - 1)))
 				   ) {
 					/* Send out the packet */
-					MGC_SelectEnd(mbase,
+					musb_ep_select(mbase,
 						pImplChannel->epnum);
 					musb_writew(mbase,
 						MGC_END_OFFSET(pImplChannel->epnum,MGC_O_HDRC_TXCSR),
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -273,7 +273,7 @@ void musb_load_testpacket(struct musb *musb)
 {
 	void __iomem	*regs = musb->endpoints[0].regs;
 
-	MGC_SelectEnd(musb->mregs, 0);
+	musb_ep_select(musb->mregs, 0);
 	musb_write_fifo(musb->control_ep,
 			sizeof(musb_test_packet), musb_test_packet);
 	musb_writew(regs, MGC_O_HDRC_CSR0, MGC_M_CSR0_TXPKTRDY);
@@ -1187,7 +1187,7 @@ static int __init ep_config_from_hw(struct musb *musb)
 	/* FIXME pick up ep0 maxpacket size */
 
 	for (epnum = 1; epnum < MUSB_C_NUM_EPS; epnum++) {
-		MGC_SelectEnd(mbase, epnum);
+		musb_ep_select(mbase, epnum);
 		hw_ep = musb->endpoints + epnum;
 
 		/* read from core using indexed model */
@@ -1257,7 +1257,7 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 	int		i;
 
 	/* log core options (read using indexed model) */
-	MGC_SelectEnd(mbase, 0);
+	musb_ep_select(mbase, 0);
 	reg = musb_readb(mbase, 0x10 + MGC_O_HDRC_CONFIGDATA);
 
 	strcpy(aInfo, (reg & MGC_M_CONFIGDATA_UTMIDW) ? "UTMI-16" : "UTMI-8");
@@ -1486,7 +1486,7 @@ irqreturn_t musb_interrupt(struct musb *musb)
 	ep_num = 1;
 	while (reg) {
 		if (reg & 1) {
-			// MGC_SelectEnd(musb->mregs, ep_num);
+			// musb_ep_select(musb->mregs, ep_num);
 			/* REVISIT just retval = ep->rx_irq(...) */
 			retval = IRQ_HANDLED;
 			if (devctl & MGC_M_DEVCTL_HM) {
@@ -1507,7 +1507,7 @@ irqreturn_t musb_interrupt(struct musb *musb)
 	ep_num = 1;
 	while (reg) {
 		if (reg & 1) {
-			// MGC_SelectEnd(musb->mregs, ep_num);
+			// musb_ep_select(musb->mregs, ep_num);
 			/* REVISIT just retval |= ep->tx_irq(...) */
 			retval = IRQ_HANDLED;
 			if (devctl & MGC_M_DEVCTL_HM) {
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -222,7 +222,7 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 
 		if (chdat->tx) {
 			DBG(2, "terminating short tx packet\n");
-			MGC_SelectEnd(musb_base, chdat->epnum);
+			musb_ep_select(musb_base, chdat->epnum);
 			csr = musb_readw(hw_ep->regs, MGC_O_HDRC_TXCSR);
 			csr |= MGC_M_TXCSR_MODE | MGC_M_TXCSR_TXPKTRDY
 				| MGC_M_TXCSR_P_WZC_BITS;
@@ -375,14 +375,14 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 	 * Prepare MUSB for DMA transfer
 	 */
 	if (chdat->tx) {
-		MGC_SelectEnd(musb_base, chdat->epnum);
+		musb_ep_select(musb_base, chdat->epnum);
 		csr = musb_readw(hw_ep->regs, MGC_O_HDRC_TXCSR);
 		csr |= (MGC_M_TXCSR_AUTOSET | MGC_M_TXCSR_DMAENAB
 			| MGC_M_TXCSR_DMAMODE | MGC_M_TXCSR_MODE);
 		csr &= ~MGC_M_TXCSR_P_UNDERRUN;
 		musb_writew(hw_ep->regs, MGC_O_HDRC_TXCSR, csr);
 	} else {
-		MGC_SelectEnd(musb_base, chdat->epnum);
+		musb_ep_select(musb_base, chdat->epnum);
 		csr = musb_readw(hw_ep->regs, MGC_O_HDRC_RXCSR);
 		csr |= MGC_M_RXCSR_DMAENAB;
 		csr &= ~(MGC_M_RXCSR_AUTOCLEAR | MGC_M_RXCSR_DMAMODE);
-- 
1.5.2.3
