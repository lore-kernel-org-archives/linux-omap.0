From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH 4/11] OMAP 3430 SDP default config
Date: Tue, 29 May 2007 01:21:16 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47FF0E30@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


Default configuration file for OMAP3430 based TI's OMAP3430 SDP

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files Changed:
 omap_3430sdp_defconfig | 1058 =
+++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 1058 insertions(+)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -purN linux-omap/arch/arm/configs/omap_3430sdp_defconfig =
val_3430_GIT/arch/arm/configs/omap_3430sdp_defconfig
--- linux-omap/arch/arm/configs/omap_3430sdp_defconfig	1969-12-31 =
18:00:00.000000000 -0600
+++ val_3430_GIT/arch/arm/configs/omap_3430sdp_defconfig	2007-05-28 =
22:15:09.000000000 -0500
@@ -0,0 +1,1058 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.22-rc2-omap1
+# Mon May 28 22:14:57 2007
+#
+CONFIG_ARM=3Dy
+CONFIG_SYS_SUPPORTS_APM_EMULATION=3Dy
+CONFIG_GENERIC_GPIO=3Dy
+CONFIG_GENERIC_TIME=3Dy
+CONFIG_GENERIC_CLOCKEVENTS=3Dy
+CONFIG_MMU=3Dy
+# CONFIG_NO_IOPORT is not set
+CONFIG_GENERIC_HARDIRQS=3Dy
+CONFIG_STACKTRACE_SUPPORT=3Dy
+CONFIG_LOCKDEP_SUPPORT=3Dy
+CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
+CONFIG_HARDIRQS_SW_RESEND=3Dy
+CONFIG_GENERIC_IRQ_PROBE=3Dy
+CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy
+# CONFIG_ARCH_HAS_ILOG2_U32 is not set
+# CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_GENERIC_HWEIGHT=3Dy
+CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
+CONFIG_ZONE_DMA=3Dy
+CONFIG_VECTORS_BASE=3D0xffff0000
+CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=3Dy
+CONFIG_BROKEN_ON_SMP=3Dy
+CONFIG_INIT_ENV_ARG_LIMIT=3D32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=3D""
+CONFIG_LOCALVERSION_AUTO=3Dy
+CONFIG_SWAP=3Dy
+CONFIG_SYSVIPC=3Dy
+# CONFIG_IPC_NS is not set
+CONFIG_SYSVIPC_SYSCTL=3Dy
+# CONFIG_POSIX_MQUEUE is not set
+CONFIG_BSD_PROCESS_ACCT=3Dy
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_UTS_NS is not set
+# CONFIG_AUDIT is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=3D14
+CONFIG_SYSFS_DEPRECATED=3Dy
+# CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=3Dy
+CONFIG_INITRAMFS_SOURCE=3D""
+CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
+CONFIG_SYSCTL=3Dy
+CONFIG_EMBEDDED=3Dy
+CONFIG_UID16=3Dy
+# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_KALLSYMS=3Dy
+# CONFIG_KALLSYMS_ALL is not set
+CONFIG_KALLSYMS_EXTRA_PASS=3Dy
+CONFIG_HOTPLUG=3Dy
+CONFIG_PRINTK=3Dy
+CONFIG_BUG=3Dy
+CONFIG_ELF_CORE=3Dy
+CONFIG_BASE_FULL=3Dy
+CONFIG_FUTEX=3Dy
+CONFIG_ANON_INODES=3Dy
+CONFIG_EPOLL=3Dy
+CONFIG_SIGNALFD=3Dy
+CONFIG_TIMERFD=3Dy
+CONFIG_EVENTFD=3Dy
+CONFIG_SHMEM=3Dy
+CONFIG_VM_EVENT_COUNTERS=3Dy
+CONFIG_SLAB=3Dy
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
+CONFIG_RT_MUTEXES=3Dy
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=3D0
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=3Dy
+CONFIG_MODULE_UNLOAD=3Dy
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+CONFIG_MODVERSIONS=3Dy
+CONFIG_MODULE_SRCVERSION_ALL=3Dy
+CONFIG_KMOD=3Dy
+
+#
+# Block layer
+#
+CONFIG_BLOCK=3Dy
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=3Dy
+CONFIG_IOSCHED_AS=3Dy
+CONFIG_IOSCHED_DEADLINE=3Dy
+CONFIG_IOSCHED_CFQ=3Dy
+CONFIG_DEFAULT_AS=3Dy
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED=3D"anticipatory"
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
+# CONFIG_ARCH_IOP13XX is not set
+# CONFIG_ARCH_IOP32X is not set
+# CONFIG_ARCH_IOP33X is not set
+# CONFIG_ARCH_IXP23XX is not set
+# CONFIG_ARCH_IXP2000 is not set
+# CONFIG_ARCH_IXP4XX is not set
+# CONFIG_ARCH_L7200 is not set
+# CONFIG_ARCH_KS8695 is not set
+# CONFIG_ARCH_NS9XXX is not set
+# CONFIG_ARCH_PNX4008 is not set
+# CONFIG_ARCH_PXA is not set
+# CONFIG_ARCH_RPC is not set
+# CONFIG_ARCH_SA1100 is not set
+# CONFIG_ARCH_S3C2410 is not set
+# CONFIG_ARCH_SHARK is not set
+# CONFIG_ARCH_LH7A40X is not set
+# CONFIG_ARCH_DAVINCI is not set
+CONFIG_ARCH_OMAP=3Dy
+
+#
+# TI OMAP Implementations
+#
+# CONFIG_ARCH_OMAP1 is not set
+# CONFIG_ARCH_OMAP2 is not set
+CONFIG_ARCH_OMAP3=3Dy
+
+#
+# OMAP Feature Selections
+#
+# CONFIG_OMAP_RESET_CLOCKS is not set
+CONFIG_OMAP_BOOT_TAG=3Dy
+CONFIG_OMAP_BOOT_REASON=3Dy
+# CONFIG_OMAP_COMPONENT_VERSION is not set
+# CONFIG_OMAP_GPIO_SWITCH is not set
+CONFIG_OMAP_MUX=3Dy
+CONFIG_OMAP_MUX_DEBUG=3Dy
+CONFIG_OMAP_MUX_WARNINGS=3Dy
+# CONFIG_OMAP_MCBSP is not set
+# CONFIG_OMAP_MMU_FWK is not set
+# CONFIG_OMAP_MBOX_FWK is not set
+CONFIG_OMAP_MPU_TIMER=3Dy
+# CONFIG_OMAP_32K_TIMER is not set
+CONFIG_OMAP_DM_TIMER=3Dy
+CONFIG_OMAP_LL_DEBUG_UART1=3Dy
+# CONFIG_OMAP_LL_DEBUG_UART2 is not set
+# CONFIG_OMAP_LL_DEBUG_UART3 is not set
+CONFIG_OMAP_SERIAL_WAKE=3Dy
+CONFIG_ARCH_OMAP34XX=3Dy
+CONFIG_ARCH_OMAP3430=3Dy
+
+#
+# OMAP Board Type
+#
+CONFIG_MACH_OMAP_3430SDP=3Dy
+
+#
+# Processor Type
+#
+CONFIG_CPU_32=3Dy
+CONFIG_CPU_32v6K=3Dy
+CONFIG_CPU_V7=3Dy
+CONFIG_CPU_32v7=3Dy
+CONFIG_CPU_ABRT_EV7=3Dy
+CONFIG_CPU_CACHE_V7=3Dy
+CONFIG_CPU_CACHE_VIPT=3Dy
+CONFIG_CPU_COPY_V6=3Dy
+CONFIG_CPU_TLB_V6=3Dy
+CONFIG_CPU_HAS_ASID=3Dy
+CONFIG_CPU_CP15=3Dy
+CONFIG_CPU_CP15_MMU=3Dy
+
+#
+# Processor Features
+#
+CONFIG_ARM_THUMB=3Dy
+# CONFIG_CPU_ICACHE_DISABLE is not set
+# CONFIG_CPU_DCACHE_DISABLE is not set
+CONFIG_CPU_L2CACHE_DISABLE=3Dy
+# CONFIG_CPU_BPREDICT_DISABLE is not set
+CONFIG_HAS_TLS_REG=3Dy
+# CONFIG_OUTER_CACHE is not set
+
+#
+# Bus support
+#
+# CONFIG_ARCH_SUPPORTS_MSI is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# Kernel Features
+#
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+# CONFIG_PREEMPT is not set
+CONFIG_HZ=3D100
+CONFIG_AEABI=3Dy
+CONFIG_OABI_COMPAT=3Dy
+# CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
+CONFIG_SELECT_MEMORY_MODEL=3Dy
+CONFIG_FLATMEM_MANUAL=3Dy
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=3Dy
+CONFIG_FLAT_NODE_MEM_MAP=3Dy
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=3D4
+# CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=3D1
+# CONFIG_LEDS is not set
+CONFIG_ALIGNMENT_TRAP=3Dy
+
+#
+# Boot options
+#
+CONFIG_ZBOOT_ROM_TEXT=3D0x0
+CONFIG_ZBOOT_ROM_BSS=3D0x0
+CONFIG_CMDLINE=3D"root=3D/dev/nfs =
nfsroot=3D192.168.0.1:/home/user/buildroot =
ip=3D192.168.0.2:192.168.0.1:192.168.0.1:255.255.255.0:tgt:eth0:off rw =
console=3DttyS2,115200n8"
+# CONFIG_XIP_KERNEL is not set
+# CONFIG_KEXEC is not set
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
+CONFIG_FPE_NWFPE=3Dy
+# CONFIG_FPE_NWFPE_XP is not set
+# CONFIG_FPE_FASTFPE is not set
+CONFIG_VFP=3Dy
+CONFIG_VFPv3=3Dy
+# CONFIG_NEON is not set
+
+#
+# Userspace binary formats
+#
+CONFIG_BINFMT_ELF=3Dy
+# CONFIG_BINFMT_AOUT is not set
+CONFIG_BINFMT_MISC=3Dy
+
+#
+# Power management options
+#
+# CONFIG_PM is not set
+
+#
+# Networking
+#
+CONFIG_NET=3Dy
+
+#
+# Networking options
+#
+CONFIG_PACKET=3Dy
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=3Dy
+CONFIG_XFRM=3Dy
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
+CONFIG_NET_KEY=3Dy
+# CONFIG_NET_KEY_MIGRATE is not set
+CONFIG_INET=3Dy
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=3Dy
+CONFIG_IP_PNP=3Dy
+CONFIG_IP_PNP_DHCP=3Dy
+CONFIG_IP_PNP_BOOTP=3Dy
+CONFIG_IP_PNP_RARP=3Dy
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_XFRM_MODE_TRANSPORT=3Dy
+CONFIG_INET_XFRM_MODE_TUNNEL=3Dy
+CONFIG_INET_XFRM_MODE_BEET=3Dy
+CONFIG_INET_DIAG=3Dy
+CONFIG_INET_TCP_DIAG=3Dy
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=3Dy
+CONFIG_DEFAULT_TCP_CONG=3D"cubic"
+# CONFIG_TCP_MD5SIG is not set
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
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
+# CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_STANDALONE=3Dy
+CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
+# CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
+
+#
+# Connector - unified userspace <-> kernelspace linker
+#
+# CONFIG_CONNECTOR is not set
+CONFIG_MTD=3Dy
+# CONFIG_MTD_DEBUG is not set
+CONFIG_MTD_CONCAT=3Dy
+CONFIG_MTD_PARTITIONS=3Dy
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=3Dy
+# CONFIG_MTD_AFS_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=3Dy
+CONFIG_MTD_BLKDEVS=3Dy
+CONFIG_MTD_BLOCK=3Dy
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=3Dy
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=3Dy
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy
+CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
+CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=3Dy
+CONFIG_MTD_CFI_I2=3Dy
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+CONFIG_MTD_CFI_INTELEXT=3Dy
+# CONFIG_MTD_CFI_AMDSTD is not set
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=3Dy
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PHYSMAP is not set
+# CONFIG_MTD_ARM_INTEGRATOR is not set
+CONFIG_MTD_OMAP_NOR=3Dy
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
+# CONFIG_MTD_NAND is not set
+CONFIG_MTD_ONENAND=3Dy
+CONFIG_MTD_ONENAND_VERIFY_WRITE=3Dy
+# CONFIG_MTD_ONENAND_GENERIC is not set
+# CONFIG_MTD_ONENAND_OTP is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+# CONFIG_PNPACPI is not set
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=3Dy
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+CONFIG_BLK_DEV_RAM=3Dy
+CONFIG_BLK_DEV_RAM_COUNT=3D16
+CONFIG_BLK_DEV_RAM_SIZE=3D16384
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=3D1024
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_ATA is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Network device support
+#
+CONFIG_NETDEVICES=3Dy
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_PHYLIB is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=3Dy
+CONFIG_MII=3Dy
+CONFIG_SMC91X=3Dy
+# CONFIG_DM9000 is not set
+CONFIG_NETDEV_1000=3Dy
+CONFIG_NETDEV_10000=3Dy
+
+#
+# Token Ring devices
+#
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+# CONFIG_WAN is not set
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
+CONFIG_INPUT=3Dy
+# CONFIG_INPUT_FF_MEMLESS is not set
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+CONFIG_INPUT_EVDEV=3Dy
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+CONFIG_INPUT_KEYBOARD=3Dy
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
+# CONFIG_KEYBOARD_GPIO is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
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
+CONFIG_VT=3Dy
+CONFIG_VT_CONSOLE=3Dy
+CONFIG_HW_CONSOLE=3Dy
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=3Dy
+CONFIG_SERIAL_8250_CONSOLE=3Dy
+CONFIG_SERIAL_8250_NR_UARTS=3D32
+CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
+CONFIG_SERIAL_8250_EXTENDED=3Dy
+CONFIG_SERIAL_8250_MANY_PORTS=3Dy
+CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
+CONFIG_SERIAL_8250_DETECT_IRQ=3Dy
+CONFIG_SERIAL_8250_RSA=3Dy
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=3Dy
+CONFIG_SERIAL_CORE_CONSOLE=3Dy
+CONFIG_UNIX98_PTYS=3Dy
+# CONFIG_LEGACY_PTYS is not set
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+CONFIG_WATCHDOG=3Dy
+CONFIG_WATCHDOG_NOWAYOUT=3Dy
+
+#
+# Watchdog Device Drivers
+#
+# CONFIG_SOFT_WATCHDOG is not set
+CONFIG_HW_RANDOM=3Dy
+# CONFIG_NVRAM is not set
+# CONFIG_R3964 is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+# CONFIG_I2C is not set
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
+# CONFIG_HWMON is not set
+
+#
+# Misc devices
+#
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
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+CONFIG_DAB=3Dy
+
+#
+# Graphics support
+#
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_FB is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=3Dy
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# HID Devices
+#
+CONFIG_HID=3Dy
+# CONFIG_HID_DEBUG is not set
+
+#
+# USB support
+#
+CONFIG_USB_ARCH_HAS_HCD=3Dy
+CONFIG_USB_ARCH_HAS_OHCI=3Dy
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
+CONFIG_MMC=3Dy
+# CONFIG_MMC_DEBUG is not set
+# CONFIG_MMC_UNSAFE_RESUME is not set
+
+#
+# MMC/SD Card Drivers
+#
+CONFIG_MMC_BLOCK=3Dy
+
+#
+# MMC/SD Host Controller Drivers
+#
+CONFIG_MMC_OMAP=3Dy
+
+#
+# Real Time Clock
+#
+CONFIG_RTC_LIB=3Dy
+# CONFIG_RTC_CLASS is not set
+
+#
+# CBUS support
+#
+# CONFIG_CBUS is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=3Dy
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+CONFIG_EXT3_FS=3Dy
+# CONFIG_EXT3_FS_XATTR is not set
+# CONFIG_EXT4DEV_FS is not set
+CONFIG_JBD=3Dy
+# CONFIG_JBD_DEBUG is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=3Dy
+CONFIG_INOTIFY_USER=3Dy
+CONFIG_QUOTA=3Dy
+# CONFIG_QFMT_V1 is not set
+CONFIG_QFMT_V2=3Dy
+CONFIG_QUOTACTL=3Dy
+CONFIG_DNOTIFY=3Dy
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
+CONFIG_FAT_FS=3Dy
+CONFIG_MSDOS_FS=3Dy
+CONFIG_VFAT_FS=3Dy
+CONFIG_FAT_DEFAULT_CODEPAGE=3D437
+CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=3Dy
+CONFIG_PROC_SYSCTL=3Dy
+CONFIG_SYSFS=3Dy
+CONFIG_TMPFS=3Dy
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=3Dy
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
+CONFIG_JFFS2_FS=3Dy
+CONFIG_JFFS2_FS_DEBUG=3D0
+CONFIG_JFFS2_FS_WRITEBUFFER=3Dy
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+CONFIG_JFFS2_COMPRESSION_OPTIONS=3Dy
+CONFIG_JFFS2_ZLIB=3Dy
+CONFIG_JFFS2_RTIME=3Dy
+# CONFIG_JFFS2_RUBIN is not set
+# CONFIG_JFFS2_CMODE_NONE is not set
+CONFIG_JFFS2_CMODE_PRIORITY=3Dy
+# CONFIG_JFFS2_CMODE_SIZE is not set
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
+CONFIG_NFS_FS=3Dy
+CONFIG_NFS_V3=3Dy
+# CONFIG_NFS_V3_ACL is not set
+CONFIG_NFS_V4=3Dy
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=3Dy
+CONFIG_LOCKD=3Dy
+CONFIG_LOCKD_V4=3Dy
+CONFIG_NFS_COMMON=3Dy
+CONFIG_SUNRPC=3Dy
+CONFIG_SUNRPC_GSS=3Dy
+# CONFIG_SUNRPC_BIND34 is not set
+CONFIG_RPCSEC_GSS_KRB5=3Dy
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
+CONFIG_PARTITION_ADVANCED=3Dy
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+# CONFIG_MAC_PARTITION is not set
+CONFIG_MSDOS_PARTITION=3Dy
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
+# CONFIG_SYSV68_PARTITION is not set
+
+#
+# Native Language Support
+#
+CONFIG_NLS=3Dy
+CONFIG_NLS_DEFAULT=3D"iso8859-1"
+CONFIG_NLS_CODEPAGE_437=3Dy
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
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
+# CONFIG_NLS_ISO8859_1 is not set
+# CONFIG_NLS_ISO8859_2 is not set
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
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
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
+CONFIG_ENABLE_MUST_CHECK=3Dy
+CONFIG_MAGIC_SYSRQ=3Dy
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
+CONFIG_DEBUG_KERNEL=3Dy
+# CONFIG_DEBUG_SHIRQ is not set
+CONFIG_DETECT_SOFTLOCKUP=3Dy
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+CONFIG_DEBUG_MUTEXES=3Dy
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_KOBJECT is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
+CONFIG_FRAME_POINTER=3Dy
+CONFIG_FORCED_INLINING=3Dy
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_DEBUG_USER is not set
+# CONFIG_DEBUG_ERRORS is not set
+CONFIG_DEBUG_LL=3Dy
+# CONFIG_DEBUG_ICEDCC is not set
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
+CONFIG_CRYPTO=3Dy
+CONFIG_CRYPTO_ALGAPI=3Dy
+CONFIG_CRYPTO_BLKCIPHER=3Dy
+CONFIG_CRYPTO_MANAGER=3Dy
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=3Dy
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_WP512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
+CONFIG_CRYPTO_ECB=3Dm
+CONFIG_CRYPTO_CBC=3Dy
+CONFIG_CRYPTO_PCBC=3Dm
+# CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_CRYPTD is not set
+CONFIG_CRYPTO_DES=3Dy
+# CONFIG_CRYPTO_FCRYPT is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Hardware crypto devices
+#
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=3Dy
+CONFIG_CRC_CCITT=3Dy
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
+CONFIG_CRC32=3Dy
+CONFIG_LIBCRC32C=3Dy
+CONFIG_ZLIB_INFLATE=3Dy
+CONFIG_ZLIB_DEFLATE=3Dy
+CONFIG_PLIST=3Dy
+CONFIG_HAS_IOMEM=3Dy
+CONFIG_HAS_IOPORT=3Dy
+CONFIG_HAS_DMA=3Dy
