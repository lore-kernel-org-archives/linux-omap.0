From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 07/26] dmaengine: omap-dma: consolidate setup of CSDP
Date: Thu, 02 Jan 2014 15:10:00 +0000
Message-ID: <E1VyjuK-0005EM-DR@rmk-PC.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:54168 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752146AbaABPPP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jan 2014 10:15:15 -0500
In-Reply-To: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

Consolidate the setup of the channel source destination parameters
register.  This way, we calculate the required CSDP value when we setup
a transfer descriptor, and only write it to the device registers once
when we start the descriptor.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c |   64 +++++++++++++++++++++---------------------------
 1 files changed, 28 insertions(+), 36 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 7e6cdc39725c..98928f7209f6 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -60,8 +60,8 @@ struct omap_desc {
 	uint8_t es;		/* OMAP_DMA_DATA_TYPE_xxx */
 	uint8_t sync_mode;	/* OMAP_DMA_SYNC_xxx */
 	uint8_t sync_type;	/* OMAP_DMA_xxx_SYNC* */
-	uint8_t periph_port;	/* Peripheral port */
 	uint16_t cicr;		/* CICR value */
+	uint32_t csdp;		/* CSDP value */
 
 	unsigned sglen;
 	struct omap_sg sg[0];
@@ -241,14 +241,6 @@ static void omap_dma_start_desc(struct omap_chan *c)
 	c->sgidx = 0;
 
 	if (d->dir == DMA_DEV_TO_MEM) {
-		if (dma_omap1()) {
-			val = c->plat->dma_read(CSDP, c->dma_ch);
-			val &= ~(0x1f << 9 | 0x1f << 2);
-			val |= OMAP_DMA_PORT_EMIFF << 9;
-			val |= d->periph_port << 2;
-			c->plat->dma_write(val, CSDP, c->dma_ch);
-		}
-
 		val = c->plat->dma_read(CCR, c->dma_ch);
 		val &= ~(0x03 << 14 | 0x03 << 12);
 		val |= OMAP_DMA_AMODE_POST_INC << 14;
@@ -259,14 +251,6 @@ static void omap_dma_start_desc(struct omap_chan *c)
 		c->plat->dma_write(0, CSEI, c->dma_ch);
 		c->plat->dma_write(d->fi, CSFI, c->dma_ch);
 	} else {
-		if (dma_omap1()) {
-			val = c->plat->dma_read(CSDP, c->dma_ch);
-			val &= ~(0x1f << 9 | 0x1f << 2);
-			val |= d->periph_port << 9;
-			val |= OMAP_DMA_PORT_EMIFF << 2;
-			c->plat->dma_write(val, CSDP, c->dma_ch);
-		}
-
 		val = c->plat->dma_read(CCR, c->dma_ch);
 		val &= ~(0x03 << 12 | 0x03 << 14);
 		val |= OMAP_DMA_AMODE_CONSTANT << 14;
@@ -278,10 +262,7 @@ static void omap_dma_start_desc(struct omap_chan *c)
 		c->plat->dma_write(d->fi, CDFI, c->dma_ch);
 	}
 
-	val = c->plat->dma_read(CSDP, c->dma_ch);
-	val &= ~0x03;
-	val |= d->es;
-	c->plat->dma_write(val, CSDP, c->dma_ch);
+	c->plat->dma_write(d->csdp, CSDP, c->dma_ch);
 
 	if (dma_omap1()) {
 		val = c->plat->dma_read(CCR, c->dma_ch);
@@ -605,13 +586,21 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 	d->es = es;
 	d->sync_mode = OMAP_DMA_SYNC_FRAME;
 	d->sync_type = sync_type;
-	d->periph_port = OMAP_DMA_PORT_TIPB;
 	d->cicr = OMAP_DMA_DROP_IRQ | OMAP_DMA_BLOCK_IRQ;
+	d->csdp = es;
 
-	if (dma_omap1())
+	if (dma_omap1()) {
 		d->cicr |= OMAP1_DMA_TOUT_IRQ;
-	else if (dma_omap2plus())
+
+		if (dir == DMA_DEV_TO_MEM)
+			d->csdp |= OMAP_DMA_PORT_EMIFF << 9 |
+				   OMAP_DMA_PORT_TIPB << 2;
+		else
+			d->csdp |= OMAP_DMA_PORT_TIPB << 9 |
+				   OMAP_DMA_PORT_EMIFF << 2;
+	} else if (dma_omap2plus()) {
 		d->cicr |= OMAP2_DMA_MISALIGNED_ERR_IRQ | OMAP2_DMA_TRANS_ERR_IRQ;
+	}
 
 	/*
 	 * Build our scatterlist entries: each contains the address,
@@ -693,7 +682,6 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
 	else
 		d->sync_mode = OMAP_DMA_SYNC_ELEMENT;
 	d->sync_type = sync_type;
-	d->periph_port = OMAP_DMA_PORT_MPUI;
 	d->sg[0].addr = buf_addr;
 	d->sg[0].en = period_len / es_bytes[es];
 	d->sg[0].fn = buf_len / period_len;
@@ -702,11 +690,24 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
 	if (flags & DMA_PREP_INTERRUPT)
 		d->cicr |= OMAP_DMA_FRAME_IRQ;
 
-	if (dma_omap1())
+	d->csdp = es;
+
+	if (dma_omap1()) {
 		d->cicr |= OMAP1_DMA_TOUT_IRQ;
-	else if (dma_omap2plus())
+
+		if (dir == DMA_DEV_TO_MEM)
+			d->csdp |= OMAP_DMA_PORT_EMIFF << 9 |
+				   OMAP_DMA_PORT_MPUI << 2;
+		else
+			d->csdp |= OMAP_DMA_PORT_MPUI << 9 |
+				   OMAP_DMA_PORT_EMIFF << 2;
+	} else if (dma_omap2plus()) {
 		d->cicr |= OMAP2_DMA_MISALIGNED_ERR_IRQ | OMAP2_DMA_TRANS_ERR_IRQ;
 
+		/* src and dst burst mode 16 */
+		d->csdp |= 3 << 14 | 3 << 7;
+	}
+
 	if (!c->cyclic) {
 		c->cyclic = true;
 
@@ -719,15 +720,6 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
 		}
 	}
 
-	if (dma_omap2plus()) {
-		uint32_t val;
-
-		val = c->plat->dma_read(CSDP, c->dma_ch);
-		val |= 0x03 << 7; /* src burst mode 16 */
-		val |= 0x03 << 14; /* dst burst mode 16 */
-		c->plat->dma_write(val, CSDP, c->dma_ch);
-	}
-
 	return vchan_tx_prep(&c->vc, &d->vd, flags);
 }
 
-- 
1.7.4.4

