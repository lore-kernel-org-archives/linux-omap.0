From: green@linuxhacker.ru
Subject: [PATCH] Fix incorrect structure freeing in omap_nand_remove()
Date: Fri, 29 Apr 2011 15:03:25 -0400
Message-ID: <1304103805-14057-1-git-send-email-green@linuxhacker.ru>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from c-71-228-165-73.hsd1.tn.comcast.net ([71.228.165.73]:45748 "EHLO
	fatbox1.localnet" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933238Ab1D2TDx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Apr 2011 15:03:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Artem Bityutskiy <dedekind1@gmail.com>, Oleg Drokin <green@linuxhacker.ru>

From: Oleg Drokin <green@linuxhacker.ru>

Attempt to kfree(&info->mtd) is a bad idea since it's
a different substructure in the middle of a properly
allocated struct omap_nand_info.
I guess nobody tripped it before since nobody really
removes NAND flash and nobody unloads the module either.

Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
---
 drivers/mtd/nand/omap2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index da9a351..39f5034 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1139,7 +1139,7 @@ static int omap_nand_remove(struct platform_device *pdev)
 	/* Release NAND device, its internal structures and partitions */
 	nand_release(&info->mtd);
 	iounmap(info->nand.IO_ADDR_R);
-	kfree(&info->mtd);
+	kfree(info);
 	return 0;
 }
 
-- 
1.7.4.4

