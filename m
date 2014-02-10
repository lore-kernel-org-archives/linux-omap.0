From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 26/26] dmaengine: omap-dma: more consolidation of CCR register
 setup
Date: Mon, 10 Feb 2014 15:58:06 +0000
Message-ID: <E1WCtFG-0006Xn-9O@rmk-PC.arm.linux.org.uk>
References: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:60112 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752985AbaBJP6I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Feb 2014 10:58:08 -0500
In-Reply-To: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

We can move the handling of the DMA synchronisation control out of the
prepare functions; this can be pre-calculated when the DMA channel has
been allocated, so we don't need to duplicate this in both prepare
functions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c | 46 ++++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index ec98e718de70..64ceca2920b8 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -41,6 +41,7 @@ struct omap_chan {
 	struct list_head node;
 	void __iomem *channel_base;
 	const struct omap_dma_reg *reg_map;
+	uint32_t ccr;
 
 	struct dma_slave_config	cfg;
 	unsigned dma_sig;
@@ -552,6 +553,21 @@ static int omap_dma_alloc_chan_resources(struct dma_chan *chan)
 		}
 	}
 
+	if (dma_omap1()) {
+		if (__dma_omap16xx(od->plat->dma_attr)) {
+			c->ccr = CCR_OMAP31_DISABLE;
+			/* Duplicate what plat-omap/dma.c does */
+			c->ccr |= c->dma_ch + 1;
+		} else {
+			c->ccr = c->dma_sig & 0x1f;
+		}
+	} else {
+		c->ccr = c->dma_sig & 0x1f;
+		c->ccr |= (c->dma_sig & ~0x1f) << 14;
+	}
+	if (od->plat->errata & DMA_ERRATA_IFRAME_BUFFERING)
+		c->ccr |= CCR_BUFFERING_DISABLE;
+
 	return ret;
 }
 
@@ -787,7 +803,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 	d->dev_addr = dev_addr;
 	d->es = es;
 
-	d->ccr = CCR_SYNC_FRAME;
+	d->ccr = c->ccr | CCR_SYNC_FRAME;
 	if (dir == DMA_DEV_TO_MEM)
 		d->ccr |= CCR_DST_AMODE_POSTINC | CCR_SRC_AMODE_CONSTANT;
 	else
@@ -797,14 +813,6 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 	d->csdp = es;
 
 	if (dma_omap1()) {
-		if (__dma_omap16xx(od->plat->dma_attr)) {
-			d->ccr |= CCR_OMAP31_DISABLE;
-			/* Duplicate what plat-omap/dma.c does */
-			d->ccr |= c->dma_ch + 1;
-		} else {
-			d->ccr |= c->dma_sig & 0x1f;
-		}
-
 		d->cicr |= CICR_TOUT_IE;
 
 		if (dir == DMA_DEV_TO_MEM)
@@ -812,16 +820,11 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 		else
 			d->csdp |= CSDP_DST_PORT_TIPB | CSDP_SRC_PORT_EMIFF;
 	} else {
-		d->ccr |= (c->dma_sig & ~0x1f) << 14;
-		d->ccr |= c->dma_sig & 0x1f;
-
 		if (dir == DMA_DEV_TO_MEM)
 			d->ccr |= CCR_TRIGGER_SRC;
 
 		d->cicr |= CICR_MISALIGNED_ERR_IE | CICR_TRANS_ERR_IE;
 	}
-	if (od->plat->errata & DMA_ERRATA_IFRAME_BUFFERING)
-		d->ccr |= CCR_BUFFERING_DISABLE;
 	if (od->plat->errata & DMA_ERRATA_PARALLEL_CHANNELS)
 		d->clnk_ctrl = c->dma_ch;
 
@@ -903,7 +906,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
 	d->sg[0].fn = buf_len / period_len;
 	d->sglen = 1;
 
-	d->ccr = 0;
+	d->ccr = c->ccr;
 	if (dir == DMA_DEV_TO_MEM)
 		d->ccr |= CCR_DST_AMODE_POSTINC | CCR_SRC_AMODE_CONSTANT;
 	else
@@ -916,14 +919,6 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
 	d->csdp = es;
 
 	if (dma_omap1()) {
-		if (__dma_omap16xx(od->plat->dma_attr)) {
-			d->ccr |= CCR_OMAP31_DISABLE;
-			/* Duplicate what plat-omap/dma.c does */
-			d->ccr |= c->dma_ch + 1;
-		} else {
-			d->ccr |= c->dma_sig & 0x1f;
-		}
-
 		d->cicr |= CICR_TOUT_IE;
 
 		if (dir == DMA_DEV_TO_MEM)
@@ -931,9 +926,6 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
 		else
 			d->csdp |= CSDP_DST_PORT_MPUI | CSDP_SRC_PORT_EMIFF;
 	} else {
-		d->ccr |= (c->dma_sig & ~0x1f) << 14;
-		d->ccr |= c->dma_sig & 0x1f;
-
 		if (burst)
 			d->ccr |= CCR_SYNC_PACKET;
 		else
@@ -946,8 +938,6 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
 
 		d->csdp |= CSDP_DST_BURST_64 | CSDP_SRC_BURST_64;
 	}
-	if (od->plat->errata & DMA_ERRATA_IFRAME_BUFFERING)
-		d->ccr |= CCR_BUFFERING_DISABLE;
 
 	if (__dma_omap15xx(od->plat->dma_attr))
 		d->ccr |= CCR_AUTO_INIT | CCR_REPEAT;
-- 
1.8.3.1

