From: Sriramakrishnan <srk@ti.com>
Subject: [PATCH] am3517evm : add nand support
Date: Thu, 29 Oct 2009 21:34:58 +0530
Message-ID: <1256832298-14266-1-git-send-email-srk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52810 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbZJ2QE7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 12:04:59 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9TG512q022226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 29 Oct 2009 11:05:03 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sriramakrishnan <srk@ti.com>

Enable Nand support on am3517evm

Signed-off-by: Sriramakrishnan <srk@ti.com>
---
This patch builds on the am3517evm board support patch submitted earlier.
http://marc.info/?l=linux-omap&m=125673923227266&w=2

 arch/arm/configs/am3517_evm_defconfig |  103 ++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/board-am3517evm.c |  104 ++++++++++++++++++++++++++++++++-
 2 files changed, 204 insertions(+), 3 deletions(-)
 mode change 100644 => 100755 arch/arm/mach-omap2/board-am3517evm.c

diff --git a/arch/arm/configs/am3517_evm_defconfig b/arch/arm/configs/am3517_evm_defconfig
index 787f295..aa9ea34 100644
--- a/arch/arm/configs/am3517_evm_defconfig
+++ b/arch/arm/configs/am3517_evm_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.32-rc5
-# Wed Oct 28 15:47:47 2009
+# Thu Oct 29 20:50:11 2009
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -457,7 +457,90 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_CONNECTOR is not set
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_TESTS is not set
+CONFIG_MTD_CONCAT=y
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+# CONFIG_MTD_AFS_PARTS is not set
+# CONFIG_MTD_AR7_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+# CONFIG_MTD_CFI is not set
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+CONFIG_MTD_NAND=y
+# CONFIG_MTD_NAND_VERIFY_WRITE is not set
+# CONFIG_MTD_NAND_ECC_SMC is not set
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
+# CONFIG_MTD_NAND_GPIO is not set
+CONFIG_MTD_NAND_OMAP2=y
+# CONFIG_MTD_NAND_OMAP_PREFETCH is not set
+CONFIG_MTD_NAND_IDS=y
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+# CONFIG_MTD_NAND_PLATFORM is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# LPDDR flash memory drivers
+#
+# CONFIG_MTD_LPDDR is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
@@ -759,6 +842,21 @@ CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_ZLIB=y
+# CONFIG_JFFS2_LZO is not set
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
+# CONFIG_JFFS2_CMODE_NONE is not set
+CONFIG_JFFS2_CMODE_PRIORITY=y
+# CONFIG_JFFS2_CMODE_SIZE is not set
+# CONFIG_JFFS2_CMODE_FAVOURLZO is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_SQUASHFS is not set
 # CONFIG_VXFS_FS is not set
@@ -1051,6 +1149,7 @@ CONFIG_CRC32=y
 # CONFIG_CRC7 is not set
 CONFIG_LIBCRC32C=y
 CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
 CONFIG_DECOMPRESS_GZIP=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
old mode 100644
new mode 100755
index 23cf949..c326f12
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -21,16 +21,117 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand.h>
+
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
 #include <plat/board.h>
+#include <plat/gpmc.h>
+#include <plat/nand.h>
 #include <plat/common.h>
 
+#define GPMC_CS0_BASE  0x60
+#define GPMC_CS_SIZE   0x30
+
+#define NAND_BLOCK_SIZE        SZ_128K
+
+static struct mtd_partition am3517evm_nand_partitions[] = {
+/* All the partition sizes are listed in terms of NAND block size */
+{
+	.name           = "xloader-nand",
+	.offset         = 0,
+	.size           = 4*(SZ_128K),
+	.mask_flags     = MTD_WRITEABLE
+},
+{
+	.name           = "uboot-nand",
+	.offset         = MTDPART_OFS_APPEND,
+	.size           = 14*(SZ_128K),
+	.mask_flags     = MTD_WRITEABLE
+},
+{
+	.name           = "params-nand",
+	.offset         = MTDPART_OFS_APPEND,
+	.size           = 2*(SZ_128K)
+},
+{
+	.name           = "linux-nand",
+	.offset         = MTDPART_OFS_APPEND,
+	.size           = 40*(SZ_128K)
+},
+{
+	.name           = "jffs2-nand",
+	.size           = MTDPART_SIZ_FULL,
+	.offset         = MTDPART_OFS_APPEND,
+},
+};
+
+static struct omap_nand_platform_data am3517evm_nand_data = {
+	.parts          = am3517evm_nand_partitions,
+	.nr_parts       = ARRAY_SIZE(am3517evm_nand_partitions),
+	.nand_setup     = NULL,
+	.dma_channel    = -1,           /* disable DMA in OMAP NAND driver */
+	.dev_ready      = NULL,
+};
+
+static struct resource am3517evm_nand_resource = {
+	.flags          = IORESOURCE_MEM,
+};
+
+static struct platform_device am3517evm_nand_device = {
+	.name           = "omap2-nand",
+	.id             = 0,
+	.dev            = {
+			.platform_data  = &am3517evm_nand_data,
+	},
+	.num_resources  = 1,
+	.resource       = &am3517evm_nand_resource,
+};
+
+void __init am3517evm_flash_init(void)
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
+		am3517evm_nand_data.cs   = nandcs;
+		am3517evm_nand_data.gpmc_cs_baseaddr = (void *)(gpmc_base_add +
+					GPMC_CS0_BASE + nandcs*GPMC_CS_SIZE);
+		am3517evm_nand_data.gpmc_baseaddr   = (void *) (gpmc_base_add);
+
+		if (platform_device_register(&am3517evm_nand_device) < 0)
+			printk(KERN_ERR "Unable to register NAND device\n");
+
+	}
+}
+
+
+
 /*
- * Board initialization
+ *  initialization
  */
 static struct omap_board_config_kernel am3517_evm_config[] __initdata = {
 };
@@ -54,6 +155,7 @@ static void __init am3517_evm_init(void)
 				ARRAY_SIZE(am3517_evm_devices));
 
 	omap_serial_init();
+	am3517evm_flash_init();
 }
 
 static void __init am3517_evm_map_io(void)
-- 
1.6.2.4

