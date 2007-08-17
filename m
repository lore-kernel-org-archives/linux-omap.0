From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/7] musb_hdrc: Search and replace MGC_HSDMA with MUSB_HSDMA
Date: Fri, 17 Aug 2007 04:44:41 -0700
Message-ID: <11873510931624-git-send-email-tony@atomide.com>
References: <118735108469-git-send-email-tony@atomide.com>
	<11873510862981-git-send-email-tony@atomide.com>
	<11873510882998-git-send-email-tony@atomide.com>
	<11873510911954-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11873510911954-git-send-email-tony@atomide.com>
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

Search and replace MGC_HSDMA with MUSB_HSDMA

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musbhsdma.c |   44 +++++++++++++++++++++---------------------
 1 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index eb3d27d..515b914 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -50,7 +50,7 @@
 #define MUSB_HSDMA_ADDRESS		0x8
 #define MUSB_HSDMA_COUNT		0xc
 
-#define MGC_HSDMA_CHANNEL_OFFSET(_bChannel, _offset)		\
+#define MUSB_HSDMA_CHANNEL_OFFSET(_bChannel, _offset)		\
 		(MUSB_HSDMA_BASE + (_bChannel << 4) + _offset)
 
 /* control register (16-bit): */
@@ -62,12 +62,12 @@
 #define MUSB_HSDMA_BUSERROR_SHIFT		8
 #define MUSB_HSDMA_BURSTMODE_SHIFT		9
 #define MUSB_HSDMA_BURSTMODE		(3 << MUSB_HSDMA_BURSTMODE_SHIFT)
-#define MGC_HSDMA_BURSTMODE_UNSPEC	0
-#define MGC_HSDMA_BURSTMODE_INCR4	1
-#define MGC_HSDMA_BURSTMODE_INCR8	2
-#define MGC_HSDMA_BURSTMODE_INCR16	3
+#define MUSB_HSDMA_BURSTMODE_UNSPEC	0
+#define MUSB_HSDMA_BURSTMODE_INCR4	1
+#define MUSB_HSDMA_BURSTMODE_INCR8	2
+#define MUSB_HSDMA_BURSTMODE_INCR16	3
 
-#define MGC_HSDMA_CHANNELS		8
+#define MUSB_HSDMA_CHANNELS		8
 
 struct musb_dma_controller;
 
