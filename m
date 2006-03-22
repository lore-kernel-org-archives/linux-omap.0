From: Jonathan McDowell <noodles@earth.li>
Subject: [PATCH] Add support for Amstrad Delta (E3) Videophone
Date: Wed, 22 Mar 2006 11:39:03 +0000
Message-ID: <20060322113903.GK5187@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Resent-Message-ID: <20060322174422.GL26949@earth.li>
Resent-To: linux-omap-open-source@linux.omap.com
Content-Disposition: inline
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
Cc: e3-hacking@earth.li
List-Id: linux-omap@vger.kernel.org

This patch adds support for the Amstrad Delta (E3) Videophone. This is
an OMAP5910 based device, which you can find more details about at:

http://www.amstrad.com/products/emailers/e3.html
http://www.earth.li/~noodles/hardware-e3.html

Patch is against latest git://source.mvista.com/git/linux-omap-2.6 and
adds the bare minimum of support for the device; I have a handful of
other patches to sort out the NAND, LCD, keymap and USB but they all
depend on this one.

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

-----
diff --git a/arch/arm/configs/ams_delta_defconfig b/arch/arm/configs/ams_delta_defconfig
new file mode 100644
index 0000000..03f02dd
--- /dev/null
+++ b/arch/arm/configs/ams_delta_defconfig
@@ -0,0 +1,880 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.16-omap1
+# Wed Mar 22 10:53:48 2006
+#
+CONFIG_ARM=y
+CONFIG_MMU=y
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_UID16=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_EMBEDDED is not set
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
+CONFIG_SLAB=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+# CONFIG_SLOB is not set
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_OBSOLETE_MODPARM=y
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_KMOD=y
+
+#
+# Block layer
+#
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+CONFIG_DEFAULT_AS=y
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="anticipatory"
+
+#
+# System Type
+#
+# CONFIG_ARCH_CLPS7500 is not set
+# CONFIG_ARCH_CLPS711X is not set
+# CONFIG_ARCH_CO285 is not set
+# CONFIG_ARCH_EBSA110 is not set
+# CONFIG_ARCH_FOOTBRIDGE is not set
+# CONFIG_ARCH_INTEGRATOR is not set
+# CONFIG_ARCH_IOP3XX is not set
+# CONFIG_ARCH_IXP4XX is not set
+# CONFIG_ARCH_IXP2000 is not set
+# CONFIG_ARCH_L7200 is not set
+# CONFIG_ARCH_PXA is not set
+# CONFIG_ARCH_RPC is not set
+# CONFIG_ARCH_SA1100 is not set
+# CONFIG_ARCH_S3C2410 is not set
+# CONFIG_ARCH_SHARK is not set
+# CONFIG_ARCH_LH7A40X is not set
+CONFIG_ARCH_OMAP=y
+# CONFIG_ARCH_VERSATILE is not set
+# CONFIG_ARCH_REALVIEW is not set
+# CONFIG_ARCH_IMX is not set
+# CONFIG_ARCH_H720X is not set
+# CONFIG_ARCH_AAEC2000 is not set
+# CONFIG_ARCH_AT91RM9200 is not set
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
+CONFIG_OMAP_MUX=y
+# CONFIG_OMAP_MUX_DEBUG is not set
+CONFIG_OMAP_MUX_WARNINGS=y
+CONFIG_OMAP_MPU_TIMER=y
+# CONFIG_OMAP_32K_TIMER is not set
+CONFIG_OMAP_LL_DEBUG_UART1=y
+# CONFIG_OMAP_LL_DEBUG_UART2 is not set
+# CONFIG_OMAP_LL_DEBUG_UART3 is not set
+CONFIG_OMAP_SERIAL_WAKE=y
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
+CONFIG_MACH_AMS_DELTA=y
+# CONFIG_MACH_OMAP_GENERIC is not set
+
+#
+# OMAP CPU Speed
+#
+# CONFIG_OMAP_CLOCKS_SET_BY_BOOTLOADER is not set
+# CONFIG_OMAP_ARM_168MHZ is not set
+CONFIG_OMAP_ARM_150MHZ=y
+# CONFIG_OMAP_ARM_120MHZ is not set
+# CONFIG_OMAP_ARM_60MHZ is not set
+# CONFIG_OMAP_ARM_30MHZ is not set
+# CONFIG_OMAP_DSP is not set
+
+#
+# Processor Type
+#
+CONFIG_CPU_32=y
+CONFIG_CPU_ARM925T=y
+CONFIG_CPU_32v4=y
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
+CONFIG_CPU_DCACHE_WRITETHROUGH=y
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
+CONFIG_PREEMPT=y
+# CONFIG_NO_IDLE_HZ is not set
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
+# CONFIG_LEDS is not set
+CONFIG_ALIGNMENT_TRAP=y
+
+#
+# Boot options
+#
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_CMDLINE="mem=32M console=ttyS0,115200n8 root=/dev/ram0 initrd=0x11c00000,4M"
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
+# CONFIG_BINFMT_AOUT is not set
+# CONFIG_BINFMT_MISC is not set
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
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+# CONFIG_IP_PNP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_BIC=y
+CONFIG_IPV6=y
+# CONFIG_IPV6_PRIVACY is not set
+# CONFIG_INET6_AH is not set
+# CONFIG_INET6_ESP is not set
+# CONFIG_INET6_IPCOMP is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_IPV6_TUNNEL is not set
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
+# CONFIG_NET_DIVERT is not set
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
+# CONFIG_DEBUG_DRIVER is not set
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
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_BLK_DEV_INITRD=y
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
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# PHY device support
+#
+# CONFIG_PHYLIB is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_SMC91X is not set
+# CONFIG_DM9000 is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+
+#
+# Ethernet (10000 Mbit)
+#
+
+#
+# Token Ring devices
+#
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+CONFIG_PPP=y
+CONFIG_PPP_MULTILINK=y
+# CONFIG_PPP_FILTER is not set
+# CONFIG_PPP_ASYNC is not set
+# CONFIG_PPP_SYNC_TTY is not set
+# CONFIG_PPP_DEFLATE is not set
+# CONFIG_PPP_BSDCOMP is not set
+# CONFIG_PPP_MPPE is not set
+# CONFIG_PPPOE is not set
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
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_ATKBD=y
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+CONFIG_KEYBOARD_OMAP=y
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+CONFIG_SERIO_SERPORT=y
+CONFIG_SERIO_LIBPS2=y
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
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
+# CONFIG_LEGACY_PTYS is not set
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
+# CONFIG_NVRAM is not set
+# CONFIG_RTC is not set
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
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+
+#
+# I2C Algorithms
+#
+CONFIG_I2C_ALGOBIT=y
+# CONFIG_I2C_ALGOPCF is not set
+# CONFIG_I2C_ALGOPCA is not set
+
+#
+# I2C Hardware Bus support
+#
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_STUB is not set
+# CONFIG_I2C_PCA_ISA is not set
+CONFIG_I2C_OMAP=y
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_SENSORS_DS1337 is not set
+# CONFIG_SENSORS_DS1374 is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_RTC8564 is not set
+# CONFIG_TPS65010 is not set
+# CONFIG_SENSORS_TLV320AIC23 is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_RTC_X1205_I2C is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+
+#
+# SPI support
+#
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Hardware Monitoring support
+#
+# CONFIG_HWMON is not set
+# CONFIG_HWMON_VID is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia Capabilities Port drivers
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
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
+# CONFIG_USB is not set
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
+# CONFIG_MMC is not set
+
+#
+# Synchronous Serial Interfaces (SSI)
+#
+# CONFIG_OMAP_UWIRE is not set
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
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+CONFIG_AUTOFS_FS=y
+CONFIG_AUTOFS4_FS=y
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
+CONFIG_FAT_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+# CONFIG_RELAYFS_FS is not set
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
+CONFIG_NFS_FS=y
+# CONFIG_NFS_V3 is not set
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_LOCKD=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
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
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+# CONFIG_MAC_PARTITION is not set
+CONFIG_MSDOS_PARTITION=y
+# CONFIG_BSD_DISKLABEL is not set
+# CONFIG_MINIX_SUBPARTITION is not set
+# CONFIG_SOLARIS_X86_PARTITION is not set
+# CONFIG_UNIXWARE_DISKLABEL is not set
+# CONFIG_LDM_PARTITION is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_KARMA_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+
+#
+# Native Language Support
+#
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=y
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+CONFIG_NLS_CODEPAGE_850=y
+CONFIG_NLS_CODEPAGE_852=y
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_ISO8859_2=y
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
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
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_DETECT_SOFTLOCKUP=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_DEBUG_SLAB is not set
+CONFIG_DEBUG_PREEMPT=y
+CONFIG_DEBUG_MUTEXES=y
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_BUGVERBOSE=y
+# CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_DEBUG_VM is not set
+CONFIG_FRAME_POINTER=y
+CONFIG_FORCED_INLINING=y
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_DEBUG_USER is not set
+# CONFIG_DEBUG_WAITQ is not set
+# CONFIG_DEBUG_ERRORS is not set
+# CONFIG_DEBUG_LL is not set
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
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index 0cad7be..fc7d3ce 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -87,6 +87,13 @@ config MACH_NOKIA770
 	  Support for the Nokia 770 Internet Tablet. Say Y here if you
 	  have such a device.
 
