From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] mtd: omap2: fix resource leak in prefetch-busy path
Date: Wed, 11 Apr 2012 04:04:34 +0300
Message-ID: <1334106274-24993-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:41682 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755856Ab2DKBEc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 21:04:32 -0400
Received: by wibhj6 with SMTP id hj6so3881872wib.1
        for <linux-omap@vger.kernel.org>; Tue, 10 Apr 2012 18:04:31 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, linux-omap@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>

If prefetch engine is busy, current code "forgets" to call
dma_unmap_single(), which results in a deadlock later, so add it.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/mtd/nand/omap2.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index f745f00..7feb274 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -402,7 +402,7 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 			PREFETCH_FIFOTHRESHOLD_MAX, 0x1, len, is_write);
 	if (ret)
 		/* PFPW engine is busy, use cpu copy method */
-		goto out_copy;
+		goto out_copy_unmap;
 
 	init_completion(&info->comp);
 
@@ -421,6 +421,8 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 	dma_unmap_single(&info->pdev->dev, dma_addr, len, dir);
 	return 0;
 
+out_copy_unmap:
+	dma_unmap_single(&info->pdev->dev, dma_addr, len, dir);
 out_copy:
 	if (info->nand.options & NAND_BUSWIDTH_16)
 		is_write == 0 ? omap_read_buf16(mtd, (u_char *) addr, len)
-- 
1.7.0.4

