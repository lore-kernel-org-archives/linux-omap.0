From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH v4 4/4] omap: nand: making ecc layout as compatible with romcode ecc
Date: Mon,  2 Aug 2010 21:19:52 +0530
Message-ID: <1280764192-15053-5-git-send-email-s-ghorai@ti.com>
References: <1280764192-15053-1-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59198 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753780Ab0HBPuK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Aug 2010 11:50:10 -0400
In-Reply-To: <1280764192-15053-1-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, Sukumar Ghorai <s-ghorai@ti.com>, Vimal Singh <vimalsingh@ti.com>

    This patch overrides nand ecc layout and bad block descriptor (for 8-bit
    device) to support hw ecc in romcode layout. So as to have in sync with ecc
    layout throughout; i.e. x-loader, u-boot and kernel.

    This patch also enables to use romcode ecc for spd and zoom, by default.

    This enables to flash x-loader, u-boot, kernel, FS images from kernel itself
    and compatiable with other tools.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 arch/arm/mach-omap2/board-flash.c |    2 +-
 drivers/mtd/nand/omap2.c          |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-flash.c b/arch/arm/mach-omap2/board-flash.c
index 5f74c8f..d71c511 100644
--- a/arch/arm/mach-omap2/board-flash.c
+++ b/arch/arm/mach-omap2/board-flash.c
@@ -145,7 +145,7 @@ __init board_nand_init(struct mtd_partition *nand_parts, u8 nr_parts, u8 cs)
 	board_nand_data.cs		= cs;
 	board_nand_data.parts		= nand_parts;
 	board_nand_data.nr_parts	= nr_parts;
-	board_nand_data.ecc_opt		= OMAP_ECC_HAMMING_CODE_DIFF_LAYOUT;
+	board_nand_data.ecc_opt		= OMAP_ECC_HAMMING_CODE_HW;
 
 	gpmc_nand_init(&board_nand_data);
 }
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 63682c0..1041783 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -128,6 +128,20 @@ const int use_dma;
 const int use_interrupt;
 #endif
 
+/* oob info generated runtime depending on ecc algorithm and layout selected */
+static struct nand_ecclayout omap_oobinfo;
+/* Define some generic bad / good block scan pattern which are used
+ * while scanning a device for factory marked good / bad blocks
+ */
+static uint8_t scan_ff_pattern[] = { 0xff };
+static struct nand_bbt_descr bb_descrip_flashbased = {
+	.options = NAND_BBT_SCANEMPTY | NAND_BBT_SCANALLPAGES,
+	.offs = 0,
+	.len = 1,
+	.pattern = scan_ff_pattern,
+};
+
+
 struct omap_nand_info {
 	struct nand_hw_control		controller;
 	struct omap_nand_platform_data	*pdata;
@@ -945,6 +959,7 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	struct omap_nand_info		*info;
 	struct omap_nand_platform_data	*pdata;
 	int				err;
+	int				i, offset;
 
 	pdata = pdev->dev.platform_data;
 	if (pdata == NULL) {
@@ -1079,6 +1094,25 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* rom code layout */
+	if (pdata->ecc_opt != OMAP_ECC_HAMMING_CODE_DIFF_LAYOUT) {
+		offset = (info->nand.options & NAND_BUSWIDTH_16) ? 2 : 1;
+		if (info->mtd.oobsize == 16) {
+			info->nand.badblock_pattern = &bb_descrip_flashbased;
+			omap_oobinfo.eccbytes = 3;
+		} else
+			omap_oobinfo.eccbytes  = 3 * 4;
+
+		for (i = 0; i < omap_oobinfo.eccbytes; i++)
+			omap_oobinfo.eccpos[i] = i+offset;
+
+		omap_oobinfo.oobfree->offset = offset + omap_oobinfo.eccbytes;
+		omap_oobinfo.oobfree->length = info->mtd.oobsize -
+					(offset + omap_oobinfo.eccbytes);
+
+		info->nand.ecc.layout = &omap_oobinfo;
+	}
+
 #ifdef CONFIG_MTD_PARTITIONS
 	err = parse_mtd_partitions(&info->mtd, part_probes, &info->parts, 0);
 	if (err > 0)
