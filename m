From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/36] musb_hdrc: Search and replace bTransmit with transmit
Date: Thu, 16 Aug 2007 02:40:30 -0700
Message-ID: <11872572762670-git-send-email-tony@atomide.com>
References: <11872572591844-git-send-email-tony@atomide.com>
	<11872572612810-git-send-email-tony@atomide.com>
	<11872572643880-git-send-email-tony@atomide.com>
	<11872572672740-git-send-email-tony@atomide.com>
	<11872572693807-git-send-email-tony@atomide.com>
	<11872572713057-git-send-email-tony@atomide.com>
	<11872572743878-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11872572743878-git-send-email-tony@atomide.com>
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

Search and replace bTransmit with transmit

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/cppi_dma.c  |   26 +++++++++++++-------------
 drivers/usb/musb/cppi_dma.h  |    2 +-
 drivers/usb/musb/dma.h       |    2 +-
 drivers/usb/musb/musbhsdma.c |   18 +++++++++---------
 drivers/usb/musb/plat_uds.c  |    4 ++--
 5 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/musb/cppi_dma.c b/drivers/usb/musb/cppi_dma.c
index d902eaa..1441dc7 100644
--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -147,11 +147,11 @@ static int __init cppi_controller_start(struct dma_controller *c)
 
 	/* do whatever is necessary to start controller */
 	for (i = 0; i < ARRAY_SIZE(pController->txCppi); i++) {
-		pController->txCppi[i].bTransmit = TRUE;
+		pController->txCppi[i].transmit = TRUE;
 		pController->txCppi[i].chNo = i;
 	}
 	for (i = 0; i < ARRAY_SIZE(pController->rxCppi); i++) {
-		pController->rxCppi[i].bTransmit = FALSE;
+		pController->rxCppi[i].transmit = FALSE;
 		pController->rxCppi[i].chNo = i;
 	}
 
