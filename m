From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 36/36] musb_hdrc: Search and replace MGC_DMA with MUSB_DMA
Date: Thu, 16 Aug 2007 02:40:59 -0700
Message-ID: <1187257343361-git-send-email-tony@atomide.com>
References: <11872572591844-git-send-email-tony@atomide.com>
	<11872572612810-git-send-email-tony@atomide.com>
	<11872572643880-git-send-email-tony@atomide.com>
	<11872572672740-git-send-email-tony@atomide.com>
	<11872572693807-git-send-email-tony@atomide.com>
	<11872572713057-git-send-email-tony@atomide.com>
	<11872572743878-git-send-email-tony@atomide.com>
	<11872572762670-git-send-email-tony@atomide.com>
	<1187257278289-git-send-email-tony@atomide.com>
	<11872572803477-git-send-email-tony@atomide.com>
	<1187257282941-git-send-email-tony@atomide.com>
	<11872572842479-git-send-email-tony@atomide.com>
	<11872572872790-git-send-email-tony@atomide.com>
	<11872572893163-git-send-email-tony@atomide.com>
	<1187257291525-git-send-email-tony@atomide.com>
	<1187257294890-git-send-email-tony@atomide.com>
	<11872572962771-git-send-email-tony@atomide.com>
	<11872572981150-git-send-email-tony@atomide.com>
	<1187257301587-git-send-email-tony@atomide.com>
	<1187257303715-git-send-email-tony@atomide.com>
	<11872573062287-git-send-email-tony@atomide.com>
	<11872573092269-git-send-email-tony@atomide.com>
	<1187257311394-git-send-email-tony@atomide.com>
	<11872573133142-git-send-email-tony@atomide.com>
	<11872573161558-git-send-email-tony@atomide.com>
	<1187257318333-git-send-email-tony@atomide.com>
	<11872573202855-git-send-email-tony@atomide.com>
	<11872573222937-git-send-email-tony@atomide.com>
	<1187257324463-git-send-email-tony@atomide.com>
	<11872573273963-git-send-email-tony@atomide.com>
	<1187257329166-git-send-email-tony@atomide.com>
	<118725733255-git-send-email-tony@atomide.com>
	<1187257334140-git-send-email-tony@atomide.com>
	<11872573361440-git-send-email-tony@atomide.com>
	<11872573381837-git-send-email-tony@atomide.com>
	<11872573412321-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11872573412321-git-send-email-tony@atomide.com>
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

Search and replace MGC_DMA with MUSB_DMA

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/cppi_dma.c      |   38 +++++++++++++++++++-------------------
 drivers/usb/musb/dma.h           |   12 ++++++------
 drivers/usb/musb/musb_gadget.c   |   14 +++++++-------
 drivers/usb/musb/musb_host.c     |   16 ++++++++--------
 drivers/usb/musb/musbhsdma.c     |   18 +++++++++---------
 drivers/usb/musb/tusb6010_omap.c |   16 ++++++++--------
 6 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/drivers/usb/musb/cppi_dma.c b/drivers/usb/musb/cppi_dma.c
index c1fa2b6..8ce3fd5 100644
--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -99,7 +99,7 @@ static void __init cppi_pool_init(struct cppi *cppi, struct cppi_channel *c)
 	c->activeQueueHead = NULL;
 	c->activeQueueTail = NULL;
 	c->lastHwBDProcessed = NULL;
-	c->Channel.status = MGC_DMA_STATUS_UNKNOWN;
+	c->Channel.status = MUSB_DMA_STATUS_UNKNOWN;
 	c->controller = cppi;
 	c->bLastModeRndis = 0;
 	c->Channel.private_data = c;
@@ -124,7 +124,7 @@ static void cppi_pool_free(struct cppi_channel *c)
 	struct cppi_descriptor	*bd;
 
 	(void) cppi_channel_abort(&c->Channel);
-	c->Channel.status = MGC_DMA_STATUS_UNKNOWN;
+	c->Channel.status = MUSB_DMA_STATUS_UNKNOWN;
 	c->controller = NULL;
 
 	/* free all its bds */
