From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 42/52] musb_hdrc: Search and replace bMode with mode
Date: Mon, 13 Aug 2007 06:49:17 -0700
Message-ID: <11870130811602-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11870130793168-git-send-email-tony@atomide.com>
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

Search and replace bMode with mode

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/dma.h       |    4 ++--
 drivers/usb/musb/musbhsdma.c |   12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/usb/musb/dma.h
+++ b/drivers/usb/musb/dma.h
@@ -126,7 +126,7 @@ struct dma_channel {
  *
  * @channel: pointer to a channel obtained by channel_alloc
  * @maxpacket: the maximum packet size
- * @bMode: TRUE if mode 1; FALSE if mode 0
+ * @mode: TRUE if mode 1; FALSE if mode 0
  * @dma_addr: base address of data (in DMA space)
  * @length: the number of bytes to transfer; no larger than the channel's
  *	reported max_len
@@ -136,7 +136,7 @@ struct dma_channel {
 typedef int (*MGC_pfDmaProgramChannel) (
 		struct dma_channel	*channel,
 		u16			maxpacket,
-		u8			bMode,
+		u8			mode,
 		dma_addr_t		dma_addr,
 		u32			length);
 
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -171,7 +171,7 @@ static void dma_channel_release(struct dma_channel *pChannel)
 }
 
 static void configure_channel(struct dma_channel *pChannel,
-				u16 wPacketSize, u8 bMode,
+				u16 wPacketSize, u8 mode,
 				dma_addr_t dma_addr, u32 dwLength)
 {
 	struct musb_dma_channel *pImplChannel =
@@ -182,9 +182,9 @@ static void configure_channel(struct dma_channel *pChannel,
 	u16 wCsr = 0;
 
 	DBG(4, "%p, pkt_sz %d, addr 0x%x, len %d, mode %d\n",
-	    pChannel, wPacketSize, dma_addr, dwLength, bMode);
+	    pChannel, wPacketSize, dma_addr, dwLength, mode);
 
-	if (bMode) {
+	if (mode) {
 		wCsr |= 1 << MGC_S_HSDMA_MODE1;
 		if (dwLength < wPacketSize) {
 			return FALSE;
@@ -221,7 +221,7 @@ static void configure_channel(struct dma_channel *pChannel,
 }
 
 static int dma_channel_program(struct dma_channel * pChannel,
-				u16 wPacketSize, u8 bMode,
+				u16 wPacketSize, u8 mode,
 				dma_addr_t dma_addr, u32 dwLength)
 {
 	struct musb_dma_channel *pImplChannel =
@@ -230,7 +230,7 @@ static int dma_channel_program(struct dma_channel * pChannel,
 	DBG(2, "ep%d-%s pkt_sz %d, dma_addr 0x%x length %d, mode %d\n",
 		pImplChannel->epnum,
 		pImplChannel->bTransmit ? "Tx" : "Rx",
-		wPacketSize, dma_addr, dwLength, bMode);
+		wPacketSize, dma_addr, dwLength, mode);
 
 	BUG_ON(pChannel->status == MGC_DMA_STATUS_UNKNOWN ||
 		pChannel->status == MGC_DMA_STATUS_BUSY);
@@ -241,7 +241,7 @@ static int dma_channel_program(struct dma_channel * pChannel,
 	pImplChannel->wMaxPacketSize = wPacketSize;
 	pChannel->status = MGC_DMA_STATUS_BUSY;
 
-	if ((bMode == 1) && (dwLength >= wPacketSize)) {
+	if ((mode == 1) && (dwLength >= wPacketSize)) {
 		configure_channel(pChannel, wPacketSize, 1, dma_addr,
 				  dwLength);
 	} else
-- 
1.5.2.3
