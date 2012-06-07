From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 12/31] dmaengine: PL08x: ignore 'direction' argument in
 dma_slave_config
Date: Thu, 07 Jun 2012 11:49:46 +0100
Message-ID: <E1ScaHi-0003kl-8T@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54201 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150Ab2FGKtz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:49:55 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Ignore the direction argument in dma_slave_config, and configure both
directions independently.  We still check that the configuration for
the intended direction is valid; this check will eventually be dropped.
This check is just for debugging at present.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   56 ++++++++++++++-------------------------------
 1 files changed, 18 insertions(+), 38 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index fde801f..50b9a83 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -218,8 +218,6 @@ enum pl08x_dma_chan_state {
  * @name: name of channel
  * @cd: channel platform data
  * @runtime_addr: address for RX/TX according to the runtime config
- * @runtime_direction: current direction of this channel according to
- * runtime config
  * @pend_list: queued transactions pending on this channel
  * @at: active transaction on this channel
  * @lock: a lock for this channel data
@@ -239,7 +237,6 @@ struct pl08x_dma_chan {
 	struct dma_slave_config cfg;
 	u32 src_cctl;
 	u32 dst_cctl;
-	enum dma_transfer_direction runtime_direction;
 	struct list_head pend_list;
 	struct pl08x_txd *at;
 	spinlock_t lock;
@@ -1239,50 +1236,31 @@ static int dma_set_runtime_config(struct dma_chan *chan,
 {
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
 	struct pl08x_driver_data *pl08x = plchan->host;
-	enum dma_slave_buswidth addr_width;
-	u32 maxburst, cctl = 0;
+	u32 src_cctl, dst_cctl;
 
 	if (!plchan->slave)
 		return -EINVAL;
 
-	/* Transfer direction */
-	plchan->runtime_direction = config->direction;
-	if (config->direction == DMA_MEM_TO_DEV) {
-		addr_width = config->dst_addr_width;
-		maxburst = config->dst_maxburst;
-	} else if (config->direction == DMA_DEV_TO_MEM) {
-		addr_width = config->src_addr_width;
-		maxburst = config->src_maxburst;
-	} else {
+	dst_cctl = pl08x_get_cctl(plchan, config->dst_addr_width,
+				  config->dst_maxburst);
+	if (dst_cctl == ~0 && config->direction == DMA_MEM_TO_DEV) {
 		dev_err(&pl08x->adev->dev,
-			"bad runtime_config: alien transfer direction\n");
+			"bad runtime_config: alien address width (M2D)\n");
 		return -EINVAL;
 	}
 
-	cctl = pl08x_get_cctl(plchan, addr_width, maxburst);
-	if (cctl == ~0) {
+	src_cctl = pl08x_get_cctl(plchan, config->src_addr_width,
+				  config->src_maxburst);
+	if (src_cctl == ~0 && config->direction == DMA_DEV_TO_MEM) {
 		dev_err(&pl08x->adev->dev,
-			"bad runtime_config: alien address width\n");
+			"bad runtime_config: alien address width (D2M)\n");
 		return -EINVAL;
 	}
 
+	plchan->dst_cctl = dst_cctl;
+	plchan->src_cctl = src_cctl;
 	plchan->cfg = *config;
 
-	if (plchan->runtime_direction == DMA_DEV_TO_MEM) {
-		plchan->src_cctl = cctl;
-	} else {
-		plchan->dst_cctl = cctl;
-	}
-
-	dev_dbg(&pl08x->adev->dev,
-		"configured channel %s (%s) for %s, data width %d, "
-		"maxburst %d words, LE, CCTL=0x%08x\n",
-		dma_chan_name(chan), plchan->name,
-		(config->direction == DMA_DEV_TO_MEM) ? "RX" : "TX",
-		addr_width,
-		maxburst,
-		cctl);
-
 	return 0;
 }
 
@@ -1470,11 +1448,6 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 		return NULL;
 	}
 
-	if (direction != plchan->runtime_direction)
-		dev_err(&pl08x->adev->dev, "%s DMA setup does not match "
-			"the direction configured for the PrimeCell\n",
-			__func__);
-
 	/*
 	 * Set up addresses, the PrimeCell configured address
 	 * will take precedence since this may configure the
@@ -1499,6 +1472,13 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 		return NULL;
 	}
 
+	if (cctl == ~0) {
+		pl08x_free_txd(pl08x, txd);
+		dev_err(&pl08x->adev->dev,
+			"DMA slave configuration botched?\n");
+		return NULL;
+	}
+
 	txd->cctl = cctl | pl08x_select_bus(src_buses, dst_buses);
 
 	if (plchan->cfg.device_fc)
-- 
1.7.4.4

