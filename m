From: Cliff Brake <cbrake@bec-systems.com>
Subject: [PATCH] nand/omap2: fix compile error with DMA Config
Date: Fri, 10 Sep 2010 17:24:22 -0400
Message-ID: <1284153862-26332-1-git-send-email-cbrake@bec-systems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from oh-69-34-21-229.sta.embarqhsd.net ([69.34.21.229]:42403 "EHLO
	happy.bec-systems.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504Ab0IJVya (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Sep 2010 17:54:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Cliff Brake <cbrake@bec-systems.com>

With CONFIG_MTD_NAND_OMAP_PREFETCH_DMA, there is a compile
error that this patch fixes.

Signed-off-by: Cliff Brake <cbrake@bec-systems.com>
---
 drivers/mtd/nand/omap2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 133d515..513e0a7 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -413,7 +413,7 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 		prefetch_status = gpmc_read_status(GPMC_PREFETCH_COUNT);
 	} while (prefetch_status);
 	/* disable and stop the PFPW engine */
-	gpmc_prefetch_reset();
+	gpmc_prefetch_reset(info->gpmc_cs);
 
 	dma_unmap_single(&info->pdev->dev, dma_addr, len, dir);
 	return 0;
-- 
1.7.0.4

