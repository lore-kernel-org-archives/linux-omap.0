From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 14/26] dmaengine: omap-dma: move barrier to
 omap_dma_start_desc()
Date: Mon, 10 Feb 2014 15:57:04 +0000
Message-ID: <E1WCtEG-0006Ww-Sb@rmk-PC.arm.linux.org.uk>
References: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:60056 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752474AbaBJP5H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Feb 2014 10:57:07 -0500
In-Reply-To: <20140210155531.GB26684@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

We don't need to issue a barrier for every segment of a DMA transfer;
doing this just once per descriptor will do.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 49609275b2e7..49b303296d75 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -195,7 +195,6 @@ static void omap_dma_start(struct omap_chan *c, struct omap_desc *d)
 
 	val = c->plat->dma_read(CCR, c->dma_ch);
 	val |= CCR_ENABLE;
-	mb();
 	c->plat->dma_write(val, CCR, c->dma_ch);
 }
 
@@ -301,6 +300,13 @@ static void omap_dma_start_desc(struct omap_chan *c)
 	c->desc = d = to_omap_dma_desc(&vd->tx);
 	c->sgidx = 0;
 
+	/*
+	 * This provides the necessary barrier to ensure data held in
+	 * DMA coherent memory is visible to the DMA engine prior to
+	 * the transfer starting.
+	 */
+	mb();
+
 	c->plat->dma_write(d->ccr, CCR, c->dma_ch);
 	if (dma_omap1())
 		c->plat->dma_write(d->ccr >> 16, CCR2, c->dma_ch);
-- 
1.8.3.1

