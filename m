From: Kevin Hilman <khilman@mvista.com>
Subject: Re: 3430 and UART3 parent clocks
Date: Wed, 14 Nov 2007 07:07:28 -0800
Message-ID: <1195052848.15127.30.camel@vence.hilman.org>
References: <1194982452.7433.55.camel@vence.hilman.org>
	<Pine.LNX.4.64.0711140221470.3713@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-abB1siQeGm/L0s2Tdlp8"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <Pine.LNX.4.64.0711140221470.3713@utopia.booyaka.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>
Cc: amit@verdurent.com, OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


--=-abB1siQeGm/L0s2Tdlp8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Wed, 2007-11-14 at 02:24 -0700, Paul Walmsley wrote:
> Hi Kevin,
> 
> On Tue, 13 Nov 2007, Kevin Hilman wrote:
> 
> > On 3430 the board init code enables all 3 UARTs, but it appears the the
> > clocks for UART3 are not getting enabled because the first access to
> > UART3 registers crashes with:
> > 
> > Unhandled fault: external abort on non-linefetch (0x1028) at 0xd9020004 
> > 
> > Simply disabling UART3 in the enabled_uarts of board-3430sdp.c gets me a
> > booting board.
> 
> Thanks for the report.  I got a similar report not too long ago, but was 
> unable to replicate here.   could you tell me ...

Maybe your bootloader is passing an ATAG which doesn't enable UART3?

> ... What bootloader are you using?

u-boot from TI.  See the full console log attached for u-boot version
and details, as well as the crash dump.

I also do not have ES2.0 silicon, in case that might matter.

> ... Can you send me your .config?

attached

> ... Does the following patch fix the problem for you?  

It gets rid of the enable warnings, but still crashes during UART3
access.

Kevin



--=-abB1siQeGm/L0s2Tdlp8
Content-Disposition: attachment; filename=dot.config.3430
Content-Type: text/plain; name=dot.config.3430; charset=utf-8
Content-Transfer-Encoding: 7bit

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.23-omap1
# Mon Nov 12 18:21:35 2007
#
CONFIG_ARM=y
CONFIG_SYS_SUPPORTS_APM_EMULATION=y
CONFIG_GENERIC_GPIO=y
CONFIG_GENERIC_TIME=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_MMU=y
# CONFIG_NO_IOPORT is not set
CONFIG_GENERIC_HARDIRQS=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
# CONFIG_ARCH_HAS_ILOG2_U32 is not set
# CONFIG_ARCH_HAS_ILOG2_U64 is not set
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ZONE_DMA=y
CONFIG_VECTORS_BASE=0xffff0000
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# General setup
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
# CONFIG_USER_NS is not set
# CONFIG_AUDIT is not set
# CONFIG_IKCONFIG is not set
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_CGROUPS is not set
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_FAIR_USER_SCHED=y
# CONFIG_FAIR_CGROUP_SCHED is not set
CONFIG_SYSFS_DEPRECATED=y
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_EMBEDDED=y
CONFIG_UID16=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_EXTRA_PASS=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_ANON_INODES=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
CONFIG_RT_MUTEXES=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_KMOD=y
CONFIG_BLOCK=y
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set
# CONFIG_BLK_DEV_BSG is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# System Type
#
# CONFIG_ARCH_AAEC2000 is not set
# CONFIG_ARCH_INTEGRATOR is not set
# CONFIG_ARCH_REALVIEW is not set
# CONFIG_ARCH_VERSATILE is not set
# CONFIG_ARCH_AT91 is not set
# CONFIG_ARCH_CLPS7500 is not set
# CONFIG_ARCH_CLPS711X is not set
# CONFIG_ARCH_CO285 is not set
# CONFIG_ARCH_EBSA110 is not set
# CONFIG_ARCH_EP93XX is not set
# CONFIG_ARCH_FOOTBRIDGE is not set
# CONFIG_ARCH_NETX is not set
# CONFIG_ARCH_H720X is not set
# CONFIG_ARCH_IMX is not set
# CONFIG_ARCH_IOP13XX is not set
# CONFIG_ARCH_IOP32X is not set
# CONFIG_ARCH_IOP33X is not set
# CONFIG_ARCH_IXP23XX is not set
# CONFIG_ARCH_IXP2000 is not set
# CONFIG_ARCH_IXP4XX is not set
# CONFIG_ARCH_L7200 is not set
# CONFIG_ARCH_KS8695 is not set
# CONFIG_ARCH_NS9XXX is not set
# CONFIG_ARCH_MXC is not set
# CONFIG_ARCH_PNX4008 is not set
# CONFIG_ARCH_PXA is not set
# CONFIG_ARCH_RPC is not set
# CONFIG_ARCH_SA1100 is not set
# CONFIG_ARCH_S3C2410 is not set
# CONFIG_ARCH_SHARK is not set
# CONFIG_ARCH_LH7A40X is not set
# CONFIG_ARCH_DAVINCI is not set
CONFIG_ARCH_OMAP=y

