From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 2/3] dmaengine: omap: add support for setting fi
Date: Fri, 22 Jun 2012 10:01:34 +0100
Message-ID: <E1ShzkE-0004h8-3u@rmk-PC.arm.linux.org.uk>
References: <20120622085911.GA19026@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60372 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070Ab2FVJBg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jun 2012 05:01:36 -0400
In-Reply-To: <20120622085911.GA19026@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/omap-dma.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 62b6a2b..e1a326d 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -50,6 +50,7 @@ struct omap_desc {
 	enum dma_transfer_direction dir;
 	dma_addr_t dev_addr;
 
+	int16_t fi;		/* for OMAP_DMA_SYNC_PACKET */
 	uint8_t es;		/* element size */
 	uint8_t sync_mode;	/* OMAP_DMA_SYNC_xxx */
 	uint8_t sync_type;	/* OMAP_DMA_xxx_SYNC* */
@@ -120,10 +121,10 @@ static void omap_dma_start_desc(struct omap_chan *c)
 
 	if (d->dir == DMA_DEV_TO_MEM)
 		omap_set_dma_src_params(c->dma_ch, d->periph_port,
-			OMAP_DMA_AMODE_CONSTANT, d->dev_addr, 0, 0);
+			OMAP_DMA_AMODE_CONSTANT, d->dev_addr, 0, d->fi);
 	else
 		omap_set_dma_dest_params(c->dma_ch, d->periph_port,
-			OMAP_DMA_AMODE_CONSTANT, d->dev_addr, 0, 0);
+			OMAP_DMA_AMODE_CONSTANT, d->dev_addr, 0, d->fi);
 
 	omap_dma_start_sg(c, d, 0);
 }
-- 
1.7.4.4

