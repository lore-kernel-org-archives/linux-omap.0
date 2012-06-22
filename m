From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 3/3] dmaengine: omap: add support for cyclic DMA
Date: Fri, 22 Jun 2012 10:01:54 +0100
Message-ID: <E1ShzkY-0004hC-7Y@rmk-PC.arm.linux.org.uk>
References: <20120622085911.GA19026@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60377 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932127Ab2FVJB4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jun 2012 05:01:56 -0400
In-Reply-To: <20120622085911.GA19026@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Add support for cyclic DMA to the OMAP DMA engine driver.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c |   93 +++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 89 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index e1a326d..dae9c2c 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -33,6 +33,7 @@ struct omap_chan {
 
 	struct dma_slave_config	cfg;
 	unsigned dma_sig;
+	bool cyclic;
 
 	int dma_ch;
 	struct omap_desc *desc;
@@ -138,11 +139,15 @@ static void omap_dma_callback(int ch, u16 status, void *data)
 	spin_lock_irqsave(&c->vc.lock, flags);
 	d = c->desc;
 	if (d) {
-		if (++c->sgidx < d->sglen) {
-			omap_dma_start_sg(c, d, c->sgidx);
+		if (!c->cyclic) {
+			if (++c->sgidx < d->sglen) {
+				omap_dma_start_sg(c, d, c->sgidx);
+			} else {
+				omap_dma_start_desc(c);
+				vchan_cookie_complete(&d->vd);
+			}
 		} else {
-			omap_dma_start_desc(c);
-			vchan_cookie_complete(&d->vd);
+			vchan_cyclic_callback(&d->vd);
 		}
 	}
 	spin_unlock_irqrestore(&c->vc.lock, flags);
@@ -358,6 +363,79 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 	return vchan_tx_prep(&c->vc, &d->vd, tx_flags);
 }
 
+static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
+	struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
+	size_t period_len, enum dma_transfer_direction dir, void *context)
+{
+	struct omap_chan *c = to_omap_dma_chan(chan);
+	enum dma_slave_buswidth dev_width;
+	struct omap_desc *d;
+	dma_addr_t dev_addr;
+	unsigned es, sync_type;
+	u32 burst;
+
+	if (dir == DMA_DEV_TO_MEM) {
+		dev_addr = c->cfg.src_addr;
+		dev_width = c->cfg.src_addr_width;
+		burst = c->cfg.src_maxburst;
+		sync_type = OMAP_DMA_SRC_SYNC;
+	} else if (dir == DMA_MEM_TO_DEV) {
+		dev_addr = c->cfg.dst_addr;
+		dev_width = c->cfg.dst_addr_width;
+		burst = c->cfg.dst_maxburst;
+		sync_type = OMAP_DMA_DST_SYNC;
+	} else {
+		dev_err(chan->device->dev, "%s: bad direction?\n", __func__);
+		return NULL;
+	}
+
+	/* Bus width translates to the element size (ES) */
+	switch (dev_width) {
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+		es = OMAP_DMA_DATA_TYPE_S8;
+		break;
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+		es = OMAP_DMA_DATA_TYPE_S16;
+		break;
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+		es = OMAP_DMA_DATA_TYPE_S32;
+		break;
+	default: /* not reached */
+		return NULL;
+	}
+
+	/* Now allocate and setup the descriptor. */
+	d = kzalloc(sizeof(*d) + sizeof(d->sg[0]), GFP_ATOMIC);
+	if (!d)
+		return NULL;
+
+	d->dir = dir;
+	d->dev_addr = dev_addr;
+	d->fi = burst;
+	d->es = es;
+	d->sync_mode = OMAP_DMA_SYNC_PACKET;
+	d->sync_type = sync_type;
+	d->periph_port = OMAP_DMA_PORT_MPUI;
+	d->sg[0].addr = buf_addr;
+	d->sg[0].en = period_len / es_bytes[es];
+	d->sg[0].fn = buf_len / period_len;
+	d->sglen = 1;
+
+	if (!c->cyclic) {
+		c->cyclic = true;
+		omap_dma_link_lch(c->dma_ch, c->dma_ch);
+		omap_enable_dma_irq(c->dma_ch, OMAP_DMA_FRAME_IRQ);
+		omap_disable_dma_irq(c->dma_ch, OMAP_DMA_BLOCK_IRQ);
+	}
+
+	if (!cpu_class_is_omap1()) {
+		omap_set_dma_src_burst_mode(c->dma_ch, OMAP_DMA_DATA_BURST_16);
+		omap_set_dma_dest_burst_mode(c->dma_ch, OMAP_DMA_DATA_BURST_16);
+	}
+
+	return vchan_tx_prep(&c->vc, &d->vd, DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+}
+
 static int omap_dma_slave_config(struct omap_chan *c, struct dma_slave_config *cfg)
 {
 	if (cfg->src_addr_width == DMA_SLAVE_BUSWIDTH_8_BYTES ||
@@ -392,6 +470,11 @@ static int omap_dma_terminate_all(struct omap_chan *c)
 		omap_stop_dma(c->dma_ch);
 	}
 
+	if (c->cyclic) {
+		c->cyclic = false;
+		omap_dma_unlink_lch(c->dma_ch, c->dma_ch);
+	}
+
 	vchan_get_all_descriptors(&c->vc, &head);
 	spin_unlock_irqrestore(&c->vc.lock, flags);
 	vchan_dma_desc_free_list(&c->vc, &head);
@@ -484,11 +567,13 @@ static int omap_dma_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dma_cap_set(DMA_SLAVE, od->ddev.cap_mask);
+	dma_cap_set(DMA_CYCLIC, od->ddev.cap_mask);
 	od->ddev.device_alloc_chan_resources = omap_dma_alloc_chan_resources;
 	od->ddev.device_free_chan_resources = omap_dma_free_chan_resources;
 	od->ddev.device_tx_status = omap_dma_tx_status;
 	od->ddev.device_issue_pending = omap_dma_issue_pending;
 	od->ddev.device_prep_slave_sg = omap_dma_prep_slave_sg;
+	od->ddev.device_prep_dma_cyclic = omap_dma_prep_dma_cyclic;
 	od->ddev.device_control = omap_dma_control;
 	od->ddev.dev = &pdev->dev;
 	INIT_LIST_HEAD(&od->ddev.channels);
-- 
1.7.4.4

