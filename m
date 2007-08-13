From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 41/52] musb_hdrc: Search and replace bDesiredMode with
	desired_mode
Date: Mon, 13 Aug 2007 06:49:16 -0700
Message-ID: <11870130793168-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11870130771666-git-send-email-tony@atomide.com>
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

Search and replace bDesiredMode with desired_mode

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/dma.h           |    4 ++--
 drivers/usb/musb/musb_gadget.c   |   20 ++++++++++----------
 drivers/usb/musb/musb_host.c     |   18 +++++++++---------
 drivers/usb/musb/musbhsdma.c     |    4 ++--
 drivers/usb/musb/tusb6010_omap.c |    2 +-
 5 files changed, 24 insertions(+), 24 deletions(-)

--- a/drivers/usb/musb/dma.h
+++ b/drivers/usb/musb/dma.h
@@ -105,7 +105,7 @@ struct dma_controller;
  *	transaction (typically representing many USB maximum-sized packets)
  * @actual_len: how many bytes have been transferred
  * @status: current channel status (updated e.g. on interrupt)
- * @bDesiredMode: TRUE if mode 1 is desired; FALSE if mode 0 is desired
+ * @desired_mode: TRUE if mode 1 is desired; FALSE if mode 0 is desired
  *
  * channels are associated with an endpoint for the duration of at least
  * one usb transfer.
@@ -116,7 +116,7 @@ struct dma_channel {
 	size_t			max_len;
 	size_t			actual_len;
 	enum dma_channel_status	status;
-	u8			bDesiredMode;
+	u8			desired_mode;
 };
 
 /*
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -306,16 +306,16 @@ static void txstate(struct musb *musb, struct musb_request *req)
 			request_size = min(pRequest->length,
 						musb_ep->dma->max_len);
 			if (request_size <= musb_ep->wPacketSize)
-				musb_ep->dma->bDesiredMode = 0;
+				musb_ep->dma->desired_mode = 0;
 			else
-				musb_ep->dma->bDesiredMode = 1;
+				musb_ep->dma->desired_mode = 1;
 
 			use_dma = use_dma && c->channel_program(
 					musb_ep->dma, musb_ep->wPacketSize,
-					musb_ep->dma->bDesiredMode,
+					musb_ep->dma->desired_mode,
 					pRequest->dma, request_size);
 			if (use_dma) {
-				if (musb_ep->dma->bDesiredMode == 0) {
+				if (musb_ep->dma->desired_mode == 0) {
 					/* ASSERT: DMAENAB is clear */
 					wCsrVal &= ~(MGC_M_TXCSR_AUTOSET |
 							MGC_M_TXCSR_DMAMODE);
