From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 02/10] ARM: OMAP2+: gpmc-nand: update gpmc-nand regs
Date: Mon, 4 Jun 2012 12:16:20 +0530
Message-ID: <3ed5c0c89ed8d06fd67ea8f3d3181cb24aff4b7a.1338790117.git.afzal@ti.com>
References: <cover.1338790117.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54554 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753932Ab2FDHCM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jun 2012 03:02:12 -0400
In-Reply-To: <cover.1338790117.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, artem.bityutskiy@linux.intel.com, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: ivan.djelic@parrot.com, Afzal Mohammed <afzal@ti.com>

GPMC has NAND registers, update nand platform data with those details
so that NAND driver can configure those by itself instead of using
exported symbols.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc-nand.c        |    2 ++
 arch/arm/plat-omap/include/plat/nand.h |    1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 386dec8..d4e803c 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -108,6 +108,8 @@ int __init gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data)
 		gpmc_cs_configure(gpmc_nand_data->cs, GPMC_CONFIG_RDY_BSY, 1);
 	}
 
+	gpmc_update_nand_reg(&gpmc_nand_data->reg, gpmc_nand_data->cs);
+
 	err = platform_device_register(&gpmc_nand_device);
 	if (err < 0) {
 		dev_err(dev, "Unable to register NAND device\n");
diff --git a/arch/arm/plat-omap/include/plat/nand.h b/arch/arm/plat-omap/include/plat/nand.h
index 67fc506..86e4d9c 100644
--- a/arch/arm/plat-omap/include/plat/nand.h
+++ b/arch/arm/plat-omap/include/plat/nand.h
@@ -29,6 +29,7 @@ struct omap_nand_platform_data {
 	unsigned long		phys_base;
 	int			devsize;
 	enum omap_ecc           ecc_opt;
+	struct gpmc_nand_regs	reg;
 };
 
 /* minimum size for IO mapping */
-- 
1.7.10.2

