From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH 1/2] ARM: OMAP: Kconfig: replace ARCH_OMAP243X with
	ARCH_OMAP2430
Date: Tue, 20 Mar 2007 17:07:49 -0700
Message-ID: <20070321000826.983707000@mvista.com>
References: <20070321000748.659921000@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=Kconfig-OMAP243x.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 arch/arm/configs/omap_2430sdp_defconfig |  322 ++++++++++++++++++++++++++++----
 arch/arm/mach-omap2/prcm-regs.h         |    4 
 drivers/usb/musb/musbdefs.h             |    2 
 drivers/usb/musb/omap2430.h             |    2 
 drivers/usb/musb/plat_uds.c             |    2 
 5 files changed, 287 insertions(+), 45 deletions(-)

Index: dev/arch/arm/configs/omap_2430sdp_defconfig
===================================================================
--- dev.orig/arch/arm/configs/omap_2430sdp_defconfig
+++ dev/arch/arm/configs/omap_2430sdp_defconfig
@@ -1,18 +1,24 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.19-omap1
-# Sun Dec  3 13:58:24 2006
+# Linux kernel version: 2.6.21-rc3-omap1
+# Mon Mar 19 22:43:37 2007
 #
 CONFIG_ARM=y
+CONFIG_SYS_SUPPORTS_APM_EMULATION=y
+CONFIG_GENERIC_GPIO=y
 # CONFIG_GENERIC_TIME is not set
 CONFIG_MMU=y
+# CONFIG_NO_IOPORT is not set
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 CONFIG_HARDIRQS_SW_RESEND=y
 CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+# CONFIG_ARCH_HAS_ILOG2_U32 is not set
+# CONFIG_ARCH_HAS_ILOG2_U64 is not set
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_ZONE_DMA=y
 CONFIG_VECTORS_BASE=0xffff0000
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
@@ -21,6 +27,7 @@ CONFIG_DEFCONFIG_LIST="/lib/modules/$UNA
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 
 #
@@ -31,6 +38,7 @@ CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_IPC_NS is not set
+CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
@@ -38,7 +46,9 @@ CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
@@ -77,7 +87,9 @@ CONFIG_KMOD=y
 # Block layer
 #
 CONFIG_BLOCK=y
+# CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
 
 #
 # IO Schedulers
@@ -111,10 +123,12 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # CONFIG_ARCH_IMX is not set
 # CONFIG_ARCH_IOP32X is not set
 # CONFIG_ARCH_IOP33X is not set
+# CONFIG_ARCH_IOP13XX is not set
 # CONFIG_ARCH_IXP4XX is not set
 # CONFIG_ARCH_IXP2000 is not set
 # CONFIG_ARCH_IXP23XX is not set
 # CONFIG_ARCH_L7200 is not set
+# CONFIG_ARCH_NS9XXX is not set
 # CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
 # CONFIG_ARCH_RPC is not set
@@ -139,10 +153,12 @@ CONFIG_OMAP_BOOT_TAG=y
 # CONFIG_OMAP_COMPONENT_VERSION is not set
 # CONFIG_OMAP_GPIO_SWITCH is not set
 CONFIG_OMAP_MUX=y
-CONFIG_OMAP_MUX_DEBUG=y
-CONFIG_OMAP_MUX_WARNINGS=y
+# CONFIG_OMAP_MUX_DEBUG is not set
+# CONFIG_OMAP_MUX_WARNINGS is not set
 # CONFIG_OMAP_STI is not set
 CONFIG_OMAP_MCBSP=y
+# CONFIG_OMAP_MMU_FWK is not set
+# CONFIG_OMAP_MBOX_FWK is not set
 CONFIG_OMAP_MPU_TIMER=y
 # CONFIG_OMAP_32K_TIMER is not set
 CONFIG_OMAP_DM_TIMER=y
@@ -163,6 +179,7 @@ CONFIG_ARCH_OMAP2430=y
 #
 # OMAP Board Type
 #
+# CONFIG_MACH_NOKIA_N800 is not set
 # CONFIG_MACH_OMAP_H4 is not set
 CONFIG_MACH_OMAP_2430SDP=y
 # CONFIG_MACH_OMAP_APOLLON is not set
@@ -190,6 +207,7 @@ CONFIG_ARM_THUMB=y
 # CONFIG_CPU_DCACHE_DISABLE is not set
 # CONFIG_CPU_DCACHE_WRITETHROUGH is not set
 # CONFIG_CPU_BPREDICT_DISABLE is not set
