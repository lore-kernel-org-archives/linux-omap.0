From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v2 2/5] mtd: nand: omap2: Start dma request before enabling prefetch
Date: Thu, 15 Oct 2015 12:37:25 -0500
Message-ID: <1444930648-19313-3-git-send-email-fcooper@ti.com>
References: <1444930648-19313-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444930648-19313-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, rogerq@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, nsekhar@ti.com, computersforpeace@gmail.com, dwmw2@infradead.org, tony@atomide.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

The prefetch engine sends a dma request once a FIFO threshold has
been met. No other requests are received until the previous request
is handled.

Starting an edma transfer (dma_async_issue_pending) results in any
previous event for the dma channel to be cleared. Therefore, starting
the prefetch engine before initiating the dma transfer may result in
the prefetch triggering a dma request but instead of it being handled
it can end up being cleared. This will result in a hang since the code
will continue to wait for the dma request to complete.

By initiating the dma request before enabling the prefetch engine this
race condition is avoided and no dma request are missed/cleared.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
V2 Changes:
Moved comment

 drivers/mtd/nand/omap2.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 957c32f..1f58420 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -509,6 +509,11 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 	tx->callback_param = &info->comp;
 	dmaengine_submit(tx);
 
+	init_completion(&info->comp);
+
+	/* setup and start DMA using dma_addr */
+	dma_async_issue_pending(info->dma);
+
 	/*  configure and start prefetch transfer */
 	ret = omap_prefetch_enable(info->gpmc_cs,
 		PREFETCH_FIFOTHRESHOLD_MAX, 0x1, len, is_write, info);
@@ -516,10 +521,6 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 		/* PFPW engine is busy, use cpu copy method */
 		goto out_copy_unmap;
 
-	init_completion(&info->comp);
-	dma_async_issue_pending(info->dma);
-
-	/* setup and start DMA using dma_addr */
 	wait_for_completion(&info->comp);
 	tim = 0;
 	limit = (loops_per_jiffy * msecs_to_jiffies(OMAP_NAND_TIMEOUT_MS));
-- 
2.6.1
