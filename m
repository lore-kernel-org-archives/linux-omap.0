From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 38/52] musb_hdrc: Search and replace dwMaxLength with max_len
Date: Mon, 13 Aug 2007 06:49:13 -0700
Message-ID: <1187013072449-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11870130701028-git-send-email-tony@atomide.com>
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

Search and replace dwMaxLength with max_len

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/dma.h           |    4 ++--
 drivers/usb/musb/musb_gadget.c   |    4 ++--
 drivers/usb/musb/musb_host.c     |    2 +-
 drivers/usb/musb/musbhsdma.c     |    2 +-
 drivers/usb/musb/tusb6010_omap.c |    2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/usb/musb/dma.h
+++ b/drivers/usb/musb/dma.h
@@ -113,7 +113,7 @@ struct dma_controller;
 struct dma_channel {
 	void			*private_data;
 	// FIXME not void* private_data, but a dma_controller *
-	size_t			dwMaxLength;
+	size_t			max_len;
 	size_t			dwActualLength;
 	enum dma_channel_status	bStatus;
 	u8			bDesiredMode;
@@ -129,7 +129,7 @@ struct dma_channel {
  * @bMode: TRUE if mode 1; FALSE if mode 0
  * @dma_addr: base address of data (in DMA space)
  * @length: the number of bytes to transfer; no larger than the channel's
- *	reported dwMaxLength
+ *	reported max_len
  *
  * Returns TRUE on success, else FALSE
  */
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -304,7 +304,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 
 			/* setup DMA, then program endpoint CSR */
 			request_size = min(pRequest->length,
-						musb_ep->dma->dwMaxLength);
+						musb_ep->dma->max_len);
 			if (request_size <= musb_ep->wPacketSize)
 				musb_ep->dma->bDesiredMode = 0;
 			else
@@ -661,7 +661,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 					int transfer_size = 0;
 #ifdef USE_MODE1
 					transfer_size = min(pRequest->length,
-							channel->dwMaxLength);
+							channel->max_len);
 #else
 					transfer_size = len;
 #endif
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -771,7 +771,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			musb_writew(epio, MGC_O_HDRC_TXCSR,
 				wCsr | MGC_M_TXCSR_MODE);
 
-			qh->segsize = min(dwLength, pDmaChannel->dwMaxLength);
+			qh->segsize = min(dwLength, pDmaChannel->max_len);
 
 			if (qh->segsize <= wPacketSize)
 				pDmaChannel->bDesiredMode = 0;
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -145,7 +145,7 @@ static struct dma_channel* dma_channel_allocate(struct dma_controller *c,
 			pChannel = &(pImplChannel->Channel);
 			pChannel->private_data = pImplChannel;
 			pChannel->bStatus = MGC_DMA_STATUS_FREE;
-			pChannel->dwMaxLength = 0x10000;
+			pChannel->max_len = 0x10000;
 			/* Tx => mode 1; Rx => mode 0 */
 			pChannel->bDesiredMode = bTransmit;
 			pChannel->dwActualLength = 0;
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -548,7 +548,7 @@ tusb_omap_dma_allocate(struct dma_controller *c,
 	chdat->completed_len = 0;
 	chdat->tusb_dma = tusb_dma;
 
-	channel->dwMaxLength = 0x7fffffff;
+	channel->max_len = 0x7fffffff;
 	channel->bDesiredMode = 0;
 	channel->dwActualLength = 0;
 
-- 
1.5.2.3