+config MACH_AMS_DELTA
+	bool "Amstrad E3 (Delta)"
+	depends on ARCH_OMAP1 && ARCH_OMAP15XX
+	help
+	  Support for the Amstrad E3 (codename Delta) videophone. Say Y here
+	  if you have such a device.
+
 config MACH_OMAP_GENERIC
 	bool "Generic OMAP board"
 	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX)
diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 5e0e023..9ea7195 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_MACH_OMAP_H3)		+= board-h3.
 obj-$(CONFIG_MACH_VOICEBLUE)		+= board-voiceblue.o
 obj-$(CONFIG_MACH_OMAP_PALMTE)		+= board-palmte.o
 obj-$(CONFIG_MACH_NOKIA770)		+= board-nokia770.o
+obj-$(CONFIG_MACH_AMS_DELTA)		+= board-ams-delta.o
 
 ifeq ($(CONFIG_ARCH_OMAP15XX),y)
 # Innovator-1510 FPGA
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
new file mode 100644
index 0000000..6178f04
--- /dev/null
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -0,0 +1,116 @@
+/*
+ * linux/arch/arm/mach-omap1/board-ams-delta.c
+ *
+ * Modified from board-generic.c
+ *
+ * Board specific inits for the Amstrad E3 (codename Delta) videophone
+ *
+ * Copyright (C) 2006 Jonathan McDowell <noodles@earth.li>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include <asm/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <asm/arch/board-ams-delta.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch/mux.h>
+#include <asm/arch/usb.h>
+#include <asm/arch/board.h>
+#include <asm/arch/common.h>
+
+static u8 ams_delta_latch1_reg;
+static u16 ams_delta_latch2_reg;
+
+void ams_delta_latch1_write(u8 mask, u8 value)
+{
+	ams_delta_latch1_reg &= ~mask;
+	ams_delta_latch1_reg |= value;
+	*(volatile __u8 *) AMS_DELTA_LATCH1_VIRT = ams_delta_latch1_reg;
+}
+
+void ams_delta_latch2_write(u16 mask, u16 value)
+{
+	ams_delta_latch2_reg &= ~mask;
+	ams_delta_latch2_reg |= value;
+	*(volatile __u16 *) AMS_DELTA_LATCH2_VIRT = ams_delta_latch2_reg;
+}
+
+static void __init ams_delta_init_irq(void)
+{
+	omap1_init_common_hw();
+	omap_init_irq();
+	omap_gpio_init();
+}
+
+static struct map_desc ams_delta_io_desc[] __initdata = {
+	// AMS_DELTA_LATCH1
+	{
+		.virtual	= AMS_DELTA_LATCH1_VIRT,
+		.pfn		= __phys_to_pfn(AMS_DELTA_LATCH1_PHYS),
+		.length		= 0x01000000,
+		.type		= MT_DEVICE
+	},
+	// AMS_DELTA_LATCH2
+	{
+		.virtual	= AMS_DELTA_LATCH2_VIRT,
+		.pfn		= __phys_to_pfn(AMS_DELTA_LATCH2_PHYS),
+		.length		= 0x01000000,
+		.type		= MT_DEVICE
+	},
+	// AMS_DELTA_MODEM
+	{
+		.virtual	= AMS_DELTA_MODEM_VIRT,
+		.pfn		= __phys_to_pfn(AMS_DELTA_MODEM_PHYS),
+		.length		= 0x01000000,
+		.type		= MT_DEVICE
+	}
+};
+
+static struct omap_uart_config ams_delta_uart_config __initdata = {
+	.enabled_uarts = 1,
+};
+
+static struct omap_board_config_kernel ams_delta_config[] = {
+	{ OMAP_TAG_UART,	&ams_delta_uart_config },
+};
+
+static void __init ams_delta_init(void)
+{
+	iotable_init(ams_delta_io_desc, ARRAY_SIZE(ams_delta_io_desc));
+
+	omap_board_config = ams_delta_config;
+	omap_board_config_size = ARRAY_SIZE(ams_delta_config);
+	omap_serial_init();
+
+	/* Clear latch2 (NAND, LCD, modem enable) */
+	ams_delta_latch2_write(~0, 0);
+}
+
+static void __init ams_delta_map_io(void)
+{
+	omap1_map_common_io();
+}
+
+MACHINE_START(AMS_DELTA, "Amstrad E3 (Delta)")
+	/* Maintainer: Jonathan McDowell <noodles@earth.li> */
+	.phys_io	= 0xfff00000,
+	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
+	.boot_params	= 0x10000100,
+	.map_io		= ams_delta_map_io,
+	.init_irq	= ams_delta_init_irq,
+	.init_machine	= ams_delta_init,
+	.timer		= &omap_timer,
+MACHINE_END
+
+EXPORT_SYMBOL(ams_delta_latch1_write);
+EXPORT_SYMBOL(ams_delta_latch2_write);
diff --git a/include/asm-arm/arch-omap/board-ams-delta.h b/include/asm-arm/arch-omap/board-ams-delta.h
new file mode 100644
index 0000000..88bb3c6
--- /dev/null
+++ b/include/asm-arm/arch-omap/board-ams-delta.h
@@ -0,0 +1,65 @@
+/*
+ * linux/include/asm-arm/arch-omap/board-ams-delta.h
+ *
+ * Copyright (C) 2006 Jonathan McDowell <noodles@earth.li>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#ifndef __ASM_ARCH_OMAP_AMS_DELTA_H
+#define __ASM_ARCH_OMAP_AMS_DELTA_H
+
+#if defined (CONFIG_MACH_AMS_DELTA)
+
+#define AMS_DELTA_LATCH1_PHYS		0x01000000
+#define AMS_DELTA_LATCH1_VIRT		0xEA000000
+#define AMS_DELTA_MODEM_PHYS		0x04000000
+#define AMS_DELTA_MODEM_VIRT		0xEB000000
+#define AMS_DELTA_LATCH2_PHYS		0x08000000
+#define AMS_DELTA_LATCH2_VIRT		0xEC000000
+
+#define AMS_DELTA_LATCH1_LED_CAMERA	0x01
+#define AMS_DELTA_LATCH1_LED_ADVERT	0x02
+#define AMS_DELTA_LATCH1_LED_EMAIL	0x04
+#define AMS_DELTA_LATCH1_LED_HANDSFREE	0x08
+#define AMS_DELTA_LATCH1_LED_VOICEMAIL	0x10
+#define AMS_DELTA_LATCH1_LED_VOICE	0x20
+
+#define AMS_DELTA_LATCH2_LCD_VBLEN	0x0001
+#define AMS_DELTA_LATCH2_LCD_NDISP	0x0002
+#define AMS_DELTA_LATCH2_NAND_NCE	0x0004
+#define AMS_DELTA_LATCH2_NAND_NRE	0x0008
+#define AMS_DELTA_LATCH2_NAND_NWP	0x0010
+#define AMS_DELTA_LATCH2_NAND_NWE	0x0020
+#define AMS_DELTA_LATCH2_NAND_ALE	0x0040
+#define AMS_DELTA_LATCH2_NAND_CLE	0x0080
+#define AMS_DELTA_LATCH2_MODEM_NRESET	0x1000
+#define AMS_DELTA_LATCH2_MODEM_CODEC	0x2000
+
+#define AMS_DELTA_GPIO_PIN_NAND_RB	12
+
+#ifndef __ASSEMBLY__
+void ams_delta_latch1_write(u8 mask, u8 value);
+void ams_delta_latch2_write(u16 mask, u16 value);
+#endif
+
+#endif /* CONFIG_MACH_AMS_DELTA */
+
+#endif /* __ASM_ARCH_OMAP_AMS_DELTA_H */
-----

J.

-- 
    "Making the impossible very    |  .''`.  Debian GNU/Linux Developer
    difficult" -- The OpenGALEN    | : :' :  Happy to accept PGP signed
             website.              | `. `'   or encrypted mail - RSA +
                                   |   `-    DSA keys on the keyservers.
