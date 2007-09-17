From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [PATCH 06/14] ARM: OMAP: Update
	arch/arm/configs/omap_generic_1710_defconfig
Date: Mon, 17 Sep 2007 16:23:13 -0400
Message-ID: <1190060603440-git-send-email-felipe.lima@indt.org.br>
References: <11900606011267-git-send-email-felipe.lima@indt.org.br>
	<11900606021256-git-send-email-felipe.lima@indt.org.br>
	<1190060602235-git-send-email-felipe.lima@indt.org.br>
	<1190060602157-git-send-email-felipe.lima@indt.org.br>
	<1190060603498-git-send-email-felipe.lima@indt.org.br>
	<11900606031155-git-send-email-felipe.lima@indt.org.br>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11900606031155-git-send-email-felipe.lima@indt.org.br>
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

Update omap_generic_1710_defconfig

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---
 arch/arm/configs/omap_generic_1710_defconfig | 1107 ++++++++++++++++----------
 1 files changed, 687 insertions(+), 420 deletions(-)

diff --git a/arch/arm/configs/omap_generic_1710_defconfig b/arch/arm/configs/omap_generic_1710_defconfig
index 579cff1..3c76efb 100644
--- a/arch/arm/configs/omap_generic_1710_defconfig
+++ b/arch/arm/configs/omap_generic_1710_defconfig
@@ -1,205 +1,307 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.9-rc3-omap1
-# Mon Oct  4 10:14:57 2004
+# Linux kernel version: 2.6.23-rc6-omap1
+# Mon Sep 17 15:41:38 2007
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
-CONFIG_GENERIC_IOMAP=y
+# CONFIG_ARCH_HAS_ILOG2_U32 is not set
+# CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
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
-
-#
-# General setup
-#
+CONFIG_INIT_ENV_ARG_LIMIT=32
 CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
-# CONFIG_BSD_PROCESS_ACCT is not set
-CONFIG_SYSCTL=y
+CONFIG_BSD_PROCESS_ACCT=y
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_USER_NS is not set
 # CONFIG_AUDIT is not set
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_HOTPLUG=y
 # CONFIG_IKCONFIG is not set
-# CONFIG_EMBEDDED is not set
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_SYSFS_DEPRECATED=y
+# CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
+CONFIG_EMBEDDED=y
+CONFIG_UID16=y
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
-# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_KALLSYMS_EXTRA_PASS=y
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
+CONFIG_RT_MUTEXES=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_KMOD=y
+CONFIG_BLOCK=y
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
+
+#
+# IO Schedulers
+#
 CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
-CONFIG_CC_OPTIMIZE_FOR_SIZE=y
-CONFIG_SHMEM=y
-# CONFIG_TINY_SHMEM is not set
-
-#
-# Loadable module support
-#
-# CONFIG_MODULES is not set
+CONFIG_DEFAULT_AS=y
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="anticipatory"
 
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
-# CONFIG_ARCH_VERSATILE_PB is not set
-# CONFIG_ARCH_IMX is not set
 
 #
 # TI OMAP Implementations
 #
+CONFIG_ARCH_OMAP_OTG=y
+# CONFIG_ARCH_OMAP1 is not set
+CONFIG_ARCH_OMAP2=y
+# CONFIG_ARCH_OMAP3 is not set
+
+#
+# OMAP Feature Selections
+#
+CONFIG_OMAP_DEBUG_DEVICES=y
+# CONFIG_OMAP_RESET_CLOCKS is not set
+CONFIG_OMAP_BOOT_TAG=y
+# CONFIG_OMAP_BOOT_REASON is not set
+# CONFIG_OMAP_COMPONENT_VERSION is not set
+# CONFIG_OMAP_GPIO_SWITCH is not set
+CONFIG_OMAP_MUX=y
+CONFIG_OMAP_MUX_DEBUG=y
+CONFIG_OMAP_MUX_WARNINGS=y
+# CONFIG_OMAP_STI is not set
+CONFIG_OMAP_MCBSP=y
+# CONFIG_OMAP_MMU_FWK is not set
+# CONFIG_OMAP_MBOX_FWK is not set
+CONFIG_OMAP_MPU_TIMER=y
+# CONFIG_OMAP_32K_TIMER is not set
+CONFIG_OMAP_DM_TIMER=y
+CONFIG_OMAP_LL_DEBUG_UART1=y
+# CONFIG_OMAP_LL_DEBUG_UART2 is not set
+# CONFIG_OMAP_LL_DEBUG_UART3 is not set
+CONFIG_OMAP_SERIAL_WAKE=y
+# CONFIG_OMAP_DSP is not set
+# CONFIG_MACH_OMAP_GENERIC is not set
 
 #
 # OMAP Core Type
 #
