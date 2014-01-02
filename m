From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 13/26] dmaengine: omap-dma: move clnk_ctrl setting to
 preparation functions
Date: Thu, 02 Jan 2014 15:11:01 +0000
Message-ID: <E1VyjvJ-0005En-2c@rmk-PC.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:54169 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751620AbaABPO7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jan 2014 10:14:59 -0500
In-Reply-To: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

Move the clnk_ctrl setup to the preparation functions, saving its
value in the omap_desc.  This only needs to be set once per descriptor,
not for each segment, so set it in omap_dma_start_desc() rather than
omap_dma_start().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c |   23 +++++++++--------------
 1 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index b4700e1f7c57..bdea85802b5b 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -59,6 +59,7 @@ struct omap_desc {
 	int16_t fi;		/* for OMAP_DMA_SYNC_PACKET */
 	uint8_t es;		/* CSDP_DATA_TYPE_xxx */
 	uint32_t ccr;		/* CCR value */
+	uint16_t clnk_ctrl;	/* CLNK_CTRL value */
 	uint16_t cicr;		/* CICR value */
 	uint32_t csdp;		/* CSDP value */
 
@@ -186,18 +187,6 @@ static void omap_dma_start(struct omap_chan *c, struct omap_desc *d)
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
@@ -637,6 +627,8 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 	}
 	if (od->plat->errata & DMA_ERRATA_IFRAME_BUFFERING)
 		d->ccr |= CCR_BUFFERING_DISABLE;
+	if (od->plat->errata & DMA_ERRATA_PARALLEL_CHANNELS)
+		d->clnk_ctrl = c->dma_ch;
 
 	/*
 	 * Build our scatterlist entries: each contains the address,
@@ -717,8 +709,6 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
 	d->sglen = 1;
 
 	d->ccr = 0;
-	if (__dma_omap15xx(od->plat->dma_attr))
-		d->ccr = CCR_AUTO_INIT | CCR_REPEAT;
 	if (dir == DMA_DEV_TO_MEM)
 		d->ccr |= CCR_DST_AMODE_POSTINC | CCR_SRC_AMODE_CONSTANT;
 	else
@@ -756,6 +746,11 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
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
1.7.4.4

