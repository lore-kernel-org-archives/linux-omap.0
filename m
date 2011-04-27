From: "Saxena, Parth" <parth.saxena@ti.com>
Subject: [RFC] mtd: nand: Fix bad block identification issue
Date: Wed, 27 Apr 2011 17:39:21 +0530
Message-ID: <1303906161-24175-1-git-send-email-parth.saxena@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43284 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755561Ab1D0MJf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Apr 2011 08:09:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org
Cc: linux-omap@vger.kernel.org, "Saxena, Parth" <parth.saxena@ti.com>, "Basheer, Mansoor Ahamed" <mansoor.ahamed@ti.com>

Commit e0b58d0 ("mtd: nand: add ->badblockbits for minimum number 
of set bits in bad block byte") by Maxim Levitsky added 
badblockbits to nand_chip to specify minimum number of set bits 
in bad block byte. The patch initialized badblockbits to 8 in 
nand_base.c, but later the initialization line got removed by commit
c7b28e2("mtd: nand: refactor BB marker detection"). After this all 
NAND drivers with NAND_SKIP_BBTSCAN are forced to initialize it to 8.
Otherwise bad block identification will fail.

As a result, mounting of empty jffs2 file system on omap3evm
(having bad blocks) failed giving the following error message -

"mount: mounting /dev/mtdblock4 on /tmp failed: Input/output error"

This patch solves the above issue for omap by initialising
badblockbits. We are working further on this to find a generic fix
to the problem in nand_base.c.

Signed-off-by: Saxena, Parth <parth.saxena@ti.com>
Signed-off-by: Basheer, Mansoor Ahamed <mansoor.ahamed@ti.com>
---
 drivers/mtd/nand/omap2.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 454f90c..350c77f 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1005,6 +1005,8 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	info->nand.options	= pdata->devsize;
 	info->nand.options	|= NAND_SKIP_BBTSCAN;
 
+	info->nand.badblockbits = 8;
+
 	/* NAND write protect off */
 	gpmc_cs_configure(info->gpmc_cs, GPMC_CONFIG_WP, 0);
 
-- 
1.6.2.4