#
# TI OMAP Implementations
#
# CONFIG_ARCH_OMAP1 is not set
# CONFIG_ARCH_OMAP2 is not set
CONFIG_ARCH_OMAP3=y

#
# OMAP Feature Selections
#
CONFIG_OMAP_RESET_CLOCKS=n
CONFIG_OMAP_BOOT_TAG=y
CONFIG_OMAP_BOOT_REASON=y
# CONFIG_OMAP_COMPONENT_VERSION is not set
# CONFIG_OMAP_GPIO_SWITCH is not set
CONFIG_OMAP_MUX=y
CONFIG_OMAP_MUX_DEBUG=y
CONFIG_OMAP_MUX_WARNINGS=y
# CONFIG_OMAP_MCBSP is not set
# CONFIG_OMAP_MMU_FWK is not set
# CONFIG_OMAP_MBOX_FWK is not set
CONFIG_OMAP_MPU_TIMER=y
# CONFIG_OMAP_32K_TIMER is not set
CONFIG_OMAP_DM_TIMER=y
CONFIG_OMAP_LL_DEBUG_UART1=y
# CONFIG_OMAP_LL_DEBUG_UART2 is not set
# CONFIG_OMAP_LL_DEBUG_UART3 is not set
CONFIG_OMAP_SERIAL_WAKE=y
CONFIG_ARCH_OMAP34XX=y
CONFIG_ARCH_OMAP3430=y

#
# OMAP Board Type
#
CONFIG_MACH_OMAP_3430SDP=y

#
# Boot options
#

#
# Power management
#

#
# Processor Type
#
CONFIG_CPU_32=y
CONFIG_CPU_32v6K=y
CONFIG_CPU_V7=y
CONFIG_CPU_32v7=y
CONFIG_CPU_ABRT_EV7=y
CONFIG_CPU_PABRT_IFAR=y
CONFIG_CPU_CACHE_V7=y
CONFIG_CPU_CACHE_VIPT=y
CONFIG_CPU_COPY_V6=y
CONFIG_CPU_TLB_V7=y
CONFIG_CPU_HAS_ASID=y
CONFIG_CPU_CP15=y
CONFIG_CPU_CP15_MMU=y

#
# Processor Features
#
CONFIG_ARM_THUMB=y
# CONFIG_ARM_XENON is not set
# CONFIG_CPU_ICACHE_DISABLE is not set
# CONFIG_CPU_DCACHE_DISABLE is not set
# CONFIG_CPU_BPREDICT_DISABLE is not set
CONFIG_HAS_TLS_REG=y
# CONFIG_OUTER_CACHE is not set

#
# Bus support
#
# CONFIG_PCI_SYSCALL is not set
# CONFIG_ARCH_SUPPORTS_MSI is not set
# CONFIG_PCCARD is not set

#
# Kernel Features
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
# CONFIG_PREEMPT is not set
CONFIG_HZ=100
CONFIG_AEABI=y
CONFIG_OABI_COMPAT=y
# CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_RESOURCES_64BIT is not set
CONFIG_ZONE_DMA_FLAG=1
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_LEDS is not set
CONFIG_ALIGNMENT_TRAP=y