-# CONFIG_ARCH_OMAP730 is not set
-# CONFIG_ARCH_OMAP15XX is not set
-CONFIG_ARCH_OMAP16XX=y
-CONFIG_ARCH_OMAP_OTG=y
+CONFIG_ARCH_OMAP24XX=y
+CONFIG_ARCH_OMAP2420=y
+# CONFIG_ARCH_OMAP2430 is not set
 
 #
 # OMAP Board Type
 #
-# CONFIG_MACH_OMAP_INNOVATOR is not set
-# CONFIG_MACH_OMAP_H2 is not set
-# CONFIG_MACH_OMAP_H3 is not set
-# CONFIG_MACH_OMAP_H4 is not set
-# CONFIG_MACH_OMAP_OSK is not set
-CONFIG_MACH_OMAP_GENERIC=y
+# CONFIG_MACH_NOKIA_N800 is not set
+CONFIG_MACH_OMAP_H4=y
+# CONFIG_MACH_OMAP_H4_TUSB is not set
+# CONFIG_MACH_OMAP_H4_OTG is not set
+# CONFIG_MACH_OMAP2_H4_USB1 is not set
+# CONFIG_MACH_OMAP_APOLLON is not set
+# CONFIG_MACH_OMAP_APOLLON_PLUS is not set
+# CONFIG_MACH_OMAP_2430SDP is not set
 
 #
-# OMAP Feature Selections
+# Boot options
+#
+
+#
+# Power management
 #
-CONFIG_OMAP_BOOT_TAG=y
-# CONFIG_OMAP_BOOT_REASON is not set
-# CONFIG_OMAP_MUX is not set
-# CONFIG_OMAP_LL_DEBUG_UART1 is not set
-# CONFIG_OMAP_LL_DEBUG_UART2 is not set
-CONFIG_OMAP_LL_DEBUG_UART3=y
-CONFIG_OMAP_ARM_192MHZ=y
-# CONFIG_OMAP_ARM_168MHZ is not set
-# CONFIG_OMAP_ARM_120MHZ is not set
-# CONFIG_OMAP_ARM_60MHZ is not set
-# CONFIG_OMAP_ARM_30MHZ is not set
-# CONFIG_OMAP_DSP is not set
 
 #
 # Processor Type
 #
 CONFIG_CPU_32=y
-CONFIG_CPU_ARM926T=y
-CONFIG_CPU_32v5=y
-CONFIG_CPU_ABRT_EV5TJ=y
-CONFIG_CPU_COPY_V4WB=y
-CONFIG_CPU_TLB_V4WBI=y
+CONFIG_CPU_V6=y
+# CONFIG_CPU_32v6K is not set
+CONFIG_CPU_32v6=y
+CONFIG_CPU_ABRT_EV6=y
+CONFIG_CPU_PABRT_NOIFAR=y
+CONFIG_CPU_CACHE_V6=y
+CONFIG_CPU_CACHE_VIPT=y
+CONFIG_CPU_COPY_V6=y
+CONFIG_CPU_TLB_V6=y
+CONFIG_CPU_HAS_ASID=y
+CONFIG_CPU_CP15=y
+CONFIG_CPU_CP15_MMU=y
 
 #
 # Processor Features
 #
-# CONFIG_ARM_THUMB is not set
+CONFIG_ARM_THUMB=y
 # CONFIG_CPU_ICACHE_DISABLE is not set
 # CONFIG_CPU_DCACHE_DISABLE is not set
-# CONFIG_CPU_DCACHE_WRITETHROUGH is not set
-# CONFIG_CPU_CACHE_ROUND_ROBIN is not set
+# CONFIG_CPU_BPREDICT_DISABLE is not set
+# CONFIG_OUTER_CACHE is not set
 
 #
-# General setup
+# Bus support
 #
