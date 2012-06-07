From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [CFT 1/2] dmaengine: sa11x0-dma: fix DMA residue support
Date: Thu, 07 Jun 2012 11:43:05 +0100
Message-ID: <E1ScaBF-0003bw-6g@rmk-PC.arm.linux.org.uk>
References: <20120607104206.GA10488@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54135 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759434Ab2FGKnK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 06:43:10 -0400
In-Reply-To: <20120607104206.GA10488@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

The semantics now implemented are:

- If the cookie has completed successfully, the residue will be zero.
- If the cookie is in progress or the channel is paused, it will be the
  number of bytes yet to be transferred. [*]
- If the cookie is queued, it will be the number of bytes in the
  descriptor.

* - where this is the number of bytes yet to be transferred to/from
  RAM.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/sa11x0-dma.c |   45 +++++++++++++++++++++++++++++----------------
 1 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index 5f1d2e6..db4fcbd 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -416,27 +416,47 @@ static enum dma_status sa11x0_dma_tx_status(struct dma_chan *chan,
 	struct sa11x0_dma_chan *c = to_sa11x0_dma_chan(chan);
 	struct sa11x0_dma_dev *d = to_sa11x0_dma(chan->device);
 	struct sa11x0_dma_phy *p;
-	struct sa11x0_dma_desc *txd;
+	struct virt_dma_desc *vd;
 	unsigned long flags;
 	enum dma_status ret;
-	size_t bytes = 0;
 
 	ret = dma_cookie_status(&c->vc.chan, cookie, state);
 	if (ret == DMA_SUCCESS)
 		return ret;
 
+	if (!state)
+		return c->status;
+
 	spin_lock_irqsave(&c->vc.lock, flags);
 	p = c->phy;
-	ret = c->status;
-	if (p) {
-		dma_addr_t addr = sa11x0_dma_pos(p);
 
-		dev_vdbg(d->slave.dev, "tx_status: addr:%x\n", addr);
+	/*
+	 * If the cookie is on our issue queue, then the residue is
+	 * its total size.
+	 */
+	vd = vchan_find_desc(&c->vc, cookie);
+	if (vd) {
+		state->residue = container_of(vd, struct sa11x0_dma_desc, vd)->size;
+	} else if (!p) {
+		state->residue = 0;
+	} else {
+		struct sa11x0_dma_desc *txd;
+		size_t bytes = 0;
+
+		if (p->txd_done && p->txd_done->vd.tx.cookie == cookie)
+			txd = p->txd_done;
+		else if (p->txd_load && p->txd_load->vd.tx.cookie == cookie)
+			txd = p->txd_load;
+		else
+			txd = NULL;
 
-		txd = p->txd_done;
+		ret = c->status;
 		if (txd) {
+			dma_addr_t addr = sa11x0_dma_pos(p);
 			unsigned i;
 
+			dev_vdbg(d->slave.dev, "tx_status: addr:%x\n", addr);
+
 			for (i = 0; i < txd->sglen; i++) {
 				dev_vdbg(d->slave.dev, "tx_status: [%u] %x+%x\n",
 					i, txd->sg[i].addr, txd->sg[i].len);
@@ -459,18 +479,11 @@ static enum dma_status sa11x0_dma_tx_status(struct dma_chan *chan,
 				bytes += txd->sg[i].len;
 			}
 		}
-		if (txd != p->txd_load && p->txd_load)
-			bytes += p->txd_load->size;
-	}
-	list_for_each_entry(txd, &c->vc.desc_issued, vd.node) {
-		bytes += txd->size;
+		state->residue = bytes;
 	}
 	spin_unlock_irqrestore(&c->vc.lock, flags);
 
-	if (state)
-		state->residue = bytes;
-
-	dev_vdbg(d->slave.dev, "tx_status: bytes 0x%zx\n", bytes);
+	dev_vdbg(d->slave.dev, "tx_status: bytes 0x%zx\n", state->residue);
 
 	return ret;
 }
-- 
1.7.4.4

