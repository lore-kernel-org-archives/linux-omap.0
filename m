From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [PATCH 07/14] Update arch/arm/configs/omap_generic_2420_defconfig
Date: Tue, 18 Sep 2007 13:56:43 -0400
Message-ID: <11901382123827-git-send-email-felipe.lima@indt.org.br>
References: <1190138210438-git-send-email-felipe.lima@indt.org.br>
	<11901382113889-git-send-email-felipe.lima@indt.org.br>
	<11901382111511-git-send-email-felipe.lima@indt.org.br>
	<11901382112392-git-send-email-felipe.lima@indt.org.br>
	<11901382112428-git-send-email-felipe.lima@indt.org.br>
	<1190138211478-git-send-email-felipe.lima@indt.org.br>
	<11901382121172-git-send-email-felipe.lima@indt.org.br>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11901382121172-git-send-email-felipe.lima@indt.org.br>
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

Update arch/arm/configs/omap_generic_2420_defconfig

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---
 arch/arm/configs/omap_generic_2420_defconfig |  382 ++++++++++++++++----------
 1 files changed, 241 insertions(+), 141 deletions(-)

diff --git a/arch/arm/configs/omap_generic_2420_defconfig b/arch/arm/configs/omap_generic_2420_defconfig
index 94d4659..cf4073b 100644
--- a/arch/arm/configs/omap_generic_2420_defconfig
+++ b/arch/arm/configs/omap_generic_2420_defconfig
@@ -1,92 +1,146 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.13-rc6-omap1
-# Thu Aug 11 10:05:10 2005
+# Linux kernel version: 2.6.23-rc6-omap1
+# Tue Sep 18 11:44:48 2007
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
-# Code maturity level options
+# General setup
 #
 CONFIG_EXPERIMENTAL=y
-CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
-
-#
-# General setup
-#
 CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_BSD_PROCESS_ACCT is not set
-CONFIG_SYSCTL=y
-CONFIG_HOTPLUG=y
+# CONFIG_USER_NS is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_SYSFS_DEPRECATED=y
+# CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
+CONFIG_UID16=y
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
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
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
+# CONFIG_SLOB is not set
+CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-
-#
-# Loadable module support
-#
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
-CONFIG_OBSOLETE_MODPARM=y
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 # CONFIG_KMOD is not set
+CONFIG_BLOCK=y
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+# CONFIG_DEFAULT_AS is not set
+# CONFIG_DEFAULT_DEADLINE is not set
+CONFIG_DEFAULT_CFQ=y
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="cfq"
 
 #
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
+# CONFIG_ARCH_MXC is not set
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
 #
+CONFIG_ARCH_OMAP_OTG=y
 # CONFIG_ARCH_OMAP1 is not set
 CONFIG_ARCH_OMAP2=y
+# CONFIG_ARCH_OMAP3 is not set
 
 #
 # OMAP Feature Selections
@@ -94,13 +148,20 @@ CONFIG_ARCH_OMAP2=y
 # CONFIG_OMAP_RESET_CLOCKS is not set
 CONFIG_OMAP_BOOT_TAG=y
 # CONFIG_OMAP_BOOT_REASON is not set
+# CONFIG_OMAP_COMPONENT_VERSION is not set
 # CONFIG_OMAP_GPIO_SWITCH is not set
 # CONFIG_OMAP_MUX is not set
+# CONFIG_OMAP_STI is not set
+CONFIG_OMAP_MCBSP=y
+# CONFIG_OMAP_MMU_FWK is not set
+# CONFIG_OMAP_MBOX_FWK is not set
 CONFIG_OMAP_MPU_TIMER=y
 # CONFIG_OMAP_32K_TIMER is not set
+CONFIG_OMAP_DM_TIMER=y
 # CONFIG_OMAP_LL_DEBUG_UART1 is not set
 # CONFIG_OMAP_LL_DEBUG_UART2 is not set
 CONFIG_OMAP_LL_DEBUG_UART3=y
+# CONFIG_OMAP_DSP is not set
 CONFIG_MACH_OMAP_GENERIC=y
 
 #
@@ -108,33 +169,56 @@ CONFIG_MACH_OMAP_GENERIC=y
 #
 CONFIG_ARCH_OMAP24XX=y
 CONFIG_ARCH_OMAP2420=y
+# CONFIG_ARCH_OMAP2430 is not set
 
 #
 # OMAP Board Type
 #
+# CONFIG_MACH_NOKIA_N800 is not set
 # CONFIG_MACH_OMAP_H4 is not set