+# CONFIG_OUTER_CACHE is not set
 
 #
 # Bus support
@@ -203,10 +221,11 @@ CONFIG_ARM_THUMB=y
 #
 # Kernel Features
 #
-# CONFIG_PREEMPT is not set
+CONFIG_PREEMPT=y
 # CONFIG_NO_IDLE_HZ is not set
 CONFIG_HZ=100
-# CONFIG_AEABI is not set
+CONFIG_AEABI=y
+CONFIG_OABI_COMPAT=y
 # CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
@@ -217,6 +236,7 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
 # CONFIG_LEDS is not set
 CONFIG_ALIGNMENT_TRAP=y
 
@@ -227,6 +247,7 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/ram0 rw console=ttyS0,115200n8 initrd=0x80600000,8M ramdisk_size=8192"
 # CONFIG_XIP_KERNEL is not set
+# CONFIG_KEXEC is not set
 
 #
 # CPU Frequency scaling
@@ -251,13 +272,15 @@ CONFIG_FPE_NWFPE=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_AOUT is not set
 CONFIG_BINFMT_MISC=y
-# CONFIG_ARTHUR is not set
 
 #
 # Power management options
 #
-# CONFIG_PM is not set
-# CONFIG_APM is not set
+CONFIG_PM=y
+# CONFIG_PM_LEGACY is not set
+# CONFIG_PM_DEBUG is not set
+# CONFIG_PM_SYSFS_DEPRECATED is not set
+# CONFIG_APM_EMULATION is not set
 
 #
 # Networking
@@ -274,7 +297,9 @@ CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
 # CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
 CONFIG_NET_KEY=y
+# CONFIG_NET_KEY_MIGRATE is not set
 CONFIG_INET=y
 # CONFIG_IP_MULTICAST is not set
 # CONFIG_IP_ADVANCED_ROUTER is not set
@@ -300,6 +325,7 @@ CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
@@ -357,6 +383,7 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 # CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
 
 #
@@ -379,6 +406,7 @@ CONFIG_MTD_CMDLINE_PARTS=y
 # User Modules And Translation Layers
 #
 CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
 CONFIG_MTD_BLOCK=y
 # CONFIG_FTL is not set
 # CONFIG_NFTL is not set
@@ -444,7 +472,11 @@ CONFIG_MTD_OMAP_NOR=y
 #
 # OneNAND Flash Device Drivers
 #
-# CONFIG_MTD_ONENAND is not set
+CONFIG_MTD_ONENAND=y
+CONFIG_MTD_ONENAND_VERIFY_WRITE=y
+# CONFIG_MTD_ONENAND_GENERIC is not set
+CONFIG_MTD_ONENAND_OMAP2=y
+# CONFIG_MTD_ONENAND_OTP is not set
 
 #
 # Parallel port support
@@ -454,6 +486,7 @@ CONFIG_MTD_OMAP_NOR=y
 #
 # Plug and Play support
 #
+# CONFIG_PNPACPI is not set
 
 #
 # Block devices
@@ -462,11 +495,11 @@ CONFIG_MTD_OMAP_NOR=y
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_UB is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=16384
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
@@ -474,8 +507,43 @@ CONFIG_BLK_DEV_INITRD=y
 # SCSI device support
 #
 # CONFIG_RAID_ATTRS is not set
-# CONFIG_SCSI is not set
+CONFIG_SCSI=m
+# CONFIG_SCSI_TGT is not set
 # CONFIG_SCSI_NETLINK is not set
+CONFIG_SCSI_PROC_FS=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=m
+# CONFIG_CHR_DEV_ST is not set
+# CONFIG_CHR_DEV_OSST is not set
+# CONFIG_BLK_DEV_SR is not set
+CONFIG_CHR_DEV_SG=m
+# CONFIG_CHR_DEV_SCH is not set
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+# CONFIG_SCSI_MULTI_LUN is not set
+# CONFIG_SCSI_CONSTANTS is not set
+# CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
+
+#
+# SCSI Transports
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+# CONFIG_SCSI_SAS_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
+
+#
+# SCSI low-level drivers
+#
+# CONFIG_ISCSI_TCP is not set
+# CONFIG_SCSI_DEBUG is not set
 
 #
 # Serial ATA (prod) and Parallel ATA (experimental) drivers
