From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 08/10] usb: musb: tusb6010: Handle DMA TX completion in DMA callback as well
Date: Wed, 10 May 2017 11:42:30 +0300
Message-ID: <20170510084231.19302-9-peter.ujfalusi@ti.com>
References: <20170510084231.19302-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170510084231.19302-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: b-liu@ti.com, tony@atomide.com, gregkh@linuxfoundation.org, vinod.koul@intel.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Handle the DMA TX in a similar way as we do for the RX: in the DMA
completion callback.

Since we are no longer using DMA completion interrupt for the TX we can as
wall keep these interrupts disabled, but keep the handler for debug
purposes.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/usb/musb/tusb6010.c      | 18 +++---------------
 drivers/usb/musb/tusb6010_omap.c | 34 +---------------------------------
 2 files changed, 4 insertions(+), 48 deletions(-)

diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 4253bfb22043..4eb640c54f2c 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -881,26 +881,14 @@ static irqreturn_t tusb_musb_interrupt(int irq, void *__hci)
 				| TUSB_INT_SRC_ID_STATUS_CHNG))
 		idle_timeout = tusb_otg_ints(musb, int_src, tbase);
 
-	/* TX dma callback must be handled here, RX dma callback is
-	 * handled in tusb_omap_dma_cb.
+	/*
+	 * Just clear the DMA interrupt if it comes as the completion for both
+	 * TX and RX is handled by the DMA callback in tusb6010_omap
 	 */
 	if ((int_src & TUSB_INT_SRC_TXRX_DMA_DONE)) {
 		u32	dma_src = musb_readl(tbase, TUSB_DMA_INT_SRC);
-		u32	real_dma_src = musb_readl(tbase, TUSB_DMA_INT_MASK);
 
 		dev_dbg(musb->controller, "DMA IRQ %08x\n", dma_src);
-		real_dma_src = ~real_dma_src & dma_src;
-		if (tusb_dma_omap(musb) && real_dma_src) {
-			int	tx_source = (real_dma_src & 0xffff);
-			int	i;
-
-			for (i = 1; i <= 15; i++) {
-				if (tx_source & (1 << i)) {
-					dev_dbg(musb->controller, "completing ep%i %s\n", i, "tx");
-					musb_dma_completion(musb, i, 1);
-				}
-			}
-		}
 		musb_writel(tbase, TUSB_DMA_INT_CLEAR, dma_src);
 	}
 
diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
index 2daeef7e572d..34e0115a4629 100644
--- a/drivers/usb/musb/tusb6010_omap.c
+++ b/drivers/usb/musb/tusb6010_omap.c
@@ -173,13 +173,7 @@ static void tusb_omap_dma_cb(int lch, u16 ch_status, void *data)
 
 	channel->status = MUSB_DMA_STATUS_FREE;
 
-	/* Handle only RX callbacks here. TX callbacks must be handled based
-	 * on the TUSB DMA status interrupt.
-	 * REVISIT: Use both TUSB DMA status interrupt and OMAP DMA callback
-	 * interrupt for RX and TX.
-	 */
-	if (!chdat->tx)
-		musb_dma_completion(musb, chdat->epnum, chdat->tx);
+	musb_dma_completion(musb, chdat->epnum, chdat->tx);
 
 	/* We must terminate short tx transfers manually by setting TXPKTRDY.
 	 * REVISIT: This same problem may occur with other MUSB dma as well.
@@ -463,22 +457,12 @@ tusb_omap_dma_allocate(struct dma_controller *c,
 	int ret, i;
 	struct tusb_omap_dma	*tusb_dma;
 	struct musb		*musb;
-	void __iomem		*tbase;
 	struct dma_channel	*channel = NULL;
 	struct tusb_omap_dma_ch	*chdat = NULL;
 	struct tusb_dma_data	*dma_data = NULL;
-	u32			reg;
 
 	tusb_dma = container_of(c, struct tusb_omap_dma, controller);
 	musb = tusb_dma->controller.musb;
-	tbase = musb->ctrl_base;
-
-	reg = musb_readl(tbase, TUSB_DMA_INT_MASK);
-	if (tx)
-		reg &= ~(1 << hw_ep->epnum);
-	else
-		reg &= ~(1 << (hw_ep->epnum + 15));
-	musb_writel(tbase, TUSB_DMA_INT_MASK, reg);
 
 	/* REVISIT: Why does dmareq5 not work? */
 	if (hw_ep->epnum == 0) {
@@ -547,26 +531,10 @@ static void tusb_omap_dma_release(struct dma_channel *channel)
 {
 	struct tusb_omap_dma_ch	*chdat = to_chdat(channel);
 	struct musb		*musb = chdat->musb;
-	void __iomem		*tbase = musb->ctrl_base;
-	u32			reg;
 
 	dev_dbg(musb->controller, "ep%i ch%i\n", chdat->epnum,
 		chdat->dma_data->ch);
 
-	reg = musb_readl(tbase, TUSB_DMA_INT_MASK);
-	if (chdat->tx)
-		reg |= (1 << chdat->epnum);
-	else
-		reg |= (1 << (chdat->epnum + 15));
-	musb_writel(tbase, TUSB_DMA_INT_MASK, reg);
-
-	reg = musb_readl(tbase, TUSB_DMA_INT_CLEAR);
-	if (chdat->tx)
-		reg |= (1 << chdat->epnum);
-	else
-		reg |= (1 << (chdat->epnum + 15));
-	musb_writel(tbase, TUSB_DMA_INT_CLEAR, reg);
-
 	channel->status = MUSB_DMA_STATUS_UNKNOWN;
 
 	omap_stop_dma(chdat->dma_data->ch);
-- 
2.12.2
