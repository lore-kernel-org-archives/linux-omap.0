From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Update palmte_defconfig to enable GPIO switch
Date: Sat, 19 May 2007 16:57:51 +0200
Message-ID: <464F106F.2000604@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030802020303020305090009"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

This is a multi-part message in MIME format.
--------------030802020303020305090009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Update palmte_defconfig to enable CONFIG_OMAP_GPIO_SWITCH. Else, we get

arch/arm/mach-omap1/built-in.o: In function `omap_palmte_init':
board-palmte.c:(.init.text+0xbc0): undefined reference to 
`omap_register_gpio_switches'

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------030802020303020305090009
Content-Type: text/plain;
	name="update_palmte_defconfig_to_enable_gpio_switch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="update_palmte_defconfig_to_enable_gpio_switch.txt"

Index: linux-osk/arch/arm/configs/palmte_defconfig
===================================================================
--- linux-osk.orig/arch/arm/configs/palmte_defconfig
+++ linux-osk/arch/arm/configs/palmte_defconfig
@@ -1,21 +1,34 @@
 #
-# Palm Tungsten E default kernel configuration
-# Created by Romain Goyet <palmtelinux-developpers@lists.sf.net>
-# Linux kernel version: 2.6.13-rc6-omap1
-# Fri Aug 26 16:01:18 2005
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.22-rc1-omap1
+# Sat May 19 11:04:27 2007
 #
 CONFIG_ARM=y
+CONFIG_SYS_SUPPORTS_APM_EMULATION=y
+CONFIG_GENERIC_GPIO=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_MMU=y
-CONFIG_UID16=y
+# CONFIG_NO_IOPORT is not set
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+CONFIG_HARDIRQS_SW_RESEND=y
+CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+# CONFIG_ARCH_HAS_ILOG2_U32 is not set
+# CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_ZONE_DMA=y
+CONFIG_VECTORS_BASE=0xffff0000
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-# CONFIG_CLEAN_COMPILE is not set
-CONFIG_BROKEN=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 
@@ -23,27 +36,43 @@ CONFIG_INIT_ENV_ARG_LIMIT=32
 # General setup
 #
 CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
+CONFIG_SYSVIPC_SYSCTL=y
 CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
-CONFIG_SYSCTL=y
-CONFIG_HOTPLUG=y
+# CONFIG_UTS_NS is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_SYSFS_DEPRECATED=y
+# CONFIG_RELAY is not set
+# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
+CONFIG_UID16=y
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
+CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
-CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
-CONFIG_CC_ALIGN_FUNCTIONS=0
-CONFIG_CC_ALIGN_LABELS=0
-CONFIG_CC_ALIGN_LOOPS=0
-CONFIG_CC_ALIGN_JUMPS=0
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
+CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 
@@ -53,30 +82,61 @@ CONFIG_BASE_SMALL=0
 # CONFIG_MODULES is not set
 
 #
+# Block layer
+#
+CONFIG_BLOCK=y
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+CONFIG_DEFAULT_AS=y
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="anticipatory"
+
+#
 # System Type
 #
+# CONFIG_ARCH_AAEC2000 is not set
+# CONFIG_ARCH_INTEGRATOR is not set
+# CONFIG_ARCH_REALVIEW is not set
+# CONFIG_ARCH_VERSATILE is not set
+# CONFIG_ARCH_AT91 is not set
 # CONFIG_ARCH_CLPS7500 is not set
 # CONFIG_ARCH_CLPS711X is not set
 # CONFIG_ARCH_CO285 is not set
 # CONFIG_ARCH_EBSA110 is not set
-# CONFIG_ARCH_CAMELOT is not set
+# CONFIG_ARCH_EP93XX is not set
 # CONFIG_ARCH_FOOTBRIDGE is not set
-# CONFIG_ARCH_INTEGRATOR is not set
-# CONFIG_ARCH_IOP3XX is not set
-# CONFIG_ARCH_IXP4XX is not set
+# CONFIG_ARCH_NETX is not set
+# CONFIG_ARCH_H720X is not set
+# CONFIG_ARCH_IMX is not set
+# CONFIG_ARCH_IOP13XX is not set
+# CONFIG_ARCH_IOP32X is not set
+# CONFIG_ARCH_IOP33X is not set
+# CONFIG_ARCH_IXP23XX is not set
 # CONFIG_ARCH_IXP2000 is not set
+# CONFIG_ARCH_IXP4XX is not set
 # CONFIG_ARCH_L7200 is not set