-# CONFIG_ZBOOT_ROM is not set
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
+# CONFIG_PCI_SYSCALL is not set
+# CONFIG_ARCH_SUPPORTS_MSI is not set
 
 #
-# PCMCIA/CardBus support
+# PCCARD (PCMCIA/CardBus) support
 #
-# CONFIG_PCMCIA is not set
+# CONFIG_PCCARD is not set
 
 #
-# At least one math emulation must be selected
+# Kernel Features
 #
-CONFIG_FPE_NWFPE=y
-# CONFIG_FPE_NWFPE_XP is not set
-# CONFIG_FPE_FASTFPE is not set
-# CONFIG_VFP is not set
-CONFIG_BINFMT_ELF=y
-# CONFIG_BINFMT_AOUT is not set
-# CONFIG_BINFMT_MISC is not set
-
-#
-# Generic Driver Options
-#
-CONFIG_STANDALONE=y
-CONFIG_PREVENT_FIRMWARE_BUILD=y
-# CONFIG_FW_LOADER is not set
-# CONFIG_DEBUG_DRIVER is not set
-CONFIG_PM=y
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
 # CONFIG_PREEMPT is not set
-# CONFIG_APM is not set
-CONFIG_ARTHUR=y
-CONFIG_CMDLINE="mem=64M console=tty0 console=ttyS2,115200 root=0801"
+CONFIG_HZ=100
+CONFIG_AEABI=y
+CONFIG_OABI_COMPAT=y
+# CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
 # CONFIG_LEDS is not set
 CONFIG_ALIGNMENT_TRAP=y
 
 #
-# Parallel port support
+# Boot options
 #
-# CONFIG_PARPORT is not set
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_CMDLINE="root=/dev/ram0 rw console=ttyS0,115200n8 initrd=0x80600000,8M ramdisk_size=8192"
+# CONFIG_XIP_KERNEL is not set
+# CONFIG_KEXEC is not set
 
 #
-# Memory Technology Devices (MTD)
+# CPU Frequency scaling
 #
-# CONFIG_MTD is not set
+# CONFIG_CPU_FREQ is not set
 
 #
-# Plug and Play support
+# Floating point emulation
 #
 
 #
-# Block devices
+# At least one emulation must be selected
 #
-# CONFIG_BLK_DEV_FD is not set
-CONFIG_BLK_DEV_LOOP=y
-# CONFIG_BLK_DEV_CRYPTOLOOP is not set
-# CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_UB is not set
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=8192
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_FPE_NWFPE=y
+# CONFIG_FPE_NWFPE_XP is not set
+# CONFIG_FPE_FASTFPE is not set
+# CONFIG_VFP is not set
 
 #
-# Multi-device support (RAID and LVM)
+# Userspace binary formats
 #
-# CONFIG_MD is not set
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_AOUT is not set
+CONFIG_BINFMT_MISC=y
 
 #
-# Networking support
+# Power management options
+#
+# CONFIG_PM is not set
+CONFIG_SUSPEND_UP_POSSIBLE=y
+
+#
+# Networking
 #
 CONFIG_NET=y
 
@@ -208,32 +310,47 @@ CONFIG_NET=y
 #
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
-# CONFIG_NETLINK_DEV is not set
 CONFIG_UNIX=y
-# CONFIG_NET_KEY is not set
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
+CONFIG_NET_KEY=y
+# CONFIG_NET_KEY_MIGRATE is not set
 CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
+# CONFIG_IP_MULTICAST is not set
 # CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_BOOTP is not set
 # CONFIG_IP_PNP_RARP is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
-# CONFIG_IP_MROUTE is not set
 # CONFIG_ARPD is not set
 # CONFIG_SYN_COOKIES is not set
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
+# CONFIG_IP_DCCP is not set
 # CONFIG_IP_SCTP is not set
+# CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_VLAN_8021Q is not set
@@ -243,179 +360,262 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
 #
 # CONFIG_NET_SCHED is not set
-# CONFIG_NET_CLS_ROUTE is not set
 
 #
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
-# CONFIG_NETPOLL is not set
-# CONFIG_NET_POLL_CONTROLLER is not set
 # CONFIG_HAMRADIO is not set
