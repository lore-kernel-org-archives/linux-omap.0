From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 37/52] musb_hdrc: Search and replace pPrivateData with
	private_data
Date: Mon, 13 Aug 2007 06:49:12 -0700
Message-ID: <11870130701028-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1187013066263-git-send-email-tony@atomide.com>
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

Search and replace pPrivateData with private_data

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/cppi_dma.c      |    8 ++++----
 drivers/usb/musb/dma.h           |    8 ++++----
 drivers/usb/musb/musbhsdma.c     |   20 ++++++++++----------
 drivers/usb/musb/plat_uds.c      |    4 ++--
 drivers/usb/musb/tusb6010_omap.c |   12 ++++++------
 5 files changed, 26 insertions(+), 26 deletions(-)

--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -102,7 +102,7 @@ static void __init cppi_pool_init(struct cppi *cppi, struct cppi_channel *c)
 	c->Channel.bStatus = MGC_DMA_STATUS_UNKNOWN;
 	c->pController = cppi;
 	c->bLastModeRndis = 0;
-	c->Channel.pPrivateData = c;
+	c->Channel.private_data = c;
 	c->bdPoolHead = NULL;
 
 	/* build the BD Free list for the channel */
@@ -325,7 +325,7 @@ cppi_channel_allocate(struct dma_controller *c,
 	otgCh->Channel.bStatus = MGC_DMA_STATUS_FREE;
 
 	DBG(4, "Allocate CPPI%d %cX\n", chNum, bTransmit ? 'T' : 'R');
-	otgCh->Channel.pPrivateData = otgCh;
+	otgCh->Channel.private_data = otgCh;
 	return &otgCh->Channel;
 }
 
