From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 03/39] ARM: OMAP2+: gpmc: register details for nand driver
Date: Tue, 1 May 2012 17:36:22 +0530
Message-ID: <93464215b662bfdafc75eb689fbc03fce16d1796.1335873032.git.afzal@ti.com>
References: <cover.1335873032.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33027 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754006Ab2EAMX2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 May 2012 08:23:28 -0400
In-Reply-To: <cover.1335873032.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, balbi@ti.com, dwmw2@infradead.org, kyungmin.park@samsung.com, gregkh@linuxfoundation.org, nm@ti.com, grinberg@compulab.co.il, notasas@gmail.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

If peripheral connected is NAND, update NAND drivers platform data
with NAND related register addresses so that NAND driver can handle
GPMC NAND operations by itself

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c             |   25 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/gpmc.h |   16 ++++++++++++++++
 arch/arm/plat-omap/include/plat/nand.h |    1 +
 3 files changed, 42 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index c8d07bb..657ce95 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -30,6 +30,7 @@
 
 #include <asm/mach-types.h>
 #include <plat/gpmc.h>
+#include <plat/nand.h>
 
 #include <plat/sdrc.h>
 
@@ -891,6 +892,28 @@ static int __init gpmc_init(void)
 }
 postcore_initcall(gpmc_init);
 
+static __devinit void gpmc_update_nand_reg(struct gpmc *gpmc,
+				struct omap_nand_platform_data *nand)
+{
+	int cs = nand->cs;
+
+	nand->reg.gpmc_status = gpmc->io_base + GPMC_STATUS;
+	nand->reg.gpmc_nand_command = gpmc->io_base + GPMC_CS0_OFFSET +
+				GPMC_CS_NAND_COMMAND + GPMC_CS_SIZE * cs;
+	nand->reg.gpmc_nand_address = gpmc->io_base + GPMC_CS0_OFFSET +
+				GPMC_CS_NAND_ADDRESS + GPMC_CS_SIZE * cs;
+	nand->reg.gpmc_nand_data = gpmc->io_base + GPMC_CS0_OFFSET +
+				GPMC_CS_NAND_DATA + GPMC_CS_SIZE * cs;
+	nand->reg.gpmc_prefetch_config1 = gpmc->io_base + GPMC_PREFETCH_CONFIG1;
+	nand->reg.gpmc_prefetch_config2 = gpmc->io_base + GPMC_PREFETCH_CONFIG2;
+	nand->reg.gpmc_prefetch_control = gpmc->io_base + GPMC_PREFETCH_CONTROL;
+	nand->reg.gpmc_prefetch_status = gpmc->io_base + GPMC_PREFETCH_STATUS;
+	nand->reg.gpmc_ecc_config = gpmc->io_base + GPMC_ECC_CONFIG;
+	nand->reg.gpmc_ecc_control = gpmc->io_base + GPMC_ECC_CONTROL;
+	nand->reg.gpmc_ecc_size_config = gpmc->io_base + GPMC_ECC_SIZE_CONFIG;
+	nand->reg.gpmc_ecc1_result = gpmc->io_base + GPMC_ECC1_RESULT;
+}
+
 static inline int gpmc_waitpin_is_reserved(struct gpmc *gpmc, unsigned waitpin)
 {
 	return gpmc->waitpin_map & (0x1 << waitpin);
@@ -1427,6 +1450,8 @@ static __devinit int gpmc_probe(struct platform_device *pdev)
 
 	for (i = 0, gdq = gp->device_pdata, gd = gpmc->device;
 			(i < gp->num_device) && (*gdq); i++, gdq++) {
+		if ((*gdq)->is_nand)
+			gpmc_update_nand_reg(gpmc, (*gdq)->pdata);
 		ret = gpmc_setup_device(gpmc, gd, *gdq);
 		if (IS_ERR_VALUE(ret))
 			dev_err(gpmc->dev, "gpmc setup on %s failed\n",
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index c5cf020..976a8f0 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -207,6 +207,7 @@ struct gpmc_device_pdata {
 	unsigned		per_res_cnt;
 	struct gpmc_cs_data	*cs_data;
 	unsigned		num_cs;
+	bool			is_nand;
 };
 
 struct gpmc_pdata {
@@ -216,6 +217,21 @@ struct gpmc_pdata {
 	struct gpmc_device_pdata	**device_pdata;
 };
 
+struct gpmc_nand_regs {
+	void __iomem	*gpmc_status;
+	void __iomem	*gpmc_nand_command;
+	void __iomem	*gpmc_nand_address;
+	void __iomem	*gpmc_nand_data;
+	void __iomem	*gpmc_prefetch_config1;
+	void __iomem	*gpmc_prefetch_config2;
+	void __iomem	*gpmc_prefetch_control;
+	void __iomem	*gpmc_prefetch_status;
+	void __iomem	*gpmc_ecc_config;
+	void __iomem	*gpmc_ecc_control;
+	void __iomem	*gpmc_ecc_size_config;
+	void __iomem	*gpmc_ecc1_result;
+};
+
 extern int gpmc_cs_reconfigure(char *name, int id, struct gpmc_cs_data *cs);
 extern int omap_init_gpmc(struct gpmc_pdata *pdata);
 
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
1.7.10