+# CONFIG_MACH_OMAP_APOLLON is not set
+# CONFIG_MACH_OMAP_APOLLON_PLUS is not set
+# CONFIG_MACH_OMAP_2430SDP is not set
+
+#
+# Boot options
+#
+
+#
+# Power management
+#
 
 #
 # Processor Type
 #
 CONFIG_CPU_32=y
 CONFIG_CPU_V6=y
+# CONFIG_CPU_32v6K is not set
 CONFIG_CPU_32v6=y
 CONFIG_CPU_ABRT_EV6=y
+CONFIG_CPU_PABRT_NOIFAR=y
 CONFIG_CPU_CACHE_V6=y
 CONFIG_CPU_CACHE_VIPT=y
 CONFIG_CPU_COPY_V6=y
 CONFIG_CPU_TLB_V6=y
+CONFIG_CPU_HAS_ASID=y
+CONFIG_CPU_CP15=y
+CONFIG_CPU_CP15_MMU=y
 
 #
 # Processor Features
 #
 CONFIG_ARM_THUMB=y
+# CONFIG_CPU_ICACHE_DISABLE is not set
+# CONFIG_CPU_DCACHE_DISABLE is not set
+# CONFIG_CPU_BPREDICT_DISABLE is not set
+# CONFIG_OUTER_CACHE is not set
 
 #
 # Bus support
 #
-CONFIG_ISA_DMA_API=y
+# CONFIG_PCI_SYSCALL is not set
+# CONFIG_ARCH_SUPPORTS_MSI is not set
 
 #
 # PCCARD (PCMCIA/CardBus) support
@@ -144,9 +228,12 @@ CONFIG_ISA_DMA_API=y
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
@@ -154,9 +241,13 @@ CONFIG_FLATMEM_MANUAL=y
 # CONFIG_SPARSEMEM_MANUAL is not set
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
 CONFIG_LEDS=y
-# CONFIG_LEDS_TIMER is not set
-# CONFIG_LEDS_CPU is not set
 CONFIG_ALIGNMENT_TRAP=y
 
 #
@@ -167,6 +258,12 @@ CONFIG_ZBOOT_ROM_BSS=0x10200000
 # CONFIG_ZBOOT_ROM is not set
 CONFIG_CMDLINE=""
 # CONFIG_XIP_KERNEL is not set
+# CONFIG_KEXEC is not set
+
+#
+# CPU Frequency scaling
+#
+# CONFIG_CPU_FREQ is not set
 
 #
 # Floating point emulation
@@ -192,6 +289,7 @@ CONFIG_BINFMT_ELF=y
 # Power management options
 #
 # CONFIG_PM is not set
+CONFIG_SUSPEND_UP_POSSIBLE=y
 
 #
 # Networking
@@ -209,78 +307,35 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
 # CONFIG_DEBUG_DRIVER is not set
-
-#
-# Memory Technology Devices (MTD)
-#
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_MTD is not set
-
-#
-# Parallel port support
-#
 # CONFIG_PARPORT is not set
-
-#
-# Plug and Play support
-#
-
-#
-# Block devices
-#
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 # CONFIG_BLK_DEV_LOOP is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE=""
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 # CONFIG_CDROM_PKTCDVD is not set
 
 #
-# IO Schedulers
-#
-CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
-CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
-
-#
 # SCSI device support
 #
+# CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
-
-#
-# Multi-device support (RAID and LVM)
-#
+# CONFIG_SCSI_DMA is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_ATA is not set
 # CONFIG_MD is not set
 
 #
-# Fusion MPT device support
-#
-# CONFIG_FUSION is not set
-
-#
-# IEEE 1394 (FireWire) support
-#
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
-# ISDN subsystem
-#
-
-#
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
 
 #
 # Userland interfaces
@@ -300,6 +355,7 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
 # CONFIG_INPUT_MISC is not set
 
@@ -317,6 +373,7 @@ CONFIG_SERIO_SERPORT=y
 CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
 
 #
@@ -325,6 +382,7 @@ CONFIG_HW_CONSOLE=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 # CONFIG_SERIAL_8250_EXTENDED is not set
 
 #
@@ -334,15 +392,7 @@ CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 # CONFIG_LEGACY_PTYS is not set
-
-#
-# IPMI
-#
 # CONFIG_IPMI_HANDLER is not set
-
-#
-# Watchdog Cards
-#
 CONFIG_WATCHDOG=y
 CONFIG_WATCHDOG_NOWAYOUT=y
 
