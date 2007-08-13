From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 49/52] musb_hdrc: Search and replace wCsrVal with csr
Date: Mon, 13 Aug 2007 06:49:24 -0700
Message-ID: <118701309984-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11870130953685-git-send-email-tony@atomide.com>
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

Search and replace wCsrVal with csr

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/g_ep0.c       |   30 ++++----
 drivers/usb/musb/musb_gadget.c |  152 ++++++++++++++++++++--------------------
 drivers/usb/musb/musb_host.c   |   46 ++++++------
 3 files changed, 114 insertions(+), 114 deletions(-)

--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -485,7 +485,7 @@ static void ep0_txstate(struct musb *musb)
 {
 	void __iomem		*regs = musb->control_ep->regs;
 	struct usb_request	*request = next_ep0_request(musb);
-	u16			wCsrVal = MGC_M_CSR0_TXPKTRDY;
+	u16			csr = MGC_M_CSR0_TXPKTRDY;
 	u8			*pFifoSource;
 	u8			fifo_count;
 
@@ -506,12 +506,12 @@ static void ep0_txstate(struct musb *musb)
 	if (fifo_count < MUSB_MAX_END0_PACKET
 			|| request->actual == request->length) {
 		musb->ep0_state = MGC_END0_STAGE_STATUSOUT;
-		wCsrVal |= MGC_M_CSR0_P_DATAEND;
+		csr |= MGC_M_CSR0_P_DATAEND;
 	} else
 		request = NULL;
 
 	/* send it out, triggering a "txpktrdy cleared" irq */
-	musb_writew(regs, MGC_O_HDRC_CSR0, wCsrVal);
+	musb_writew(regs, MGC_O_HDRC_CSR0, csr);
 
 	/* report completions as soon as the fifo's loaded; there's no
 	 * win in waiting till this last packet gets acked.  (other than
@@ -598,36 +598,36 @@ __acquires(musb->lock)
  */
 irqreturn_t musb_g_ep0_irq(struct musb *musb)
 {
-	u16		wCsrVal;
+	u16		csr;
 	u16		len;
 	void __iomem	*mbase = musb->mregs;
 	void __iomem	*regs = musb->endpoints[0].regs;
 	irqreturn_t	retval = IRQ_NONE;
 
 	musb_ep_select(mbase, 0);	/* select ep0 */
-	wCsrVal = musb_readw(regs, MGC_O_HDRC_CSR0);
+	csr = musb_readw(regs, MGC_O_HDRC_CSR0);
 	len = musb_readb(regs, MGC_O_HDRC_COUNT0);
 
 	DBG(4, "csr %04x, count %d, myaddr %d, ep0stage %s\n",
-			wCsrVal, len,
+			csr, len,
 			musb_readb(mbase, MGC_O_HDRC_FADDR),
 			decode_ep0stage(musb->ep0_state));
 
 	/* I sent a stall.. need to acknowledge it now.. */
-	if (wCsrVal & MGC_M_CSR0_P_SENTSTALL) {
+	if (csr & MGC_M_CSR0_P_SENTSTALL) {
 		musb_writew(regs, MGC_O_HDRC_CSR0,
-				wCsrVal & ~MGC_M_CSR0_P_SENTSTALL);
+				csr & ~MGC_M_CSR0_P_SENTSTALL);
 		retval = IRQ_HANDLED;
 		musb->ep0_state = MGC_END0_STAGE_SETUP;
-		wCsrVal = musb_readw(regs, MGC_O_HDRC_CSR0);
+		csr = musb_readw(regs, MGC_O_HDRC_CSR0);
 	}
 
 	/* request ended "early" */
-	if (wCsrVal & MGC_M_CSR0_P_SETUPEND) {
+	if (csr & MGC_M_CSR0_P_SETUPEND) {
 		musb_writew(regs, MGC_O_HDRC_CSR0, MGC_M_CSR0_P_SVDSETUPEND);
 		retval = IRQ_HANDLED;
 		musb->ep0_state = MGC_END0_STAGE_SETUP;
-		wCsrVal = musb_readw(regs, MGC_O_HDRC_CSR0);
+		csr = musb_readw(regs, MGC_O_HDRC_CSR0);
 		/* NOTE:  request may need completion */
 	}
 
@@ -639,7 +639,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 
 	case MGC_END0_STAGE_TX:
 		/* irq on clearing txpktrdy */
-		if ((wCsrVal & MGC_M_CSR0_TXPKTRDY) == 0) {
+		if ((csr & MGC_M_CSR0_TXPKTRDY) == 0) {
 			ep0_txstate(musb);
 			retval = IRQ_HANDLED;
 		}
@@ -647,7 +647,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 
 	case MGC_END0_STAGE_RX:
 		/* irq on set rxpktrdy */
-		if (wCsrVal & MGC_M_CSR0_RXPKTRDY) {
+		if (csr & MGC_M_CSR0_RXPKTRDY) {
 			ep0_rxstate(musb);
 			retval = IRQ_HANDLED;
 		}
@@ -692,7 +692,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 		/* FALLTHROUGH */
 
 	case MGC_END0_STAGE_SETUP:
-		if (wCsrVal & MGC_M_CSR0_RXPKTRDY) {
+		if (csr & MGC_M_CSR0_RXPKTRDY) {
 			struct usb_ctrlrequest	setup;
 			int			handled = 0;
 
@@ -755,7 +755,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 			}
 
 			DBG(3, "handled %d, csr %04x, ep0stage %s\n",
-				handled, wCsrVal,
+				handled, csr,
 				decode_ep0stage(musb->ep0_state));
 
 			/* unless we need to delegate this to the gadget
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -256,7 +256,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 	struct musb_ep		*musb_ep;
 	void __iomem		*epio = musb->endpoints[epnum].regs;
 	struct usb_request	*request;
-	u16			fifo_count = 0, wCsrVal;
+	u16			fifo_count = 0, csr;
 	int			use_dma = 0;
 
 	musb_ep = req->ep;
@@ -268,27 +268,27 @@ static void txstate(struct musb *musb, struct musb_request *req)
 	}
 
 	/* read TXCSR before */
-	wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
+	csr = musb_readw(epio, MGC_O_HDRC_TXCSR);
 
 	request = &req->request;
 	fifo_count = min(max_ep_writesize(musb, musb_ep),
 			(int)(request->length - request->actual));
 
-	if (wCsrVal & MGC_M_TXCSR_TXPKTRDY) {
+	if (csr & MGC_M_TXCSR_TXPKTRDY) {
 		DBG(5, "%s old packet still ready , txcsr %03x\n",
-				musb_ep->end_point.name, wCsrVal);
+				musb_ep->end_point.name, csr);
 		return;
 	}
 
-	if (wCsrVal & MGC_M_TXCSR_P_SENDSTALL) {
+	if (csr & MGC_M_TXCSR_P_SENDSTALL) {
 		DBG(5, "%s stalling, txcsr %03x\n",
-				musb_ep->end_point.name, wCsrVal);
+				musb_ep->end_point.name, csr);
 		return;
 	}
 
 	DBG(4, "hw_ep%d, maxpacket %d, fifo count %d, txcsr %03x\n",
 			epnum, musb_ep->wPacketSize, fifo_count,
-			wCsrVal);
+			csr);
 
 #ifndef	CONFIG_USB_INVENTRA_FIFO
 	if (is_dma_capable() && musb_ep->dma) {
@@ -317,36 +317,36 @@ static void txstate(struct musb *musb, struct musb_request *req)
 			if (use_dma) {
 				if (musb_ep->dma->desired_mode == 0) {
 					/* ASSERT: DMAENAB is clear */
-					wCsrVal &= ~(MGC_M_TXCSR_AUTOSET |
+					csr &= ~(MGC_M_TXCSR_AUTOSET |
 							MGC_M_TXCSR_DMAMODE);
-					wCsrVal |= (MGC_M_TXCSR_DMAENAB |
+					csr |= (MGC_M_TXCSR_DMAENAB |
 							MGC_M_TXCSR_MODE);
 					// against programming guide
 				}
 				else
-					wCsrVal |= (MGC_M_TXCSR_AUTOSET
+					csr |= (MGC_M_TXCSR_AUTOSET
 							| MGC_M_TXCSR_DMAENAB
 							| MGC_M_TXCSR_DMAMODE
 							| MGC_M_TXCSR_MODE);
 
-				wCsrVal &= ~MGC_M_TXCSR_P_UNDERRUN;
-				musb_writew(epio, MGC_O_HDRC_TXCSR, wCsrVal);
+				csr &= ~MGC_M_TXCSR_P_UNDERRUN;
+				musb_writew(epio, MGC_O_HDRC_TXCSR, csr);
 			}
 		}
 
 #elif defined(CONFIG_USB_TI_CPPI_DMA)
 		/* program endpoint CSR first, then setup DMA */
-		wCsrVal &= ~(MGC_M_TXCSR_AUTOSET
+		csr &= ~(MGC_M_TXCSR_AUTOSET
 				| MGC_M_TXCSR_DMAMODE
 				| MGC_M_TXCSR_P_UNDERRUN
 				| MGC_M_TXCSR_TXPKTRDY);
-		wCsrVal |= MGC_M_TXCSR_MODE | MGC_M_TXCSR_DMAENAB;
+		csr |= MGC_M_TXCSR_MODE | MGC_M_TXCSR_DMAENAB;
 		musb_writew(epio, MGC_O_HDRC_TXCSR,
 			(MGC_M_TXCSR_P_WZC_BITS & ~MGC_M_TXCSR_P_UNDERRUN)
-				| wCsrVal);
+				| csr);
 
 		/* ensure writebuffer is empty */
-		wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
+		csr = musb_readw(epio, MGC_O_HDRC_TXCSR);
 
 		/* NOTE host side sets DMAENAB later than this; both are
 		 * OK since the transfer dma glue (between CPPI and Mentor
@@ -367,7 +367,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 			c->channel_release(musb_ep->dma);
 			musb_ep->dma = NULL;
 			/* ASSERT: DMAENAB clear */
-			wCsrVal &= ~(MGC_M_TXCSR_DMAMODE | MGC_M_TXCSR_MODE);
+			csr &= ~(MGC_M_TXCSR_DMAMODE | MGC_M_TXCSR_MODE);
 			/* invariant: prequest->buf is non-null */
 		}
 #elif defined(CONFIG_USB_TUSB_OMAP_DMA)
@@ -384,9 +384,9 @@ static void txstate(struct musb *musb, struct musb_request *req)
 		musb_write_fifo(musb_ep->hw_ep, fifo_count,
 				(u8 *) (request->buf + request->actual));
 		request->actual += fifo_count;
-		wCsrVal |= MGC_M_TXCSR_TXPKTRDY;
-		wCsrVal &= ~MGC_M_TXCSR_P_UNDERRUN;
-		musb_writew(epio, MGC_O_HDRC_TXCSR, wCsrVal);
+		csr |= MGC_M_TXCSR_TXPKTRDY;
+		csr &= ~MGC_M_TXCSR_P_UNDERRUN;
+		musb_writew(epio, MGC_O_HDRC_TXCSR, csr);
 	}
 
 	/* host may already have the data when this message shows... */
@@ -404,7 +404,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
  */
 void musb_g_tx(struct musb *musb, u8 epnum)
 {
-	u16			wCsrVal;
+	u16			csr;
 	struct usb_request	*request;
 	u8 __iomem		*mbase = musb->mregs;
 	struct musb_ep		*musb_ep = &musb->endpoints[epnum].ep_in;
@@ -414,18 +414,18 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 	musb_ep_select(mbase, epnum);
 	request = next_request(musb_ep);
 
-	wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
-	DBG(4, "<== %s, txcsr %04x\n", musb_ep->end_point.name, wCsrVal);
+	csr = musb_readw(epio, MGC_O_HDRC_TXCSR);
+	DBG(4, "<== %s, txcsr %04x\n", musb_ep->end_point.name, csr);
 
 	dma = is_dma_capable() ? musb_ep->dma : NULL;
 	do {
 		/* REVISIT for high bandwidth, MGC_M_TXCSR_P_INCOMPTX
 		 * probably rates reporting as a host error
 		 */
-		if (wCsrVal & MGC_M_TXCSR_P_SENTSTALL) {
-			wCsrVal |= MGC_M_TXCSR_P_WZC_BITS;
-			wCsrVal &= ~MGC_M_TXCSR_P_SENTSTALL;
-			musb_writew(epio, MGC_O_HDRC_TXCSR, wCsrVal);
+		if (csr & MGC_M_TXCSR_P_SENTSTALL) {
+			csr |= MGC_M_TXCSR_P_WZC_BITS;
+			csr &= ~MGC_M_TXCSR_P_SENTSTALL;
+			musb_writew(epio, MGC_O_HDRC_TXCSR, csr);
 			if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
 				dma->status = MGC_DMA_STATUS_CORE_ABORT;
 				musb->dma_controller->channel_abort(dma);
@@ -437,12 +437,12 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 			break;
 		}
 
-		if (wCsrVal & MGC_M_TXCSR_P_UNDERRUN) {
+		if (csr & MGC_M_TXCSR_P_UNDERRUN) {
 			/* we NAKed, no big deal ... little reason to care */
-			wCsrVal |= MGC_M_TXCSR_P_WZC_BITS;
-			wCsrVal &= ~(MGC_M_TXCSR_P_UNDERRUN
+			csr |= MGC_M_TXCSR_P_WZC_BITS;
+			csr &= ~(MGC_M_TXCSR_P_UNDERRUN
 					| MGC_M_TXCSR_TXPKTRDY);
-			musb_writew(epio, MGC_O_HDRC_TXCSR, wCsrVal);
+			musb_writew(epio, MGC_O_HDRC_TXCSR, csr);
 			DBG(20, "underrun on ep%d, req %p\n", epnum, request);
 		}
 
@@ -457,19 +457,19 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 		if (request) {
 			u8	is_dma = 0;
 
-			if (dma && (wCsrVal & MGC_M_TXCSR_DMAENAB)) {
+			if (dma && (csr & MGC_M_TXCSR_DMAENAB)) {
 				is_dma = 1;
-				wCsrVal |= MGC_M_TXCSR_P_WZC_BITS;
-				wCsrVal &= ~(MGC_M_TXCSR_DMAENAB
+				csr |= MGC_M_TXCSR_P_WZC_BITS;
+				csr &= ~(MGC_M_TXCSR_DMAENAB
 						| MGC_M_TXCSR_P_UNDERRUN
 						| MGC_M_TXCSR_TXPKTRDY);
-				musb_writew(epio, MGC_O_HDRC_TXCSR, wCsrVal);
+				musb_writew(epio, MGC_O_HDRC_TXCSR, csr);
 				/* ensure writebuffer is empty */
-				wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
+				csr = musb_readw(epio, MGC_O_HDRC_TXCSR);
 				request->actual += musb_ep->dma->actual_len;
 				DBG(4, "TXCSR%d %04x, dma off, "
 						"len %Zd, req %p\n",
-					epnum, wCsrVal,
+					epnum, csr,
 					musb_ep->dma->actual_len,
 					request);
 			}
@@ -495,7 +495,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 					/* on dma completion, fifo may not
 					 * be available yet ...
 					 */
-					if (wCsrVal & MGC_M_TXCSR_TXPKTRDY)
+					if (csr & MGC_M_TXCSR_TXPKTRDY)
 						break;
 
 					DBG(4, "sending zero pkt\n");
@@ -515,8 +515,8 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 				 * FIXME revisit for stalls too...
 				 */
 				musb_ep_select(mbase, epnum);
-				wCsrVal = musb_readw(epio, MGC_O_HDRC_TXCSR);
-				if (wCsrVal & MGC_M_TXCSR_FIFONOTEMPTY)
+				csr = musb_readw(epio, MGC_O_HDRC_TXCSR);
+				if (csr & MGC_M_TXCSR_FIFONOTEMPTY)
 					break;
 				request = musb_ep->desc
 						? next_request(musb_ep)
@@ -572,7 +572,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
  */
 static void rxstate(struct musb *musb, struct musb_request *req)
 {
-	u16			wCsrVal = 0;
+	u16			csr = 0;
 	const u8		epnum = req->epnum;
 	struct usb_request	*request = &req->request;
 	struct musb_ep		*musb_ep = &musb->endpoints[epnum].ep_out;
@@ -580,7 +580,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	u16			fifo_count = 0;
 	u16			len = musb_ep->wPacketSize;
 
-	wCsrVal = musb_readw(epio, MGC_O_HDRC_RXCSR);
+	csr = musb_readw(epio, MGC_O_HDRC_RXCSR);
 
 	if (is_cppi_enabled() && musb_ep->dma) {
 		struct dma_controller	*c = musb->dma_controller;
@@ -601,15 +601,15 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 			 * the cppi engine will be ready to take it as soon
 			 * as DMA is enabled
 			 */
-			wCsrVal &= ~(MGC_M_RXCSR_AUTOCLEAR
+			csr &= ~(MGC_M_RXCSR_AUTOCLEAR
 					| MGC_M_RXCSR_DMAMODE);
-			wCsrVal |= MGC_M_RXCSR_DMAENAB | MGC_M_RXCSR_P_WZC_BITS;
-			musb_writew(epio, MGC_O_HDRC_RXCSR, wCsrVal);
+			csr |= MGC_M_RXCSR_DMAENAB | MGC_M_RXCSR_P_WZC_BITS;
+			musb_writew(epio, MGC_O_HDRC_RXCSR, csr);
 			return;
 		}
 	}
 
-	if (wCsrVal & MGC_M_RXCSR_RXPKTRDY) {
+	if (csr & MGC_M_RXCSR_RXPKTRDY) {
 		len = musb_readw(epio, MGC_O_HDRC_RXCOUNT);
 		if (request->actual < request->length) {
 #ifdef CONFIG_USB_INVENTRA_DMA
@@ -642,20 +642,20 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	 * then becomes usable as a runtime "use mode 1" hint...
 	 */
 
-				wCsrVal |= MGC_M_RXCSR_DMAENAB;
+				csr |= MGC_M_RXCSR_DMAENAB;
 #ifdef USE_MODE1
-				wCsrVal |= MGC_M_RXCSR_AUTOCLEAR;
-//				wCsrVal |= MGC_M_RXCSR_DMAMODE;
+				csr |= MGC_M_RXCSR_AUTOCLEAR;
+//				csr |= MGC_M_RXCSR_DMAMODE;
 
 				/* this special sequence (enabling and then
 				   disabling MGC_M_RXCSR_DMAMODE) is required
 				   to get DMAReq to activate
 				 */
 				musb_writew(epio, MGC_O_HDRC_RXCSR,
-					wCsrVal | MGC_M_RXCSR_DMAMODE);
+					csr | MGC_M_RXCSR_DMAMODE);
 #endif
 				musb_writew(epio, MGC_O_HDRC_RXCSR,
-						wCsrVal);
+						csr);
 
 				if (request->actual < request->length) {
 					int transfer_size = 0;
@@ -718,9 +718,9 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 			 */
 
 			/* ack the read! */
-			wCsrVal |= MGC_M_RXCSR_P_WZC_BITS;
-			wCsrVal &= ~MGC_M_RXCSR_RXPKTRDY;
-			musb_writew(epio, MGC_O_HDRC_RXCSR, wCsrVal);
+			csr |= MGC_M_RXCSR_P_WZC_BITS;
+			csr &= ~MGC_M_RXCSR_RXPKTRDY;
+			musb_writew(epio, MGC_O_HDRC_RXCSR, csr);
 		}
 	}
 
@@ -734,7 +734,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
  */
 void musb_g_rx(struct musb *musb, u8 epnum)
 {
-	u16			wCsrVal;
+	u16			csr;
 	struct usb_request	*request;
 	void __iomem		*mbase = musb->mregs;
 	struct musb_ep		*musb_ep = &musb->endpoints[epnum].ep_out;
@@ -745,61 +745,61 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 
 	request = next_request(musb_ep);
 
-	wCsrVal = musb_readw(epio, MGC_O_HDRC_RXCSR);
+	csr = musb_readw(epio, MGC_O_HDRC_RXCSR);
 	dma = is_dma_capable() ? musb_ep->dma : NULL;
 
 	DBG(4, "<== %s, rxcsr %04x%s %p\n", musb_ep->end_point.name,
-			wCsrVal, dma ? " (dma)" : "", request);
+			csr, dma ? " (dma)" : "", request);
 
-	if (wCsrVal & MGC_M_RXCSR_P_SENTSTALL) {
+	if (csr & MGC_M_RXCSR_P_SENTSTALL) {
 		if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
 			dma->status = MGC_DMA_STATUS_CORE_ABORT;
 			(void) musb->dma_controller->channel_abort(dma);
 			request->actual += musb_ep->dma->actual_len;
 		}
 
-		wCsrVal |= MGC_M_RXCSR_P_WZC_BITS;
-		wCsrVal &= ~MGC_M_RXCSR_P_SENTSTALL;
-		musb_writew(epio, MGC_O_HDRC_RXCSR, wCsrVal);
+		csr |= MGC_M_RXCSR_P_WZC_BITS;
+		csr &= ~MGC_M_RXCSR_P_SENTSTALL;
+		musb_writew(epio, MGC_O_HDRC_RXCSR, csr);
 
 		if (request)
 			musb_g_giveback(musb_ep, request, -EPIPE);
 		goto done;
 	}
 
-	if (wCsrVal & MGC_M_RXCSR_P_OVERRUN) {
-		// wCsrVal |= MGC_M_RXCSR_P_WZC_BITS;
-		wCsrVal &= ~MGC_M_RXCSR_P_OVERRUN;
-		musb_writew(epio, MGC_O_HDRC_RXCSR, wCsrVal);
+	if (csr & MGC_M_RXCSR_P_OVERRUN) {
+		// csr |= MGC_M_RXCSR_P_WZC_BITS;
+		csr &= ~MGC_M_RXCSR_P_OVERRUN;
+		musb_writew(epio, MGC_O_HDRC_RXCSR, csr);
 
 		DBG(3, "%s iso overrun on %p\n", musb_ep->name, request);
 		if (request && request->status == -EINPROGRESS)
 			request->status = -EOVERFLOW;
 	}
-	if (wCsrVal & MGC_M_RXCSR_INCOMPRX) {
+	if (csr & MGC_M_RXCSR_INCOMPRX) {
 		/* REVISIT not necessarily an error */
 		DBG(4, "%s, incomprx\n", musb_ep->end_point.name);
 	}
 
 	if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
 		/* "should not happen"; likely RXPKTRDY pending for DMA */
-		DBG((wCsrVal & MGC_M_RXCSR_DMAENAB) ? 4 : 1,
+		DBG((csr & MGC_M_RXCSR_DMAENAB) ? 4 : 1,
 			"%s busy, csr %04x\n",
-			musb_ep->end_point.name, wCsrVal);
+			musb_ep->end_point.name, csr);
 		goto done;
 	}
 
-	if (dma && (wCsrVal & MGC_M_RXCSR_DMAENAB)) {
-		wCsrVal &= ~(MGC_M_RXCSR_AUTOCLEAR
+	if (dma && (csr & MGC_M_RXCSR_DMAENAB)) {
+		csr &= ~(MGC_M_RXCSR_AUTOCLEAR
 				| MGC_M_RXCSR_DMAENAB
 				| MGC_M_RXCSR_DMAMODE);
 		musb_writew(epio, MGC_O_HDRC_RXCSR,
-			MGC_M_RXCSR_P_WZC_BITS | wCsrVal);
+			MGC_M_RXCSR_P_WZC_BITS | csr);
 
 		request->actual += musb_ep->dma->actual_len;
 
 		DBG(4, "RXCSR%d %04x, dma off, %04x, len %Zd, req %p\n",
-			epnum, wCsrVal,
+			epnum, csr,
 			musb_readw(epio, MGC_O_HDRC_RXCSR),
 			musb_ep->dma->actual_len, request);
 
@@ -809,8 +809,8 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 				|| (dma->actual_len
 					& (musb_ep->wPacketSize - 1))) {
 			/* ack the read! */
-			wCsrVal &= ~MGC_M_RXCSR_RXPKTRDY;
-			musb_writew(epio, MGC_O_HDRC_RXCSR, wCsrVal);
+			csr &= ~MGC_M_RXCSR_RXPKTRDY;
+			musb_writew(epio, MGC_O_HDRC_RXCSR, csr);
 		}
 
 		/* incomplete, and not short? wait for next IN packet */
@@ -827,8 +827,8 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 
 		/* don't start more i/o till the stall clears */
 		musb_ep_select(mbase, epnum);
-		wCsrVal = musb_readw(epio, MGC_O_HDRC_RXCSR);
-		if (wCsrVal & MGC_M_RXCSR_P_SENDSTALL)
+		csr = musb_readw(epio, MGC_O_HDRC_RXCSR);
+		if (csr & MGC_M_RXCSR_P_SENDSTALL)
 			goto done;
 	}
 
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1021,7 +1021,7 @@ static int musb_h_ep0_continue(struct musb *musb,
 irqreturn_t musb_h_ep0_irq(struct musb *musb)
 {
 	struct urb		*pUrb;
-	u16			wCsrVal, len;
+	u16			csr, len;
 	int			status = 0;
 	void __iomem		*mbase = musb->mregs;
 	struct musb_hw_ep	*hw_ep = musb->control_ep;
@@ -1034,13 +1034,13 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 	pUrb = next_urb(qh);
 
 	musb_ep_select(mbase, 0);
-	wCsrVal = musb_readw(epio, MGC_O_HDRC_CSR0);
-	len = (wCsrVal & MGC_M_CSR0_RXPKTRDY)
+	csr = musb_readw(epio, MGC_O_HDRC_CSR0);
+	len = (csr & MGC_M_CSR0_RXPKTRDY)
 			? musb_readb(epio, MGC_O_HDRC_COUNT0)
 			: 0;
 
 	DBG(4, "<== csr0 %04x, qh %p, count %d, urb %p, stage %d\n",
-		wCsrVal, qh, len, pUrb, musb->ep0_stage);
+		csr, qh, len, pUrb, musb->ep0_stage);
 
 	/* if we just did status stage, we are done */
 	if (MGC_END0_STATUS == musb->ep0_stage) {
@@ -1049,15 +1049,15 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 	}
 
 	/* prepare status */
-	if (wCsrVal & MGC_M_CSR0_H_RXSTALL) {
+	if (csr & MGC_M_CSR0_H_RXSTALL) {
 		DBG(6, "STALLING ENDPOINT\n");
 		status = -EPIPE;
 
-	} else if (wCsrVal & MGC_M_CSR0_H_ERROR) {
-		DBG(2, "no response, csr0 %04x\n", wCsrVal);
+	} else if (csr & MGC_M_CSR0_H_ERROR) {
+		DBG(2, "no response, csr0 %04x\n", csr);
 		status = -EPROTO;
 
-	} else if (wCsrVal & MGC_M_CSR0_H_NAKTIMEOUT) {
+	} else if (csr & MGC_M_CSR0_H_NAKTIMEOUT) {
 		DBG(2, "control NAK timeout\n");
 
 		/* NOTE:  this code path would be a good place to PAUSE a
@@ -1079,17 +1079,17 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 		bComplete = TRUE;
 
 		/* use the proper sequence to abort the transfer */
-		if (wCsrVal & MGC_M_CSR0_H_REQPKT) {
-			wCsrVal &= ~MGC_M_CSR0_H_REQPKT;
-			musb_writew(epio, MGC_O_HDRC_CSR0, wCsrVal);
-			wCsrVal &= ~MGC_M_CSR0_H_NAKTIMEOUT;
-			musb_writew(epio, MGC_O_HDRC_CSR0, wCsrVal);
+		if (csr & MGC_M_CSR0_H_REQPKT) {
+			csr &= ~MGC_M_CSR0_H_REQPKT;
+			musb_writew(epio, MGC_O_HDRC_CSR0, csr);
+			csr &= ~MGC_M_CSR0_H_NAKTIMEOUT;
+			musb_writew(epio, MGC_O_HDRC_CSR0, csr);
 		} else {
-			wCsrVal |= MGC_M_CSR0_FLUSHFIFO;
-			musb_writew(epio, MGC_O_HDRC_CSR0, wCsrVal);
-			musb_writew(epio, MGC_O_HDRC_CSR0, wCsrVal);
-			wCsrVal &= ~MGC_M_CSR0_H_NAKTIMEOUT;
-			musb_writew(epio, MGC_O_HDRC_CSR0, wCsrVal);
+			csr |= MGC_M_CSR0_FLUSHFIFO;
+			musb_writew(epio, MGC_O_HDRC_CSR0, csr);
+			musb_writew(epio, MGC_O_HDRC_CSR0, csr);
+			csr &= ~MGC_M_CSR0_H_NAKTIMEOUT;
+			musb_writew(epio, MGC_O_HDRC_CSR0, csr);
 		}
 
 		musb_writeb(epio, MGC_O_HDRC_NAKLIMIT0, 0);
@@ -1114,25 +1114,25 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
 		/* call common logic and prepare response */
 		if (musb_h_ep0_continue(musb, len, pUrb)) {
 			/* more packets required */
-			wCsrVal = (MGC_END0_IN == musb->ep0_stage)
+			csr = (MGC_END0_IN == musb->ep0_stage)
 				?  MGC_M_CSR0_H_REQPKT : MGC_M_CSR0_TXPKTRDY;
 		} else {
 			/* data transfer complete; perform status phase */
 			if (usb_pipeout(pUrb->pipe)
 					|| !pUrb->transfer_buffer_length)
-				wCsrVal = MGC_M_CSR0_H_STATUSPKT
+				csr = MGC_M_CSR0_H_STATUSPKT
 					| MGC_M_CSR0_H_REQPKT;
 			else
-				wCsrVal = MGC_M_CSR0_H_STATUSPKT
+				csr = MGC_M_CSR0_H_STATUSPKT
 					| MGC_M_CSR0_TXPKTRDY;
 
 			/* flag status stage */
 			musb->ep0_stage = MGC_END0_STATUS;
 
-			DBG(5, "ep0 STATUS, csr %04x\n", wCsrVal);
+			DBG(5, "ep0 STATUS, csr %04x\n", csr);
 
 		}
-		musb_writew(epio, MGC_O_HDRC_CSR0, wCsrVal);
+		musb_writew(epio, MGC_O_HDRC_CSR0, csr);
 		retval = IRQ_HANDLED;
 	} else
 		musb->ep0_stage = MGC_END0_IDLE;
-- 
1.5.2.3
