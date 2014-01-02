From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 10/26] dmaengine: omap-dma: move CCR buffering disable
 errata out of the fast path
Date: Thu, 02 Jan 2014 15:10:30 +0000
Message-ID: <E1Vyjuo-0005Ea-O5@rmk-PC.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:54168 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751790AbaABPPB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jan 2014 10:15:01 -0500
In-Reply-To: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

Since we record the CCR register in the dma transaction, we can move the
processing of the iframe buffering errata out of the omap_dma_start().
Move it to the preparation functions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 13dca8e0ef32..ba0e10db5185 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -200,8 +200,6 @@ static void omap_dma_start(struct omap_chan *c, struct omap_desc *d)
 	c->plat->dma_write(d->cicr, CICR, c->dma_ch);
 
 	val = c->plat->dma_read(CCR, c->dma_ch);
-	if (od->plat->errata & DMA_ERRATA_IFRAME_BUFFERING)
-		val |= CCR_BUFFERING_DISABLE;
 	val |= CCR_ENABLE;
 	mb();
 	c->plat->dma_write(val, CCR, c->dma_ch);
@@ -558,6 +556,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 	struct dma_chan *chan, struct scatterlist *sgl, unsigned sglen,
 	enum dma_transfer_direction dir, unsigned long tx_flags, void *context)
 {
+	struct omap_dmadev *od = to_omap_dma_dev(chan->device);
 	struct omap_chan *c = to_omap_dma_chan(chan);
 	enum dma_slave_buswidth dev_width;
 	struct scatterlist *sgent;
@@ -628,6 +627,8 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 
 		d->cicr |= CICR_MISALIGNED_ERR_IE | CICR_TRANS_ERR_IE;
 	}
+	if (od->plat->errata & DMA_ERRATA_IFRAME_BUFFERING)
+		d->ccr |= CCR_BUFFERING_DISABLE;
 
 	/*
 	 * Build our scatterlist entries: each contains the address,
@@ -744,6 +745,8 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
 
 		d->csdp |= CSDP_DST_BURST_64 | CSDP_SRC_BURST_64;
 	}
+	if (od->plat->errata & DMA_ERRATA_IFRAME_BUFFERING)
+		d->ccr |= CCR_BUFFERING_DISABLE;
 
 	c->cyclic = true;
 
-- 
1.7.4.4