-# CONFIG_IRDA is not set
-# CONFIG_BT is not set
-CONFIG_NETDEVICES=y
-# CONFIG_DUMMY is not set
-# CONFIG_BONDING is not set
-# CONFIG_EQUALIZER is not set
-# CONFIG_TUN is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=y
-CONFIG_NET_VENDOR_SMC=y
-# CONFIG_SMC91X is not set
-# CONFIG_SMC9194 is not set
-
-#
-# Ethernet (1000 Mbit)
-#
+CONFIG_IRDA=y
 
 #
-# Ethernet (10000 Mbit)
+# IrDA protocols
 #
+CONFIG_IRLAN=y
+CONFIG_IRCOMM=y
+# CONFIG_IRDA_ULTRA is not set
 
 #
-# Token Ring devices
+# IrDA options
 #
+# CONFIG_IRDA_CACHE_LAST_LSAP is not set
+# CONFIG_IRDA_FAST_RR is not set
+# CONFIG_IRDA_DEBUG is not set
 
 #
-# Wireless LAN (non-hamradio)
+# Infrared-port device drivers
 #
-CONFIG_NET_RADIO=y
 
 #
-# Obsolete Wireless cards support (pre-802.11)
+# SIR device drivers
 #
-# CONFIG_STRIP is not set
-# CONFIG_ATMEL is not set
+# CONFIG_IRTTY_SIR is not set
 
 #
-# Wan interfaces
+# Dongle support
 #
-# CONFIG_WAN is not set
-CONFIG_PPP=y
-# CONFIG_PPP_MULTILINK is not set
-# CONFIG_PPP_FILTER is not set
-# CONFIG_PPP_ASYNC is not set
-# CONFIG_PPP_SYNC_TTY is not set
-# CONFIG_PPP_DEFLATE is not set
-# CONFIG_PPP_BSDCOMP is not set
-# CONFIG_PPPOE is not set
-# CONFIG_SLIP is not set
-# CONFIG_SHAPER is not set
-# CONFIG_NETCONSOLE is not set
 
 #
-# SCSI device support
+# Old SIR device drivers
 #
-CONFIG_SCSI=y
-CONFIG_SCSI_PROC_FS=y
+# CONFIG_IRPORT_SIR is not set
 
 #
-# SCSI support type (disk, tape, CD-ROM)
+# Old Serial dongle support
 #
-CONFIG_BLK_DEV_SD=y
-# CONFIG_CHR_DEV_ST is not set
-# CONFIG_CHR_DEV_OSST is not set
-# CONFIG_BLK_DEV_SR is not set
-# CONFIG_CHR_DEV_SG is not set
 
 #
-# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+# FIR device drivers
 #
-# CONFIG_SCSI_MULTI_LUN is not set
-# CONFIG_SCSI_CONSTANTS is not set
-# CONFIG_SCSI_LOGGING is not set
-
-#
-# SCSI Transport Attributes
-#
-# CONFIG_SCSI_SPI_ATTRS is not set
-# CONFIG_SCSI_FC_ATTRS is not set
+CONFIG_OMAP_IR=y
+# CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
 
 #
-# SCSI low-level drivers
+# Wireless
 #
-# CONFIG_SCSI_SATA is not set
-# CONFIG_SCSI_DEBUG is not set
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
+# CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
-# Fusion MPT device support
+# Device Drivers
 #
 
 #
-# IEEE 1394 (FireWire) support
+# Generic Driver Options
 #
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+CONFIG_MTD_CONCAT=y
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+# CONFIG_MTD_AFS_PARTS is not set
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
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
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
+CONFIG_MTD_CFI_INTELEXT=y
+# CONFIG_MTD_CFI_AMDSTD is not set
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
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
+CONFIG_MTD_OMAP_NOR=y
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
+# CONFIG_MTD_ONENAND is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=16384
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
 
 #
-# I2O device support
+# SCSI device support
 #
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_ATA is not set
+# CONFIG_MD is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_PHYLIB is not set
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_AX88796 is not set
+CONFIG_SMC91X=y
+# CONFIG_DM9000 is not set
+CONFIG_NETDEV_1000=y
+CONFIG_NETDEV_10000=y
 
 #
-# ISDN subsystem
+# Wireless LAN
 #
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+# CONFIG_WAN is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
 # CONFIG_ISDN is not set
 
 #
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
 
 #
 # Userland interfaces
 #