@@ -487,7 +487,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 							== 0)
 #ifdef CONFIG_USB_INVENTRA_DMA
 					|| (is_dma &&
-						((!dma->bDesiredMode) ||
+						((!dma->desired_mode) ||
 						    (pRequest->actual &
 						    (musb_ep->wPacketSize - 1))))
 #endif
@@ -666,14 +666,14 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 					transfer_size = len;
 #endif
 					if (transfer_size <= musb_ep->wPacketSize)
-						musb_ep->dma->bDesiredMode = 0;
+						musb_ep->dma->desired_mode = 0;
 					else
-						musb_ep->dma->bDesiredMode = 1;
+						musb_ep->dma->desired_mode = 1;
 
 					use_dma = c->channel_program(
 							channel,
 							musb_ep->wPacketSize,
-							channel->bDesiredMode,
+							channel->desired_mode,
 							pRequest->dma
 							+ pRequest->actual,
 							transfer_size);
@@ -701,7 +701,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 
 				ret = c->channel_program(channel,
 						musb_ep->wPacketSize,
-						channel->bDesiredMode,
+						channel->desired_mode,
 						dma_addr,
 						fifo_count);
 				if (ret == TRUE)
@@ -805,7 +805,7 @@ void musb_g_rx(struct musb *musb, u8 epnum)
 
 #if defined(CONFIG_USB_INVENTRA_DMA) || defined(CONFIG_USB_TUSB_OMAP_DMA)
 		/* Autoclear doesn't clear RxPktRdy for short packets */
-		if ((dma->bDesiredMode == 0)
+		if ((dma->desired_mode == 0)
 				|| (dma->actual_len
 					& (musb_ep->wPacketSize - 1))) {
 			/* ack the read! */
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -774,12 +774,12 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			qh->segsize = min(dwLength, pDmaChannel->max_len);
 
 			if (qh->segsize <= wPacketSize)
-				pDmaChannel->bDesiredMode = 0;
+				pDmaChannel->desired_mode = 0;
 			else
-				pDmaChannel->bDesiredMode = 1;
+				pDmaChannel->desired_mode = 1;
 
 
-			if (pDmaChannel->bDesiredMode == 0) {
+			if (pDmaChannel->desired_mode == 0) {
 				wCsr &= ~(MGC_M_TXCSR_AUTOSET
 					| MGC_M_TXCSR_DMAMODE);
 				wCsr |= (MGC_M_TXCSR_DMAENAB);
@@ -793,7 +793,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 
 			bDmaOk = dma_controller->channel_program(
 					pDmaChannel, wPacketSize,
-					pDmaChannel->bDesiredMode,
+					pDmaChannel->desired_mode,
 					pUrb->transfer_dma,
 					qh->segsize);
 			if (bDmaOk) {
@@ -1569,7 +1569,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 
 			c = musb->dma_controller;
 
-			dma->bDesiredMode = 0;
+			dma->desired_mode = 0;
 #ifdef USE_MODE1
 			/* because of the issue below, mode 1 will
 			 * only rarely behave with correct semantics.
@@ -1579,7 +1579,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 				&& (pUrb->transfer_buffer_length -
 						pUrb->actual_length)
 					> qh->maxpacket)
-				dma->bDesiredMode = 1;
+				dma->desired_mode = 1;
 #endif
 
 /* Disadvantage of using mode 1:
@@ -1602,7 +1602,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 			wVal = musb_readw(epio, MGC_O_HDRC_RXCSR);
 			wVal &= ~MGC_M_RXCSR_H_REQPKT;
 
-			if (dma->bDesiredMode == 0)
+			if (dma->desired_mode == 0)
 				wVal &= ~MGC_M_RXCSR_H_AUTOREQ;
 			else
 				wVal |= MGC_M_RXCSR_H_AUTOREQ;
@@ -1617,10 +1617,10 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 			 */
 			status = c->channel_program(
 				dma, qh->maxpacket,
-				dma->bDesiredMode,
+				dma->desired_mode,
 				pUrb->transfer_dma
 					+ pUrb->actual_length,
-				(dma->bDesiredMode == 0)
+				(dma->desired_mode == 0)
 					? wRxCount
 					: pUrb->transfer_buffer_length);
 
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -147,7 +147,7 @@ static struct dma_channel* dma_channel_allocate(struct dma_controller *c,
 			pChannel->status = MGC_DMA_STATUS_FREE;
 			pChannel->max_len = 0x10000;
 			/* Tx => mode 1; Rx => mode 0 */
-			pChannel->bDesiredMode = bTransmit;
+			pChannel->desired_mode = bTransmit;
 			pChannel->actual_len = 0;
 			break;
 		}
@@ -348,7 +348,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 				/* completed */
 				if ((devctl & MGC_M_DEVCTL_HM)
 				    && (pImplChannel->bTransmit)
-				    && ((pChannel->bDesiredMode == 0)
+				    && ((pChannel->desired_mode == 0)
 					|| (pChannel->actual_len &
 					    (pImplChannel->wMaxPacketSize - 1)))
 				   ) {
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -549,7 +549,7 @@ tusb_omap_dma_allocate(struct dma_controller *c,
 	chdat->tusb_dma = tusb_dma;
 
 	channel->max_len = 0x7fffffff;
-	channel->bDesiredMode = 0;
+	channel->desired_mode = 0;
 	channel->actual_len = 0;
 
 	if (dmareq_works()) {
-- 
1.5.2.3