@@ -322,7 +322,7 @@ cppi_channel_allocate(struct dma_controller *c,
 		DBG(1, "re-allocating DMA%d %cX channel %p\n",
 				chNum, transmit ? 'T' : 'R', otgCh);
 	otgCh->hw_ep = ep;
-	otgCh->Channel.status = MGC_DMA_STATUS_FREE;
+	otgCh->Channel.status = MUSB_DMA_STATUS_FREE;
 
 	DBG(4, "Allocate CPPI%d %cX\n", chNum, transmit ? 'T' : 'R');
 	otgCh->Channel.private_data = otgCh;
@@ -348,7 +348,7 @@ static void cppi_channel_release(struct dma_channel *channel)
 
 	/* for now, leave its cppi IRQ enabled (we won't trigger it) */
 	c->hw_ep = NULL;
-	channel->status = MGC_DMA_STATUS_UNKNOWN;
+	channel->status = MUSB_DMA_STATUS_UNKNOWN;
 }
 
 /* Context: controller irqlocked */
@@ -958,30 +958,30 @@ static int cppi_channel_program(struct dma_channel *pChannel,
 	struct musb		*musb = controller->musb;
 
 	switch (pChannel->status) {
-	case MGC_DMA_STATUS_BUS_ABORT:
-	case MGC_DMA_STATUS_CORE_ABORT:
+	case MUSB_DMA_STATUS_BUS_ABORT:
+	case MUSB_DMA_STATUS_CORE_ABORT:
 		/* fault irq handler should have handled cleanup */
 		WARN("%cX DMA%d not cleaned up after abort!\n",
 				otgChannel->transmit ? 'T' : 'R',
 				otgChannel->chNo);
 		//WARN_ON(1);
 		break;
-	case MGC_DMA_STATUS_BUSY:
+	case MUSB_DMA_STATUS_BUSY:
 		WARN("program active channel?  %cX DMA%d\n",
 				otgChannel->transmit ? 'T' : 'R',
 				otgChannel->chNo);
 		//WARN_ON(1);
 		break;
-	case MGC_DMA_STATUS_UNKNOWN:
+	case MUSB_DMA_STATUS_UNKNOWN:
 		DBG(1, "%cX DMA%d not allocated!\n",
 				otgChannel->transmit ? 'T' : 'R',
 				otgChannel->chNo);
 		/* FALLTHROUGH */
-	case MGC_DMA_STATUS_FREE:
+	case MUSB_DMA_STATUS_FREE:
 		break;
 	}
 
-	pChannel->status = MGC_DMA_STATUS_BUSY;
+	pChannel->status = MUSB_DMA_STATUS_BUSY;
 
 	/* set transfer parameters, then queue up its first segment */
 	otgChannel->startAddr = dma_addr;
@@ -1225,7 +1225,7 @@ void cppi_completion(struct musb *musb, u32 rx, u32 tx)
 					txChannel->activeQueueHead = NULL;
 					txChannel->activeQueueTail = NULL;
 					txChannel->Channel.status =
-							MGC_DMA_STATUS_FREE;
+							MUSB_DMA_STATUS_FREE;
 
 					hw_ep = txChannel->hw_ep;
 
@@ -1288,7 +1288,7 @@ void cppi_completion(struct musb *musb, u32 rx, u32 tx)
 			}
 
 			/* all segments completed! */
-			rxChannel->Channel.status = MGC_DMA_STATUS_FREE;
+			rxChannel->Channel.status = MUSB_DMA_STATUS_FREE;
 
 			hw_ep = rxChannel->hw_ep;
 