@@ -350,48 +400,61 @@ CONFIG_WATCHDOG_NOWAYOUT=y
 # Watchdog Device Drivers
 #
 # CONFIG_SOFT_WATCHDOG is not set
+# CONFIG_OMAP_WATCHDOG is not set
+CONFIG_HW_RANDOM=m
+CONFIG_HW_RANDOM_OMAP=m
 # CONFIG_NVRAM is not set
-# CONFIG_RTC is not set
-# CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_RAW_DRIVER is not set
-
-#
-# TPM devices
-#
-
-#
-# I2C support
-#
+# CONFIG_TCG_TPM is not set
 # CONFIG_I2C is not set
-# CONFIG_I2C_SENSOR is not set
 
 #
-# Hardware Monitoring support
+# SPI support
 #
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
+# CONFIG_W1 is not set
 CONFIG_HWMON=y
+# CONFIG_HWMON_VID is not set
+# CONFIG_SENSORS_ABITUGURU is not set
+# CONFIG_SENSORS_ABITUGURU3 is not set
+# CONFIG_SENSORS_F71805F is not set
+# CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_PC87360 is not set
+# CONFIG_SENSORS_PC87427 is not set
+# CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_VT1211 is not set
+# CONFIG_SENSORS_W83627HF is not set
+# CONFIG_SENSORS_W83627EHF is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
+CONFIG_MISC_DEVICES=y
+# CONFIG_EEPROM_93CX6 is not set
 
 #
-# Misc devices
+# Multifunction device drivers
 #
+# CONFIG_MFD_SM501 is not set
+# CONFIG_NEW_LEDS is not set
 
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
+CONFIG_VIDEO_OUTPUT_CONTROL=m
 # CONFIG_FB is not set
 
 #
@@ -404,28 +467,48 @@ CONFIG_DUMMY_CONSOLE=y
 # Sound
 #
 # CONFIG_SOUND is not set
-
-#
-# USB support
-#
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
+CONFIG_HID_DEBUG=y
+CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
+# CONFIG_USB_ARCH_HAS_EHCI is not set
 # CONFIG_USB is not set
 
 #
+# Enable Host or Gadget support to see Inventra options
+#
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
+# CONFIG_MMC is not set
+CONFIG_RTC_LIB=y
+# CONFIG_RTC_CLASS is not set
 
 #
-# MMC/SD Card support
+# DMA Engine support
+#
+# CONFIG_DMA_ENGINE is not set
+
+#
+# DMA Clients
 #
-# CONFIG_MMC is not set
 
 #
-# Synchronous Serial Interfaces (SSI)
+# DMA Devices
 #
-# CONFIG_OMAP_TSC2101 is not set
+
+#
+# CBUS support
+#
+# CONFIG_CBUS is not set
 
 #
 # File systems
@@ -436,23 +519,22 @@ CONFIG_EXT2_FS_XATTR=y
 # CONFIG_EXT2_FS_SECURITY is not set
 # CONFIG_EXT2_FS_XIP is not set
 # CONFIG_EXT3_FS is not set
-# CONFIG_JBD is not set
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_FS_MBCACHE=y
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
 CONFIG_ROMFS_FS=y
 CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
 
 #
 # CD-ROM/DVD Filesystems
@@ -471,11 +553,12 @@ CONFIG_DNOTIFY=y
 # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
-# CONFIG_DEVPTS_FS_XATTR is not set
 # CONFIG_TMPFS is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
+# CONFIG_CONFIGFS_FS is not set
 
 #
 # Miscellaneous filesystems
@@ -514,20 +597,37 @@ CONFIG_MSDOS_PARTITION=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
-CONFIG_DEBUG_KERNEL=y
+CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_MAGIC_SYSRQ is not set
-CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+CONFIG_DETECT_SOFTLOCKUP=y
+CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
-# CONFIG_DEBUG_SLAB is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_SLUB_DEBUG_ON is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
 CONFIG_DEBUG_BUGVERBOSE=y
 CONFIG_DEBUG_INFO=y
-# CONFIG_DEBUG_FS is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
 CONFIG_FRAME_POINTER=y
+CONFIG_FORCED_INLINING=y
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
 CONFIG_DEBUG_USER=y
-# CONFIG_DEBUG_WAITQ is not set
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_LL=y
 # CONFIG_DEBUG_ICEDCC is not set
@@ -537,19 +637,19 @@ CONFIG_DEBUG_LL=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
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
+# CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
+CONFIG_PLIST=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
-- 
1.5.3.1.91.gd3392
