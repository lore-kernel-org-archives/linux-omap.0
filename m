From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH] OMAP2EVM: Updates defconfig
Date: Wed, 20 Aug 2008 21:47:19 +0530
Message-ID: <dfeb90390808200917t3c48c99dod8557b098a61307e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:27854 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758355AbYHTQRW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 12:17:22 -0400
Received: by ti-out-0910.google.com with SMTP id b6so313468tic.23
        for <linux-omap@vger.kernel.org>; Wed, 20 Aug 2008 09:17:20 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch updates omap2evm defconfig with keypad and nand driver

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 arch/arm/configs/omap2_evm_defconfig |  196 ++++++++++++++++++++++++++++++----
 1 files changed, 173 insertions(+), 23 deletions(-)

diff --git a/arch/arm/configs/omap2_evm_defconfig
b/arch/arm/configs/omap2_evm_defconfig
index 9d5b30f..61f0965 100644
--- a/arch/arm/configs/omap2_evm_defconfig
+++ b/arch/arm/configs/omap2_evm_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.26-omap1
-# Wed Aug  6 17:05:50 2008
+# Linux kernel version: 2.6.27-rc3-omap1
+# Wed Aug 20 21:20:25 2008
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -12,6 +12,7 @@ CONFIG_MMU=y
 # CONFIG_NO_IOPORT is not set
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_HAVE_LATENCYTOP_SUPPORT=y
 CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 CONFIG_HARDIRQS_SW_RESEND=y
@@ -23,6 +24,7 @@ CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_ARCH_SUPPORTS_AOUT=y
 CONFIG_ZONE_DMA=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 CONFIG_VECTORS_BASE=0xffff0000
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

@@ -81,10 +83,16 @@ CONFIG_SLAB=y
 # CONFIG_MARKERS is not set
 CONFIG_HAVE_OPROFILE=y
 # CONFIG_KPROBES is not set
+# CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is not set
+# CONFIG_HAVE_IOREMAP_PROT is not set
 CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
+# CONFIG_HAVE_ARCH_TRACEHOOK is not set
 # CONFIG_HAVE_DMA_ATTRS is not set
+# CONFIG_USE_GENERIC_SMP_HELPERS is not set
+CONFIG_HAVE_CLK=y
 CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -101,6 +109,7 @@ CONFIG_BLOCK=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
 # CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set

 #
 # IO Schedulers
@@ -126,7 +135,6 @@ CONFIG_CLASSIC_RCU=y
 # CONFIG_ARCH_AT91 is not set
 # CONFIG_ARCH_CLPS7500 is not set
 # CONFIG_ARCH_CLPS711X is not set
-# CONFIG_ARCH_CO285 is not set
 # CONFIG_ARCH_EBSA110 is not set
 # CONFIG_ARCH_EP93XX is not set
 # CONFIG_ARCH_FOOTBRIDGE is not set
@@ -140,8 +148,11 @@ CONFIG_CLASSIC_RCU=y
 # CONFIG_ARCH_IXP2000 is not set
 # CONFIG_ARCH_IXP4XX is not set
 # CONFIG_ARCH_L7200 is not set
+# CONFIG_ARCH_KIRKWOOD is not set
 # CONFIG_ARCH_KS8695 is not set
 # CONFIG_ARCH_NS9XXX is not set
+# CONFIG_ARCH_LOKI is not set
+# CONFIG_ARCH_MV78XX0 is not set
 # CONFIG_ARCH_MXC is not set
 # CONFIG_ARCH_ORION5X is not set
 # CONFIG_ARCH_PNX4008 is not set
@@ -200,6 +211,7 @@ CONFIG_ARCH_OMAP2430=y
 #
 # CONFIG_MACH_OMAP_2430SDP is not set
 CONFIG_MACH_OMAP2EVM=y
+CONFIG_OMAP_TICK_GPTIMER=1

 #
 # Boot options
@@ -314,10 +326,6 @@ CONFIG_SUSPEND=y
 CONFIG_SUSPEND_FREEZER=y
 # CONFIG_APM_EMULATION is not set
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
-
-#
-# Networking
-#
 CONFIG_NET=y

 #
@@ -430,7 +438,84 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 # CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_CONNECTOR is not set
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
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
+# CONFIG_MTD_DATAFLASH is not set
+# CONFIG_MTD_M25P80 is not set
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
+# CONFIG_MTD_ONENAND is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
@@ -490,10 +575,10 @@ CONFIG_SCSI_WAIT_SCAN=m
 CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_ISCSI_TCP is not set
 # CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_DH is not set
 # CONFIG_ATA is not set
 # CONFIG_MD is not set
 CONFIG_NETDEVICES=y
-# CONFIG_NETDEVICES_MULTIQUEUE is not set
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
 # CONFIG_MACVLAN is not set
@@ -556,6 +641,7 @@ CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_NEWTON is not set
 # CONFIG_KEYBOARD_STOWAWAY is not set
 # CONFIG_KEYBOARD_OMAP is not set
+CONFIG_KEYBOARD_TWL4030=y
 # CONFIG_KEYBOARD_LM8323 is not set
 # CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_INPUT_MOUSE is not set
@@ -567,6 +653,7 @@ CONFIG_TOUCHSCREEN_ADS7846=y
 # CONFIG_TOUCHSCREEN_GUNZE is not set
 # CONFIG_TOUCHSCREEN_ELO is not set
 # CONFIG_TOUCHSCREEN_MTOUCH is not set
+# CONFIG_TOUCHSCREEN_INEXIO is not set
 # CONFIG_TOUCHSCREEN_MK712 is not set
 # CONFIG_TOUCHSCREEN_PENMOUNT is not set
 # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
