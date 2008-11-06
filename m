From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 3/3] Enable touchscreen in pandora's defconfig
Date: Thu,  6 Nov 2008 21:49:58 +0200
Message-ID: <1226000998-22397-3-git-send-email-notasas@gmail.com>
References: <1226000998-22397-1-git-send-email-notasas@gmail.com>
 <1226000998-22397-2-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:27666 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbYKFTuZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2008 14:50:25 -0500
Received: by ey-out-2122.google.com with SMTP id 6so363104eyi.37
        for <linux-omap@vger.kernel.org>; Thu, 06 Nov 2008 11:50:22 -0800 (PST)
In-Reply-To: <1226000998-22397-2-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Grazvydas Ignotas <notasas@gmail.com>

This patch enables McSPI and ADS7846 driver in Pandora's defconfig.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/configs/omap3_pandora_defconfig |  227 ++++++++++++++++++++----------
 1 files changed, 151 insertions(+), 76 deletions(-)

diff --git a/arch/arm/configs/omap3_pandora_defconfig b/arch/arm/configs/omap3_pandora_defconfig
index ffed27d..1c2b7a2 100644
--- a/arch/arm/configs/omap3_pandora_defconfig
+++ b/arch/arm/configs/omap3_pandora_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.27-omap1
-# Sat Oct 18 14:12:19 2008
+# Linux kernel version: 2.6.28-rc3-omap1
+# Wed Nov  5 22:02:43 2008
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -22,8 +22,6 @@ CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
-CONFIG_ARCH_SUPPORTS_AOUT=y
-CONFIG_ZONE_DMA=y
 CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 CONFIG_VECTORS_BASE=0xffff0000
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
@@ -80,6 +78,7 @@ CONFIG_SIGNALFD=y
 CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
+CONFIG_AIO=y
 CONFIG_VM_EVENT_COUNTERS=y
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
@@ -88,15 +87,9 @@ CONFIG_SLAB=y
 # CONFIG_MARKERS is not set
 CONFIG_HAVE_OPROFILE=y
 # CONFIG_KPROBES is not set
-# CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is not set
-# CONFIG_HAVE_IOREMAP_PROT is not set
 CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
-# CONFIG_HAVE_ARCH_TRACEHOOK is not set
-# CONFIG_HAVE_DMA_ATTRS is not set
-# CONFIG_USE_GENERIC_SMP_HELPERS is not set
 CONFIG_HAVE_CLK=y
-CONFIG_PROC_PAGE_MONITOR=y
 CONFIG_HAVE_GENERIC_DMA_COHERENT=y
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
@@ -129,6 +122,7 @@ CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="anticipatory"
 CONFIG_CLASSIC_RCU=y
+# CONFIG_FREEZER is not set
 
 #
 # System Type
@@ -169,7 +163,7 @@ CONFIG_CLASSIC_RCU=y
 # CONFIG_ARCH_LH7A40X is not set
 # CONFIG_ARCH_DAVINCI is not set
 CONFIG_ARCH_OMAP=y
-# CONFIG_ARCH_MSM7X00A is not set
+# CONFIG_ARCH_MSM is not set
 
 #
 # TI OMAP Implementations
@@ -265,26 +259,30 @@ CONFIG_TICK_ONESHOT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+CONFIG_VMSPLIT_3G=y
+# CONFIG_VMSPLIT_2G is not set
+# CONFIG_VMSPLIT_1G is not set
+CONFIG_PAGE_OFFSET=0xC0000000
 # CONFIG_PREEMPT is not set
 CONFIG_HZ=128
 CONFIG_AEABI=y
 CONFIG_OABI_COMPAT=y
 CONFIG_ARCH_FLATMEM_HAS_HOLES=y
-# CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
+# CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
+# CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
 # CONFIG_SPARSEMEM_MANUAL is not set
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
-# CONFIG_SPARSEMEM_STATIC is not set
-# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
 CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
-CONFIG_ZONE_DMA_FLAG=1
-CONFIG_BOUNCE=y
+# CONFIG_PHYS_ADDR_T_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
+CONFIG_UNEVICTABLE_LRU=y
 # CONFIG_LEDS is not set
 CONFIG_ALIGNMENT_TRAP=y
 
