From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 11/26] dmaengine: omap-dma: consolidate clearing channel
 status register
Date: Thu, 02 Jan 2014 15:10:40 +0000
Message-ID: <E1Vyjuy-0005Ef-Rl@rmk-PC.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:54169 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751930AbaABPPD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jan 2014 10:15:03 -0500
In-Reply-To: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index ba0e10db5185..574f38e3fead 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -168,6 +168,14 @@ static void omap_dma_desc_free(struct virt_dma_desc *vd)
 	kfree(container_of(vd, struct omap_desc, vd));
 }
 
+static void omap_dma_clear_csr(struct omap_chan *c)
+{
+	if (dma_omap1())
+		c->plat->dma_read(CSR, c->dma_ch);
+	else
+		c->plat->dma_write(~0, CSR, c->dma_ch);
+}
+
 static void omap_dma_start(struct omap_chan *c, struct omap_desc *d)
 {
 	struct omap_dmadev *od = to_omap_dma_dev(c->vc.chan.device);
@@ -190,11 +198,7 @@ static void omap_dma_start(struct omap_chan *c, struct omap_desc *d)
 	} else if (od->plat->errata & DMA_ERRATA_PARALLEL_CHANNELS)
 		c->plat->dma_write(c->dma_ch, CLNK_CTRL, c->dma_ch);
 
-	/* Clear CSR */
-	if (dma_omap1())
-		c->plat->dma_read(CSR, c->dma_ch);
-	else
-		c->plat->dma_write(~0, CSR, c->dma_ch);
+	omap_dma_clear_csr(c);
 
 	/* Enable interrupts */
 	c->plat->dma_write(d->cicr, CICR, c->dma_ch);
@@ -213,11 +217,7 @@ static void omap_dma_stop(struct omap_chan *c)
 	/* disable irq */
 	c->plat->dma_write(0, CICR, c->dma_ch);
 
-	/* Clear CSR */
-	if (dma_omap1())
-		c->plat->dma_read(CSR, c->dma_ch);
-	else
-		c->plat->dma_write(~0, CSR, c->dma_ch);
+	omap_dma_clear_csr(c);
 
 	val = c->plat->dma_read(CCR, c->dma_ch);
 	if (od->plat->errata & DMA_ERRATA_i541 && val & CCR_TRIGGER_SRC) {
-- 
1.7.4.4

