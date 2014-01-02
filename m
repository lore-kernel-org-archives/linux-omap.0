From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 03/26] dmaengine: omap-dma: program hardware directly
Date: Thu, 02 Jan 2014 15:07:22 +0000
Message-ID: <E1Vyjrm-0004zV-91@rmk-PC.arm.linux.org.uk>
References: <20140102150621.GJ16456@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:54168 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751790AbaABPPA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jan 2014 10:15:00 -0500
In-Reply-To: <20140102150621.GJ16456@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead, org@arm.linux.org.uk, linux-omap@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

Program the transfer parameters directly into the hardware, rather
than using the functions in arch/arm/plat-omap/dma.c.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c   |  144 ++++++++++++++++++++++++++++++++++++++++-----
 include/linux/omap-dma.h |    6 +-
 2 files changed, 132 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 3c1bb34aad0a..dd233ca2cf5a 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -99,16 +99,96 @@ static void omap_dma_start_sg(struct omap_chan *c, struct omap_desc *d,
 	unsigned idx)
 {
 	struct omap_sg *sg = d->sg + idx;
+	uint32_t val;
+
+	if (d->dir == DMA_DEV_TO_MEM) {
+		if (dma_omap1()) {
+			val = c->plat->dma_read(CSDP, c->dma_ch);
+			val &= ~(0x1f << 9);
+			val |= OMAP_DMA_PORT_EMIFF << 9;
+			c->plat->dma_write(val, CSDP, c->dma_ch);
+		}
 
-	if (d->dir == DMA_DEV_TO_MEM)
-		omap_set_dma_dest_params(c->dma_ch, OMAP_DMA_PORT_EMIFF,
-			OMAP_DMA_AMODE_POST_INC, sg->addr, 0, 0);
-	else
-		omap_set_dma_src_params(c->dma_ch, OMAP_DMA_PORT_EMIFF,
-			OMAP_DMA_AMODE_POST_INC, sg->addr, 0, 0);
+		val = c->plat->dma_read(CCR, c->dma_ch);
+		val &= ~(0x03 << 14);
+		val |= OMAP_DMA_AMODE_POST_INC << 14;
+		c->plat->dma_write(val, CCR, c->dma_ch);
+
+		c->plat->dma_write(sg->addr, CDSA, c->dma_ch);
+		c->plat->dma_write(0, CDEI, c->dma_ch);
+		c->plat->dma_write(0, CDFI, c->dma_ch);
+	} else {
+		if (dma_omap1()) {
+			val = c->plat->dma_read(CSDP, c->dma_ch);
+			val &= ~(0x1f << 2);
+			val |= OMAP_DMA_PORT_EMIFF << 2;
+			c->plat->dma_write(val, CSDP, c->dma_ch);
+		}
+
+		val = c->plat->dma_read(CCR, c->dma_ch);
+		val &= ~(0x03 << 12);
+		val |= OMAP_DMA_AMODE_POST_INC << 12;
+		c->plat->dma_write(val, CCR, c->dma_ch);
+
+		c->plat->dma_write(sg->addr, CSSA, c->dma_ch);
+		c->plat->dma_write(0, CSEI, c->dma_ch);
+		c->plat->dma_write(0, CSFI, c->dma_ch);
+	}
+
+	val = c->plat->dma_read(CSDP, c->dma_ch);
+	val &= ~0x03;
+	val |= d->es;
+	c->plat->dma_write(val, CSDP, c->dma_ch);
+
+	if (dma_omap1()) {
+		val = c->plat->dma_read(CCR, c->dma_ch);
+		val &= ~(1 << 5);
+		if (d->sync_mode == OMAP_DMA_SYNC_FRAME)
+			val |= 1 << 5;
+		c->plat->dma_write(val, CCR, c->dma_ch);
+
+		val = c->plat->dma_read(CCR2, c->dma_ch);
+		val &= ~(1 << 2);
+		if (d->sync_mode == OMAP_DMA_SYNC_BLOCK)
+			val |= 1 << 2;
+		c->plat->dma_write(val, CCR2, c->dma_ch);
+	}
+
+	if (dma_omap2plus() && c->dma_sig) {
+		val = c->plat->dma_read(CCR, c->dma_ch);
+
+		/* DMA_SYNCHRO_CONTROL_UPPER depends on the channel number */
+		val &= ~((1 << 23) | (3 << 19) | 0x1f);
+		val |= (c->dma_sig & ~0x1f) << 14;
+		val |= c->dma_sig & 0x1f;
+
+		if (d->sync_mode & OMAP_DMA_SYNC_FRAME)
+			val |= 1 << 5;
+		else
+			val &= ~(1 << 5);
 
-	omap_set_dma_transfer_params(c->dma_ch, d->es, sg->en, sg->fn,
-		d->sync_mode, c->dma_sig, d->sync_type);
+		if (d->sync_mode & OMAP_DMA_SYNC_BLOCK)
+			val |= 1 << 18;
+		else
+			val &= ~(1 << 18);
+
+		switch (d->sync_type) {
+		case OMAP_DMA_DST_SYNC_PREFETCH:
+			val &= ~(1 << 24);	/* dest synch */
+			val |= 1 << 23;		/* Prefetch */
+			break;
+		case 0:
+			val &= ~(1 << 24);	/* dest synch */
+			break;
+		default:
+			val |= 1 << 24;		/* source synch */
+			break;
+		}
+		c->plat->dma_write(val, CCR, c->dma_ch);
+	}
+
+	c->plat->dma_write(sg->en, CEN, c->dma_ch);
+	c->plat->dma_write(sg->fn, CFN, c->dma_ch);
 
 	omap_start_dma(c->dma_ch);
 }