+# CONFIG_ARCH_KS8695 is not set
+# CONFIG_ARCH_NS9XXX is not set
+# CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
 # CONFIG_ARCH_RPC is not set
 # CONFIG_ARCH_SA1100 is not set
 # CONFIG_ARCH_S3C2410 is not set
 # CONFIG_ARCH_SHARK is not set
 # CONFIG_ARCH_LH7A40X is not set
+# CONFIG_ARCH_DAVINCI is not set
 CONFIG_ARCH_OMAP=y
-# CONFIG_ARCH_VERSATILE is not set
-# CONFIG_ARCH_IMX is not set
-# CONFIG_ARCH_H720X is not set
-# CONFIG_ARCH_AAEC2000 is not set
 
 #
 # TI OMAP Implementations
@@ -89,15 +149,20 @@ CONFIG_ARCH_OMAP1=y
 #
 # CONFIG_OMAP_RESET_CLOCKS is not set
 # CONFIG_OMAP_BOOT_TAG is not set
+CONFIG_OMAP_GPIO_SWITCH=y
 CONFIG_OMAP_MUX=y
 # CONFIG_OMAP_MUX_DEBUG is not set
 CONFIG_OMAP_MUX_WARNINGS=y
+CONFIG_OMAP_MCBSP=y
+# CONFIG_OMAP_MMU_FWK is not set
+# CONFIG_OMAP_MBOX_FWK is not set
 CONFIG_OMAP_MPU_TIMER=y
 # CONFIG_OMAP_32K_TIMER is not set
 CONFIG_OMAP_LL_DEBUG_UART1=y
 # CONFIG_OMAP_LL_DEBUG_UART2 is not set
 # CONFIG_OMAP_LL_DEBUG_UART3 is not set
 CONFIG_OMAP_SERIAL_WAKE=y
+# CONFIG_OMAP_DSP is not set
 
 #
 # OMAP Core Type
@@ -111,8 +176,11 @@ CONFIG_ARCH_OMAP15XX=y
 #
 # CONFIG_MACH_OMAP_INNOVATOR is not set
 # CONFIG_MACH_VOICEBLUE is not set
-# CONFIG_MACH_NETSTAR is not set
 CONFIG_MACH_OMAP_PALMTE=y
+# CONFIG_MACH_OMAP_PALMZ71 is not set
+# CONFIG_MACH_OMAP_PALMTT is not set
+# CONFIG_MACH_SX1 is not set
+# CONFIG_MACH_AMS_DELTA is not set
 # CONFIG_MACH_OMAP_GENERIC is not set
 
 #
@@ -124,19 +192,20 @@ CONFIG_OMAP_CLOCKS_SET_BY_BOOTLOADER=y
 # CONFIG_OMAP_ARM_120MHZ is not set
 # CONFIG_OMAP_ARM_60MHZ is not set
 # CONFIG_OMAP_ARM_30MHZ is not set
-# CONFIG_OMAP_DSP is not set
 
 #
 # Processor Type
 #
 CONFIG_CPU_32=y
 CONFIG_CPU_ARM925T=y
-CONFIG_CPU_32v4=y
+CONFIG_CPU_32v4T=y
 CONFIG_CPU_ABRT_EV4T=y
 CONFIG_CPU_CACHE_V4WT=y
 CONFIG_CPU_CACHE_VIVT=y
 CONFIG_CPU_COPY_V4WB=y
 CONFIG_CPU_TLB_V4WBI=y
+CONFIG_CPU_CP15=y
+CONFIG_CPU_CP15_MMU=y
 
 #
 # Processor Features
@@ -145,11 +214,12 @@ CONFIG_CPU_TLB_V4WBI=y
 # CONFIG_CPU_ICACHE_DISABLE is not set
 # CONFIG_CPU_DCACHE_DISABLE is not set
 # CONFIG_CPU_DCACHE_WRITETHROUGH is not set
+# CONFIG_OUTER_CACHE is not set
 
 #
 # Bus support
 #
-CONFIG_ISA_DMA_API=y
+# CONFIG_ARCH_SUPPORTS_MSI is not set
 
 #
 # PCCARD (PCMCIA/CardBus) support
@@ -159,9 +229,12 @@ CONFIG_ISA_DMA_API=y
 #
 # Kernel Features
 #
-# CONFIG_SMP is not set
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
 # CONFIG_PREEMPT is not set
-# CONFIG_NO_IDLE_HZ is not set
+CONFIG_HZ=100
+# CONFIG_AEABI is not set
 # CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
@@ -169,6 +242,10 @@ CONFIG_FLATMEM_MANUAL=y
 # CONFIG_SPARSEMEM_MANUAL is not set
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4096
+# CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
 # CONFIG_LEDS is not set
 CONFIG_ALIGNMENT_TRAP=y
 