@@ -575,6 +662,7 @@ CONFIG_TOUCHSCREEN_ADS7846=y
 # CONFIG_TOUCHSCREEN_TSC2102 is not set
 # CONFIG_TOUCHSCREEN_TSC210X is not set
 # CONFIG_TOUCHSCREEN_UCB1400 is not set
+# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
 # CONFIG_INPUT_MISC is not set

 #
@@ -587,6 +675,7 @@ CONFIG_TOUCHSCREEN_ADS7846=y
 # Character devices
 #
 CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
 # CONFIG_VT_HW_CONSOLE_BINDING is not set
@@ -623,26 +712,41 @@ CONFIG_HW_RANDOM_OMAP=y
 CONFIG_I2C=y
 CONFIG_I2C_BOARDINFO=y
 CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_HELPER_AUTO=y

 #
 # I2C Hardware Bus support
 #
+
+#
+# I2C system bus drivers (mostly embedded / system-on-chip)
+#
 # CONFIG_I2C_GPIO is not set
 # CONFIG_I2C_OCORES is not set
 CONFIG_I2C_OMAP=y
-# CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_SIMTEC is not set
+
+#
+# External I2C/SMBus adapter drivers
+#
+# CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_TAOS_EVM is not set
-# CONFIG_I2C_STUB is not set
+
+#
+# Other I2C/SMBus bus drivers
+#
 # CONFIG_I2C_PCA_PLATFORM is not set
+# CONFIG_I2C_STUB is not set

 #
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
+# CONFIG_AT24 is not set
 # CONFIG_SENSORS_EEPROM is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
+# CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_ISP1301_OMAP is not set
 # CONFIG_TPS65010 is not set
@@ -681,21 +785,25 @@ CONFIG_SPI_MASTER=y
 # CONFIG_SPI_TSC2301 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
-CONFIG_HAVE_GPIO_LIB=y
-
-#
-# GPIO Support
-#
+CONFIG_ARCH_REQUIRE_GPIOLIB=y
+CONFIG_GPIOLIB=y
+# CONFIG_GPIO_SYSFS is not set

 #
 # I2C GPIO expanders:
 #
+# CONFIG_GPIO_MAX732X is not set
 # CONFIG_GPIO_PCA953X is not set
 # CONFIG_GPIO_PCF857X is not set

 #
+# PCI GPIO expanders:
+#
+
+#
 # SPI GPIO expanders:
 #
+# CONFIG_GPIO_MAX7301 is not set
 # CONFIG_GPIO_MCP23S08 is not set
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
@@ -718,10 +826,14 @@ CONFIG_SSB_POSSIBLE=y
 #
 # Multifunction device drivers
 #
+# CONFIG_MFD_CORE is not set
 # CONFIG_MFD_SM501 is not set
-# CONFIG_MFD_ASIC3 is not set
 # CONFIG_HTC_EGPIO is not set
 # CONFIG_HTC_PASIC3 is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_MFD_T7L66XB is not set
+# CONFIG_MFD_TC6387XB is not set
+# CONFIG_MFD_TC6393XB is not set

 #
 # Multimedia devices
@@ -793,10 +905,6 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_LOGO_LINUX_CLUT224=y
-
-#
-# Sound
-#
 # CONFIG_SOUND is not set
 CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
@@ -818,11 +926,21 @@ CONFIG_MMC_BLOCK_BOUNCE=y
 #
 # MMC/SD Host Controller Drivers
 #
+# CONFIG_MMC_SDHCI is not set
 CONFIG_MMC_OMAP_HS=y
 # CONFIG_MMC_SPI is not set
 # CONFIG_NEW_LEDS is not set
 CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
+# CONFIG_DMADEVICES is not set
+
+#
+# Voltage and Current regulators
+#
+# CONFIG_REGULATOR is not set
+# CONFIG_REGULATOR_FIXED_VOLTAGE is not set
+# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
+# CONFIG_REGULATOR_BQ24022 is not set
 # CONFIG_UIO is not set

 #
@@ -894,9 +1012,25 @@ CONFIG_TMPFS=y
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
 # CONFIG_VXFS_FS is not set
 # CONFIG_MINIX_FS is not set
+# CONFIG_OMFS_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -907,13 +1041,12 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFS_V4 is not set
-# CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
+# CONFIG_NFSD is not set
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
-# CONFIG_SUNRPC_BIND34 is not set
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -998,8 +1131,18 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
 CONFIG_FRAME_POINTER=y
+# CONFIG_LATENCYTOP is not set
+CONFIG_HAVE_FTRACE=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+# CONFIG_FTRACE is not set
+# CONFIG_IRQSOFF_TRACER is not set
+# CONFIG_PREEMPT_TRACER is not set
+# CONFIG_SCHED_TRACER is not set
+# CONFIG_CONTEXT_SWITCH_TRACER is not set
 # CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_DEBUG_USER is not set

 #
@@ -1053,6 +1196,10 @@ CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_RMD128 is not set
+# CONFIG_CRYPTO_RMD160 is not set
+# CONFIG_CRYPTO_RMD256 is not set
+# CONFIG_CRYPTO_RMD320 is not set
 # CONFIG_CRYPTO_SHA1 is not set
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
@@ -1093,10 +1240,13 @@ CONFIG_BITREVERSE=y
 # CONFIG_GENERIC_FIND_NEXT_BIT is not set
 CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
+CONFIG_CRC_T10DIF=m
 # CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
 # CONFIG_CRC7 is not set
 CONFIG_LIBCRC32C=y
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
-- 
1.5.3.4