#
# Boot options
#
CONFIG_ZBOOT_ROM_TEXT=0x0
CONFIG_ZBOOT_ROM_BSS=0x0
CONFIG_CMDLINE="root=/dev/nfs nfsroot=192.168.0.1:/home/user/buildroot ip=192.168.0.2:192.168.0.1:192.168.0.1:255.255.255.0:tgt:eth0:off rw console=ttyS2,115200n8"
# CONFIG_XIP_KERNEL is not set
# CONFIG_KEXEC is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Floating point emulation
#

#
# At least one emulation must be selected
#
CONFIG_FPE_NWFPE=y
# CONFIG_FPE_NWFPE_XP is not set
# CONFIG_FPE_FASTFPE is not set
CONFIG_VFP=y
CONFIG_VFPv3=y
# CONFIG_NEON is not set

#
# Userspace binary formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=y

#
# Power management options
#
# CONFIG_PM is not set
CONFIG_SUSPEND_UP_POSSIBLE=y

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=y
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
CONFIG_NET_KEY=y
# CONFIG_NET_KEY_MIGRATE is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
# CONFIG_INET_LRO is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set

#
# Wireless
#
# CONFIG_CFG80211 is not set
# CONFIG_WIRELESS_EXT is not set
# CONFIG_MAC80211 is not set
# CONFIG_IEEE80211 is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_CONNECTOR is not set
CONFIG_MTD=y
# CONFIG_MTD_DEBUG is not set
CONFIG_MTD_CONCAT=y
CONFIG_MTD_PARTITIONS=y
# CONFIG_MTD_REDBOOT_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=y
# CONFIG_MTD_AFS_PARTS is not set

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_MTD_OOPS is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_CFI_INTELEXT=y
# CONFIG_MTD_CFI_AMDSTD is not set
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_ARM_INTEGRATOR is not set
CONFIG_MTD_OMAP_NOR=y
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOC2000 is not set
# CONFIG_MTD_DOC2001 is not set
# CONFIG_MTD_DOC2001PLUS is not set
# CONFIG_MTD_NAND is not set
CONFIG_MTD_ONENAND=y
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
# CONFIG_MTD_ONENAND_GENERIC is not set
# CONFIG_MTD_ONENAND_OTP is not set
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
# CONFIG_MTD_ONENAND_SIM is not set

#
# UBI - Unsorted block images
#
# CONFIG_MTD_UBI is not set
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_MISC_DEVICES=y
# CONFIG_EEPROM_93CX6 is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
# CONFIG_SCSI is not set
# CONFIG_SCSI_DMA is not set
# CONFIG_SCSI_NETLINK is not set
# CONFIG_ATA is not set
# CONFIG_MD is not set
CONFIG_NETDEVICES=y
# CONFIG_NETDEVICES_MULTIQUEUE is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_MACVLAN is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_VETH is not set
# CONFIG_PHYLIB is not set
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_AX88796 is not set
CONFIG_SMC91X=y
# CONFIG_DM9000 is not set
# CONFIG_IBM_NEW_EMAC_ZMII is not set
# CONFIG_IBM_NEW_EMAC_RGMII is not set
# CONFIG_IBM_NEW_EMAC_TAH is not set
# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
# CONFIG_B44 is not set
CONFIG_NETDEV_1000=y
CONFIG_NETDEV_10000=y

#
# Wireless LAN
#
# CONFIG_WLAN_PRE80211 is not set
# CONFIG_WLAN_80211 is not set
# CONFIG_WAN is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ATKBD is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
# CONFIG_SERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_RSA=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
# CONFIG_NVRAM is not set
# CONFIG_R3964 is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_I2C is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_HWMON is not set

#
# Sonics Silicon Backplane
#
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_SM501 is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DVB_CORE is not set
CONFIG_DAB=y

#
# Graphics support
#
# CONFIG_VGASTATE is not set
CONFIG_VIDEO_OUTPUT_CONTROL=m
# CONFIG_FB is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Display device support
#
# CONFIG_DISPLAY_SUPPORT is not set

#
# Console display driver support
#
# CONFIG_VGA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
# CONFIG_HID_DEBUG is not set
# CONFIG_HIDRAW is not set
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
# CONFIG_USB_ARCH_HAS_EHCI is not set
# CONFIG_USB is not set

