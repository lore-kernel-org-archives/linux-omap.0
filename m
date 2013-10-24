From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 4/5] mtd: nand: omap2: Use devm_kzalloc
Date: Thu, 24 Oct 2013 19:12:16 -0300
Message-ID: <1382652737-20239-5-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1382652737-20239-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:52606 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754553Ab3JXWMe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Oct 2013 18:12:34 -0400
In-Reply-To: <1382652737-20239-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Brian Norris <computersforpeace@gmail.com>, Pekon Gupta <pekon@ti.com>, Felipe Balbi <balbi@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

This simplifies the error path and makes the code less error-prone.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/omap2.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index e01a936..d4cafb0 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1837,7 +1837,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	info = kzalloc(sizeof(struct omap_nand_info), GFP_KERNEL);
+	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
@@ -2066,9 +2066,6 @@ out_release_mem_region:
 	if (info->gpmc_irq_fifo > 0)
 		free_irq(info->gpmc_irq_fifo, info);
 	release_mem_region(info->phys_base, info->mem_size);
-out_free_info:
-	kfree(info);
-
 	return err;
 }
 
@@ -2091,7 +2088,6 @@ static int omap_nand_remove(struct platform_device *pdev)
 	nand_release(&info->mtd);
 	iounmap(info->nand.IO_ADDR_R);
 	release_mem_region(info->phys_base, info->mem_size);
-	kfree(info);
 	return 0;
 }
 
-- 
1.8.1.5

