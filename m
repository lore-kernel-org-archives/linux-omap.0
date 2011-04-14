From: Jan Weitzel <j.weitzel@phytec.de>
Subject: [PATCH] ARM: omap2: mtd split nand_scan in ident and tail
Date: Thu, 14 Apr 2011 11:15:29 +0200
Message-ID: <1302772529-15641-1-git-send-email-j.weitzel@phytec.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.visioncatalog.com ([217.6.246.34]:51817 "EHLO
	root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753985Ab1DNJPb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Apr 2011 05:15:31 -0400
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
	by root.phytec.de (Postfix) with ESMTP id 581AABF0E6
	for <linux-omap@vger.kernel.org>; Thu, 14 Apr 2011 11:17:35 +0200 (CEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jan Weitzel <j.weitzel@phytec.de>

nand_scan calls nand_scan_ident and nand_scan_tail, setting values like oobvail
according to ecc.layout. If we change the layout afterwards values are wrong.

Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
---
 drivers/mtd/nand/omap2.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index da9a351..288423f 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1073,9 +1073,9 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	/* DIP switches on some boards change between 8 and 16 bit
 	 * bus widths for flash.  Try the other width if the first try fails.
 	 */
-	if (nand_scan(&info->mtd, 1)) {
+	if (nand_scan_ident(&info->mtd, 1, NULL)) {
 		info->nand.options ^= NAND_BUSWIDTH_16;
-		if (nand_scan(&info->mtd, 1)) {
+		if (nand_scan_ident(&info->mtd, 1, NULL)) {
 			err = -ENXIO;
 			goto out_release_mem_region;
 		}
@@ -1101,6 +1101,12 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 		info->nand.ecc.layout = &omap_oobinfo;
 	}
 
+	/* second phase scan */
+	if (nand_scan_tail(&info->mtd)) {
+		err = -ENXIO;
+		goto out_release_mem_region;
+	}
+
 #ifdef CONFIG_MTD_PARTITIONS
 	err = parse_mtd_partitions(&info->mtd, part_probes, &info->parts, 0);
 	if (err > 0)
-- 
1.7.0.4