@@ -179,6 +256,7 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE=""
 # CONFIG_XIP_KERNEL is not set
+# CONFIG_KEXEC is not set
 
 #
 # CPU Frequency scaling
@@ -224,9 +302,10 @@ CONFIG_BINFMT_ELF=y
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_FW_LOADER is not set
+# CONFIG_SYS_HYPERVISOR is not set
 
 #
-# Memory Technology Devices (MTD)
+# Connector - unified userspace <-> kernelspace linker
 #
 # CONFIG_MTD is not set
 
@@ -238,6 +317,7 @@ CONFIG_BINFMT_ELF=y
 #
 # Plug and Play support
 #
+# CONFIG_PNPACPI is not set
 
 #
 # Block devices
@@ -245,22 +325,15 @@ CONFIG_BINFMT_ELF=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_RAM is not set
-CONFIG_BLK_DEV_RAM_COUNT=16
-CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_CDROM_PKTCDVD is not set
 
 #
-# IO Schedulers
-#
-CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
-
-#
 # SCSI device support
 #
+# CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_ATA is not set
 
 #
 # Multi-device support (RAID and LVM)
@@ -268,26 +341,6 @@ CONFIG_IOSCHED_AS=y
 # CONFIG_MD is not set
 
 #
-# Fusion MPT device support
-#
-# CONFIG_FUSION is not set
-
-#
-# IEEE 1394 (FireWire) support
-#
-# CONFIG_IEEE1394 is not set
-
-#
-# I2O device support
-#
-
-#
-# Network device support
-#
-# CONFIG_NETPOLL is not set
-# CONFIG_NET_POLL_CONTROLLER is not set
-
-#
 # ISDN subsystem
 #
 
@@ -295,6 +348,7 @@ CONFIG_IOSCHED_AS=y
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
 
 #
 # Userland interfaces
@@ -314,6 +368,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=320
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
 # CONFIG_INPUT_MISC is not set
 
@@ -329,6 +384,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=320
 CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
 
 #
@@ -346,65 +402,96 @@ CONFIG_UNIX98_PTYS=y
 # IPMI
 #
 # CONFIG_IPMI_HANDLER is not set
-
-#
-# Watchdog Cards
-#
 # CONFIG_WATCHDOG is not set
+CONFIG_HW_RANDOM=y
 # CONFIG_NVRAM is not set
-# CONFIG_RTC is not set
 CONFIG_OMAP_RTC=y
-# CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_RAW_DRIVER is not set
 
 #
 # TPM devices
 #
+# CONFIG_TCG_TPM is not set
+# CONFIG_I2C is not set
 
 #
-# I2C support
+# SPI support
 #
-# CONFIG_I2C is not set
-# CONFIG_I2C_SENSOR is not set
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
 
 #
-# Hardware Monitoring support
+# Dallas's 1-wire bus
 #
+# CONFIG_W1 is not set
 # CONFIG_HWMON is not set
 
 #
 # Misc devices
 #
+# CONFIG_BLINK is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
+# LED devices
+#
+# CONFIG_NEW_LEDS is not set
+
+#
+# LED drivers
+#
+
+#
+# LED Triggers
+#
 
 #
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
+CONFIG_DAB=y
 
 #
-# Digital Video Broadcasting Devices
+# Graphics support
 #
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
-# Graphics support
+# Display device support
 #
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_VGASTATE is not set
 CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
 # CONFIG_FB_CFB_FILLRECT is not set
 # CONFIG_FB_CFB_COPYAREA is not set
 # CONFIG_FB_CFB_IMAGEBLIT is not set
-CONFIG_FB_SOFT_CURSOR=y
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_SYS_FOPS is not set
+CONFIG_FB_DEFERRED_IO=y
+# CONFIG_FB_SVGALIB is not set
 # CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
 # CONFIG_FB_MODE_HELPERS is not set
 # CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
 # CONFIG_FB_S1D13XXX is not set
 CONFIG_FB_OMAP=y
-CONFIG_FB_OMAP_INTERNAL_LCDC=y
-# CONFIG_FB_OMAP_EXTERNAL_LCDC is not set
+# CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
+# CONFIG_FB_OMAP_LCD_MIPID is not set
+# CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
+CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
 # CONFIG_FB_OMAP_DMA_TUNE is not set
 # CONFIG_FB_VIRTUAL is not set
 
