From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] dmaengine: omap-dma: Add support for memcpy
Date: Wed, 22 Apr 2015 10:34:29 +0300
Message-ID: <1429688069-31765-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, linux@arm.linux.org.uk
Cc: tony@atomide.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dan.j.williams@intel.com
List-Id: linux-omap@vger.kernel.org

The sDMA controller is capable of performing memory copy operation. It need
to be configured to software triggered mode and without HW synchronization.
The sDMA can copy data which is aligned to 8, 16 or 32 bits.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/omap-dma.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 36e6a299af5c..1dfc71c90123 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -366,7 +366,7 @@ static void omap_dma_start_sg(struct omap_chan *c, struct omap_desc *d,
 	struct omap_sg *sg = d->sg + idx;
 	unsigned cxsa, cxei, cxfi;
 
-	if (d->dir == DMA_DEV_TO_MEM) {
+	if (d->dir == DMA_DEV_TO_MEM || d->dir == DMA_MEM_TO_MEM) {
 		cxsa = CDSA;
 		cxei = CDEI;
 		cxfi = CDFI;
@@ -412,7 +412,7 @@ static void omap_dma_start_desc(struct omap_chan *c)
 	if (dma_omap1())
 		omap_dma_chan_write(c, CCR2, d->ccr >> 16);
 
-	if (d->dir == DMA_DEV_TO_MEM) {
+	if (d->dir == DMA_DEV_TO_MEM || d->dir == DMA_MEM_TO_MEM) {
 		cxsa = CSSA;
 		cxei = CSEI;
 		cxfi = CSFI;
@@ -957,6 +957,51 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
 	return vchan_tx_prep(&c->vc, &d->vd, flags);
 }
 
+static struct dma_async_tx_descriptor *omap_dma_prep_dma_memcpy(
+	struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
+	size_t len, unsigned long tx_flags)
+{
+	struct omap_chan *c = to_omap_dma_chan(chan);
+	struct omap_desc *d;
+	uint8_t data_type;
+
+	d = kzalloc(sizeof(*d) + sizeof(d->sg[0]), GFP_ATOMIC);
+	if (!d)
+		return NULL;
+
+	data_type = __ffs((src | dest | len));
+	if (data_type > CSDP_DATA_TYPE_32)
+		data_type = CSDP_DATA_TYPE_32;
+
+	d->dir = DMA_MEM_TO_MEM;
+	d->dev_addr = src;
+	d->fi = 0;
+	d->es = data_type;
+	d->sg[0].en = len / BIT(data_type);
+	d->sg[0].fn = 1;
+	d->sg[0].addr = dest;
+	d->sglen = 1;
+	d->ccr = c->ccr;
+	d->ccr |= CCR_DST_AMODE_POSTINC | CCR_SRC_AMODE_POSTINC;
+
+	d->cicr = CICR_DROP_IE;
+	if (tx_flags & DMA_PREP_INTERRUPT)
+		d->cicr |= CICR_FRAME_IE;
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
+	return vchan_tx_prep(&c->vc, &d->vd, tx_flags);
+}
+
 static int omap_dma_slave_config(struct dma_chan *chan, struct dma_slave_config *cfg)
 {
 	struct omap_chan *c = to_omap_dma_chan(chan);
@@ -1102,12 +1147,14 @@ static int omap_dma_probe(struct platform_device *pdev)
 
 	dma_cap_set(DMA_SLAVE, od->ddev.cap_mask);
 	dma_cap_set(DMA_CYCLIC, od->ddev.cap_mask);
+	dma_cap_set(DMA_MEMCPY, od->ddev.cap_mask);
 	od->ddev.device_alloc_chan_resources = omap_dma_alloc_chan_resources;
 	od->ddev.device_free_chan_resources = omap_dma_free_chan_resources;
 	od->ddev.device_tx_status = omap_dma_tx_status;
 	od->ddev.device_issue_pending = omap_dma_issue_pending;
 	od->ddev.device_prep_slave_sg = omap_dma_prep_slave_sg;
 	od->ddev.device_prep_dma_cyclic = omap_dma_prep_dma_cyclic;
+	od->ddev.device_prep_dma_memcpy = omap_dma_prep_dma_memcpy;
 	od->ddev.device_config = omap_dma_slave_config;
 	od->ddev.device_pause = omap_dma_pause;
 	od->ddev.device_resume = omap_dma_resume;
-- 
2.3.5
