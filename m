From: Vimal Singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 2/3]NAND: OMAP: Fixing omap nand driver, compiled as
	module
Date: Fri, 30 Oct 2009 14:57:41 +0530
Message-ID: <ce9ab5790910300227r41d42673webad0ee48e3444d1@mail.gmail.com>
References: <ce9ab5790910292321y1e7239b7pbffe9a5891d66448@mail.gmail.com>
	<ce9ab5790910300142kf12e31cpd6249d4c7383553f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:55518 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755003AbZJ3J15 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Oct 2009 05:27:57 -0400
Received: by bwz27 with SMTP id 27so3307948bwz.21
        for <linux-omap@vger.kernel.org>; Fri, 30 Oct 2009 02:28:01 -0700 (PDT)
In-Reply-To: <ce9ab5790910300142kf12e31cpd6249d4c7383553f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux MTD <linux-mtd@lists.infradead.org>, linux-omap@vger.kernel.org

Last time I forgot to 'git add' for 'arch/arm/mach-omap2/gpmc.c'... My bad.
Correct patch is below.

-vimal


From: Vimal Singh <vimalsingh@ti.com>
Date: Fri, 30 Oct 2009 14:54:29 +0530
Subject: [PATCH] NAND: OMAP: Fixing omap nand driver, compiled as module

Removing OMAP NAND driver, when loaded as a module, gives error and
does not get success. This fixes this and makes driver loadable and
removable run time.

Signed-off-by: Vimal Singh <vimalsingh@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |    2 ++
 drivers/mtd/nand/omap2.c   |    5 ++++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 1587682..1d10b7b 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -88,6 +88,7 @@ void gpmc_cs_write_reg(int cs, int idx, u32 val)
 	reg_addr = gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + idx;
 	__raw_writel(val, reg_addr);
 }
+EXPORT_SYMBOL(gpmc_cs_write_reg);

 u32 gpmc_cs_read_reg(int cs, int idx)
 {
@@ -96,6 +97,7 @@ u32 gpmc_cs_read_reg(int cs, int idx)
 	reg_addr = gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + idx;
 	return __raw_readl(reg_addr);
 }
+EXPORT_SYMBOL(gpmc_cs_read_reg);

 /* TODO: Add support for gpmc_fck to clock framework and use it */
 unsigned long gpmc_get_fclk_period(void)
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 92573d5..ecc4d32 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1056,7 +1056,8 @@ out_free_info:
 static int omap_nand_remove(struct platform_device *pdev)
 {
 	struct mtd_info *mtd = platform_get_drvdata(pdev);
-	struct omap_nand_info *info = mtd->priv;
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
+							mtd);

 	platform_set_drvdata(pdev, NULL);
 	if (use_dma)
@@ -1064,7 +1065,9 @@ static int omap_nand_remove(struct platform_device *pdev)

 	/* Release NAND device, its internal structures and partitions */
 	nand_release(&info->mtd);
+	release_mem_region(info->phys_base, NAND_IO_SIZE);
 	iounmap(info->nand_pref_fifo_add);
+	gpmc_cs_free(info->gpmc_cs);
 	kfree(&info->mtd);
 	return 0;
 }
-- 
1.5.5
