From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 1/3] dmaengine: omap: add support for returning residue in
 tx_state method
Date: Fri, 22 Jun 2012 10:01:13 +0100
Message-ID: <E1Shzjt-0004h4-U7@rmk-PC.arm.linux.org.uk>
References: <20120622085911.GA19026@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60365 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761756Ab2FVJBQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jun 2012 05:01:16 -0400
In-Reply-To: <20120622085911.GA19026@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Add support for returning the residue for a particular descriptor by
reading the current DMA address for the source or destination side of
the transfer as appropriate, and walking the scatterlist until we find
an entry containing the current DMA address.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c |   69 ++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 47d5e63..62b6a2b 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -194,14 +194,73 @@ static void omap_dma_free_chan_resources(struct dma_chan *chan)
 	dev_info(c->vc.chan.device->dev, "freeing channel for %u\n", c->dma_sig);
 }
 
+static size_t omap_dma_sg_size(struct omap_sg *sg)
+{
+	return sg->en * sg->fn;
+}
+
+static size_t omap_dma_desc_size(struct omap_desc *d)
+{
+	unsigned i;
+	size_t size;
+
+	for (size = i = 0; i < d->sglen; i++)
+		size += omap_dma_sg_size(&d->sg[i]);
+
+	return size * es_bytes[d->es];
+}
+
+static size_t omap_dma_desc_size_pos(struct omap_desc *d, dma_addr_t addr)
+{
+	unsigned i;
+	size_t size, es_size = es_bytes[d->es];
+
+	for (size = i = 0; i < d->sglen; i++) {
+		size_t this_size = omap_dma_sg_size(&d->sg[i]) * es_size;
+
+		if (size)
+			size += this_size;
+		else if (addr >= d->sg[i].addr &&
+			 addr < d->sg[i].addr + this_size)
+			size += d->sg[i].addr + this_size - addr;
+	}
+	return size;
+}
+
 static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
 	dma_cookie_t cookie, struct dma_tx_state *txstate)
 {
-	/*
-	 * FIXME: do we need to return pending bytes?
-	 * We have no users of that info at the moment...
-	 */
-	return dma_cookie_status(chan, cookie, txstate);
+	struct omap_chan *c = to_omap_dma_chan(chan);
+	struct virt_dma_desc *vd;
+	enum dma_status ret;
+	unsigned long flags;
+
+	ret = dma_cookie_status(chan, cookie, txstate);
+	if (ret == DMA_SUCCESS || !txstate)
+		return ret;
+
+	spin_lock_irqsave(&c->vc.lock, flags);
+	vd = vchan_find_desc(&c->vc, cookie);
+	if (vd) {
+		txstate->residue = omap_dma_desc_size(to_omap_dma_desc(&vd->tx));
+	} else if (c->desc && c->desc->vd.tx.cookie == cookie) {
+		struct omap_desc *d = c->desc;
+		dma_addr_t pos;
+
+		if (d->dir == DMA_MEM_TO_DEV)
+			pos = omap_get_dma_src_pos(c->dma_ch);
+		else if (d->dir == DMA_DEV_TO_MEM)
+			pos = omap_get_dma_dst_pos(c->dma_ch);
+		else
+			pos = 0;
+
+		txstate->residue = omap_dma_desc_size_pos(d, pos);
+	} else {
+		txstate->residue = 0;
+	}
+	spin_unlock_irqrestore(&c->vc.lock, flags);
+
+	return ret;
 }
 
 static void omap_dma_issue_pending(struct dma_chan *chan)
-- 
1.7.4.4

