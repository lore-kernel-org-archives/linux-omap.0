From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] [OMAP1] htcherald: Add board support and LCD config for
	HTC Herald
Date: Sat, 3 Oct 2009 14:18:35 -0700
Message-ID: <6cb013310910031418g3d6bc25fj8f785dcf93da1a91@mail.gmail.com>
References: <6cb013310910031320n45a78725qa0e0970499647ead@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f199.google.com ([209.85.210.199]:61496 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755501AbZJCVTc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Oct 2009 17:19:32 -0400
Received: by yxe37 with SMTP id 37so2069960yxe.33
        for <linux-omap@vger.kernel.org>; Sat, 03 Oct 2009 14:18:55 -0700 (PDT)
In-Reply-To: <6cb013310910031320n45a78725qa0e0970499647ead@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I just became aware that I was missing some key header information, so
I have a revised patch with the proper information (patch to follow
next).

- Cory

On Sat, Oct 3, 2009 at 1:20 PM, Cory Maccarrone <darkstar6262@gmail.com=
> wrote:
> I have added a board support file, along with corresponding LCD confi=
guration
> for the HTC Herald series of OMAP850-based smartphones (T-Mobile Wing=
, etc).
>
> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
> ---
> =A0arch/arm/configs/htcherald_defconfig =A0| 1146 +++++++++++++++++++=
++++++++++++++
> =A0arch/arm/mach-omap1/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 =A06 +
> =A0arch/arm/mach-omap1/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0arch/arm/mach-omap1/board-htcherald.c | =A0233 +++++++
> =A0drivers/video/omap/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/video/omap/lcd_htcherald.c =A0 =A0| =A0124 ++++
> =A06 files changed, 1511 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/arm/configs/htcherald_defconfig
> =A0create mode 100644 arch/arm/mach-omap1/board-htcherald.c
> =A0create mode 100644 drivers/video/omap/lcd_htcherald.c
>
> diff --git a/arch/arm/configs/htcherald_defconfig
> b/arch/arm/configs/htcherald_defconfig
> new file mode 100644
> index 0000000..9ec9c26
> --- /dev/null
> +++ b/arch/arm/configs/htcherald_defconfig
> @@ -0,0 +1,1146 @@
> +#
> +# Automatically generated make config: don't edit
> +# Linux kernel version: 2.6.32-rc2
> +# Sat Oct =A03 12:16:22 2009
> +#
> +CONFIG_ARM=3Dy
> +CONFIG_SYS_SUPPORTS_APM_EMULATION=3Dy
> +CONFIG_GENERIC_GPIO=3Dy
> +CONFIG_GENERIC_TIME=3Dy
> +CONFIG_GENERIC_CLOCKEVENTS=3Dy
> +CONFIG_GENERIC_HARDIRQS=3Dy
> +CONFIG_STACKTRACE_SUPPORT=3Dy
> +CONFIG_HAVE_LATENCYTOP_SUPPORT=3Dy
> +CONFIG_LOCKDEP_SUPPORT=3Dy
> +CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
> +CONFIG_HARDIRQS_SW_RESEND=3Dy
> +CONFIG_GENERIC_IRQ_PROBE=3Dy
> +CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy
> +CONFIG_ARCH_HAS_CPUFREQ=3Dy
> +CONFIG_GENERIC_HWEIGHT=3Dy
> +CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
> +CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=3Dy
> +CONFIG_VECTORS_BASE=3D0xffff0000
> +CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
> +CONFIG_CONSTRUCTORS=3Dy
> +
> +#
> +# General setup
> +#
> +CONFIG_EXPERIMENTAL=3Dy
> +CONFIG_BROKEN_ON_SMP=3Dy
> +CONFIG_LOCK_KERNEL=3Dy
> +CONFIG_INIT_ENV_ARG_LIMIT=3D32
> +CONFIG_LOCALVERSION=3D""
> +CONFIG_LOCALVERSION_AUTO=3Dy
> +CONFIG_SWAP=3Dy
> +CONFIG_SYSVIPC=3Dy
> +CONFIG_SYSVIPC_SYSCTL=3Dy
> +# CONFIG_POSIX_MQUEUE is not set
> +# CONFIG_BSD_PROCESS_ACCT is not set
> +# CONFIG_TASKSTATS is not set
> +# CONFIG_AUDIT is not set
> +
> +#
> +# RCU Subsystem
> +#
> +CONFIG_TREE_RCU=3Dy
> +# CONFIG_TREE_PREEMPT_RCU is not set
> +# CONFIG_RCU_TRACE is not set
> +CONFIG_RCU_FANOUT=3D32
> +# CONFIG_RCU_FANOUT_EXACT is not set
> +# CONFIG_TREE_RCU_TRACE is not set
> +# CONFIG_IKCONFIG is not set
> +CONFIG_LOG_BUF_SHIFT=3D14
> +# CONFIG_GROUP_SCHED is not set
> +# CONFIG_CGROUPS is not set
> +# CONFIG_SYSFS_DEPRECATED_V2 is not set
> +# CONFIG_RELAY is not set
> +CONFIG_NAMESPACES=3Dy
> +# CONFIG_UTS_NS is not set
> +# CONFIG_IPC_NS is not set
> +# CONFIG_USER_NS is not set
> +# CONFIG_PID_NS is not set
> +# CONFIG_NET_NS is not set
> +CONFIG_BLK_DEV_INITRD=3Dy
> +CONFIG_INITRAMFS_SOURCE=3D""
> +CONFIG_RD_GZIP=3Dy
> +CONFIG_RD_BZIP2=3Dy
> +CONFIG_RD_LZMA=3Dy
> +CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
> +CONFIG_SYSCTL=3Dy
> +CONFIG_ANON_INODES=3Dy
> +# CONFIG_EMBEDDED is not set
> +CONFIG_UID16=3Dy
> +CONFIG_SYSCTL_SYSCALL=3Dy
> +CONFIG_KALLSYMS=3Dy
> +# CONFIG_KALLSYMS_EXTRA_PASS is not set
> +CONFIG_HOTPLUG=3Dy
> +CONFIG_PRINTK=3Dy
> +CONFIG_BUG=3Dy
> +CONFIG_ELF_CORE=3Dy
> +CONFIG_BASE_FULL=3Dy
> +CONFIG_FUTEX=3Dy
> +CONFIG_EPOLL=3Dy
> +CONFIG_SIGNALFD=3Dy
> +CONFIG_TIMERFD=3Dy
> +CONFIG_EVENTFD=3Dy
> +CONFIG_SHMEM=3Dy
> +CONFIG_AIO=3Dy
> +
> +#
> +# Kernel Performance Events And Counters
> +#
> +CONFIG_VM_EVENT_COUNTERS=3Dy
> +CONFIG_COMPAT_BRK=3Dy
> +CONFIG_SLAB=3Dy
> +# CONFIG_SLUB is not set
> +# CONFIG_SLOB is not set
> +# CONFIG_PROFILING is not set
> +CONFIG_HAVE_OPROFILE=3Dy
> +# CONFIG_KPROBES is not set
> +CONFIG_HAVE_KPROBES=3Dy
> +CONFIG_HAVE_KRETPROBES=3Dy
> +CONFIG_HAVE_CLK=3Dy
> +
> +#
> +# GCOV-based kernel profiling
> +#
> +# CONFIG_SLOW_WORK is not set
> +CONFIG_HAVE_GENERIC_DMA_COHERENT=3Dy
> +CONFIG_SLABINFO=3Dy
> +CONFIG_RT_MUTEXES=3Dy
> +CONFIG_BASE_SMALL=3D0
> +CONFIG_MODULES=3Dy
> +# CONFIG_MODULE_FORCE_LOAD is not set
> +CONFIG_MODULE_UNLOAD=3Dy
> +# CONFIG_MODULE_FORCE_UNLOAD is not set
> +# CONFIG_MODVERSIONS is not set
> +# CONFIG_MODULE_SRCVERSION_ALL is not set
> +CONFIG_BLOCK=3Dy
> +CONFIG_LBDAF=3Dy
> +# CONFIG_BLK_DEV_BSG is not set
> +# CONFIG_BLK_DEV_INTEGRITY is not set
> +
> +#
> +# IO Schedulers
> +#
> +CONFIG_IOSCHED_NOOP=3Dy
> +CONFIG_IOSCHED_AS=3Dy
> +CONFIG_IOSCHED_DEADLINE=3Dy
> +CONFIG_IOSCHED_CFQ=3Dy
> +# CONFIG_DEFAULT_AS is not set
> +# CONFIG_DEFAULT_DEADLINE is not set
> +CONFIG_DEFAULT_CFQ=3Dy
> +# CONFIG_DEFAULT_NOOP is not set
> +CONFIG_DEFAULT_IOSCHED=3D"cfq"
> +CONFIG_FREEZER=3Dy
> +
> +#
> +# System Type
> +#
> +CONFIG_MMU=3Dy
> +# CONFIG_ARCH_AAEC2000 is not set
> +# CONFIG_ARCH_INTEGRATOR is not set
> +# CONFIG_ARCH_REALVIEW is not set
> +# CONFIG_ARCH_VERSATILE is not set
> +# CONFIG_ARCH_AT91 is not set
> +# CONFIG_ARCH_CLPS711X is not set
> +# CONFIG_ARCH_GEMINI is not set
> +# CONFIG_ARCH_EBSA110 is not set
> +# CONFIG_ARCH_EP93XX is not set
> +# CONFIG_ARCH_FOOTBRIDGE is not set
> +# CONFIG_ARCH_MXC is not set
> +# CONFIG_ARCH_STMP3XXX is not set
> +# CONFIG_ARCH_NETX is not set
> +# CONFIG_ARCH_H720X is not set
> +# CONFIG_ARCH_NOMADIK is not set
> +# CONFIG_ARCH_IOP13XX is not set
> +# CONFIG_ARCH_IOP32X is not set
> +# CONFIG_ARCH_IOP33X is not set
> +# CONFIG_ARCH_IXP23XX is not set
> +# CONFIG_ARCH_IXP2000 is not set
> +# CONFIG_ARCH_IXP4XX is not set
> +# CONFIG_ARCH_L7200 is not set
> +# CONFIG_ARCH_KIRKWOOD is not set
> +# CONFIG_ARCH_LOKI is not set
> +# CONFIG_ARCH_MV78XX0 is not set
> +# CONFIG_ARCH_ORION5X is not set
> +# CONFIG_ARCH_MMP is not set
> +# CONFIG_ARCH_KS8695 is not set
> +# CONFIG_ARCH_NS9XXX is not set
> +# CONFIG_ARCH_W90X900 is not set
> +# CONFIG_ARCH_PNX4008 is not set
> +# CONFIG_ARCH_PXA is not set
> +# CONFIG_ARCH_MSM is not set
> +# CONFIG_ARCH_RPC is not set
> +# CONFIG_ARCH_SA1100 is not set
> +# CONFIG_ARCH_S3C2410 is not set
> +# CONFIG_ARCH_S3C64XX is not set
> +# CONFIG_ARCH_S5PC1XX is not set
> +# CONFIG_ARCH_SHARK is not set
> +# CONFIG_ARCH_LH7A40X is not set
> +# CONFIG_ARCH_U300 is not set
> +# CONFIG_ARCH_DAVINCI is not set
> +CONFIG_ARCH_OMAP=3Dy
> +# CONFIG_ARCH_BCMRING is not set
> +
> +#
> +# TI OMAP Implementations
> +#
> +CONFIG_ARCH_OMAP1=3Dy
> +# CONFIG_ARCH_OMAP2 is not set
> +# CONFIG_ARCH_OMAP3 is not set
> +# CONFIG_ARCH_OMAP4 is not set
> +
> +#
> +# OMAP Feature Selections
> +#
> +# CONFIG_OMAP_RESET_CLOCKS is not set
> +# CONFIG_OMAP_MUX is not set
> +CONFIG_OMAP_MCBSP=3Dy
> +# CONFIG_OMAP_MBOX_FWK is not set
> +CONFIG_OMAP_MPU_TIMER=3Dy
> +# CONFIG_OMAP_32K_TIMER is not set
> +CONFIG_OMAP_LL_DEBUG_UART1=3Dy
> +# CONFIG_OMAP_LL_DEBUG_UART2 is not set
> +# CONFIG_OMAP_LL_DEBUG_UART3 is not set
> +# CONFIG_OMAP_PM_NONE is not set
> +CONFIG_OMAP_PM_NOOP=3Dy
> +
> +#
> +# OMAP Core Type
> +#
> +# CONFIG_ARCH_OMAP730 is not set
> +CONFIG_ARCH_OMAP850=3Dy
> +# CONFIG_ARCH_OMAP15XX is not set
> +# CONFIG_ARCH_OMAP16XX is not set
> +
> +#
> +# OMAP Board Type
> +#
> +# CONFIG_MACH_OMAP_HTCWIZARD is not set
> +CONFIG_MACH_HERALD=3Dy
> +
> +#
> +# OMAP CPU Speed
> +#
> +# CONFIG_OMAP_CLOCKS_SET_BY_BOOTLOADER is not set
> +CONFIG_OMAP_ARM_195MHZ=3Dy
> +# CONFIG_OMAP_ARM_182MHZ is not set
> +# CONFIG_OMAP_ARM_168MHZ is not set
> +# CONFIG_OMAP_ARM_120MHZ is not set
> +# CONFIG_OMAP_ARM_60MHZ is not set
> +# CONFIG_OMAP_ARM_30MHZ is not set
> +
> +#
> +# Processor Type
> +#
> +CONFIG_CPU_32=3Dy
> +CONFIG_CPU_ARM925T=3Dy
> +CONFIG_CPU_ARM926T=3Dy
> +CONFIG_CPU_32v4T=3Dy
> +CONFIG_CPU_32v5=3Dy
> +CONFIG_CPU_ABRT_EV4T=3Dy
> +CONFIG_CPU_ABRT_EV5TJ=3Dy
> +CONFIG_CPU_PABRT_NOIFAR=3Dy
> +CONFIG_CPU_CACHE_V4WT=3Dy
> +CONFIG_CPU_CACHE_VIVT=3Dy
> +CONFIG_CPU_COPY_V4WB=3Dy
> +CONFIG_CPU_TLB_V4WBI=3Dy
> +CONFIG_CPU_CP15=3Dy
> +CONFIG_CPU_CP15_MMU=3Dy
> +
> +#
> +# Processor Features
> +#
> +CONFIG_ARM_THUMB=3Dy
> +# CONFIG_CPU_ICACHE_DISABLE is not set
> +# CONFIG_CPU_DCACHE_DISABLE is not set
> +CONFIG_CPU_DCACHE_WRITETHROUGH=3Dy
> +# CONFIG_CPU_CACHE_ROUND_ROBIN is not set
> +CONFIG_ARM_L1_CACHE_SHIFT=3D5
> +CONFIG_COMMON_CLKDEV=3Dy
> +
> +#
> +# Bus support
> +#
> +# CONFIG_PCI_SYSCALL is not set
> +# CONFIG_ARCH_SUPPORTS_MSI is not set
> +# CONFIG_PCCARD is not set
> +
> +#
> +# Kernel Features
> +#
> +# CONFIG_NO_HZ is not set
> +# CONFIG_HIGH_RES_TIMERS is not set
> +CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy
> +CONFIG_VMSPLIT_3G=3Dy
> +# CONFIG_VMSPLIT_2G is not set
> +# CONFIG_VMSPLIT_1G is not set
> +CONFIG_PAGE_OFFSET=3D0xC0000000
> +# CONFIG_PREEMPT_NONE is not set
> +# CONFIG_PREEMPT_VOLUNTARY is not set
> +CONFIG_PREEMPT=3Dy
> +CONFIG_HZ=3D100
> +CONFIG_AEABI=3Dy
> +CONFIG_OABI_COMPAT=3Dy
> +# CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
> +# CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
> +# CONFIG_HIGHMEM is not set
> +CONFIG_SELECT_MEMORY_MODEL=3Dy
> +CONFIG_FLATMEM_MANUAL=3Dy
> +# CONFIG_DISCONTIGMEM_MANUAL is not set
> +# CONFIG_SPARSEMEM_MANUAL is not set
> +CONFIG_FLATMEM=3Dy
> +CONFIG_FLAT_NODE_MEM_MAP=3Dy
> +CONFIG_PAGEFLAGS_EXTENDED=3Dy
> +CONFIG_SPLIT_PTLOCK_CPUS=3D4096
> +# CONFIG_PHYS_ADDR_T_64BIT is not set
> +CONFIG_ZONE_DMA_FLAG=3D0
> +CONFIG_VIRT_TO_BUS=3Dy
> +CONFIG_HAVE_MLOCK=3Dy
> +CONFIG_HAVE_MLOCKED_PAGE_BIT=3Dy
> +# CONFIG_KSM is not set
> +CONFIG_DEFAULT_MMAP_MIN_ADDR=3D4096
> +CONFIG_LEDS=3Dy
> +CONFIG_ALIGNMENT_TRAP=3Dy
> +# CONFIG_UACCESS_WITH_MEMCPY is not set
> +
> +#
> +# Boot options
> +#
> +CONFIG_ZBOOT_ROM_TEXT=3D0x0
> +CONFIG_ZBOOT_ROM_BSS=3D0x0
> +CONFIG_CMDLINE=3D"mem=3D32M console=3DttyS0,115200 ip=3Ddhcp"
> +# CONFIG_XIP_KERNEL is not set
> +# CONFIG_KEXEC is not set
> +
> +#
> +# CPU Power Management
> +#
> +# CONFIG_CPU_FREQ is not set
> +# CONFIG_CPU_IDLE is not set
> +
> +#
> +# Floating point emulation
> +#
> +
> +#
> +# At least one emulation must be selected
> +#
> +CONFIG_FPE_NWFPE=3Dy
> +# CONFIG_FPE_NWFPE_XP is not set
> +# CONFIG_FPE_FASTFPE is not set
> +# CONFIG_VFP is not set
> +
> +#
> +# Userspace binary formats
> +#
> +CONFIG_BINFMT_ELF=3Dy
> +# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> +CONFIG_HAVE_AOUT=3Dy
> +# CONFIG_BINFMT_AOUT is not set
> +# CONFIG_BINFMT_MISC is not set
> +
> +#
> +# Power management options
> +#
> +CONFIG_PM=3Dy
> +# CONFIG_PM_DEBUG is not set
> +CONFIG_PM_SLEEP=3Dy
> +CONFIG_SUSPEND=3Dy
> +CONFIG_SUSPEND_FREEZER=3Dy
> +# CONFIG_APM_EMULATION is not set
> +# CONFIG_PM_RUNTIME is not set
> +CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
> +CONFIG_NET=3Dy
> +
> +#
> +# Networking options
> +#
> +CONFIG_PACKET=3Dy
> +# CONFIG_PACKET_MMAP is not set
> +CONFIG_UNIX=3Dy
> +CONFIG_XFRM=3Dy
> +# CONFIG_XFRM_USER is not set
> +# CONFIG_XFRM_SUB_POLICY is not set
> +# CONFIG_XFRM_MIGRATE is not set
> +# CONFIG_XFRM_STATISTICS is not set
> +# CONFIG_NET_KEY is not set
> +CONFIG_INET=3Dy
> +CONFIG_IP_MULTICAST=3Dy
> +# CONFIG_IP_ADVANCED_ROUTER is not set
> +CONFIG_IP_FIB_HASH=3Dy
> +CONFIG_IP_PNP=3Dy
> +CONFIG_IP_PNP_DHCP=3Dy
> +CONFIG_IP_PNP_BOOTP=3Dy
> +# CONFIG_IP_PNP_RARP is not set
> +# CONFIG_NET_IPIP is not set
> +# CONFIG_NET_IPGRE is not set
> +# CONFIG_IP_MROUTE is not set
> +# CONFIG_ARPD is not set
> +# CONFIG_SYN_COOKIES is not set
> +# CONFIG_INET_AH is not set
> +# CONFIG_INET_ESP is not set
> +# CONFIG_INET_IPCOMP is not set
> +# CONFIG_INET_XFRM_TUNNEL is not set
> +# CONFIG_INET_TUNNEL is not set
> +CONFIG_INET_XFRM_MODE_TRANSPORT=3Dy
> +CONFIG_INET_XFRM_MODE_TUNNEL=3Dy
> +CONFIG_INET_XFRM_MODE_BEET=3Dy
> +CONFIG_INET_LRO=3Dy
> +CONFIG_INET_DIAG=3Dy
> +CONFIG_INET_TCP_DIAG=3Dy
> +# CONFIG_TCP_CONG_ADVANCED is not set
> +CONFIG_TCP_CONG_CUBIC=3Dy
> +CONFIG_DEFAULT_TCP_CONG=3D"cubic"
> +# CONFIG_TCP_MD5SIG is not set
> +# CONFIG_IPV6 is not set
> +# CONFIG_NETWORK_SECMARK is not set
> +# CONFIG_NETFILTER is not set
> +# CONFIG_IP_DCCP is not set
> +# CONFIG_IP_SCTP is not set
> +# CONFIG_RDS is not set
> +# CONFIG_TIPC is not set
> +# CONFIG_ATM is not set
> +# CONFIG_BRIDGE is not set
> +# CONFIG_NET_DSA is not set
> +# CONFIG_VLAN_8021Q is not set
> +# CONFIG_DECNET is not set
> +# CONFIG_LLC2 is not set
> +# CONFIG_IPX is not set
> +# CONFIG_ATALK is not set
> +# CONFIG_X25 is not set
> +# CONFIG_LAPB is not set
> +# CONFIG_ECONET is not set
> +# CONFIG_WAN_ROUTER is not set
> +# CONFIG_PHONET is not set
> +# CONFIG_IEEE802154 is not set
> +# CONFIG_NET_SCHED is not set
> +# CONFIG_DCB is not set
> +
> +#
> +# Network testing
> +#
> +# CONFIG_NET_PKTGEN is not set
> +# CONFIG_HAMRADIO is not set
> +# CONFIG_CAN is not set
> +# CONFIG_IRDA is not set
> +# CONFIG_BT is not set
> +# CONFIG_AF_RXRPC is not set
> +CONFIG_WIRELESS=3Dy
> +# CONFIG_CFG80211 is not set
> +CONFIG_CFG80211_DEFAULT_PS_VALUE=3D0
> +# CONFIG_WIRELESS_OLD_REGULATORY is not set
> +# CONFIG_WIRELESS_EXT is not set
> +# CONFIG_LIB80211 is not set
> +
> +#
> +# CFG80211 needs to be enabled for MAC80211
> +#
> +# CONFIG_WIMAX is not set
> +# CONFIG_RFKILL is not set
> +# CONFIG_NET_9P is not set
> +
> +#
> +# Device Drivers
> +#
> +
> +#
> +# Generic Driver Options
> +#
> +CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
> +# CONFIG_DEVTMPFS is not set
> +CONFIG_STANDALONE=3Dy
> +CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
> +CONFIG_FW_LOADER=3Dy
> +CONFIG_FIRMWARE_IN_KERNEL=3Dy
> +CONFIG_EXTRA_FIRMWARE=3D""
> +# CONFIG_SYS_HYPERVISOR is not set
> +# CONFIG_CONNECTOR is not set
> +# CONFIG_MTD is not set
> +# CONFIG_PARPORT is not set
> +CONFIG_BLK_DEV=3Dy
> +# CONFIG_BLK_DEV_COW_COMMON is not set
> +CONFIG_BLK_DEV_LOOP=3Dy
> +# CONFIG_BLK_DEV_CRYPTOLOOP is not set
> +# CONFIG_BLK_DEV_NBD is not set
> +CONFIG_BLK_DEV_RAM=3Dy
> +CONFIG_BLK_DEV_RAM_COUNT=3D16
> +CONFIG_BLK_DEV_RAM_SIZE=3D8192
> +# CONFIG_BLK_DEV_XIP is not set
> +# CONFIG_CDROM_PKTCDVD is not set
> +# CONFIG_ATA_OVER_ETH is not set
> +# CONFIG_MG_DISK is not set
> +CONFIG_MISC_DEVICES=3Dy
> +# CONFIG_ENCLOSURE_SERVICES is not set
> +# CONFIG_C2PORT is not set
> +
> +#
> +# EEPROM support
> +#
> +# CONFIG_EEPROM_93CX6 is not set
> +CONFIG_HAVE_IDE=3Dy
> +# CONFIG_IDE is not set
> +
> +#
> +# SCSI device support
> +#
> +# CONFIG_RAID_ATTRS is not set
> +# CONFIG_SCSI is not set
> +# CONFIG_SCSI_DMA is not set
> +# CONFIG_SCSI_NETLINK is not set
> +# CONFIG_ATA is not set
> +# CONFIG_MD is not set
> +CONFIG_NETDEVICES=3Dy
> +# CONFIG_DUMMY is not set
> +# CONFIG_BONDING is not set
> +# CONFIG_MACVLAN is not set
> +# CONFIG_EQUALIZER is not set
> +# CONFIG_TUN is not set
> +# CONFIG_VETH is not set
> +# CONFIG_PHYLIB is not set
> +CONFIG_NET_ETHERNET=3Dy
> +CONFIG_MII=3Dy
> +# CONFIG_AX88796 is not set
> +CONFIG_SMC91X=3Dy
> +# CONFIG_DM9000 is not set
> +# CONFIG_ETHOC is not set
> +# CONFIG_SMC911X is not set
> +# CONFIG_SMSC911X is not set
> +# CONFIG_DNET is not set
> +# CONFIG_IBM_NEW_EMAC_ZMII is not set
> +# CONFIG_IBM_NEW_EMAC_RGMII is not set
> +# CONFIG_IBM_NEW_EMAC_TAH is not set
> +# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
> +# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
> +# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
> +# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
> +# CONFIG_B44 is not set
> +# CONFIG_KS8842 is not set
> +CONFIG_NETDEV_1000=3Dy
> +CONFIG_NETDEV_10000=3Dy
> +CONFIG_WLAN=3Dy
> +# CONFIG_WLAN_PRE80211 is not set
> +# CONFIG_WLAN_80211 is not set
> +
> +#
> +# Enable WiMAX (Networking options) to see the WiMAX drivers
> +#
> +# CONFIG_WAN is not set
> +# CONFIG_PPP is not set
> +# CONFIG_SLIP is not set
> +# CONFIG_NETCONSOLE is not set
> +# CONFIG_NETPOLL is not set
> +# CONFIG_NET_POLL_CONTROLLER is not set
> +# CONFIG_ISDN is not set
> +# CONFIG_PHONE is not set
> +
> +#
> +# Input device support
> +#
> +CONFIG_INPUT=3Dy
> +# CONFIG_INPUT_FF_MEMLESS is not set
> +# CONFIG_INPUT_POLLDEV is not set
> +
> +#
> +# Userland interfaces
> +#
> +CONFIG_INPUT_MOUSEDEV=3Dy
> +CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
> +CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
> +CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
> +# CONFIG_INPUT_JOYDEV is not set
> +# CONFIG_INPUT_EVDEV is not set
> +# CONFIG_INPUT_EVBUG is not set
> +
> +#
> +# Input Device Drivers
> +#
> +CONFIG_INPUT_KEYBOARD=3Dy
> +# CONFIG_KEYBOARD_ATKBD is not set
> +# CONFIG_KEYBOARD_LKKBD is not set
> +# CONFIG_KEYBOARD_GPIO is not set
> +# CONFIG_KEYBOARD_MATRIX is not set
> +# CONFIG_KEYBOARD_NEWTON is not set
> +# CONFIG_KEYBOARD_OPENCORES is not set
> +# CONFIG_KEYBOARD_STOWAWAY is not set
> +# CONFIG_KEYBOARD_SUNKBD is not set
> +CONFIG_KEYBOARD_OMAP=3Dy
> +# CONFIG_KEYBOARD_XTKBD is not set
> +# CONFIG_INPUT_MOUSE is not set
> +# CONFIG_INPUT_JOYSTICK is not set
> +# CONFIG_INPUT_TABLET is not set
> +# CONFIG_INPUT_TOUCHSCREEN is not set
> +# CONFIG_INPUT_MISC is not set
> +
> +#
> +# Hardware I/O ports
> +#
> +CONFIG_SERIO=3Dy
> +CONFIG_SERIO_SERPORT=3Dy
> +# CONFIG_SERIO_RAW is not set
> +# CONFIG_GAMEPORT is not set
> +
> +#
> +# Character devices
> +#
> +CONFIG_VT=3Dy
> +CONFIG_CONSOLE_TRANSLATIONS=3Dy
> +CONFIG_VT_CONSOLE=3Dy
> +CONFIG_HW_CONSOLE=3Dy
> +# CONFIG_VT_HW_CONSOLE_BINDING is not set
> +CONFIG_DEVKMEM=3Dy
> +# CONFIG_SERIAL_NONSTANDARD is not set
> +
> +#
> +# Serial drivers
> +#
> +CONFIG_SERIAL_8250=3Dy
> +CONFIG_SERIAL_8250_CONSOLE=3Dy
> +CONFIG_SERIAL_8250_NR_UARTS=3D4
> +CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
> +# CONFIG_SERIAL_8250_EXTENDED is not set
> +
> +#
> +# Non-8250 serial port support
> +#
> +CONFIG_SERIAL_CORE=3Dy
> +CONFIG_SERIAL_CORE_CONSOLE=3Dy
> +CONFIG_UNIX98_PTYS=3Dy
> +# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
> +# CONFIG_LEGACY_PTYS is not set
> +# CONFIG_IPMI_HANDLER is not set
> +CONFIG_HW_RANDOM=3Dm
> +# CONFIG_HW_RANDOM_TIMERIOMEM is not set
> +# CONFIG_R3964 is not set
> +# CONFIG_RAW_DRIVER is not set
> +# CONFIG_TCG_TPM is not set
> +# CONFIG_I2C is not set
> +# CONFIG_SPI is not set
> +
> +#
> +# PPS support
> +#
> +# CONFIG_PPS is not set
> +CONFIG_ARCH_REQUIRE_GPIOLIB=3Dy
> +CONFIG_GPIOLIB=3Dy
> +# CONFIG_GPIO_SYSFS is not set
> +
> +#
> +# Memory mapped GPIO expanders:
> +#
> +
> +#
> +# I2C GPIO expanders:
> +#
> +
> +#
> +# PCI GPIO expanders:
> +#
> +
> +#
> +# SPI GPIO expanders:
> +#
> +
> +#
> +# AC97 GPIO expanders:
> +#
> +# CONFIG_W1 is not set
> +# CONFIG_POWER_SUPPLY is not set
> +CONFIG_HWMON=3Dy
> +# CONFIG_HWMON_VID is not set
> +# CONFIG_HWMON_DEBUG_CHIP is not set
> +
> +#
> +# Native drivers
> +#
> +# CONFIG_SENSORS_F71805F is not set
> +# CONFIG_SENSORS_F71882FG is not set
> +# CONFIG_SENSORS_IT87 is not set
> +# CONFIG_SENSORS_PC87360 is not set
> +# CONFIG_SENSORS_PC87427 is not set
> +# CONFIG_SENSORS_SHT15 is not set
> +# CONFIG_SENSORS_SMSC47M1 is not set
> +# CONFIG_SENSORS_SMSC47B397 is not set
> +# CONFIG_SENSORS_VT1211 is not set
> +# CONFIG_SENSORS_W83627HF is not set
> +# CONFIG_SENSORS_W83627EHF is not set
> +# CONFIG_THERMAL is not set
> +# CONFIG_WATCHDOG is not set
> +CONFIG_SSB_POSSIBLE=3Dy
> +
> +#
> +# Sonics Silicon Backplane
> +#
> +# CONFIG_SSB is not set
> +
> +#
> +# Multifunction device drivers
> +#
> +# CONFIG_MFD_CORE is not set
> +# CONFIG_MFD_SM501 is not set
> +# CONFIG_MFD_ASIC3 is not set
> +# CONFIG_HTC_EGPIO is not set
> +# CONFIG_HTC_PASIC3 is not set
> +# CONFIG_MFD_TMIO is not set
> +# CONFIG_MFD_T7L66XB is not set
> +# CONFIG_MFD_TC6387XB is not set
> +# CONFIG_MFD_TC6393XB is not set
> +# CONFIG_REGULATOR is not set
> +# CONFIG_MEDIA_SUPPORT is not set
> +
> +#
> +# Graphics support
> +#
> +# CONFIG_VGASTATE is not set
> +CONFIG_VIDEO_OUTPUT_CONTROL=3Dm
> +CONFIG_FB=3Dy
> +# CONFIG_FIRMWARE_EDID is not set
> +# CONFIG_FB_DDC is not set
> +# CONFIG_FB_BOOT_VESA_SUPPORT is not set
> +CONFIG_FB_CFB_FILLRECT=3Dy
> +CONFIG_FB_CFB_COPYAREA=3Dy
> +CONFIG_FB_CFB_IMAGEBLIT=3Dy
> +# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
> +# CONFIG_FB_SYS_FILLRECT is not set
> +# CONFIG_FB_SYS_COPYAREA is not set
> +# CONFIG_FB_SYS_IMAGEBLIT is not set
> +# CONFIG_FB_FOREIGN_ENDIAN is not set
> +# CONFIG_FB_SYS_FOPS is not set
> +# CONFIG_FB_SVGALIB is not set
> +# CONFIG_FB_MACMODES is not set
> +# CONFIG_FB_BACKLIGHT is not set
> +CONFIG_FB_MODE_HELPERS=3Dy
> +# CONFIG_FB_TILEBLITTING is not set
> +
> +#
> +# Frame buffer hardware drivers
> +#
> +# CONFIG_FB_S1D13XXX is not set
> +# CONFIG_FB_VIRTUAL is not set
> +# CONFIG_FB_METRONOME is not set
> +# CONFIG_FB_MB862XX is not set
> +# CONFIG_FB_BROADSHEET is not set
> +CONFIG_FB_OMAP=3Dy
> +# CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
> +# CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
> +CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=3D2
> +# CONFIG_FB_OMAP_DMA_TUNE is not set
> +# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
> +
> +#
> +# Display device support
> +#
> +# CONFIG_DISPLAY_SUPPORT is not set
> +
> +#
> +# Console display driver support
> +#
> +# CONFIG_VGA_CONSOLE is not set
> +CONFIG_DUMMY_CONSOLE=3Dy
> +CONFIG_FRAMEBUFFER_CONSOLE=3Dy
> +# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
> +CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
> +CONFIG_FONTS=3Dy
> +# CONFIG_FONT_8x8 is not set
> +# CONFIG_FONT_8x16 is not set
> +# CONFIG_FONT_6x11 is not set
> +# CONFIG_FONT_7x14 is not set
> +# CONFIG_FONT_PEARL_8x8 is not set
> +# CONFIG_FONT_ACORN_8x8 is not set
> +CONFIG_FONT_MINI_4x6=3Dy
> +# CONFIG_FONT_SUN8x16 is not set
> +# CONFIG_FONT_SUN12x22 is not set
> +# CONFIG_FONT_10x18 is not set
> +# CONFIG_LOGO is not set
> +# CONFIG_SOUND is not set
> +CONFIG_HID_SUPPORT=3Dy
> +CONFIG_HID=3Dy
> +# CONFIG_HIDRAW is not set
> +# CONFIG_HID_PID is not set
> +
> +#
> +# Special HID drivers
> +#
> +CONFIG_USB_SUPPORT=3Dy
> +CONFIG_USB_ARCH_HAS_HCD=3Dy
> +CONFIG_USB_ARCH_HAS_OHCI=3Dy
> +# CONFIG_USB_ARCH_HAS_EHCI is not set
> +# CONFIG_USB is not set
> +# CONFIG_USB_MUSB_HDRC is not set
> +# CONFIG_USB_GADGET_MUSB_HDRC is not set
> +
> +#
> +# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> +#
> +CONFIG_USB_GADGET=3Dy
> +# CONFIG_USB_GADGET_DEBUG_FILES is not set
> +CONFIG_USB_GADGET_VBUS_DRAW=3D2
> +CONFIG_USB_GADGET_SELECTED=3Dy
> +# CONFIG_USB_GADGET_AT91 is not set
> +# CONFIG_USB_GADGET_ATMEL_USBA is not set
> +# CONFIG_USB_GADGET_FSL_USB2 is not set
> +# CONFIG_USB_GADGET_LH7A40X is not set
> +CONFIG_USB_GADGET_OMAP=3Dy
> +CONFIG_USB_OMAP=3Dy
> +# CONFIG_USB_GADGET_PXA25X is not set
> +# CONFIG_USB_GADGET_R8A66597 is not set
> +# CONFIG_USB_GADGET_PXA27X is not set
> +# CONFIG_USB_GADGET_S3C_HSOTG is not set
> +# CONFIG_USB_GADGET_IMX is not set
> +# CONFIG_USB_GADGET_S3C2410 is not set
> +# CONFIG_USB_GADGET_M66592 is not set
> +# CONFIG_USB_GADGET_AMD5536UDC is not set
> +# CONFIG_USB_GADGET_FSL_QE is not set
> +# CONFIG_USB_GADGET_CI13XXX is not set
> +# CONFIG_USB_GADGET_NET2280 is not set
> +# CONFIG_USB_GADGET_GOKU is not set
> +# CONFIG_USB_GADGET_LANGWELL is not set
> +# CONFIG_USB_GADGET_DUMMY_HCD is not set
> +# CONFIG_USB_GADGET_DUALSPEED is not set
> +# CONFIG_USB_ZERO is not set
> +# CONFIG_USB_AUDIO is not set
> +CONFIG_USB_ETH=3Dy
> +# CONFIG_USB_ETH_RNDIS is not set
> +# CONFIG_USB_ETH_EEM is not set
> +# CONFIG_USB_GADGETFS is not set
> +# CONFIG_USB_FILE_STORAGE is not set
> +# CONFIG_USB_G_SERIAL is not set
> +# CONFIG_USB_MIDI_GADGET is not set
> +# CONFIG_USB_G_PRINTER is not set
> +# CONFIG_USB_CDC_COMPOSITE is not set
> +
> +#
> +# OTG and related infrastructure
> +#
> +CONFIG_USB_OTG_UTILS=3Dy
> +# CONFIG_USB_GPIO_VBUS is not set
> +# CONFIG_NOP_USB_XCEIV is not set
> +CONFIG_MMC=3Dy
> +# CONFIG_MMC_DEBUG is not set
> +# CONFIG_MMC_UNSAFE_RESUME is not set
> +
> +#
> +# MMC/SD/SDIO Card Drivers
> +#
> +CONFIG_MMC_BLOCK=3Dy
> +CONFIG_MMC_BLOCK_BOUNCE=3Dy
> +# CONFIG_SDIO_UART is not set
> +# CONFIG_MMC_TEST is not set
> +
> +#
> +# MMC/SD/SDIO Host Controller Drivers
> +#
> +CONFIG_MMC_SDHCI=3Dy
> +CONFIG_MMC_SDHCI_PLTFM=3Dy
> +CONFIG_MMC_OMAP=3Dy
> +# CONFIG_MMC_AT91 is not set
> +# CONFIG_MMC_ATMELMCI is not set
> +# CONFIG_MEMSTICK is not set
> +# CONFIG_NEW_LEDS is not set
> +# CONFIG_ACCESSIBILITY is not set
> +CONFIG_RTC_LIB=3Dy
> +CONFIG_RTC_CLASS=3Dy
> +CONFIG_RTC_HCTOSYS=3Dy
> +CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
> +# CONFIG_RTC_DEBUG is not set
> +
> +#
> +# RTC interfaces
> +#
> +CONFIG_RTC_INTF_SYSFS=3Dy
> +CONFIG_RTC_INTF_PROC=3Dy
> +CONFIG_RTC_INTF_DEV=3Dy
> +# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> +# CONFIG_RTC_DRV_TEST is not set
> +
> +#
> +# SPI RTC drivers
> +#
> +
> +#
> +# Platform RTC drivers
> +#
> +# CONFIG_RTC_DRV_CMOS is not set
> +# CONFIG_RTC_DRV_DS1286 is not set
> +# CONFIG_RTC_DRV_DS1511 is not set
> +# CONFIG_RTC_DRV_DS1553 is not set
> +# CONFIG_RTC_DRV_DS1742 is not set
> +# CONFIG_RTC_DRV_STK17TA8 is not set
> +# CONFIG_RTC_DRV_M48T86 is not set
> +# CONFIG_RTC_DRV_M48T35 is not set
> +# CONFIG_RTC_DRV_M48T59 is not set
> +# CONFIG_RTC_DRV_BQ4802 is not set
> +# CONFIG_RTC_DRV_V3020 is not set
> +
> +#
> +# on-CPU RTC drivers
> +#
> +# CONFIG_DMADEVICES is not set
> +# CONFIG_AUXDISPLAY is not set
> +# CONFIG_UIO is not set
> +
> +#
> +# TI VLYNQ
> +#
> +# CONFIG_STAGING is not set
> +
> +#
> +# CBUS support
> +#
> +# CONFIG_CBUS is not set
> +
> +#
> +# File systems
> +#
> +CONFIG_EXT2_FS=3Dy
> +# CONFIG_EXT2_FS_XATTR is not set
> +# CONFIG_EXT2_FS_XIP is not set
> +CONFIG_EXT3_FS=3Dy
> +# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
> +CONFIG_EXT3_FS_XATTR=3Dy
> +# CONFIG_EXT3_FS_POSIX_ACL is not set
> +# CONFIG_EXT3_FS_SECURITY is not set
> +# CONFIG_EXT4_FS is not set
> +CONFIG_JBD=3Dy
> +CONFIG_FS_MBCACHE=3Dy
> +# CONFIG_REISERFS_FS is not set
> +# CONFIG_JFS_FS is not set
> +# CONFIG_FS_POSIX_ACL is not set
> +# CONFIG_XFS_FS is not set
> +# CONFIG_GFS2_FS is not set
> +# CONFIG_OCFS2_FS is not set
> +# CONFIG_BTRFS_FS is not set
> +# CONFIG_NILFS2_FS is not set
> +CONFIG_FILE_LOCKING=3Dy
> +CONFIG_FSNOTIFY=3Dy
> +CONFIG_DNOTIFY=3Dy
> +CONFIG_INOTIFY=3Dy
> +CONFIG_INOTIFY_USER=3Dy
> +# CONFIG_QUOTA is not set
> +# CONFIG_AUTOFS_FS is not set
> +# CONFIG_AUTOFS4_FS is not set
> +# CONFIG_FUSE_FS is not set
> +
> +#
> +# Caches
> +#
> +# CONFIG_FSCACHE is not set
> +
> +#
> +# CD-ROM/DVD Filesystems
> +#
> +# CONFIG_ISO9660_FS is not set
> +# CONFIG_UDF_FS is not set
> +
> +#
> +# DOS/FAT/NT Filesystems
> +#
> +# CONFIG_MSDOS_FS is not set
> +# CONFIG_VFAT_FS is not set
> +# CONFIG_NTFS_FS is not set
> +
> +#
> +# Pseudo filesystems
> +#
> +CONFIG_PROC_FS=3Dy
> +CONFIG_PROC_SYSCTL=3Dy
> +CONFIG_PROC_PAGE_MONITOR=3Dy
> +CONFIG_SYSFS=3Dy
> +CONFIG_TMPFS=3Dy
> +# CONFIG_TMPFS_POSIX_ACL is not set
> +# CONFIG_HUGETLB_PAGE is not set
> +# CONFIG_CONFIGFS_FS is not set
> +CONFIG_MISC_FILESYSTEMS=3Dy
> +# CONFIG_ADFS_FS is not set
> +# CONFIG_AFFS_FS is not set
> +# CONFIG_HFS_FS is not set
> +# CONFIG_HFSPLUS_FS is not set
> +# CONFIG_BEFS_FS is not set
> +# CONFIG_BFS_FS is not set
> +# CONFIG_EFS_FS is not set
> +# CONFIG_CRAMFS is not set
> +# CONFIG_SQUASHFS is not set
> +# CONFIG_VXFS_FS is not set
> +# CONFIG_MINIX_FS is not set
> +# CONFIG_OMFS_FS is not set
> +# CONFIG_HPFS_FS is not set
> +# CONFIG_QNX4FS_FS is not set
> +# CONFIG_ROMFS_FS is not set
> +# CONFIG_SYSV_FS is not set
> +# CONFIG_UFS_FS is not set
> +CONFIG_NETWORK_FILESYSTEMS=3Dy
> +CONFIG_NFS_FS=3Dy
> +# CONFIG_NFS_V3 is not set
> +# CONFIG_NFS_V4 is not set
> +CONFIG_ROOT_NFS=3Dy
> +# CONFIG_NFSD is not set
> +CONFIG_LOCKD=3Dy
> +CONFIG_NFS_COMMON=3Dy
> +CONFIG_SUNRPC=3Dy
> +# CONFIG_RPCSEC_GSS_KRB5 is not set
> +# CONFIG_RPCSEC_GSS_SPKM3 is not set
> +# CONFIG_SMB_FS is not set
> +# CONFIG_CIFS is not set
> +# CONFIG_NCP_FS is not set
> +# CONFIG_CODA_FS is not set
> +# CONFIG_AFS_FS is not set
> +
> +#
> +# Partition Types
> +#
> +# CONFIG_PARTITION_ADVANCED is not set
> +CONFIG_MSDOS_PARTITION=3Dy
> +# CONFIG_NLS is not set
> +# CONFIG_DLM is not set
> +
> +#
> +# Kernel hacking
> +#
> +# CONFIG_PRINTK_TIME is not set
> +CONFIG_ENABLE_WARN_DEPRECATED=3Dy
> +CONFIG_ENABLE_MUST_CHECK=3Dy
> +CONFIG_FRAME_WARN=3D1024
> +# CONFIG_MAGIC_SYSRQ is not set
> +# CONFIG_STRIP_ASM_SYMS is not set
> +# CONFIG_UNUSED_SYMBOLS is not set
> +# CONFIG_DEBUG_FS is not set
> +# CONFIG_HEADERS_CHECK is not set
> +# CONFIG_DEBUG_KERNEL is not set
> +CONFIG_DEBUG_BUGVERBOSE=3Dy
> +CONFIG_DEBUG_MEMORY_INIT=3Dy
> +# CONFIG_RCU_CPU_STALL_DETECTOR is not set
> +# CONFIG_LATENCYTOP is not set
> +# CONFIG_SYSCTL_SYSCALL_CHECK is not set
> +CONFIG_HAVE_FUNCTION_TRACER=3Dy
> +CONFIG_TRACING_SUPPORT=3Dy
> +# CONFIG_FTRACE is not set
> +# CONFIG_SAMPLES is not set
> +CONFIG_HAVE_ARCH_KGDB=3Dy
> +CONFIG_ARM_UNWIND=3Dy
> +# CONFIG_DEBUG_USER is not set
> +
> +#
> +# Security options
> +#
> +# CONFIG_KEYS is not set
> +# CONFIG_SECURITY is not set
> +# CONFIG_SECURITYFS is not set
> +# CONFIG_SECURITY_FILE_CAPABILITIES is not set
> +CONFIG_CRYPTO=3Dy
> +
> +#
> +# Crypto core or helper
> +#
> +CONFIG_CRYPTO_ALGAPI=3Dy
> +CONFIG_CRYPTO_ALGAPI2=3Dy
> +CONFIG_CRYPTO_PCOMP=3Dy
> +# CONFIG_CRYPTO_MANAGER is not set
> +# CONFIG_CRYPTO_MANAGER2 is not set
> +# CONFIG_CRYPTO_GF128MUL is not set
> +# CONFIG_CRYPTO_NULL is not set
> +# CONFIG_CRYPTO_CRYPTD is not set
> +# CONFIG_CRYPTO_AUTHENC is not set
> +# CONFIG_CRYPTO_TEST is not set
> +
> +#
> +# Authenticated Encryption with Associated Data
> +#
> +# CONFIG_CRYPTO_CCM is not set
> +# CONFIG_CRYPTO_GCM is not set
> +# CONFIG_CRYPTO_SEQIV is not set
> +
> +#
> +# Block modes
> +#
> +# CONFIG_CRYPTO_CBC is not set
> +# CONFIG_CRYPTO_CTR is not set
> +# CONFIG_CRYPTO_CTS is not set
> +# CONFIG_CRYPTO_ECB is not set
> +# CONFIG_CRYPTO_LRW is not set
> +# CONFIG_CRYPTO_PCBC is not set
> +# CONFIG_CRYPTO_XTS is not set
> +
> +#
> +# Hash modes
> +#
> +# CONFIG_CRYPTO_HMAC is not set
> +# CONFIG_CRYPTO_XCBC is not set
> +# CONFIG_CRYPTO_VMAC is not set
> +
> +#
> +# Digest
> +#
> +# CONFIG_CRYPTO_CRC32C is not set
> +# CONFIG_CRYPTO_GHASH is not set
> +# CONFIG_CRYPTO_MD4 is not set
> +# CONFIG_CRYPTO_MD5 is not set
> +# CONFIG_CRYPTO_MICHAEL_MIC is not set
> +# CONFIG_CRYPTO_RMD128 is not set
> +# CONFIG_CRYPTO_RMD160 is not set
> +# CONFIG_CRYPTO_RMD256 is not set
> +# CONFIG_CRYPTO_RMD320 is not set
> +# CONFIG_CRYPTO_SHA1 is not set
> +# CONFIG_CRYPTO_SHA256 is not set
> +# CONFIG_CRYPTO_SHA512 is not set
> +# CONFIG_CRYPTO_TGR192 is not set
> +# CONFIG_CRYPTO_WP512 is not set
> +
> +#
> +# Ciphers
> +#
> +# CONFIG_CRYPTO_AES is not set
> +# CONFIG_CRYPTO_ANUBIS is not set
> +# CONFIG_CRYPTO_ARC4 is not set
> +# CONFIG_CRYPTO_BLOWFISH is not set
> +# CONFIG_CRYPTO_CAMELLIA is not set
> +# CONFIG_CRYPTO_CAST5 is not set
> +# CONFIG_CRYPTO_CAST6 is not set
> +# CONFIG_CRYPTO_DES is not set
> +# CONFIG_CRYPTO_FCRYPT is not set
> +# CONFIG_CRYPTO_KHAZAD is not set
> +# CONFIG_CRYPTO_SALSA20 is not set
> +# CONFIG_CRYPTO_SEED is not set
> +# CONFIG_CRYPTO_SERPENT is not set
> +# CONFIG_CRYPTO_TEA is not set
> +# CONFIG_CRYPTO_TWOFISH is not set
> +
> +#
> +# Compression
> +#
> +CONFIG_CRYPTO_DEFLATE=3Dy
> +CONFIG_CRYPTO_ZLIB=3Dy
> +CONFIG_CRYPTO_LZO=3Dy
> +
> +#
> +# Random Number Generation
> +#
> +# CONFIG_CRYPTO_ANSI_CPRNG is not set
> +CONFIG_CRYPTO_HW=3Dy
> +# CONFIG_BINARY_PRINTF is not set
> +
> +#
> +# Library routines
> +#
> +CONFIG_BITREVERSE=3Dy
> +CONFIG_GENERIC_FIND_LAST_BIT=3Dy
> +# CONFIG_CRC_CCITT is not set
> +# CONFIG_CRC16 is not set
> +# CONFIG_CRC_T10DIF is not set
> +# CONFIG_CRC_ITU_T is not set
> +CONFIG_CRC32=3Dy
> +# CONFIG_CRC7 is not set
> +# CONFIG_LIBCRC32C is not set
> +CONFIG_ZLIB_INFLATE=3Dy
> +CONFIG_ZLIB_DEFLATE=3Dy
> +CONFIG_LZO_COMPRESS=3Dy
> +CONFIG_LZO_DECOMPRESS=3Dy
> +CONFIG_DECOMPRESS_GZIP=3Dy
> +CONFIG_DECOMPRESS_BZIP2=3Dy
> +CONFIG_DECOMPRESS_LZMA=3Dy
> +CONFIG_HAS_IOMEM=3Dy
> +CONFIG_HAS_IOPORT=3Dy
> +CONFIG_HAS_DMA=3Dy
> +CONFIG_NLATTR=3Dy
> diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfi=
g
> index 55ecc01..0341d7b 100644
> --- a/arch/arm/mach-omap1/Kconfig
> +++ b/arch/arm/mach-omap1/Kconfig
> @@ -56,6 +56,12 @@ config MACH_OMAP_HTCWIZARD
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0HTC Wizard smartphone support (AKA QTEK 9100, ...)
>
> +config MACH_HERALD
> + =A0 =A0 =A0 bool "HTC Herald"
> + =A0 =A0 =A0 depends on ARCH_OMAP850
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 HTC Herald smartphone support (AKA T-Mobile Wing, .=
=2E.)
> +
> =A0config MACH_OMAP_OSK
> =A0 =A0 =A0 =A0bool "TI OSK Support"
> =A0 =A0 =A0 =A0depends on ARCH_OMAP1 && ARCH_OMAP16XX
> diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makef=
ile
> index 6867cd3..87e539a 100644
> --- a/arch/arm/mach-omap1/Makefile
> +++ b/arch/arm/mach-omap1/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_MACH_OMAP_PALMTT) =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0+=3D board-palmtt.o
> =A0obj-$(CONFIG_MACH_NOKIA770) =A0 =A0 =A0 =A0 =A0 =A0+=3D board-noki=
a770.o
> =A0obj-$(CONFIG_MACH_AMS_DELTA) =A0 =A0 =A0 =A0 =A0 +=3D board-ams-de=
lta.o
> =A0obj-$(CONFIG_MACH_SX1) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D board-=
sx1.o board-sx1-mmc.o
> +obj-$(CONFIG_MACH_HERALD) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D board-htch=
erald.o
>
> =A0ifeq ($(CONFIG_ARCH_OMAP15XX),y)
> =A0# Innovator-1510 FPGA
> diff --git a/arch/arm/mach-omap1/board-htcherald.c
> b/arch/arm/mach-omap1/board-htcherald.c
> new file mode 100644
> index 0000000..0f09600
> --- /dev/null
> +++ b/arch/arm/mach-omap1/board-htcherald.c
> @@ -0,0 +1,233 @@
> +/*
> + * HTC Herald board configuration
> + * Copyright (C) 2009 Cory Maccarrone <darkstar6262@gmail.com>
> + * Copyright (C) 2009 Wing Linux
> + *
> + * This =A0program is =A0free =A0software; you =A0can =A0redistribut=
e it =A0and/or
> + * modify =A0it under the =A0terms of =A0the GNU =A0General Public =A0=
License as
> + * published by the Free Software =A0Foundation; either version 2 of=
 the
> + * License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut
> + * WITHOUT =A0ANY =A0WARRANTY; =A0without =A0 even =A0the =A0implied=
 =A0warranty =A0of
> + * MERCHANTABILITY or =A0FITNESS FOR A PARTICULAR PURPOSE. =A0 See t=
he GNU
> + * General Public License for more details.
> + *
> + * You should have =A0received a copy of the =A0GNU General Public L=
icense
> + * along =A0with =A0this program; =A0if =A0not, =A0write =A0to the =A0=
=46ree =A0Software
> + * Foundation, =A0Inc., =A051 Franklin =A0Street, =A0Fifth =A0Floor,=
 Boston, =A0MA
> + * 02110-1301, USA.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/input.h>
> +#include <linux/bootmem.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <mach/omap7xx.h>
> +#include <asm/page.h>
> +#include <asm/memory.h>
> +#include <mach/common.h>
> +#include <mach/board.h>
> +
> +#include <mach/io.h>
> +#include <mach/irqs.h>
> +#include <mach/gpio.h>
> +#include <mach/keypad.h>
> +
> +#include <linux/delay.h>
> +
> +static struct omap_lcd_config htcherald_lcd_config __initdata =3D {
> + =A0 =A0 =A0 .ctrl_name =A0 =A0 =A0=3D "internal",
> +};
> +
> +static struct omap_board_config_kernel htcherald_config[] __initdata=
 =3D
> +{
> + =A0 =A0 =A0 { OMAP_TAG_LCD, &htcherald_lcd_config },
> +};
> +
> +/* Keyboard definition */
> +
> +static int htc_herald_keymap[] =3D {
> + =A0 =A0 =A0 KEY(0,0,KEY_RECORD), /* Mail button */
> + =A0 =A0 =A0 KEY(0,1,KEY_CAMERA), /* Camera */
> + =A0 =A0 =A0 KEY(0,2,KEY_PHONE), /* Send key */
> + =A0 =A0 =A0 KEY(0,3,KEY_VOLUMEUP), /* Volume up */
> + =A0 =A0 =A0 KEY(0,4,KEY_F2), =A0/* Right bar (landscape) */
> + =A0 =A0 =A0 KEY(0,5,KEY_MAIL), /* Win key (portrait) */
> + =A0 =A0 =A0 KEY(0,6,KEY_DIRECTORY), /* Right bar (protrait) */
> + =A0 =A0 =A0 KEY(1,0,KEY_LEFTCTRL), /* Windows key */
> + =A0 =A0 =A0 KEY(1,1,KEY_COMMA),
> + =A0 =A0 =A0 KEY(1,2,KEY_M),
> + =A0 =A0 =A0 KEY(1,3,KEY_K),
> + =A0 =A0 =A0 KEY(1,4,KEY_SLASH), /* OK key */
> + =A0 =A0 =A0 KEY(1,5,KEY_I),
> + =A0 =A0 =A0 KEY(1,6,KEY_U),
> + =A0 =A0 =A0 /* Handle red button as alt key,
> + =A0 =A0 =A0 =A0* and map keys on defkeymap */
> + =A0 =A0 =A0 KEY(2,0,KEY_LEFTALT),
> + =A0 =A0 =A0 KEY(2,1,KEY_TAB),
> + =A0 =A0 =A0 KEY(2,2,KEY_N),
> + =A0 =A0 =A0 KEY(2,3,KEY_J),
> + =A0 =A0 =A0 KEY(2,4,KEY_ENTER),
> + =A0 =A0 =A0 KEY(2,5,KEY_H),
> + =A0 =A0 =A0 KEY(2,6,KEY_Y),
> + =A0 =A0 =A0 KEY(3,0,KEY_SPACE),
> + =A0 =A0 =A0 KEY(3,1,KEY_L),
> + =A0 =A0 =A0 KEY(3,2,KEY_B),
> + =A0 =A0 =A0 KEY(3,3,KEY_V),
> + =A0 =A0 =A0 KEY(3,4,KEY_BACKSPACE),
> + =A0 =A0 =A0 KEY(3,5,KEY_G),
> + =A0 =A0 =A0 KEY(3,6,KEY_T),
> + =A0 =A0 =A0 KEY(4,0,KEY_CAPSLOCK), /* Shift */
> + =A0 =A0 =A0 KEY(4,1,KEY_C),
> + =A0 =A0 =A0 KEY(4,2,KEY_F),
> + =A0 =A0 =A0 KEY(4,3,KEY_R),
> + =A0 =A0 =A0 KEY(4,4,KEY_O),
> + =A0 =A0 =A0 KEY(4,5,KEY_E),
> + =A0 =A0 =A0 KEY(4,6,KEY_D),
> + =A0 =A0 =A0 KEY(5,0,KEY_X),
> + =A0 =A0 =A0 KEY(5,1,KEY_Z),
> + =A0 =A0 =A0 KEY(5,2,KEY_S),
> + =A0 =A0 =A0 KEY(5,3,KEY_W),
> + =A0 =A0 =A0 KEY(5,4,KEY_P),
> + =A0 =A0 =A0 KEY(5,5,KEY_Q),
> + =A0 =A0 =A0 KEY(5,6,KEY_A),
> + =A0 =A0 =A0 KEY(6,0,KEY_CONNECT), /* Voice button */
> + =A0 =A0 =A0 KEY(6,2,KEY_CANCEL), /* End key */
> + =A0 =A0 =A0 KEY(6,3,KEY_VOLUMEDOWN), /* Volume down */
> + =A0 =A0 =A0 KEY(6,4,KEY_F1), /* Left bar (landscape) */
> + =A0 =A0 =A0 KEY(6,5,KEY_WWW), /* OK button (portrait) */
> + =A0 =A0 =A0 KEY(6,6,KEY_CALENDAR), /* Left bar (portrait) */
> + =A0 =A0 =A0 0
> +};
> +
> +struct omap_kp_platform_data htcherald_kp_data =3D {
> + =A0 =A0 =A0 .rows =A0 =3D 7,
> + =A0 =A0 =A0 .cols =A0 =3D 7,
> + =A0 =A0 =A0 .delay =3D 20,
> + =A0 =A0 =A0 .rep =3D 1,
> + =A0 =A0 =A0 .keymap =3D htc_herald_keymap,
> +};
> +
> +static struct resource kp_resources[] =3D {
> + =A0 =A0 =A0 [0] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D INT_7XX_MPUIO_KEYPAD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D INT_7XX_MPUIO_KEYPAD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_IRQ,
> + =A0 =A0 =A0 },
> +};
> +
> +static struct platform_device kp_device =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "omap-keypad",
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,
> + =A0 =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0=3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &htcherald_kp_data,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(kp_resources),
> + =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D kp_resources,
> +};
> +
> +/* LCD Device resources */
> +static struct platform_device lcd_device =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "lcd_htcherald",
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,
> +};
> +
> +static struct platform_device *devices[] __initdata =3D {
> + =A0 =A0 =A0 &kp_device,
> + =A0 =A0 =A0 &lcd_device,
> +};
> +
> +/*
> + * Init functions from here on
> + */
> +
> +/* LCD register definition (maybe to move somewhere else */
> +#define =A0 =A0 =A0 OMAP_LCDC_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0=
xfffec000 + 0x00)
> +#define =A0 =A0 =A0 OMAP_LCDC_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(0xfffec000 + 0x10)
> +#define =A0 =A0 =A0 OMAP_DMA_LCD_CCR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(0xfffee300 + 0xc2)
> +#define =A0 =A0 =A0 OMAP_DMA_LCD_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0=
xfffee300 + 0xc4)
> +#define =A0 =A0 =A0 OMAP_LCDC_CTRL_LCD_EN =A0 =A0 =A0 =A0 =A0 (1 << =
0)
> +#define =A0 =A0 =A0 OMAP_LCDC_STAT_DONE =A0 =A0 =A0 =A0 =A0 =A0 (1 <=
< 0)
> +static void htcherald_lcd_init(void)
> +{
> + =A0 =A0 =A0 u32 reg;
> + =A0 =A0 =A0 /* disable controller if active */
> + =A0 =A0 =A0 reg =3D omap_readl(OMAP_LCDC_CONTROL);
> + =A0 =A0 =A0 if (reg & OMAP_LCDC_CTRL_LCD_EN) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~OMAP_LCDC_CTRL_LCD_EN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_writel(reg, OMAP_LCDC_CONTROL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* wait for end of frame */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!(omap_readl(OMAP_LCDC_STATUS) &=
 OMAP_LCDC_STAT_DONE));
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* turn off DMA */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D omap_readw(OMAP_DMA_LCD_CCR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(1 << 7);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_writew(reg, OMAP_DMA_LCD_CCR);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D omap_readw(OMAP_DMA_LCD_CTRL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(1 << 8);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_writew(reg, OMAP_DMA_LCD_CTRL);
> + =A0 =A0 =A0 }
> +}
> +
> +static void __init htcherald_map_io(void)
> +{
> + =A0 =A0 =A0 omap1_map_common_io();
> + =A0 =A0 =A0 printk("htcherald_map_io done.\n");
> +
> + =A0 =A0 =A0 htcherald_lcd_init();
> +}
> +
> +static void __init htcherald_disable_watchdog(void)
> +{
> + =A0 =A0 =A0 /* Disable watchdog if running */
> + =A0 =A0 =A0 if (omap_readl(OMAP_WDT_TIMER_MODE) & 0x8000) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* disable a potentially running watc=
hdog timer before
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* it kills us.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("OMAP850 Watchdog seems to be ac=
tivated, disabling it for now.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_writel(0xF5, OMAP_WDT_TIMER_MODE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_writel(0xA0, OMAP_WDT_TIMER_MODE);
> + =A0 =A0 =A0 }
> +}
> +
> +static void __init htcherald_init(void)
> +{
> + =A0 =A0 =A0 printk("HTC Herald init.\n");
> +
> + =A0 =A0 =A0 omap_gpio_init();
> +
> + =A0 =A0 =A0 omap_board_config =3D htcherald_config;
> + =A0 =A0 =A0 omap_board_config_size =3D ARRAY_SIZE(htcherald_config)=
;
> + =A0 =A0 =A0 platform_add_devices(devices, ARRAY_SIZE(devices));
> +
> + =A0 =A0 =A0 htcherald_disable_watchdog();
> +}
> +
> +static void __init htcherald_init_irq(void)
> +{
> + =A0 =A0 =A0 printk("htcherald_init_irq.\n");
> + =A0 =A0 =A0 omap1_init_common_hw();
> + =A0 =A0 =A0 omap_init_irq();
> +}
> +
> +MACHINE_START(HERALD, "HTC Herald")
> + =A0 =A0 =A0 /* Maintainer: Cory Maccarrone <darkstar6262@gmail.com>=
 */
> + =A0 =A0 =A0 /* Maintainer: wing-linux.sourceforge.net */
> + =A0 =A0 =A0 .phys_io =A0 =A0 =A0 =A0=3D 0xfff00000,
> + =A0 =A0 =A0 .io_pg_offst =A0 =A0=3D ((0xfef00000) >> 18) & 0xfffc,
> + =A0 =A0 =A0 .boot_params =A0 =A0=3D 0x10000100,
> + =A0 =A0 =A0 .map_io =A0 =A0 =A0 =A0 =3D htcherald_map_io,
> + =A0 =A0 =A0 .init_irq =A0 =A0 =A0 =3D htcherald_init_irq,
> + =A0 =A0 =A0 .init_machine =A0 =3D htcherald_init,
> + =A0 =A0 =A0 .timer =A0 =A0 =A0 =A0 =A0=3D &omap_timer,
> +MACHINE_END
> diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefil=
e
> index b63b198..49226a1 100644
> --- a/drivers/video/omap/Makefile
> +++ b/drivers/video/omap/Makefile
> @@ -35,6 +35,7 @@ objs-y$(CONFIG_MACH_OMAP3EVM) +=3D lcd_omap3evm.o
> =A0objs-y$(CONFIG_MACH_OMAP3_BEAGLE) +=3D lcd_omap3beagle.o
> =A0objs-y$(CONFIG_FB_OMAP_LCD_MIPID) +=3D lcd_mipid.o
> =A0objs-y$(CONFIG_MACH_OVERO) +=3D lcd_overo.o
> +objs-y$(CONFIG_MACH_HERALD) +=3D lcd_htcherald.o
>
> =A0omapfb-objs :=3D $(objs-yy)
>
> diff --git a/drivers/video/omap/lcd_htcherald.c
> b/drivers/video/omap/lcd_htcherald.c
> new file mode 100644
> index 0000000..377cd0e
> --- /dev/null
> +++ b/drivers/video/omap/lcd_htcherald.c
> @@ -0,0 +1,124 @@
> +/*
> + * File: drivers/video/omap/lcd-htcherald.c
> + *
> + * LCD panel support for the HTC Herald
> + *
> + * Copyright (C) 2009 Cory Maccarrone <darkstar6262@gmail.com>
> + * Copyright (C) 2009 Wing Linux
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License as published by=
 the
> + * Free Software Foundation; either version 2 of the License, or (at=
 your
> + * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the G=
NU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License=
 along
> + * with this program; if not, write to the Free Software Foundation,=
 Inc.,
> + * 59 Temple Place - Suite 330, Boston, MA =A002111-1307, USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include <mach/omapfb.h>
> +
> +static int htcherald_panel_init(struct lcd_panel *panel,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stru=
ct omapfb_device *fbdev)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void htcherald_panel_cleanup(struct lcd_panel *panel)
> +{
> +}
> +
> +static int htcherald_panel_enable(struct lcd_panel *panel)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void htcherald_panel_disable(struct lcd_panel *panel)
> +{
> +}
> +
> +static unsigned long htcherald_panel_get_caps(struct lcd_panel *pane=
l)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/* Found on WIZ200 (miknix) and some HERA110 models (darkstar62) */
> +struct lcd_panel htcherald_panel_1 =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "lcd_herald",
> + =A0 =A0 =A0 .config =A0 =A0 =A0 =A0 =3D OMAP_LCDC_PANEL_TFT |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_LCDC_INV_HSYNC=
 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_LCDC_INV_VSYNC=
 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_LCDC_INV_PIX_C=
LOCK,
> + =A0 =A0 =A0 .bpp =A0 =A0 =A0 =A0 =A0 =A0=3D 16,
> + =A0 =A0 =A0 .data_lines =A0 =A0 =3D 16,
> + =A0 =A0 =A0 .x_res =A0 =A0 =A0 =A0 =A0=3D 240,
> + =A0 =A0 =A0 .y_res =A0 =A0 =A0 =A0 =A0=3D 320,
> + =A0 =A0 =A0 .pixel_clock =A0 =A0=3D 6093,
> + =A0 =A0 =A0 .pcd =A0 =A0 =A0 =A0 =A0 =A0=3D 0, /* 15 */
> + =A0 =A0 =A0 .hsw =A0 =A0 =A0 =A0 =A0 =A0=3D 10,
> + =A0 =A0 =A0 .hfp =A0 =A0 =A0 =A0 =A0 =A0=3D 10,
> + =A0 =A0 =A0 .hbp =A0 =A0 =A0 =A0 =A0 =A0=3D 20,
> + =A0 =A0 =A0 .vsw =A0 =A0 =A0 =A0 =A0 =A0=3D 3,
> + =A0 =A0 =A0 .vfp =A0 =A0 =A0 =A0 =A0 =A0=3D 2,
> + =A0 =A0 =A0 .vbp =A0 =A0 =A0 =A0 =A0 =A0=3D 2,
> +
> + =A0 =A0 =A0 .init =A0 =A0 =A0 =A0 =A0 =3D htcherald_panel_init,
> + =A0 =A0 =A0 .cleanup =A0 =A0 =A0 =A0=3D htcherald_panel_cleanup,
> + =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D htcherald_panel_enable,
> + =A0 =A0 =A0 .disable =A0 =A0 =A0 =A0=3D htcherald_panel_disable,
> + =A0 =A0 =A0 .get_caps =A0 =A0 =A0 =3D htcherald_panel_get_caps,
> +};
> +
> +static int htcherald_panel_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 omapfb_register_panel(&htcherald_panel_1);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int htcherald_panel_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int htcherald_panel_suspend(struct platform_device *pdev,
> pm_message_t mesg)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int htcherald_panel_resume(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +struct platform_driver htcherald_panel_driver =3D {
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D htcherald_panel_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D htcherald_panel_remove,
> + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D htcherald_panel_suspend,
> + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D htcherald_panel_resume,
> + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "lcd_htcherald",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 },
> +};
> +
> +static int htcherald_panel_drv_init(void)
> +{
> + =A0 =A0 =A0 return platform_driver_register(&htcherald_panel_driver=
);
> +}
> +
> +static void htcherald_panel_drv_cleanup(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&htcherald_panel_driver);
> +}
> +
> +module_init(htcherald_panel_drv_init);
> +module_exit(htcherald_panel_drv_cleanup);
> +
> --
> 1.5.6.3
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
