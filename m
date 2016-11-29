From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 2/2] dmaengine: omap-dma: Support for slave devices with data port window
Date: Tue, 29 Nov 2016 16:23:42 +0200
Message-ID: <20161129142342.30949-3-peter.ujfalusi@ti.com>
References: <20161129142342.30949-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161129142342.30949-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com, tony@atomide.com, linux@armlinux.org.uk
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

Based on the src/dst_port_window_size - if it is set - configure the DMA
channel to use double indexing in order to be able to loop within the
address window.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 15eb8024666b..ac68666cd3f4 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -166,6 +166,9 @@ enum {
 	CSDP_DST_BURST_16	= 1 << 14,
 	CSDP_DST_BURST_32	= 2 << 14,
 	CSDP_DST_BURST_64	= 3 << 14,
+	CSDP_WRITE_NON_POSTED	= 0 << 16,
+	CSDP_WRITE_POSTED	= 1 << 16,
+	CSDP_WRITE_LAST_NON_POSTED = 2 << 16,
 
 	CICR_TOUT_IE		= BIT(0),	/* OMAP1 only */
 	CICR_DROP_IE		= BIT(1),
@@ -881,15 +884,18 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 	unsigned i, es, en, frame_bytes;
 	bool ll_failed = false;
 	u32 burst;
+	u32 port_window, port_window_bytes;
 
 	if (dir == DMA_DEV_TO_MEM) {
 		dev_addr = c->cfg.src_addr;
 		dev_width = c->cfg.src_addr_width;
 		burst = c->cfg.src_maxburst;
+		port_window = c->cfg.src_port_window_size;
 	} else if (dir == DMA_MEM_TO_DEV) {
 		dev_addr = c->cfg.dst_addr;
 		dev_width = c->cfg.dst_addr_width;
 		burst = c->cfg.dst_maxburst;
+		port_window = c->cfg.dst_port_window_size;
 	} else {
 		dev_err(chan->device->dev, "%s: bad direction?\n", __func__);
 		return NULL;
@@ -910,6 +916,12 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 		return NULL;
 	}
 
+	/* When the port_window is used, one frame must cover the window */
+	if (port_window) {
+		burst = port_window;
+		port_window_bytes = port_window * es_bytes[es];
+	}
+
 	/* Now allocate and setup the descriptor. */
 	d = kzalloc(sizeof(*d) + sglen * sizeof(d->sg[0]), GFP_ATOMIC);
 	if (!d)
@@ -921,11 +933,45 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 
 	d->ccr = c->ccr | CCR_SYNC_FRAME;
 	if (dir == DMA_DEV_TO_MEM) {
-		d->ccr |= CCR_DST_AMODE_POSTINC | CCR_SRC_AMODE_CONSTANT;
 		d->csdp = CSDP_DST_BURST_64 | CSDP_DST_PACKED;
+
+		d->ccr |= CCR_DST_AMODE_POSTINC;
+		if (port_window) {
+			d->ccr |= CCR_SRC_AMODE_DBLIDX;
+			d->ei = 1;
+			/*
+			 * One frame covers the port_window and by  configure
+			 * the source frame index to be -1 * (port_window - 1)
+			 * we instruct the sDMA that after a frame is processed
+			 * it should move back to the start of the window.
+			 */
+			d->fi = -(port_window_bytes - 1);
+
+			if (port_window_bytes >= 64)
+				d->csdp = CSDP_SRC_BURST_64 | CSDP_SRC_PACKED;
+			else if (port_window_bytes >= 32)
+				d->csdp = CSDP_SRC_BURST_32 | CSDP_SRC_PACKED;
+			else if (port_window_bytes >= 16)
+				d->csdp = CSDP_SRC_BURST_16 | CSDP_SRC_PACKED;
+		} else {
+			d->ccr |= CCR_SRC_AMODE_CONSTANT;
+		}
 	} else {
-		d->ccr |= CCR_DST_AMODE_CONSTANT | CCR_SRC_AMODE_POSTINC;
 		d->csdp = CSDP_SRC_BURST_64 | CSDP_SRC_PACKED;
+
+		d->ccr |= CCR_SRC_AMODE_POSTINC;
+		if (port_window) {
+			d->ccr |= CCR_DST_AMODE_DBLIDX;
+
+			if (port_window_bytes >= 64)
+				d->csdp = CSDP_DST_BURST_64 | CSDP_DST_PACKED;
+			else if (port_window_bytes >= 32)
+				d->csdp = CSDP_DST_BURST_32 | CSDP_DST_PACKED;
+			else if (port_window_bytes >= 16)
+				d->csdp = CSDP_DST_BURST_16 | CSDP_DST_PACKED;
+		} else {
+			d->ccr |= CCR_DST_AMODE_CONSTANT;
+		}
 	}
 
 	d->cicr = CICR_DROP_IE | CICR_BLOCK_IE;
@@ -943,6 +989,9 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 			d->ccr |= CCR_TRIGGER_SRC;
 
 		d->cicr |= CICR_MISALIGNED_ERR_IE | CICR_TRANS_ERR_IE;
+
+		if (port_window)
+			d->csdp |= CSDP_WRITE_LAST_NON_POSTED;
 	}
 	if (od->plat->errata & DMA_ERRATA_PARALLEL_CHANNELS)
 		d->clnk_ctrl = c->dma_ch;
@@ -968,6 +1017,16 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 		osg->addr = sg_dma_address(sgent);
 		osg->en = en;
 		osg->fn = sg_dma_len(sgent) / frame_bytes;
+		if (port_window && dir == DMA_MEM_TO_DEV) {
+			osg->ei = 1;
+			/*
+			 * One frame covers the port_window and by  configure
+			 * the source frame index to be -1 * (port_window - 1)
+			 * we instruct the sDMA that after a frame is processed
+			 * it should move back to the start of the window.
+			 */
+			osg->fi = -(port_window_bytes - 1);
+		}
 
 		if (d->using_ll) {
 			osg->t2_desc = dma_pool_alloc(od->desc_pool, GFP_ATOMIC,
-- 
2.11.0.rc2
