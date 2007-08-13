From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/52] musb_hdrc: Search and replace pEndPt with hw_ep
Date: Mon, 13 Aug 2007 06:48:37 -0700
Message-ID: <11870129721700-git-send-email-tony@atomide.com>
References: musb <11870129672745-git-send-email-tony@atomide.com>
	<11870129702817-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11870129702817-git-send-email-tony@atomide.com>
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

Search and replace pEndPt with hw_ep

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/cppi_dma.c |   26 +++++++++++++-------------
 drivers/usb/musb/cppi_dma.h |    2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -318,10 +318,10 @@ cppi_channel_allocate(struct dma_controller *c,
 	/* REVISIT make this an error later once the same driver code works
 	 * with the Mentor DMA engine too
 	 */
-	if (otgCh->pEndPt)
+	if (otgCh->hw_ep)
 		DBG(1, "re-allocating DMA%d %cX channel %p\n",
 				chNum, bTransmit ? 'T' : 'R', otgCh);
-	otgCh->pEndPt = ep;
+	otgCh->hw_ep = ep;
 	otgCh->Channel.bStatus = MGC_DMA_STATUS_FREE;
 
 	DBG(4, "Allocate CPPI%d %cX\n", chNum, bTransmit ? 'T' : 'R');
@@ -341,13 +341,13 @@ static void cppi_channel_release(struct dma_channel *channel)
 	c = container_of(channel, struct cppi_channel, Channel);
 	epnum = c->chNo + 1;
 	tibase = c->pController->pCoreBase - DAVINCI_BASE_OFFSET;
-	if (!c->pEndPt)
+	if (!c->hw_ep)
 		DBG(1, "releasing idle DMA channel %p\n", c);
 	else if (!c->bTransmit)
 		core_rxirq_enable(tibase, epnum);
 
 	/* for now, leave its cppi IRQ enabled (we won't trigger it) */
-	c->pEndPt = NULL;
+	c->hw_ep = NULL;
 	channel->bStatus = MGC_DMA_STATUS_UNKNOWN;
 }
 
@@ -366,7 +366,7 @@ cppi_dump_rx(int level, struct cppi_channel *c, const char *tag)
 		c->chNo, tag,
 		musb_readl(base - DAVINCI_BASE_OFFSET,
 			DAVINCI_RXCPPI_BUFCNT0_REG + 4 *c->chNo),
-		musb_readw(c->pEndPt->regs, MGC_O_HDRC_RXCSR),
+		musb_readw(c->hw_ep->regs, MGC_O_HDRC_RXCSR),
 
 		musb_readl(c->stateRam, 0 * 4),	/* buf offset */
 		musb_readl(c->stateRam, 1 * 4),	/* head ptr */
@@ -393,7 +393,7 @@ cppi_dump_tx(int level, struct cppi_channel *c, const char *tag)
 			"F%08x L%08x .. %08x"
 			"\n",
 		c->chNo, tag,
-		musb_readw(c->pEndPt->regs, MGC_O_HDRC_TXCSR),
+		musb_readw(c->hw_ep->regs, MGC_O_HDRC_TXCSR),
 
 		musb_readl(c->stateRam, 0 * 4),	/* head ptr */
 		musb_readl(c->stateRam, 1 * 4),	/* sop bd */
@@ -498,7 +498,7 @@ static inline int cppi_autoreq_update(struct cppi_channel *rx,
 
 	/* REQPKT is turned off after each segment */
 	if (n_bds && rx->actualLen) {
-		void		*__iomem regs = rx->pEndPt->regs;
+		void		*__iomem regs = rx->hw_ep->regs;
 
 		val = musb_readw(regs, MGC_O_HDRC_RXCSR);
 		if (!(val & MGC_M_RXCSR_H_REQPKT)) {
@@ -1008,7 +1008,7 @@ static int cppi_rx_scan(struct cppi *cppi, unsigned ch)
 	int				completed = 0, acked = 0;
 	int				i;
 	dma_addr_t			safe2ack;
-	void				*__iomem regs = rx->pEndPt->regs;
+	void				*__iomem regs = rx->hw_ep->regs;
 
 	cppi_dump_rx(6, rx, "/K");
 
@@ -1116,14 +1116,14 @@ static int cppi_rx_scan(struct cppi *cppi, unsigned ch)
 		/* REVISIT seems like "autoreq all but EOP" doesn't...
 		 * setting it here "should" be racey, but seems to work
 		 */
-		csr = musb_readw(rx->pEndPt->regs, MGC_O_HDRC_RXCSR);
+		csr = musb_readw(rx->hw_ep->regs, MGC_O_HDRC_RXCSR);
 		if (is_host_active(cppi->musb)
 				&& bd
 				&& !(csr & MGC_M_RXCSR_H_REQPKT)) {
 			csr |= MGC_M_RXCSR_H_REQPKT;
 			musb_writew(regs, MGC_O_HDRC_RXCSR,
 					MGC_M_RXCSR_H_WZC_BITS | csr);
-			csr = musb_readw(rx->pEndPt->regs, MGC_O_HDRC_RXCSR);
+			csr = musb_readw(rx->hw_ep->regs, MGC_O_HDRC_RXCSR);
 		}
 	} else {
 		rx->activeQueueHead = NULL;
@@ -1227,7 +1227,7 @@ void cppi_completion(struct musb *musb, u32 rx, u32 tx)
 					txChannel->Channel.bStatus =
 							MGC_DMA_STATUS_FREE;
 
-					pEnd = txChannel->pEndPt;
+					pEnd = txChannel->hw_ep;
 
 					txChannel->Channel.dwActualLength =
 						txChannel->actualLen;
@@ -1290,7 +1290,7 @@ void cppi_completion(struct musb *musb, u32 rx, u32 tx)
 			/* all segments completed! */
 			rxChannel->Channel.bStatus = MGC_DMA_STATUS_FREE;
 
-			pEnd = rxChannel->pEndPt;
+			pEnd = rxChannel->hw_ep;
 
 			rxChannel->Channel.dwActualLength =
 					rxChannel->actualLen;
@@ -1381,7 +1381,7 @@ static int cppi_channel_abort(struct dma_channel *channel)
 		/* from RX or TX fault irq handler */
 	case MGC_DMA_STATUS_BUSY:
 		/* the hardware needs shutting down */
-		regs = otgCh->pEndPt->regs;
+		regs = otgCh->hw_ep->regs;
 		break;
 	case MGC_DMA_STATUS_UNKNOWN:
 	case MGC_DMA_STATUS_FREE:
--- a/drivers/usb/musb/cppi_dma.h
+++ b/drivers/usb/musb/cppi_dma.h
@@ -65,7 +65,7 @@ struct cppi_channel {
 	struct cppi		*pController;
 
 	/* which direction of which endpoint? */
-	struct musb_hw_ep	*pEndPt;
+	struct musb_hw_ep	*hw_ep;
 	u8			bTransmit;
 	u8			chNo;
 
-- 
1.5.2.3