@@ -581,6 +649,7 @@ CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_NEWTON is not set
 # CONFIG_KEYBOARD_STOWAWAY is not set
 CONFIG_KEYBOARD_OMAP=y
+# CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
@@ -638,16 +707,16 @@ CONFIG_WATCHDOG_NOWAYOUT=y
 #
 # CONFIG_SOFT_WATCHDOG is not set
 CONFIG_OMAP_WATCHDOG=y
+
+#
+# USB-based Watchdog Cards
+#
+# CONFIG_USBPCWATCHDOG is not set
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_OMAP=y
-# CONFIG_OMAP_RNG is not set
 # CONFIG_NVRAM is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_RAW_DRIVER is not set
 
 #
@@ -717,7 +786,11 @@ CONFIG_TWL4030_CORE=y
 #
 # Misc devices
 #
-# CONFIG_TIFM_CORE is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
 
 #
 # LED devices
@@ -741,26 +814,34 @@ CONFIG_TWL4030_CORE=y
 # Digital Video Broadcasting Devices
 #
 # CONFIG_DVB is not set
+# CONFIG_USB_DABUSB is not set
 
 #
 # Graphics support
 #
-CONFIG_FIRMWARE_EDID=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 CONFIG_FB=y
+CONFIG_FIRMWARE_EDID=y
+# CONFIG_FB_DDC is not set
 # CONFIG_FB_CFB_FILLRECT is not set
 # CONFIG_FB_CFB_COPYAREA is not set
 # CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_SVGALIB is not set
 # CONFIG_FB_MACMODES is not set
 # CONFIG_FB_BACKLIGHT is not set
 # CONFIG_FB_MODE_HELPERS is not set
 # CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frambuffer hardware drivers
+#
 # CONFIG_FB_S1D13XXX is not set
-# CONFIG_FB_VIRTUAL is not set
 CONFIG_FB_OMAP=y
 # CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
 # CONFIG_FB_OMAP_LCD_MIPID is not set
 # CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
 CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
+# CONFIG_FB_VIRTUAL is not set
 
 #
 # Console display driver support
@@ -780,7 +861,6 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_LOGO_LINUX_CLUT224=y
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -788,25 +868,180 @@ CONFIG_LOGO_LINUX_CLUT224=y
 # CONFIG_SOUND is not set
 
 #
+# HID Devices
+#
+CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
+
+#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 # CONFIG_USB_ARCH_HAS_EHCI is not set
-# CONFIG_USB is not set
+CONFIG_USB=m
+# CONFIG_USB_DEBUG is not set
+
+#
+# Miscellaneous USB options
+#
+# CONFIG_USB_DEVICEFS is not set
+# CONFIG_USB_DYNAMIC_MINORS is not set
+CONFIG_USB_SUSPEND=y
+CONFIG_USB_OTG=y
+CONFIG_USB_OTG_WHITELIST=y
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_OHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+CONFIG_USB_MUSB_HDRC=m
+CONFIG_USB_MUSB_SOC=y
 
 #
-# Enable Host or Gadget support to see Inventra options
+# OMAP 243x high speed USB support
 #
+# CONFIG_USB_MUSB_HOST is not set
+# CONFIG_USB_MUSB_PERIPHERAL is not set
+CONFIG_USB_MUSB_OTG=y
+CONFIG_USB_GADGET_MUSB_HDRC=y
+CONFIG_USB_MUSB_HDRC_HCD=y
+# CONFIG_USB_INVENTRA_FIFO is not set
+CONFIG_USB_INVENTRA_DMA=y
+# CONFIG_USB_TI_CPPI_DMA is not set
+CONFIG_USB_INVENTRA_HCD_LOGGING=1
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
 #
 
 #
