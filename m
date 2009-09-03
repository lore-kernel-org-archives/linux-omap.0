From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH-v2 3/3] OMAP: Zoom2: Enable NAND in defconfig
Date: Thu,  3 Sep 2009 14:26:20 -0500
Message-ID: <1252005980-17721-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57135 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753888AbZICTcO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Sep 2009 15:32:14 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n83JWB8U020242
	for <linux-omap@vger.kernel.org>; Thu, 3 Sep 2009 14:32:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

Enable NAND options by default in zoom2_defconfig file
Other changes in defconfig come from make menuconfig syncup

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/configs/omap_zoom2_defconfig |  224 +++++++++++++++++++++++----------
 1 files changed, 160 insertions(+), 64 deletions(-)

diff --git a/arch/arm/configs/omap_zoom2_defconfig b/arch/arm/configs/omap_zoom2_defconfig
index f1739fa..b16a38c 100644
--- a/arch/arm/configs/omap_zoom2_defconfig
+++ b/arch/arm/configs/omap_zoom2_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.30-omap1
-# Fri Jun 12 17:25:46 2009
+# Linux kernel version: 2.6.31-rc8-omap1
+# Thu Sep  3 13:52:59 2009
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -9,7 +9,6 @@ CONFIG_GENERIC_GPIO=y
 CONFIG_GENERIC_TIME=y
 CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_MMU=y
-# CONFIG_NO_IOPORT is not set
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_HAVE_LATENCYTOP_SUPPORT=y
@@ -18,13 +17,12 @@ CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 CONFIG_HARDIRQS_SW_RESEND=y
 CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
-# CONFIG_ARCH_HAS_ILOG2_U32 is not set
-# CONFIG_ARCH_HAS_ILOG2_U64 is not set
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 CONFIG_VECTORS_BASE=0xffff0000
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_CONSTRUCTORS=y
 
 #
 # General setup
@@ -77,7 +75,6 @@ CONFIG_UID16=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 CONFIG_KALLSYMS_EXTRA_PASS=y
-# CONFIG_STRIP_ASM_SYMS is not set
 CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
@@ -90,7 +87,12 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_AIO=y
+
+#
+# Performance Counters
+#
 CONFIG_VM_EVENT_COUNTERS=y
+# CONFIG_STRIP_ASM_SYMS is not set
 CONFIG_COMPAT_BRK=y
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
@@ -102,6 +104,10 @@ CONFIG_HAVE_OPROFILE=y
 CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
 CONFIG_HAVE_CLK=y
+
+#
+# GCOV-based kernel profiling
+#
 # CONFIG_SLOW_WORK is not set
 CONFIG_HAVE_GENERIC_DMA_COHERENT=y
 CONFIG_SLABINFO=y
@@ -114,7 +120,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_BLOCK=y
-# CONFIG_LBD is not set
+CONFIG_LBDAF=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_BLK_DEV_INTEGRITY is not set
 
@@ -141,13 +147,14 @@ CONFIG_FREEZER=y
 # CONFIG_ARCH_VERSATILE is not set
 # CONFIG_ARCH_AT91 is not set
 # CONFIG_ARCH_CLPS711X is not set
+# CONFIG_ARCH_GEMINI is not set
 # CONFIG_ARCH_EBSA110 is not set
 # CONFIG_ARCH_EP93XX is not set
-# CONFIG_ARCH_GEMINI is not set
 # CONFIG_ARCH_FOOTBRIDGE is not set
+# CONFIG_ARCH_MXC is not set
+# CONFIG_ARCH_STMP3XXX is not set
 # CONFIG_ARCH_NETX is not set
 # CONFIG_ARCH_H720X is not set
-# CONFIG_ARCH_IMX is not set
 # CONFIG_ARCH_IOP13XX is not set
 # CONFIG_ARCH_IOP32X is not set
 # CONFIG_ARCH_IOP33X is not set
@@ -156,25 +163,25 @@ CONFIG_FREEZER=y
 # CONFIG_ARCH_IXP4XX is not set
 # CONFIG_ARCH_L7200 is not set
 # CONFIG_ARCH_KIRKWOOD is not set
