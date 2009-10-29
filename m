From: Sriramakrishnan <srk@ti.com>
Subject: [PATCH] omap3evm : enable nand support
Date: Thu, 29 Oct 2009 18:32:08 +0530
Message-ID: <1256821328-28765-1-git-send-email-srk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54833 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753206AbZJ2NCI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Oct 2009 09:02:08 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9TD2Aro012897
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 29 Oct 2009 08:02:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sriramakrishnan <srk@ti.com>

Enable Nand suport on the OMAP3EVM.

Signed-off-by: Sriramakrishnan <srk@ti.com>
---
This patch has been generated against the tip of for-next branch.

 arch/arm/configs/omap3_evm_defconfig |    2 +
 arch/arm/mach-omap2/board-omap3evm.c |  102 ++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
index d5ff477..5675281 100644
--- a/arch/arm/configs/omap3_evm_defconfig
+++ b/arch/arm/configs/omap3_evm_defconfig
@@ -516,6 +516,8 @@ CONFIG_MTD_NAND=y
 # CONFIG_MTD_NAND_ECC_SMC is not set
 # CONFIG_MTD_NAND_MUSEUM_IDS is not set
 # CONFIG_MTD_NAND_GPIO is not set
+CONFIG_MTD_NAND_OMAP2=y
+# CONFIG_MTD_NAND_OMAP_PREFETCH is not set
 CONFIG_MTD_NAND_IDS=y
 # CONFIG_MTD_NAND_DISKONCHIP is not set
 # CONFIG_MTD_NAND_NANDSIM is not set
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 5d2310e..91772f2 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -27,6 +27,11 @@
 #include <linux/i2c/twl4030.h>
 #include <linux/usb/otg.h>
 
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand.h>
+
+
 #include <linux/regulator/machine.h>
 
 #include <mach/hardware.h>
@@ -36,6 +41,8 @@
 
 #include <plat/board.h>
 #include <plat/mux.h>
+#include <plat/gpmc.h>
+#include <plat/nand.h>
 #include <plat/usb.h>
 #include <plat/common.h>
 #include <plat/mcspi.h>
@@ -44,6 +51,11 @@
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "mmc-twl4030.h"
 
+#define GPMC_CS0_BASE	0x60
+#define GPMC_CS_SIZE	0x30
+
+#define NAND_BLOCK_SIZE	SZ_128K
+
 #define OMAP3_EVM_TS_GPIO	175
 
 #define OMAP3EVM_ETHR_START	0x2c000000
@@ -51,6 +63,95 @@
 #define OMAP3EVM_ETHR_GPIO_IRQ	176
 #define OMAP3EVM_SMC911X_CS	5
 
+
+static struct mtd_partition omap3evm_nand_partitions[] = {
+	/* All the partition sizes are listed in terms of NAND block size */
+	{
+		.name           = "xloader-nand",
+		.offset         = 0,
+		.size           = 4*(SZ_128K),
+		.mask_flags     = MTD_WRITEABLE
+	},
+	{
+		.name           = "uboot-nand",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 14*(SZ_128K),
+		.mask_flags     = MTD_WRITEABLE
+	},
+	{
+		.name           = "params-nand",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 2*(SZ_128K)
+	},
+	{
+		.name           = "linux-nand",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 40*(SZ_128K)
+	},
+	{
+		.name           = "jffs2-nand",
+		.size           = MTDPART_SIZ_FULL,
+		.offset         = MTDPART_OFS_APPEND,
+	},
+};
+
+static struct omap_nand_platform_data omap3evm_nand_data = {
+	.parts          = omap3evm_nand_partitions,
+	.nr_parts       = ARRAY_SIZE(omap3evm_nand_partitions),
+	.nand_setup     = NULL,
+	.dma_channel    = -1,           /* disable DMA in OMAP NAND driver */
+	.dev_ready      = NULL,
+};
+
+static struct resource omap3evm_nand_resource = {
+	.flags          = IORESOURCE_MEM,
+};
+
+static struct platform_device omap3evm_nand_device = {
+	.name           = "omap2-nand",
+	.id             = 0,
+	.dev            = {
+		.platform_data  = &omap3evm_nand_data,
+	},
+	.num_resources  = 1,
+	.resource       = &omap3evm_nand_resource,
+};
+
+void __init omap3evm_flash_init(void)
+{
+	u8 cs = 0;
+	u8 nandcs = GPMC_CS_NUM + 1;
+	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
+
+	while (cs < GPMC_CS_NUM) {
+		u32 ret = 0;
+		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+
+		if ((ret & 0xC00) == 0x800) {
+			/* Found it!! */
+			if (nandcs > GPMC_CS_NUM)
+				nandcs = cs;
+		}
+		cs++;
+	}
+	if (nandcs > GPMC_CS_NUM) {
+		printk(KERN_INFO "NAND: Unable to find configuration "
+			" in GPMC\n ");
+		return;
+	}
+
+	if (nandcs < GPMC_CS_NUM) {
+		omap3evm_nand_data.cs   = nandcs;
+		omap3evm_nand_data.gpmc_cs_baseaddr = (void *)(gpmc_base_add +
+					GPMC_CS0_BASE + nandcs*GPMC_CS_SIZE);
+		omap3evm_nand_data.gpmc_baseaddr   = (void *) (gpmc_base_add);
+
+		if (platform_device_register(&omap3evm_nand_device) < 0) {
+			printk(KERN_ERR "Unable to register NAND device\n");
+			}
+	}
+}
+
 static struct resource omap3evm_smc911x_resources[] = {
 	[0] =	{
 		.start	= OMAP3EVM_ETHR_START,
@@ -358,6 +459,7 @@ static void __init omap3_evm_init(void)
 	usb_nop_xceiv_register();
 #endif
 	usb_musb_init();
+	omap3evm_flash_init();
 	ads7846_dev_init();
 }
 
-- 
1.6.2.4

