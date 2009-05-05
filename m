From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/7] onenand init: Convert omap3430sdp to use gpmc-onenand
Date: Mon, 04 May 2009 17:26:54 -0700
Message-ID: <20090505002654.2894.43754.stgit@localhost>
References: <20090505002144.2894.25201.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65180 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587AbZEEA04 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 May 2009 20:26:56 -0400
In-Reply-To: <20090505002144.2894.25201.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind@infradead.org, juha.yrjola@solidboot.com, linux-omap@vger.kernel.org, adrian.hunter@nokia.com

Convert omap3430sdp to use gpmc-onenand. Note that sync mode
does not seem to work for some reason, so disable it with flags.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-3430sdp-flash.c |   28 ++--------------------------
 1 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp-flash.c b/arch/arm/mach-omap2/board-3430sdp-flash.c
index f0e25a4..e0ea564 100644
--- a/arch/arm/mach-omap2/board-3430sdp-flash.c
+++ b/arch/arm/mach-omap2/board-3430sdp-flash.c
@@ -103,8 +103,6 @@ static struct platform_device sdp_nor_device = {
 	.resource	= &sdp_nor_resource,
 };
 
-static int sdp_onenand_setup(void __iomem *, int freq);
-
 static struct mtd_partition sdp_onenand_partitions[] = {
 	{
 		.name		= "X-Loader-OneNAND",
@@ -138,30 +136,9 @@ static struct mtd_partition sdp_onenand_partitions[] = {
 static struct omap_onenand_platform_data sdp_onenand_data = {
 	.parts		= sdp_onenand_partitions,
 	.nr_parts	= ARRAY_SIZE(sdp_onenand_partitions),
-	.onenand_setup	= sdp_onenand_setup,
 	.dma_channel	= -1,	/* disable DMA in OMAP OneNAND driver */
 };
 
-static struct platform_device sdp_onenand_device = {
-	.name		= "omap2-onenand",
-	.id		= -1,
-	.dev = {
-		.platform_data = &sdp_onenand_data,
-	},
-};
-
-/*
- * sdp_onenand_setup - The function configures the onenand flash.
- * @onenand_base: Onenand base address
- *
- * @return int:	Currently always returning zero.
- */
-static int sdp_onenand_setup(void __iomem *onenand_base, int freq)
-{
-	/* Onenand setup does nothing at present */
-	return 0;
-}
-
 static struct mtd_partition sdp_nand_partitions[] = {
 	/* All the partition sizes are listed in terms of NAND block size */
 	{
@@ -262,7 +239,7 @@ void __init sdp3430_flash_init(void)
 		} else {
 			ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
 			if ((ret & 0x3F) == (ONENAND_MAP >> 24))
-			onenandcs = cs;
+				onenandcs = cs;
 		}
 		cs++;
 	}
@@ -284,7 +261,6 @@ void __init sdp3430_flash_init(void)
 
 	if (onenandcs < GPMC_CS_NUM) {
 		sdp_onenand_data.cs = onenandcs;
-		if (platform_device_register(&sdp_onenand_device) < 0)
-			printk(KERN_ERR "Unable to register OneNAND device\n");
+		gpmc_onenand_init(&sdp_onenand_data);
 	}
 }