@@ -84,7 +84,7 @@ struct musb_dma_channel {
 
 struct musb_dma_controller {
 	struct dma_controller		Controller;
-	struct musb_dma_channel		aChannel[MGC_HSDMA_CHANNELS];
+	struct musb_dma_channel		aChannel[MUSB_HSDMA_CHANNELS];
 	void 				*pDmaPrivate;
 	void __iomem 			*pCoreBase;
 	u8 				bChannelCount;
@@ -112,7 +112,7 @@ static int dma_controller_stop(struct dma_controller *c)
 		dev_err(musb->controller,
 			"Stopping DMA controller while channel active\n");
 
-		for (bBit = 0; bBit < MGC_HSDMA_CHANNELS; bBit++) {
+		for (bBit = 0; bBit < MUSB_HSDMA_CHANNELS; bBit++) {
 			if (controller->bmUsedChannels & (1 << bBit)) {
 				pChannel = &(controller->aChannel[bBit].Channel);
 				dma_channel_release(pChannel);
@@ -134,7 +134,7 @@ static struct dma_channel* dma_channel_allocate(struct dma_controller *c,
 	struct musb_dma_controller *controller =
 			container_of(c, struct musb_dma_controller, Controller);
 
-	for (bBit = 0; bBit < MGC_HSDMA_CHANNELS; bBit++) {
+	for (bBit = 0; bBit < MUSB_HSDMA_CHANNELS; bBit++) {
 		if (!(controller->bmUsedChannels & (1 << bBit))) {
 			controller->bmUsedChannels |= (1 << bBit);
 			pImplChannel = &(controller->aChannel[bBit]);
@@ -191,13 +191,13 @@ static void configure_channel(struct dma_channel *pChannel,
 		}
 		if (packet_sz >= 64) {
 			csr |=
-			    MGC_HSDMA_BURSTMODE_INCR16 << MUSB_HSDMA_BURSTMODE_SHIFT;
+			    MUSB_HSDMA_BURSTMODE_INCR16 << MUSB_HSDMA_BURSTMODE_SHIFT;
 		} else if (packet_sz >= 32) {
 			csr |=
-			    MGC_HSDMA_BURSTMODE_INCR8 << MUSB_HSDMA_BURSTMODE_SHIFT;
+			    MUSB_HSDMA_BURSTMODE_INCR8 << MUSB_HSDMA_BURSTMODE_SHIFT;
 		} else if (packet_sz >= 16) {
 			csr |=
-			    MGC_HSDMA_BURSTMODE_INCR4 << MUSB_HSDMA_BURSTMODE_SHIFT;
+			    MUSB_HSDMA_BURSTMODE_INCR4 << MUSB_HSDMA_BURSTMODE_SHIFT;
 		}
 	}
 
@@ -208,15 +208,15 @@ static void configure_channel(struct dma_channel *pChannel,
 
 	/* address/count */
 	musb_writel(mbase,
-		    MGC_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_ADDRESS),
+		    MUSB_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_ADDRESS),
 		    dma_addr);
 	musb_writel(mbase,
-		    MGC_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_COUNT),
+		    MUSB_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_COUNT),
 		    len);
 
 	/* control (this should start things) */
 	musb_writew(mbase,
-		    MGC_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_CONTROL),
+		    MUSB_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_CONTROL),
 		    csr);
 }
 
@@ -283,11 +283,11 @@ static int dma_channel_abort(struct dma_channel *pChannel)
 		}
 
 		musb_writew(mbase,
-		   MGC_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_CONTROL), 0);
+		   MUSB_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_CONTROL), 0);
 		musb_writel(mbase,
-		   MGC_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_ADDRESS), 0);
+		   MUSB_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_ADDRESS), 0);
 		musb_writel(mbase,
-		   MGC_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_COUNT), 0);
+		   MUSB_HSDMA_CHANNEL_OFFSET(bChannel, MUSB_HSDMA_COUNT), 0);
 
 		pChannel->status = MUSB_DMA_STATUS_FREE;
 	}
@@ -311,14 +311,14 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 	if (!int_hsdma)
 		goto done;
 
-	for (bChannel = 0; bChannel < MGC_HSDMA_CHANNELS; bChannel++) {
+	for (bChannel = 0; bChannel < MUSB_HSDMA_CHANNELS; bChannel++) {
 		if (int_hsdma & (1 << bChannel)) {
 			pImplChannel = (struct musb_dma_channel *)
 					&(controller->aChannel[bChannel]);
 			pChannel = &pImplChannel->Channel;
 
 			csr = musb_readw(mbase,
-				       MGC_HSDMA_CHANNEL_OFFSET(bChannel,
+				       MUSB_HSDMA_CHANNEL_OFFSET(bChannel,
 							MUSB_HSDMA_CONTROL));
 
 			if (csr & (1 << MUSB_HSDMA_BUSERROR_SHIFT)) {
@@ -326,7 +326,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 				    MUSB_DMA_STATUS_BUS_ABORT;
 			} else {
 				dwAddress = musb_readl(mbase,
-						MGC_HSDMA_CHANNEL_OFFSET(
+						MUSB_HSDMA_CHANNEL_OFFSET(
 							bChannel,
 							MUSB_HSDMA_ADDRESS));
 				pChannel->actual_len =
@@ -403,7 +403,7 @@ dma_controller_create(struct musb *musb, void __iomem *pCoreBase)
 				GFP_KERNEL)))
 		return NULL;
 
-	controller->bChannelCount = MGC_HSDMA_CHANNELS;
+	controller->bChannelCount = MUSB_HSDMA_CHANNELS;
 	controller->pDmaPrivate = musb;
 	controller->pCoreBase = pCoreBase;
 
-- 
1.5.2.3
