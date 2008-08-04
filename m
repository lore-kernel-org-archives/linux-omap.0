From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH 3/3 v2] OMAP3 Beagle: Enable nand and jffs2 support in defconfig
Date: Mon, 04 Aug 2008 17:58:38 +0200
Message-ID: <4897272E.2050905@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090201070907070004080402"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:19323 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755371AbYHDP6l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 11:58:41 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1022490fgg.17
        for <linux-omap@vger.kernel.org>; Mon, 04 Aug 2008 08:58:40 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Steve Sakoman <steve@sakoman.com>

This is a multi-part message in MIME format.
--------------090201070907070004080402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

From: Steve Sakoman <steve@sakoman.com>, Dirk Behme <dirk.behme@gmail.com>

Enable nand and jffs2 in defconfig

Signed-off-by: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Dirk Behme <dirk.behme@gmail.com>



--------------090201070907070004080402
Content-Type: text/plain;
 name="3_nand.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="3_nand.txt"

Index: linux-beagle/arch/arm/configs/omap3_beagle_defconfig
===================================================================
--- linux-beagle.orig/arch/arm/configs/omap3_beagle_defconfig
+++ linux-beagle/arch/arm/configs/omap3_beagle_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.26-rc3-omap1
-# Tue May 27 22:23:14 2008
+# Linux kernel version: 2.6.26-rc8-omap1
+# Fri Jul  4 10:19:23 2008
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -170,9 +170,9 @@ CONFIG_ARCH_OMAP3=y
 #
 # OMAP Feature Selections
 #
-CONFIG_OMAP_DEBUG_SRAM_PATCH=y
 # CONFIG_OMAP_DEBUG_POWERDOMAIN is not set
 # CONFIG_OMAP_DEBUG_CLOCKDOMAIN is not set
+# CONFIG_OMAP_SMARTREFLEX is not set
 # CONFIG_OMAP_RESET_CLOCKS is not set
 CONFIG_OMAP_BOOT_TAG=y
 CONFIG_OMAP_BOOT_REASON=y
@@ -415,7 +415,83 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_CONNECTOR is not set
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
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
+CONFIG_MTD_NAND_OMAP2=y
+CONFIG_MTD_NAND_IDS=y
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+# CONFIG_MTD_NAND_PLATFORM is not set
+# CONFIG_MTD_ALAUDA is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
@@ -791,6 +867,7 @@ CONFIG_USB_MUSB_LOGLEVEL=0
 #
 # CONFIG_USB_ACM is not set
 # CONFIG_USB_PRINTER is not set
+# CONFIG_USB_WDM is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
@@ -837,6 +914,7 @@ CONFIG_USB_MON=y
 # CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_IOWARRIOR is not set
 # CONFIG_USB_TEST is not set
+# CONFIG_USB_ISIGHTFW is not set
 CONFIG_USB_GADGET=y
 # CONFIG_USB_GADGET_DEBUG is not set
 # CONFIG_USB_GADGET_DEBUG_FILES is not set
@@ -873,6 +951,7 @@ CONFIG_MMC=y
 CONFIG_MMC_BLOCK=y
 CONFIG_MMC_BLOCK_BOUNCE=y
 # CONFIG_SDIO_UART is not set
+# CONFIG_MMC_TEST is not set
 
 #
 # MMC/SD Host Controller Drivers
@@ -909,6 +988,7 @@ CONFIG_RTC_INTF_DEV=y
 # CONFIG_RTC_DRV_M41T80 is not set
 CONFIG_RTC_DRV_TWL4030=y
 # CONFIG_RTC_DRV_S35390A is not set
+# CONFIG_RTC_DRV_FM3130 is not set
 
 #
 # SPI RTC drivers
@@ -1001,6 +1081,17 @@ CONFIG_TMPFS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+# CONFIG_JFFS2_LZO is not set
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_MINIX_FS is not set
@@ -1235,6 +1326,8 @@ CONFIG_CRC_CCITT=y
 CONFIG_CRC32=y
 # CONFIG_CRC7 is not set
 CONFIG_LIBCRC32C=y
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y

--------------090201070907070004080402--
