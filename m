From: green@liuxhacker.ru
Subject: [PATCH] Fix incorrect structure freeing in omap_nand_remove()
Date: Thu, 10 Mar 2011 19:26:39 -0500
Message-ID: <1299803199-12790-1-git-send-email-green@liuxhacker.ru>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [68.84.92.224] ([68.84.92.224]:51310 "EHLO fatbox1.localnet"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754802Ab1CKAfA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 19:35:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Oleg Drokin <green@linuxhacker.ru>

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
index 4e33972..7c71716 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1131,7 +1131,7 @@ static int omap_nand_remove(struct platform_device *pdev)
 	/* Release NAND device, its internal structures and partitions */
 	nand_release(&info->mtd);
 	iounmap(info->nand.IO_ADDR_R);
-	kfree(&info->mtd);
+	kfree(info);
 	return 0;
 }
 
-- 
1.7.4

