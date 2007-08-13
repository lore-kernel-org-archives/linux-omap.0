From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/52] musb_hdrc: Search and replace bLocalEnd with epnum
Date: Mon, 13 Aug 2007 06:48:47 -0700
Message-ID: <1187012998290-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1187012995338-git-send-email-tony@atomide.com>
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

Search and replace bLocalEnd with epnum

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/cppi_dma.c      |    2 +-
 drivers/usb/musb/dma.h           |    2 +-
 drivers/usb/musb/musb_host.c     |   16 ++++++++--------
 drivers/usb/musb/musbdefs.h      |    2 +-
 drivers/usb/musb/musbhsdma.c     |    2 +-
 drivers/usb/musb/plat_uds.c      |   24 ++++++++++++------------
 drivers/usb/musb/tusb6010.c      |    4 ++--
 drivers/usb/musb/tusb6010_omap.c |    8 ++++----
 8 files changed, 30 insertions(+), 30 deletions(-)

--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -289,7 +289,7 @@ cppi_channel_allocate(struct dma_controller *c,
 	u8			chNum;
 	struct cppi_channel	*otgCh;
 	void __iomem		*tibase;
-	int			local_end = ep->bLocalEnd;
+	int			local_end = ep->epnum;
 
 	pController = container_of(c, struct cppi, Controller);
 	tibase = pController->pCoreBase - DAVINCI_BASE_OFFSET;
--- a/drivers/usb/musb/dma.h
+++ b/drivers/usb/musb/dma.h
@@ -180,7 +180,7 @@ struct dma_controller {
 };
 
 /* called after channel_program(), may indicate a fault */
-extern void musb_dma_completion(struct musb *musb, u8 bLocalEnd, u8 bTransmit);
+extern void musb_dma_completion(struct musb *musb, u8 epnum, u8 bTransmit);
 
 
 extern struct dma_controller *__init
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -139,7 +139,7 @@ static inline void musb_h_tx_start(struct musb_hw_ep *ep)
 	u16	txcsr;
 
 	/* NOTE: no locks here; caller should lock and select EP */
-	if (ep->bLocalEnd) {
+	if (ep->epnum) {
 		txcsr = musb_readw(ep->regs, MGC_O_HDRC_TXCSR);
 		txcsr |= MGC_M_TXCSR_TXPKTRDY | MGC_M_TXCSR_H_WZC_BITS;
 		musb_writew(ep->regs, MGC_O_HDRC_TXCSR, txcsr);
@@ -177,7 +177,7 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 	struct musb_hw_ep	*hw_ep = qh->hw_ep;
 	unsigned		nPipe = urb->pipe;
 	u8			bAddress = usb_pipedevice(nPipe);
-	int			bEnd = hw_ep->bLocalEnd;
+	int			bEnd = hw_ep->epnum;
 
 	/* initialize software qh state */
 	qh->offset = 0;
@@ -396,7 +396,7 @@ musb_giveback(struct musb_qh *qh, struct urb *urb, int status)
 			 * de-allocated if it's tracked and allocated;
 			 * and where we'd update the schedule tree...
 			 */
-			musb->periodic[ep->bLocalEnd] = NULL;
+			musb->periodic[ep->epnum] = NULL;
 			kfree(qh);
 			qh = NULL;
 			break;
@@ -437,7 +437,7 @@ musb_advance_schedule(struct musb *musb, struct urb *urb,
 
 	if (qh && qh->is_ready && !list_empty(&qh->hep->urb_list)) {
 		DBG(4, "... next ep%d %cX urb %p\n",
-				hw_ep->bLocalEnd, is_in ? 'R' : 'T',
+				hw_ep->epnum, is_in ? 'R' : 'T',
 				next_urb(qh));
 		musb_start_urb(musb, is_in, qh);
 	}
@@ -592,7 +592,7 @@ musb_rx_reinit(struct musb *musb, struct musb_qh *qh, struct musb_hw_ep *ep)
 	} else {
 		csr = musb_readw(ep->regs, MGC_O_HDRC_RXCSR);
 		if (csr & MGC_M_RXCSR_RXPKTRDY)
-			WARN("rx%d, packet/%d ready?\n", ep->bLocalEnd,
+			WARN("rx%d, packet/%d ready?\n", ep->epnum,
 				musb_readw(ep->regs, MGC_O_HDRC_RXCOUNT));
 
 		musb_h_flush_rxfifo(ep, MGC_M_RXCSR_CLRDATATOG);
@@ -893,7 +893,7 @@ static void musb_ep_program(struct musb *musb, u8 bEnd,
 					| MGC_M_RXCSR_DMAENAB
 					| MGC_M_RXCSR_H_REQPKT))
 				ERR("broken !rx_reinit, ep%d csr %04x\n",
-						hw_ep->bLocalEnd, csr);
+						hw_ep->epnum, csr);
 
 			/* scrub any stale state, leaving toggle alone */
 			csr &= MGC_M_RXCSR_DISNYET;
@@ -1903,7 +1903,7 @@ static int musb_cleanup_urb(struct urb *urb, struct musb_qh *qh, int is_in)
 {
 	struct musb_hw_ep	*ep = qh->hw_ep;
 	void __iomem		*epio = ep->regs;
-	unsigned		hw_end = ep->bLocalEnd;
+	unsigned		hw_end = ep->epnum;
 	void __iomem		*regs = ep->musb->mregs;
 	u16			csr;
 	int			status = 0;
@@ -1918,7 +1918,7 @@ static int musb_cleanup_urb(struct urb *urb, struct musb_qh *qh, int is_in)
 			status = ep->musb->pDmaController->channel_abort(dma);
 			DBG(status ? 1 : 3,
 				"abort %cX%d DMA for urb %p --> %d\n",
-				is_in ? 'R' : 'T', ep->bLocalEnd,
+				is_in ? 'R' : 'T', ep->epnum,
 				urb, status);
 			urb->actual_length += dma->dwActualLength;
 		}
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -283,7 +283,7 @@ struct musb_hw_ep {
 #endif
 
 	/* index in musb->aLocalEnd[]  */
-	u8			bLocalEnd;
+	u8			epnum;
 
 	/* hardware configuration, possibly dynamic */
 	u8			bIsSharedFifo;
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -140,7 +140,7 @@ static struct dma_channel* dma_channel_allocate(struct dma_controller *c,
 			pImplChannel = &(pController->aChannel[bBit]);
 			pImplChannel->pController = pController;
 			pImplChannel->bIndex = bBit;
-			pImplChannel->bEnd = hw_ep->bLocalEnd;
+			pImplChannel->bEnd = hw_ep->epnum;
 			pImplChannel->bTransmit = bTransmit;
 			pChannel = &(pImplChannel->Channel);
 			pChannel->pPrivateData = pImplChannel;
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -176,7 +176,7 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
 	prefetch((u8 *)src);
 
 	DBG(4, "%cX ep%d fifo %p count %d buf %p\n",
-			'T', hw_ep->bLocalEnd, fifo, len, src);
+			'T', hw_ep->epnum, fifo, len, src);
 
 	/* we can't assume unaligned reads work */
 	if (likely((0x01 & (unsigned long) src) == 0)) {
@@ -214,7 +214,7 @@ void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
 	void __iomem *fifo = hw_ep->fifo;
 
 	DBG(4, "%cX ep%d fifo %p count %d buf %p\n",
-			'R', hw_ep->bLocalEnd, fifo, len, dst);
+			'R', hw_ep->epnum, fifo, len, dst);
 
 	/* we can't assume unaligned writes work */
 	if (likely((0x01 & (unsigned long) dst) == 0)) {
@@ -1044,13 +1044,13 @@ fifo_setup(struct musb *musb, struct musb_hw_ep  *hw_ep,
 	}
 
 	/* configure the FIFO */
-	musb_writeb(mbase, MGC_O_HDRC_INDEX, hw_ep->bLocalEnd);
+	musb_writeb(mbase, MGC_O_HDRC_INDEX, hw_ep->epnum);
 
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 	/* EP0 reserved endpoint for control, bidirectional;
 	 * EP1 reserved for bulk, two unidirection halves.
 	 */
-	if (hw_ep->bLocalEnd == 1)
+	if (hw_ep->epnum == 1)
 		musb->bulk_ep = hw_ep;
 	/* REVISIT error check:  be sure ep0 can both rx and tx ... */
 #endif
@@ -1085,7 +1085,7 @@ fifo_setup(struct musb *musb, struct musb_hw_ep  *hw_ep,
 	/* NOTE rx and tx endpoint irqs aren't managed separately,
 	 * which happens to be ok
 	 */
-	musb->wEndMask |= (1 << hw_ep->bLocalEnd);
+	musb->wEndMask |= (1 << hw_ep->epnum);
 
 	return offset + (maxpacket << ((c_size & MGC_M_FIFOSZ_DPB) ? 1 : 0));
 }
@@ -1538,13 +1538,13 @@ static int __initdata use_dma = 1;
 module_param(use_dma, bool, 0);
 MODULE_PARM_DESC(use_dma, "enable/disable use of DMA");
 
-void musb_dma_completion(struct musb *musb, u8 bLocalEnd, u8 bTransmit)
+void musb_dma_completion(struct musb *musb, u8 epnum, u8 bTransmit)
 {
 	u8	devctl = musb_readb(musb->mregs, MGC_O_HDRC_DEVCTL);
 
 	/* called with controller lock already held */
 
-	if (!bLocalEnd) {
+	if (!epnum) {
 #ifndef CONFIG_USB_TUSB_OMAP_DMA
 		if (!is_cppi_enabled()) {
 			/* endpoint 0 */
@@ -1559,19 +1559,19 @@ void musb_dma_completion(struct musb *musb, u8 bLocalEnd, u8 bTransmit)
 		if (bTransmit) {
 			if (devctl & MGC_M_DEVCTL_HM) {
 				if (is_host_capable())
-					musb_host_tx(musb, bLocalEnd);
+					musb_host_tx(musb, epnum);
 			} else {
 				if (is_peripheral_capable())
-					musb_g_tx(musb, bLocalEnd);
+					musb_g_tx(musb, epnum);
 			}
 		} else {
 			/* receive */
 			if (devctl & MGC_M_DEVCTL_HM) {
 				if (is_host_capable())
-					musb_host_rx(musb, bLocalEnd);
+					musb_host_rx(musb, epnum);
 			} else {
 				if (is_peripheral_capable())
-					musb_g_rx(musb, bLocalEnd);
+					musb_g_rx(musb, epnum);
 			}
 		}
 	}
@@ -1776,7 +1776,7 @@ allocate_instance(struct device *dev, void __iomem *mbase)
 			epnum++, ep++) {
 
 		ep->musb = musb;
-		ep->bLocalEnd = epnum;
+		ep->epnum = epnum;
 	}
 
 	musb->controller = dev;
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -152,7 +152,7 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *buf)
 {
 	void __iomem	*ep_conf = hw_ep->conf;
 	void __iomem	*fifo = hw_ep->fifo;
-	u8		epnum = hw_ep->bLocalEnd;
+	u8		epnum = hw_ep->epnum;
 
 	prefetch(buf);
 
@@ -201,7 +201,7 @@ void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *buf)
 {
 	void __iomem	*ep_conf = hw_ep->conf;
 	void __iomem	*fifo = hw_ep->fifo;
-	u8		epnum = hw_ep->bLocalEnd;
+	u8		epnum = hw_ep->epnum;
 
 	DBG(4, "%cX ep%d fifo %p count %d buf %p\n",
 			'R', epnum, fifo, len, buf);
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -508,13 +508,13 @@ tusb_omap_dma_allocate(struct dma_controller *c,
 
 	reg = musb_readl(tusb_base, TUSB_DMA_INT_MASK);
 	if (tx)
-		reg &= ~(1 << hw_ep->bLocalEnd);
+		reg &= ~(1 << hw_ep->epnum);
 	else
-		reg &= ~(1 << (hw_ep->bLocalEnd + 15));
+		reg &= ~(1 << (hw_ep->epnum + 15));
 	musb_writel(tusb_base, TUSB_DMA_INT_MASK, reg);
 
 	/* REVISIT: Why does dmareq5 not work? */
-	if (hw_ep->bLocalEnd == 0) {
+	if (hw_ep->epnum == 0) {
 		DBG(3, "Not allowing DMA for ep0 %s\n", tx ? "tx" : "rx");
 		return NULL;
 	}
@@ -543,7 +543,7 @@ tusb_omap_dma_allocate(struct dma_controller *c,
 	chdat->musb = tusb_dma->musb;
 	chdat->tusb_base = tusb_dma->tusb_base;
 	chdat->hw_ep = hw_ep;
-	chdat->epnum = hw_ep->bLocalEnd;
+	chdat->epnum = hw_ep->epnum;
 	chdat->dmareq = -1;
 	chdat->completed_len = 0;
 	chdat->tusb_dma = tusb_dma;
-- 
1.5.2.3
