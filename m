From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] dmaengine: omap-dma: Support for interleaved transfer
Date: Tue, 12 Jul 2016 14:21:14 +0300
Message-ID: <20160712112114.8478-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Initial support for interleaved transfer with sDMA.
The implementation only supports DMA_MEM_TO_MEM and frame_size must be 1.
sDMA needs to be configured for double indexing when ICG is needed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index f7498681be82..c026642fc66a 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -59,6 +59,8 @@ struct omap_sg {
 	dma_addr_t addr;
 	uint32_t en;		/* number of elements (24-bit) */
 	uint32_t fn;		/* number of frames (16-bit) */
+	int32_t fi;		/* for double indexing */
+	int16_t ei;		/* for double indexing */
 };
 
 struct omap_desc {
@@ -66,7 +68,8 @@ struct omap_desc {
 	enum dma_transfer_direction dir;
 	dma_addr_t dev_addr;
 
-	int16_t fi;		/* for OMAP_DMA_SYNC_PACKET */
+	int32_t fi;		/* for OMAP_DMA_SYNC_PACKET / double indexing */
+	int16_t ei;		/* for double indexing */
 	uint8_t es;		/* CSDP_DATA_TYPE_xxx */
 	uint32_t ccr;		/* CCR value */
 	uint16_t clnk_ctrl;	/* CLNK_CTRL value */
@@ -378,8 +381,8 @@ static void omap_dma_start_sg(struct omap_chan *c, struct omap_desc *d)
 	}
 
 	omap_dma_chan_write(c, cxsa, sg->addr);
-	omap_dma_chan_write(c, cxei, 0);
-	omap_dma_chan_write(c, cxfi, 0);
+	omap_dma_chan_write(c, cxei, sg->ei);
+	omap_dma_chan_write(c, cxfi, sg->fi);
 	omap_dma_chan_write(c, CEN, sg->en);
 	omap_dma_chan_write(c, CFN, sg->fn);
 
@@ -425,7 +428,7 @@ static void omap_dma_start_desc(struct omap_chan *c)
 	}
 
 	omap_dma_chan_write(c, cxsa, d->dev_addr);
-	omap_dma_chan_write(c, cxei, 0);
+	omap_dma_chan_write(c, cxei, d->ei);
 	omap_dma_chan_write(c, cxfi, d->fi);
 	omap_dma_chan_write(c, CSDP, d->csdp);
 	omap_dma_chan_write(c, CLNK_CTRL, d->clnk_ctrl);
@@ -969,6 +972,89 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_memcpy(
 	return vchan_tx_prep(&c->vc, &d->vd, tx_flags);
 }
 
+static struct dma_async_tx_descriptor *omap_dma_prep_dma_interleaved(
+	struct dma_chan *chan, struct dma_interleaved_template *xt,
+	unsigned long flags)
+{
+	struct omap_chan *c = to_omap_dma_chan(chan);
+	struct omap_desc *d;
+	struct omap_sg *sg;
+	uint8_t data_type;
+	size_t src_icg, dst_icg;
+
+	/* Slave mode is not supported */
+	if (is_slave_direction(xt->dir))
+		return NULL;
+
+	if (xt->frame_size != 1 || xt->numf == 0)
+		return NULL;
+
+	d = kzalloc(sizeof(*d) + sizeof(d->sg[0]), GFP_ATOMIC);
+	if (!d)
+		return NULL;
+
+	data_type = __ffs((xt->src_start | xt->dst_start | xt->sgl[0].size));
+	if (data_type > CSDP_DATA_TYPE_32)
+		data_type = CSDP_DATA_TYPE_32;
+
+	sg = &d->sg[0];
+	d->dir = DMA_MEM_TO_MEM;
+	d->dev_addr = xt->src_start;
+	d->es = data_type;
+	sg->en = xt->sgl[0].size / BIT(data_type);
+	sg->fn = xt->numf;
+	sg->addr = xt->dst_start;
+	d->sglen = 1;
+	d->ccr = c->ccr;
+
+	src_icg = dmaengine_get_src_icg(xt, &xt->sgl[0]);
+	dst_icg = dmaengine_get_dst_icg(xt, &xt->sgl[0]);
+	if (src_icg) {
+		d->ccr |= CCR_SRC_AMODE_DBLIDX;
+		d->ei = 1;
+		d->fi = src_icg;
+	} else if (xt->src_inc) {
+		d->ccr |= CCR_SRC_AMODE_POSTINC;
+		d->fi = 0;
+	} else {
+		dev_err(chan->device->dev,
+			"%s: SRC constant addressing is not supported\n",
+			__func__);
+		kfree(d);
+		return NULL;
+	}
+
+	if (dst_icg) {
+		d->ccr |= CCR_DST_AMODE_DBLIDX;
+		sg->ei = 1;
+		sg->fi = dst_icg;
+	} else if (xt->dst_inc) {
+		d->ccr |= CCR_DST_AMODE_POSTINC;
+		sg->fi = 0;
+	} else {
+		dev_err(chan->device->dev,
+			"%s: DST constant addressing is not supported\n",
+			__func__);
+		kfree(d);
+		return NULL;
+	}
+
+	d->cicr = CICR_DROP_IE | CICR_FRAME_IE;
+
+	d->csdp = data_type;
+
+	if (dma_omap1()) {
+		d->cicr |= CICR_TOUT_IE;
+		d->csdp |= CSDP_DST_PORT_EMIFF | CSDP_SRC_PORT_EMIFF;
+	} else {
+		d->csdp |= CSDP_DST_PACKED | CSDP_SRC_PACKED;
+		d->cicr |= CICR_MISALIGNED_ERR_IE | CICR_TRANS_ERR_IE;
+		d->csdp |= CSDP_DST_BURST_64 | CSDP_SRC_BURST_64;
+	}
+
+	return vchan_tx_prep(&c->vc, &d->vd, flags);
+}
+
 static int omap_dma_slave_config(struct dma_chan *chan, struct dma_slave_config *cfg)
 {
 	struct omap_chan *c = to_omap_dma_chan(chan);
@@ -1114,6 +1200,7 @@ static int omap_dma_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_SLAVE, od->ddev.cap_mask);
 	dma_cap_set(DMA_CYCLIC, od->ddev.cap_mask);
 	dma_cap_set(DMA_MEMCPY, od->ddev.cap_mask);
+	dma_cap_set(DMA_INTERLEAVE, od->ddev.cap_mask);
 	od->ddev.device_alloc_chan_resources = omap_dma_alloc_chan_resources;
 	od->ddev.device_free_chan_resources = omap_dma_free_chan_resources;
 	od->ddev.device_tx_status = omap_dma_tx_status;
@@ -1121,6 +1208,7 @@ static int omap_dma_probe(struct platform_device *pdev)
 	od->ddev.device_prep_slave_sg = omap_dma_prep_slave_sg;
 	od->ddev.device_prep_dma_cyclic = omap_dma_prep_dma_cyclic;
 	od->ddev.device_prep_dma_memcpy = omap_dma_prep_dma_memcpy;
+	od->ddev.device_prep_interleaved_dma = omap_dma_prep_dma_interleaved;
 	od->ddev.device_config = omap_dma_slave_config;
 	od->ddev.device_pause = omap_dma_pause;
 	od->ddev.device_resume = omap_dma_resume;
-- 
2.9.0
