From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/17] MTD: remove no longer used OMAP flash map
Date: Wed, 10 Feb 2010 19:35:33 -0800
Message-ID: <20100211033533.1624.629.stgit@baageli.muru.com>
References: <20100211033310.1624.80025.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58082 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306Ab0BKDe4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 22:34:56 -0500
In-Reply-To: <20100211033310.1624.80025.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Ladislav Michl <ladis@linux-mips.org>

From: Ladislav Michl <ladis@linux-mips.org>

All OMAP boards are now using physmap-flash.

Cc: linux-mtd@lists.infradead.org
Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mtd/maps/Kconfig    |    9 --
 drivers/mtd/maps/Makefile   |    1 
 drivers/mtd/maps/omap_nor.c |  188 -------------------------------------------
 3 files changed, 0 insertions(+), 198 deletions(-)

diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 2de0cc8..9605cb8 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -428,15 +428,6 @@ config MTD_H720X
 	  This enables access to the flash chips on the Hynix evaluation boards.
 	  If you have such a board, say 'Y'.
 
-config MTD_OMAP_NOR
-	tristate "TI OMAP board mappings"
-	depends on MTD_CFI && ARCH_OMAP
-	help
-	  This enables access to the NOR flash chips on TI OMAP-based
-	  boards defining flash platform devices and flash platform data.
-	  These boards include the Innovator, H2, H3, OSK, Perseus2, and
-	  more.  If you have such a board, say 'Y'.
-
 # This needs CFI or JEDEC, depending on the cards found.
 config MTD_PCI
 	tristate "PCI MTD driver"
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index ce31521..faa9fef 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -55,7 +55,6 @@ obj-$(CONFIG_MTD_IXP2000)	+= ixp2000.o
 obj-$(CONFIG_MTD_WRSBC8260)	+= wr_sbc82xx_flash.o
 obj-$(CONFIG_MTD_DMV182)	+= dmv182.o
 obj-$(CONFIG_MTD_PLATRAM)	+= plat-ram.o
-obj-$(CONFIG_MTD_OMAP_NOR)	+= omap_nor.o
 obj-$(CONFIG_MTD_INTEL_VR_NOR)	+= intel_vr_nor.o
 obj-$(CONFIG_MTD_BFIN_ASYNC)	+= bfin-async-flash.o
 obj-$(CONFIG_MTD_RBTX4939)	+= rbtx4939-flash.o
diff --git a/drivers/mtd/maps/omap_nor.c b/drivers/mtd/maps/omap_nor.c
index ead0b2f..e69de29 100644
--- a/drivers/mtd/maps/omap_nor.c
+++ b/drivers/mtd/maps/omap_nor.c
@@ -1,188 +0,0 @@
-/*
- * Flash memory support for various TI OMAP boards
- *
- * Copyright (C) 2001-2002 MontaVista Software Inc.
- * Copyright (C) 2003-2004 Texas Instruments
- * Copyright (C) 2004 Nokia Corporation
- *
- *	Assembled using driver code copyright the companies above
- *	and written by David Brownell, Jian Zhang <jzhang@ti.com>,
- * 	Tony Lindgren <tony@atomide.com> and others.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
- * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
- * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the  GNU General Public License along
- * with this program; if not, write  to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/platform_device.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/slab.h>
-
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/map.h>
-#include <linux/mtd/partitions.h>
-
-#include <asm/io.h>
-#include <mach/hardware.h>
-#include <asm/mach/flash.h>
-#include <plat/tc.h>
-
-#ifdef CONFIG_MTD_PARTITIONS
-static const char *part_probes[] = { /* "RedBoot", */ "cmdlinepart", NULL };
-#endif
-
-struct omapflash_info {
-	struct mtd_partition	*parts;
-	struct mtd_info		*mtd;
-	struct map_info		map;
-};
-
-static void omap_set_vpp(struct map_info *map, int enable)
-{
-	static int	count;
-	u32 l;
-
-	if (cpu_class_is_omap1()) {
-		if (enable) {
-			if (count++ == 0) {
-				l = omap_readl(EMIFS_CONFIG);
-				l |= OMAP_EMIFS_CONFIG_WP;
-				omap_writel(l, EMIFS_CONFIG);
-			}
-		} else {
-			if (count && (--count == 0)) {
-				l = omap_readl(EMIFS_CONFIG);
-				l &= ~OMAP_EMIFS_CONFIG_WP;
-				omap_writel(l, EMIFS_CONFIG);
-			}
-		}
-	}
-}
-
-static int __init omapflash_probe(struct platform_device *pdev)
-{
-	int err;
-	struct omapflash_info *info;
-	struct flash_platform_data *pdata = pdev->dev.platform_data;
-	struct resource *res = pdev->resource;
-	unsigned long size = res->end - res->start + 1;
-
-	info = kzalloc(sizeof(struct omapflash_info), GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
-
-	if (!request_mem_region(res->start, size, "flash")) {
-		err = -EBUSY;
-		goto out_free_info;
-	}
-
-	info->map.virt		= ioremap(res->start, size);
-	if (!info->map.virt) {
-		err = -ENOMEM;
-		goto out_release_mem_region;
-	}
-	info->map.name		= dev_name(&pdev->dev);
-	info->map.phys		= res->start;
-	info->map.size		= size;
-	info->map.bankwidth	= pdata->width;
-	info->map.set_vpp	= omap_set_vpp;
-
-	simple_map_init(&info->map);
-	info->mtd = do_map_probe(pdata->map_name, &info->map);
-	if (!info->mtd) {
-		err = -EIO;
-		goto out_iounmap;
-	}
-	info->mtd->owner = THIS_MODULE;
-
-	info->mtd->dev.parent = &pdev->dev;
-
-#ifdef CONFIG_MTD_PARTITIONS
-	err = parse_mtd_partitions(info->mtd, part_probes, &info->parts, 0);
-	if (err > 0)
-		add_mtd_partitions(info->mtd, info->parts, err);
-	else if (err <= 0 && pdata->parts)
-		add_mtd_partitions(info->mtd, pdata->parts, pdata->nr_parts);
-	else
-#endif
-		add_mtd_device(info->mtd);
-
-	platform_set_drvdata(pdev, info);
-
-	return 0;
-
-out_iounmap:
-	iounmap(info->map.virt);
-out_release_mem_region:
-	release_mem_region(res->start, size);
-out_free_info:
-	kfree(info);
-
-	return err;
-}
-
-static int __exit omapflash_remove(struct platform_device *pdev)
-{
-	struct omapflash_info *info = platform_get_drvdata(pdev);
-
-	platform_set_drvdata(pdev, NULL);
-
-	if (info) {
-		if (info->parts) {
-			del_mtd_partitions(info->mtd);
-			kfree(info->parts);
-		} else
-			del_mtd_device(info->mtd);
-		map_destroy(info->mtd);
-		release_mem_region(info->map.phys, info->map.size);
-		iounmap((void __iomem *) info->map.virt);
-		kfree(info);
-	}
-
-	return 0;
-}
-
-static struct platform_driver omapflash_driver = {
-	.remove	= __exit_p(omapflash_remove),
-	.driver = {
-		.name	= "omapflash",
-		.owner	= THIS_MODULE,
-	},
-};
-
-static int __init omapflash_init(void)
-{
-	return platform_driver_probe(&omapflash_driver, omapflash_probe);
-}
-
-static void __exit omapflash_exit(void)
-{
-	platform_driver_unregister(&omapflash_driver);
-}
-
-module_init(omapflash_init);
-module_exit(omapflash_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("MTD NOR map driver for TI OMAP boards");
-MODULE_ALIAS("platform:omapflash");