-CONFIG_INPUT_MOUSEDEV=y
-CONFIG_INPUT_MOUSEDEV_PSAUX=y
-CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
-CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_JOYDEV is not set
 # CONFIG_INPUT_TSDEV is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_EVBUG is not set
 
 #
-# Input I/O drivers
-#
-# CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
-CONFIG_SERIO=y
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_CT82C710 is not set
-# CONFIG_SERIO_RAW is not set
-
-#
 # Input Device Drivers
 #
 CONFIG_INPUT_KEYBOARD=y
-CONFIG_KEYBOARD_ATKBD=y
+# CONFIG_KEYBOARD_ATKBD is not set
 # CONFIG_KEYBOARD_SUNKBD is not set
 # CONFIG_KEYBOARD_LKKBD is not set
 # CONFIG_KEYBOARD_XTKBD is not set
 # CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
 CONFIG_KEYBOARD_OMAP=y
+# CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
 # CONFIG_INPUT_MISC is not set
 
 #
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
 # Character devices
 #
 CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
 
 #
@@ -423,75 +623,247 @@ CONFIG_HW_CONSOLE=y
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=4
-# CONFIG_SERIAL_8250_EXTENDED is not set
+CONFIG_SERIAL_8250_NR_UARTS=32
+CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_MANY_PORTS=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_8250_DETECT_IRQ=y
+CONFIG_SERIAL_8250_RSA=y
 
 #
 # Non-8250 serial port support
 #
-CONFIG_SERIAL_8250_OMAP=y
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
-CONFIG_LEGACY_PTYS=y
-CONFIG_LEGACY_PTY_COUNT=256
-
-#
-# IPMI
-#
+# CONFIG_LEGACY_PTYS is not set
 # CONFIG_IPMI_HANDLER is not set
+CONFIG_WATCHDOG=y
+CONFIG_WATCHDOG_NOWAYOUT=y
 
 #
-# Watchdog Cards
+# Watchdog Device Drivers
 #
-# CONFIG_WATCHDOG is not set
+# CONFIG_SOFT_WATCHDOG is not set
+CONFIG_OMAP_WATCHDOG=y
+CONFIG_HW_RANDOM=m
+CONFIG_HW_RANDOM_OMAP=m
 # CONFIG_NVRAM is not set
-# CONFIG_RTC is not set
-# CONFIG_OMAP_RTC is not set
-# CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+# CONFIG_I2C_CHARDEV is not set
 
 #
-# Ftape, the floppy tape device driver
+# I2C Algorithms
 #
-# CONFIG_DRM is not set
-# CONFIG_RAW_DRIVER is not set
+# CONFIG_I2C_ALGOBIT is not set
+# CONFIG_I2C_ALGOPCF is not set
+# CONFIG_I2C_ALGOPCA is not set
+
+#
+# I2C Hardware Bus support
+#
+# CONFIG_I2C_GPIO is not set
+# CONFIG_I2C_OCORES is not set
+CONFIG_I2C_OMAP=y
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_TAOS_EVM is not set
+# CONFIG_I2C_STUB is not set
 
 #
-# I2C support
+# Miscellaneous I2C Chip support
 #
-# CONFIG_I2C is not set
+# CONFIG_SENSORS_DS1337 is not set
+# CONFIG_SENSORS_DS1374 is not set
+# CONFIG_DS1682 is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_ISP1301_OMAP is not set
+# CONFIG_TPS65010 is not set
+# CONFIG_SENSORS_TLV320AIC23 is not set
+CONFIG_GPIOEXPANDER_OMAP=y
+# CONFIG_TWL4030_CORE is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+CONFIG_MENELAUS=y
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
+# CONFIG_W1 is not set
+# CONFIG_HWMON is not set
+CONFIG_MISC_DEVICES=y
+# CONFIG_EEPROM_93CX6 is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+# CONFIG_NEW_LEDS is not set
 
 #
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+CONFIG_DAB=y
+
+#
+# Graphics support
+#
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
-# Digital Video Broadcasting Devices
+# Display device support
 #
