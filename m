From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 40/52] musb_hdrc: Search and replace bStatus with status
Date: Mon, 13 Aug 2007 06:49:15 -0700
Message-ID: <11870130771666-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11870130741506-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Search and replace bStatus with status

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/cppi_dma.c      |   22 +++++++++++-----------
 drivers/usb/musb/dma.h           |    6 +++---
 drivers/usb/musb/musb_gadget.c   |    4 ++--
 drivers/usb/musb/musb_host.c     |    6 +++---
 drivers/usb/musb/musbhsdma.c     |   18 +++++++++---------
 drivers/usb/musb/tusb6010_omap.c |   16 ++++++++--------
 6 files changed, 36 insertions(+), 36 deletions(-)

--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -99,7 +99,7 @@ static void __init cppi_pool_init(struct cppi *cppi, struct cppi_channel *c)
 	c->activeQueueHead = NULL;
 	c->activeQueueTail = NULL;
 	c->lastHwBDProcessed = NULL;
-	c->Channel.bStatus = MGC_DMA_STATUS_UNKNOWN;
+	c->Channel.status = MGC_DMA_STATUS_UNKNOWN;
 	c->pController = cppi;
 	c->bLastModeRndis = 0;
 	c->Channel.private_data = c;
@@ -124,7 +124,7 @@ static void cppi_pool_free(struct cppi_channel *c)
 	struct cppi_descriptor	*bd;
 
 	(void) cppi_channel_abort(&c->Channel);
-	c->Channel.bStatus = MGC_DMA_STATUS_UNKNOWN;
+	c->Channel.status = MGC_DMA_STATUS_UNKNOWN;
 	c->pController = NULL;
 
 	/* free all its bds */
@@ -322,7 +322,7 @@ cppi_channel_allocate(struct dma_controller *c,
 		DBG(1, "re-allocating DMA%d %cX channel %p\n",
 				chNum, bTransmit ? 'T' : 'R', otgCh);
 	otgCh->hw_ep = ep;
-	otgCh->Channel.bStatus = MGC_DMA_STATUS_FREE;
+	otgCh->Channel.status = MGC_DMA_STATUS_FREE;
 
 	DBG(4, "Allocate CPPI%d %cX\n", chNum, bTransmit ? 'T' : 'R');
 	otgCh->Channel.private_data = otgCh;
@@ -348,7 +348,7 @@ static void cppi_channel_release(struct dma_channel *channel)
 
 	/* for now, leave its cppi IRQ enabled (we won't trigger it) */
 	c->hw_ep = NULL;
-	channel->bStatus = MGC_DMA_STATUS_UNKNOWN;
+	channel->status = MGC_DMA_STATUS_UNKNOWN;
 }
 
 /* Context: controller irqlocked */