#
# Enable Host or Gadget support to see Inventra options
#

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set
# CONFIG_MMC is not set
# CONFIG_NEW_LEDS is not set
CONFIG_RTC_LIB=y
# CONFIG_RTC_CLASS is not set

#
# CBUS support
#
# CONFIG_CBUS is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_XATTR is not set
# CONFIG_EXT4DEV_FS is not set
CONFIG_JBD=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
# CONFIG_JFFS2_SUMMARY is not set
# CONFIG_JFFS2_FS_XATTR is not set
CONFIG_JFFS2_COMPRESSION_OPTIONS=y
CONFIG_JFFS2_ZLIB=y
# CONFIG_JFFS2_LZO is not set
CONFIG_JFFS2_RTIME=y
# CONFIG_JFFS2_RUBIN is not set
# CONFIG_JFFS2_CMODE_NONE is not set
CONFIG_JFFS2_CMODE_PRIORITY=y
# CONFIG_JFFS2_CMODE_SIZE is not set
# CONFIG_JFFS2_CMODE_FAVOURLZO is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_NFSD is not set
CONFIG_ROOT_NFS=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
# CONFIG_SUNRPC_BIND34 is not set
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set
CONFIG_INSTRUMENTATION=y
# CONFIG_PROFILING is not set
# CONFIG_MARKERS is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_CHECK is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_SHIRQ is not set
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_TIMER_STATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_FRAME_POINTER=y
CONFIG_FORCED_INLINING=y
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_SAMPLES is not set
CONFIG_DEBUG_USER=y
CONFIG_DEBUG_ERRORS=y
# CONFIG_DEBUG_LL is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITY_FILE_CAPABILITIES is not set
CONFIG_CRYPTO=y
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_MANAGER=y
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_GF128MUL is not set
CONFIG_CRYPTO_ECB=m
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_PCBC=m
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_XTS is not set
# CONFIG_CRYPTO_CRYPTD is not set
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_TEST is not set
# CONFIG_CRYPTO_AUTHENC is not set
CONFIG_CRYPTO_HW=y

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_CRC_CCITT=y
# CONFIG_CRC16 is not set
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=y
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_PLIST=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_DMA=y

--=-abB1siQeGm/L0s2Tdlp8
Content-Disposition: attachment; filename=minicom.cap
Content-Type: text/plain; name=minicom.cap; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by calf.ext.ti.com id lAEF7Z2G014882



U-Boot 1.1.4 (Jun 27 2007 - 00:17:31)

OMAP3430-GP rev 1, CPU-OPP2 L3-165MHz
TI 3430SDP 0.1 Version + mDDR (Boot NOR)
DRAM:  128 MB
Flash: 64 MB
Muxed OneNAND 128MB 1.8V 16-bit (0x30)
Scanning device for bad blocks
num of blocks =3D 2048
Bad eraseblock 32 at 0x00400000
In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot:  3 =08=08=08 2 =08=08=08 1 =08=08=08 0=20

*** Warning: ethaddr is not set properly, ignoring!!
Using MAC Address 08:00:28:01:16:03
BOOTP broadcast 1
*** WARNING: Root Path is too long (100 - max: 64) - truncated
*** WARNING: Root Path is too long (100 - max: 64) - truncated
DHCP client bound to address 192.168.1.171
TFTP from server 192.168.1.2; our IP address is 192.168.1.171
Filename 'omap3430/uImage'.
Load address: 0x80000000
Loading: *=08############################################################=
#####
	 #################################################################
	 #################################################################
	 #################################################################
	 ######################
done
Bytes transferred =3D 1439348 (15f674 hex)
## Booting image at 80000000 ...
   Image Name:   Linux-2.6.23-omap1-arm-omap3430-
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1439284 Bytes =3D  1.4 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing Linux......................................................=
......................................... done, booting the kernel.
Linux version 2.6.23-omap1-arm-omap3430-default-gc3b1efeb-dirty (khilman@=
paris) (gcc version 4.2.0 (MontaVista 4.2.0-16.0.4.0704316 2007-10-31)) #=
23 Wed Nov 14 07:00:13 PST 2007
CPU: ARMv7 Processor [410fc080] revision 0 (ARMv7), cr=3D00c5387f
Machine: OMAP3430 3430SDP board
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 32768
  DMA zone: 256 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 32512 pages, LIFO batch:7
  Normal zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