-# CONFIG_DVB is not set
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_VGASTATE is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=m
+CONFIG_FB=y
+CONFIG_FIRMWARE_EDID=y
+# CONFIG_FB_DDC is not set
+# CONFIG_FB_CFB_FILLRECT is not set
+# CONFIG_FB_CFB_COPYAREA is not set
+# CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_SYS_FOPS is not set
+CONFIG_FB_DEFERRED_IO=y
+# CONFIG_FB_SVGALIB is not set
+# CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
+# CONFIG_FB_S1D13XXX is not set
+CONFIG_FB_OMAP=y
+# CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
+# CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
+CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
+# CONFIG_FB_VIRTUAL is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+# CONFIG_FONTS is not set
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+CONFIG_LOGO=y
+# CONFIG_LOGO_LINUX_MONO is not set
+# CONFIG_LOGO_LINUX_VGA16 is not set
+CONFIG_LOGO_LINUX_CLUT224=y
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
+CONFIG_USB_SUPPORT=y
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
+CONFIG_MMC=y
+# CONFIG_MMC_DEBUG is not set
+# CONFIG_MMC_UNSAFE_RESUME is not set
+
+#
+# MMC/SD Card Drivers
+#
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_BLOCK_BOUNCE=y
+
+#
+# MMC/SD Host Controller Drivers
+#
+CONFIG_MMC_OMAP=y
+CONFIG_RTC_LIB=y
+# CONFIG_RTC_CLASS is not set
+
+#
+# DMA Engine support
+#
+# CONFIG_DMA_ENGINE is not set
+
+#
+# DMA Clients
+#
+
+#
+# DMA Devices
+#
+
+#
+# CBUS support
+#
+# CONFIG_CBUS is not set
 
 #
 # File systems
 #
 CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
 CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_XATTR=y
-# CONFIG_EXT3_FS_POSIX_ACL is not set
-# CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT3_FS_XATTR is not set
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
-CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
-# CONFIG_QUOTA is not set
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
+CONFIG_QUOTA=y
+# CONFIG_QFMT_V1 is not set
+CONFIG_QFMT_V2=y
+CONFIG_QUOTACTL=y
+CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
 
 #
 # CD-ROM/DVD Filesystems
@@ -502,20 +874,24 @@ CONFIG_FS_MBCACHE=y
 #
 # DOS/FAT/NT Filesystems
 #
-# CONFIG_MSDOS_FS is not set
-# CONFIG_VFAT_FS is not set
+CONFIG_FAT_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
 
 #
 # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
-# CONFIG_DEVFS_FS is not set
-# CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
+# CONFIG_CONFIGFS_FS is not set
 
 #
 # Miscellaneous filesystems
@@ -527,6 +903,15 @@ CONFIG_RAMFS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
@@ -539,15 +924,17 @@ CONFIG_RAMFS=y
 #
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
 CONFIG_NFS_V4=y
 # CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
-# CONFIG_ROOT_NFS is not set
+CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
-# CONFIG_EXPORTFS is not set
+CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 CONFIG_SUNRPC_GSS=y
+# CONFIG_SUNRPC_BIND34 is not set
 CONFIG_RPCSEC_GSS_KRB5=y
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -574,7 +961,9 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_SGI_PARTITION is not set
 # CONFIG_ULTRIX_PARTITION is not set
 # CONFIG_SUN_PARTITION is not set
+# CONFIG_KARMA_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
+# CONFIG_SYSV68_PARTITION is not set
 
 #
 # Native Language Support
@@ -585,7 +974,7 @@ CONFIG_NLS_CODEPAGE_437=y
 # CONFIG_NLS_CODEPAGE_737 is not set
 # CONFIG_NLS_CODEPAGE_775 is not set
 # CONFIG_NLS_CODEPAGE_850 is not set
-CONFIG_NLS_CODEPAGE_852=y
+# CONFIG_NLS_CODEPAGE_852 is not set
 # CONFIG_NLS_CODEPAGE_855 is not set
 # CONFIG_NLS_CODEPAGE_857 is not set
 # CONFIG_NLS_CODEPAGE_860 is not set
@@ -605,7 +994,7 @@ CONFIG_NLS_CODEPAGE_852=y
 # CONFIG_NLS_CODEPAGE_1250 is not set
 # CONFIG_NLS_CODEPAGE_1251 is not set
 # CONFIG_NLS_ASCII is not set
-CONFIG_NLS_ISO8859_1=y
+# CONFIG_NLS_ISO8859_1 is not set
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
 # CONFIG_NLS_ISO8859_4 is not set
