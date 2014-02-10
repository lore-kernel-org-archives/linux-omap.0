From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 13/26] dmaengine: omap-dma: move clnk_ctrl setting to
 preparation functions
Date: Mon, 10 Feb 2014 15:56:59 +0000
Message-ID: <E1WCtEB-0006Ws-Ow@rmk-PC.arm.linux.org.uk>
References: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:60051 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752474AbaBJP5B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Feb 2014 10:57:01 -0500
In-Reply-To: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Move the clnk_ctrl setup to the preparation functions, saving its
value in the omap_desc.  This only needs to be set once per descriptor,
not for each segment, so set it in omap_dma_start_desc() rather than
omap_dma_start().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 06727a78e883..49609275b2e7 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -59,6 +59,7 @@ struct omap_desc {
 	int16_t fi;		/* for OMAP_DMA_SYNC_PACKET */
 	uint8_t es;		/* CSDP_DATA_TYPE_xxx */
 	uint32_t ccr;		/* CCR value */
+	uint16_t clnk_ctrl;	/* CLNK_CTRL value */
 	uint16_t cicr;		/* CICR value */
 	uint32_t csdp;		/* CSDP value */
 
@@ -187,18 +188,6 @@ static void omap_dma_start(struct omap_chan *c, struct omap_desc *d)
 	else
 		c->plat->dma_write(0, CDAC, c->dma_ch);
 
-	if (!__dma_omap15xx(od->plat->dma_attr) && c->cyclic) {
-		val = c->plat->dma_read(CLNK_CTRL, c->dma_ch);
-
-		if (dma_omap1())
-			val &= ~(1 << 14);
-
-		val |= c->dma_ch | CLNK_CTRL_ENABLE_LNK;
-
-		c->plat->dma_write(val, CLNK_CTRL, c->dma_ch);
-	} else if (od->plat->errata & DMA_ERRATA_PARALLEL_CHANNELS)
-		c->plat->dma_write(c->dma_ch, CLNK_CTRL, c->dma_ch);
-
 	omap_dma_clear_csr(c);
 
 	/* Enable interrupts */
@@ -330,6 +319,7 @@ static void omap_dma_start_desc(struct omap_chan *c)
 	c->plat->dma_write(0, cxei, c->dma_ch);
 	c->plat->dma_write(d->fi, cxfi, c->dma_ch);
 	c->plat->dma_write(d->csdp, CSDP, c->dma_ch);
+	c->plat->dma_write(d->clnk_ctrl, CLNK_CTRL, c->dma_ch);
 
 	omap_dma_start_sg(c, d, 0);
 }
@@ -645,6 +635,8 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 	}
 	if (od->plat->errata & DMA_ERRATA_IFRAME_BUFFERING)
 		d->ccr |= CCR_BUFFERING_DISABLE;
+	if (od->plat->errata & DMA_ERRATA_PARALLEL_CHANNELS)
+		d->clnk_ctrl = c->dma_ch;
 
 	/*
 	 * Build our scatterlist entries: each contains the address,
@@ -725,8 +717,6 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
 	d->sglen = 1;
 
 	d->ccr = 0;
-	if (__dma_omap15xx(od->plat->dma_attr))
-		d->ccr = CCR_AUTO_INIT | CCR_REPEAT;
 	if (dir == DMA_DEV_TO_MEM)
 		d->ccr |= CCR_DST_AMODE_POSTINC | CCR_SRC_AMODE_CONSTANT;
 	else
@@ -772,6 +762,11 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
 	if (od->plat->errata & DMA_ERRATA_IFRAME_BUFFERING)
 		d->ccr |= CCR_BUFFERING_DISABLE;
 
+	if (__dma_omap15xx(od->plat->dma_attr))
+		d->ccr |= CCR_AUTO_INIT | CCR_REPEAT;
+	else
+		d->clnk_ctrl = c->dma_ch | CLNK_CTRL_ENABLE_LNK;
+
 	c->cyclic = true;
 
 	return vchan_tx_prep(&c->vc, &d->vd, flags);
-- 
1.8.3.1

