From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/36] musb_hdrc: Search and replace pDmaChannel with
	dma_channel
Date: Thu, 16 Aug 2007 02:40:35 -0700
Message-ID: <11872572872790-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11872572842479-git-send-email-tony@atomide.com>
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

Search and replace pDmaChannel with dma_channel

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c |   54 +++++++++++++++++++++---------------------
 1 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index cc05f70..ea30146 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -628,7 +628,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			u8 * buf, u32 len)
 {
 	struct dma_controller	*dma_controller;
-	struct dma_channel	*pDmaChannel;
+	struct dma_channel	*dma_channel;
 	u8			bDmaOk;
 	void __iomem		*mbase = musb->mregs;
 	struct musb_hw_ep	*hw_ep = musb->endpoints + epnum;
@@ -656,17 +656,17 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 	/* candidate for DMA? */
 	dma_controller = musb->dma_controller;
 	if (is_dma_capable() && epnum && dma_controller) {
-		pDmaChannel = is_out ? hw_ep->tx_channel : hw_ep->rx_channel;
-		if (!pDmaChannel) {
-			pDmaChannel = dma_controller->channel_alloc(
+		dma_channel = is_out ? hw_ep->tx_channel : hw_ep->rx_channel;
+		if (!dma_channel) {
+			dma_channel = dma_controller->channel_alloc(
 					dma_controller, hw_ep, is_out);
 			if (is_out)
-				hw_ep->tx_channel = pDmaChannel;
+				hw_ep->tx_channel = dma_channel;
 			else
-				hw_ep->rx_channel = pDmaChannel;
+				hw_ep->rx_channel = dma_channel;
 		}
 	} else
-		pDmaChannel = NULL;
+		dma_channel = NULL;
 
 	/* make sure we clear DMAEnab, autoSet bits from previous run */
 
@@ -760,7 +760,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			wLoadCount = min((u32) packet_sz, len);
 
 #ifdef CONFIG_USB_INVENTRA_DMA
-		if (pDmaChannel) {
+		if (dma_channel) {
 
 			/* clear previous state */
 			csr = musb_readw(epio, MUSB_TXCSR);
@@ -771,15 +771,15 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			musb_writew(epio, MUSB_TXCSR,
 				csr | MUSB_TXCSR_MODE);
 
-			qh->segsize = min(len, pDmaChannel->max_len);
+			qh->segsize = min(len, dma_channel->max_len);
 
 			if (qh->segsize <= packet_sz)
-				pDmaChannel->desired_mode = 0;
+				dma_channel->desired_mode = 0;
 			else
-				pDmaChannel->desired_mode = 1;
+				dma_channel->desired_mode = 1;
 
 
-			if (pDmaChannel->desired_mode == 0) {
+			if (dma_channel->desired_mode == 0) {
 				csr &= ~(MUSB_TXCSR_AUTOSET
 					| MUSB_TXCSR_DMAMODE);
 				csr |= (MUSB_TXCSR_DMAENAB);
@@ -792,25 +792,25 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			musb_writew(epio, MUSB_TXCSR, csr);
 
 			bDmaOk = dma_controller->channel_program(
-					pDmaChannel, packet_sz,
-					pDmaChannel->desired_mode,
+					dma_channel, packet_sz,
+					dma_channel->desired_mode,
 					urb->transfer_dma,
 					qh->segsize);
 			if (bDmaOk) {
 				wLoadCount = 0;
 			} else {
-				dma_controller->channel_release(pDmaChannel);
+				dma_controller->channel_release(dma_channel);
 				if (is_out)
 					hw_ep->tx_channel = NULL;
 				else
 					hw_ep->rx_channel = NULL;
-				pDmaChannel = NULL;
+				dma_channel = NULL;
 			}
 		}
 #endif
 
 		/* candidate for DMA */
-		if ((is_cppi_enabled() || tusb_dma_omap()) && pDmaChannel) {
+		if ((is_cppi_enabled() || tusb_dma_omap()) && dma_channel) {
 
 			/* program endpoint CSRs first, then setup DMA.
 			 * assume CPPI setup succeeds.
@@ -824,14 +824,14 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			musb_writew(epio, MUSB_TXCSR,
 				csr | MUSB_TXCSR_MODE);
 
-			pDmaChannel->actual_len = 0L;
+			dma_channel->actual_len = 0L;
 			qh->segsize = len;
 
 			/* TX uses "rndis" mode automatically, but needs help
 			 * to identify the zero-length-final-packet case.
 			 */
 			bDmaOk = dma_controller->channel_program(
-					pDmaChannel, packet_sz,
+					dma_channel, packet_sz,
 					(urb->transfer_flags
 							& URB_ZERO_PACKET)
 						== URB_ZERO_PACKET,
@@ -840,8 +840,8 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			if (bDmaOk) {
 				wLoadCount = 0;
 			} else {
-				dma_controller->channel_release(pDmaChannel);
-				pDmaChannel = hw_ep->tx_channel = NULL;
+				dma_controller->channel_release(dma_channel);
+				dma_channel = hw_ep->tx_channel = NULL;
 
 				/* REVISIT there's an error path here that
 				 * needs handling:  can't do dma, but
@@ -901,10 +901,10 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 
 		/* kick things off */
 
-		if ((is_cppi_enabled() || tusb_dma_omap()) && pDmaChannel) {
+		if ((is_cppi_enabled() || tusb_dma_omap()) && dma_channel) {
 			/* candidate for DMA */
-			if (pDmaChannel) {
-				pDmaChannel->actual_len = 0L;
+			if (dma_channel) {
+				dma_channel->actual_len = 0L;
 				qh->segsize = len;
 
 				/* AUTOREQ is in a DMA register */
@@ -916,15 +916,15 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 				 * errors, we dare not queue multiple transfers.
 				 */
 				bDmaOk = dma_controller->channel_program(
-						pDmaChannel, packet_sz,
+						dma_channel, packet_sz,
 						!(urb->transfer_flags
 							& URB_SHORT_NOT_OK),
 						urb->transfer_dma,
 						qh->segsize);
 				if (!bDmaOk) {
 					dma_controller->channel_release(
-							pDmaChannel);
-					pDmaChannel = hw_ep->rx_channel = NULL;
+							dma_channel);
+					dma_channel = hw_ep->rx_channel = NULL;
 				} else
 					csr |= MUSB_RXCSR_DMAENAB;
 			}
-- 
1.5.2.3
