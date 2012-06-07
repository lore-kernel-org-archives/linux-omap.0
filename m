From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 10/31] dmaengine: PL08x: move the bus and increment selection
 to dma prepare function
Date: Thu, 07 Jun 2012 11:49:05 +0100
Message-ID: <E1ScaH3-0003kd-Di@rmk-PC.arm.linux.org.uk>
References: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54193 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760567Ab2FGKtK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:49:10 -0400
In-Reply-To: <20120607104527.GA15973@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Move the bus and transfer increment selection to the DMA prepare
function rather than the slave configuration function.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 7eb0e8e..bd51a44 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1258,13 +1258,9 @@ static int dma_set_runtime_config(struct dma_chan *chan,
 	cctl |= burst << PL080_CONTROL_DB_SIZE_SHIFT;
 
 	if (plchan->runtime_direction == DMA_DEV_TO_MEM) {
-		plchan->src_cctl = pl08x_cctl(cctl) | PL080_CONTROL_DST_INCR |
-			pl08x_select_bus(plchan->cd->periph_buses,
-					 pl08x->mem_buses);
+		plchan->src_cctl = pl08x_cctl(cctl);
 	} else {
-		plchan->dst_cctl = pl08x_cctl(cctl) | PL080_CONTROL_SRC_INCR |
-			pl08x_select_bus(pl08x->mem_buses,
-					 plchan->cd->periph_buses);
+		plchan->dst_cctl = pl08x_cctl(cctl);
 	}
 
 	dev_dbg(&pl08x->adev->dev,
@@ -1451,6 +1447,8 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	struct scatterlist *sg;
 	dma_addr_t slave_addr;
 	int ret, tmp;
+	u8 src_buses, dst_buses;
+	u32 cctl;
 
 	dev_dbg(&pl08x->adev->dev, "%s prepare transaction of %d bytes from %s\n",
 			__func__, sg_dma_len(sgl), plchan->name);
@@ -1474,11 +1472,15 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 	txd->direction = direction;
 
 	if (direction == DMA_MEM_TO_DEV) {
-		txd->cctl = plchan->dst_cctl;
+		cctl = plchan->dst_cctl | PL080_CONTROL_SRC_INCR;
 		slave_addr = plchan->cfg.dst_addr;
+		src_buses = pl08x->mem_buses;
+		dst_buses = plchan->cd->periph_buses;
 	} else if (direction == DMA_DEV_TO_MEM) {
-		txd->cctl = plchan->src_cctl;
+		cctl = plchan->src_cctl | PL080_CONTROL_DST_INCR;
 		slave_addr = plchan->cfg.src_addr;
+		src_buses = plchan->cd->periph_buses;
+		dst_buses = pl08x->mem_buses;
 	} else {
 		pl08x_free_txd(pl08x, txd);
 		dev_err(&pl08x->adev->dev,
@@ -1486,6 +1488,8 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 		return NULL;
 	}
 
+	txd->cctl = cctl | pl08x_select_bus(src_buses, dst_buses);
+
 	if (plchan->cfg.device_fc)
 		tmp = (direction == DMA_MEM_TO_DEV) ? PL080_FLOW_MEM2PER_PER :
 			PL080_FLOW_PER2MEM_PER;
@@ -1785,10 +1789,8 @@ static void pl08x_dma_slave_init(struct pl08x_dma_chan *chan)
 	chan->name = chan->cd->bus_id;
 	chan->cfg.src_addr = chan->cd->addr;
 	chan->cfg.dst_addr = chan->cd->addr;
-	chan->src_cctl = cctl | PL080_CONTROL_DST_INCR |
-		pl08x_select_bus(chan->cd->periph_buses, chan->host->mem_buses);
-	chan->dst_cctl = cctl | PL080_CONTROL_SRC_INCR |
-		pl08x_select_bus(chan->host->mem_buses, chan->cd->periph_buses);
+	chan->src_cctl = cctl;
+	chan->dst_cctl = cctl;
 }
 
 /*
-- 
1.7.4.4