@@ -615,214 +1004,71 @@ CONFIG_NLS_ISO8859_1=y
 # CONFIG_NLS_ISO8859_9 is not set
 # CONFIG_NLS_ISO8859_13 is not set
 # CONFIG_NLS_ISO8859_14 is not set
-CONFIG_NLS_ISO8859_15=y
+# CONFIG_NLS_ISO8859_15 is not set
 # CONFIG_NLS_KOI8_R is not set
 # CONFIG_NLS_KOI8_U is not set
 # CONFIG_NLS_UTF8 is not set
 
 #
-# Profiling support
-#
-# CONFIG_PROFILING is not set
-
-#
-# Graphics support
-#
-# CONFIG_FB is not set
-
-#
-# Console display driver support
-#
-# CONFIG_VGA_CONSOLE is not set
-CONFIG_DUMMY_CONSOLE=y
-
-#
-# Sound
-#
-# CONFIG_SOUND is not set
-
-#
-# Misc devices
+# Distributed Lock Manager
 #
+# CONFIG_DLM is not set
 
 #
-# USB support
-#
-CONFIG_USB=y
-CONFIG_USB_DEBUG=y
-
-#
-# Miscellaneous USB options
-#
-CONFIG_USB_DEVICEFS=y
-CONFIG_USB_BANDWIDTH=y
-# CONFIG_USB_DYNAMIC_MINORS is not set
-# CONFIG_USB_SUSPEND is not set
-# CONFIG_USB_OTG is not set
-
-#
-# USB Host Controller Drivers
-#
-# CONFIG_USB_EHCI_HCD is not set
-CONFIG_USB_OHCI_HCD=y
-# CONFIG_USB_UHCI_HCD is not set
-# CONFIG_USB_SL811HS is not set
-
-#
-# USB Device Class drivers
-#
-# CONFIG_USB_BLUETOOTH_TTY is not set
-# CONFIG_USB_ACM is not set
-# CONFIG_USB_PRINTER is not set
-CONFIG_USB_STORAGE=y
-# CONFIG_USB_STORAGE_DEBUG is not set
-# CONFIG_USB_STORAGE_RW_DETECT is not set
-# CONFIG_USB_STORAGE_DATAFAB is not set
-# CONFIG_USB_STORAGE_FREECOM is not set
-# CONFIG_USB_STORAGE_DPCM is not set
-# CONFIG_USB_STORAGE_HP8200e is not set
-# CONFIG_USB_STORAGE_SDDR09 is not set
-# CONFIG_USB_STORAGE_SDDR55 is not set
-# CONFIG_USB_STORAGE_JUMPSHOT is not set
-
-#
-# USB Human Interface Devices (HID)
-#
-CONFIG_USB_HID=y
-CONFIG_USB_HIDINPUT=y
-# CONFIG_HID_FF is not set
-# CONFIG_USB_HIDDEV is not set
-# CONFIG_USB_AIPTEK is not set
-# CONFIG_USB_WACOM is not set
-# CONFIG_USB_KBTAB is not set
-# CONFIG_USB_POWERMATE is not set
-# CONFIG_USB_MTOUCH is not set
-# CONFIG_USB_EGALAX is not set
-# CONFIG_USB_XPAD is not set
-# CONFIG_USB_ATI_REMOTE is not set
-
-#
-# USB Imaging devices
-#
-# CONFIG_USB_MDC800 is not set
-# CONFIG_USB_MICROTEK is not set
-# CONFIG_USB_HPUSBSCSI is not set
-
-#
-# USB Multimedia devices
-#
-# CONFIG_USB_DABUSB is not set
-
-#
-# Video4Linux support is needed for USB Multimedia device support
-#
-
-#
-# USB Network adaptors
-#
-# CONFIG_USB_CATC is not set
-# CONFIG_USB_KAWETH is not set
-# CONFIG_USB_PEGASUS is not set
-# CONFIG_USB_RTL8150 is not set
-CONFIG_USB_USBNET=y
-
-#
-# USB Host-to-Host Cables
-#
-CONFIG_USB_ALI_M5632=y
-# CONFIG_USB_AN2720 is not set
-# CONFIG_USB_BELKIN is not set
-# CONFIG_USB_GENESYS is not set
-# CONFIG_USB_NET1080 is not set
-# CONFIG_USB_PL2301 is not set
-
-#
-# Intelligent USB Devices/Gadgets
-#
-# CONFIG_USB_ARMLINUX is not set
-# CONFIG_USB_EPSON2888 is not set
-# CONFIG_USB_ZAURUS is not set
-# CONFIG_USB_CDCETHER is not set
-
-#
-# USB Network Adapters
-#
-CONFIG_USB_AX8817X=y
-
-#
-# USB port drivers
-#
-
-#
-# USB Serial Converter support
-#
-# CONFIG_USB_SERIAL is not set
-
-#
-# USB Miscellaneous drivers
-#
-# CONFIG_USB_EMI62 is not set
-# CONFIG_USB_EMI26 is not set
-# CONFIG_USB_TIGL is not set
-# CONFIG_USB_AUERSWALD is not set
-# CONFIG_USB_RIO500 is not set
-# CONFIG_USB_LEGOTOWER is not set
-# CONFIG_USB_LCD is not set
-# CONFIG_USB_LED is not set
-# CONFIG_USB_CYTHERM is not set
-# CONFIG_USB_PHIDGETSERVO is not set
-# CONFIG_USB_TEST is not set
-
-#
-# USB Gadget Support
-#
-# CONFIG_USB_GADGET is not set
-
-#
-# Synchronous Serial Interfaces (SSI)
-#
-# CONFIG_OMAP_UWIRE is not set
-
-#
-# MMC/SD Card support
+# Profiling support
 #
