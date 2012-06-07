From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 2/2] dmaengine: sa11x0-dma: add cyclic DMA support
Date: Thu, 07 Jun 2012 11:43:25 +0100
Message-ID: <E1ScaBZ-0003c5-F2@rmk-PC.arm.linux.org.uk>
References: <20120607104206.GA10488@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54140 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507Ab2FGKnc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:43:32 -0400
In-Reply-To: <20120607104206.GA10488@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Add support for cyclic DMA on sa11x0 platforms.  This follows the
discussed behaviour that the callback will be called at some point
after period expires, and may coalesce multiple period expiries into
one callback (due to the tasklet behaviour.)

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/sa11x0-dma.c |  108 +++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 92 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index db4fcbd..f5a7360 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -78,6 +78,8 @@ struct sa11x0_dma_desc {
 
 	u32			ddar;
 	size_t			size;
+	unsigned		period;
+	bool			cyclic;
 
 	unsigned		sglen;
 	struct sa11x0_dma_sg	sg[0];
@@ -178,19 +180,24 @@ static void noinline sa11x0_dma_start_sg(struct sa11x0_dma_phy *p,
 		return;
 
 	if (p->sg_load == txd->sglen) {
-		struct sa11x0_dma_desc *txn = sa11x0_dma_next_desc(c);
+		if (!txd->cyclic) {
+			struct sa11x0_dma_desc *txn = sa11x0_dma_next_desc(c);
 
-		/*
-		 * We have reached the end of the current descriptor.
-		 * Peek at the next descriptor, and if compatible with
-		 * the current, start processing it.
-		 */
-		if (txn && txn->ddar == txd->ddar) {
-			txd = txn;
-			sa11x0_dma_start_desc(p, txn);
+			/*
+			 * We have reached the end of the current descriptor.
+			 * Peek at the next descriptor, and if compatible with
+			 * the current, start processing it.
+			 */
+			if (txn && txn->ddar == txd->ddar) {
+				txd = txn;
+				sa11x0_dma_start_desc(p, txn);
+			} else {
+				p->txd_load = NULL;
+				return;
+			}
 		} else {
-			p->txd_load = NULL;
-			return;
+			/* Cyclic: reset back to beginning */
+			p->sg_load = 0;
 		}
 	}
 
@@ -224,13 +231,21 @@ static void noinline sa11x0_dma_complete(struct sa11x0_dma_phy *p,
 	struct sa11x0_dma_desc *txd = p->txd_done;
 
 	if (++p->sg_done == txd->sglen) {
-		vchan_cookie_complete(&txd->vd);
+		if (!txd->cyclic) {
+			vchan_cookie_complete(&txd->vd);
 
-		p->sg_done = 0;
-		p->txd_done = p->txd_load;
+			p->sg_done = 0;
+			p->txd_done = p->txd_load;
+
+			if (!p->txd_done)
+				tasklet_schedule(&p->dev->task);
+		} else {
+			if ((p->sg_done % txd->period) == 0)
+				vchan_cyclic_callback(&txd->vd);
 
-		if (!p->txd_done)
-			tasklet_schedule(&p->dev->task);
+			/* Cyclic: reset back to beginning */
+			p->sg_done = 0;
+		}
 	}
 
 	sa11x0_dma_start_sg(p, c);
@@ -597,6 +612,65 @@ static struct dma_async_tx_descriptor *sa11x0_dma_prep_slave_sg(
 	return vchan_tx_prep(&c->vc, &txd->vd, flags);
 }
 
+static struct dma_async_tx_descriptor *sa11x0_dma_prep_dma_cyclic(
+	struct dma_chan *chan, dma_addr_t addr, size_t size, size_t period,
+	enum dma_transfer_direction dir, void *context)
+{
+	struct sa11x0_dma_chan *c = to_sa11x0_dma_chan(chan);
+	struct sa11x0_dma_desc *txd;
+	unsigned i, j, k, sglen, sgperiod;
+
+	/* SA11x0 channels can only operate in their native direction */
+	if (dir != (c->ddar & DDAR_RW ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV)) {
+		dev_err(chan->device->dev, "vchan %p: bad DMA direction: DDAR:%08x dir:%u\n",
+			&c->vc, c->ddar, dir);
+		return NULL;
+	}
+
+	sgperiod = DIV_ROUND_UP(period, DMA_MAX_SIZE & ~DMA_ALIGN);
+	sglen = size * sgperiod / period;
+
+	/* Do not allow zero-sized txds */
+	if (sglen == 0)
+		return NULL;
+
+	txd = kzalloc(sizeof(*txd) + sglen * sizeof(txd->sg[0]), GFP_ATOMIC);
+	if (!txd) {
+		dev_dbg(chan->device->dev, "vchan %p: kzalloc failed\n", &c->vc);
+		return NULL;
+	}
+
+	for (i = k = 0; i < size / period; i++) {
+		size_t tlen, len = period;
+
+		for (j = 0; j < sgperiod; j++, k++) {
+			tlen = len;
+
+			if (tlen > DMA_MAX_SIZE) {
+				unsigned mult = DIV_ROUND_UP(tlen, DMA_MAX_SIZE & ~DMA_ALIGN);
+				tlen = (tlen / mult) & ~DMA_ALIGN;
+			}
+
+			txd->sg[k].addr = addr;
+			txd->sg[k].len = tlen;
+			addr += tlen;
+			len -= tlen;
+		}
+
+		WARN_ON(len != 0);
+	}
+
+	WARN_ON(k != sglen);
+
+	txd->ddar = c->ddar;
+	txd->size = size;
+	txd->sglen = sglen;
+	txd->cyclic = 1;
+	txd->period = sgperiod;
+
+	return vchan_tx_prep(&c->vc, &txd->vd, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+}
+
 static int sa11x0_dma_slave_config(struct sa11x0_dma_chan *c, struct dma_slave_config *cfg)
 {
 	u32 ddar = c->ddar & ((0xf << 4) | DDAR_RW);
@@ -867,7 +941,9 @@ static int __devinit sa11x0_dma_probe(struct platform_device *pdev)
 	}
 
 	dma_cap_set(DMA_SLAVE, d->slave.cap_mask);
+	dma_cap_set(DMA_CYCLIC, d->slave.cap_mask);
 	d->slave.device_prep_slave_sg = sa11x0_dma_prep_slave_sg;
+	d->slave.device_prep_dma_cyclic = sa11x0_dma_prep_dma_cyclic;
 	ret = sa11x0_dma_init_dmadev(&d->slave, &pdev->dev);
 	if (ret) {
 		dev_warn(d->slave.dev, "failed to register slave async device: %d\n",
-- 
1.7.4.4