-# CONFIG_ARCH_KS8695 is not set
-# CONFIG_ARCH_NS9XXX is not set
 # CONFIG_ARCH_LOKI is not set
 # CONFIG_ARCH_MV78XX0 is not set
-# CONFIG_ARCH_MXC is not set
 # CONFIG_ARCH_ORION5X is not set
+# CONFIG_ARCH_MMP is not set
+# CONFIG_ARCH_KS8695 is not set
+# CONFIG_ARCH_NS9XXX is not set
+# CONFIG_ARCH_W90X900 is not set
 # CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
-# CONFIG_ARCH_MMP is not set
+# CONFIG_ARCH_MSM is not set
 # CONFIG_ARCH_RPC is not set
 # CONFIG_ARCH_SA1100 is not set
 # CONFIG_ARCH_S3C2410 is not set
 # CONFIG_ARCH_S3C64XX is not set
 # CONFIG_ARCH_SHARK is not set
 # CONFIG_ARCH_LH7A40X is not set
+# CONFIG_ARCH_U300 is not set
 # CONFIG_ARCH_DAVINCI is not set
 CONFIG_ARCH_OMAP=y
-# CONFIG_ARCH_MSM is not set
-# CONFIG_ARCH_W90X900 is not set
 
 #
 # TI OMAP Implementations
@@ -209,13 +216,13 @@ CONFIG_ARCH_OMAP3430=y
 #
 # OMAP Board Type
 #
-# CONFIG_MACH_NOKIA_RX51 is not set
-# CONFIG_MACH_OMAP_LDP is not set
-# CONFIG_MACH_OMAP_3430SDP is not set
-# CONFIG_MACH_OMAP3EVM is not set
 # CONFIG_MACH_OMAP3_BEAGLE is not set
+# CONFIG_MACH_OMAP_LDP is not set
 # CONFIG_MACH_OVERO is not set
+# CONFIG_MACH_OMAP3EVM is not set
 # CONFIG_MACH_OMAP3_PANDORA is not set
+# CONFIG_MACH_OMAP_3430SDP is not set
+# CONFIG_MACH_NOKIA_RX51 is not set
 CONFIG_MACH_OMAP_ZOOM2=y
 
 #
@@ -244,7 +251,6 @@ CONFIG_ARM_THUMB=y
 # CONFIG_CPU_DCACHE_DISABLE is not set
 # CONFIG_CPU_BPREDICT_DISABLE is not set
 CONFIG_HAS_TLS_REG=y
-# CONFIG_OUTER_CACHE is not set
 # CONFIG_ARM_ERRATA_430973 is not set
 # CONFIG_ARM_ERRATA_458693 is not set
 # CONFIG_ARM_ERRATA_460075 is not set
@@ -272,7 +278,6 @@ CONFIG_PAGE_OFFSET=0xC0000000
 CONFIG_HZ=128
 CONFIG_AEABI=y
 CONFIG_OABI_COMPAT=y
-# CONFIG_ARCH_HAS_HOLES_MEMORYMODEL is not set
 # CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
 # CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
 # CONFIG_HIGHMEM is not set
@@ -287,11 +292,12 @@ CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_PHYS_ADDR_T_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
-CONFIG_UNEVICTABLE_LRU=y
 CONFIG_HAVE_MLOCK=y
 CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
 # CONFIG_LEDS is not set
 CONFIG_ALIGNMENT_TRAP=y
+# CONFIG_UACCESS_WITH_MEMCPY is not set
 
 #
 # Boot options
@@ -406,6 +412,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 # CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
 # CONFIG_NET_SCHED is not set
 # CONFIG_DCB is not set
 