+# may also be needed; see USB_STORAGE Help for more information
+#
+CONFIG_USB_STORAGE=m
+# CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_DPCM is not set
+# CONFIG_USB_STORAGE_USBAT is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+# CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_KARMA is not set
+# CONFIG_USB_LIBUSUAL is not set
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=m
+# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_HID_FF is not set
+# CONFIG_USB_HIDDEV is not set
+
+#
+# USB HID Boot Protocol drivers
+#
+# CONFIG_USB_KBD is not set
+# CONFIG_USB_MOUSE is not set
+# CONFIG_USB_AIPTEK is not set
+# CONFIG_USB_WACOM is not set
+# CONFIG_USB_ACECAD is not set
+# CONFIG_USB_KBTAB is not set
+# CONFIG_USB_POWERMATE is not set
+# CONFIG_USB_TOUCHSCREEN is not set
+# CONFIG_USB_YEALINK is not set
+# CONFIG_USB_XPAD is not set
+# CONFIG_USB_ATI_REMOTE is not set
+# CONFIG_USB_ATI_REMOTE2 is not set
+# CONFIG_USB_KEYSPAN_REMOTE is not set
+# CONFIG_USB_APPLETOUCH is not set
+# CONFIG_USB_GTCO is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET_MII is not set
+# CONFIG_USB_USBNET is not set
+CONFIG_USB_MON=y
+
+#
+# USB port drivers
+#
+
+#
+# USB Serial Converter support
+#
+# CONFIG_USB_SERIAL is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_AUERSWALD is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_PHIDGET is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+
+#
+# USB DSL modem support
+#
+
+#
 # USB Gadget Support
 #
-# CONFIG_USB_GADGET is not set
+CONFIG_USB_GADGET=m
+CONFIG_USB_GADGET_DEBUG_FILES=y
+CONFIG_USB_GADGET_SELECTED=y
+# CONFIG_USB_GADGET_NET2280 is not set
+# CONFIG_USB_GADGET_PXA2XX is not set
+# CONFIG_USB_GADGET_GOKU is not set
+# CONFIG_USB_GADGET_LH7A40X is not set
+# CONFIG_USB_GADGET_OMAP is not set
+# CONFIG_USB_GADGET_AT91 is not set
+# CONFIG_USB_GADGET_DUMMY_HCD is not set
+CONFIG_USB_GADGET_DUALSPEED=y
+CONFIG_USB_ZERO=m
+# CONFIG_USB_ZERO_HNPTEST is not set
+CONFIG_USB_ETH=m
+CONFIG_USB_ETH_RNDIS=y
+CONFIG_USB_GADGETFS=m
+CONFIG_USB_FILE_STORAGE=m
+# CONFIG_USB_FILE_STORAGE_TEST is not set
+CONFIG_USB_G_SERIAL=m
+# CONFIG_USB_MIDI_GADGET is not set
 
 #
 # MMC/SD Card support
@@ -815,7 +1050,6 @@ CONFIG_MMC=y
 # CONFIG_MMC_DEBUG is not set
 CONFIG_MMC_BLOCK=y
 CONFIG_MMC_OMAP=y
-# CONFIG_MMC_TIFM_SD is not set
 
 #
 # Real Time Clock
@@ -824,11 +1058,6 @@ CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
 
 #
-# Synchronous Serial Interfaces (SSI)
-#
-# CONFIG_OMAP_TSC2101 is not set
-
-#
 # CBUS support
 #
 # CONFIG_CBUS is not set
@@ -901,7 +1130,6 @@ CONFIG_RAMFS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-# CONFIG_JFFS_FS is not set
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_FS_DEBUG=0
 CONFIG_JFFS2_FS_WRITEBUFFER=y
@@ -927,7 +1155,7 @@ CONFIG_JFFS2_CMODE_PRIORITY=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
-CONFIG_NFS_V4=y
+# CONFIG_NFS_V4 is not set
 # CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
@@ -935,8 +1163,7 @@ CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
-CONFIG_SUNRPC_GSS=y
-CONFIG_RPCSEC_GSS_KRB5=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
@@ -1011,6 +1238,11 @@ CONFIG_NLS_CODEPAGE_437=y
 # CONFIG_NLS_UTF8 is not set
 
 #
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # Profiling support
 #
 # CONFIG_PROFILING is not set
@@ -1022,33 +1254,34 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
+CONFIG_TIMER_STATS=y
 # CONFIG_DEBUG_SLAB is not set
+CONFIG_DEBUG_PREEMPT=y
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 CONFIG_DEBUG_MUTEXES=y
-# CONFIG_DEBUG_RWSEMS is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_INFO is not set
-# CONFIG_DEBUG_FS is not set
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
 CONFIG_FRAME_POINTER=y
 CONFIG_FORCED_INLINING=y
-# CONFIG_HEADERS_CHECK is not set
 # CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
 # CONFIG_DEBUG_USER is not set
-# CONFIG_DEBUG_WAITQ is not set
 # CONFIG_DEBUG_ERRORS is not set