@@ -283,7 +283,7 @@ static inline void core_rxirq_enable(void __iomem *tibase, unsigned epnum)
 static struct dma_channel *
 cppi_channel_allocate(struct dma_controller *c,
 		struct musb_hw_ep *ep,
-		u8 bTransmit)
+		u8 transmit)
 {
 	struct cppi		*pController;
 	u8			chNum;
@@ -300,7 +300,7 @@ cppi_channel_allocate(struct dma_controller *c,
 	/* return the corresponding CPPI Channel Handle, and
 	 * probably disable the non-CPPI irq until we need it.
 	 */
-	if (bTransmit) {
+	if (transmit) {
 		if (local_end > ARRAY_SIZE(pController->txCppi)) {
 			DBG(1, "no %cX DMA channel for ep%d\n", 'T', local_end);
 			return NULL;
@@ -320,11 +320,11 @@ cppi_channel_allocate(struct dma_controller *c,
 	 */
 	if (otgCh->hw_ep)
 		DBG(1, "re-allocating DMA%d %cX channel %p\n",
-				chNum, bTransmit ? 'T' : 'R', otgCh);
+				chNum, transmit ? 'T' : 'R', otgCh);
 	otgCh->hw_ep = ep;
 	otgCh->Channel.status = MGC_DMA_STATUS_FREE;
 
-	DBG(4, "Allocate CPPI%d %cX\n", chNum, bTransmit ? 'T' : 'R');
+	DBG(4, "Allocate CPPI%d %cX\n", chNum, transmit ? 'T' : 'R');
 	otgCh->Channel.private_data = otgCh;
 	return &otgCh->Channel;
 }
@@ -343,7 +343,7 @@ static void cppi_channel_release(struct dma_channel *channel)
 	tibase = c->pController->pCoreBase - DAVINCI_BASE_OFFSET;
 	if (!c->hw_ep)
 		DBG(1, "releasing idle DMA channel %p\n", c);
-	else if (!c->bTransmit)
+	else if (!c->transmit)
 		core_rxirq_enable(tibase, epnum);
 
 	/* for now, leave its cppi IRQ enabled (we won't trigger it) */
@@ -962,19 +962,19 @@ static int cppi_channel_program(struct dma_channel *pChannel,
 	case MGC_DMA_STATUS_CORE_ABORT:
 		/* fault irq handler should have handled cleanup */
 		WARN("%cX DMA%d not cleaned up after abort!\n",
-				otgChannel->bTransmit ? 'T' : 'R',
+				otgChannel->transmit ? 'T' : 'R',
 				otgChannel->chNo);
 		//WARN_ON(1);
 		break;
 	case MGC_DMA_STATUS_BUSY:
 		WARN("program active channel?  %cX DMA%d\n",
-				otgChannel->bTransmit ? 'T' : 'R',
+				otgChannel->transmit ? 'T' : 'R',
 				otgChannel->chNo);
 		//WARN_ON(1);
 		break;
 	case MGC_DMA_STATUS_UNKNOWN:
 		DBG(1, "%cX DMA%d not allocated!\n",
-				otgChannel->bTransmit ? 'T' : 'R',
+				otgChannel->transmit ? 'T' : 'R',
 				otgChannel->chNo);
 		/* FALLTHROUGH */
 	case MGC_DMA_STATUS_FREE:
@@ -991,7 +991,7 @@ static int cppi_channel_program(struct dma_channel *pChannel,
 	otgChannel->transferSize = dwLength;
 
 	/* TX channel? or RX? */
-	if (otgChannel->bTransmit)
+	if (otgChannel->transmit)
 		cppi_next_tx_segment(musb, otgChannel);
 	else
 		cppi_next_rx_segment(musb, otgChannel, mode);
@@ -1390,7 +1390,7 @@ static int cppi_channel_abort(struct dma_channel *channel)
 		return -EINVAL;
 	}
 
-	if (!otgCh->bTransmit && otgCh->activeQueueHead)
+	if (!otgCh->transmit && otgCh->activeQueueHead)
 		cppi_dump_rxq(3, "/abort", otgCh);
 
 	mbase = pController->pCoreBase;
@@ -1406,7 +1406,7 @@ static int cppi_channel_abort(struct dma_channel *channel)
 	 */
 	musb_ep_select(mbase, chNum + 1);
 
-	if (otgCh->bTransmit) {
+	if (otgCh->transmit) {
 		struct cppi_tx_stateram	*__iomem txState;
 		int			enabled;
 
diff --git a/drivers/usb/musb/cppi_dma.h b/drivers/usb/musb/cppi_dma.h
index bfcc992..66a46ea 100644
--- a/drivers/usb/musb/cppi_dma.h
+++ b/drivers/usb/musb/cppi_dma.h
@@ -66,7 +66,7 @@ struct cppi_channel {
 
 	/* which direction of which endpoint? */
 	struct musb_hw_ep	*hw_ep;
-	u8			bTransmit;
+	u8			transmit;
 	u8			chNo;
 
 	/* DMA modes:  RNDIS or "transparent" */
diff --git a/drivers/usb/musb/dma.h b/drivers/usb/musb/dma.h
index 6985340..0054c93 100644
--- a/drivers/usb/musb/dma.h
+++ b/drivers/usb/musb/dma.h
@@ -181,7 +181,7 @@ struct dma_controller {
 };
 
 /* called after channel_program(), may indicate a fault */
-extern void musb_dma_completion(struct musb *musb, u8 epnum, u8 bTransmit);
+extern void musb_dma_completion(struct musb *musb, u8 epnum, u8 transmit);
 
 
 extern struct dma_controller *__init
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index 081ca82..98b5b2e 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -79,7 +79,7 @@ struct musb_dma_channel {
 	u16				wMaxPacketSize;
 	u8				bIndex;
 	u8				epnum;
-	u8				bTransmit;
+	u8				transmit;
 };
 
 struct musb_dma_controller {
@@ -126,7 +126,7 @@ static int dma_controller_stop(struct dma_controller *c)
 }
 
 static struct dma_channel* dma_channel_allocate(struct dma_controller *c,
-				struct musb_hw_ep *hw_ep, u8 bTransmit)
+				struct musb_hw_ep *hw_ep, u8 transmit)
 {
 	u8 bBit;
 	struct dma_channel *pChannel = NULL;
@@ -141,13 +141,13 @@ static struct dma_channel* dma_channel_allocate(struct dma_controller *c,
 			pImplChannel->pController = pController;
 			pImplChannel->bIndex = bBit;
 			pImplChannel->epnum = hw_ep->epnum;
-			pImplChannel->bTransmit = bTransmit;
+			pImplChannel->transmit = transmit;
 			pChannel = &(pImplChannel->Channel);
 			pChannel->private_data = pImplChannel;
 			pChannel->status = MGC_DMA_STATUS_FREE;
 			pChannel->max_len = 0x10000;
 			/* Tx => mode 1; Rx => mode 0 */
-			pChannel->desired_mode = bTransmit;
+			pChannel->desired_mode = transmit;
 			pChannel->actual_len = 0;
 			break;
 		}
@@ -204,7 +204,7 @@ static void configure_channel(struct dma_channel *pChannel,
 	csr |= (pImplChannel->epnum << MUSB_HSDMA_ENDPOINT_SHIFT)
 		| (1 << MUSB_HSDMA_ENABLE_SHIFT)
 		| (1 << MUSB_HSDMA_IRQENABLE_SHIFT)
-		| (pImplChannel->bTransmit ? (1 << MUSB_HSDMA_TRANSMIT_SHIFT) : 0);
+		| (pImplChannel->transmit ? (1 << MUSB_HSDMA_TRANSMIT_SHIFT) : 0);
 
 	/* address/count */
 	musb_writel(mbase,
@@ -229,7 +229,7 @@ static int dma_channel_program(struct dma_channel * pChannel,
 
 	DBG(2, "ep%d-%s pkt_sz %d, dma_addr 0x%x length %d, mode %d\n",
 		pImplChannel->epnum,
-		pImplChannel->bTransmit ? "Tx" : "Rx",
+		pImplChannel->transmit ? "Tx" : "Rx",
 		packet_sz, dma_addr, dwLength, mode);
 
 	BUG_ON(pChannel->status == MGC_DMA_STATUS_UNKNOWN ||
@@ -260,7 +260,7 @@ static int dma_channel_abort(struct dma_channel *pChannel)
 	u16 csr;
 
 	if (pChannel->status == MGC_DMA_STATUS_BUSY) {
-		if (pImplChannel->bTransmit) {
+		if (pImplChannel->transmit) {
 
 			csr = musb_readw(mbase,
 				MGC_END_OFFSET(pImplChannel->epnum,MUSB_TXCSR));
@@ -347,7 +347,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 
 				/* completed */
 				if ((devctl & MUSB_DEVCTL_HM)
-				    && (pImplChannel->bTransmit)
+				    && (pImplChannel->transmit)
 				    && ((pChannel->desired_mode == 0)
 					|| (pChannel->actual_len &
 					    (pImplChannel->wMaxPacketSize - 1)))
@@ -362,7 +362,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 					musb_dma_completion(
 						pController->pDmaPrivate,
 						pImplChannel->epnum,
-						pImplChannel->bTransmit);
+						pImplChannel->transmit);
 			}
 		}
 	}
diff --git a/drivers/usb/musb/plat_uds.c b/drivers/usb/musb/plat_uds.c
index 73a72c9..946ddbf 100644
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -1539,7 +1539,7 @@ static int __initdata use_dma = 1;
 module_param(use_dma, bool, 0);
 MODULE_PARM_DESC(use_dma, "enable/disable use of DMA");
 
-void musb_dma_completion(struct musb *musb, u8 epnum, u8 bTransmit)
+void musb_dma_completion(struct musb *musb, u8 epnum, u8 transmit)
 {
 	u8	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
 
@@ -1557,7 +1557,7 @@ void musb_dma_completion(struct musb *musb, u8 epnum, u8 bTransmit)
 #endif
 	} else {
 		/* endpoints 1..15 */
-		if (bTransmit) {
+		if (transmit) {
 			if (devctl & MUSB_DEVCTL_HM) {
 				if (is_host_capable())
 					musb_host_tx(musb, epnum);
-- 
1.5.2.3
