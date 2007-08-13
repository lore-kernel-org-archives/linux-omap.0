From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/52] musb_hdrc: Search and replace pBase with mbase
Date: Mon, 13 Aug 2007 06:48:41 -0700
Message-ID: <11870129834092-git-send-email-tony@atomide.com>
References: musb <11870129672745-git-send-email-tony@atomide.com>
	<11870129702817-git-send-email-tony@atomide.com>
	<11870129721700-git-send-email-tony@atomide.com>
	<1187012975431-git-send-email-tony@atomide.com>
	<11870129782148-git-send-email-tony@atomide.com>
	<1187012980445-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1187012980445-git-send-email-tony@atomide.com>
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

Search and replace pBase with mbase

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/g_ep0.c       |   34 +++++++++---------
 drivers/usb/musb/musb_gadget.c |   42 +++++++++++-----------
 drivers/usb/musb/musb_host.c   |   50 ++++++++++++++--------------
 drivers/usb/musb/musb_procfs.c |   52 ++++++++++++++--------------
 drivers/usb/musb/musbdefs.h    |   10 +++---
 drivers/usb/musb/musbhsdma.c   |   38 ++++++++++----------
 drivers/usb/musb/plat_uds.c    |   72 ++++++++++++++++++++--------------------
 drivers/usb/musb/virthub.c     |   26 +++++++-------
 8 files changed, 162 insertions(+), 162 deletions(-)

--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -74,7 +74,7 @@ static int service_tx_status_request(
 	struct musb *musb,
 	const struct usb_ctrlrequest *pControlRequest)
 {
-	void __iomem	*pBase = musb->mregs;
+	void __iomem	*mbase = musb->mregs;
 	int handled = 1;
 	u8 bResult[2], bEnd = 0;
 	const u8 bRecip = pControlRequest->bRequestType & USB_RECIP_MASK;
@@ -127,14 +127,14 @@ static int service_tx_status_request(
 			break;
 		}
 
-		MGC_SelectEnd(pBase, bEnd);
+		MGC_SelectEnd(mbase, bEnd);
 		if (is_in)
 			tmp = musb_readw(regs, MGC_O_HDRC_TXCSR)
 						& MGC_M_TXCSR_P_SENDSTALL;
 		else
 			tmp = musb_readw(regs, MGC_O_HDRC_RXCSR)
 						& MGC_M_RXCSR_P_SENDSTALL;
-		MGC_SelectEnd(pBase, 0);
+		MGC_SelectEnd(mbase, 0);
 
 		bResult[0] = tmp ? 1 : 0;
 		} break;
@@ -205,12 +205,12 @@ static void musb_g_ep0_giveback(struct musb *musb, struct usb_request *req)
  */
 static inline void musb_try_b_hnp_enable(struct musb *musb)
 {
-	void __iomem	*pBase = musb->mregs;
+	void __iomem	*mbase = musb->mregs;
 	u8		devctl;
 
 	DBG(1, "HNP: Setting HR\n");
-	devctl = musb_readb(pBase, MGC_O_HDRC_DEVCTL);
-	musb_writeb(pBase, MGC_O_HDRC_DEVCTL, devctl | MGC_M_DEVCTL_HR);
+	devctl = musb_readb(mbase, MGC_O_HDRC_DEVCTL);
+	musb_writeb(mbase, MGC_O_HDRC_DEVCTL, devctl | MGC_M_DEVCTL_HR);
 }
 
 /*
@@ -230,7 +230,7 @@ __releases(musb->Lock)
 __acquires(musb->Lock)
 {
 	int handled = -EINVAL;
-	void __iomem *pBase = musb->mregs;
+	void __iomem *mbase = musb->mregs;
 	const u8 bRecip = pControlRequest->bRequestType & USB_RECIP_MASK;
 
 	/* the gadget driver handles everything except what we MUST handle */
@@ -278,7 +278,7 @@ __acquires(musb->Lock)
 				spin_lock(&musb->Lock);
 
 				/* select ep0 again */
-				MGC_SelectEnd(pBase, 0);
+				MGC_SelectEnd(mbase, 0);
 				handled = 1;
 				} break;
 			default:
@@ -388,7 +388,7 @@ stall:
 				if (!musb_ep->desc)
 					break;
 
-				MGC_SelectEnd(pBase, bEnd);
+				MGC_SelectEnd(mbase, bEnd);
 				if (is_in) {
 					csr = musb_readw(regs,
 							MGC_O_HDRC_TXCSR);
@@ -411,7 +411,7 @@ stall:
 				}
 
 				/* select ep0 again */
-				MGC_SelectEnd(pBase, 0);
+				MGC_SelectEnd(mbase, 0);
 				handled = 1;
 				} break;
 