@@ -298,9 +296,10 @@ CONFIG_CMDLINE=" debug "
 # CONFIG_KEXEC is not set
 
 #
-# CPU Frequency scaling
+# CPU Power Management
 #
 # CONFIG_CPU_FREQ is not set
+# CONFIG_CPU_IDLE is not set
 
 #
 # Floating point emulation
@@ -320,6 +319,8 @@ CONFIG_NEON=y
 # Userspace binary formats
 #
 CONFIG_BINFMT_ELF=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_HAVE_AOUT=y
 # CONFIG_BINFMT_AOUT is not set
 CONFIG_BINFMT_MISC=y
 
@@ -381,6 +382,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
+# CONFIG_NET_DSA is not set
 # CONFIG_VLAN_8021Q is not set
 # CONFIG_DECNET is not set
 # CONFIG_LLC2 is not set
@@ -401,14 +403,8 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
-
-#
-# Wireless
-#
-# CONFIG_CFG80211 is not set
-# CONFIG_WIRELESS_EXT is not set
-# CONFIG_MAC80211 is not set
-# CONFIG_IEEE80211 is not set
+# CONFIG_PHONET is not set
+# CONFIG_WIRELESS is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
 
@@ -477,6 +473,8 @@ CONFIG_MTD_CFI_I2=y
 #
 # Self-contained MTD device drivers
 #
+# CONFIG_MTD_DATAFLASH is not set
+# CONFIG_MTD_M25P80 is not set
 # CONFIG_MTD_SLRAM is not set
 # CONFIG_MTD_PHRAM is not set
 # CONFIG_MTD_MTDRAM is not set
@@ -492,6 +490,7 @@ CONFIG_MTD_NAND=y
 # CONFIG_MTD_NAND_VERIFY_WRITE is not set
 # CONFIG_MTD_NAND_ECC_SMC is not set
 # CONFIG_MTD_NAND_MUSEUM_IDS is not set
+# CONFIG_MTD_NAND_GPIO is not set
 CONFIG_MTD_NAND_OMAP2=y
 CONFIG_MTD_NAND_IDS=y
 # CONFIG_MTD_NAND_DISKONCHIP is not set
@@ -637,7 +636,22 @@ CONFIG_INPUT_MOUSE=y
 # CONFIG_MOUSE_GPIO is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
-# CONFIG_INPUT_TOUCHSCREEN is not set
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ADS7846=y
+# CONFIG_TOUCHSCREEN_FUJITSU is not set
+# CONFIG_TOUCHSCREEN_GUNZE is not set
+# CONFIG_TOUCHSCREEN_ELO is not set
+# CONFIG_TOUCHSCREEN_MTOUCH is not set
+# CONFIG_TOUCHSCREEN_INEXIO is not set
+# CONFIG_TOUCHSCREEN_MK712 is not set
+# CONFIG_TOUCHSCREEN_PENMOUNT is not set
+# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
+# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
+# CONFIG_TOUCHSCREEN_TSC2005 is not set
+# CONFIG_TOUCHSCREEN_TSC2102 is not set
+# CONFIG_TOUCHSCREEN_TSC210X is not set
+# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
+# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
 # CONFIG_INPUT_MISC is not set
 
 #
@@ -737,7 +751,26 @@ CONFIG_TWL4030_USB=y
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
 # CONFIG_I2C_DEBUG_CHIP is not set
-# CONFIG_SPI is not set
+CONFIG_SPI=y
+# CONFIG_SPI_DEBUG is not set
+CONFIG_SPI_MASTER=y
+
+#
+# SPI Master Controller Drivers
+#
+# CONFIG_SPI_BITBANG is not set
+CONFIG_SPI_OMAP24XX=y
+
+#
+# SPI Protocol Masters
+#
+# CONFIG_SPI_AT25 is not set
+# CONFIG_SPI_TSC2101 is not set
+# CONFIG_SPI_TSC2102 is not set
+# CONFIG_SPI_TSC210X is not set
+# CONFIG_SPI_TSC2301 is not set
+# CONFIG_SPI_SPIDEV is not set
+# CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
 CONFIG_GPIOLIB=y
 # CONFIG_DEBUG_GPIO is not set
@@ -758,9 +791,13 @@ CONFIG_GPIO_TWL4030=y
 #
 # SPI GPIO expanders:
 #