@@ -953,7 +953,7 @@ static int cppi_channel_program(struct dma_channel *pChannel,
 		u16 wPacketSz, u8 mode,
 		dma_addr_t dma_addr, u32 dwLength)
 {
-	struct cppi_channel	*otgChannel = pChannel->pPrivateData;
+	struct cppi_channel	*otgChannel = pChannel->private_data;
 	struct cppi		*pController = otgChannel->pController;
 	struct musb		*musb = pController->musb;
 
@@ -1316,7 +1316,7 @@ dma_controller_create(struct musb *musb, void __iomem *pCoreBase)
 	/* Initialize the Cppi DmaController  structure */
 	pController->pCoreBase = pCoreBase;
 	pController->musb = musb;
-	pController->Controller.pPrivateData = pController;
+	pController->Controller.private_data = pController;
 	pController->Controller.start = cppi_controller_start;
 	pController->Controller.stop = cppi_controller_stop;
 	pController->Controller.channel_alloc = cppi_channel_allocate;
--- a/drivers/usb/musb/dma.h
+++ b/drivers/usb/musb/dma.h
@@ -100,7 +100,7 @@ struct dma_controller;
 
 /**
  * struct dma_channel - A DMA channel.
- * @pPrivateData: channel-private data
+ * @private_data: channel-private data
  * @wMaxLength: the maximum number of bytes the channel can move in one
  *	transaction (typically representing many USB maximum-sized packets)
  * @dwActualLength: how many bytes have been transferred
@@ -111,7 +111,7 @@ struct dma_controller;
  * one usb transfer.
  */
 struct dma_channel {
-	void			*pPrivateData;
+	void			*private_data;
 	// FIXME not void* private_data, but a dma_controller *
 	size_t			dwMaxLength;
 	size_t			dwActualLength;
@@ -156,7 +156,7 @@ dma_channel_status(struct dma_channel *c)
 
 /**
  * struct dma_controller - A DMA Controller.
- * @pPrivateData: controller-private data;
+ * @private_data: controller-private data;
  * @start: call this to start a DMA controller;
  *	return 0 on success, else negative errno
  * @stop: call this to stop a DMA controller
@@ -169,7 +169,7 @@ dma_channel_status(struct dma_channel *c)
  * Controllers manage dma channels.
  */
 struct dma_controller {
-	void			*pPrivateData;
+	void			*private_data;
 	int			(*start)(struct dma_controller *);
 	int			(*stop)(struct dma_controller *);
 	struct dma_channel	*(*channel_alloc)(struct dma_controller *,
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -143,7 +143,7 @@ static struct dma_channel* dma_channel_allocate(struct dma_controller *c,
 			pImplChannel->epnum = hw_ep->epnum;
 			pImplChannel->bTransmit = bTransmit;
 			pChannel = &(pImplChannel->Channel);
-			pChannel->pPrivateData = pImplChannel;
+			pChannel->private_data = pImplChannel;
 			pChannel->bStatus = MGC_DMA_STATUS_FREE;
 			pChannel->dwMaxLength = 0x10000;
 			/* Tx => mode 1; Rx => mode 0 */
@@ -158,7 +158,7 @@ static struct dma_channel* dma_channel_allocate(struct dma_controller *c,
 static void dma_channel_release(struct dma_channel *pChannel)
 {
 	struct musb_dma_channel *pImplChannel =
-		(struct musb_dma_channel *) pChannel->pPrivateData;
+		(struct musb_dma_channel *) pChannel->private_data;
 
 	pChannel->dwActualLength = 0;
 	pImplChannel->dwStartAddress = 0;
@@ -175,7 +175,7 @@ static void configure_channel(struct dma_channel *pChannel,
 				dma_addr_t dma_addr, u32 dwLength)
 {
 	struct musb_dma_channel *pImplChannel =
-		(struct musb_dma_channel *) pChannel->pPrivateData;
+		(struct musb_dma_channel *) pChannel->private_data;
 	struct musb_dma_controller *pController = pImplChannel->pController;
 	u8 *mbase = pController->pCoreBase;
 	u8 bChannel = pImplChannel->bIndex;
@@ -225,7 +225,7 @@ static int dma_channel_program(struct dma_channel * pChannel,
 				dma_addr_t dma_addr, u32 dwLength)
 {
 	struct musb_dma_channel *pImplChannel =
-			(struct musb_dma_channel *) pChannel->pPrivateData;
+			(struct musb_dma_channel *) pChannel->private_data;
 
 	DBG(2, "ep%d-%s pkt_sz %d, dma_addr 0x%x length %d, mode %d\n",
 		pImplChannel->epnum,
@@ -254,7 +254,7 @@ static int dma_channel_program(struct dma_channel * pChannel,
 static int dma_channel_abort(struct dma_channel *pChannel)
 {
 	struct musb_dma_channel *pImplChannel =
-		(struct musb_dma_channel *) pChannel->pPrivateData;
+		(struct musb_dma_channel *) pChannel->private_data;
 	u8 bChannel = pImplChannel->bIndex;
 	u8 *mbase = pImplChannel->pController->pCoreBase;
 	u16 csr;
@@ -294,10 +294,10 @@ static int dma_channel_abort(struct dma_channel *pChannel)
 	return 0;
 }
 
-static irqreturn_t dma_controller_irq(int irq, void *pPrivateData)
+static irqreturn_t dma_controller_irq(int irq, void *private_data)
 {
 	struct musb_dma_controller *pController =
-		(struct musb_dma_controller *)pPrivateData;
+		(struct musb_dma_controller *)private_data;
 	struct musb_dma_channel *pImplChannel;
 	u8 *mbase = pController->pCoreBase;
 	struct dma_channel *pChannel;
@@ -374,7 +374,7 @@ done:
 void dma_controller_destroy(struct dma_controller *c)
 {
 	struct musb_dma_controller *pController =
-		(struct musb_dma_controller *) c->pPrivateData;
+		(struct musb_dma_controller *) c->private_data;
 
 	if (!pController)
 		return;
@@ -383,7 +383,7 @@ void dma_controller_destroy(struct dma_controller *c)
 		free_irq(pController->irq, c);
 
 	kfree(pController);
-	c->pPrivateData = NULL;
+	c->private_data = NULL;
 }
 
 struct dma_controller *__init
@@ -407,7 +407,7 @@ dma_controller_create(struct musb *musb, void __iomem *pCoreBase)
 	pController->pDmaPrivate = musb;
 	pController->pCoreBase = pCoreBase;
 
-	pController->Controller.pPrivateData = pController;
+	pController->Controller.private_data = pController;
 	pController->Controller.start = dma_controller_start;
 	pController->Controller.stop = dma_controller_stop;
 	pController->Controller.channel_alloc = dma_channel_allocate;
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -1810,7 +1810,7 @@ static void musb_free(struct musb *musb)
 	if (is_dma_capable() && musb->dma_controller) {
 		struct dma_controller	*c = musb->dma_controller;
 
-		(void) c->stop(c->pPrivateData);
+		(void) c->stop(c->private_data);
 		dma_controller_destroy(c);
 	}
 
@@ -1923,7 +1923,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 		c = dma_controller_create(musb, musb->mregs);
 		musb->dma_controller = c;
 		if (c)
-			(void) c->start(c->pPrivateData);
+			(void) c->start(c->private_data);
 	}
 #endif
 	/* ideally this would be abstracted in platform setup */
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -32,7 +32,7 @@
 #define dmareq_works()		1
 #endif
 
-#define to_chdat(c)		(struct tusb_omap_dma_ch *)(c)->pPrivateData
+#define to_chdat(c)		(struct tusb_omap_dma_ch *)(c)->private_data
 
 #define MAX_DMAREQ		5	/* REVISIT: Really 6, but req5 not OK */
 
@@ -524,7 +524,7 @@ tusb_omap_dma_allocate(struct dma_controller *c,
 		if (ch->bStatus == MGC_DMA_STATUS_UNKNOWN) {
 			ch->bStatus = MGC_DMA_STATUS_FREE;
 			channel = ch;
-			chdat = ch->pPrivateData;
+			chdat = ch->private_data;
 			break;
 		}
 	}
@@ -640,8 +640,8 @@ void dma_controller_destroy(struct dma_controller *c)
 	for (i = 0; i < MAX_DMAREQ; i++) {
 		struct dma_channel *ch = dma_channel_pool[i];
 		if (ch) {
-			if (ch->pPrivateData)
-				kfree(ch->pPrivateData);
+			if (ch->private_data)
+				kfree(ch->private_data);
 			kfree(ch);
 		}
 	}
@@ -686,7 +686,7 @@ dma_controller_create(struct musb *musb, void __iomem *base)
 	tusb_dma->controller.channel_release = tusb_omap_dma_release;
 	tusb_dma->controller.channel_program = tusb_omap_dma_program;
 	tusb_dma->controller.channel_abort = tusb_omap_dma_abort;
-	tusb_dma->controller.pPrivateData = tusb_dma;
+	tusb_dma->controller.private_data = tusb_dma;
 
 	for (i = 0; i < MAX_DMAREQ; i++) {
 		struct dma_channel	*ch;
@@ -703,7 +703,7 @@ dma_controller_create(struct musb *musb, void __iomem *base)
 			goto cleanup;
 
 		ch->bStatus = MGC_DMA_STATUS_UNKNOWN;
-		ch->pPrivateData = chdat;
+		ch->private_data = chdat;
 	}
 
 	return &tusb_dma->controller;
-- 
1.5.2.3
