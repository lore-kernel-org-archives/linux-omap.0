From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 9/52] musb_hdrc: Search and replace dwCount with len
Date: Mon, 13 Aug 2007 06:48:44 -0700
Message-ID: <11870129901657-git-send-email-tony@atomide.com>
References: musb <11870129672745-git-send-email-tony@atomide.com>
	<11870129702817-git-send-email-tony@atomide.com>
	<11870129721700-git-send-email-tony@atomide.com>
	<1187012975431-git-send-email-tony@atomide.com>
	<11870129782148-git-send-email-tony@atomide.com>
	<1187012980445-git-send-email-tony@atomide.com>
	<11870129834092-git-send-email-tony@atomide.com>
	<11870129861917-git-send-email-tony@atomide.com>
	<118701298833-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <118701298833-git-send-email-tony@atomide.com>
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

Search and replace dwCount with len

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musbhsdma.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -75,7 +75,7 @@ struct musb_dma_channel {
 	struct dma_channel		Channel;
 	struct musb_dma_controller	*pController;
 	u32				dwStartAddress;
-	u32				dwCount;
+	u32				len;
 	u16				wMaxPacketSize;
 	u8				bIndex;
 	u8				bEnd;
@@ -162,7 +162,7 @@ static void dma_channel_release(struct dma_channel *pChannel)
 
 	pChannel->dwActualLength = 0;
 	pImplChannel->dwStartAddress = 0;
-	pImplChannel->dwCount = 0;
+	pImplChannel->len = 0;
 
 	pImplChannel->pController->bmUsedChannels &=
 		~(1 << pImplChannel->bIndex);
@@ -237,7 +237,7 @@ static int dma_channel_program(struct dma_channel * pChannel,
 
 	pChannel->dwActualLength = 0;
 	pImplChannel->dwStartAddress = dma_addr;
-	pImplChannel->dwCount = dwLength;
+	pImplChannel->len = dwLength;
 	pImplChannel->wMaxPacketSize = wPacketSize;
 	pChannel->bStatus = MGC_DMA_STATUS_BUSY;
 
@@ -335,9 +335,9 @@ static irqreturn_t dma_controller_irq(int irq, void *pPrivateData)
 				DBG(2, "ch %p, 0x%x -> 0x%x (%d / %d) %s\n",
 				    pChannel, pImplChannel->dwStartAddress,
 				    dwAddress, pChannel->dwActualLength,
-				    pImplChannel->dwCount,
+				    pImplChannel->len,
 				    (pChannel->dwActualLength <
-					pImplChannel->dwCount) ?
+					pImplChannel->len) ?
 					"=> reconfig 0": "=> complete");
 
 				u8 devctl = musb_readb(mbase,
-- 
1.5.2.3
