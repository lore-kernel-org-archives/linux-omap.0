From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/4] dmaengine: omap-dma: Correct status reporting for memcpy
Date: Wed, 11 Nov 2015 12:37:55 +0200
Message-ID: <1447238278-15863-2-git-send-email-peter.ujfalusi@ti.com>
References: <1447238278-15863-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447238278-15863-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, linux@arm.linux.org.uk
Cc: tony@atomide.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

During mem copy both src and dst position moves at the same pace. Check the
dst position for progress reporting.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/dma/omap-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 1dfc71c90123..8ed39ce24d46 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -719,7 +719,7 @@ static enum dma_status omap_dma_tx_status(struct dma_chan *chan,
 
 		if (d->dir == DMA_MEM_TO_DEV)
 			pos = omap_dma_get_src_pos(c);
-		else if (d->dir == DMA_DEV_TO_MEM)
+		else if (d->dir == DMA_DEV_TO_MEM  || d->dir == DMA_MEM_TO_MEM)
 			pos = omap_dma_get_dst_pos(c);
 		else
 			pos = 0;
-- 
2.6.2