@@ -439,7 +446,92 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_SYS_HYPERVISOR is not set
 CONFIG_CONNECTOR=y
 CONFIG_PROC_EVENTS=y
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+CONFIG_MTD_CONCAT=y
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_TESTS is not set
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
+CONFIG_MTD_NAND_VERIFY_WRITE=y
+CONFIG_MTD_NAND_ECC_SMC=y
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
+# CONFIG_MTD_NAND_GPIO is not set
+CONFIG_MTD_NAND_OMAP2=y
+CONFIG_MTD_NAND_IDS=y
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+# CONFIG_MTD_NAND_PLATFORM is not set
+# CONFIG_MTD_ALAUDA is not set
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
@@ -453,6 +545,7 @@ CONFIG_BLK_DEV_RAM_SIZE=16384
 # CONFIG_BLK_DEV_XIP is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
+# CONFIG_MG_DISK is not set
 CONFIG_MISC_DEVICES=y
 # CONFIG_ICS932S401 is not set
 # CONFIG_OMAP_STI is not set
@@ -466,6 +559,7 @@ CONFIG_MISC_DEVICES=y
 # CONFIG_EEPROM_AT24 is not set
 # CONFIG_EEPROM_AT25 is not set
 # CONFIG_EEPROM_LEGACY is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_EEPROM_93CX6 is not set
 CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
@@ -489,10 +583,6 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_BLK_DEV_SR is not set
 # CONFIG_CHR_DEV_SG is not set
 # CONFIG_CHR_DEV_SCH is not set
-
-#
-# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
-#
 # CONFIG_SCSI_MULTI_LUN is not set
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
@@ -517,7 +607,6 @@ CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_ATA is not set
 # CONFIG_MD is not set
 CONFIG_NETDEVICES=y
-CONFIG_COMPAT_NET_DEV_OPS=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
 # CONFIG_MACVLAN is not set
@@ -562,6 +651,8 @@ CONFIG_SMSC911X=y
 # CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
 # CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
 # CONFIG_B44 is not set
+# CONFIG_KS8842 is not set
+# CONFIG_KS8851 is not set
 CONFIG_NETDEV_1000=y
 CONFIG_NETDEV_10000=y
 
@@ -619,6 +710,7 @@ CONFIG_TOUCHSCREEN_ADS7846=y
 # CONFIG_TOUCHSCREEN_AD7879_I2C is not set
 # CONFIG_TOUCHSCREEN_AD7879_SPI is not set
 # CONFIG_TOUCHSCREEN_AD7879 is not set
+# CONFIG_TOUCHSCREEN_EETI is not set
 # CONFIG_TOUCHSCREEN_FUJITSU is not set
 # CONFIG_TOUCHSCREEN_GUNZE is not set
 # CONFIG_TOUCHSCREEN_ELO is not set
@@ -629,11 +721,10 @@ CONFIG_TOUCHSCREEN_ADS7846=y
 # CONFIG_TOUCHSCREEN_PENMOUNT is not set
 # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
 # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
-# CONFIG_TOUCHSCREEN_TSC2005 is not set
-# CONFIG_TOUCHSCREEN_TSC210X is not set
 # CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
 # CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
 # CONFIG_TOUCHSCREEN_TSC2007 is not set
+# CONFIG_TOUCHSCREEN_W90X900 is not set
 # CONFIG_INPUT_MISC is not set
 
 #
@@ -693,6 +784,7 @@ CONFIG_I2C_HELPER_AUTO=y
 #
 # I2C system bus drivers (mostly embedded / system-on-chip)
 #
+# CONFIG_I2C_DESIGNWARE is not set
 # CONFIG_I2C_GPIO is not set
 # CONFIG_I2C_OCORES is not set
 CONFIG_I2C_OMAP=y
@@ -718,9 +810,6 @@ CONFIG_I2C_OMAP=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_TWL4030_MADC is not set
-# CONFIG_TWL4030_POWEROFF is not set
-# CONFIG_SENSORS_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
@@ -793,7 +882,9 @@ CONFIG_POWER_SUPPLY=y
 # CONFIG_POWER_SUPPLY_DEBUG is not set
 # CONFIG_PDA_POWER is not set
 # CONFIG_BATTERY_DS2760 is not set
+# CONFIG_BATTERY_DS2782 is not set
 # CONFIG_BATTERY_BQ27x00 is not set
