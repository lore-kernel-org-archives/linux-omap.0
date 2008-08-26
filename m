From: "vimal singh" <vimalsingh@ti.com>
Subject: [RESENDING][PATCH 1/2]OMAP3 NAND: Add NAND support on OMAP3430
Date: Tue, 26 Aug 2008 16:11:58 +0530 (IST)
Message-ID: <41054.192.168.10.89.1219747318.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34700 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239AbYHZKmE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Aug 2008 06:42:04 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7QAfw7K007029
	for <linux-omap@vger.kernel.org>; Tue, 26 Aug 2008 05:42:03 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id m7QAfugf022698
	for <linux-omap@vger.kernel.org>; Tue, 26 Aug 2008 05:41:57 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Teerth Reddy <teerth@ti.com>

This patch adds NAND support on 3430sdp board

Signed-off-by: Teerth Reddy <teerth@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp-flash.c |   88 ++++++++++++++++++++++++++++--
 arch/arm/plat-omap/include/mach/gpmc.h    |   10 +++
 2 files changed, 93 insertions(+), 5 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp-flash.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-3430sdp-flash.c
+++ linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp-flash.c
@@ -24,6 +24,7 @@
 #include <mach/onenand.h>
 #include <mach/board.h>
 #include <mach/gpmc.h>
+#include <mach/nand.h>

 static struct mtd_partition sdp_nor_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
@@ -137,6 +138,61 @@ static int sdp_onenand_setup(void __iome
 	/* Onenand setup does nothing at present */
 	return 0;
 }
+
+static struct mtd_partition sdp_nand_partitions[] = {
+	/* All the partition sizes are listed in terms of NAND block size */
+	{
+		.name           = "X-Loader-NAND",
+		.offset         = 0,
+		.size           = 4 * (64 * 2048),
+		.mask_flags     = MTD_WRITEABLE,        /* force read-only */
+	},
+	{
+		.name           = "U-Boot-NAND",
+		.offset         = MTDPART_OFS_APPEND,   /* Offset = 0x80000 */
+		.size           = 4 * (64 * 2048),
+		.mask_flags     = MTD_WRITEABLE,        /* force read-only */
+	},
+	{
+		.name           = "Boot Env-NAND",
+		.offset         = MTDPART_OFS_APPEND,   /* Offset = 0x100000 */
+		.size           = 2 * (64 * 2048),
+	},
+	{
+		.name           = "Kernel-NAND",
+		.offset         = MTDPART_OFS_APPEND,   /* Offset = 0x140000 */
+		.size           = 32 * (64 * 2048),
+	},
+	{
+		.name           = "File System - NAND",
+		.size           = MTDPART_SIZ_FULL,
+		.offset         = MTDPART_OFS_APPEND,   /* Offset = 0x540000 */
+	},
+};
+
+static struct omap_nand_platform_data sdp_nand_data = {
+	.parts          = sdp_nand_partitions,
+	.nr_parts       = ARRAY_SIZE(sdp_nand_partitions),
+	.nand_setup     = NULL,
+	.dma_channel    = -1,           /* disable DMA in OMAP NAND driver */
+	.dev_ready      = NULL,
+};
+
+static struct resource sdp_nand_resource = {
+	.flags          = IORESOURCE_MEM,
+};
+
+static struct platform_device sdp_nand_device = {
+	.name           = "omap2-nand",
+	.id             = 0,
+	.dev            = {
+	.platform_data  = &sdp_nand_data,
+	},
+	.num_resources  = 1,
+	.resource       = &sdp_nand_resource,
+};
+
+
 /**
  * sdp3430_flash_init - Identify devices connected to GPMC and register.
  *
@@ -145,7 +201,11 @@ static int sdp_onenand_setup(void __iome
 void __init sdp3430_flash_init(void)
 {
 	u8		cs = 0;
+	u8              nandcs = GPMC_CS_NUM + 1;
 	u8		onenandcs = GPMC_CS_NUM + 1;
+	unsigned long	gpmc_base_add;
+
+	gpmc_base_add   = OMAP34XX_GPMC_VIRT;

 	/* Configure start address and size of NOR device */
 	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
@@ -163,25 +223,43 @@ void __init sdp3430_flash_init(void)

 	while (cs < GPMC_CS_NUM) {
 		u32 ret = 0;
-		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
+		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);

 		/*
-		* xloader/Uboot would have programmed the oneNAND
+		* xloader/Uboot would have programmed the NAND/oneNAND
 		* base address for us This is a ugly hack. The proper
 		* way of doing this is to pass the setup of u-boot up
 		* to kernel using kernel params - something on the
 		* lines of machineID. Check if oneNAND is configured
 		*/
-		if ((ret & 0x3F) == (ONENAND_MAP >> 24))
+		if ((ret & 0xC00) == 0x800) {
+			/* Found it!! */
+			if (nandcs > GPMC_CS_NUM)
+				nandcs = cs;
+		} else {
+			ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
+			if ((ret & 0x3F) == (ONENAND_MAP >> 24))
 			onenandcs = cs;
+		}
 		cs++;
 	}
-	if (onenandcs > GPMC_CS_NUM) {
-		printk(KERN_INFO "OneNAND: Unable to find configuration "
+	if ((nandcs > GPMC_CS_NUM) && (onenandcs > GPMC_CS_NUM)) {
+		printk(KERN_INFO "NAND/OneNAND: Unable to find configuration "
 				" in GPMC\n ");
 		return;
 	}

+	if (nandcs < GPMC_CS_NUM) {
+		sdp_nand_data.cs        = nandcs;
+		sdp_nand_data.gpmc_cs_baseaddr   = (void *)(gpmc_base_add +
+					GPMC_CS0_BASE + nandcs*GPMC_CS_SIZE);
+		sdp_nand_data.gpmc_baseaddr     = (void *) (gpmc_base_add);
+
+		if (platform_device_register(&sdp_nand_device) < 0) {
+			printk(KERN_ERR "Unable to register NAND device\n");
+		}
+	}
+
 	if (onenandcs < GPMC_CS_NUM) {
 		sdp_onenand_data.cs = onenandcs;
 		if (platform_device_register(&sdp_onenand_device) < 0)
Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/gpmc.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/gpmc.h
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/gpmc.h
@@ -25,8 +25,18 @@
 #define GPMC_CS_NAND_ADDRESS	0x20
 #define GPMC_CS_NAND_DATA	0x24

+/*
+ * The following gpmc registers are being used by
+ * nand driver and hence is defined here.
+ * TBD: Move them to gpmc.c by providing appropriate
+ *  methods to read and write into these registers
+ */
+#define GPMC_IRQSTATUS		0x18
 #define GPMC_CONFIG		0x50
 #define GPMC_STATUS		0x54
+#define GPMC_CS0_BASE           0x60
+#define GPMC_CS_SIZE            0x30
+

 #define GPMC_CONFIG1_WRAPBURST_SUPP     (1 << 31)
 #define GPMC_CONFIG1_READMULTIPLE_SUPP  (1 << 30)


