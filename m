From: Marek =?iso-8859-2?q?Va=B9ut?= <marek.vasut@gmail.com>
Subject: [PATCH] Basic support for Palm Zire71
Date: Fri, 20 Oct 2006 23:03:13 +0200
Message-ID: <200610202303.13569.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RmTOF8xDRZTfcf2"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--Boundary-00=_RmTOF8xDRZTfcf2
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

This patch adds basic support for Palm Zire71 PDA. LCD, backlight, MMC,
touchscreen (using ads7846 driver) works. There is much more stuff supporte=
d=20
now, but it=B4s still dirty code which needs cleanup before sending here. I=
f=20
you are interested check www.hackndev.com . Patch is enclosed.

Signed-off-by: Marek Va=B9ut <marek.vasut@gmail.com>

--Boundary-00=_RmTOF8xDRZTfcf2
Content-Type: text/x-diff;
  charset="us-ascii";
  name="palmz71-basic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="palmz71-basic.patch"

diff -Naur linux-omap/arch/arm/configs/palmz71_defconfig linux-omap-z71/arch/arm/configs/palmz71_defconfig
--- linux-omap/arch/arm/configs/palmz71_defconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-omap-z71/arch/arm/configs/palmz71_defconfig	2006-10-20 22:15:57.000000000 +0200
@@ -0,0 +1,809 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.18-omap1
+# Fri Oct 20 22:04:08 2006
+#
+CONFIG_ARM=y
+CONFIG_MMU=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_HARDIRQS_SW_RESEND=y
+CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_VECTORS_BASE=0xffff0000
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION="-z71"
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+CONFIG_BSD_PROCESS_ACCT=y
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_AUDIT is not set
+# CONFIG_IKCONFIG is not set
+# CONFIG_RELAY is not set
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_EMBEDDED is not set
+CONFIG_UID16=y
+CONFIG_SYSCTL=y
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SHMEM=y
+CONFIG_SLAB=y
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_RT_MUTEXES=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+# CONFIG_SLOB is not set
+
+#
+# Loadable module support
+#
+# CONFIG_MODULES is not set
+
+#
+# Block layer
+#
+# CONFIG_BLK_DEV_IO_TRACE is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_DEFAULT_AS is not set
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
+
+#
+# System Type
+#
+# CONFIG_ARCH_AAEC2000 is not set
+# CONFIG_ARCH_INTEGRATOR is not set
+# CONFIG_ARCH_REALVIEW is not set
+# CONFIG_ARCH_VERSATILE is not set
+# CONFIG_ARCH_AT91 is not set
+# CONFIG_ARCH_CLPS7500 is not set
+# CONFIG_ARCH_CLPS711X is not set
+# CONFIG_ARCH_CO285 is not set
+# CONFIG_ARCH_EBSA110 is not set
+# CONFIG_ARCH_EP93XX is not set
+# CONFIG_ARCH_FOOTBRIDGE is not set
+# CONFIG_ARCH_NETX is not set
+# CONFIG_ARCH_H720X is not set
+# CONFIG_ARCH_IMX is not set
+# CONFIG_ARCH_IOP3XX is not set
+# CONFIG_ARCH_IXP4XX is not set
+# CONFIG_ARCH_IXP2000 is not set
+# CONFIG_ARCH_IXP23XX is not set
+# CONFIG_ARCH_L7200 is not set
+# CONFIG_ARCH_PNX4008 is not set
+# CONFIG_ARCH_PXA is not set
+# CONFIG_ARCH_RPC is not set
+# CONFIG_ARCH_SA1100 is not set
+# CONFIG_ARCH_S3C2410 is not set
+# CONFIG_ARCH_SHARK is not set
+# CONFIG_ARCH_LH7A40X is not set
+CONFIG_ARCH_OMAP=y
+
+#
+# TI OMAP Implementations
+#
+CONFIG_ARCH_OMAP1=y
+# CONFIG_ARCH_OMAP2 is not set
+
+#
+# OMAP Feature Selections
+#
+# CONFIG_OMAP_RESET_CLOCKS is not set
+# CONFIG_OMAP_BOOT_TAG is not set
+# CONFIG_OMAP_GPIO_SWITCH is not set
+CONFIG_OMAP_MUX=y
+# CONFIG_OMAP_MUX_DEBUG is not set
+CONFIG_OMAP_MUX_WARNINGS=y
+CONFIG_OMAP_MCBSP=y
+CONFIG_OMAP_MPU_TIMER=y
+# CONFIG_OMAP_32K_TIMER is not set
+CONFIG_OMAP_LL_DEBUG_UART1=y
+# CONFIG_OMAP_LL_DEBUG_UART2 is not set
+# CONFIG_OMAP_LL_DEBUG_UART3 is not set
+CONFIG_OMAP_SERIAL_WAKE=y
+# CONFIG_OMAP_DSP is not set
+
+#
+# OMAP Core Type
+#
+# CONFIG_ARCH_OMAP730 is not set
+CONFIG_ARCH_OMAP15XX=y
+# CONFIG_ARCH_OMAP16XX is not set
+
+#
+# OMAP Board Type
+#
+# CONFIG_MACH_OMAP_INNOVATOR is not set
+# CONFIG_MACH_VOICEBLUE is not set
+# CONFIG_MACH_OMAP_PALMTE is not set
+CONFIG_MACH_OMAP_PALMZ71=y
+# CONFIG_MACH_AMS_DELTA is not set
+# CONFIG_MACH_OMAP_GENERIC is not set
+
+#
+# OMAP CPU Speed
+#
+CONFIG_OMAP_CLOCKS_SET_BY_BOOTLOADER=y
+# CONFIG_OMAP_ARM_168MHZ is not set
+# CONFIG_OMAP_ARM_150MHZ is not set
+# CONFIG_OMAP_ARM_120MHZ is not set
+# CONFIG_OMAP_ARM_60MHZ is not set
+# CONFIG_OMAP_ARM_30MHZ is not set
+
+#
+# Processor Type
+#
+CONFIG_CPU_32=y
+CONFIG_CPU_ARM925T=y
+CONFIG_CPU_32v4T=y
+CONFIG_CPU_ABRT_EV4T=y
+CONFIG_CPU_CACHE_V4WT=y
+CONFIG_CPU_CACHE_VIVT=y
+CONFIG_CPU_COPY_V4WB=y
+CONFIG_CPU_TLB_V4WBI=y
+
+#
+# Processor Features
+#
+# CONFIG_ARM_THUMB is not set
+# CONFIG_CPU_ICACHE_DISABLE is not set
+# CONFIG_CPU_DCACHE_DISABLE is not set
+# CONFIG_CPU_DCACHE_WRITETHROUGH is not set
+
+#
+# Bus support
+#
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# Kernel Features
+#
+# CONFIG_PREEMPT is not set
+# CONFIG_NO_IDLE_HZ is not set
+CONFIG_HZ=100
+# CONFIG_AEABI is not set
+# CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4096
+# CONFIG_RESOURCES_64BIT is not set
+# CONFIG_LEDS is not set
+CONFIG_ALIGNMENT_TRAP=y
+
+#
+# Boot options
+#
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_CMDLINE=""
+# CONFIG_XIP_KERNEL is not set
+
+#
+# CPU Frequency scaling
+#
+# CONFIG_CPU_FREQ is not set
+
+#
+# Floating point emulation
+#
+
+#
+# At least one emulation must be selected
+#
+CONFIG_FPE_NWFPE=y
+# CONFIG_FPE_NWFPE_XP is not set
+# CONFIG_FPE_FASTFPE is not set
+
+#
+# Userspace binary formats
+#
+CONFIG_BINFMT_ELF=y
+CONFIG_BINFMT_AOUT=y
+CONFIG_BINFMT_MISC=y
+# CONFIG_ARTHUR is not set
+
+#
+# Power management options
+#
+# CONFIG_PM is not set
+# CONFIG_APM is not set
+
+#
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+# CONFIG_NETDEBUG is not set
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+CONFIG_NET_KEY=y
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+# CONFIG_IP_PNP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_BIC=y
+# CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
+
+#
+# DCCP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_DCCP is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+
+#
+# TIPC Configuration (EXPERIMENTAL)
+#
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_IEEE80211 is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+# CONFIG_SYS_HYPERVISOR is not set
+
+#
+# Connector - unified userspace <-> kernelspace linker
+#
+# CONFIG_CONNECTOR is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_COW_COMMON is not set
+# CONFIG_BLK_DEV_LOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_RAM is not set
+# CONFIG_BLK_DEV_INITRD is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+
+#
+# I2O device support
+#
+
+#
+# Network device support
+#
+# CONFIG_NETDEVICES is not set
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# PHY device support
+#
+
+#
+# Ethernet (10 or 100Mbit)
+#
+# CONFIG_NET_ETHERNET is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=320
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=320
+# CONFIG_INPUT_JOYDEV is not set
+CONFIG_INPUT_TSDEV=y
+CONFIG_INPUT_TSDEV_SCREEN_X=320
+CONFIG_INPUT_TSDEV_SCREEN_Y=320
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ADS7846=y
+# CONFIG_TOUCHSCREEN_GUNZE is not set
+# CONFIG_TOUCHSCREEN_ELO is not set
+# CONFIG_TOUCHSCREEN_MTOUCH is not set
+# CONFIG_TOUCHSCREEN_MK712 is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+# CONFIG_SERIAL_8250_EXTENDED is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=16
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+CONFIG_HW_RANDOM=y
+# CONFIG_NVRAM is not set
+CONFIG_OMAP_RTC=y
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+# CONFIG_TELCLOCK is not set
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# SPI support
+#
+CONFIG_SPI=y
+CONFIG_SPI_MASTER=y
+
+#
+# SPI Master Controller Drivers
+#
+CONFIG_SPI_BITBANG=y
+CONFIG_SPI_OMAP_UWIRE=y
+
+#
+# SPI Protocol Masters
+#
+
+#
+# Dallas's 1-wire bus
+#
+
+#
+# Hardware Monitoring support
+#
+CONFIG_HWMON=y
+# CONFIG_HWMON_VID is not set
+# CONFIG_SENSORS_ABITUGURU is not set
+# CONFIG_SENSORS_F71805F is not set
+# CONFIG_SENSORS_LM70 is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
+
+#
+# Misc devices
+#
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
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+CONFIG_VIDEO_V4L2=y
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+CONFIG_FIRMWARE_EDID=y
+CONFIG_FB=y
+# CONFIG_FB_CFB_FILLRECT is not set
+# CONFIG_FB_CFB_COPYAREA is not set
+# CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+# CONFIG_FB_S1D13XXX is not set
+# CONFIG_FB_VIRTUAL is not set
+CONFIG_FB_OMAP=y
+# CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
+# CONFIG_FB_OMAP_LCD_MIPID is not set
+# CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
+CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
+# CONFIG_FB_OMAP_DMA_TUNE is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+# CONFIG_FONTS is not set
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+
+#
+# Logo configuration
+#
+# CONFIG_LOGO is not set
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+CONFIG_BACKLIGHT_DEVICE=y
+CONFIG_LCD_CLASS_DEVICE=y
+CONFIG_LCD_DEVICE=y
+CONFIG_BACKLIGHT_OMAP=y
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+# CONFIG_USB_ARCH_HAS_EHCI is not set
+# CONFIG_USB is not set
+
+#
+# Enable Host or Gadget support to see Inventra options
+#
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# MMC/SD Card support
+#
+CONFIG_MMC=y
+# CONFIG_MMC_DEBUG is not set
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_OMAP=y
+
+#
+# Real Time Clock
+#
+CONFIG_RTC_LIB=y
+# CONFIG_RTC_CLASS is not set
+
+#
+# Synchronous Serial Interfaces (SSI)
+#
+CONFIG_OMAP_UWIRE=y
+# CONFIG_OMAP_TSC2101 is not set
+
+#
+# CBUS support
+#
+# CONFIG_CBUS is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_INOTIFY is not set
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_SYSFS=y
+# CONFIG_TMPFS is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+# CONFIG_CONFIGFS_FS is not set
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+# CONFIG_NFS_FS is not set
+# CONFIG_NFSD is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+# CONFIG_9P_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+
+#
+# Native Language Support
+#
+# CONFIG_NLS is not set
+
+#
+# Profiling support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_KERNEL is not set
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_DEBUG_BUGVERBOSE=y
+# CONFIG_DEBUG_FS is not set
+CONFIG_FRAME_POINTER=y
+# CONFIG_UNWIND_INFO is not set
+# CONFIG_DEBUG_USER is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
+
+#
+# Hardware crypto devices
+#
+
+#
+# Library routines
+#
+CONFIG_CRC_CCITT=y
+CONFIG_CRC16=y
+CONFIG_CRC32=y
+CONFIG_LIBCRC32C=y
+CONFIG_PLIST=y
diff -Naur linux-omap/arch/arm/mach-omap1/board-palmz71.c linux-omap-z71/arch/arm/mach-omap1/board-palmz71.c
--- linux-omap/arch/arm/mach-omap1/board-palmz71.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-omap-z71/arch/arm/mach-omap1/board-palmz71.c	2006-10-20 22:26:21.000000000 +0200
@@ -0,0 +1,371 @@
+/*
+ * linux/arch/arm/mach-omap1/board-palmz71.c
+ *
+ * Modified from board-generic.c
+ *
+ * Support for the Palm Zire71 PDA.
+ *
+ * Original version : Laurent Gonzalez
+ *
+ * Modified for zire71 : Marek Vasut
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/notifier.h>
+#include <linux/clk.h>
+#include <linux/irq.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+
+#include <asm/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/flash.h>
+
+#include <asm/arch/mcbsp.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch/mux.h>
+#include <asm/arch/usb.h>
+#include <asm/arch/dma.h>
+#include <asm/arch/tc.h>
+#include <asm/arch/board.h>
+#include <asm/arch/irda.h>
+#include <asm/arch/keypad.h>
+#include <asm/arch/common.h>
+#include <asm/arch/omap-alsa.h>
+
+#include <linux/input.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/ads7846.h>
+
+static void __init omap_palmz71_init_irq(void)
+{
+	omap1_init_common_hw();
+	omap_init_irq();
+	omap_gpio_init();
+}
+
+static int palmz71_keymap[] = {
+	KEY(0, 0, KEY_F1),
+	KEY(0, 1, KEY_F2),
+	KEY(0, 2, KEY_F3),
+	KEY(0, 3, KEY_F4),
+	KEY(0, 4, KEY_POWER),
+	KEY(1, 0, KEY_LEFT),
+	KEY(1, 1, KEY_DOWN),
+	KEY(1, 2, KEY_UP),
+	KEY(1, 3, KEY_RIGHT),
+	KEY(1, 4, KEY_CENTER),
+	KEY(2, 0, KEY_CAMERA),
+        0,
+};
+
+static struct omap_kp_platform_data palmz71_kp_data = {
+	.rows	= 8,
+	.cols	= 8,
+	.keymap = palmz71_keymap,
+	.rep	= 1,
+};
+
+static struct resource palmz71_kp_resources[] = {
+	[0]	= {
+		.start	= INT_KEYBOARD,
+		.end	= INT_KEYBOARD,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device palmz71_kp_device = {
+	.name		= "omap-keypad",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &palmz71_kp_data,
+	},
+	.num_resources	= ARRAY_SIZE(palmz71_kp_resources),
+	.resource	= palmz71_kp_resources,
+};
+
+static struct mtd_partition palmz71_rom_partitions[] = {
+	/* PalmOS "Small ROM", contains the bootloader and the debugger */
+	{
+		.name		= "smallrom",
+		.offset		= 0,
+		.size		= 0xa000,
+		.mask_flags	= MTD_WRITEABLE,
+	},
+	/* PalmOS "Big ROM", a filesystem with all the OS code and data */
+	{
+		.name		= "bigrom",
+		.offset		= SZ_128K,
+		/*
+		 * 0x5f0000 bytes big in the multi-language ("EFIGS") version,
+		 * 0x7b0000 bytes in the English-only ("enUS") version.
+		 */
+		.size		= 0x7b0000,
+		.mask_flags	= MTD_WRITEABLE,
+	},
+};
+
+static struct flash_platform_data palmz71_rom_data = {
+	.map_name	= "map_rom",
+	.name		= "onboardrom",
+	.width		= 2,
+	.parts		= palmz71_rom_partitions,
+	.nr_parts	= ARRAY_SIZE(palmz71_rom_partitions),
+};
+
+static struct resource palmz71_rom_resource = {
+	.start		= OMAP_CS0_PHYS,
+	.end		= OMAP_CS0_PHYS + SZ_8M - 1,
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device palmz71_rom_device = {
+	.name		= "omapflash",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &palmz71_rom_data,
+	},
+	.num_resources	= 1,
+	.resource	= &palmz71_rom_resource,
+};
+
+static struct platform_device palmz71_lcd_device = {
+	.name		= "lcd_palmz71",
+	.id		= -1,
+};
+
+static struct omap_irda_config palmz71_irda_config = {
+	.transceiver_cap	= IR_SIRMODE,
+	.rx_channel		= OMAP_DMA_UART3_RX,
+	.tx_channel		= OMAP_DMA_UART3_TX,
+	.dest_start		= UART3_THR,
+	.src_start		= UART3_RHR,
+	.tx_trigger		= 0,
+	.rx_trigger		= 0,
+};
+
+static struct resource palmz71_irda_resources[] = {
+	[0]	= {
+		.start	= INT_UART3,
+		.end	= INT_UART3,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device palmz71_irda_device = {
+	.name		= "omapirda",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &palmz71_irda_config,
+	},
+	.num_resources	= ARRAY_SIZE(palmz71_irda_resources),
+	.resource	= palmz71_irda_resources,
+};
+
+static struct platform_device palmz71_spi_device = {
+	.name		= "spi_palmz71",
+	.id		= -1,
+};
+
+#define DEFAULT_BITPERSAMPLE 16
+
+static struct omap_mcbsp_reg_cfg mcbsp_regs = {
+       .spcr2 = FREE | FRST | GRST | XRST | XINTM(3),
+       .spcr1 = RINTM(3) | RRST,
+       .rcr2 = RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
+           RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(0),
+       .rcr1 = RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),
+       .xcr2 = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
+           XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,
+       .xcr1 = XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
+       .srgr1 = FWID(DEFAULT_BITPERSAMPLE - 1),
+       .srgr2 = GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1),
+       /*.pcr0 = FSXM | FSRM | CLKXM | CLKRM | CLKXP | CLKRP,*/ /* mcbsp: master */
+       .pcr0 = CLKXP | CLKRP,  /* mcbsp: slave */
+};
+
+static struct omap_alsa_codec_config alsa_config = {
+       .name                   = "PalmZ71 AIC23",
+       .mcbsp_regs_alsa        = &mcbsp_regs,
+       .codec_configure_dev    = NULL, // aic23_configure,
+       .codec_set_samplerate   = NULL, // aic23_set_samplerate,
+       .codec_clock_setup      = NULL, // aic23_clock_setup,
+       .codec_clock_on         = NULL, // aic23_clock_on,
+       .codec_clock_off        = NULL, // aic23_clock_off,
+       .get_default_samplerate = NULL, // aic23_get_default_samplerate,
+};
+
+static struct platform_device palmz71_mcbsp1_device = {
+       .name   = "omap_alsa_mcbsp",
+       .id     = 1,
+       .dev = {
+               .platform_data  = &alsa_config,
+       },
+};
+
+static struct omap_backlight_config palmz71_backlight_config = {
+	.default_intensity	= 0xa0,
+};
+
+static struct platform_device palmz71_backlight_device = {
+	.name		= "omap-bl",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &palmz71_backlight_config,
+	},
+};
+
+static struct platform_device *devices[] __initdata = {
+	&palmz71_rom_device,
+	&palmz71_kp_device,
+	&palmz71_mcbsp1_device,
+	&palmz71_lcd_device,
+	&palmz71_irda_device,
+	&palmz71_spi_device,
+	&palmz71_backlight_device,
+};
+
+static int palmz71_get_pendown_state(void)
+{
+    return !omap_get_gpio_datain(6);
+    }
+    
+static const struct ads7846_platform_data palmz71_ts_info = {
+    .model			= 7846,
+    .vref_delay_usecs		= 100,	/* internal, no capacitor */
+    .x_plate_ohms		= 419,
+    .y_plate_ohms		= 486,
+    .get_pendown_state		= palmz71_get_pendown_state,
+};
+			
+static struct spi_board_info __initdata palmz71_boardinfo[] = { {
+    /* MicroWire (bus 2) CS0 has an ads7846e */
+    .modalias			= "ads7846",
+    .platform_data		= &palmz71_ts_info,
+    .irq			= OMAP_GPIO_IRQ(6),
+    .max_speed_hz		= 120000 /* max sample rate at 3V */
+				    * 26 /* command + data + overhead */,
+    .bus_num			= 2,
+    .chip_select		= 0,
+} };
+									
+static struct omap_usb_config palmz71_usb_config __initdata = {
+	.register_dev	= 1,	/* Mini-B only receptacle */
+	.hmc_mode	= 0,
+	.pins[0]	= 2,
+};
+
+static struct omap_mmc_config palmz71_mmc_config __initdata = {
+	.mmc[0]		= {
+		.enabled 	= 1,
+		.wire4		= 0,
+		.wp_pin		= PALMZ71_MMC_WP_GPIO,
+		.power_pin	= -1,
+		.switch_pin	= PALMZ71_MMC_IN_GPIO,
+	},
+};
+
+static struct omap_lcd_config palmz71_lcd_config __initdata = {
+	.ctrl_name	= "internal",
+};
+
+static struct omap_uart_config palmz71_uart_config __initdata = {
+	.enabled_uarts = (1 << 0) | (1 << 1) | (0 << 2),
+};
+
+static struct omap_board_config_kernel palmz71_config[] = {
+	{ OMAP_TAG_USB,		&palmz71_usb_config },
+	{ OMAP_TAG_MMC,		&palmz71_mmc_config },
+	{ OMAP_TAG_LCD,		&palmz71_lcd_config },
+	{ OMAP_TAG_UART,	&palmz71_uart_config },
+};
+
+static irqreturn_t
+palmz71_powercable(int irq, void *dev_id, struct pt_regs *regs)
+{
+	if (omap_get_gpio_datain(PALMZ71_USBDETECT_GPIO)) {
+		printk(KERN_INFO "PM: Power cable connected\n");
+		set_irq_type(OMAP_GPIO_IRQ(PALMZ71_USBDETECT_GPIO), IRQT_FALLING);
+	} else {
+		printk(KERN_INFO "PM: Power cable disconnected\n");
+		set_irq_type(OMAP_GPIO_IRQ(PALMZ71_USBDETECT_GPIO), IRQT_RISING);
+	}
+	return IRQ_HANDLED;
+}
+
+static void __init omap_mpu_wdt_mode(int mode) {
+	if (mode)
+		omap_writew(0x8000, OMAP_WDT_TIMER_MODE);
+	else {
+		omap_writew(0x00f5, OMAP_WDT_TIMER_MODE);
+		omap_writew(0x00a0, OMAP_WDT_TIMER_MODE);
+	}
+}
+
+static void __init palmz71_gpio_setup(int early)
+{
+    if (early) {
+	/* Only set GPIO1 so we have a working serial */
+	omap_set_gpio_dataout(1,1);
+	omap_set_gpio_direction(1,0);
+    } else {
+	/* Set MMC/SD host WP pin as input */
+	if (omap_request_gpio(PALMZ71_MMC_WP_GPIO)) {
+		printk(KERN_ERR "Could not reserve WP GPIO!\n");
+		return;
+	}
+	omap_set_gpio_direction(PALMZ71_MMC_WP_GPIO, 1);
+
+	/* Monitor the Power-cable-connected signal */
+	if (omap_request_gpio(PALMZ71_USBDETECT_GPIO)) {
+		printk(KERN_ERR "Could not reserve cable signal GPIO!\n");
+		return;
+	}
+	omap_set_gpio_direction(PALMZ71_USBDETECT_GPIO, 1);
+	if (request_irq(OMAP_GPIO_IRQ(PALMZ71_USBDETECT_GPIO), palmz71_powercable,
+				SA_SAMPLE_RANDOM, "palmz71-cable", 0))
+		printk(KERN_ERR "IRQ request for power cable failed!\n");
+	palmz71_powercable(OMAP_GPIO_IRQ(PALMZ71_USBDETECT_GPIO), 0, 0);
+    }
+}
+
+static void __init omap_palmz71_init(void)
+{
+	palmz71_gpio_setup(1);
+	omap_mpu_wdt_mode(0);
+
+	omap_board_config = palmz71_config;
+	omap_board_config_size = ARRAY_SIZE(palmz71_config);
+
+	platform_add_devices(devices, ARRAY_SIZE(devices));
+
+	spi_register_board_info(palmz71_boardinfo,ARRAY_SIZE(palmz71_boardinfo));
+	omap_serial_init();
+	palmz71_gpio_setup(0);
+}
+
+static void __init omap_palmz71_map_io(void)
+{
+	omap1_map_common_io();
+}
+
+MACHINE_START(OMAP_PALMZ71, "OMAP310 based Palm Zire71")
+	.phys_io	= 0xfff00000,
+	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
+	.boot_params	= 0x10000100,
+	.map_io		= omap_palmz71_map_io,
+	.init_irq	= omap_palmz71_init_irq,
+	.init_machine	= omap_palmz71_init,
+	.timer		= &omap_timer,
+MACHINE_END
diff -Naur linux-omap/arch/arm/mach-omap1/clock.h linux-omap-z71/arch/arm/mach-omap1/clock.h
--- linux-omap/arch/arm/mach-omap1/clock.h	2006-10-15 16:09:10.000000000 +0200
+++ linux-omap-z71/arch/arm/mach-omap1/clock.h	2006-10-20 21:56:49.000000000 +0200
@@ -282,7 +282,7 @@
 static struct clk dsp_ck = {
 	.name		= "dsp_ck",
 	.parent		= &ck_dpll1,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  RATE_CKCTL,
 	.enable_reg	= (void __iomem *)ARM_CKCTL,
 	.enable_bit	= EN_DSPCK,
@@ -295,7 +295,7 @@
 static struct clk dspmmu_ck = {
 	.name		= "dspmmu_ck",
 	.parent		= &ck_dpll1,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  RATE_CKCTL | ALWAYS_ENABLED,
 	.rate_offset	= CKCTL_DSPMMUDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
@@ -306,7 +306,7 @@
 static struct clk dspper_ck = {
 	.name		= "dspper_ck",
 	.parent		= &ck_dpll1,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  RATE_CKCTL | VIRTUAL_IO_ADDRESS,
 	.enable_reg	= (void __iomem *)DSP_IDLECT2,
 	.enable_bit	= EN_PERCK,
@@ -320,7 +320,7 @@
 static struct clk dspxor_ck = {
 	.name		= "dspxor_ck",
 	.parent		= &ck_ref,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  VIRTUAL_IO_ADDRESS,
 	.enable_reg	= (void __iomem *)DSP_IDLECT2,
 	.enable_bit	= EN_XORPCK,
@@ -332,7 +332,7 @@
 static struct clk dsptim_ck = {
 	.name		= "dsptim_ck",
 	.parent		= &ck_ref,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  VIRTUAL_IO_ADDRESS,
 	.enable_reg	= (void __iomem *)DSP_IDLECT2,
 	.enable_bit	= EN_DSPTIMCK,
@@ -374,7 +374,7 @@
 
 static struct clk tipb_ck = {
 	/* No-idle controlled by "tc_ck" */
-	.name		= "tibp_ck",
+	.name		= "tipb_ck",
 	.parent		= &tc_ck.clk,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
 			  ALWAYS_ENABLED,
@@ -733,7 +733,7 @@
 static struct clk i2c_fck = {
 	.name		= "i2c_fck",
 	.id		= 1,
-	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
+	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  VIRTUAL_CLOCK | CLOCK_NO_IDLE_PARENT |
 			  ALWAYS_ENABLED,
 	.parent		= &armxor_ck.clk,
diff -Naur linux-omap/arch/arm/mach-omap1/Kconfig linux-omap-z71/arch/arm/mach-omap1/Kconfig
--- linux-omap/arch/arm/mach-omap1/Kconfig	2006-10-15 16:09:10.000000000 +0200
+++ linux-omap-z71/arch/arm/mach-omap1/Kconfig	2006-10-20 21:56:49.000000000 +0200
@@ -89,6 +89,15 @@
 	  http://palmtelinux.sourceforge.net/ for more information.
 	  Say Y here if you have this PDA model, say N otherwise.
 
+config MACH_OMAP_PALMZ71
+       bool "Palm Zire71"
+       depends on ARCH_OMAP1 && ARCH_OMAP15XX
+       help
+         Support for the Palm Zire71 PDA. To boot the kernel,
+         you'll need a PalmOS compatible bootloader; check out
+         http://hackndev.com/palm/z71 for more informations.
+         Say Y here if you have such a PDA, say N otherwise.
+
 config MACH_NOKIA770
 	bool "Nokia 770"
 	depends on ARCH_OMAP1 && ARCH_OMAP16XX
diff -Naur linux-omap/arch/arm/mach-omap1/Makefile linux-omap-z71/arch/arm/mach-omap1/Makefile
--- linux-omap/arch/arm/mach-omap1/Makefile	2006-10-15 16:09:10.000000000 +0200
+++ linux-omap-z71/arch/arm/mach-omap1/Makefile	2006-10-20 21:56:49.000000000 +0200
@@ -25,6 +25,7 @@
 obj-$(CONFIG_MACH_OMAP_H3)		+= board-h3.o
 obj-$(CONFIG_MACH_VOICEBLUE)		+= board-voiceblue.o
 obj-$(CONFIG_MACH_OMAP_PALMTE)		+= board-palmte.o
+obj-$(CONFIG_MACH_OMAP_PALMZ71)		+= board-palmz71.o
 obj-$(CONFIG_MACH_NOKIA770)		+= board-nokia770.o
 obj-$(CONFIG_MACH_AMS_DELTA)		+= board-ams-delta.o
 
diff -Naur linux-omap/arch/arm/mach-omap1/serial.c linux-omap-z71/arch/arm/mach-omap1/serial.c
--- linux-omap/arch/arm/mach-omap1/serial.c	2006-10-15 16:09:10.000000000 +0200
+++ linux-omap-z71/arch/arm/mach-omap1/serial.c	2006-10-20 21:56:49.000000000 +0200
@@ -1,7 +1,7 @@
 /*
- * linux/arch/arm/mach-omap1/id.c
+ * linux/arch/arm/mach-omap1/serial.c
  *
- * OMAP1 CPU identification code
+ * OMAP1 serial port driver
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -59,7 +59,7 @@
 	omap_serial_outp(p, UART_OMAP_SCR, 0x08);	/* TX watermark */
 	omap_serial_outp(p, UART_OMAP_MDR1, 0x00);	/* enable UART */
 
-	if (!cpu_is_omap1510()) {
+	if (!cpu_is_omap15xx()) {
 		omap_serial_outp(p, UART_OMAP_SYSC, 0x01);
 		while (!(omap_serial_in(p, UART_OMAP_SYSC) & 0x01));
 	}
@@ -121,7 +121,7 @@
 		serial_platform_data[1].irq = INT_730_UART_MODEM_IRDA_2;
 	}
 
-	if (cpu_is_omap1510()) {
+	if (cpu_is_omap15xx()) {
 		serial_platform_data[0].uartclk = OMAP1510_BASE_BAUD * 16;
 		serial_platform_data[1].uartclk = OMAP1510_BASE_BAUD * 16;
 		serial_platform_data[2].uartclk = OMAP1510_BASE_BAUD * 16;
@@ -147,10 +147,10 @@
 				printk("Could not get uart1_ck\n");
 			else {
 				clk_enable(uart1_ck);
-				if (cpu_is_omap1510())
+				if (cpu_is_omap15xx())
 					clk_set_rate(uart1_ck, 12000000);
 			}
-			if (cpu_is_omap1510()) {
+			if (cpu_is_omap15xx()) {
 				omap_cfg_reg(UART1_TX);
 				omap_cfg_reg(UART1_RTS);
 				if (machine_is_omap_innovator()) {
@@ -167,12 +167,12 @@
 				printk("Could not get uart2_ck\n");
 			else {
 				clk_enable(uart2_ck);
-				if (cpu_is_omap1510())
+				if (cpu_is_omap15xx())
 					clk_set_rate(uart2_ck, 12000000);
 				else
 					clk_set_rate(uart2_ck, 48000000);
 			}
-			if (cpu_is_omap1510()) {
+			if (cpu_is_omap15xx()) {
 				omap_cfg_reg(UART2_TX);
 				omap_cfg_reg(UART2_RTS);
 				if (machine_is_omap_innovator()) {
@@ -189,10 +189,10 @@
 				printk("Could not get uart3_ck\n");
 			else {
 				clk_enable(uart3_ck);
-				if (cpu_is_omap1510())
+				if (cpu_is_omap15xx())
 					clk_set_rate(uart3_ck, 12000000);
 			}
-			if (cpu_is_omap1510()) {
+			if (cpu_is_omap15xx()) {
 				omap_cfg_reg(UART3_TX);
 				omap_cfg_reg(UART3_RX);
 			}
diff -Naur linux-omap/drivers/video/omap/lcd_palmz71.c linux-omap-z71/drivers/video/omap/lcd_palmz71.c
--- linux-omap/drivers/video/omap/lcd_palmz71.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-omap-z71/drivers/video/omap/lcd_palmz71.c	2006-10-20 22:31:18.000000000 +0200
@@ -0,0 +1,128 @@
+/*
+ * File: drivers/video/omap/lcd_palmz71.c
+ *
+ * LCD panel support for the Palm Zire71
+ *
+ * Original version : Romain Goyet
+ * Current version : Laurent Gonzalez
+ * Modified for zire71 : Marek Vasut
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <asm/io.h>
+
+//#include <asm/arch/fpga.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch/omapfb.h>
+
+/* #define OMAPFB_DBG 1 */
+
+static int palmz71_panel_init(struct omapfb_device *panel)
+{
+	return 0;
+}
+
+static void palmz71_panel_cleanup(void)
+{
+
+}
+
+static int palmz71_panel_enable(void)
+{
+	return 0;
+}
+
+static void palmz71_panel_disable(void)
+{
+}
+
+static unsigned long palmz71_panel_get_caps(void)
+{
+return OMAPFB_CAPS_SET_BACKLIGHT;
+}
+
+struct lcd_panel palmz71_panel = {
+	.name		= "palmz71",
+	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
+			  OMAP_LCDC_INV_HSYNC | OMAP_LCDC_HSVS_RISING_EDGE |
+			  OMAP_LCDC_HSVS_OPPOSITE,
+	.data_lines	= 16,
+	.bpp		= 16,
+	.pixel_clock	= 24000,
+	.x_res		= 320,
+	.y_res		= 320,
+	.hsw		= 4,
+	.hfp		= 8,
+	.hbp		= 28,
+	.vsw		= 1,
+	.vfp		= 8,
+	.vbp		= 7,
+	.pcd		= 0,
+
+	.init		= palmz71_panel_init,
+	.cleanup	= palmz71_panel_cleanup,
+	.enable		= palmz71_panel_enable,
+	.disable	= palmz71_panel_disable,
+	.get_caps	= palmz71_panel_get_caps,
+};
+
+static int palmz71_panel_probe(struct platform_device *pdev)
+{
+	omapfb_register_panel(&palmz71_panel);
+	return 0;
+}
+
+static int palmz71_panel_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int palmz71_panel_suspend(struct platform_device *pdev, pm_message_t mesg)
+{
+	return 0;
+}
+
+static int palmz71_panel_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+struct platform_driver palmz71_panel_driver = {
+	.probe		= palmz71_panel_probe,
+	.remove		= palmz71_panel_remove,
+	.suspend	= palmz71_panel_suspend,
+	.resume		= palmz71_panel_resume,
+	.driver		= {
+		.name	= "lcd_palmz71",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int palmz71_panel_drv_init(void)
+{
+	return platform_driver_register(&palmz71_panel_driver);
+}
+
+static void palmz71_panel_drv_cleanup(void)
+{
+	platform_driver_unregister(&palmz71_panel_driver);
+}
+
+module_init(palmz71_panel_drv_init);
+module_exit(palmz71_panel_drv_cleanup);
diff -Naur linux-omap/drivers/video/omap/Makefile linux-omap-z71/drivers/video/omap/Makefile
--- linux-omap/drivers/video/omap/Makefile	2006-10-15 16:09:33.000000000 +0200
+++ linux-omap-z71/drivers/video/omap/Makefile	2006-10-20 21:56:49.000000000 +0200
@@ -19,6 +19,7 @@
 objs-y$(CONFIG_MACH_OMAP_H3) += lcd_h3.o
 objs-y$(CONFIG_MACH_OMAP_H2) += lcd_h2.o
 objs-y$(CONFIG_MACH_OMAP_PALMTE) += lcd_palmte.o
+objs-y$(CONFIG_MACH_OMAP_PALMZ71) += lcd_palmz71.o
 objs-$(CONFIG_ARCH_OMAP16XX)$(CONFIG_MACH_OMAP_INNOVATOR) += lcd_inn1610.o
 objs-$(CONFIG_ARCH_OMAP15XX)$(CONFIG_MACH_OMAP_INNOVATOR) += lcd_inn1510.o
 objs-y$(CONFIG_MACH_OMAP_OSK) += lcd_osk.o
diff -Naur linux-omap/include/asm-arm/arch-omap/board-palmz71.h linux-omap-z71/include/asm-arm/arch-omap/board-palmz71.h
--- linux-omap/include/asm-arm/arch-omap/board-palmz71.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-omap-z71/include/asm-arm/arch-omap/board-palmz71.h	2006-10-20 21:56:49.000000000 +0200
@@ -0,0 +1,26 @@
+/*
+ * linux/include/asm-arm/arch-omap/board-palmz71.h
+ *
+ * Hardware definitions for the Palm Zire71 device.
+ *
+ * Maintainters :	Marek Vasut <marek.vasut@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __OMAP_BOARD_PALMZ71_H
+#define __OMAP_BOARD_PALMZ71_H
+
+#define PALMZ71_USBDETECT_GPIO	0
+#define PALMZ71_PINTDAV_GPIO	6
+#define PALMZ71_MMC_WP_GPIO	8
+#define PALMZ71_HDQ_GPIO 	11
+
+#define PALMZ71_HOTSYNC_GPIO	OMAP_MPUIO(1)
+#define PALMZ71_CABLE_GPIO	OMAP_MPUIO(2)
+#define PALMZ71_SLIDER_GPIO	OMAP_MPUIO(3)
+#define PALMZ71_MMC_IN_GPIO	OMAP_MPUIO(4)
+
+#endif	/* __OMAP_BOARD_PALMZ71_H */
diff -Naur linux-omap/include/asm-arm/arch-omap/hardware.h linux-omap-z71/include/asm-arm/arch-omap/hardware.h
--- linux-omap/include/asm-arm/arch-omap/hardware.h	2006-10-15 16:09:42.000000000 +0200
+++ linux-omap-z71/include/asm-arm/arch-omap/hardware.h	2006-10-20 21:56:49.000000000 +0200
@@ -334,6 +334,10 @@
 #include "board-palmte.h"
 #endif
 
+#ifdef CONFIG_MACH_OMAP_PALMZ71
+#include "board-palmz71.h"
+#endif
+
 #endif /* !__ASSEMBLER__ */
 
 #endif	/* __ASM_ARCH_OMAP_HARDWARE_H */

--Boundary-00=_RmTOF8xDRZTfcf2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_RmTOF8xDRZTfcf2--
