From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 14/26] dmaengine: omap-dma: move barrier to
 omap_dma_start_desc()
Date: Thu, 02 Jan 2014 15:11:11 +0000
Message-ID: <E1VyjvT-0005Es-6A@rmk-PC.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:54169 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752181AbaABPPX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jan 2014 10:15:23 -0500
In-Reply-To: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

We don't need to issue a barrier for every segment of a DMA transfer;
doing this just once per descriptor will do.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index bdea85802b5b..e212e0df9b42 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -194,7 +194,6 @@ static void omap_dma_start(struct omap_chan *c, struct omap_desc *d)
 
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
1.7.4.4