@@ -600,17 +600,17 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 {
 	u16		wCsrVal;
 	u16		wCount;
-	void __iomem	*pBase = musb->mregs;
+	void __iomem	*mbase = musb->mregs;
 	void __iomem	*regs = musb->aLocalEnd[0].regs;
 	irqreturn_t	retval = IRQ_NONE;
 
-	MGC_SelectEnd(pBase, 0);	/* select ep0 */
+	MGC_SelectEnd(mbase, 0);	/* select ep0 */
 	wCsrVal = musb_readw(regs, MGC_O_HDRC_CSR0);
 	wCount = musb_readb(regs, MGC_O_HDRC_COUNT0);
 
 	DBG(4, "csr %04x, count %d, myaddr %d, ep0stage %s\n",
 			wCsrVal, wCount,
-			musb_readb(pBase, MGC_O_HDRC_FADDR),
+			musb_readb(mbase, MGC_O_HDRC_FADDR),
 			decode_ep0stage(musb->ep0_state));
 
 	/* I sent a stall.. need to acknowledge it now.. */
@@ -663,7 +663,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 		 */
 		if (musb->bSetAddress) {
 			musb->bSetAddress = FALSE;
-			musb_writeb(pBase, MGC_O_HDRC_FADDR, musb->bAddress);
+			musb_writeb(mbase, MGC_O_HDRC_FADDR, musb->bAddress);
 		}
 
 		/* enter test mode if needed (exit by reset) */
@@ -673,7 +673,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 			if (MGC_M_TEST_PACKET == musb->bTestModeValue)
 				musb_load_testpacket(musb);
 
-			musb_writeb(pBase, MGC_O_HDRC_TESTMODE,
+			musb_writeb(mbase, MGC_O_HDRC_TESTMODE,
 					musb->bTestModeValue);
 		}
 		/* FALLTHROUGH */
@@ -710,7 +710,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 				printk(KERN_NOTICE "%s: peripheral reset "
 						"irq lost!\n",
 						musb_driver_name);
-				power = musb_readb(pBase, MGC_O_HDRC_POWER);
+				power = musb_readb(mbase, MGC_O_HDRC_POWER);
 				musb->g.speed = (power & MGC_M_POWER_HSMODE)
 					? USB_SPEED_HIGH : USB_SPEED_FULL;
 
@@ -769,7 +769,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 
 			handled = forward_to_driver(musb, &setup);
 			if (handled < 0) {
-				MGC_SelectEnd(pBase, 0);
+				MGC_SelectEnd(mbase, 0);
 stall:
 				DBG(3, "stall (%d)\n", handled);
 				musb->ackpend |= MGC_M_CSR0_P_SENDSTALL;
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -406,12 +406,12 @@ void musb_g_tx(struct musb *musb, u8 bEnd)
 {
 	u16			wCsrVal;
 	struct usb_request	*pRequest;
-	u8 __iomem		*pBase = musb->mregs;
+	u8 __iomem		*mbase = musb->mregs;
 	struct musb_ep		*musb_ep = &musb->aLocalEnd[bEnd].ep_in;
 	void __iomem		*epio = musb->aLocalEnd[bEnd].regs;
 	struct dma_channel	*dma;
 
-	MGC_SelectEnd(pBase, bEnd);
+	MGC_SelectEnd(mbase, bEnd);
 	pRequest = next_request(musb_ep);
 
 	wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
@@ -514,7 +514,7 @@ void musb_g_tx(struct musb *musb, u8 bEnd)
 				 * REVISIT for double buffering...
 				 * FIXME revisit for stalls too...
 				 */
-				MGC_SelectEnd(pBase, bEnd);
+				MGC_SelectEnd(mbase, bEnd);
 				wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
 				if (wCsrVal & MGC_M_TXCSR_FIFONOTEMPTY)
 					break;
@@ -736,12 +736,12 @@ void musb_g_rx(struct musb *musb, u8 bEnd)
 {
 	u16			wCsrVal;
 	struct usb_request	*pRequest;
-	void __iomem		*pBase = musb->mregs;
+	void __iomem		*mbase = musb->mregs;
 	struct musb_ep		*musb_ep = &musb->aLocalEnd[bEnd].ep_out;
 	void __iomem		*epio = musb->aLocalEnd[bEnd].regs;
 	struct dma_channel	*dma;
 
-	MGC_SelectEnd(pBase, bEnd);
+	MGC_SelectEnd(mbase, bEnd);
 
 	pRequest = next_request(musb_ep);
 
@@ -826,7 +826,7 @@ void musb_g_rx(struct musb *musb, u8 bEnd)
 			goto done;
 
 		/* don't start more i/o till the stall clears */
-		MGC_SelectEnd(pBase, bEnd);
+		MGC_SelectEnd(mbase, bEnd);
 		wCsrVal = musb_readw(epio, MGC_O_HDRC_RXCSR);
 		if (wCsrVal & MGC_M_RXCSR_P_SENDSTALL)
 			goto done;
@@ -855,7 +855,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 	struct musb_hw_ep	*hw_ep;
 	void __iomem		*regs;
 	struct musb		*musb;
-	void __iomem	*pBase;
+	void __iomem	*mbase;
 	u8		bEnd;
 	u16		csr;
 	unsigned	tmp;
@@ -868,7 +868,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 	hw_ep = musb_ep->hw_ep;
 	regs = hw_ep->regs;
 	musb = musb_ep->musb;
-	pBase = musb->mregs;
+	mbase = musb->mregs;
 	bEnd = musb_ep->bEndNumber;
 
 	spin_lock_irqsave(&musb->Lock, flags);
@@ -892,9 +892,9 @@ static int musb_gadget_enable(struct usb_ep *ep,
 	/* enable the interrupts for the endpoint, set the endpoint
 	 * packet size (or fail), set the mode, clear the fifo
 	 */
-	MGC_SelectEnd(pBase, bEnd);
+	MGC_SelectEnd(mbase, bEnd);
 	if (desc->bEndpointAddress & USB_DIR_IN) {
-		u16 wIntrTxE = musb_readw(pBase, MGC_O_HDRC_INTRTXE);
+		u16 wIntrTxE = musb_readw(mbase, MGC_O_HDRC_INTRTXE);
 
 		if (hw_ep->bIsSharedFifo)
 			musb_ep->is_in = 1;
@@ -904,7 +904,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 			goto fail;
 
 		wIntrTxE |= (1 << bEnd);
-		musb_writew(pBase, MGC_O_HDRC_INTRTXE, wIntrTxE);
+		musb_writew(mbase, MGC_O_HDRC_INTRTXE, wIntrTxE);
 
 		/* REVISIT if can_bulk_split(), use by updating "tmp";
 		 * likewise high bandwidth periodic tx
@@ -924,7 +924,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 		musb_writew(regs, MGC_O_HDRC_TXCSR, csr);
 
 	} else {
-		u16 wIntrRxE = musb_readw(pBase, MGC_O_HDRC_INTRRXE);
+		u16 wIntrRxE = musb_readw(mbase, MGC_O_HDRC_INTRRXE);
 
 		if (hw_ep->bIsSharedFifo)
 			musb_ep->is_in = 0;
@@ -934,7 +934,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 			goto fail;
 
 		wIntrRxE |= (1 << bEnd);
-		musb_writew(pBase, MGC_O_HDRC_INTRRXE, wIntrRxE);
+		musb_writew(mbase, MGC_O_HDRC_INTRRXE, wIntrRxE);
 
 		/* REVISIT if can_bulk_combine() use by updating "tmp"
 		 * likewise high bandwidth periodic rx
@@ -1232,7 +1232,7 @@ int musb_gadget_set_halt(struct usb_ep *ep, int value)
 	u8			bEnd = musb_ep->bEndNumber;
 	struct musb		*musb = musb_ep->musb;
 	void __iomem		*epio = musb->aLocalEnd[bEnd].regs;
-	void __iomem		*pBase;
+	void __iomem		*mbase;
 	unsigned long		flags;
 	u16			wCsr;
 	struct musb_request	*pRequest = NULL;
@@ -1240,7 +1240,7 @@ int musb_gadget_set_halt(struct usb_ep *ep, int value)
 
 	if (!ep)
 		return -EINVAL;
-	pBase = musb->mregs;
+	mbase = musb->mregs;
 
 	spin_lock_irqsave(&musb->Lock, flags);
 
@@ -1249,7 +1249,7 @@ int musb_gadget_set_halt(struct usb_ep *ep, int value)
 		goto done;
 	}
 
-	MGC_SelectEnd(pBase, bEnd);
+	MGC_SelectEnd(mbase, bEnd);
 
 	/* cannot portably stall with non-empty FIFO */
 	pRequest = to_musb_request(next_request(musb_ep));
@@ -1979,14 +1979,14 @@ void musb_g_reset(struct musb *musb)
 __releases(musb->Lock)
 __acquires(musb->Lock)
 {
-	void __iomem	*pBase = musb->mregs;
-	u8		devctl = musb_readb(pBase, MGC_O_HDRC_DEVCTL);
+	void __iomem	*mbase = musb->mregs;
+	u8		devctl = musb_readb(mbase, MGC_O_HDRC_DEVCTL);
 	u8		power;
 
 	DBG(3, "<== %s addr=%x driver '%s'\n",
 			(devctl & MGC_M_DEVCTL_BDEVICE)
 				? "B-Device" : "A-Device",
-			musb_readb(pBase, MGC_O_HDRC_FADDR),
+			musb_readb(mbase, MGC_O_HDRC_FADDR),
 			musb->pGadgetDriver
 				? musb->pGadgetDriver->driver.name
 				: NULL
@@ -1998,11 +1998,11 @@ __acquires(musb->Lock)
 
 	/* clear HR */
 	else if (devctl & MGC_M_DEVCTL_HR)
-		musb_writeb(pBase, MGC_O_HDRC_DEVCTL, MGC_M_DEVCTL_SESSION);
+		musb_writeb(mbase, MGC_O_HDRC_DEVCTL, MGC_M_DEVCTL_SESSION);
 
 
 	/* what speed did we negotiate? */
-	power = musb_readb(pBase, MGC_O_HDRC_POWER);
+	power = musb_readb(mbase, MGC_O_HDRC_POWER);
 	musb->g.speed = (power & MGC_M_POWER_HSMODE)
 			? USB_SPEED_HIGH : USB_SPEED_FULL;
 
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -172,7 +172,7 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 	u16			wFrame;
 	u32			dwLength;
 	void			*pBuffer;
-	void __iomem		*pBase =  musb->mregs;
+	void __iomem		*mbase =  musb->mregs;
 	struct urb		*urb = next_urb(qh);
 	struct musb_hw_ep	*hw_ep = qh->hw_ep;
 	unsigned		nPipe = urb->pipe;
@@ -232,7 +232,7 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 	case USB_ENDPOINT_XFER_INT:
 		DBG(3, "check whether there's still time for periodic Tx\n");
 		qh->iso_idx = 0;
-		wFrame = musb_readw(pBase, MGC_O_HDRC_FRAME);
+		wFrame = musb_readw(mbase, MGC_O_HDRC_FRAME);
 		/* FIXME this doesn't implement that scheduling policy ...
 		 * or handle framecounter wrapping
 		 */
@@ -248,7 +248,7 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 			/* enable SOF interrupt so we can count down */
 DBG(1,"SOF for %d\n", bEnd);
 #if 1 // ifndef	CONFIG_ARCH_DAVINCI
-			musb_writeb(pBase, MGC_O_HDRC_INTRUSBE, 0xff);
+			musb_writeb(mbase, MGC_O_HDRC_INTRUSBE, 0xff);
 #endif
 		}
 		break;
@@ -481,7 +481,7 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *pUrb,
 	int			nPipe = pUrb->pipe;
 	void			*buffer = pUrb->transfer_buffer;
 
-	// MGC_SelectEnd(pBase, bEnd);
+	// MGC_SelectEnd(mbase, bEnd);
 	wRxCount = musb_readw(epio, MGC_O_HDRC_RXCOUNT);
 	DBG(3, "RX%d count %d, buffer %p len %d/%d\n", bEnd, wRxCount,
 			pUrb->transfer_buffer, qh->offset,
@@ -630,7 +630,7 @@ static void musb_ep_program(struct musb *musb, u8 bEnd,
 	struct dma_controller	*pDmaController;
 	struct dma_channel	*pDmaChannel;
 	u8			bDmaOk;
-	void __iomem		*pBase = musb->mregs;
+	void __iomem		*mbase = musb->mregs;
 	struct musb_hw_ep	*hw_ep = musb->aLocalEnd + bEnd;
 	void __iomem		*epio = hw_ep->regs;
 	struct musb_qh		*qh;
@@ -651,7 +651,7 @@ static void musb_ep_program(struct musb *musb, u8 bEnd,
 			qh->h_addr_reg, qh->h_port_reg,
 			dwLength);
 
-	MGC_SelectEnd(pBase, bEnd);
+	MGC_SelectEnd(mbase, bEnd);
 
 	/* candidate for DMA? */
 	pDmaController = musb->pDmaController;
@@ -679,8 +679,8 @@ static void musb_ep_program(struct musb *musb, u8 bEnd,
 		wCsr = musb_readw(epio, MGC_O_HDRC_TXCSR);
 
 		/* disable interrupt in case we flush */
-		wIntrTxE = musb_readw(pBase, MGC_O_HDRC_INTRTXE);
-		musb_writew(pBase, MGC_O_HDRC_INTRTXE, wIntrTxE & ~(1 << bEnd));
+		wIntrTxE = musb_readw(mbase, MGC_O_HDRC_INTRTXE);
+		musb_writew(mbase, MGC_O_HDRC_INTRTXE, wIntrTxE & ~(1 << bEnd));
 
 		/* general endpoint setup */
 		if (bEnd) {
@@ -721,18 +721,18 @@ static void musb_ep_program(struct musb *musb, u8 bEnd,
 
 		/* target addr and (for multipoint) hub addr/port */
 		if (musb->bIsMultipoint) {
-			musb_writeb(pBase,
+			musb_writeb(mbase,
 				MGC_BUSCTL_OFFSET(bEnd, MGC_O_HDRC_TXFUNCADDR),
 				qh->addr_reg);
-			musb_writeb(pBase,
+			musb_writeb(mbase,
 				MGC_BUSCTL_OFFSET(bEnd, MGC_O_HDRC_TXHUBADDR),
 				qh->h_addr_reg);
-			musb_writeb(pBase,
+			musb_writeb(mbase,
 				MGC_BUSCTL_OFFSET(bEnd, MGC_O_HDRC_TXHUBPORT),
 				qh->h_port_reg);
 /* FIXME if !bEnd, do the same for RX ... */
 		} else
-			musb_writeb(pBase, MGC_O_HDRC_FADDR, qh->addr_reg);
+			musb_writeb(mbase, MGC_O_HDRC_FADDR, qh->addr_reg);
 
 		/* protocol/endpoint/interval/NAKlimit */
 		if (bEnd) {
@@ -868,7 +868,7 @@ static void musb_ep_program(struct musb *musb, u8 bEnd,
 		}
 
 		/* re-enable interrupt */
-		musb_writew(pBase, MGC_O_HDRC_INTRTXE, wIntrTxE);
+		musb_writew(mbase, MGC_O_HDRC_INTRTXE, wIntrTxE);
 
 	/* IN/receive */
 	} else {
@@ -1023,7 +1023,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 	struct urb		*pUrb;
 	u16			wCsrVal, wCount;
 	int			status = 0;
-	void __iomem		*pBase = musb->mregs;
+	void __iomem		*mbase = musb->mregs;
 	struct musb_hw_ep	*hw_ep = musb->control_ep;
 	void __iomem		*epio = hw_ep->regs;
 	struct musb_qh		*qh = hw_ep->in_qh;
@@ -1033,7 +1033,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 	/* ep0 only has one queue, "in" */
 	pUrb = next_urb(qh);
 
-	MGC_SelectEnd(pBase, 0);
+	MGC_SelectEnd(mbase, 0);
 	wCsrVal = musb_readw(epio, MGC_O_HDRC_CSR0);
 	wCount = (wCsrVal & MGC_M_CSR0_RXPKTRDY)
 			? musb_readb(epio, MGC_O_HDRC_COUNT0)
@@ -1174,12 +1174,12 @@ void musb_host_tx(struct musb *musb, u8 bEnd)
 	void __iomem		*epio = hw_ep->regs;
 	struct musb_qh		*qh = hw_ep->out_qh;
 	u32			status = 0;
-	void __iomem		*pBase = musb->mregs;
+	void __iomem		*mbase = musb->mregs;
 	struct dma_channel	*dma;
 
 	pUrb = next_urb(qh);
 
-	MGC_SelectEnd(pBase, bEnd);
+	MGC_SelectEnd(mbase, bEnd);
 	wTxCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
 
 	/* with CPPI, DMA sometimes triggers "extra" irqs */
@@ -1217,7 +1217,7 @@ void musb_host_tx(struct musb *musb, u8 bEnd)
 		 * if (bulk && qh->ring.next != &musb->out_bulk), then
 		 * we have a candidate... NAKing is *NOT* an error
 		 */
-		MGC_SelectEnd(pBase, bEnd);
+		MGC_SelectEnd(mbase, bEnd);
 		musb_writew(epio, MGC_O_HDRC_CSR0,
 				MGC_M_TXCSR_H_WZC_BITS
 				| MGC_M_TXCSR_TXPKTRDY);
@@ -1241,7 +1241,7 @@ void musb_host_tx(struct musb *musb, u8 bEnd)
 				| MGC_M_TXCSR_H_NAKTIMEOUT
 				);
 
-		MGC_SelectEnd(pBase, bEnd);
+		MGC_SelectEnd(mbase, bEnd);
 		musb_writew(epio, MGC_O_HDRC_TXCSR, wTxCsrVal);
 		/* REVISIT may need to clear FLUSHFIFO ... */
 		musb_writew(epio, MGC_O_HDRC_TXCSR, wTxCsrVal);
@@ -1323,7 +1323,7 @@ void musb_host_tx(struct musb *musb, u8 bEnd)
 		musb_write_fifo(hw_ep, wLength, pBuffer);
 		qh->segsize = wLength;
 
-		MGC_SelectEnd(pBase, bEnd);
+		MGC_SelectEnd(mbase, bEnd);
 		musb_writew(epio, MGC_O_HDRC_TXCSR,
 				MGC_M_TXCSR_H_WZC_BITS | MGC_M_TXCSR_TXPKTRDY);
 	} else
@@ -1384,7 +1384,7 @@ void musb_host_rx(struct musb *musb, u8 bEnd)
 	void __iomem		*epio = hw_ep->regs;
 	struct musb_qh		*qh = hw_ep->in_qh;
 	size_t			xfer_len;
-	void __iomem		*pBase = musb->mregs;
+	void __iomem		*mbase = musb->mregs;
 	int			nPipe;
 	u16			wRxCsrVal, wVal;
 	u8			bIsochError = FALSE;
@@ -1392,7 +1392,7 @@ void musb_host_rx(struct musb *musb, u8 bEnd)
 	u32			status;
 	struct dma_channel	*dma;
 
-	MGC_SelectEnd(pBase, bEnd);
+	MGC_SelectEnd(mbase, bEnd);
 
 	pUrb = next_urb(qh);
 	dma = is_dma_capable() ? hw_ep->rx_channel : NULL;
@@ -1443,7 +1443,7 @@ void musb_host_rx(struct musb *musb, u8 bEnd)
 			 * we have a candidate... NAKing is *NOT* an error
 			 */
 			DBG(6, "RX end %d NAK timeout\n", bEnd);
-			MGC_SelectEnd(pBase, bEnd);
+			MGC_SelectEnd(mbase, bEnd);
 			musb_writew(epio, MGC_O_HDRC_RXCSR,
 					MGC_M_RXCSR_H_WZC_BITS
 					| MGC_M_RXCSR_H_REQPKT);
@@ -1501,7 +1501,7 @@ void musb_host_rx(struct musb *musb, u8 bEnd)
 				xfer_len, dma ? ", dma" : "");
 		wRxCsrVal &= ~MGC_M_RXCSR_H_REQPKT;
 
-		MGC_SelectEnd(pBase, bEnd);
+		MGC_SelectEnd(mbase, bEnd);
 		musb_writew(epio, MGC_O_HDRC_RXCSR,
 				MGC_M_RXCSR_H_WZC_BITS | wRxCsrVal);
 	}
@@ -1545,7 +1545,7 @@ void musb_host_rx(struct musb *musb, u8 bEnd)
 
 // SCRUB (RX)
 			/* do the proper sequence to abort the transfer */
-			MGC_SelectEnd(pBase, bEnd);
+			MGC_SelectEnd(mbase, bEnd);
 			wVal &= ~MGC_M_RXCSR_H_REQPKT;
 			musb_writew(epio, MGC_O_HDRC_RXCSR, wVal);
 			goto finish;
--- a/drivers/usb/musb/musb_procfs.c
+++ b/drivers/usb/musb/musb_procfs.c
@@ -485,14 +485,14 @@ dump_end_info(struct musb *musb, u8 bEnd, char *aBuffer, unsigned max)
 static int dump_header_stats(struct musb *musb, char *buffer)
 {
 	int code, count = 0;
-	const void __iomem *pBase = musb->mregs;
+	const void __iomem *mbase = musb->mregs;
 
 	*buffer = 0;
 	count = sprintf(buffer, "Status: %sHDRC, Mode=%s "
 				"(Power=%02x, DevCtl=%02x)\n",
 			(musb->bIsMultipoint ? "M" : ""), MUSB_MODE(musb),
-			musb_readb(pBase, MGC_O_HDRC_POWER),
-			musb_readb(pBase, MGC_O_HDRC_DEVCTL));
+			musb_readb(mbase, MGC_O_HDRC_POWER),
+			musb_readb(mbase, MGC_O_HDRC_DEVCTL));
 	if (count <= 0)
 		return 0;
 	buffer += count;
@@ -653,7 +653,7 @@ static int musb_proc_write(struct file *file, const char __user *buffer,
 	char cmd;
 	u8 bReg;
 	struct musb *musb = (struct musb *)data;
-	void __iomem *pBase = musb->mregs;
+	void __iomem *mbase = musb->mregs;
 
 	/* MOD_INC_USE_COUNT; */
 
@@ -662,65 +662,65 @@ static int musb_proc_write(struct file *file, const char __user *buffer,
 
 	switch (cmd) {
 	case 'C':
-		if (pBase) {
-			bReg = musb_readb(pBase, MGC_O_HDRC_POWER)
+		if (mbase) {
+			bReg = musb_readb(mbase, MGC_O_HDRC_POWER)
 					| MGC_M_POWER_SOFTCONN;
-			musb_writeb(pBase, MGC_O_HDRC_POWER, bReg);
+			musb_writeb(mbase, MGC_O_HDRC_POWER, bReg);
 		}
 		break;
 
 	case 'c':
-		if (pBase) {
-			bReg = musb_readb(pBase, MGC_O_HDRC_POWER)
+		if (mbase) {
+			bReg = musb_readb(mbase, MGC_O_HDRC_POWER)
 					& ~MGC_M_POWER_SOFTCONN;
-			musb_writeb(pBase, MGC_O_HDRC_POWER, bReg);
+			musb_writeb(mbase, MGC_O_HDRC_POWER, bReg);
 		}
 		break;
 
 	case 'I':
-		if (pBase) {
-			bReg = musb_readb(pBase, MGC_O_HDRC_POWER)
+		if (mbase) {
+			bReg = musb_readb(mbase, MGC_O_HDRC_POWER)
 					| MGC_M_POWER_HSENAB;
-			musb_writeb(pBase, MGC_O_HDRC_POWER, bReg);
+			musb_writeb(mbase, MGC_O_HDRC_POWER, bReg);
 		}
 		break;
 
 	case 'i':
-		if (pBase) {
-			bReg = musb_readb(pBase, MGC_O_HDRC_POWER)
+		if (mbase) {
+			bReg = musb_readb(mbase, MGC_O_HDRC_POWER)
 					& ~MGC_M_POWER_HSENAB;
-			musb_writeb(pBase, MGC_O_HDRC_POWER, bReg);
+			musb_writeb(mbase, MGC_O_HDRC_POWER, bReg);
 		}
 		break;
 
 	case 'F':
-		bReg = musb_readb(pBase, MGC_O_HDRC_DEVCTL);
+		bReg = musb_readb(mbase, MGC_O_HDRC_DEVCTL);
 		bReg |= MGC_M_DEVCTL_SESSION;
-		musb_writeb(pBase, MGC_O_HDRC_DEVCTL, bReg);
+		musb_writeb(mbase, MGC_O_HDRC_DEVCTL, bReg);
 		break;
 
 	case 'H':
-		if (pBase) {
-			bReg = musb_readb(pBase, MGC_O_HDRC_DEVCTL);
+		if (mbase) {
+			bReg = musb_readb(mbase, MGC_O_HDRC_DEVCTL);
 			bReg |= MGC_M_DEVCTL_HR;
-			musb_writeb(pBase, MGC_O_HDRC_DEVCTL, bReg);
+			musb_writeb(mbase, MGC_O_HDRC_DEVCTL, bReg);
 			//MUSB_HST_MODE( ((struct musb*)data) );
 			//WARN("Host Mode\n");
 		}
 		break;
 
 	case 'h':
-		if (pBase) {
-			bReg = musb_readb(pBase, MGC_O_HDRC_DEVCTL);
+		if (mbase) {
+			bReg = musb_readb(mbase, MGC_O_HDRC_DEVCTL);
 			bReg &= ~MGC_M_DEVCTL_HR;
-			musb_writeb(pBase, MGC_O_HDRC_DEVCTL, bReg);
+			musb_writeb(mbase, MGC_O_HDRC_DEVCTL, bReg);
 		}
 		break;
 
 	case 'T':
-		if (pBase) {
+		if (mbase) {
 			musb_load_testpacket(musb);
-			musb_writeb(pBase, MGC_O_HDRC_TESTMODE,
+			musb_writeb(mbase, MGC_O_HDRC_TESTMODE,
 					MGC_M_TEST_PACKET);
 		}
 		break;
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -218,19 +218,19 @@ enum musb_g_ep0_state {
 
 /* TUSB mapping: "flat" plus ep0 special cases */
 #if	defined(CONFIG_USB_TUSB6010)
-#define MGC_SelectEnd(_pBase, _bEnd) \
-	musb_writeb((_pBase), MGC_O_HDRC_INDEX, (_bEnd))
+#define MGC_SelectEnd(_mbase, _bEnd) \
+	musb_writeb((_mbase), MGC_O_HDRC_INDEX, (_bEnd))
 #define	MGC_END_OFFSET			MGC_TUSB_OFFSET
 
 /* "flat" mapping: each endpoint has its own i/o address */
 #elif	defined(MUSB_FLAT_REG)
-#define MGC_SelectEnd(_pBase, _bEnd)	(((void)(_pBase)),((void)(_bEnd)))
+#define MGC_SelectEnd(_mbase, _bEnd)	(((void)(_mbase)),((void)(_bEnd)))
 #define	MGC_END_OFFSET			MGC_FLAT_OFFSET
 
 /* "indexed" mapping: INDEX register controls register bank select */
 #else
-#define MGC_SelectEnd(_pBase, _bEnd) \
-	musb_writeb((_pBase), MGC_O_HDRC_INDEX, (_bEnd))
+#define MGC_SelectEnd(_mbase, _bEnd) \
+	musb_writeb((_mbase), MGC_O_HDRC_INDEX, (_bEnd))
 #define	MGC_END_OFFSET			MGC_INDEXED_OFFSET
 #endif
 
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -177,7 +177,7 @@ static void configure_channel(struct dma_channel *pChannel,
 	struct musb_dma_channel *pImplChannel =
 		(struct musb_dma_channel *) pChannel->pPrivateData;
 	struct musb_dma_controller *pController = pImplChannel->pController;
-	u8 *pBase = pController->pCoreBase;
+	u8 *mbase = pController->pCoreBase;
 	u8 bChannel = pImplChannel->bIndex;
 	u16 wCsr = 0;
 
@@ -207,15 +207,15 @@ static void configure_channel(struct dma_channel *pChannel,
 		| (pImplChannel->bTransmit ? (1 << MGC_S_HSDMA_TRANSMIT) : 0);
 
 	/* address/count */
-	musb_writel(pBase,
+	musb_writel(mbase,
 		    MGC_HSDMA_CHANNEL_OFFSET(bChannel, MGC_O_HSDMA_ADDRESS),
 		    dma_addr);
-	musb_writel(pBase,
+	musb_writel(mbase,
 		    MGC_HSDMA_CHANNEL_OFFSET(bChannel, MGC_O_HSDMA_COUNT),
 		    dwLength);
 
 	/* control (this should start things) */
-	musb_writew(pBase,
+	musb_writew(mbase,
 		    MGC_HSDMA_CHANNEL_OFFSET(bChannel, MGC_O_HSDMA_CONTROL),
 		    wCsr);
 }
@@ -256,37 +256,37 @@ static int dma_channel_abort(struct dma_channel *pChannel)
 	struct musb_dma_channel *pImplChannel =
 		(struct musb_dma_channel *) pChannel->pPrivateData;
 	u8 bChannel = pImplChannel->bIndex;
-	u8 *pBase = pImplChannel->pController->pCoreBase;
+	u8 *mbase = pImplChannel->pController->pCoreBase;
 	u16 csr;
 
 	if (pChannel->bStatus == MGC_DMA_STATUS_BUSY) {
 		if (pImplChannel->bTransmit) {
 
-			csr = musb_readw(pBase,
+			csr = musb_readw(mbase,
 				MGC_END_OFFSET(pImplChannel->bEnd,MGC_O_HDRC_TXCSR));
 			csr &= ~(MGC_M_TXCSR_AUTOSET |
 				 MGC_M_TXCSR_DMAENAB |
 				 MGC_M_TXCSR_DMAMODE);
-			musb_writew(pBase,
+			musb_writew(mbase,
 					MGC_END_OFFSET(pImplChannel->bEnd,MGC_O_HDRC_TXCSR),
 					csr);
 		}
 		else {
-			csr = musb_readw(pBase,
+			csr = musb_readw(mbase,
 				MGC_END_OFFSET(pImplChannel->bEnd,MGC_O_HDRC_RXCSR));
 			csr &= ~(MGC_M_RXCSR_AUTOCLEAR |
 				 MGC_M_RXCSR_DMAENAB |
 				 MGC_M_RXCSR_DMAMODE);
-			musb_writew(pBase,
+			musb_writew(mbase,
 					MGC_END_OFFSET(pImplChannel->bEnd,MGC_O_HDRC_RXCSR),
 					csr);
 		}
 
-		musb_writew(pBase,
+		musb_writew(mbase,
 		   MGC_HSDMA_CHANNEL_OFFSET(bChannel, MGC_O_HSDMA_CONTROL), 0);
-		musb_writel(pBase,
+		musb_writel(mbase,
 		   MGC_HSDMA_CHANNEL_OFFSET(bChannel, MGC_O_HSDMA_ADDRESS), 0);
-		musb_writel(pBase,
+		musb_writel(mbase,
 		   MGC_HSDMA_CHANNEL_OFFSET(bChannel, MGC_O_HSDMA_COUNT), 0);
 
 		pChannel->bStatus = MGC_DMA_STATUS_FREE;
@@ -299,7 +299,7 @@ static irqreturn_t dma_controller_irq(int irq, void *pPrivateData)
 	struct musb_dma_controller *pController =
 		(struct musb_dma_controller *)pPrivateData;
 	struct musb_dma_channel *pImplChannel;
-	u8 *pBase = pController->pCoreBase;
+	u8 *mbase = pController->pCoreBase;
 	struct dma_channel *pChannel;
 	u8 bChannel;
 	u16 wCsr;
@@ -307,7 +307,7 @@ static irqreturn_t dma_controller_irq(int irq, void *pPrivateData)
 	u8 bIntr;
 	irqreturn_t retval = IRQ_NONE;
 
-	bIntr = musb_readb(pBase, MGC_O_HSDMA_INTR);
+	bIntr = musb_readb(mbase, MGC_O_HSDMA_INTR);
 	if (!bIntr)
 		goto done;
 
@@ -317,7 +317,7 @@ static irqreturn_t dma_controller_irq(int irq, void *pPrivateData)
 					&(pController->aChannel[bChannel]);
 			pChannel = &pImplChannel->Channel;
 
-			wCsr = musb_readw(pBase,
+			wCsr = musb_readw(mbase,
 				       MGC_HSDMA_CHANNEL_OFFSET(bChannel,
 							MGC_O_HSDMA_CONTROL));
 
@@ -325,7 +325,7 @@ static irqreturn_t dma_controller_irq(int irq, void *pPrivateData)
 				pImplChannel->Channel.bStatus =
 				    MGC_DMA_STATUS_BUS_ABORT;
 			} else {
-				dwAddress = musb_readl(pBase,
+				dwAddress = musb_readl(mbase,
 						MGC_HSDMA_CHANNEL_OFFSET(
 							bChannel,
 							MGC_O_HSDMA_ADDRESS));
@@ -340,7 +340,7 @@ static irqreturn_t dma_controller_irq(int irq, void *pPrivateData)
 					pImplChannel->dwCount) ?
 					"=> reconfig 0": "=> complete");
 
-				u8 devctl = musb_readb(pBase,
+				u8 devctl = musb_readb(mbase,
 						MGC_O_HDRC_DEVCTL);
 
 				pChannel->bStatus = MGC_DMA_STATUS_FREE;
@@ -353,9 +353,9 @@ static irqreturn_t dma_controller_irq(int irq, void *pPrivateData)
 					    (pImplChannel->wMaxPacketSize - 1)))
 				   ) {
 					/* Send out the packet */
-					MGC_SelectEnd(pBase,
+					MGC_SelectEnd(mbase,
 						pImplChannel->bEnd);
-					musb_writew(pBase,
+					musb_writew(mbase,
 						MGC_END_OFFSET(pImplChannel->bEnd,MGC_O_HDRC_TXCSR),
 						MGC_M_TXCSR_TXPKTRDY);
 				} else
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -315,7 +315,7 @@ static DEFINE_TIMER(musb_otg_timer, musb_otg_timer_func, 0, 0);
 void musb_hnp_stop(struct musb *musb)
 {
 	struct usb_hcd	*hcd = musb_to_hcd(musb);
-	void __iomem	*pBase = musb->mregs;
+	void __iomem	*mbase = musb->mregs;
 	u8	reg;
 
 	switch (musb->xceiv.state) {
@@ -331,9 +331,9 @@ void musb_hnp_stop(struct musb *musb)
 		DBG(1, "HNP: Disabling HR\n");
 		hcd->self.is_b_host = 0;
 		musb->xceiv.state = OTG_STATE_B_PERIPHERAL;
-		reg = musb_readb(pBase, MGC_O_HDRC_POWER);
+		reg = musb_readb(mbase, MGC_O_HDRC_POWER);
 		reg |= MGC_M_POWER_SUSPENDM;
-		musb_writeb(pBase, MGC_O_HDRC_POWER, reg);
+		musb_writeb(mbase, MGC_O_HDRC_POWER, reg);
 		/* REVISIT: Start SESSION_REQUEST here? */
 		break;
 	default:
@@ -365,7 +365,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
 {
 	irqreturn_t handled = IRQ_NONE;
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
-	void __iomem *pBase = musb->mregs;
+	void __iomem *mbase = musb->mregs;
 #endif
 
 	DBG(3, "<== Power=%02x, DevCtl=%02x, bIntrUSB=0x%x\n", power, devctl,
@@ -395,7 +395,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
 				}
 
 				power &= ~MGC_M_POWER_SUSPENDM;
-				musb_writeb(pBase, MGC_O_HDRC_POWER,
+				musb_writeb(mbase, MGC_O_HDRC_POWER,
 						power | MGC_M_POWER_RESUME);
 
 				musb->port1_status |=
@@ -466,7 +466,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
 		 *  - ... to A_WAIT_BCON.
 		 * a_wait_vrise_tmout triggers VBUS_ERROR transitions
 		 */
-		musb_writeb(pBase, MGC_O_HDRC_DEVCTL, MGC_M_DEVCTL_SESSION);
+		musb_writeb(mbase, MGC_O_HDRC_DEVCTL, MGC_M_DEVCTL_SESSION);
 		musb->bEnd0Stage = MGC_END0_START;
 		musb->xceiv.state = OTG_STATE_A_IDLE;
 		MUSB_HST_MODE(musb);
@@ -508,7 +508,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
 				musb->vbuserr_retry--;
 				ignore = 1;
 				devctl |= MGC_M_DEVCTL_SESSION;
-				musb_writeb(pBase, MGC_O_HDRC_DEVCTL, devctl);
+				musb_writeb(mbase, MGC_O_HDRC_DEVCTL, devctl);
 			} else {
 				musb->port1_status |=
 					  (1 << USB_PORT_FEAT_OVER_CURRENT)
@@ -558,9 +558,9 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
 			// REVISIT HNP; just force disconnect
 		}
 		musb->bDelayPortPowerOff = FALSE;
-		musb_writew(pBase, MGC_O_HDRC_INTRTXE, musb->wEndMask);
-		musb_writew(pBase, MGC_O_HDRC_INTRRXE, musb->wEndMask & 0xfffe);
-		musb_writeb(pBase, MGC_O_HDRC_INTRUSBE, 0xf7);
+		musb_writew(mbase, MGC_O_HDRC_INTRTXE, musb->wEndMask);
+		musb_writew(mbase, MGC_O_HDRC_INTRRXE, musb->wEndMask & 0xfffe);
+		musb_writeb(mbase, MGC_O_HDRC_INTRUSBE, 0xf7);
 #endif
 		musb->port1_status &= ~(USB_PORT_STAT_LOW_SPEED
 					|USB_PORT_STAT_HIGH_SPEED
@@ -616,7 +616,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
 				DBG(1, "BABBLE devctl: %02x\n", devctl);
 			else {
 				ERR("Stopping host session because of babble\n");
-				musb_writeb(pBase, MGC_O_HDRC_DEVCTL, 0);
+				musb_writeb(mbase, MGC_O_HDRC_DEVCTL, 0);
 			}
 		} else {
 			DBG(1, "BUS RESET\n");
@@ -660,7 +660,7 @@ static irqreturn_t musb_stage2_irq(struct musb * musb, u8 bIntrUSB,
  * to support ISO transfers yet.
  */
 	if (bIntrUSB & MGC_M_INTR_SOF) {
-		void __iomem *pBase = musb->mregs;
+		void __iomem *mbase = musb->mregs;
 		struct musb_hw_ep	*ep;
 		u8 bEnd;
 		u16 wFrame;
@@ -669,7 +669,7 @@ static irqreturn_t musb_stage2_irq(struct musb * musb, u8 bIntrUSB,
 		handled = IRQ_HANDLED;
 
 		/* start any periodic Tx transfers waiting for current frame */
-		wFrame = musb_readw(pBase, MGC_O_HDRC_FRAME);
+		wFrame = musb_readw(mbase, MGC_O_HDRC_FRAME);
 		ep = musb->aLocalEnd;
 		for (bEnd = 1; (bEnd < musb->bEndCount)
 					&& (musb->wEndMask >= (1 << bEnd));
@@ -835,21 +835,21 @@ void musb_start(struct musb *musb)
 
 static void musb_generic_disable(struct musb *musb)
 {
-	void __iomem	*pBase = musb->mregs;
+	void __iomem	*mbase = musb->mregs;
 	u16	temp;
 
 	/* disable interrupts */
-	musb_writeb(pBase, MGC_O_HDRC_INTRUSBE, 0);
-	musb_writew(pBase, MGC_O_HDRC_INTRTXE, 0);
-	musb_writew(pBase, MGC_O_HDRC_INTRRXE, 0);
+	musb_writeb(mbase, MGC_O_HDRC_INTRUSBE, 0);
+	musb_writew(mbase, MGC_O_HDRC_INTRTXE, 0);
+	musb_writew(mbase, MGC_O_HDRC_INTRRXE, 0);
 
 	/* off */
-	musb_writeb(pBase, MGC_O_HDRC_DEVCTL, 0);
+	musb_writeb(mbase, MGC_O_HDRC_DEVCTL, 0);
 
 	/*  flush pending interrupts */
-	temp = musb_readb(pBase, MGC_O_HDRC_INTRUSB);
-	temp = musb_readw(pBase, MGC_O_HDRC_INTRTX);
-	temp = musb_readw(pBase, MGC_O_HDRC_INTRRX);
+	temp = musb_readb(mbase, MGC_O_HDRC_INTRUSB);
+	temp = musb_readw(mbase, MGC_O_HDRC_INTRTX);
+	temp = musb_readw(mbase, MGC_O_HDRC_INTRRX);
 
 }
 
@@ -1180,14 +1180,14 @@ static int __init ep_config_from_hw(struct musb *musb)
 {
 	u8 bEnd = 0, reg;
 	struct musb_hw_ep *hw_ep;
-	void *pBase = musb->mregs;
+	void *mbase = musb->mregs;
 
 	DBG(2, "<== static silicon ep config\n");
 
 	/* FIXME pick up ep0 maxpacket size */
 
 	for (bEnd = 1; bEnd < MUSB_C_NUM_EPS; bEnd++) {
-		MGC_SelectEnd(pBase, bEnd);
+		MGC_SelectEnd(mbase, bEnd);
 		hw_ep = musb->aLocalEnd + bEnd;
 
 		/* read from core using indexed model */
@@ -1252,13 +1252,13 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 	char *type;
 	u16 wRelease, wRelMajor, wRelMinor;
 	char aInfo[78], aRevision[32], aDate[12];
-	void __iomem	*pBase = musb->mregs;
+	void __iomem	*mbase = musb->mregs;
 	int		status = 0;
 	int		i;
 
 	/* log core options (read using indexed model) */
-	MGC_SelectEnd(pBase, 0);
-	reg = musb_readb(pBase, 0x10 + MGC_O_HDRC_CONFIGDATA);
+	MGC_SelectEnd(mbase, 0);
+	reg = musb_readb(mbase, 0x10 + MGC_O_HDRC_CONFIGDATA);
 
 	strcpy(aInfo, (reg & MGC_M_CONFIGDATA_UTMIDW) ? "UTMI-16" : "UTMI-8");
 	if (reg & MGC_M_CONFIGDATA_DYNFIFO) {
@@ -1296,15 +1296,15 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 			musb_driver_name, reg, aInfo);
 
 #ifdef MUSB_AHB_ID
-	dwData = musb_readl(pBase, 0x404);
+	dwData = musb_readl(mbase, 0x404);
 	sprintf(aDate, "%04d-%02x-%02x", (dwData & 0xffff),
 		(dwData >> 16) & 0xff, (dwData >> 24) & 0xff);
 	/* FIXME ID2 and ID3 are unused */
-	dwData = musb_readl(pBase, 0x408);
+	dwData = musb_readl(mbase, 0x408);
 	printk("ID2=%lx\n", (long unsigned)dwData);
-	dwData = musb_readl(pBase, 0x40c);
+	dwData = musb_readl(mbase, 0x40c);
 	printk("ID3=%lx\n", (long unsigned)dwData);
-	reg = musb_readb(pBase, 0x400);
+	reg = musb_readb(mbase, 0x400);
 	wType = ('M' == reg) ? MUSB_CONTROLLER_MHDRC : MUSB_CONTROLLER_HDRC;
 #else
 	aDate[0] = 0;
@@ -1325,7 +1325,7 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 	}
 
 	/* log release info */
-	wRelease = musb_readw(pBase, MGC_O_HDRC_HWVERS);
+	wRelease = musb_readw(mbase, MGC_O_HDRC_HWVERS);
 	wRelMajor = (wRelease >> 10) & 0x1f;
 	wRelMinor = wRelease & 0x3ff;
 	snprintf(aRevision, 32, "%d.%d%s", wRelMajor,
@@ -1364,7 +1364,7 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 	for (i = 0; i < musb->bEndCount; i++) {
 		struct musb_hw_ep	*hw_ep = musb->aLocalEnd + i;
 
-		hw_ep->fifo = MUSB_FIFO_OFFSET(i) + pBase;
+		hw_ep->fifo = MUSB_FIFO_OFFSET(i) + mbase;
 #ifdef CONFIG_USB_TUSB6010
 		hw_ep->fifo_async = musb->async + 0x400 + MUSB_FIFO_OFFSET(i);
 		hw_ep->fifo_sync = musb->sync + 0x400 + MUSB_FIFO_OFFSET(i);
@@ -1372,14 +1372,14 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 			musb->sync_va + 0x400 + MUSB_FIFO_OFFSET(i);
 
 		if (i == 0)
-			hw_ep->conf = pBase - 0x400 + TUSB_EP0_CONF;
+			hw_ep->conf = mbase - 0x400 + TUSB_EP0_CONF;
 		else
-			hw_ep->conf = pBase + 0x400 + (((i - 1) & 0xf) << 2);
+			hw_ep->conf = mbase + 0x400 + (((i - 1) & 0xf) << 2);
 #endif
 
-		hw_ep->regs = MGC_END_OFFSET(i, 0) + pBase;
+		hw_ep->regs = MGC_END_OFFSET(i, 0) + mbase;
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
-		hw_ep->target_regs = MGC_BUSCTL_OFFSET(i, 0) + pBase;
+		hw_ep->target_regs = MGC_BUSCTL_OFFSET(i, 0) + mbase;
 		hw_ep->rx_reinit = 1;
 		hw_ep->tx_reinit = 1;
 #endif
--- a/drivers/usb/musb/virthub.c
+++ b/drivers/usb/musb/virthub.c
@@ -49,7 +49,7 @@
 static void musb_port_suspend(struct musb *musb, u8 bSuspend)
 {
 	u8		power;
-	void __iomem	*pBase = musb->mregs;
+	void __iomem	*mbase = musb->mregs;
 
 	if (!is_host_active(musb))
 		return;
@@ -59,18 +59,18 @@ static void musb_port_suspend(struct musb *musb, u8 bSuspend)
 	 * MGC_M_POWER_ENSUSPEND.  PHY may need a clock (sigh) to detect
 	 * SE0 changing to connect (J) or wakeup (K) states.
 	 */
-	power = musb_readb(pBase, MGC_O_HDRC_POWER);
+	power = musb_readb(mbase, MGC_O_HDRC_POWER);
 	if (bSuspend) {
 		int retries = 10000;
 
 		power &= ~MGC_M_POWER_RESUME;
 		power |= MGC_M_POWER_SUSPENDM;
-		musb_writeb(pBase, MGC_O_HDRC_POWER, power);
+		musb_writeb(mbase, MGC_O_HDRC_POWER, power);
 
 		/* Needed for OPT A tests */
-		power = musb_readb(pBase, MGC_O_HDRC_POWER);
+		power = musb_readb(mbase, MGC_O_HDRC_POWER);
 		while (power & MGC_M_POWER_SUSPENDM) {
-			power = musb_readb(pBase, MGC_O_HDRC_POWER);
+			power = musb_readb(mbase, MGC_O_HDRC_POWER);
 			if (retries-- < 1)
 				break;
 		}
@@ -97,7 +97,7 @@ static void musb_port_suspend(struct musb *musb, u8 bSuspend)
 	} else if (power & MGC_M_POWER_SUSPENDM) {
 		power &= ~MGC_M_POWER_SUSPENDM;
 		power |= MGC_M_POWER_RESUME;
-		musb_writeb(pBase, MGC_O_HDRC_POWER, power);
+		musb_writeb(mbase, MGC_O_HDRC_POWER, power);
 
 		DBG(3, "Root port resuming, power %02x\n", power);
 
@@ -110,11 +110,11 @@ static void musb_port_suspend(struct musb *musb, u8 bSuspend)
 static void musb_port_reset(struct musb *musb, u8 bReset)
 {
 	u8		power;
-	void __iomem	*pBase = musb->mregs;
+	void __iomem	*mbase = musb->mregs;
 
 #ifdef CONFIG_USB_MUSB_OTG
 	/* REVISIT this looks wrong for HNP */
-	u8 devctl = musb_readb(pBase, MGC_O_HDRC_DEVCTL);
+	u8 devctl = musb_readb(mbase, MGC_O_HDRC_DEVCTL);
 
 	if (musb->bDelayPortPowerOff || !(devctl & MGC_M_DEVCTL_HM)) {
 		return;
@@ -127,7 +127,7 @@ static void musb_port_reset(struct musb *musb, u8 bReset)
 	/* NOTE:  caller guarantees it will turn off the reset when
 	 * the appropriate amount of time has passed
 	 */
-	power = musb_readb(pBase, MGC_O_HDRC_POWER);
+	power = musb_readb(mbase, MGC_O_HDRC_POWER);
 	if (bReset) {
 
 		/*
@@ -140,14 +140,14 @@ static void musb_port_reset(struct musb *musb, u8 bReset)
 		if (power &  MGC_M_POWER_RESUME) {
 			while (time_before(jiffies, musb->rh_timer))
 				msleep(1);
-			musb_writeb(pBase, MGC_O_HDRC_POWER,
+			musb_writeb(mbase, MGC_O_HDRC_POWER,
 				power & ~MGC_M_POWER_RESUME);
 			msleep(1);
 		}
 
 		musb->bIgnoreDisconnect = TRUE;
 		power &= 0xf0;
-		musb_writeb(pBase, MGC_O_HDRC_POWER,
+		musb_writeb(mbase, MGC_O_HDRC_POWER,
 				power | MGC_M_POWER_RESET);
 
 		musb->port1_status |= USB_PORT_STAT_RESET;
@@ -155,12 +155,12 @@ static void musb_port_reset(struct musb *musb, u8 bReset)
 		musb->rh_timer = jiffies + msecs_to_jiffies(50);
 	} else {
 		DBG(4, "root port reset stopped\n");
-		musb_writeb(pBase, MGC_O_HDRC_POWER,
+		musb_writeb(mbase, MGC_O_HDRC_POWER,
 				power & ~MGC_M_POWER_RESET);
 
 		musb->bIgnoreDisconnect = FALSE;
 
-		power = musb_readb(pBase, MGC_O_HDRC_POWER);
+		power = musb_readb(mbase, MGC_O_HDRC_POWER);
 		if (power & MGC_M_POWER_HSMODE) {
 			DBG(4, "high-speed device connected\n");
 			musb->port1_status |= USB_PORT_STAT_HIGH_SPEED;
-- 
1.5.2.3
