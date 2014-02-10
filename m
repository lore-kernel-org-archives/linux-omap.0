From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 04/26] dmaengine: omap-dma: consolidate writes to DMA
 registers
Date: Mon, 10 Feb 2014 15:56:13 +0000
Message-ID: <E1WCtDR-0006WI-NH@rmk-PC.arm.linux.org.uk>
References: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:60006 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752781AbaBJP4Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Feb 2014 10:56:16 -0500
In-Reply-To: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

There's no need to keep writing registers which don't change value in
omap_dma_start_sg().  Move this into omap_dma_start_desc() and merge
the register updates together.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c | 123 +++++++++++++++++++------------------------------
 1 file changed, 48 insertions(+), 75 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 47a3fa5bc38e..8c5c862f01ed 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -99,40 +99,75 @@ static void omap_dma_start_sg(struct omap_chan *c, struct omap_desc *d,
 	unsigned idx)
 {
 	struct omap_sg *sg = d->sg + idx;
+
+	if (d->dir == DMA_DEV_TO_MEM) {
+		c->plat->dma_write(sg->addr, CDSA, c->dma_ch);
+		c->plat->dma_write(0, CDEI, c->dma_ch);
+		c->plat->dma_write(0, CDFI, c->dma_ch);
+	} else {
+		c->plat->dma_write(sg->addr, CSSA, c->dma_ch);
+		c->plat->dma_write(0, CSEI, c->dma_ch);
+		c->plat->dma_write(0, CSFI, c->dma_ch);
+	}
+
+	c->plat->dma_write(sg->en, CEN, c->dma_ch);
+	c->plat->dma_write(sg->fn, CFN, c->dma_ch);
+
+	omap_start_dma(c->dma_ch);
+}
+
+static void omap_dma_start_desc(struct omap_chan *c)
+{
+	struct virt_dma_desc *vd = vchan_next_desc(&c->vc);
+	struct omap_desc *d;
 	uint32_t val;
 
+	if (!vd) {
+		c->desc = NULL;
+		return;
+	}
+
+	list_del(&vd->node);
+
+	c->desc = d = to_omap_dma_desc(&vd->tx);
+	c->sgidx = 0;
+
 	if (d->dir == DMA_DEV_TO_MEM) {
 		if (dma_omap1()) {
 			val = c->plat->dma_read(CSDP, c->dma_ch);
-			val &= ~(0x1f << 9);
+			val &= ~(0x1f << 9 | 0x1f << 2);
 			val |= OMAP_DMA_PORT_EMIFF << 9;
+			val |= d->periph_port << 2;
 			c->plat->dma_write(val, CSDP, c->dma_ch);
 		}
 
 		val = c->plat->dma_read(CCR, c->dma_ch);
-		val &= ~(0x03 << 14);
+		val &= ~(0x03 << 14 | 0x03 << 12);
 		val |= OMAP_DMA_AMODE_POST_INC << 14;
+		val |= OMAP_DMA_AMODE_CONSTANT << 12;
 		c->plat->dma_write(val, CCR, c->dma_ch);
 
-		c->plat->dma_write(sg->addr, CDSA, c->dma_ch);
-		c->plat->dma_write(0, CDEI, c->dma_ch);
-		c->plat->dma_write(0, CDFI, c->dma_ch);
+		c->plat->dma_write(d->dev_addr, CSSA, c->dma_ch);
+		c->plat->dma_write(0, CSEI, c->dma_ch);
+		c->plat->dma_write(d->fi, CSFI, c->dma_ch);
 	} else {
 		if (dma_omap1()) {
 			val = c->plat->dma_read(CSDP, c->dma_ch);
-			val &= ~(0x1f << 2);
+			val &= ~(0x1f << 9 | 0x1f << 2);
+			val |= d->periph_port << 9;
 			val |= OMAP_DMA_PORT_EMIFF << 2;
 			c->plat->dma_write(val, CSDP, c->dma_ch);
 		}
 
 		val = c->plat->dma_read(CCR, c->dma_ch);
-		val &= ~(0x03 << 12);
+		val &= ~(0x03 << 12 | 0x03 << 14);
+		val |= OMAP_DMA_AMODE_CONSTANT << 14;
 		val |= OMAP_DMA_AMODE_POST_INC << 12;
 		c->plat->dma_write(val, CCR, c->dma_ch);
 
-		c->plat->dma_write(sg->addr, CSSA, c->dma_ch);
-		c->plat->dma_write(0, CSEI, c->dma_ch);
-		c->plat->dma_write(0, CSFI, c->dma_ch);
+		c->plat->dma_write(d->dev_addr, CDSA, c->dma_ch);
+		c->plat->dma_write(0, CDEI, c->dma_ch);
+		c->plat->dma_write(d->fi, CDFI, c->dma_ch);
 	}
 
 	val = c->plat->dma_read(CSDP, c->dma_ch);
@@ -156,91 +191,29 @@ static void omap_dma_start_sg(struct omap_chan *c, struct omap_desc *d,
 		val = c->plat->dma_read(CCR, c->dma_ch);
 
 		/* DMA_SYNCHRO_CONTROL_UPPER depends on the channel number */
-		val &= ~((1 << 23) | (3 << 19) | 0x1f);
+		val &= ~(1 << 24 | 1 << 23 | 3 << 19 | 1 << 18 | 1 << 5 | 0x1f);
 		val |= (c->dma_sig & ~0x1f) << 14;
 		val |= c->dma_sig & 0x1f;
 
 		if (d->sync_mode & OMAP_DMA_SYNC_FRAME)
 			val |= 1 << 5;
-		else
-			val &= ~(1 << 5);
 
 		if (d->sync_mode & OMAP_DMA_SYNC_BLOCK)
 			val |= 1 << 18;
-		else
-			val &= ~(1 << 18);
 
 		switch (d->sync_type) {
-		case OMAP_DMA_DST_SYNC_PREFETCH:
-			val &= ~(1 << 24);	/* dest synch */
+		case OMAP_DMA_DST_SYNC_PREFETCH:/* dest synch */
 			val |= 1 << 23;		/* Prefetch */
 			break;
 		case 0:
-			val &= ~(1 << 24);	/* dest synch */
 			break;
 		default:
-			val |= 1 << 24;		/* source synch */
+			val |= 1 << 24; 	/* source synch */
 			break;
 		}
 		c->plat->dma_write(val, CCR, c->dma_ch);
 	}
 
-	c->plat->dma_write(sg->en, CEN, c->dma_ch);
-	c->plat->dma_write(sg->fn, CFN, c->dma_ch);
-
-	omap_start_dma(c->dma_ch);
-}
-
-static void omap_dma_start_desc(struct omap_chan *c)
-{
-	struct virt_dma_desc *vd = vchan_next_desc(&c->vc);
-	struct omap_desc *d;
-	uint32_t val;
-
-	if (!vd) {
-		c->desc = NULL;
-		return;
-	}
-
-	list_del(&vd->node);
-
-	c->desc = d = to_omap_dma_desc(&vd->tx);
-	c->sgidx = 0;
-
-	if (d->dir == DMA_DEV_TO_MEM) {
-		if (dma_omap1()) {
-			val = c->plat->dma_read(CSDP, c->dma_ch);
-			val &= ~(0x1f << 2);
-			val |= d->periph_port << 2;
-			c->plat->dma_write(val, CSDP, c->dma_ch);
-		}
-
-		val = c->plat->dma_read(CCR, c->dma_ch);
-		val &= ~(0x03 << 12);
-		val |= OMAP_DMA_AMODE_CONSTANT << 12;
-		c->plat->dma_write(val, CCR, c->dma_ch);
-
-		c->plat->dma_write(d->dev_addr, CSSA, c->dma_ch);
-		c->plat->dma_write(0, CSEI, c->dma_ch);
-		c->plat->dma_write(d->fi, CSFI, c->dma_ch);
-	} else {
-		if (dma_omap1()) {
-			val = c->plat->dma_read(CSDP, c->dma_ch);
-			val &= ~(0x1f << 9);
-			val |= d->periph_port << 9;
-			c->plat->dma_write(val, CSDP, c->dma_ch);
-		}
-
-		val = c->plat->dma_read(CCR, c->dma_ch);
-		val &= ~(0x03 << 14);
-		val |= OMAP_DMA_AMODE_CONSTANT << 14;
-		c->plat->dma_write(val, CCR, c->dma_ch);
-
-		c->plat->dma_write(d->dev_addr, CDSA, c->dma_ch);
-		c->plat->dma_write(0, CDEI, c->dma_ch);
-		c->plat->dma_write(d->fi, CDFI, c->dma_ch);
-	}
-
 	omap_dma_start_sg(c, d, 0);
 }
 
-- 
1.8.3.1