@@ -957,7 +957,7 @@ static int cppi_channel_program(struct dma_channel *pChannel,
 	struct cppi		*pController = otgChannel->pController;
 	struct musb		*musb = pController->musb;
 
-	switch (pChannel->bStatus) {
+	switch (pChannel->status) {
 	case MGC_DMA_STATUS_BUS_ABORT:
 	case MGC_DMA_STATUS_CORE_ABORT:
 		/* fault irq handler should have handled cleanup */
@@ -981,7 +981,7 @@ static int cppi_channel_program(struct dma_channel *pChannel,
 		break;
 	}
 
-	pChannel->bStatus = MGC_DMA_STATUS_BUSY;
+	pChannel->status = MGC_DMA_STATUS_BUSY;
 
 	/* set transfer parameters, then queue up its first segment */
 	otgChannel->startAddr = dma_addr;
@@ -1224,7 +1224,7 @@ void cppi_completion(struct musb *musb, u32 rx, u32 tx)
 						>= txChannel->transferSize) {
 					txChannel->activeQueueHead = NULL;
 					txChannel->activeQueueTail = NULL;
-					txChannel->Channel.bStatus =
+					txChannel->Channel.status =
 							MGC_DMA_STATUS_FREE;
 
 					hw_ep = txChannel->hw_ep;
@@ -1288,7 +1288,7 @@ void cppi_completion(struct musb *musb, u32 rx, u32 tx)
 			}
 
 			/* all segments completed! */
-			rxChannel->Channel.bStatus = MGC_DMA_STATUS_FREE;
+			rxChannel->Channel.status = MGC_DMA_STATUS_FREE;
 
 			hw_ep = rxChannel->hw_ep;
 
@@ -1375,7 +1375,7 @@ static int cppi_channel_abort(struct dma_channel *channel)
 	pController = otgCh->pController;
 	chNum = otgCh->chNo;
 
-	switch (channel->bStatus) {
+	switch (channel->status) {
 	case MGC_DMA_STATUS_BUS_ABORT:
 	case MGC_DMA_STATUS_CORE_ABORT:
 		/* from RX or TX fault irq handler */
@@ -1515,7 +1515,7 @@ static int cppi_channel_abort(struct dma_channel *channel)
 		 * refers to an entire "DMA packet" not just emptying the
 		 * current fifo; most segments need multiple usb packets.
 		 */
-		if (channel->bStatus == MGC_DMA_STATUS_BUSY)
+		if (channel->status == MGC_DMA_STATUS_BUSY)
 			udelay(50);
 
 		/* scan the current list, reporting any data that was
@@ -1552,7 +1552,7 @@ static int cppi_channel_abort(struct dma_channel *channel)
 		}
 	}
 
-	channel->bStatus = MGC_DMA_STATUS_FREE;
+	channel->status = MGC_DMA_STATUS_FREE;
 	otgCh->startAddr = 0;
 	otgCh->currOffset = 0;
 	otgCh->transferSize = 0;
--- a/drivers/usb/musb/dma.h
+++ b/drivers/usb/musb/dma.h
@@ -104,7 +104,7 @@ struct dma_controller;
  * @wMaxLength: the maximum number of bytes the channel can move in one
  *	transaction (typically representing many USB maximum-sized packets)
  * @actual_len: how many bytes have been transferred
- * @bStatus: current channel status (updated e.g. on interrupt)
+ * @status: current channel status (updated e.g. on interrupt)
  * @bDesiredMode: TRUE if mode 1 is desired; FALSE if mode 0 is desired
  *
  * channels are associated with an endpoint for the duration of at least
@@ -115,7 +115,7 @@ struct dma_channel {
 	// FIXME not void* private_data, but a dma_controller *
 	size_t			max_len;
 	size_t			actual_len;
-	enum dma_channel_status	bStatus;
+	enum dma_channel_status	status;
 	u8			bDesiredMode;
 };
 
@@ -151,7 +151,7 @@ typedef int (*MGC_pfDmaProgramChannel) (
 static inline enum dma_channel_status
 dma_channel_status(struct dma_channel *c)
 {
-	return (is_dma_capable() && c) ? c->bStatus : MGC_DMA_STATUS_UNKNOWN;
+	return (is_dma_capable() && c) ? c->status : MGC_DMA_STATUS_UNKNOWN;
 }
 
 /**
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -427,7 +427,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 			wCsrVal &= ~MGC_M_TXCSR_P_SENTSTALL;
 			musb_writew(epio, MGC_O_HDRC_TXCSR, wCsrVal);
 			if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
-				dma->bStatus = MGC_DMA_STATUS_CORE_ABORT;
+				dma->status = MGC_DMA_STATUS_CORE_ABORT;
 				musb->dma_controller->channel_abort(dma);
 			}
 
@@ -753,7 +753,7 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 
 	if (wCsrVal & MGC_M_RXCSR_P_SENTSTALL) {
 		if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
-			dma->bStatus = MGC_DMA_STATUS_CORE_ABORT;
+			dma->status = MGC_DMA_STATUS_CORE_ABORT;
 			(void) musb->dma_controller->channel_abort(dma);
 			pRequest->actual += musb_ep->dma->actual_len;
 		}
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1226,7 +1226,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 
 	if (status) {
 		if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
-			dma->bStatus = MGC_DMA_STATUS_CORE_ABORT;
+			dma->status = MGC_DMA_STATUS_CORE_ABORT;
 			(void) musb->dma_controller->channel_abort(dma);
 		}
 
@@ -1460,7 +1460,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 	if (status) {
 		/* clean up dma and collect transfer count */
 		if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
-			dma->bStatus = MGC_DMA_STATUS_CORE_ABORT;
+			dma->status = MGC_DMA_STATUS_CORE_ABORT;
 			(void) musb->dma_controller->channel_abort(dma);
 			xfer_len = dma->actual_len;
 		}
@@ -1491,7 +1491,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 		 * shouldn't this be the "half full" double buffer case?
 		 */
 		if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
-			dma->bStatus = MGC_DMA_STATUS_CORE_ABORT;
+			dma->status = MGC_DMA_STATUS_CORE_ABORT;
 			(void) musb->dma_controller->channel_abort(dma);
 			xfer_len = dma->actual_len;
 			bDone = TRUE;
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -144,7 +144,7 @@ static struct dma_channel* dma_channel_allocate(struct dma_controller *c,
 			pImplChannel->bTransmit = bTransmit;
 			pChannel = &(pImplChannel->Channel);
 			pChannel->private_data = pImplChannel;
-			pChannel->bStatus = MGC_DMA_STATUS_FREE;
+			pChannel->status = MGC_DMA_STATUS_FREE;
 			pChannel->max_len = 0x10000;
 			/* Tx => mode 1; Rx => mode 0 */
 			pChannel->bDesiredMode = bTransmit;
@@ -167,7 +167,7 @@ static void dma_channel_release(struct dma_channel *pChannel)
 	pImplChannel->pController->bmUsedChannels &=
 		~(1 << pImplChannel->bIndex);
 
-	pChannel->bStatus = MGC_DMA_STATUS_UNKNOWN;
+	pChannel->status = MGC_DMA_STATUS_UNKNOWN;
 }
 
 static void configure_channel(struct dma_channel *pChannel,
@@ -232,14 +232,14 @@ static int dma_channel_program(struct dma_channel * pChannel,
 		pImplChannel->bTransmit ? "Tx" : "Rx",
 		wPacketSize, dma_addr, dwLength, bMode);
 
-	BUG_ON(pChannel->bStatus == MGC_DMA_STATUS_UNKNOWN ||
-		pChannel->bStatus == MGC_DMA_STATUS_BUSY);
+	BUG_ON(pChannel->status == MGC_DMA_STATUS_UNKNOWN ||
+		pChannel->status == MGC_DMA_STATUS_BUSY);
 
 	pChannel->actual_len = 0;
 	pImplChannel->dwStartAddress = dma_addr;
 	pImplChannel->len = dwLength;
 	pImplChannel->wMaxPacketSize = wPacketSize;
-	pChannel->bStatus = MGC_DMA_STATUS_BUSY;
+	pChannel->status = MGC_DMA_STATUS_BUSY;
 
 	if ((bMode == 1) && (dwLength >= wPacketSize)) {
 		configure_channel(pChannel, wPacketSize, 1, dma_addr,
@@ -259,7 +259,7 @@ static int dma_channel_abort(struct dma_channel *pChannel)
 	u8 *mbase = pImplChannel->pController->pCoreBase;
 	u16 csr;
 
-	if (pChannel->bStatus == MGC_DMA_STATUS_BUSY) {
+	if (pChannel->status == MGC_DMA_STATUS_BUSY) {
 		if (pImplChannel->bTransmit) {
 
 			csr = musb_readw(mbase,
@@ -289,7 +289,7 @@ static int dma_channel_abort(struct dma_channel *pChannel)
 		musb_writel(mbase,
 		   MGC_HSDMA_CHANNEL_OFFSET(bChannel, MGC_O_HSDMA_COUNT), 0);
 
-		pChannel->bStatus = MGC_DMA_STATUS_FREE;
+		pChannel->status = MGC_DMA_STATUS_FREE;
 	}
 	return 0;
 }
@@ -322,7 +322,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 							MGC_O_HSDMA_CONTROL));
 
 			if (wCsr & (1 << MGC_S_HSDMA_BUSERROR)) {
-				pImplChannel->Channel.bStatus =
+				pImplChannel->Channel.status =
 				    MGC_DMA_STATUS_BUS_ABORT;
 			} else {
 				dwAddress = musb_readl(mbase,
@@ -343,7 +343,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 				u8 devctl = musb_readb(mbase,
 						MGC_O_HDRC_DEVCTL);
 
-				pChannel->bStatus = MGC_DMA_STATUS_FREE;
+				pChannel->status = MGC_DMA_STATUS_FREE;
 
 				/* completed */
 				if ((devctl & MGC_M_DEVCTL_HM)
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -202,7 +202,7 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 	if (!dmareq_works())
 		tusb_omap_free_shared_dmareq(chdat);
 
-	channel->bStatus = MGC_DMA_STATUS_FREE;
+	channel->status = MGC_DMA_STATUS_FREE;
 
 	/* Handle only RX callbacks here. TX callbacks musb be handled based
 	 * on the TUSB DMA status interrupt.
@@ -296,7 +296,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 	chdat->len = len;
 	channel->actual_len = 0;
 	chdat->dma_addr = (void __iomem *)dma_addr;
-	channel->bStatus = MGC_DMA_STATUS_BUSY;
+	channel->status = MGC_DMA_STATUS_BUSY;
 
 	/* Since we're recycling dma areas, we need to clean or invalidate */
 	if (chdat->tx) {
@@ -430,7 +430,7 @@ static int tusb_omap_dma_abort(struct dma_channel *channel)
 		tusb_dma->sync_dev = -1;
 	}
 
-	channel->bStatus = MGC_DMA_STATUS_FREE;
+	channel->status = MGC_DMA_STATUS_FREE;
 
 	return 0;
 }
@@ -521,8 +521,8 @@ tusb_omap_dma_allocate(struct dma_controller *c,
 
 	for (i = 0; i < MAX_DMAREQ; i++) {
 		struct dma_channel *ch = dma_channel_pool[i];
-		if (ch->bStatus == MGC_DMA_STATUS_UNKNOWN) {
-			ch->bStatus = MGC_DMA_STATUS_FREE;
+		if (ch->status == MGC_DMA_STATUS_UNKNOWN) {
+			ch->status = MGC_DMA_STATUS_FREE;
 			channel = ch;
 			chdat = ch->private_data;
 			break;
@@ -589,7 +589,7 @@ free_dmareq:
 	tusb_omap_dma_free_dmareq(chdat);
 
 	DBG(3, "ep%i: Could not get a DMA channel\n", chdat->epnum);
-	channel->bStatus = MGC_DMA_STATUS_UNKNOWN;
+	channel->status = MGC_DMA_STATUS_UNKNOWN;
 
 	return NULL;
 }
@@ -617,7 +617,7 @@ static void tusb_omap_dma_release(struct dma_channel *channel)
 		reg |= (1 << (chdat->epnum + 15));
 	musb_writel(tusb_base, TUSB_DMA_INT_CLEAR, reg);
 
-	channel->bStatus = MGC_DMA_STATUS_UNKNOWN;
+	channel->status = MGC_DMA_STATUS_UNKNOWN;
 
 	if (chdat->ch >= 0) {
 		omap_stop_dma(chdat->ch);
@@ -702,7 +702,7 @@ dma_controller_create(struct musb *musb, void __iomem *base)
 		if (!chdat)
 			goto cleanup;
 
-		ch->bStatus = MGC_DMA_STATUS_UNKNOWN;
+		ch->status = MGC_DMA_STATUS_UNKNOWN;
 		ch->private_data = chdat;
 	}
 
-- 
1.5.2.3