+# CONFIG_BATTERY_MAX17040 is not set
 # CONFIG_HWMON is not set
 # CONFIG_THERMAL is not set
 # CONFIG_THERMAL_HWMON is not set
@@ -805,6 +896,7 @@ CONFIG_WATCHDOG_NOWAYOUT=y
 #
 # CONFIG_SOFT_WATCHDOG is not set
 # CONFIG_OMAP_WATCHDOG is not set
+# CONFIG_TWL4030_WATCHDOG is not set
 
 #
 # USB-based Watchdog Cards
@@ -835,23 +927,9 @@ CONFIG_TWL4030_CORE=y
 # CONFIG_MFD_WM8400 is not set
 # CONFIG_MFD_WM8350_I2C is not set
 # CONFIG_MFD_PCF50633 is not set
-
-#
-# Multimedia devices
-#
-
-#
-# Multimedia core support
-#
-# CONFIG_VIDEO_DEV is not set
-# CONFIG_DVB_CORE is not set
-# CONFIG_VIDEO_MEDIA is not set
-
-#
-# Multimedia drivers
-#
-CONFIG_DAB=y
-# CONFIG_USB_DABUSB is not set
+# CONFIG_AB3100_CORE is not set
+# CONFIG_EZX_PCAP is not set
+# CONFIG_MEDIA_SUPPORT is not set
 
 #
 # Graphics support
@@ -883,6 +961,11 @@ CONFIG_SND_SUPPORT_OLD_API=y
 CONFIG_SND_VERBOSE_PROCFS=y
 # CONFIG_SND_VERBOSE_PRINTK is not set
 # CONFIG_SND_DEBUG is not set
+# CONFIG_SND_RAWMIDI_SEQ is not set
+# CONFIG_SND_OPL3_LIB_SEQ is not set
+# CONFIG_SND_OPL4_LIB_SEQ is not set
+# CONFIG_SND_SBAWE_SEQ is not set
+# CONFIG_SND_EMU10K1_SEQ is not set
 CONFIG_SND_DRIVERS=y
 # CONFIG_SND_DUMMY is not set
 # CONFIG_SND_MTPAV is not set
@@ -916,7 +999,7 @@ CONFIG_USB_HID=y
 # CONFIG_HID_CHERRY is not set
 # CONFIG_HID_CHICONY is not set
 # CONFIG_HID_CYPRESS is not set
-# CONFIG_DRAGONRISE_FF is not set
+# CONFIG_HID_DRAGONRISE is not set
 # CONFIG_HID_EZKEY is not set
 # CONFIG_HID_KYE is not set
 # CONFIG_HID_GYRATION is not set
@@ -930,10 +1013,11 @@ CONFIG_USB_HID=y
 # CONFIG_HID_SAMSUNG is not set
 # CONFIG_HID_SONY is not set
 # CONFIG_HID_SUNPLUS is not set
-# CONFIG_GREENASIA_FF is not set
+# CONFIG_HID_GREENASIA is not set
+# CONFIG_HID_SMARTJOYPLUS is not set
 # CONFIG_HID_TOPSEED is not set
-# CONFIG_THRUSTMASTER_FF is not set
-# CONFIG_ZEROPLUS_FF is not set
+# CONFIG_HID_THRUSTMASTER is not set
+# CONFIG_HID_ZEROPLUS is not set
 CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
@@ -1030,9 +1114,11 @@ CONFIG_USB_MUSB_DEBUG=y
 # CONFIG_USB_IDMOUSE is not set
 # CONFIG_USB_FTDI_ELAN is not set
 # CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_SISUSBVGA is not set
 # CONFIG_USB_LD is not set
 # CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_TEST is not set
 # CONFIG_USB_ISIGHTFW is not set
 # CONFIG_USB_VST is not set
 CONFIG_USB_GADGET=y
@@ -1047,18 +1133,21 @@ CONFIG_USB_GADGET_SELECTED=y
 # CONFIG_USB_GADGET_OMAP is not set
 # CONFIG_USB_GADGET_PXA25X is not set
 # CONFIG_USB_GADGET_PXA27X is not set
