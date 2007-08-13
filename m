From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 26/52] musb_hdrc: Search and replace pDmaController with
	dma_controller
Date: Mon, 13 Aug 2007 06:49:01 -0700
Message-ID: <11870130314189-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1187013029823-git-send-email-tony@atomide.com>
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

Search and replace pDmaController with dma_controller

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/cppi_dma.c    |    2 +-
 drivers/usb/musb/musb_gadget.c |   20 ++++++++++----------
 drivers/usb/musb/musb_host.c   |   32 ++++++++++++++++----------------
 drivers/usb/musb/musb_procfs.c |    2 +-
 drivers/usb/musb/musbdefs.h    |    2 +-
 drivers/usb/musb/plat_uds.c    |   10 +++++-----
 6 files changed, 34 insertions(+), 34 deletions(-)

--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -1143,7 +1143,7 @@ void cppi_completion(struct musb *musb, u32 rx, u32 tx)
 	struct cppi_descriptor	*bdPtr;
 	struct musb_hw_ep	*hw_ep = NULL;
 
-	cppi = container_of(musb->pDmaController, struct cppi, Controller);
+	cppi = container_of(musb->dma_controller, struct cppi, Controller);
 
 	regBase = musb->ctrl_base;
 
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -164,7 +164,7 @@ static void nuke(struct musb_ep *ep, const int status)
 	ep->busy = 1;
 
 	if (is_dma_capable() && ep->dma) {
-		struct dma_controller	*c = ep->musb->pDmaController;
+		struct dma_controller	*c = ep->musb->dma_controller;
 		int value;
 		if (ep->is_in) {
 			musb_writew(epio, MGC_O_HDRC_TXCSR,
@@ -292,7 +292,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 
 #ifndef	CONFIG_USB_INVENTRA_FIFO
 	if (is_dma_capable() && musb_ep->dma) {
-		struct dma_controller	*c = musb->pDmaController;
+		struct dma_controller	*c = musb->dma_controller;
 
 		use_dma = (pRequest->dma != DMA_ADDR_INVALID);
 
@@ -428,7 +428,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 			musb_writew(epio, MGC_O_HDRC_TXCSR, wCsrVal);
 			if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
 				dma->bStatus = MGC_DMA_STATUS_CORE_ABORT;
-				musb->pDmaController->channel_abort(dma);
+				musb->dma_controller->channel_abort(dma);
 			}
 
 			if (pRequest)
@@ -583,7 +583,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	wCsrVal = musb_readw(epio, MGC_O_HDRC_RXCSR);
 
 	if (is_cppi_enabled() && musb_ep->dma) {
-		struct dma_controller	*c = musb->pDmaController;
+		struct dma_controller	*c = musb->dma_controller;
 		struct dma_channel	*channel = musb_ep->dma;
 
 		/* NOTE:  CPPI won't actually stop advancing the DMA
@@ -618,7 +618,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 				struct dma_channel	*channel;
 				int			use_dma = 0;
 
-				c = musb->pDmaController;
+				c = musb->dma_controller;
 				channel = musb_ep->dma;
 
 	/* We use DMA Req mode 0 in RxCsr, and DMA controller operates in
@@ -694,7 +694,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 
 #ifdef	CONFIG_USB_TUSB_OMAP_DMA
 			if (tusb_dma_omap() && musb_ep->dma) {
-				struct dma_controller *c = musb->pDmaController;
+				struct dma_controller *c = musb->dma_controller;
 				struct dma_channel *channel = musb_ep->dma;
 				u32 dma_addr = pRequest->dma + pRequest->actual;
 				int ret;
@@ -754,7 +754,7 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 	if (wCsrVal & MGC_M_RXCSR_P_SENTSTALL) {
 		if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
 			dma->bStatus = MGC_DMA_STATUS_CORE_ABORT;
-			(void) musb->pDmaController->channel_abort(dma);
+			(void) musb->dma_controller->channel_abort(dma);
 			pRequest->actual += musb_ep->dma->dwActualLength;
 		}
 
@@ -962,8 +962,8 @@ static int musb_gadget_enable(struct usb_ep *ep,
 	/* NOTE:  all the I/O code _should_ work fine without DMA, in case
 	 * for some reason you run out of channels here.
 	 */
-	if (is_dma_capable() && musb->pDmaController) {
-		struct dma_controller	*c = musb->pDmaController;
+	if (is_dma_capable() && musb->dma_controller) {
+		struct dma_controller	*c = musb->dma_controller;
 
 		musb_ep->dma = c->channel_alloc(c, hw_ep,
 				(desc->bEndpointAddress & USB_DIR_IN));
@@ -1199,7 +1199,7 @@ static int musb_gadget_dequeue(struct usb_ep *ep, struct usb_request *pRequest)
 
 	/* ... else abort the dma transfer ... */
 	else if (is_dma_capable() && musb_ep->dma) {
-		struct dma_controller	*c = musb->pDmaController;
+		struct dma_controller	*c = musb->dma_controller;
 
 		musb_ep_select(musb->mregs, musb_ep->current_epnum);
 		if (c->channel_abort)
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -627,7 +627,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			struct urb *pUrb, unsigned int is_out,
 			u8 * pBuffer, u32 dwLength)
 {
-	struct dma_controller	*pDmaController;
+	struct dma_controller	*dma_controller;
 	struct dma_channel	*pDmaChannel;
 	u8			bDmaOk;
 	void __iomem		*mbase = musb->mregs;
@@ -654,12 +654,12 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 	musb_ep_select(mbase, epnum);
 
 	/* candidate for DMA? */
-	pDmaController = musb->pDmaController;
-	if (is_dma_capable() && epnum && pDmaController) {
+	dma_controller = musb->dma_controller;
+	if (is_dma_capable() && epnum && dma_controller) {
 		pDmaChannel = is_out ? hw_ep->tx_channel : hw_ep->rx_channel;
 		if (!pDmaChannel) {
-			pDmaChannel = pDmaController->channel_alloc(
-					pDmaController, hw_ep, is_out);
+			pDmaChannel = dma_controller->channel_alloc(
+					dma_controller, hw_ep, is_out);
 			if (is_out)
 				hw_ep->tx_channel = pDmaChannel;
 			else
@@ -791,7 +791,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 
 			musb_writew(epio, MGC_O_HDRC_TXCSR, wCsr);
 
-			bDmaOk = pDmaController->channel_program(
+			bDmaOk = dma_controller->channel_program(
 					pDmaChannel, wPacketSize,
 					pDmaChannel->bDesiredMode,
 					pUrb->transfer_dma,
@@ -799,7 +799,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			if (bDmaOk) {
 				wLoadCount = 0;
 			} else {
-				pDmaController->channel_release(pDmaChannel);
+				dma_controller->channel_release(pDmaChannel);
 				if (is_out)
 					hw_ep->tx_channel = NULL;
 				else
@@ -830,7 +830,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			/* TX uses "rndis" mode automatically, but needs help
 			 * to identify the zero-length-final-packet case.
 			 */
-			bDmaOk = pDmaController->channel_program(
+			bDmaOk = dma_controller->channel_program(
 					pDmaChannel, wPacketSize,
 					(pUrb->transfer_flags
 							& URB_ZERO_PACKET)
@@ -840,7 +840,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			if (bDmaOk) {
 				wLoadCount = 0;
 			} else {
-				pDmaController->channel_release(pDmaChannel);
+				dma_controller->channel_release(pDmaChannel);
 				pDmaChannel = hw_ep->tx_channel = NULL;
 
 				/* REVISIT there's an error path here that
@@ -915,14 +915,14 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 				/* unless caller treats short rx transfers as
 				 * errors, we dare not queue multiple transfers.
 				 */
-				bDmaOk = pDmaController->channel_program(
+				bDmaOk = dma_controller->channel_program(
 						pDmaChannel, wPacketSize,
 						!(pUrb->transfer_flags
 							& URB_SHORT_NOT_OK),
 						pUrb->transfer_dma,
 						qh->segsize);
 				if (!bDmaOk) {
-					pDmaController->channel_release(
+					dma_controller->channel_release(
 							pDmaChannel);
 					pDmaChannel = hw_ep->rx_channel = NULL;
 				} else
@@ -1227,7 +1227,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 	if (status) {
 		if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
 			dma->bStatus = MGC_DMA_STATUS_CORE_ABORT;
-			(void) musb->pDmaController->channel_abort(dma);
+			(void) musb->dma_controller->channel_abort(dma);
 		}
 
 		/* do the proper sequence to abort the transfer in the
@@ -1461,7 +1461,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 		/* clean up dma and collect transfer count */
 		if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
 			dma->bStatus = MGC_DMA_STATUS_CORE_ABORT;
-			(void) musb->pDmaController->channel_abort(dma);
+			(void) musb->dma_controller->channel_abort(dma);
 			xfer_len = dma->dwActualLength;
 		}
 		musb_h_flush_rxfifo(hw_ep, 0);
@@ -1492,7 +1492,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 		 */
 		if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
 			dma->bStatus = MGC_DMA_STATUS_CORE_ABORT;
-			(void) musb->pDmaController->channel_abort(dma);
+			(void) musb->dma_controller->channel_abort(dma);
 			xfer_len = dma->dwActualLength;
 			bDone = TRUE;
 		}
@@ -1567,7 +1567,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 					qh->offset,
 					pUrb->transfer_buffer_length);
 
-			c = musb->pDmaController;
+			c = musb->dma_controller;
 
 			dma->bDesiredMode = 0;
 #ifdef USE_MODE1
@@ -1915,7 +1915,7 @@ static int musb_cleanup_urb(struct urb *urb, struct musb_qh *qh, int is_in)
 
 		dma = is_in ? ep->rx_channel : ep->tx_channel;
 		if (dma) {
-			status = ep->musb->pDmaController->channel_abort(dma);
+			status = ep->musb->dma_controller->channel_abort(dma);
 			DBG(status ? 1 : 3,
 				"abort %cX%d DMA for urb %p --> %d\n",
 				is_in ? 'R' : 'T', ep->epnum,
--- a/drivers/usb/musb/musb_procfs.c
+++ b/drivers/usb/musb/musb_procfs.c
@@ -593,7 +593,7 @@ static int dump_header_stats(struct musb *musb, char *buffer)
 	buffer += code;
 #endif	/* DAVINCI */
 
-	if (is_cppi_enabled() && musb->pDmaController) {
+	if (is_cppi_enabled() && musb->dma_controller) {
 		code = sprintf(buffer,
 				"CPPI: txcr=%d txsrc=%01x txena=%01x; "
 				"rxcr=%d rxsrc=%01x rxena=%01x "
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -356,7 +356,7 @@ struct musb {
 	 */
 	void			(*board_set_vbus)(struct musb *, int is_on);
 
-	struct dma_controller	*pDmaController;
+	struct dma_controller	*dma_controller;
 
 	struct device		*controller;
 	void __iomem		*ctrl_base;
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -1807,8 +1807,8 @@ static void musb_free(struct musb *musb)
 		disable_irq_wake(musb->nIrq);
 		free_irq(musb->nIrq, musb);
 	}
-	if (is_dma_capable() && musb->pDmaController) {
-		struct dma_controller	*c = musb->pDmaController;
+	if (is_dma_capable() && musb->dma_controller) {
+		struct dma_controller	*c = musb->dma_controller;
 
 		(void) c->stop(c->pPrivateData);
 		dma_controller_destroy(c);
@@ -1921,13 +1921,13 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 		struct dma_controller	*c;
 
 		c = dma_controller_create(musb, musb->mregs);
-		musb->pDmaController = c;
+		musb->dma_controller = c;
 		if (c)
 			(void) c->start(c->pPrivateData);
 	}
 #endif
 	/* ideally this would be abstracted in platform setup */
-	if (!is_dma_capable() || !musb->pDmaController)
+	if (!is_dma_capable() || !musb->dma_controller)
 		dev->dma_mask = NULL;
 
 	/* be sure interrupts are disabled before connecting ISR */
@@ -1961,7 +1961,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 			default:		s = "OTG"; break;
 			}; s; }),
 			ctrl,
-			(is_dma_capable() && musb->pDmaController)
+			(is_dma_capable() && musb->dma_controller)
 				? "DMA" : "PIO",
 			musb->nIrq);
 
-- 
1.5.2.3
