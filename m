From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] omap2/3: mtd: fix compile warning
Date: Tue, 29 Dec 2009 16:04:52 +0530
Message-ID: <1262082892-5260-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47195 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752683AbZL2KfG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Dec 2009 05:35:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch fixes following compile warning:

drivers/mtd/nand/omap2.c:508: warning: passing argumen
t 2 of 'omap_nand_dma_transfer' discards qualifiers fr
om pointer target type

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 drivers/mtd/nand/omap2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 1bb799f..08c193c 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -505,7 +505,7 @@ static void omap_write_buf_dma_pref(struct mtd_info *mtd,
 		omap_write_buf_pref(mtd, buf, len);
 	else
 		/* start transfer in DMA mode */
-		omap_nand_dma_transfer(mtd, buf, len, 0x1);
+		omap_nand_dma_transfer(mtd, (void *)buf, len, 0x1);
 }
 
 /**
-- 
1.6.2.2