Unknown OMAP CPU id
SRAM: Mapped pa 0x40200000 to va 0xd0000000 size: 0x100000
CPU0: D VIPT write-through cache
CPU0: cache: 768 bytes, associativity 1, 8 byte lines, 64 sets
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 3251=
2
Kernel command line: console=3DttyS0,115200n8 noinitrd rw root=3D/dev/nfs=
 ip=3Ddhcp debug user_debug=3D0xffffffff
Clocking rate (Crystal/DPLL/MPU): 19.2/166/166 MHz
GPMC revision 4.0
IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP34xx GPIO hardware version 2.4
PID hash table entries: 512 (order: 9, 2048 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128MB 0MB =3D 128MB total
Memory: 126848KB available (2676K code, 229K data, 104K init)
Calibrating delay loop... 380.10 BogoMIPS (lpj=3D1900544)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
net_namespace: 64 bytes
NET: Registered protocol family 16
OMAP DMA hardware revision 4.0
USB: No board-specific platform config found
NET: Registered protocol family 2
Time: gp timer clocksource has been installed.
Switched to high resolution mode on CPU 0
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
NetWinder Floating Point Emulator V0.97 (double precision)
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
console [ttyS0] enabled
serial8250.0: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
Unhandled fault: external abort on non-linefetch (0x1028) at 0xd9020004
Internal error: : 1028 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.23-omap1-arm-omap3430-default-gc3b1efeb-dirty=
 #23)
PC is at serial_in+0x6c/0xb4
LR is at serial8250_config_port+0x94/0x9f4
pc : [<c0178df8>]    lr : [<c0179dc4>]    psr: 80000093
sp : c0819cd8  ip : c0819ce8  fp : c0819ce4
r10: c082c060  r9 : 00000001  r8 : 20000013
r7 : c02f0b84  r6 : 49020000  r5 : 00000000  r4 : 00000002
r3 : d9020000  r2 : 00000002  r1 : 00000004  r0 : c02f0b84
Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387f  Table: 80004018  DAC: 00000017
Process swapper (pid: 1, stack limit =3D 0xc08182d0)
Stack: (0xc0819cd8 to 0xc081a000)
9cc0:                                                       c0819d1c c081=
9ce8=20
9ce0: c0179dc4 c0178d98 fffffffe 49020000 c02f0b84 00000002 00000002 4902=
0000=20
9d00: c02f0b84 c0819dec c02c59f8 c082c060 c0819da4 c0819d20 c01783f0 c017=
9d3c=20
9d20: c0153910 c01547b0 c0819d44 c0819d38 c02dc998 c082c078 c0819d5c c081=
9d48=20
9d40: c017cad4 00000000 c0819d74 c0819d58 c02264f0 c0060244 c017cb74 0000=
0000=20
9d60: c02f0b84 c082c060 c0819d84 c0819d78 c0226558 c0226448 c0819da4 0000=
0002=20
9d80: 00000002 49020000 c02f0b84 c0819dec c02c59f8 c02c5970 c0819dcc c081=
9da8=20
9da0: c017b2e8 c01782f8 c02c5968 c0819dec c02c5ab8 00000001 00000002 c02c=
5970=20
9dc0: c0819e9c c0819dd0 c017b3b8 c017b19c c0819dfc c0819de0 c02264f0 c006=
0244=20
9de0: c00cb460 c0819e60 00000000 00000000 d9020000 0000004a 02dc6c00 0000=
0000=20
9e00: 00020200 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000=20
9e20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000=20
9e40: 00000000 11000000 00000000 00000000 00000000 00000000 00000000 0000=
0000=20
9e60: 49020000 c02c5970 00000000 00000000 c02c5970 c02c5970 c02c5970 c02d=
c9dc=20
9e80: c02dc9dc c0818000 00000000 c001f000 c0819eac c0819ea0 c01808ec c017=
b328=20
9ea0: c0819ecc c0819eb0 c017f124 c01808d8 c02c5a14 c02c5970 c017f2a8 c02d=
c9dc=20
9ec0: c0819ee4 c0819ed0 c017f324 c017f054 00000000 c0819eec c0819f14 c081=
9ee8=20
9ee0: c017e488 c017f2b4 00000000 c02dce90 c02dce90 c02c59b8 c02dc9dc c02d=
c9e4=20
9f00: 00000000 c02dcdf8 c0819f24 c0819f18 c017ef64 c017e444 c0819f44 c081=
9f28=20
9f20: c017e834 c017ef50 c02dc9dc c02f0cf4 c02dc908 c0875a08 c0819f5c c081=
9f48=20
9f40: c017f58c c017e7d0 c02f0c3c 00000005 c0819f6c c0819f60 c0180b74 c017=
f514=20
9f60: c0819f8c c0819f70 c001956c c0180b14 00000000 00000000 00000000 c001=
e6b8=20
9f80: c0819ff4 c0819f90 c00087c4 c00194bc c0819fac c0819fa0 c00406b8 c004=
0454=20
9fa0: 00000000 c0819fb0 c0022ea4 c00406ac 00000000 00000000 c0008704 c004=
6a6c=20
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000=20
9fe0: 00000000 00000000 00000000 c0819ff8 c0046a6c c0008710 ff00ff00 ff00=
ff00=20
Backtrace:=20
[<c0178d8c>] (serial_in+0x0/0xb4) from [<c0179dc4>] (serial8250_config_po=
rt+0x94/0x9f4)
[<c0179d30>] (serial8250_config_port+0x0/0x9f4) from [<c01783f0>] (uart_a=
dd_one_port+0x104/0x2e4)
[<c01782ec>] (uart_add_one_port+0x0/0x2e4) from [<c017b2e8>] (serial8250_=
register_port+0x158/0x18c)
[<c017b190>] (serial8250_register_port+0x0/0x18c) from [<c017b3b8>] (seri=
al8250_probe+0x9c/0x114)
[<c017b31c>] (serial8250_probe+0x0/0x114) from [<c01808ec>] (platform_drv=
_probe+0x20/0x24)
[<c01808cc>] (platform_drv_probe+0x0/0x24) from [<c017f124>] (driver_prob=
e_device+0xdc/0x18c)
[<c017f048>] (driver_probe_device+0x0/0x18c) from [<c017f324>] (__driver_=
attach+0x7c/0xd4)
 r7:c02dc9dc r6:c017f2a8 r5:c02c5970 r4:c02c5a14
[<c017f2a8>] (__driver_attach+0x0/0xd4) from [<c017e488>] (bus_for_each_d=
ev+0x50/0x84)
 r5:c0819eec r4:00000000
[<c017e438>] (bus_for_each_dev+0x0/0x84) from [<c017ef64>] (driver_attach=
+0x20/0x28)
 r7:c02dcdf8 r6:00000000 r5:c02dc9e4 r4:c02dc9dc
[<c017ef44>] (driver_attach+0x0/0x28) from [<c017e834>] (bus_add_driver+0=
x70/0x1c0)
[<c017e7c4>] (bus_add_driver+0x0/0x1c0) from [<c017f58c>] (driver_registe=
r+0x84/0x8c)
 r7:c0875a08 r6:c02dc908 r5:c02f0cf4 r4:c02dc9dc
[<c017f508>] (driver_register+0x0/0x8c) from [<c0180b74>] (platform_drive=
r_register+0x6c/0x88)
 r4:00000005
[<c0180b08>] (platform_driver_register+0x0/0x88) from [<c001956c>] (seria=
l8250_init+0xbc/0x110)
[<c00194b0>] (serial8250_init+0x0/0x110) from [<c00087c4>] (kernel_init+0=
xc0/0x274)
 r7:c001e6b8 r6:00000000 r5:00000000 r4:00000000
[<c0008704>] (kernel_init+0x0/0x274) from [<c0046a6c>] (do_exit+0x0/0x6cc=
)
Code: e5903000 e5d33001 ea00000c e5903004 (e7d33001)=20
Kernel panic - not syncing: Attempted to kill init!

--=-abB1siQeGm/L0s2Tdlp8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--=-abB1siQeGm/L0s2Tdlp8--