+# CONFIG_GPIO_MAX7301 is not set
+# CONFIG_GPIO_MCP23S08 is not set
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+# CONFIG_THERMAL_HWMON is not set
 # CONFIG_WATCHDOG is not set
 
 #
@@ -778,10 +815,14 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_HTC_EGPIO is not set
 # CONFIG_HTC_PASIC3 is not set
 CONFIG_TWL4030_CORE=y
+CONFIG_TWL4030_POWER=y
 # CONFIG_MFD_TMIO is not set
 # CONFIG_MFD_T7L66XB is not set
 # CONFIG_MFD_TC6387XB is not set
 # CONFIG_MFD_TC6393XB is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM8350_I2C is not set
 
 #
 # Multimedia devices
@@ -808,6 +849,7 @@ CONFIG_DAB=y
 CONFIG_FB=y
 # CONFIG_FIRMWARE_EDID is not set
 # CONFIG_FB_DDC is not set
+# CONFIG_FB_BOOT_VESA_SUPPORT is not set
 CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
@@ -828,6 +870,7 @@ CONFIG_FB_CFB_IMAGEBLIT=y
 #
 # CONFIG_FB_S1D13XXX is not set
 # CONFIG_FB_VIRTUAL is not set
+# CONFIG_FB_METRONOME is not set
 CONFIG_FB_OMAP=y
 # CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
 # CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
@@ -869,9 +912,33 @@ CONFIG_HID=y
 # USB Input Devices
 #
 CONFIG_USB_HID=y
-# CONFIG_USB_HIDINPUT_POWERBOOK is not set
-# CONFIG_HID_FF is not set
+# CONFIG_HID_PID is not set
 # CONFIG_USB_HIDDEV is not set
+
+#
+# Special HID drivers
+#
+# CONFIG_HID_COMPAT is not set
+# CONFIG_HID_A4TECH is not set
+# CONFIG_HID_APPLE is not set
+# CONFIG_HID_BELKIN is not set
+# CONFIG_HID_BRIGHT is not set
+# CONFIG_HID_CHERRY is not set
+# CONFIG_HID_CHICONY is not set
+# CONFIG_HID_CYPRESS is not set
+# CONFIG_HID_DELL is not set
+# CONFIG_HID_EZKEY is not set
+# CONFIG_HID_GYRATION is not set
+# CONFIG_HID_LOGITECH is not set
+# CONFIG_HID_MICROSOFT is not set
+# CONFIG_HID_MONTEREY is not set
+# CONFIG_HID_PANTHERLORD is not set
+# CONFIG_HID_PETALYNX is not set
+# CONFIG_HID_SAMSUNG is not set
+# CONFIG_HID_SONY is not set
+# CONFIG_HID_SUNPLUS is not set
+# CONFIG_THRUSTMASTER_FF is not set
+# CONFIG_ZEROPLUS_FF is not set
 CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
@@ -891,6 +958,8 @@ CONFIG_USB_OTG=y
 # CONFIG_USB_OTG_WHITELIST is not set
 # CONFIG_USB_OTG_BLACKLIST_HUB is not set
 CONFIG_USB_MON=y
+# CONFIG_USB_WUSB is not set
+# CONFIG_USB_WUSB_CBAF is not set
 
 #
 # USB Host Controller Drivers
@@ -902,6 +971,7 @@ CONFIG_USB_MON=y
 # CONFIG_USB_OHCI_HCD is not set
 # CONFIG_USB_SL811_HCD is not set
 # CONFIG_USB_R8A66597_HCD is not set
+# CONFIG_USB_HWA_HCD is not set
 CONFIG_USB_MUSB_HDRC=y
 CONFIG_USB_MUSB_SOC=y
 
@@ -924,6 +994,7 @@ CONFIG_USB_INVENTRA_DMA=y
 # CONFIG_USB_ACM is not set
 # CONFIG_USB_PRINTER is not set
 # CONFIG_USB_WDM is not set
+# CONFIG_USB_TMC is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
@@ -952,6 +1023,7 @@ CONFIG_USB_INVENTRA_DMA=y
 # CONFIG_USB_EMI62 is not set
 # CONFIG_USB_EMI26 is not set
 # CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_SEVSEG is not set
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_LCD is not set
@@ -968,22 +1040,25 @@ CONFIG_USB_INVENTRA_DMA=y
 # CONFIG_USB_IOWARRIOR is not set
 # CONFIG_USB_TEST is not set
 # CONFIG_USB_ISIGHTFW is not set
