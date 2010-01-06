From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH 1/3][NAND][OMAP]: Fixing compilation warning for
	'nand/omap2.c'
Date: Wed, 6 Jan 2010 19:30:21 +0530
Message-ID: <ce9ab5791001060600q1bef6ff5x602519e7db9e145@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:49786 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713Ab0AFOAn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 09:00:43 -0500
Received: by bwz27 with SMTP id 27so10683489bwz.21
        for <linux-omap@vger.kernel.org>; Wed, 06 Jan 2010 06:00:41 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux MTD <linux-mtd@lists.infradead.org>
Cc: linux-omap@vger.kernel.org

>From 3e856346f93afaf3f519dffe7987e4bbf56a136d Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Tue, 5 Jan 2010 12:49:24 +0530
Subject: [PATCH] Fixing compilation warning for 'nand/omap2.c'

Fixing below warning in compilation:
drivers/mtd/nand/omap2.c: In function 'omap_write_buf_dma_pref':
drivers/mtd/nand/omap2.c:508: warning: passing argument 2 of
'omap_nand_dma_transfer' discards qualifiers from pointer target type

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 drivers/mtd/nand/omap2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 1bb799f..4eea97c 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -505,7 +505,7 @@ static void omap_write_buf_dma_pref(struct mtd_info *mtd,
 		omap_write_buf_pref(mtd, buf, len);
 	else
 		/* start transfer in DMA mode */
-		omap_nand_dma_transfer(mtd, buf, len, 0x1);
+		omap_nand_dma_transfer(mtd, (u_char *) buf, len, 0x1);
 }

 /**
-- 
1.5.5
