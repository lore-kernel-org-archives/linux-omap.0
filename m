From: Jan Weitzel <j.weitzel@phytec.de>
Subject: [PATCH v3] ARM: omap2: mtd split nand_scan in ident and tail
Date: Tue, 19 Apr 2011 16:15:34 +0200
Message-ID: <1303222534-10143-1-git-send-email-j.weitzel@phytec.de>
References: <BANLkTimxgyStkfYXyHJUzQBKTR0pYsF7Qw@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.rapiddevelopmentkit.de ([217.6.246.34]:38122 "EHLO
	root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155Ab1DSOPj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 10:15:39 -0400
In-Reply-To: <BANLkTimxgyStkfYXyHJUzQBKTR0pYsF7Qw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Artem.Bityutskiy@nokia.com
Cc: s.hauer@pengutronix.de, dwmw2@infradead.org, tony@atomide.com, s-ghorai@ti.com, vimal.newwork@gmail.com, Jan Weitzel <j.weitzel@phytec.de>

nand_scan calls nand_scan_tail and here we got a ecc.layout and calculate
oobavail for this layout. After calling nand_scan, we change the layout pointer
if OMAP_ECC_HAMMING_CODE_HW_ROMCODE is set. This results in not calcluated
oobavail. Mountig as jffs2 is not possible.

To fix that nand_scan has to split up in nand_scan_ident and nand_scan_tail
setting ecc.layout between these calls. So nand_scan_tail calculates oobvail
for the used layout. This is also done in serveral other platforms.

Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
Reviewed-by: Vimal Singh <vimal.newwork@gmail.com>
---
v2:
update commit message
v3:
Add Reviewed-by

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