+# CONFIG_USB_VST is not set
 CONFIG_USB_GADGET=y
 # CONFIG_USB_GADGET_DEBUG is not set
 # CONFIG_USB_GADGET_DEBUG_FILES is not set
+CONFIG_USB_GADGET_VBUS_DRAW=2
 CONFIG_USB_GADGET_SELECTED=y
-# CONFIG_USB_GADGET_AMD5536UDC is not set
+# CONFIG_USB_GADGET_AT91 is not set
 # CONFIG_USB_GADGET_ATMEL_USBA is not set
 # CONFIG_USB_GADGET_FSL_USB2 is not set
-# CONFIG_USB_GADGET_NET2280 is not set
-# CONFIG_USB_GADGET_PXA25X is not set
-# CONFIG_USB_GADGET_M66592 is not set
-# CONFIG_USB_GADGET_PXA27X is not set
-# CONFIG_USB_GADGET_GOKU is not set
 # CONFIG_USB_GADGET_LH7A40X is not set
 # CONFIG_USB_GADGET_OMAP is not set
+# CONFIG_USB_GADGET_PXA25X is not set
+# CONFIG_USB_GADGET_PXA27X is not set
 # CONFIG_USB_GADGET_S3C2410 is not set
-# CONFIG_USB_GADGET_AT91 is not set
+# CONFIG_USB_GADGET_M66592 is not set
+# CONFIG_USB_GADGET_AMD5536UDC is not set
+# CONFIG_USB_GADGET_FSL_QE is not set
+# CONFIG_USB_GADGET_NET2280 is not set
+# CONFIG_USB_GADGET_GOKU is not set
 # CONFIG_USB_GADGET_DUMMY_HCD is not set
 CONFIG_USB_GADGET_DUALSPEED=y
 # CONFIG_USB_ZERO is not set
@@ -1000,7 +1075,7 @@ CONFIG_MMC=y
 # CONFIG_MMC_UNSAFE_RESUME is not set
 
 #
-# MMC/SD Card Drivers
+# MMC/SD/SDIO Card Drivers
 #
 CONFIG_MMC_BLOCK=y
 CONFIG_MMC_BLOCK_BOUNCE=y
@@ -1008,10 +1083,13 @@ CONFIG_MMC_BLOCK_BOUNCE=y
 # CONFIG_MMC_TEST is not set
 
 #
-# MMC/SD Host Controller Drivers
+# MMC/SD/SDIO Host Controller Drivers
 #
 # CONFIG_MMC_SDHCI is not set
 CONFIG_MMC_OMAP_HS=y
+# CONFIG_MMC_SPI is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_ACCESSIBILITY is not set
 # CONFIG_NEW_LEDS is not set
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
@@ -1048,17 +1126,26 @@ CONFIG_RTC_DRV_TWL4030=y
 #
 # SPI RTC drivers
 #
+# CONFIG_RTC_DRV_M41T94 is not set
+# CONFIG_RTC_DRV_DS1305 is not set
+# CONFIG_RTC_DRV_MAX6902 is not set
+# CONFIG_RTC_DRV_R9701 is not set
+# CONFIG_RTC_DRV_RS5C348 is not set
+# CONFIG_RTC_DRV_DS3234 is not set
 
 #
 # Platform RTC drivers
 #
 # CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1286 is not set
 # CONFIG_RTC_DRV_DS1511 is not set
 # CONFIG_RTC_DRV_DS1553 is not set
 # CONFIG_RTC_DRV_DS1742 is not set
 # CONFIG_RTC_DRV_STK17TA8 is not set
 # CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T35 is not set
 # CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_BQ4802 is not set
 # CONFIG_RTC_DRV_V3020 is not set
 
 #
@@ -1088,11 +1175,12 @@ CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XIP is not set
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
-# CONFIG_EXT4DEV_FS is not set
+# CONFIG_EXT4_FS is not set
 CONFIG_JBD=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
+CONFIG_FILE_LOCKING=y
 # CONFIG_XFS_FS is not set
 # CONFIG_OCFS2_FS is not set
 CONFIG_DNOTIFY=y