@@ -117,6 +197,7 @@ static void omap_dma_start_desc(struct omap_chan *c)
 {
 	struct virt_dma_desc *vd = vchan_next_desc(&c->vc);
 	struct omap_desc *d;
+	uint32_t val;
 
 	if (!vd) {
 		c->desc = NULL;
@@ -128,12 +209,39 @@ static void omap_dma_start_desc(struct omap_chan *c)
 	c->desc = d = to_omap_dma_desc(&vd->tx);
 	c->sgidx = 0;
 
-	if (d->dir == DMA_DEV_TO_MEM)
-		omap_set_dma_src_params(c->dma_ch, d->periph_port,
-			OMAP_DMA_AMODE_CONSTANT, d->dev_addr, 0, d->fi);
-	else
-		omap_set_dma_dest_params(c->dma_ch, d->periph_port,
-			OMAP_DMA_AMODE_CONSTANT, d->dev_addr, 0, d->fi);
+	if (d->dir == DMA_DEV_TO_MEM) {
+		if (dma_omap1()) {
+			val = c->plat->dma_read(CSDP, c->dma_ch);
+			val &= ~(0x1f << 2);
+			val |= d->periph_port << 2;
+			c->plat->dma_write(val, CSDP, c->dma_ch);
+		}
+
+		val = c->plat->dma_read(CCR, c->dma_ch);
+		val &= ~(0x03 << 12);
+		val |= OMAP_DMA_AMODE_CONSTANT << 12;
+		c->plat->dma_write(val, CCR, c->dma_ch);
+
+		c->plat->dma_write(d->dev_addr, CSSA, c->dma_ch);
+		c->plat->dma_write(0, CSEI, c->dma_ch);
+		c->plat->dma_write(d->fi, CSFI, c->dma_ch);
+	} else {
+		if (dma_omap1()) {
+			val = c->plat->dma_read(CSDP, c->dma_ch);
+			val &= ~(0x1f << 9);
+			val |= d->periph_port << 9;
+			c->plat->dma_write(val, CSDP, c->dma_ch);
+		}
+
+		val = c->plat->dma_read(CCR, c->dma_ch);
+		val &= ~(0x03 << 14);
+		val |= OMAP_DMA_AMODE_CONSTANT << 14;
+		c->plat->dma_write(val, CCR, c->dma_ch);
+
+		c->plat->dma_write(d->dev_addr, CDSA, c->dma_ch);
+		c->plat->dma_write(0, CDEI, c->dma_ch);
+		c->plat->dma_write(d->fi, CDFI, c->dma_ch);
+	}
 
 	omap_dma_start_sg(c, d, 0);
 }
@@ -452,8 +560,12 @@ static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
 	}
 
 	if (dma_omap2plus()) {
-		omap_set_dma_src_burst_mode(c->dma_ch, OMAP_DMA_DATA_BURST_16);
-		omap_set_dma_dest_burst_mode(c->dma_ch, OMAP_DMA_DATA_BURST_16);
+		uint32_t val;
+
+		val = c->plat->dma_read(CSDP, c->dma_ch);
+		val |= 0x03 << 7; /* src burst mode 16 */
+		val |= 0x03 << 14; /* dst burst mode 16 */
+		c->plat->dma_write(val, CSDP, c->dma_ch);
 	}
 
 	return vchan_tx_prep(&c->vc, &d->vd, flags);
diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
index 14742fc2aefe..d631658e2237 100644
--- a/include/linux/omap-dma.h
+++ b/include/linux/omap-dma.h
@@ -289,8 +289,10 @@ struct omap_system_dma_plat_info {
 #define dma_omap2plus()	0
 #endif
 #define dma_omap1()	(!dma_omap2plus())
-#define dma_omap15xx()	((dma_omap1() && (d->dev_caps & ENABLE_1510_MODE)))
-#define dma_omap16xx()	((dma_omap1() && (d->dev_caps & ENABLE_16XX_MODE)))
+#define __dma_omap15xx(d) (dma_omap1() && (d)->dev_caps & ENABLE_1510_MODE)
+#define __dma_omap16xx(d) (dma_omap1() && (d)->dev_caps & ENABLE_16XX_MODE)
+#define dma_omap15xx()	__dma_omap15xx(d)
+#define dma_omap16xx()	__dma_omap16xx(d)
 
 extern struct omap_system_dma_plat_info *omap_get_plat_info(void);
 
-- 
1.7.4.4

