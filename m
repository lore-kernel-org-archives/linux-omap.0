From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] onenand init: Convert omap3430sdp to use gpmc-onenand (Re:
	[PATCH] onenand_init: Allow disabling sync read and write based on
	flags (Re: [PATCH 1/4] onenand init: Rename board-n800-flash.c to
	gpmc-onenand.c))
Date: Thu, 30 Apr 2009 11:59:46 -0700
Message-ID: <20090430185945.GH12986@atomide.com>
References: <40106.192.168.10.89.1241073191.squirrel@dbdmail.itg.ti.com> <20090430140336.GC12986@atomide.com> <20090430185307.GF12986@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="s9fJI615cBHmzTOP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64137 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758491AbZD3S7s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Apr 2009 14:59:48 -0400
Content-Disposition: inline
In-Reply-To: <20090430185307.GF12986@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vimal singh <vimalsingh@ti.com>
Cc: dedekind@infradead.org, linux-omap@vger.kernel.org, adrian.hunter@nokia.com, Tony Lindgren <tony@atommide.com>


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



--s9fJI615cBHmzTOP
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="convert-3430sdp.patch"

>From b5c750c4d3f523df5759c3b7cbda321d056f7045 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 30 Apr 2009 11:46:41 -0700
Subject: [PATCH] onenand init: Convert omap3430sdp to use gpmc-onenand

Convert omap3430sdp to use gpmc-onenand. Note that sync mode
does not seem to work for some reason, so disable it with flags.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-3430sdp-flash.c b/arch/arm/mach-omap2/board-3430sdp-flash.c
index f0e25a4..ab3fc1a 100644
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
@@ -138,30 +136,10 @@ static struct mtd_partition sdp_onenand_partitions[] = {
 static struct omap_onenand_platform_data sdp_onenand_data = {
 	.parts		= sdp_onenand_partitions,
 	.nr_parts	= ARRAY_SIZE(sdp_onenand_partitions),
-	.onenand_setup	= sdp_onenand_setup,
 	.dma_channel	= -1,	/* disable DMA in OMAP OneNAND driver */
+	.flags		= ONENAND_DIS_SYNC_READ | ONENAND_DIS_SYNC_WRITE,
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
@@ -262,7 +240,7 @@ void __init sdp3430_flash_init(void)
 		} else {
 			ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
 			if ((ret & 0x3F) == (ONENAND_MAP >> 24))
-			onenandcs = cs;
+				onenandcs = cs;
 		}
 		cs++;
 	}
@@ -284,7 +262,6 @@ void __init sdp3430_flash_init(void)
 
 	if (onenandcs < GPMC_CS_NUM) {
 		sdp_onenand_data.cs = onenandcs;
-		if (platform_device_register(&sdp_onenand_device) < 0)
-			printk(KERN_ERR "Unable to register OneNAND device\n");
+		gpmc_onenand_init(&sdp_onenand_data);
 	}
 }

--s9fJI615cBHmzTOP--
