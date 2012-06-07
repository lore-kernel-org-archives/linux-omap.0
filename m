From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 13/31] dmaengine: PL08x: get rid of unnecessary checks in
 dma_slave_config
Date: Thu, 07 Jun 2012 11:50:06 +0100
Message-ID: <E1ScaI2-0003kt-MT@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54205 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150Ab2FGKuM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:50:12 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Get rid of the unnecessary checks in dma_slave_config utilizing
the DMA direction.  This allows us to move the computation of
cctl to the prepare function.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |   41 +++++++++++++----------------------------
 include/linux/amba/pl08x.h |    5 +++--
 2 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 50b9a83..f739778 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -235,8 +235,6 @@ struct pl08x_dma_chan {
 	const char *name;
 	const struct pl08x_channel_data *cd;
 	struct dma_slave_config cfg;
-	u32 src_cctl;
-	u32 dst_cctl;
 	struct list_head pend_list;
 	struct pl08x_txd *at;
 	spinlock_t lock;
@@ -1235,30 +1233,15 @@ static int dma_set_runtime_config(struct dma_chan *chan,
 				  struct dma_slave_config *config)
 {
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
-	struct pl08x_driver_data *pl08x = plchan->host;
-	u32 src_cctl, dst_cctl;
 
 	if (!plchan->slave)
 		return -EINVAL;
 
-	dst_cctl = pl08x_get_cctl(plchan, config->dst_addr_width,
-				  config->dst_maxburst);
-	if (dst_cctl == ~0 && config->direction == DMA_MEM_TO_DEV) {
-		dev_err(&pl08x->adev->dev,
-			"bad runtime_config: alien address width (M2D)\n");
+	/* Reject definitely invalid configurations */
+	if (config->src_addr_width == DMA_SLAVE_BUSWIDTH_8_BYTES ||
+	    config->dst_addr_width == DMA_SLAVE_BUSWIDTH_8_BYTES)
 		return -EINVAL;
-	}
 
-	src_cctl = pl08x_get_cctl(plchan, config->src_addr_width,
-				  config->src_maxburst);
-	if (src_cctl == ~0 && config->direction == DMA_DEV_TO_MEM) {
-		dev_err(&pl08x->adev->dev,
-			"bad runtime_config: alien address width (D2M)\n");
-		return -EINVAL;
-	}
-
-	plchan->dst_cctl = dst_cctl;
-	plchan->src_cctl = src_cctl;
 	plchan->cfg = *config;
 
 	return 0;
@@ -1407,7 +1390,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
 
 	/* Set platform data for m2m */
 	txd->ccfg |= PL080_FLOW_MEM2MEM << PL080_CONFIG_FLOW_CONTROL_SHIFT;
-	txd->cctl = pl08x->pd->memcpy_channel.cctl &
+	txd->cctl = pl08x->pd->memcpy_channel.cctl_memcpy &
 			~(PL080_CONTROL_DST_AHB2 | PL080_CONTROL_SRC_AHB2);
 
 	/* Both to be incremented or the code will break */
@@ -1434,10 +1417,11 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	struct pl08x_txd *txd;
 	struct pl08x_sg *dsg;
 	struct scatterlist *sg;
+	enum dma_slave_buswidth addr_width;
 	dma_addr_t slave_addr;
 	int ret, tmp;
 	u8 src_buses, dst_buses;
-	u32 cctl;
+	u32 maxburst, cctl;
 
 	dev_dbg(&pl08x->adev->dev, "%s prepare transaction of %d bytes from %s\n",
 			__func__, sg_dma_len(sgl), plchan->name);
@@ -1456,13 +1440,17 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	txd->direction = direction;
 
 	if (direction == DMA_MEM_TO_DEV) {
-		cctl = plchan->dst_cctl | PL080_CONTROL_SRC_INCR;
+		cctl = PL080_CONTROL_SRC_INCR;
 		slave_addr = plchan->cfg.dst_addr;
+		addr_width = plchan->cfg.dst_addr_width;
+		maxburst = plchan->cfg.dst_maxburst;
 		src_buses = pl08x->mem_buses;
 		dst_buses = plchan->cd->periph_buses;
 	} else if (direction == DMA_DEV_TO_MEM) {
-		cctl = plchan->src_cctl | PL080_CONTROL_DST_INCR;
+		cctl = PL080_CONTROL_DST_INCR;
 		slave_addr = plchan->cfg.src_addr;
+		addr_width = plchan->cfg.src_addr_width;
+		maxburst = plchan->cfg.src_maxburst;
 		src_buses = plchan->cd->periph_buses;
 		dst_buses = pl08x->mem_buses;
 	} else {
@@ -1472,6 +1460,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 		return NULL;
 	}
 
+	cctl |= pl08x_get_cctl(plchan, addr_width, maxburst);
 	if (cctl == ~0) {
 		pl08x_free_txd(pl08x, txd);
 		dev_err(&pl08x->adev->dev,
@@ -1774,14 +1763,10 @@ static irqreturn_t pl08x_irq(int irq, void *dev)
 
 static void pl08x_dma_slave_init(struct pl08x_dma_chan *chan)
 {
-	u32 cctl = pl08x_cctl(chan->cd->cctl);
-
 	chan->slave = true;
 	chan->name = chan->cd->bus_id;
 	chan->cfg.src_addr = chan->cd->addr;
 	chan->cfg.dst_addr = chan->cd->addr;
-	chan->src_cctl = cctl;
-	chan->dst_cctl = cctl;
 }
 
 /*
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 158ce26..2a5f64a 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -47,7 +47,8 @@ enum {
  * devices with static assignments
  * @muxval: a number usually used to poke into some mux regiser to
  * mux in the signal to this channel
- * @cctl_opt: default options for the channel control register
+ * @cctl_memcpy: options for the channel control register for memcpy
+ *  *** not used for slave channels ***
  * @addr: source/target address in physical memory for this DMA channel,
  * can be the address of a FIFO register for burst requests for example.
  * This can be left undefined if the PrimeCell API is used for configuring
@@ -62,7 +63,7 @@ struct pl08x_channel_data {
 	int min_signal;
 	int max_signal;
 	u32 muxval;
-	u32 cctl;
+	u32 cctl_memcpy;
 	dma_addr_t addr;
 	bool single;
 	u8 periph_buses;
-- 
1.7.4.4

