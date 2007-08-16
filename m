From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 30/36] musb_hdrc: Search and replace pController with
	controller
Date: Thu, 16 Aug 2007 02:40:53 -0700
Message-ID: <1187257329166-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11872573273963-git-send-email-tony@atomide.com>
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

Search and replace pController with controller

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/cppi_dma.c  |  128 +++++++++++++++++++++---------------------
 drivers/usb/musb/cppi_dma.h  |    2 +-
 drivers/usb/musb/musbhsdma.c |   82 +++++++++++++-------------
 3 files changed, 106 insertions(+), 106 deletions(-)

diff --git a/drivers/usb/musb/cppi_dma.c b/drivers/usb/musb/cppi_dma.c
index b455f8e..c1fa2b6 100644
--- a/drivers/usb/musb/cppi_dma.c
+++ b/drivers/usb/musb/cppi_dma.c
@@ -100,7 +100,7 @@ static void __init cppi_pool_init(struct cppi *cppi, struct cppi_channel *c)
 	c->activeQueueTail = NULL;
 	c->lastHwBDProcessed = NULL;
 	c->Channel.status = MGC_DMA_STATUS_UNKNOWN;
-	c->pController = cppi;
+	c->controller = cppi;
 	c->bLastModeRndis = 0;
 	c->Channel.private_data = c;
 	c->bdPoolHead = NULL;