-CONFIG_DEBUG_LL=y
-# CONFIG_DEBUG_ICEDCC is not set
+# CONFIG_DEBUG_LL is not set
 
 #
 # Security options
@@ -1064,6 +1297,7 @@ CONFIG_CRYPTO_ALGAPI=y
 CONFIG_CRYPTO_BLKCIPHER=y
 CONFIG_CRYPTO_MANAGER=y
 # CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
 # CONFIG_CRYPTO_NULL is not set
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=y
@@ -1072,9 +1306,13 @@ CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_PCBC=m
+# CONFIG_CRYPTO_LRW is not set
 CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_FCRYPT is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set
 # CONFIG_CRYPTO_SERPENT is not set
@@ -1088,6 +1326,7 @@ CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_DEFLATE is not set
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_TEST is not set
 
 #
@@ -1097,6 +1336,7 @@ CONFIG_CRYPTO_DES=y
 #
 # Library routines
 #
+CONFIG_BITREVERSE=y
 CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
 CONFIG_CRC32=y
@@ -1104,3 +1344,5 @@ CONFIG_LIBCRC32C=y
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y
 CONFIG_PLIST=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
Index: dev/arch/arm/mach-omap2/prcm-regs.h
===================================================================
--- dev.orig/arch/arm/mach-omap2/prcm-regs.h
+++ dev/arch/arm/mach-omap2/prcm-regs.h
@@ -240,7 +240,7 @@
 #define GPIO3_SYSCONFIG		__REG32((GPIOX_BASE(3) + 0x10))
 #define GPIO4_SYSCONFIG		__REG32((GPIOX_BASE(4) + 0x10))
 
-#if defined(CONFIG_ARCH_OMAP243X)
+#if defined(CONFIG_ARCH_OMAP2430)
 #define GPIO5_SYSCONFIG		__REG32((OMAP24XX_GPIO5_BASE + 0x10))
 #endif
 
@@ -332,7 +332,7 @@
 #define GPIO4_DEBOUNCENABLE	GPIO4_REG32(0x050)
 #define GPIO4_DEBOUNCINGTIME	GPIO4_REG32(0x054)
 
-#if defined(CONFIG_ARCH_OMAP243X)
+#if defined(CONFIG_ARCH_OMAP2430)
 /* GPIO 5 */
 #define GPIO5_REG32(offset)	__REG32((OMAP24XX_GPIO5_BASE + (offset)))
 #define GPIO5_IRQENABLE1	GPIO5_REG32(0x01C)
Index: dev/drivers/usb/musb/musbdefs.h
===================================================================
--- dev.orig/drivers/usb/musb/musbdefs.h
+++ dev/drivers/usb/musb/musbdefs.h
@@ -202,7 +202,7 @@ enum musb_g_ep0_state {
  * directly with the "flat" model, or after setting up an index register.
  */
 
-#if defined(CONFIG_ARCH_DAVINCI) || defined(CONFIG_ARCH_OMAP243X)
+#if defined(CONFIG_ARCH_DAVINCI) || defined(CONFIG_ARCH_OMAP2430)
 /* REVISIT indexed access seemed to
  * misbehave (on DaVinci) for at least peripheral IN ...
  */
Index: dev/drivers/usb/musb/omap2430.h
===================================================================
--- dev.orig/drivers/usb/musb/omap2430.h
+++ dev/drivers/usb/musb/omap2430.h
@@ -23,6 +23,6 @@
 #define OTG_INTERFSEL		HS_OTG(0x40c)
 #define OTG_SIMENABLE		HS_OTG(0x410)
 
-#endif	/* CONFIG_ARCH_OMAP243X */
+#endif	/* CONFIG_ARCH_OMAP2430 */
 
 #endif	/* __MUSB_OMAP243X_H__ */
Index: dev/drivers/usb/musb/plat_uds.c
===================================================================
--- dev.orig/drivers/usb/musb/plat_uds.c
+++ dev/drivers/usb/musb/plat_uds.c
@@ -1302,7 +1302,7 @@ static int __init musb_core_init(u16 wTy
 
 /*-------------------------------------------------------------------------*/
 
-#ifdef CONFIG_ARCH_OMAP243X
+#ifdef CONFIG_ARCH_OMAP2430
 
 static irqreturn_t generic_interrupt(int irq, void *__hci)
 {

--