@@ -1376,15 +1376,15 @@ static int cppi_channel_abort(struct dma_channel *channel)
 	chNum = otgCh->chNo;
 
 	switch (channel->status) {
-	case MGC_DMA_STATUS_BUS_ABORT:
-	case MGC_DMA_STATUS_CORE_ABORT:
+	case MUSB_DMA_STATUS_BUS_ABORT:
+	case MUSB_DMA_STATUS_CORE_ABORT:
 		/* from RX or TX fault irq handler */
-	case MGC_DMA_STATUS_BUSY:
+	case MUSB_DMA_STATUS_BUSY:
 		/* the hardware needs shutting down */
 		regs = otgCh->hw_ep->regs;
 		break;
-	case MGC_DMA_STATUS_UNKNOWN:
-	case MGC_DMA_STATUS_FREE:
+	case MUSB_DMA_STATUS_UNKNOWN:
+	case MUSB_DMA_STATUS_FREE:
 		return 0;
 	default:
 		return -EINVAL;
@@ -1515,7 +1515,7 @@ static int cppi_channel_abort(struct dma_channel *channel)
 		 * refers to an entire "DMA packet" not just emptying the
 		 * current fifo; most segments need multiple usb packets.
 		 */
-		if (channel->status == MGC_DMA_STATUS_BUSY)
+		if (channel->status == MUSB_DMA_STATUS_BUSY)
 			udelay(50);
 
 		/* scan the current list, reporting any data that was
@@ -1552,7 +1552,7 @@ static int cppi_channel_abort(struct dma_channel *channel)
 		}
 	}
 
-	channel->status = MGC_DMA_STATUS_FREE;
+	channel->status = MUSB_DMA_STATUS_FREE;
 	otgCh->startAddr = 0;
 	otgCh->currOffset = 0;
 	otgCh->transferSize = 0;
diff --git a/drivers/usb/musb/dma.h b/drivers/usb/musb/dma.h
index 2333667..5d76f6a 100644
--- a/drivers/usb/musb/dma.h
+++ b/drivers/usb/musb/dma.h
@@ -86,15 +86,15 @@ struct musb_hw_ep;
  */
 enum dma_channel_status {
 	/* unallocated */
-	MGC_DMA_STATUS_UNKNOWN,
+	MUSB_DMA_STATUS_UNKNOWN,
 	/* allocated ... but not busy, no errors */
-	MGC_DMA_STATUS_FREE,
+	MUSB_DMA_STATUS_FREE,
 	/* busy ... transactions are active */
-	MGC_DMA_STATUS_BUSY,
+	MUSB_DMA_STATUS_BUSY,
 	/* transaction(s) aborted due to ... dma or memory bus error */
-	MGC_DMA_STATUS_BUS_ABORT,
+	MUSB_DMA_STATUS_BUS_ABORT,
 	/* transaction(s) aborted due to ... core error or USB fault */
-	MGC_DMA_STATUS_CORE_ABORT
+	MUSB_DMA_STATUS_CORE_ABORT
 };
 
 struct dma_controller;
@@ -131,7 +131,7 @@ struct dma_channel {
 static inline enum dma_channel_status
 dma_channel_status(struct dma_channel *c)
 {
-	return (is_dma_capable() && c) ? c->status : MGC_DMA_STATUS_UNKNOWN;
+	return (is_dma_capable() && c) ? c->status : MUSB_DMA_STATUS_UNKNOWN;
 }
 
 /**
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 4d90717..0f04288 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -263,7 +263,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 	musb_ep = req->ep;
 
 	/* we shouldn't get here while DMA is active ... but we do ... */
-	if (dma_channel_status(musb_ep->dma) == MGC_DMA_STATUS_BUSY) {
+	if (dma_channel_status(musb_ep->dma) == MUSB_DMA_STATUS_BUSY) {
 		DBG(4, "dma pending...\n");
 		return;
 	}
@@ -427,8 +427,8 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 			csr |= MUSB_TXCSR_P_WZC_BITS;
 			csr &= ~MUSB_TXCSR_P_SENTSTALL;
 			musb_writew(epio, MUSB_TXCSR, csr);
-			if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
-				dma->status = MGC_DMA_STATUS_CORE_ABORT;
+			if (dma_channel_status(dma) == MUSB_DMA_STATUS_BUSY) {
+				dma->status = MUSB_DMA_STATUS_CORE_ABORT;
 				musb->dma_controller->channel_abort(dma);
 			}
 
@@ -447,7 +447,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 			DBG(20, "underrun on ep%d, req %p\n", epnum, request);
 		}
 
-		if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
+		if (dma_channel_status(dma) == MUSB_DMA_STATUS_BUSY) {
 			/* SHOULD NOT HAPPEN ... has with cppi though, after
 			 * changing SENDSTALL (and other cases); harmless?
 			 */
@@ -753,8 +753,8 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 			csr, dma ? " (dma)" : "", request);
 
 	if (csr & MUSB_RXCSR_P_SENTSTALL) {
-		if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
-			dma->status = MGC_DMA_STATUS_CORE_ABORT;
+		if (dma_channel_status(dma) == MUSB_DMA_STATUS_BUSY) {
+			dma->status = MUSB_DMA_STATUS_CORE_ABORT;
 			(void) musb->dma_controller->channel_abort(dma);
 			request->actual += musb_ep->dma->actual_len;
 		}
@@ -782,7 +782,7 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 		DBG(4, "%s, incomprx\n", musb_ep->end_point.name);
 	}
 
-	if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
+	if (dma_channel_status(dma) == MUSB_DMA_STATUS_BUSY) {
 		/* "should not happen"; likely RXPKTRDY pending for DMA */
 		DBG((csr & MUSB_RXCSR_DMAENAB) ? 4 : 1,
 			"%s busy, csr %04x\n",
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 933e292..27dd33f 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1225,8 +1225,8 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 	}
 
 	if (status) {
-		if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
-			dma->status = MGC_DMA_STATUS_CORE_ABORT;
+		if (dma_channel_status(dma) == MUSB_DMA_STATUS_BUSY) {
+			dma->status = MUSB_DMA_STATUS_CORE_ABORT;
 			(void) musb->dma_controller->channel_abort(dma);
 		}
 
@@ -1251,7 +1251,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 	}
 
 	/* second cppi case */
-	if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
+	if (dma_channel_status(dma) == MUSB_DMA_STATUS_BUSY) {
 		DBG(4, "extra TX%d ready, csr %04x\n", epnum, tx_csr);
 		goto finish;
 
@@ -1459,8 +1459,8 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 	/* faults abort the transfer */
 	if (status) {
 		/* clean up dma and collect transfer count */
-		if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
-			dma->status = MGC_DMA_STATUS_CORE_ABORT;
+		if (dma_channel_status(dma) == MUSB_DMA_STATUS_BUSY) {
+			dma->status = MUSB_DMA_STATUS_CORE_ABORT;
 			(void) musb->dma_controller->channel_abort(dma);
 			xfer_len = dma->actual_len;
 		}
@@ -1470,7 +1470,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 		goto finish;
 	}
 
-	if (unlikely(dma_channel_status(dma) == MGC_DMA_STATUS_BUSY)) {
+	if (unlikely(dma_channel_status(dma) == MUSB_DMA_STATUS_BUSY)) {
 		/* SHOULD NEVER HAPPEN ... but at least DaVinci has done it */
 		ERR("RX%d dma busy, csr %04x\n", epnum, rx_csr);
 		goto finish;
@@ -1490,8 +1490,8 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 		 * and also duplicates dma cleanup code above ... plus,
 		 * shouldn't this be the "half full" double buffer case?
 		 */
-		if (dma_channel_status(dma) == MGC_DMA_STATUS_BUSY) {
-			dma->status = MGC_DMA_STATUS_CORE_ABORT;
+		if (dma_channel_status(dma) == MUSB_DMA_STATUS_BUSY) {
+			dma->status = MUSB_DMA_STATUS_CORE_ABORT;
 			(void) musb->dma_controller->channel_abort(dma);
 			xfer_len = dma->actual_len;
 			done = TRUE;
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 3b20667..f3e76bc 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -144,7 +144,7 @@ static struct dma_channel* dma_channel_allocate(struct dma_controller *c,
 			pImplChannel->transmit = transmit;
 			pChannel = &(pImplChannel->Channel);
 			pChannel->private_data = pImplChannel;
-			pChannel->status = MGC_DMA_STATUS_FREE;
+			pChannel->status = MUSB_DMA_STATUS_FREE;
 			pChannel->max_len = 0x10000;
 			/* Tx => mode 1; Rx => mode 0 */
 			pChannel->desired_mode = transmit;
@@ -167,7 +167,7 @@ static void dma_channel_release(struct dma_channel *pChannel)
 	pImplChannel->controller->bmUsedChannels &=
 		~(1 << pImplChannel->bIndex);
 
-	pChannel->status = MGC_DMA_STATUS_UNKNOWN;
+	pChannel->status = MUSB_DMA_STATUS_UNKNOWN;
 }
 
 static void configure_channel(struct dma_channel *pChannel,
@@ -232,14 +232,14 @@ static int dma_channel_program(struct dma_channel * pChannel,
 		pImplChannel->transmit ? "Tx" : "Rx",
 		packet_sz, dma_addr, len, mode);
 
-	BUG_ON(pChannel->status == MGC_DMA_STATUS_UNKNOWN ||
-		pChannel->status == MGC_DMA_STATUS_BUSY);
+	BUG_ON(pChannel->status == MUSB_DMA_STATUS_UNKNOWN ||
+		pChannel->status == MUSB_DMA_STATUS_BUSY);
 
 	pChannel->actual_len = 0;
 	pImplChannel->dwStartAddress = dma_addr;
 	pImplChannel->len = len;
 	pImplChannel->wMaxPacketSize = packet_sz;
-	pChannel->status = MGC_DMA_STATUS_BUSY;
+	pChannel->status = MUSB_DMA_STATUS_BUSY;
 
 	if ((mode == 1) && (len >= packet_sz)) {
 		configure_channel(pChannel, packet_sz, 1, dma_addr,
@@ -259,7 +259,7 @@ static int dma_channel_abort(struct dma_channel *pChannel)
 	u8 *mbase = pImplChannel->controller->pCoreBase;
 	u16 csr;
 
-	if (pChannel->status == MGC_DMA_STATUS_BUSY) {
+	if (pChannel->status == MUSB_DMA_STATUS_BUSY) {
 		if (pImplChannel->transmit) {
 
 			csr = musb_readw(mbase,
@@ -289,7 +289,7 @@ static int dma_channel_abort(struct dma_channel *pChannel)
 		musb_writel(mbase,
 		   MGC_HSDMA_CHANNEL_OFFSET(bChannel, MGC_O_HSDMA_COUNT), 0);
 
-		pChannel->status = MGC_DMA_STATUS_FREE;
+		pChannel->status = MUSB_DMA_STATUS_FREE;
 	}
 	return 0;
 }
@@ -323,7 +323,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 
 			if (csr & (1 << MUSB_HSDMA_BUSERROR_SHIFT)) {
 				pImplChannel->Channel.status =
-				    MGC_DMA_STATUS_BUS_ABORT;
+				    MUSB_DMA_STATUS_BUS_ABORT;
 			} else {
 				dwAddress = musb_readl(mbase,
 						MGC_HSDMA_CHANNEL_OFFSET(
@@ -343,7 +343,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 				u8 devctl = musb_readb(mbase,
 						MUSB_DEVCTL);
 
-				pChannel->status = MGC_DMA_STATUS_FREE;
+				pChannel->status = MUSB_DMA_STATUS_FREE;
 
 				/* completed */
 				if ((devctl & MUSB_DEVCTL_HM)
diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index 3a4db47..c71e123 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -202,7 +202,7 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 	if (!dmareq_works())
 		tusb_omap_free_shared_dmareq(chdat);
 
-	channel->status = MGC_DMA_STATUS_FREE;
+	channel->status = MUSB_DMA_STATUS_FREE;
 
 	/* Handle only RX callbacks here. TX callbacks musb be handled based
 	 * on the TUSB DMA status interrupt.
@@ -296,7 +296,7 @@ static int tusb_omap_dma_program(struct dma_channel *channel, u16 packet_sz,
 	chdat->len = len;
 	channel->actual_len = 0;
 	chdat->dma_addr = (void __iomem *)dma_addr;
-	channel->status = MGC_DMA_STATUS_BUSY;
+	channel->status = MUSB_DMA_STATUS_BUSY;
 
 	/* Since we're recycling dma areas, we need to clean or invalidate */
 	if (chdat->tx) {
@@ -430,7 +430,7 @@ static int tusb_omap_dma_abort(struct dma_channel *channel)
 		tusb_dma->sync_dev = -1;
 	}
 
-	channel->status = MGC_DMA_STATUS_FREE;
+	channel->status = MUSB_DMA_STATUS_FREE;
 
 	return 0;
 }
@@ -521,8 +521,8 @@ tusb_omap_dma_allocate(struct dma_controller *c,
 
 	for (i = 0; i < MAX_DMAREQ; i++) {
 		struct dma_channel *ch = dma_channel_pool[i];
-		if (ch->status == MGC_DMA_STATUS_UNKNOWN) {
-			ch->status = MGC_DMA_STATUS_FREE;
+		if (ch->status == MUSB_DMA_STATUS_UNKNOWN) {
+			ch->status = MUSB_DMA_STATUS_FREE;
 			channel = ch;
 			chdat = ch->private_data;
 			break;
@@ -589,7 +589,7 @@ free_dmareq:
 	tusb_omap_dma_free_dmareq(chdat);
 
 	DBG(3, "ep%i: Could not get a DMA channel\n", chdat->epnum);
-	channel->status = MGC_DMA_STATUS_UNKNOWN;
+	channel->status = MUSB_DMA_STATUS_UNKNOWN;
 
 	return NULL;
 }
@@ -617,7 +617,7 @@ static void tusb_omap_dma_release(struct dma_channel *channel)
 		reg |= (1 << (chdat->epnum + 15));
 	musb_writel(tusb_base, TUSB_DMA_INT_CLEAR, reg);
 
-	channel->status = MGC_DMA_STATUS_UNKNOWN;
+	channel->status = MUSB_DMA_STATUS_UNKNOWN;
 
 	if (chdat->ch >= 0) {
 		omap_stop_dma(chdat->ch);
@@ -702,7 +702,7 @@ dma_controller_create(struct musb *musb, void __iomem *base)
 		if (!chdat)
 			goto cleanup;
 
-		ch->status = MGC_DMA_STATUS_UNKNOWN;
+		ch->status = MUSB_DMA_STATUS_UNKNOWN;
 		ch->private_data = chdat;
 	}
 
-- 
1.5.2.3