@@ -120,12 +120,12 @@ static int cppi_channel_abort(struct dma_channel *);
 
 static void cppi_pool_free(struct cppi_channel *c)
 {
-	struct cppi		*cppi = c->pController;
+	struct cppi		*cppi = c->controller;
 	struct cppi_descriptor	*bd;
 
 	(void) cppi_channel_abort(&c->Channel);
 	c->Channel.status = MGC_DMA_STATUS_UNKNOWN;
-	c->pController = NULL;
+	c->controller = NULL;
 
 	/* free all its bds */
 	bd = c->lastHwBDProcessed;
@@ -139,36 +139,36 @@ static void cppi_pool_free(struct cppi_channel *c)
 
 static int __init cppi_controller_start(struct dma_controller *c)
 {
-	struct cppi	*pController;
+	struct cppi	*controller;
 	void		*__iomem regBase;
 	int		i;
 
-	pController = container_of(c, struct cppi, Controller);
+	controller = container_of(c, struct cppi, Controller);
 
 	/* do whatever is necessary to start controller */
-	for (i = 0; i < ARRAY_SIZE(pController->txCppi); i++) {
-		pController->txCppi[i].transmit = TRUE;
-		pController->txCppi[i].chNo = i;
+	for (i = 0; i < ARRAY_SIZE(controller->txCppi); i++) {
+		controller->txCppi[i].transmit = TRUE;
+		controller->txCppi[i].chNo = i;
 	}
-	for (i = 0; i < ARRAY_SIZE(pController->rxCppi); i++) {
-		pController->rxCppi[i].transmit = FALSE;
-		pController->rxCppi[i].chNo = i;
+	for (i = 0; i < ARRAY_SIZE(controller->rxCppi); i++) {
+		controller->rxCppi[i].transmit = FALSE;
+		controller->rxCppi[i].chNo = i;
 	}
 
 	/* setup BD list on a per channel basis */
-	for (i = 0; i < ARRAY_SIZE(pController->txCppi); i++)
-		cppi_pool_init(pController, pController->txCppi + i);
-	for (i = 0; i < ARRAY_SIZE(pController->rxCppi); i++)
-		cppi_pool_init(pController, pController->rxCppi + i);
+	for (i = 0; i < ARRAY_SIZE(controller->txCppi); i++)
+		cppi_pool_init(controller, controller->txCppi + i);
+	for (i = 0; i < ARRAY_SIZE(controller->rxCppi); i++)
+		cppi_pool_init(controller, controller->rxCppi + i);
 
 	/* Do Necessary configuartion in H/w to get started */
-	regBase =  pController->pCoreBase - DAVINCI_BASE_OFFSET;
+	regBase =  controller->pCoreBase - DAVINCI_BASE_OFFSET;
 
-	INIT_LIST_HEAD(&pController->tx_complete);
+	INIT_LIST_HEAD(&controller->tx_complete);
 
 	/* initialise tx/rx channel head pointers to zero */
-	for (i = 0; i < ARRAY_SIZE(pController->txCppi); i++) {
-		struct cppi_channel	*txChannel = pController->txCppi + i;
+	for (i = 0; i < ARRAY_SIZE(controller->txCppi); i++) {
+		struct cppi_channel	*txChannel = controller->txCppi + i;
 		struct cppi_tx_stateram *__iomem txState;
 
 		INIT_LIST_HEAD(&txChannel->tx_complete);
@@ -186,8 +186,8 @@ static int __init cppi_controller_start(struct dma_controller *c)
 		txState->completionPtr = 0;
 
 	}
-	for (i = 0; i < ARRAY_SIZE(pController->rxCppi); i++) {
-		struct cppi_channel	*rxChannel = pController->rxCppi + i;
+	for (i = 0; i < ARRAY_SIZE(controller->rxCppi); i++) {
+		struct cppi_channel	*rxChannel = controller->rxCppi + i;
 		struct cppi_rx_stateram *__iomem rxState;
 
 		INIT_LIST_HEAD(&rxChannel->tx_complete);
@@ -222,13 +222,13 @@ static int __init cppi_controller_start(struct dma_controller *c)
 
 static int cppi_controller_stop(struct dma_controller *c)
 {
-	struct cppi		*pController;
+	struct cppi		*controller;
 	void __iomem		*regBase;
 	int			i;
 
-	pController = container_of(c, struct cppi, Controller);
+	controller = container_of(c, struct cppi, Controller);
 
-	regBase = pController->pCoreBase - DAVINCI_BASE_OFFSET;
+	regBase = controller->pCoreBase - DAVINCI_BASE_OFFSET;
 	/* DISABLE INDIVIDUAL CHANNEL Interrupts */
 	musb_writel(regBase, DAVINCI_TXCPPI_INTCLR_REG,
 			DAVINCI_DMA_ALL_CHANNELS_ENABLE);
@@ -236,13 +236,13 @@ static int cppi_controller_stop(struct dma_controller *c)
 			DAVINCI_DMA_ALL_CHANNELS_ENABLE);
 
 	DBG(1, "Tearing down RX and TX Channels\n");
-	for (i = 0; i < ARRAY_SIZE(pController->txCppi); i++) {
+	for (i = 0; i < ARRAY_SIZE(controller->txCppi); i++) {
 		/* FIXME restructure of txdma to use bds like rxdma */
-		pController->txCppi[i].lastHwBDProcessed = NULL;
-		cppi_pool_free(pController->txCppi + i);
+		controller->txCppi[i].lastHwBDProcessed = NULL;
+		cppi_pool_free(controller->txCppi + i);
 	}
-	for (i = 0; i < ARRAY_SIZE(pController->rxCppi); i++)
-		cppi_pool_free(pController->rxCppi + i);
+	for (i = 0; i < ARRAY_SIZE(controller->rxCppi); i++)
+		cppi_pool_free(controller->rxCppi + i);
 
 	/* in Tx Case proper teardown is supported. We resort to disabling
 	 * Tx/Rx CPPI after cleanup of Tx channels. Before TX teardown is
@@ -285,14 +285,14 @@ cppi_channel_allocate(struct dma_controller *c,
 		struct musb_hw_ep *ep,
 		u8 transmit)
 {
-	struct cppi		*pController;
+	struct cppi		*controller;
 	u8			chNum;
 	struct cppi_channel	*otgCh;
 	void __iomem		*tibase;
 	int			local_end = ep->epnum;
 
-	pController = container_of(c, struct cppi, Controller);
-	tibase = pController->pCoreBase - DAVINCI_BASE_OFFSET;
+	controller = container_of(c, struct cppi, Controller);
+	tibase = controller->pCoreBase - DAVINCI_BASE_OFFSET;
 
 	/* remember local_end: 1..Max_EndPt, and cppi ChNum:0..Max_EndPt-1 */
 	chNum = local_end - 1;
@@ -301,17 +301,17 @@ cppi_channel_allocate(struct dma_controller *c,
 	 * probably disable the non-CPPI irq until we need it.
 	 */
 	if (transmit) {
-		if (local_end > ARRAY_SIZE(pController->txCppi)) {
+		if (local_end > ARRAY_SIZE(controller->txCppi)) {
 			DBG(1, "no %cX DMA channel for ep%d\n", 'T', local_end);
 			return NULL;
 		}
-		otgCh = pController->txCppi + chNum;
+		otgCh = controller->txCppi + chNum;
 	} else {
-		if (local_end > ARRAY_SIZE(pController->rxCppi)) {
+		if (local_end > ARRAY_SIZE(controller->rxCppi)) {
 			DBG(1, "no %cX DMA channel for ep%d\n", 'R', local_end);
 			return NULL;
 		}
-		otgCh = pController->rxCppi + chNum;
+		otgCh = controller->rxCppi + chNum;
 		core_rxirq_disable(tibase, local_end);
 	}
 
@@ -340,7 +340,7 @@ static void cppi_channel_release(struct dma_channel *channel)
 
 	c = container_of(channel, struct cppi_channel, Channel);
 	epnum = c->chNo + 1;
-	tibase = c->pController->pCoreBase - DAVINCI_BASE_OFFSET;
+	tibase = c->controller->pCoreBase - DAVINCI_BASE_OFFSET;
 	if (!c->hw_ep)
 		DBG(1, "releasing idle DMA channel %p\n", c);
 	else if (!c->transmit)
@@ -355,7 +355,7 @@ static void cppi_channel_release(struct dma_channel *channel)
 static void
 cppi_dump_rx(int level, struct cppi_channel *c, const char *tag)
 {
-	void	*__iomem base = c->pController->pCoreBase;
+	void	*__iomem base = c->controller->pCoreBase;
 
 	musb_ep_select(base, c->chNo + 1);
 
@@ -384,7 +384,7 @@ cppi_dump_rx(int level, struct cppi_channel *c, const char *tag)
 static void
 cppi_dump_tx(int level, struct cppi_channel *c, const char *tag)
 {
-	void	*__iomem base = c->pController->pCoreBase;
+	void	*__iomem base = c->controller->pCoreBase;
 
 	musb_ep_select(base, c->chNo + 1);
 
@@ -954,8 +954,8 @@ static int cppi_channel_program(struct dma_channel *pChannel,
 		dma_addr_t dma_addr, u32 len)
 {
 	struct cppi_channel	*otgChannel = pChannel->private_data;
-	struct cppi		*pController = otgChannel->pController;
-	struct musb		*musb = pController->musb;
+	struct cppi		*controller = otgChannel->controller;
+	struct musb		*musb = controller->musb;
 
 	switch (pChannel->status) {
 	case MGC_DMA_STATUS_BUS_ABORT:
@@ -1307,38 +1307,38 @@ void cppi_completion(struct musb *musb, u32 rx, u32 tx)
 struct dma_controller *__init
 dma_controller_create(struct musb *musb, void __iomem *pCoreBase)
 {
-	struct cppi		*pController;
+	struct cppi		*controller;
 
-	pController = kzalloc(sizeof *pController, GFP_KERNEL);
-	if (!pController)
+	controller = kzalloc(sizeof *controller, GFP_KERNEL);
+	if (!controller)
 		return NULL;
 
 	/* Initialize the Cppi DmaController  structure */
-	pController->pCoreBase = pCoreBase;
-	pController->musb = musb;
-	pController->Controller.private_data = pController;
-	pController->Controller.start = cppi_controller_start;
-	pController->Controller.stop = cppi_controller_stop;
-	pController->Controller.channel_alloc = cppi_channel_allocate;
-	pController->Controller.channel_release = cppi_channel_release;
-	pController->Controller.channel_program = cppi_channel_program;
-	pController->Controller.channel_abort = cppi_channel_abort;
+	controller->pCoreBase = pCoreBase;
+	controller->musb = musb;
+	controller->Controller.private_data = controller;
+	controller->Controller.start = cppi_controller_start;
+	controller->Controller.stop = cppi_controller_stop;
+	controller->Controller.channel_alloc = cppi_channel_allocate;
+	controller->Controller.channel_release = cppi_channel_release;
+	controller->Controller.channel_program = cppi_channel_program;
+	controller->Controller.channel_abort = cppi_channel_abort;
 
 	/* NOTE: allocating from on-chip SRAM would give the least
 	 * contention for memory access, if that ever matters here.
 	 */
 
 	/* setup BufferPool */
-	pController->pool = dma_pool_create("cppi",
-			pController->musb->controller,
+	controller->pool = dma_pool_create("cppi",
+			controller->musb->controller,
 			sizeof(struct cppi_descriptor),
 			CPPI_DESCRIPTOR_ALIGN, 0);
-	if (!pController->pool) {
-		kfree(pController);
+	if (!controller->pool) {
+		kfree(controller);
 		return NULL;
 	}
 
-	return &pController->Controller;
+	return &controller->Controller;
 }
 
 /*
@@ -1362,7 +1362,7 @@ void dma_controller_destroy(struct dma_controller *c)
 static int cppi_channel_abort(struct dma_channel *channel)
 {
 	struct cppi_channel	*otgCh;
-	struct cppi		*pController;
+	struct cppi		*controller;
 	int			chNum;
 	void			*__iomem mbase;
 	void			*__iomem regBase;
@@ -1372,7 +1372,7 @@ static int cppi_channel_abort(struct dma_channel *channel)
 
 	otgCh = container_of(channel, struct cppi_channel, Channel);
 
-	pController = otgCh->pController;
+	controller = otgCh->controller;
 	chNum = otgCh->chNo;
 
 	switch (channel->status) {
@@ -1393,7 +1393,7 @@ static int cppi_channel_abort(struct dma_channel *channel)
 	if (!otgCh->transmit && otgCh->activeQueueHead)
 		cppi_dump_rxq(3, "/abort", otgCh);
 
-	mbase = pController->pCoreBase;
+	mbase = controller->pCoreBase;
 	regBase = mbase - DAVINCI_BASE_OFFSET;
 
 	queue = otgCh->activeQueueHead;
@@ -1490,7 +1490,7 @@ static int cppi_channel_abort(struct dma_channel *channel)
 		core_rxirq_disable(regBase, otgCh->chNo + 1);
 
 		/* for host, ensure ReqPkt is never set again */
-		if (is_host_active(otgCh->pController->musb)) {
+		if (is_host_active(otgCh->controller->musb)) {
 			regVal = musb_readl(regBase, DAVINCI_AUTOREQ_REG);
 			regVal &= ~((0x3) << (otgCh->chNo * 2));
 			musb_writel(regBase, DAVINCI_AUTOREQ_REG, regVal);
@@ -1499,7 +1499,7 @@ static int cppi_channel_abort(struct dma_channel *channel)
 		csr = musb_readw(regs, MUSB_RXCSR);
 
 		/* for host, clear (just) ReqPkt at end of current packet(s) */
-		if (is_host_active(otgCh->pController->musb)) {
+		if (is_host_active(otgCh->controller->musb)) {
 			csr |= MUSB_RXCSR_H_WZC_BITS;
 			csr &= ~MUSB_RXCSR_H_REQPKT;
 		} else
@@ -1521,7 +1521,7 @@ static int cppi_channel_abort(struct dma_channel *channel)
 		/* scan the current list, reporting any data that was
 		 * transferred and acking any IRQ
 		 */
-		cppi_rx_scan(pController, chNum);
+		cppi_rx_scan(controller, chNum);
 
 		/* clobber the existing state once it's idle
 		 *
diff --git a/drivers/usb/musb/cppi_dma.h b/drivers/usb/musb/cppi_dma.h
index 66a46ea..da97a99 100644
--- a/drivers/usb/musb/cppi_dma.h
+++ b/drivers/usb/musb/cppi_dma.h
@@ -62,7 +62,7 @@ struct cppi_channel {
 	struct dma_channel Channel;
 
 	/* back pointer to the Dma Controller structure */
-	struct cppi		*pController;
+	struct cppi		*controller;
 
 	/* which direction of which endpoint? */
 	struct musb_hw_ep	*hw_ep;
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index b6d3ef0..3b20667 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -73,7 +73,7 @@ struct musb_dma_controller;
 
 struct musb_dma_channel {
 	struct dma_channel		Channel;
-	struct musb_dma_controller	*pController;
+	struct musb_dma_controller	*controller;
 	u32				dwStartAddress;
 	u32				len;
 	u16				wMaxPacketSize;
@@ -102,22 +102,22 @@ static void dma_channel_release(struct dma_channel *pChannel);
 
 static int dma_controller_stop(struct dma_controller *c)
 {
-	struct musb_dma_controller *pController =
+	struct musb_dma_controller *controller =
 		container_of(c, struct musb_dma_controller, Controller);
-	struct musb *musb = (struct musb *) pController->pDmaPrivate;
+	struct musb *musb = (struct musb *) controller->pDmaPrivate;
 	struct dma_channel *pChannel;
 	u8 bBit;
 
-	if (pController->bmUsedChannels != 0) {
+	if (controller->bmUsedChannels != 0) {
 		dev_err(musb->controller,
 			"Stopping DMA controller while channel active\n");
 
 		for (bBit = 0; bBit < MGC_HSDMA_CHANNELS; bBit++) {
-			if (pController->bmUsedChannels & (1 << bBit)) {
-				pChannel = &(pController->aChannel[bBit].Channel);
+			if (controller->bmUsedChannels & (1 << bBit)) {
+				pChannel = &(controller->aChannel[bBit].Channel);
 				dma_channel_release(pChannel);
 
-				if (!pController->bmUsedChannels)
+				if (!controller->bmUsedChannels)
 					break;
 			}
 		}
@@ -131,14 +131,14 @@ static struct dma_channel* dma_channel_allocate(struct dma_controller *c,
 	u8 bBit;
 	struct dma_channel *pChannel = NULL;
 	struct musb_dma_channel *pImplChannel = NULL;
-	struct musb_dma_controller *pController =
+	struct musb_dma_controller *controller =
 			container_of(c, struct musb_dma_controller, Controller);
 
 	for (bBit = 0; bBit < MGC_HSDMA_CHANNELS; bBit++) {
-		if (!(pController->bmUsedChannels & (1 << bBit))) {
-			pController->bmUsedChannels |= (1 << bBit);
-			pImplChannel = &(pController->aChannel[bBit]);
-			pImplChannel->pController = pController;
+		if (!(controller->bmUsedChannels & (1 << bBit))) {
+			controller->bmUsedChannels |= (1 << bBit);
+			pImplChannel = &(controller->aChannel[bBit]);
+			pImplChannel->controller = controller;
 			pImplChannel->bIndex = bBit;
 			pImplChannel->epnum = hw_ep->epnum;
 			pImplChannel->transmit = transmit;
@@ -164,7 +164,7 @@ static void dma_channel_release(struct dma_channel *pChannel)
 	pImplChannel->dwStartAddress = 0;
 	pImplChannel->len = 0;
 
-	pImplChannel->pController->bmUsedChannels &=
+	pImplChannel->controller->bmUsedChannels &=
 		~(1 << pImplChannel->bIndex);
 
 	pChannel->status = MGC_DMA_STATUS_UNKNOWN;
@@ -176,8 +176,8 @@ static void configure_channel(struct dma_channel *pChannel,
 {
 	struct musb_dma_channel *pImplChannel =
 		(struct musb_dma_channel *) pChannel->private_data;
-	struct musb_dma_controller *pController = pImplChannel->pController;
-	u8 *mbase = pController->pCoreBase;
+	struct musb_dma_controller *controller = pImplChannel->controller;
+	u8 *mbase = controller->pCoreBase;
 	u8 bChannel = pImplChannel->bIndex;
 	u16 csr = 0;
 
@@ -256,7 +256,7 @@ static int dma_channel_abort(struct dma_channel *pChannel)
 	struct musb_dma_channel *pImplChannel =
 		(struct musb_dma_channel *) pChannel->private_data;
 	u8 bChannel = pImplChannel->bIndex;
-	u8 *mbase = pImplChannel->pController->pCoreBase;
+	u8 *mbase = pImplChannel->controller->pCoreBase;
 	u16 csr;
 
 	if (pChannel->status == MGC_DMA_STATUS_BUSY) {
@@ -296,10 +296,10 @@ static int dma_channel_abort(struct dma_channel *pChannel)
 
 static irqreturn_t dma_controller_irq(int irq, void *private_data)
 {
-	struct musb_dma_controller *pController =
+	struct musb_dma_controller *controller =
 		(struct musb_dma_controller *)private_data;
 	struct musb_dma_channel *pImplChannel;
-	u8 *mbase = pController->pCoreBase;
+	u8 *mbase = controller->pCoreBase;
 	struct dma_channel *pChannel;
 	u8 bChannel;
 	u16 csr;
@@ -314,7 +314,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 	for (bChannel = 0; bChannel < MGC_HSDMA_CHANNELS; bChannel++) {
 		if (int_hsdma & (1 << bChannel)) {
 			pImplChannel = (struct musb_dma_channel *)
-					&(pController->aChannel[bChannel]);
+					&(controller->aChannel[bChannel]);
 			pChannel = &pImplChannel->Channel;
 
 			csr = musb_readw(mbase,
@@ -360,7 +360,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 						MUSB_TXCSR_TXPKTRDY);
 				} else
 					musb_dma_completion(
-						pController->pDmaPrivate,
+						controller->pDmaPrivate,
 						pImplChannel->epnum,
 						pImplChannel->transmit);
 			}
@@ -373,23 +373,23 @@ done:
 
 void dma_controller_destroy(struct dma_controller *c)
 {
-	struct musb_dma_controller *pController =
+	struct musb_dma_controller *controller =
 		(struct musb_dma_controller *) c->private_data;
 
-	if (!pController)
+	if (!controller)
 		return;
 
-	if (pController->irq)
-		free_irq(pController->irq, c);
+	if (controller->irq)
+		free_irq(controller->irq, c);
 
-	kfree(pController);
+	kfree(controller);
 	c->private_data = NULL;
 }
 
 struct dma_controller *__init
 dma_controller_create(struct musb *musb, void __iomem *pCoreBase)
 {
-	struct musb_dma_controller *pController;
+	struct musb_dma_controller *controller;
 	struct device *dev = musb->controller;
 	struct platform_device *pdev = to_platform_device(dev);
 	int irq = platform_get_irq(pdev, 1);
@@ -399,30 +399,30 @@ dma_controller_create(struct musb *musb, void __iomem *pCoreBase)
 		return NULL;
 	}
 
-	if (!(pController = kzalloc(sizeof(struct musb_dma_controller),
+	if (!(controller = kzalloc(sizeof(struct musb_dma_controller),
 				GFP_KERNEL)))
 		return NULL;
 
-	pController->bChannelCount = MGC_HSDMA_CHANNELS;
-	pController->pDmaPrivate = musb;
-	pController->pCoreBase = pCoreBase;
+	controller->bChannelCount = MGC_HSDMA_CHANNELS;
+	controller->pDmaPrivate = musb;
+	controller->pCoreBase = pCoreBase;
 
-	pController->Controller.private_data = pController;
-	pController->Controller.start = dma_controller_start;
-	pController->Controller.stop = dma_controller_stop;
-	pController->Controller.channel_alloc = dma_channel_allocate;
-	pController->Controller.channel_release = dma_channel_release;
-	pController->Controller.channel_program = dma_channel_program;
-	pController->Controller.channel_abort = dma_channel_abort;
+	controller->Controller.private_data = controller;
+	controller->Controller.start = dma_controller_start;
+	controller->Controller.stop = dma_controller_stop;
+	controller->Controller.channel_alloc = dma_channel_allocate;
+	controller->Controller.channel_release = dma_channel_release;
+	controller->Controller.channel_program = dma_channel_program;
+	controller->Controller.channel_abort = dma_channel_abort;
 
 	if (request_irq(irq, dma_controller_irq, IRQF_DISABLED,
-			musb->controller->bus_id, &pController->Controller)) {
+			musb->controller->bus_id, &controller->Controller)) {
 		dev_err(dev, "request_irq %d failed!\n", irq);
-		dma_controller_destroy(&pController->Controller);
+		dma_controller_destroy(&controller->Controller);
 		return NULL;
 	}
 
-	pController->irq = irq;
+	controller->irq = irq;
 
-	return &pController->Controller;
+	return &controller->Controller;
 }
-- 
1.5.2.3