-# CONFIG_USB_GADGET_S3C2410 is not set
+# CONFIG_USB_GADGET_S3C_HSOTG is not set
 # CONFIG_USB_GADGET_IMX is not set
+# CONFIG_USB_GADGET_S3C2410 is not set
 # CONFIG_USB_GADGET_M66592 is not set
 # CONFIG_USB_GADGET_AMD5536UDC is not set
 # CONFIG_USB_GADGET_FSL_QE is not set
 # CONFIG_USB_GADGET_CI13XXX is not set
 # CONFIG_USB_GADGET_NET2280 is not set
 # CONFIG_USB_GADGET_GOKU is not set
+# CONFIG_USB_GADGET_LANGWELL is not set
 # CONFIG_USB_GADGET_DUMMY_HCD is not set
 CONFIG_USB_GADGET_DUALSPEED=y
-CONFIG_USB_ZERO=y
+CONFIG_USB_ZERO=m
 # CONFIG_USB_ZERO_HNPTEST is not set
+# CONFIG_USB_AUDIO is not set
 # CONFIG_USB_ETH is not set
 # CONFIG_USB_GADGETFS is not set
 # CONFIG_USB_FILE_STORAGE is not set
@@ -1128,6 +1217,7 @@ CONFIG_RTC_INTF_DEV=y
 # CONFIG_RTC_DRV_S35390A is not set
 # CONFIG_RTC_DRV_FM3130 is not set
 # CONFIG_RTC_DRV_RX8581 is not set
+# CONFIG_RTC_DRV_RX8025 is not set
 
 #
 # SPI RTC drivers
@@ -1164,8 +1254,11 @@ CONFIG_REGULATOR=y
 # CONFIG_REGULATOR_DEBUG is not set
 # CONFIG_REGULATOR_FIXED_VOLTAGE is not set
 # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
+# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
 # CONFIG_REGULATOR_BQ24022 is not set
+# CONFIG_REGULATOR_MAX1586 is not set
 CONFIG_REGULATOR_TWL4030=y
+# CONFIG_REGULATOR_LP3971 is not set
 # CONFIG_UIO is not set
 # CONFIG_STAGING is not set
 
@@ -1188,10 +1281,12 @@ CONFIG_JBD=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 CONFIG_FS_POSIX_ACL=y
-CONFIG_FILE_LOCKING=y
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_BTRFS_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
 CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
@@ -1246,6 +1341,7 @@ CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+# CONFIG_JFFS2_FS is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_SQUASHFS is not set
 # CONFIG_VXFS_FS is not set
@@ -1262,6 +1358,7 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
+# CONFIG_NFS_V4_1 is not set
 CONFIG_ROOT_NFS=y
 # CONFIG_NFSD is not set
 CONFIG_LOCKD=y
@@ -1365,6 +1462,7 @@ CONFIG_SCHED_DEBUG=y
 # CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_OBJECTS is not set
 # CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_KMEMLEAK is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
@@ -1393,17 +1491,15 @@ CONFIG_DEBUG_INFO=y
 # CONFIG_PAGE_POISONING is not set
 CONFIG_HAVE_FUNCTION_TRACER=y
 CONFIG_TRACING_SUPPORT=y
-
-#
-# Tracers
-#
+CONFIG_FTRACE=y
 # CONFIG_FUNCTION_TRACER is not set
 # CONFIG_IRQSOFF_TRACER is not set
 # CONFIG_SCHED_TRACER is not set
-# CONFIG_CONTEXT_SWITCH_TRACER is not set
-# CONFIG_EVENT_TRACER is not set
+# CONFIG_ENABLE_DEFAULT_TRACERS is not set
 # CONFIG_BOOT_TRACER is not set
-# CONFIG_TRACE_BRANCH_PROFILING is not set
+CONFIG_BRANCH_PROFILE_NONE=y
+# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
+# CONFIG_PROFILE_ALL_BRANCHES is not set
 # CONFIG_STACK_TRACER is not set
 # CONFIG_KMEMTRACE is not set
 # CONFIG_WORKQUEUE_TRACER is not set
-- 
1.6.3.3.334.g916e1