@@ -414,18 +501,14 @@ CONFIG_FB_OMAP_INTERNAL_LCDC=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
 # CONFIG_FONTS is not set
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
-
-#
-# Logo configuration
-#
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_LOGO_LINUX_CLUT224=y
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -433,11 +516,24 @@ CONFIG_LOGO_LINUX_CLUT224=y
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
+# CONFIG_USB_ARCH_HAS_EHCI is not set
 # CONFIG_USB is not set
+# CONFIG_USB_MUSB_HDRC is not set
+# CONFIG_USB_GADGET_MUSB_HDRC is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
 
 #
 # USB Gadget Support
@@ -445,12 +541,14 @@ CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_GADGET=y
 # CONFIG_USB_GADGET_DEBUG_FILES is not set
 CONFIG_USB_GADGET_SELECTED=y
+# CONFIG_USB_GADGET_FSL_USB2 is not set
 # CONFIG_USB_GADGET_NET2280 is not set
 # CONFIG_USB_GADGET_PXA2XX is not set
 # CONFIG_USB_GADGET_GOKU is not set
 # CONFIG_USB_GADGET_LH7A40X is not set
 CONFIG_USB_GADGET_OMAP=y
 CONFIG_USB_OMAP=y
+# CONFIG_USB_GADGET_AT91 is not set
 # CONFIG_USB_GADGET_DUMMY_HCD is not set
 # CONFIG_USB_GADGET_DUALSPEED is not set
 CONFIG_USB_ZERO=y
@@ -458,23 +556,31 @@ CONFIG_USB_ZERO=y
 # CONFIG_USB_GADGETFS is not set
 # CONFIG_USB_FILE_STORAGE is not set
 # CONFIG_USB_G_SERIAL is not set
+# CONFIG_USB_MIDI_GADGET is not set
+CONFIG_MMC=y
+# CONFIG_MMC_DEBUG is not set
+# CONFIG_MMC_UNSAFE_RESUME is not set
 
 #
-# MMC/SD Card support
+# MMC/SD Card Drivers
 #
-CONFIG_MMC=y
-# CONFIG_MMC_DEBUG is not set
 CONFIG_MMC_BLOCK=y
-# CONFIG_MMC_BLOCK_BROKEN_RFD is not set
-# CONFIG_MMC_BULKTRANSFER is not set
+
+#
+# MMC/SD Host Controller Drivers
+#
 CONFIG_MMC_OMAP=y
-# CONFIG_MMC_WBSD is not set
 
 #
-# Synchronous Serial Interfaces (SSI)
+# Real Time Clock
 #
-# CONFIG_OMAP_UWIRE is not set
-# CONFIG_OMAP_TSC2101 is not set
+CONFIG_RTC_LIB=y
+# CONFIG_RTC_CLASS is not set
+
+#
+# CBUS support
+#
+# CONFIG_CBUS is not set
 
 #
 # File systems
@@ -483,15 +589,12 @@ CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
 # CONFIG_EXT2_FS_XIP is not set
 # CONFIG_EXT3_FS is not set
-# CONFIG_JBD is not set
+# CONFIG_EXT4DEV_FS is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
-
-#
-# XFS support
-#
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
 # CONFIG_INOTIFY is not set
@@ -499,6 +602,7 @@ CONFIG_EXT2_FS=y
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
 
 #
 # CD-ROM/DVD Filesystems
@@ -520,13 +624,13 @@ CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
-# CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
-# CONFIG_TMPFS_XATTR is not set
-# CONFIG_HUGETLBFS is not set
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
+# CONFIG_CONFIGFS_FS is not set
 
 #
 # Miscellaneous filesystems
@@ -563,7 +667,9 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_SGI_PARTITION is not set
 # CONFIG_ULTRIX_PARTITION is not set
 # CONFIG_SUN_PARTITION is not set
+# CONFIG_KARMA_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
+# CONFIG_SYSV68_PARTITION is not set
 
 #
 # Native Language Support
@@ -618,8 +724,12 @@ CONFIG_NLS_ISO8859_1=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_MUST_CHECK=y
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_LOG_BUF_SHIFT=14
 CONFIG_DEBUG_BUGVERBOSE=y
 CONFIG_FRAME_POINTER=y
 # CONFIG_DEBUG_USER is not set
@@ -636,13 +746,16 @@ CONFIG_FRAME_POINTER=y
 # CONFIG_CRYPTO is not set
 
 #
-# Hardware crypto devices
-#
-
-#
 # Library routines
 #
+CONFIG_BITREVERSE=y
 CONFIG_CRC_CCITT=y
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
+CONFIG_PLIST=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y

--------------030802020303020305090009
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030802020303020305090009--