-CONFIG_MMC=y
-# CONFIG_MMC_DEBUG is not set
-CONFIG_MMC_BLOCK=y
-# CONFIG_MMC_BLOCK_BROKEN_RFD is not set
-CONFIG_MMC_OMAP=y
-# CONFIG_MMC_OMAP16XX_BLOCK1 is not set
-CONFIG_MMC_OMAP16XX_BLOCK2=y
+# CONFIG_PROFILING is not set
 
 #
 # Kernel hacking
 #
-CONFIG_DEBUG_KERNEL=y
+# CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_SLAB=y
-CONFIG_DEBUG_SPINLOCK=y
-CONFIG_DEBUG_BUGVERBOSE=y
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+CONFIG_DETECT_SOFTLOCKUP=y
+CONFIG_SCHED_DEBUG=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+CONFIG_DEBUG_MUTEXES=y
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_KOBJECT is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
 CONFIG_FRAME_POINTER=y
+CONFIG_FORCED_INLINING=y
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
 # CONFIG_DEBUG_USER is not set
-CONFIG_DEBUG_WAITQ=y
-CONFIG_DEBUG_ERRORS=y
-# CONFIG_DEBUG_LL is not set
+# CONFIG_DEBUG_ERRORS is not set
+CONFIG_DEBUG_LL=y
+# CONFIG_DEBUG_ICEDCC is not set
 
 #
 # Security options
 #
-CONFIG_SECURITY=y
-# CONFIG_SECURITY_NETWORK is not set
-CONFIG_SECURITY_CAPABILITIES=y
-# CONFIG_SECURITY_ROOTPLUG is not set
-# CONFIG_SECURITY_SELINUX is not set
-
-#
-# Cryptographic options
-#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
 CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_MANAGER=y
 # CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
 # CONFIG_CRYPTO_NULL is not set
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=y
@@ -830,7 +1076,15 @@ CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_WP512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
+CONFIG_CRYPTO_ECB=m
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_PCBC=m
+# CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_CRYPTD is not set
 CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_FCRYPT is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set
 # CONFIG_CRYPTO_SERPENT is not set
@@ -840,14 +1094,27 @@ CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_TEA is not set
 # CONFIG_CRYPTO_ARC4 is not set
 # CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_ANUBIS is not set
 # CONFIG_CRYPTO_DEFLATE is not set
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_TEST is not set
+CONFIG_CRYPTO_HW=y
 
 #
 # Library routines
 #
-# CONFIG_CRC_CCITT is not set
+CONFIG_BITREVERSE=y
+CONFIG_CRC_CCITT=y
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
-# CONFIG_LIBCRC32C is not set
+# CONFIG_CRC7 is not set
+CONFIG_LIBCRC32C=y
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_PLIST=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
-- 
1.5.3.1.91.gd3392