@@ -1129,6 +1217,7 @@ CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_SYSCTL=y
+CONFIG_PROC_PAGE_MONITOR=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 # CONFIG_TMPFS_POSIX_ACL is not set
@@ -1145,17 +1234,7 @@ CONFIG_TMPFS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-CONFIG_JFFS2_FS=y
-CONFIG_JFFS2_FS_DEBUG=0
-CONFIG_JFFS2_FS_WRITEBUFFER=y
-# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
-# CONFIG_JFFS2_SUMMARY is not set
-# CONFIG_JFFS2_FS_XATTR is not set
-# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
-CONFIG_JFFS2_ZLIB=y
-# CONFIG_JFFS2_LZO is not set
-CONFIG_JFFS2_RTIME=y
-# CONFIG_JFFS2_RUBIN is not set
+# CONFIG_JFFS2_FS is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_MINIX_FS is not set
@@ -1165,25 +1244,7 @@ CONFIG_JFFS2_RTIME=y
 # CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-CONFIG_NETWORK_FILESYSTEMS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
-# CONFIG_NFS_V3_ACL is not set
-CONFIG_NFS_V4=y
-CONFIG_ROOT_NFS=y
-# CONFIG_NFSD is not set
-CONFIG_LOCKD=y
-CONFIG_LOCKD_V4=y
-CONFIG_NFS_COMMON=y
-CONFIG_SUNRPC=y
-CONFIG_SUNRPC_GSS=y
-CONFIG_RPCSEC_GSS_KRB5=y
-# CONFIG_RPCSEC_GSS_SPKM3 is not set
-# CONFIG_SMB_FS is not set
-# CONFIG_CIFS is not set
-# CONFIG_NCP_FS is not set
-# CONFIG_CODA_FS is not set
-# CONFIG_AFS_FS is not set
+# CONFIG_NETWORK_FILESYSTEMS is not set
 
 #
 # Partition Types
@@ -1289,15 +1350,23 @@ CONFIG_DEBUG_INFO=y
 CONFIG_FRAME_POINTER=y
 # CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 # CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
 # CONFIG_FAULT_INJECTION is not set
 # CONFIG_LATENCYTOP is not set
-CONFIG_HAVE_FTRACE=y
-CONFIG_HAVE_DYNAMIC_FTRACE=y
-# CONFIG_FTRACE is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+
+#
+# Tracers
+#
+# CONFIG_FUNCTION_TRACER is not set
 # CONFIG_IRQSOFF_TRACER is not set
 # CONFIG_SCHED_TRACER is not set
 # CONFIG_CONTEXT_SWITCH_TRACER is not set
+# CONFIG_BOOT_TRACER is not set
+# CONFIG_STACK_TRACER is not set
+# CONFIG_DYNAMIC_PRINTK_DEBUG is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_KGDB is not set
@@ -1311,14 +1380,19 @@ CONFIG_HAVE_ARCH_KGDB=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
+# CONFIG_SECURITYFS is not set
 # CONFIG_SECURITY_FILE_CAPABILITIES is not set
 CONFIG_CRYPTO=y
 
 #
 # Crypto core or helper
 #
+# CONFIG_CRYPTO_FIPS is not set
 CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_AEAD=y
 CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_RNG=y
 CONFIG_CRYPTO_MANAGER=y
 # CONFIG_CRYPTO_GF128MUL is not set
 # CONFIG_CRYPTO_NULL is not set
@@ -1391,14 +1465,17 @@ CONFIG_CRYPTO_DES=y
 #
 # CONFIG_CRYPTO_DEFLATE is not set
 # CONFIG_CRYPTO_LZO is not set
+
+#
+# Random Number Generation
+#
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_HW=y
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
-# CONFIG_GENERIC_FIND_FIRST_BIT is not set
-# CONFIG_GENERIC_FIND_NEXT_BIT is not set
 CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_T10DIF is not set
@@ -1406,8 +1483,6 @@ CONFIG_CRC_CCITT=y
 CONFIG_CRC32=y
 # CONFIG_CRC7 is not set
 CONFIG_LIBCRC32C=y
-CONFIG_ZLIB_INFLATE=y
-CONFIG_ZLIB_DEFLATE=y
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
-- 
1.5.4.3

