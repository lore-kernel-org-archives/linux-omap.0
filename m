From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v6 2/5] mtd: omap-nand: pass device_node in platform data
Date: Thu, 29 Nov 2012 17:01:29 +0100
Message-ID: <1354204892-22762-3-git-send-email-zonque@gmail.com>
References: <1354204892-22762-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:53093 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754714Ab2K2QBy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Nov 2012 11:01:54 -0500
In-Reply-To: <1354204892-22762-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, jon-hunter@ti.com, avinashphilip@ti.com, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com, jacmet@sunsite.dk, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, Daniel Mack <zonque@gmail.com>

Pass an optional device_node pointer in the platform data, which in turn
will be put into a mtd_part_parser_data. This way, code that sets up the
platform devices can pass along the node from DT so that the partitions
can be parsed.

For non-DT boards, this change has no effect.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/mtd/nand/omap2.c                     | 4 +++-
 include/linux/platform_data/mtd-nand-omap2.h | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 3282b15..a733f15 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1331,6 +1331,7 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	dma_cap_mask_t mask;
 	unsigned sig;
 	struct resource			*res;
+	struct mtd_part_parser_data	ppdata = {};
 
 	pdata = pdev->dev.platform_data;
 	if (pdata == NULL) {
@@ -1556,7 +1557,8 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 		goto out_release_mem_region;
 	}
 
-	mtd_device_parse_register(&info->mtd, NULL, NULL, pdata->parts,
+	ppdata.of_node = pdata->of_node;
+	mtd_device_parse_register(&info->mtd, NULL, &ppdata, pdata->parts,
 				  pdata->nr_parts);
 
 	platform_set_drvdata(pdev, &info->mtd);
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index 24d32ca..6bf9ef4 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -60,6 +60,8 @@ struct omap_nand_platform_data {
 	int			devsize;
 	enum omap_ecc           ecc_opt;
 	struct gpmc_nand_regs	reg;
-};
 
+	/* for passing the partitions */
+	struct device_node	*of_node;
+};
 #endif
-- 
1.7.11.7

