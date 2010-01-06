From: Vimal Singh <vimal.newwork@gmail.com>
Subject: [PATCH 2/3][NAND][OMAP]: correct 'info' pointer in 'omap_nand_remove'
Date: Wed, 6 Jan 2010 19:35:11 +0530
Message-ID: <ce9ab5791001060605j7a424203lcb90f3d79d0ddfae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:45303 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932225Ab0AFOFc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 09:05:32 -0500
Received: by bwz27 with SMTP id 27so10687196bwz.21
        for <linux-omap@vger.kernel.org>; Wed, 06 Jan 2010 06:05:31 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux MTD <linux-mtd@lists.infradead.org>
Cc: linux-omap@vger.kernel.org

>From bf5256c8c29100c3a55e29a8a5d6718ba5817519 Mon Sep 17 00:00:00 2001
From: Vimal Singh <vimalsingh@ti.com>
Date: Tue, 5 Jan 2010 16:01:08 +0530
Subject: [PATCH] NAND: OMAP: correct 'info' pointer in 'omap_nand_remove'

Removing OMAP NAND driver, when loaded as a module, gives error and
does not get success. This fixes this and makes driver loadable and
removable run time.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 drivers/mtd/nand/omap2.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 4eea97c..16120e2 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1054,7 +1054,8 @@ out_free_info:
 static int omap_nand_remove(struct platform_device *pdev)
 {
 	struct mtd_info *mtd = platform_get_drvdata(pdev);
-	struct omap_nand_info *info = mtd->priv;
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
+							mtd);

 	platform_set_drvdata(pdev, NULL);
 	if (use_dma)
-- 
1.5.5
