From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 09/12] AM3517: Update the config file of am3517evm
Date: Wed, 14 Apr 2010 19:12:41 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E136BAC@dbde02.ent.ti.com>
References: <1271233822-27286-1-git-send-email-stanley.miao@windriver.com>
 <1271233822-27286-10-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43792 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755435Ab0DNNmu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Apr 2010 09:42:50 -0400
In-Reply-To: <1271233822-27286-10-git-send-email-stanley.miao@windriver.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Stanley.Miao
> Sent: Wednesday, April 14, 2010 2:00 PM
> To: linux-omap@vger.kernel.org
> Cc: tony@atomide.com
> Subject: [PATCH 09/12] AM3517: Update the config file of am3517evm
>
> Added MTD, NETDEVICES, WATCHDOG, GPIO_PCA953X, REGULATOR, FB, SOUND, MMC,
> RTC.
[Hiremath, Vaibhav] The patch for selection of FB in default config has already been submitted and merged by Tomi; please refer to the tread,

http://marc.info/?l=linux-omap&m=126261568408449&w=2

Thanks,
Vaibhav

>
> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> ---
>  arch/arm/configs/am3517_evm_defconfig |  599 ++++++++++++++++++++++++++++--
> ---
>  1 files changed, 513 insertions(+), 86 deletions(-)
>
> diff --git a/arch/arm/configs/am3517_evm_defconfig
> b/arch/arm/configs/am3517_evm_defconfig
> index 66a10b5..a995767 100644
> --- a/arch/arm/configs/am3517_evm_defconfig
> +++ b/arch/arm/configs/am3517_evm_defconfig
> @@ -1,13 +1,14 @@
>  #
>  # Automatically generated make config: don't edit
> -# Linux kernel version: 2.6.32-rc5
> -# Wed Oct 28 15:47:47 2009
> +# Linux kernel version: 2.6.34-rc3
> +# Wed Apr 14 16:07:52 2010
>  #
>  CONFIG_ARM=y
>  CONFIG_SYS_SUPPORTS_APM_EMULATION=y
>  CONFIG_GENERIC_GPIO=y
>  CONFIG_GENERIC_TIME=y
>  CONFIG_GENERIC_CLOCKEVENTS=y
> +CONFIG_HAVE_PROC_CPU=y
>  CONFIG_GENERIC_HARDIRQS=y
>  CONFIG_STACKTRACE_SUPPORT=y
>  CONFIG_HAVE_LATENCYTOP_SUPPORT=y
> @@ -19,7 +20,9 @@ CONFIG_RWSEM_GENERIC_SPINLOCK=y
>  CONFIG_ARCH_HAS_CPUFREQ=y
>  CONFIG_GENERIC_HWEIGHT=y
>  CONFIG_GENERIC_CALIBRATE_DELAY=y
> +CONFIG_NEED_DMA_MAP_STATE=y
>  CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
> +CONFIG_ARM_L1_CACHE_SHIFT_6=y
>  CONFIG_VECTORS_BASE=0xffff0000
>  CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
>  CONFIG_CONSTRUCTORS=y
> @@ -32,6 +35,12 @@ CONFIG_BROKEN_ON_SMP=y
>  CONFIG_INIT_ENV_ARG_LIMIT=32
>  CONFIG_LOCALVERSION=""
>  CONFIG_LOCALVERSION_AUTO=y
> +CONFIG_HAVE_KERNEL_GZIP=y
> +CONFIG_HAVE_KERNEL_LZO=y
> +CONFIG_KERNEL_GZIP=y
> +# CONFIG_KERNEL_BZIP2 is not set
> +# CONFIG_KERNEL_LZMA is not set
> +# CONFIG_KERNEL_LZO is not set
>  CONFIG_SWAP=y
>  CONFIG_SYSVIPC=y
>  CONFIG_SYSVIPC_SYSCTL=y
> @@ -46,17 +55,13 @@ CONFIG_BSD_PROCESS_ACCT=y
>  #
>  CONFIG_TREE_RCU=y
>  # CONFIG_TREE_PREEMPT_RCU is not set
> +# CONFIG_TINY_RCU is not set
>  # CONFIG_RCU_TRACE is not set
>  CONFIG_RCU_FANOUT=32
>  # CONFIG_RCU_FANOUT_EXACT is not set
>  # CONFIG_TREE_RCU_TRACE is not set
>  # CONFIG_IKCONFIG is not set
>  CONFIG_LOG_BUF_SHIFT=14
> -CONFIG_GROUP_SCHED=y
> -CONFIG_FAIR_GROUP_SCHED=y
> -# CONFIG_RT_GROUP_SCHED is not set
> -CONFIG_USER_SCHED=y
> -# CONFIG_CGROUP_SCHED is not set
>  # CONFIG_CGROUPS is not set
>  CONFIG_SYSFS_DEPRECATED=y
>  CONFIG_SYSFS_DEPRECATED_V2=y
> @@ -67,6 +72,7 @@ CONFIG_INITRAMFS_SOURCE=""
>  CONFIG_RD_GZIP=y
>  # CONFIG_RD_BZIP2 is not set
>  # CONFIG_RD_LZMA is not set
> +# CONFIG_RD_LZO is not set
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  CONFIG_SYSCTL=y
>  CONFIG_ANON_INODES=y
> @@ -88,10 +94,14 @@ CONFIG_TIMERFD=y
>  CONFIG_EVENTFD=y
>  CONFIG_SHMEM=y
>  CONFIG_AIO=y
> +CONFIG_HAVE_PERF_EVENTS=y
> +CONFIG_PERF_USE_VMALLOC=y
>
>  #
>  # Kernel Performance Events And Counters
>  #
> +# CONFIG_PERF_EVENTS is not set
> +# CONFIG_PERF_COUNTERS is not set
>  CONFIG_VM_EVENT_COUNTERS=y
>  CONFIG_COMPAT_BRK=y
>  CONFIG_SLAB=y
> @@ -127,14 +137,41 @@ CONFIG_LBDAF=y
>  # IO Schedulers
>  #
>  CONFIG_IOSCHED_NOOP=y
> -CONFIG_IOSCHED_AS=y
>  CONFIG_IOSCHED_DEADLINE=y
>  CONFIG_IOSCHED_CFQ=y
> -CONFIG_DEFAULT_AS=y
>  # CONFIG_DEFAULT_DEADLINE is not set
> -# CONFIG_DEFAULT_CFQ is not set
> +CONFIG_DEFAULT_CFQ=y
>  # CONFIG_DEFAULT_NOOP is not set
> -CONFIG_DEFAULT_IOSCHED="anticipatory"
> +CONFIG_DEFAULT_IOSCHED="cfq"
> +# CONFIG_INLINE_SPIN_TRYLOCK is not set
> +# CONFIG_INLINE_SPIN_TRYLOCK_BH is not set
> +# CONFIG_INLINE_SPIN_LOCK is not set
> +# CONFIG_INLINE_SPIN_LOCK_BH is not set
> +# CONFIG_INLINE_SPIN_LOCK_IRQ is not set
> +# CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
> +CONFIG_INLINE_SPIN_UNLOCK=y
> +# CONFIG_INLINE_SPIN_UNLOCK_BH is not set
> +CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
> +# CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
> +# CONFIG_INLINE_READ_TRYLOCK is not set
> +# CONFIG_INLINE_READ_LOCK is not set
> +# CONFIG_INLINE_READ_LOCK_BH is not set
> +# CONFIG_INLINE_READ_LOCK_IRQ is not set
> +# CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
> +CONFIG_INLINE_READ_UNLOCK=y
> +# CONFIG_INLINE_READ_UNLOCK_BH is not set
> +CONFIG_INLINE_READ_UNLOCK_IRQ=y
> +# CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
> +# CONFIG_INLINE_WRITE_TRYLOCK is not set
> +# CONFIG_INLINE_WRITE_LOCK is not set
> +# CONFIG_INLINE_WRITE_LOCK_BH is not set
> +# CONFIG_INLINE_WRITE_LOCK_IRQ is not set
> +# CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
> +CONFIG_INLINE_WRITE_UNLOCK=y
> +# CONFIG_INLINE_WRITE_UNLOCK_BH is not set
> +CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
> +# CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
> +# CONFIG_MUTEX_SPIN_ON_OWNER is not set
>  # CONFIG_FREEZER is not set
>
>  #
> @@ -146,6 +183,7 @@ CONFIG_MMU=y
>  # CONFIG_ARCH_REALVIEW is not set
>  # CONFIG_ARCH_VERSATILE is not set
>  # CONFIG_ARCH_AT91 is not set
> +# CONFIG_ARCH_BCMRING is not set
>  # CONFIG_ARCH_CLPS711X is not set
>  # CONFIG_ARCH_GEMINI is not set
>  # CONFIG_ARCH_EBSA110 is not set
> @@ -155,7 +193,6 @@ CONFIG_MMU=y
>  # CONFIG_ARCH_STMP3XXX is not set
>  # CONFIG_ARCH_NETX is not set
>  # CONFIG_ARCH_H720X is not set
> -# CONFIG_ARCH_NOMADIK is not set
>  # CONFIG_ARCH_IOP13XX is not set
>  # CONFIG_ARCH_IOP32X is not set
>  # CONFIG_ARCH_IOP33X is not set
> @@ -163,6 +200,7 @@ CONFIG_MMU=y
>  # CONFIG_ARCH_IXP2000 is not set
>  # CONFIG_ARCH_IXP4XX is not set
>  # CONFIG_ARCH_L7200 is not set
> +# CONFIG_ARCH_DOVE is not set
>  # CONFIG_ARCH_KIRKWOOD is not set
>  # CONFIG_ARCH_LOKI is not set
>  # CONFIG_ARCH_MV78XX0 is not set
> @@ -171,26 +209,33 @@ CONFIG_MMU=y
>  # CONFIG_ARCH_KS8695 is not set
>  # CONFIG_ARCH_NS9XXX is not set
>  # CONFIG_ARCH_W90X900 is not set
> +# CONFIG_ARCH_NUC93X is not set
>  # CONFIG_ARCH_PNX4008 is not set
>  # CONFIG_ARCH_PXA is not set
>  # CONFIG_ARCH_MSM is not set
> +# CONFIG_ARCH_SHMOBILE is not set
>  # CONFIG_ARCH_RPC is not set
>  # CONFIG_ARCH_SA1100 is not set
>  # CONFIG_ARCH_S3C2410 is not set
>  # CONFIG_ARCH_S3C64XX is not set
> +# CONFIG_ARCH_S5P6440 is not set
> +# CONFIG_ARCH_S5P6442 is not set
>  # CONFIG_ARCH_S5PC1XX is not set
> +# CONFIG_ARCH_S5PV210 is not set
>  # CONFIG_ARCH_SHARK is not set
>  # CONFIG_ARCH_LH7A40X is not set
>  # CONFIG_ARCH_U300 is not set
> +# CONFIG_ARCH_U8500 is not set
> +# CONFIG_ARCH_NOMADIK is not set
>  # CONFIG_ARCH_DAVINCI is not set
>  CONFIG_ARCH_OMAP=y
> -# CONFIG_ARCH_BCMRING is not set
>
>  #
>  # TI OMAP Implementations
>  #
>  CONFIG_ARCH_OMAP_OTG=y
>  # CONFIG_ARCH_OMAP1 is not set
> +CONFIG_ARCH_OMAP2PLUS=y
>  # CONFIG_ARCH_OMAP2 is not set
>  CONFIG_ARCH_OMAP3=y
>  # CONFIG_ARCH_OMAP4 is not set
> @@ -198,37 +243,41 @@ CONFIG_ARCH_OMAP3=y
>  #
>  # OMAP Feature Selections
>  #
> -# CONFIG_OMAP_DEBUG_POWERDOMAIN is not set
> -# CONFIG_OMAP_DEBUG_CLOCKDOMAIN is not set
>  CONFIG_OMAP_RESET_CLOCKS=y
>  CONFIG_OMAP_MUX=y
> -# CONFIG_OMAP_MCBSP is not set
> +# CONFIG_OMAP_MUX_DEBUG is not set
> +CONFIG_OMAP_MUX_WARNINGS=y
> +CONFIG_OMAP_MCBSP=y
>  # CONFIG_OMAP_MBOX_FWK is not set
>  # CONFIG_OMAP_MPU_TIMER is not set
>  CONFIG_OMAP_32K_TIMER=y
>  CONFIG_OMAP_32K_TIMER_HZ=128
>  CONFIG_OMAP_DM_TIMER=y
> -# CONFIG_OMAP_LL_DEBUG_UART1 is not set
> -# CONFIG_OMAP_LL_DEBUG_UART2 is not set
> -CONFIG_OMAP_LL_DEBUG_UART3=y
>  # CONFIG_OMAP_PM_NONE is not set
>  CONFIG_OMAP_PM_NOOP=y
> -CONFIG_ARCH_OMAP34XX=y
>  CONFIG_ARCH_OMAP3430=y
> +CONFIG_OMAP_PACKAGE_CBB=y
>
>  #
>  # OMAP Board Type
>  #
>  # CONFIG_MACH_OMAP3_BEAGLE is not set
> +# CONFIG_MACH_DEVKIT8000 is not set
>  # CONFIG_MACH_OMAP_LDP is not set
>  # CONFIG_MACH_OVERO is not set
>  # CONFIG_MACH_OMAP3EVM is not set
>  CONFIG_MACH_OMAP3517EVM=y
>  # CONFIG_MACH_OMAP3_PANDORA is not set
> +# CONFIG_MACH_OMAP3_TOUCHBOOK is not set
>  # CONFIG_MACH_OMAP_3430SDP is not set
>  # CONFIG_MACH_NOKIA_RX51 is not set
>  # CONFIG_MACH_OMAP_ZOOM2 is not set
> +# CONFIG_MACH_OMAP_ZOOM3 is not set
>  # CONFIG_MACH_CM_T35 is not set
> +# CONFIG_MACH_IGEP0020 is not set
> +# CONFIG_MACH_OMAP_3630SDP is not set
> +# CONFIG_OMAP3_EMU is not set
> +# CONFIG_OMAP3_SDRC_AC_TIMING is not set
>
>  #
>  # Processor Type
> @@ -256,6 +305,7 @@ CONFIG_ARM_THUMB=y
>  # CONFIG_CPU_BPREDICT_DISABLE is not set
>  CONFIG_HAS_TLS_REG=y
>  CONFIG_ARM_L1_CACHE_SHIFT=6
> +CONFIG_CPU_HAS_PMU=y
>  # CONFIG_ARM_ERRATA_430973 is not set
>  # CONFIG_ARM_ERRATA_458693 is not set
>  # CONFIG_ARM_ERRATA_460075 is not set
> @@ -286,6 +336,7 @@ CONFIG_HZ=128
>  # CONFIG_THUMB2_KERNEL is not set
>  CONFIG_AEABI=y
>  CONFIG_OABI_COMPAT=y
> +CONFIG_ARCH_HAS_HOLES_MEMORYMODEL=y
>  # CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
>  # CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
>  # CONFIG_HIGHMEM is not set
> @@ -300,8 +351,6 @@ CONFIG_SPLIT_PTLOCK_CPUS=4
>  # CONFIG_PHYS_ADDR_T_64BIT is not set
>  CONFIG_ZONE_DMA_FLAG=0
>  CONFIG_VIRT_TO_BUS=y
> -CONFIG_HAVE_MLOCK=y
> -CONFIG_HAVE_MLOCKED_PAGE_BIT=y
>  # CONFIG_KSM is not set
>  CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
>  # CONFIG_LEDS is not set
> @@ -357,7 +406,6 @@ CONFIG_NET=y
>  # Networking options
>  #
>  CONFIG_PACKET=y
> -# CONFIG_PACKET_MMAP is not set
>  CONFIG_UNIX=y
>  CONFIG_XFRM=y
>  # CONFIG_XFRM_USER is not set
> @@ -428,9 +476,6 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
>  # CONFIG_AF_RXRPC is not set
>  CONFIG_WIRELESS=y
>  # CONFIG_CFG80211 is not set
> -CONFIG_CFG80211_DEFAULT_PS_VALUE=0
> -# CONFIG_WIRELESS_OLD_REGULATORY is not set
> -# CONFIG_WIRELESS_EXT is not set
>  # CONFIG_LIB80211 is not set
>
>  #
> @@ -456,12 +501,104 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
>  # CONFIG_DEBUG_DEVRES is not set
>  # CONFIG_SYS_HYPERVISOR is not set
>  # CONFIG_CONNECTOR is not set
> -# CONFIG_MTD is not set
> +CONFIG_MTD=y
> +# CONFIG_MTD_DEBUG is not set
> +CONFIG_MTD_TESTS=m
> +# CONFIG_MTD_CONCAT is not set
> +CONFIG_MTD_PARTITIONS=y
> +# CONFIG_MTD_REDBOOT_PARTS is not set
> +# CONFIG_MTD_CMDLINE_PARTS is not set
> +# CONFIG_MTD_AFS_PARTS is not set
> +# CONFIG_MTD_AR7_PARTS is not set
> +
> +#
> +# User Modules And Translation Layers
> +#
> +CONFIG_MTD_CHAR=y
> +CONFIG_MTD_BLKDEVS=y
> +CONFIG_MTD_BLOCK=y
> +# CONFIG_FTL is not set
> +# CONFIG_NFTL is not set
> +# CONFIG_INFTL is not set
> +# CONFIG_RFD_FTL is not set
> +# CONFIG_SSFDC is not set
> +# CONFIG_MTD_OOPS is not set
> +
> +#
> +# RAM/ROM/Flash chip drivers
> +#
> +# CONFIG_MTD_CFI is not set
> +# CONFIG_MTD_JEDECPROBE is not set
> +CONFIG_MTD_MAP_BANK_WIDTH_1=y
> +CONFIG_MTD_MAP_BANK_WIDTH_2=y
> +CONFIG_MTD_MAP_BANK_WIDTH_4=y
> +# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
> +# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
> +# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
> +CONFIG_MTD_CFI_I1=y
> +CONFIG_MTD_CFI_I2=y
> +# CONFIG_MTD_CFI_I4 is not set
> +# CONFIG_MTD_CFI_I8 is not set
> +# CONFIG_MTD_RAM is not set
> +# CONFIG_MTD_ROM is not set
> +# CONFIG_MTD_ABSENT is not set
> +
> +#
> +# Mapping drivers for chip access
> +#
> +# CONFIG_MTD_COMPLEX_MAPPINGS is not set
> +# CONFIG_MTD_PLATRAM is not set
> +
> +#
> +# Self-contained MTD device drivers
> +#
> +# CONFIG_MTD_DATAFLASH is not set
> +# CONFIG_MTD_M25P80 is not set
> +# CONFIG_MTD_SST25L is not set
> +# CONFIG_MTD_SLRAM is not set
> +# CONFIG_MTD_PHRAM is not set
> +# CONFIG_MTD_MTDRAM is not set
> +# CONFIG_MTD_BLOCK2MTD is not set
> +
> +#
> +# Disk-On-Chip Device Drivers
> +#
> +# CONFIG_MTD_DOC2000 is not set
> +# CONFIG_MTD_DOC2001 is not set
> +# CONFIG_MTD_DOC2001PLUS is not set
> +CONFIG_MTD_NAND=y
> +# CONFIG_MTD_NAND_VERIFY_WRITE is not set
> +# CONFIG_MTD_NAND_ECC_SMC is not set
> +# CONFIG_MTD_NAND_MUSEUM_IDS is not set
> +# CONFIG_MTD_NAND_GPIO is not set
> +CONFIG_MTD_NAND_OMAP2=y
> +CONFIG_MTD_NAND_OMAP_PREFETCH=y
> +CONFIG_MTD_NAND_OMAP_PREFETCH_DMA=y
> +CONFIG_MTD_NAND_IDS=y
> +# CONFIG_MTD_NAND_DISKONCHIP is not set
> +# CONFIG_MTD_NAND_NANDSIM is not set
> +# CONFIG_MTD_NAND_PLATFORM is not set
> +# CONFIG_MTD_ALAUDA is not set
> +# CONFIG_MTD_ONENAND is not set
> +
> +#
> +# LPDDR flash memory drivers
> +#
> +# CONFIG_MTD_LPDDR is not set
> +
> +#
> +# UBI - Unsorted block images
> +#
> +# CONFIG_MTD_UBI is not set
>  # CONFIG_PARPORT is not set
>  CONFIG_BLK_DEV=y
>  # CONFIG_BLK_DEV_COW_COMMON is not set
>  CONFIG_BLK_DEV_LOOP=y
>  # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> +
> +#
> +# DRBD disabled because PROC_FS, INET or CONNECTOR not selected
> +#
>  # CONFIG_BLK_DEV_NBD is not set
>  # CONFIG_BLK_DEV_UB is not set
>  CONFIG_BLK_DEV_RAM=y
> @@ -478,6 +615,7 @@ CONFIG_HAVE_IDE=y
>  #
>  # SCSI device support
>  #
> +CONFIG_SCSI_MOD=y
>  # CONFIG_RAID_ATTRS is not set
>  CONFIG_SCSI=y
>  CONFIG_SCSI_DMA=y
> @@ -517,7 +655,77 @@ CONFIG_SCSI_LOWLEVEL=y
>  # CONFIG_SCSI_OSD_INITIATOR is not set
>  # CONFIG_ATA is not set
>  # CONFIG_MD is not set
> -# CONFIG_NETDEVICES is not set
> +CONFIG_NETDEVICES=y
> +# CONFIG_DUMMY is not set
> +# CONFIG_BONDING is not set
> +# CONFIG_MACVLAN is not set
> +# CONFIG_EQUALIZER is not set
> +# CONFIG_TUN is not set
> +# CONFIG_VETH is not set
> +CONFIG_PHYLIB=y
> +
> +#
> +# MII PHY device drivers
> +#
> +# CONFIG_MARVELL_PHY is not set
> +# CONFIG_DAVICOM_PHY is not set
> +# CONFIG_QSEMI_PHY is not set
> +# CONFIG_LXT_PHY is not set
> +# CONFIG_CICADA_PHY is not set
> +# CONFIG_VITESSE_PHY is not set
> +CONFIG_SMSC_PHY=y
> +# CONFIG_BROADCOM_PHY is not set
> +# CONFIG_ICPLUS_PHY is not set
> +# CONFIG_REALTEK_PHY is not set
> +# CONFIG_NATIONAL_PHY is not set
> +# CONFIG_STE10XP is not set
> +# CONFIG_LSI_ET1011C_PHY is not set
> +# CONFIG_FIXED_PHY is not set
> +# CONFIG_MDIO_BITBANG is not set
> +CONFIG_NET_ETHERNET=y
> +CONFIG_MII=y
> +# CONFIG_AX88796 is not set
> +# CONFIG_SMC91X is not set
> +CONFIG_TI_DAVINCI_EMAC=y
> +# CONFIG_DM9000 is not set
> +# CONFIG_ENC28J60 is not set
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
> +# CONFIG_KS8851 is not set
> +# CONFIG_KS8851_MLL is not set
> +# CONFIG_NETDEV_1000 is not set
> +# CONFIG_NETDEV_10000 is not set
> +# CONFIG_WLAN is not set
> +
> +#
> +# Enable WiMAX (Networking options) to see the WiMAX drivers
> +#
> +
> +#
> +# USB Network Adapters
> +#
> +# CONFIG_USB_CATC is not set
> +# CONFIG_USB_KAWETH is not set
> +# CONFIG_USB_PEGASUS is not set
> +# CONFIG_USB_RTL8150 is not set
> +# CONFIG_USB_USBNET is not set
> +# CONFIG_WAN is not set
> +# CONFIG_PPP is not set
> +# CONFIG_SLIP is not set
> +# CONFIG_NETCONSOLE is not set
> +# CONFIG_NETPOLL is not set
> +# CONFIG_NET_POLL_CONTROLLER is not set
>  # CONFIG_ISDN is not set
>  # CONFIG_PHONE is not set
>
> @@ -527,6 +735,7 @@ CONFIG_SCSI_LOWLEVEL=y
>  CONFIG_INPUT=y
>  # CONFIG_INPUT_FF_MEMLESS is not set
>  # CONFIG_INPUT_POLLDEV is not set
> +# CONFIG_INPUT_SPARSEKMAP is not set
>
>  #
>  # Userland interfaces
> @@ -579,8 +788,10 @@ CONFIG_SERIAL_8250_RSA=y
>  #
>  # Non-8250 serial port support
>  #
> +# CONFIG_SERIAL_MAX3100 is not set
>  CONFIG_SERIAL_CORE=y
>  CONFIG_SERIAL_CORE_CONSOLE=y
> +# CONFIG_SERIAL_TIMBERDALE is not set
>  CONFIG_UNIX98_PTYS=y
>  # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
>  # CONFIG_LEGACY_PTYS is not set
> @@ -595,6 +806,7 @@ CONFIG_I2C_BOARDINFO=y
>  CONFIG_I2C_COMPAT=y
>  CONFIG_I2C_CHARDEV=y
>  CONFIG_I2C_HELPER_AUTO=y
> +CONFIG_I2C_ALGOPCA=y
>
>  #
>  # I2C Hardware Bus support
> @@ -608,6 +820,7 @@ CONFIG_I2C_HELPER_AUTO=y
>  # CONFIG_I2C_OCORES is not set
>  CONFIG_I2C_OMAP=y
>  # CONFIG_I2C_SIMTEC is not set
> +# CONFIG_I2C_XILINX is not set
>
>  #
>  # External I2C/SMBus adapter drivers
> @@ -619,18 +832,29 @@ CONFIG_I2C_OMAP=y
>  #
>  # Other I2C/SMBus bus drivers
>  #
> -# CONFIG_I2C_PCA_PLATFORM is not set
> +CONFIG_I2C_PCA_PLATFORM=y
>  # CONFIG_I2C_STUB is not set
> +CONFIG_I2C_DEBUG_CORE=y
> +# CONFIG_I2C_DEBUG_ALGO is not set
> +CONFIG_I2C_DEBUG_BUS=y
> +CONFIG_SPI=y
> +# CONFIG_SPI_DEBUG is not set
> +CONFIG_SPI_MASTER=y
>
>  #
> -# Miscellaneous I2C Chip support
> +# SPI Master Controller Drivers
>  #
> -# CONFIG_SENSORS_TSL2550 is not set
> -# CONFIG_I2C_DEBUG_CORE is not set
> -# CONFIG_I2C_DEBUG_ALGO is not set
> -# CONFIG_I2C_DEBUG_BUS is not set
> -# CONFIG_I2C_DEBUG_CHIP is not set
> -# CONFIG_SPI is not set
> +# CONFIG_SPI_BITBANG is not set
> +# CONFIG_SPI_GPIO is not set
> +CONFIG_SPI_OMAP24XX=y
> +# CONFIG_SPI_XILINX is not set
> +# CONFIG_SPI_DESIGNWARE is not set
> +
> +#
> +# SPI Protocol Masters
> +#
> +# CONFIG_SPI_SPIDEV is not set
> +# CONFIG_SPI_TLE62X0 is not set
>
>  #
>  # PPS support
> @@ -644,10 +868,17 @@ CONFIG_GPIOLIB=y
>  #
>  # Memory mapped GPIO expanders:
>  #
> +# CONFIG_GPIO_IT8761E is not set
>
>  #
>  # I2C GPIO expanders:
>  #
> +# CONFIG_GPIO_MAX7300 is not set
> +# CONFIG_GPIO_MAX732X is not set
> +CONFIG_GPIO_PCA953X=y
> +# CONFIG_GPIO_PCA953X_IRQ is not set
> +# CONFIG_GPIO_PCF857X is not set
> +# CONFIG_GPIO_ADP5588 is not set
>
>  #
>  # PCI GPIO expanders:
> @@ -656,6 +887,9 @@ CONFIG_GPIOLIB=y
>  #
>  # SPI GPIO expanders:
>  #
> +# CONFIG_GPIO_MAX7301 is not set
> +# CONFIG_GPIO_MCP23S08 is not set
> +# CONFIG_GPIO_MC33880 is not set
>
>  #
>  # AC97 GPIO expanders:
> @@ -664,7 +898,20 @@ CONFIG_GPIOLIB=y
>  # CONFIG_POWER_SUPPLY is not set
>  # CONFIG_HWMON is not set
>  # CONFIG_THERMAL is not set
> -# CONFIG_WATCHDOG is not set
> +CONFIG_WATCHDOG=y
> +# CONFIG_WATCHDOG_NOWAYOUT is not set
> +
> +#
> +# Watchdog Device Drivers
> +#
> +# CONFIG_SOFT_WATCHDOG is not set
> +# CONFIG_MAX63XX_WATCHDOG is not set
> +CONFIG_OMAP_WATCHDOG=y
> +
> +#
> +# USB-based Watchdog Cards
> +#
> +# CONFIG_USBPCWATCHDOG is not set
>  CONFIG_SSB_POSSIBLE=y
>
>  #
> @@ -676,15 +923,43 @@ CONFIG_SSB_POSSIBLE=y
>  # Multifunction device drivers
>  #
>  # CONFIG_MFD_CORE is not set
> +# CONFIG_MFD_88PM860X is not set
>  # CONFIG_MFD_SM501 is not set
>  # CONFIG_MFD_ASIC3 is not set
>  # CONFIG_HTC_EGPIO is not set
>  # CONFIG_HTC_PASIC3 is not set
> +# CONFIG_HTC_I2CPLD is not set
> +# CONFIG_TPS65010 is not set
> +# CONFIG_TWL4030_CORE is not set
>  # CONFIG_MFD_TMIO is not set
>  # CONFIG_MFD_T7L66XB is not set
>  # CONFIG_MFD_TC6387XB is not set
>  # CONFIG_MFD_TC6393XB is not set
> -# CONFIG_REGULATOR is not set
> +# CONFIG_PMIC_DA903X is not set
> +# CONFIG_PMIC_ADP5520 is not set
> +# CONFIG_MFD_MAX8925 is not set
> +# CONFIG_MFD_WM8400 is not set
> +# CONFIG_MFD_WM831X is not set
> +# CONFIG_MFD_WM8350_I2C is not set
> +# CONFIG_MFD_WM8994 is not set
> +# CONFIG_MFD_PCF50633 is not set
> +# CONFIG_MFD_MC13783 is not set
> +# CONFIG_AB3100_CORE is not set
> +# CONFIG_EZX_PCAP is not set
> +# CONFIG_AB4500_CORE is not set
> +CONFIG_REGULATOR=y
> +# CONFIG_REGULATOR_DEBUG is not set
> +# CONFIG_REGULATOR_DUMMY is not set
> +# CONFIG_REGULATOR_FIXED_VOLTAGE is not set
> +# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
> +# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
> +# CONFIG_REGULATOR_BQ24022 is not set
> +# CONFIG_REGULATOR_MAX1586 is not set
> +# CONFIG_REGULATOR_MAX8649 is not set
> +# CONFIG_REGULATOR_MAX8660 is not set
> +# CONFIG_REGULATOR_LP3971 is not set
> +CONFIG_REGULATOR_TPS65023=y
> +# CONFIG_REGULATOR_TPS6507X is not set
>  # CONFIG_MEDIA_SUPPORT is not set
>
>  #
> @@ -692,7 +967,58 @@ CONFIG_SSB_POSSIBLE=y
>  #
>  # CONFIG_VGASTATE is not set
>  # CONFIG_VIDEO_OUTPUT_CONTROL is not set
> -# CONFIG_FB is not set
> +CONFIG_FB=y
> +# CONFIG_FIRMWARE_EDID is not set
> +# CONFIG_FB_DDC is not set
> +# CONFIG_FB_BOOT_VESA_SUPPORT is not set
> +CONFIG_FB_CFB_FILLRECT=y
> +CONFIG_FB_CFB_COPYAREA=y
> +CONFIG_FB_CFB_IMAGEBLIT=y
> +# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
> +# CONFIG_FB_SYS_FILLRECT is not set
> +# CONFIG_FB_SYS_COPYAREA is not set
> +# CONFIG_FB_SYS_IMAGEBLIT is not set
> +# CONFIG_FB_FOREIGN_ENDIAN is not set
> +# CONFIG_FB_SYS_FOPS is not set
> +# CONFIG_FB_SVGALIB is not set
> +# CONFIG_FB_MACMODES is not set
> +# CONFIG_FB_BACKLIGHT is not set
> +# CONFIG_FB_MODE_HELPERS is not set
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
> +# CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
> +CONFIG_OMAP2_VRAM=y
> +CONFIG_OMAP2_VRFB=y
> +CONFIG_OMAP2_DSS=y
> +CONFIG_OMAP2_VRAM_SIZE=4
> +CONFIG_OMAP2_DSS_DEBUG_SUPPORT=y
> +# CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS is not set
> +# CONFIG_OMAP2_DSS_RFBI is not set
> +CONFIG_OMAP2_DSS_VENC=y
> +# CONFIG_OMAP2_DSS_SDI is not set
> +# CONFIG_OMAP2_DSS_DSI is not set
> +# CONFIG_OMAP2_DSS_FAKE_VSYNC is not set
> +CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=4
> +CONFIG_FB_OMAP2=y
> +CONFIG_FB_OMAP2_DEBUG_SUPPORT=y
> +CONFIG_FB_OMAP2_NUM_FBS=3
> +
> +#
> +# OMAP2/3 Display Device Drivers
> +#
> +CONFIG_PANEL_GENERIC=y
> +# CONFIG_PANEL_SHARP_LS037V7DW01 is not set
> +CONFIG_PANEL_SHARP_LQ043T1DG01=y
> +# CONFIG_PANEL_TOPPOLY_TDO35S is not set
> +# CONFIG_PANEL_TPO_TD043MTEA1 is not set
>  # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
>
>  #
> @@ -705,47 +1031,52 @@ CONFIG_SSB_POSSIBLE=y
>  #
>  # CONFIG_VGA_CONSOLE is not set
>  CONFIG_DUMMY_CONSOLE=y
> -# CONFIG_SOUND is not set
> -CONFIG_HID_SUPPORT=y
> -CONFIG_HID=y
> -# CONFIG_HIDRAW is not set
> -
> -#
> -# USB Input Devices
> -#
> -CONFIG_USB_HID=y
> -# CONFIG_HID_PID is not set
> -# CONFIG_USB_HIDDEV is not set
> -
> -#
> -# Special HID drivers
> -#
> -# CONFIG_HID_A4TECH is not set
> -# CONFIG_HID_APPLE is not set
> -# CONFIG_HID_BELKIN is not set
> -# CONFIG_HID_CHERRY is not set
> -# CONFIG_HID_CHICONY is not set
> -# CONFIG_HID_CYPRESS is not set
> -# CONFIG_HID_DRAGONRISE is not set
> -# CONFIG_HID_EZKEY is not set
> -# CONFIG_HID_KYE is not set
> -# CONFIG_HID_GYRATION is not set
> -# CONFIG_HID_TWINHAN is not set
> -# CONFIG_HID_KENSINGTON is not set
> -# CONFIG_HID_LOGITECH is not set
> -# CONFIG_HID_MICROSOFT is not set
> -# CONFIG_HID_MONTEREY is not set
> -# CONFIG_HID_NTRIG is not set
> -# CONFIG_HID_PANTHERLORD is not set
> -# CONFIG_HID_PETALYNX is not set
> -# CONFIG_HID_SAMSUNG is not set
> -# CONFIG_HID_SONY is not set
> -# CONFIG_HID_SUNPLUS is not set
> -# CONFIG_HID_GREENASIA is not set
> -# CONFIG_HID_SMARTJOYPLUS is not set
> -# CONFIG_HID_TOPSEED is not set
> -# CONFIG_HID_THRUSTMASTER is not set
> -# CONFIG_HID_ZEROPLUS is not set
> +CONFIG_FRAMEBUFFER_CONSOLE=y
> +# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
> +# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
> +# CONFIG_FONTS is not set
> +CONFIG_FONT_8x8=y
> +CONFIG_FONT_8x16=y
> +CONFIG_LOGO=y
> +CONFIG_LOGO_LINUX_MONO=y
> +CONFIG_LOGO_LINUX_VGA16=y
> +CONFIG_LOGO_LINUX_CLUT224=y
> +CONFIG_SOUND=y
> +# CONFIG_SOUND_OSS_CORE is not set
> +CONFIG_SND=y
> +CONFIG_SND_TIMER=y
> +CONFIG_SND_PCM=y
> +CONFIG_SND_JACK=y
> +# CONFIG_SND_SEQUENCER is not set
> +# CONFIG_SND_MIXER_OSS is not set
> +# CONFIG_SND_PCM_OSS is not set
> +# CONFIG_SND_HRTIMER is not set
> +# CONFIG_SND_DYNAMIC_MINORS is not set
> +CONFIG_SND_SUPPORT_OLD_API=y
> +CONFIG_SND_VERBOSE_PROCFS=y
> +# CONFIG_SND_VERBOSE_PRINTK is not set
> +# CONFIG_SND_DEBUG is not set
> +# CONFIG_SND_RAWMIDI_SEQ is not set
> +# CONFIG_SND_OPL3_LIB_SEQ is not set
> +# CONFIG_SND_OPL4_LIB_SEQ is not set
> +# CONFIG_SND_SBAWE_SEQ is not set
> +# CONFIG_SND_EMU10K1_SEQ is not set
> +# CONFIG_SND_DRIVERS is not set
> +# CONFIG_SND_ARM is not set
> +CONFIG_SND_SPI=y
> +CONFIG_SND_USB=y
> +# CONFIG_SND_USB_AUDIO is not set
> +# CONFIG_SND_USB_UA101 is not set
> +# CONFIG_SND_USB_CAIAQ is not set
> +CONFIG_SND_SOC=y
> +CONFIG_SND_OMAP_SOC=y
> +CONFIG_SND_OMAP_SOC_MCBSP=y
> +CONFIG_SND_OMAP_SOC_AM3517EVM=y
> +CONFIG_SND_SOC_I2C_AND_SPI=y
> +# CONFIG_SND_SOC_ALL_CODECS is not set
> +CONFIG_SND_SOC_TLV320AIC23=y
> +# CONFIG_SOUND_PRIME is not set
> +# CONFIG_HID_SUPPORT is not set
>  CONFIG_USB_SUPPORT=y
>  CONFIG_USB_ARCH_HAS_HCD=y
>  CONFIG_USB_ARCH_HAS_OHCI=y
> @@ -760,7 +1091,6 @@ CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
>  # CONFIG_USB_DEVICEFS is not set
>  # CONFIG_USB_DEVICE_CLASS is not set
>  # CONFIG_USB_DYNAMIC_MINORS is not set
> -# CONFIG_USB_OTG is not set
>  # CONFIG_USB_OTG_WHITELIST is not set
>  # CONFIG_USB_OTG_BLACKLIST_HUB is not set
>  # CONFIG_USB_MON is not set
> @@ -835,7 +1165,6 @@ CONFIG_USB_STORAGE=y
>  # CONFIG_USB_RIO500 is not set
>  # CONFIG_USB_LEGOTOWER is not set
>  # CONFIG_USB_LCD is not set
> -# CONFIG_USB_BERRY_CHARGE is not set
>  # CONFIG_USB_LED is not set
>  # CONFIG_USB_CYPRESS_CY7C63 is not set
>  # CONFIG_USB_CYTHERM is not set
> @@ -848,20 +1177,103 @@ CONFIG_USB_STORAGE=y
>  # CONFIG_USB_IOWARRIOR is not set
>  # CONFIG_USB_TEST is not set
>  # CONFIG_USB_ISIGHTFW is not set
> -# CONFIG_USB_VST is not set
>  # CONFIG_USB_GADGET is not set
>
>  #
>  # OTG and related infrastructure
>  #
>  # CONFIG_USB_GPIO_VBUS is not set
> +# CONFIG_ISP1301_OMAP is not set
> +# CONFIG_USB_ULPI is not set
>  # CONFIG_NOP_USB_XCEIV is not set
> -# CONFIG_MMC is not set
> +CONFIG_MMC=y
> +# CONFIG_MMC_DEBUG is not set
> +# CONFIG_MMC_UNSAFE_RESUME is not set
> +
> +#
> +# MMC/SD/SDIO Card Drivers
> +#
> +CONFIG_MMC_BLOCK=y
> +CONFIG_MMC_BLOCK_BOUNCE=y
> +# CONFIG_SDIO_UART is not set
> +# CONFIG_MMC_TEST is not set
> +
> +#
> +# MMC/SD/SDIO Host Controller Drivers
> +#
> +# CONFIG_MMC_SDHCI is not set
> +# CONFIG_MMC_OMAP is not set
> +CONFIG_MMC_OMAP_HS=y
> +# CONFIG_MMC_SPI is not set
>  # CONFIG_MEMSTICK is not set
>  # CONFIG_NEW_LEDS is not set
>  # CONFIG_ACCESSIBILITY is not set
>  CONFIG_RTC_LIB=y
> -# CONFIG_RTC_CLASS is not set
> +CONFIG_RTC_CLASS=y
> +CONFIG_RTC_HCTOSYS=y
> +CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
> +# CONFIG_RTC_DEBUG is not set
> +
> +#
> +# RTC interfaces
> +#
> +CONFIG_RTC_INTF_SYSFS=y
> +CONFIG_RTC_INTF_PROC=y
> +CONFIG_RTC_INTF_DEV=y
> +# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> +# CONFIG_RTC_DRV_TEST is not set
> +
> +#
> +# I2C RTC drivers
> +#
> +# CONFIG_RTC_DRV_DS1307 is not set
> +# CONFIG_RTC_DRV_DS1374 is not set
> +# CONFIG_RTC_DRV_DS1672 is not set
> +# CONFIG_RTC_DRV_MAX6900 is not set
> +# CONFIG_RTC_DRV_RS5C372 is not set
> +# CONFIG_RTC_DRV_ISL1208 is not set
> +# CONFIG_RTC_DRV_X1205 is not set
> +# CONFIG_RTC_DRV_PCF8563 is not set
> +# CONFIG_RTC_DRV_PCF8583 is not set
> +# CONFIG_RTC_DRV_M41T80 is not set
> +# CONFIG_RTC_DRV_BQ32K is not set
> +CONFIG_RTC_DRV_S35390A=y
> +# CONFIG_RTC_DRV_FM3130 is not set
> +# CONFIG_RTC_DRV_RX8581 is not set
> +# CONFIG_RTC_DRV_RX8025 is not set
> +
> +#
> +# SPI RTC drivers
> +#
> +# CONFIG_RTC_DRV_M41T94 is not set
> +# CONFIG_RTC_DRV_DS1305 is not set
> +# CONFIG_RTC_DRV_DS1390 is not set
> +# CONFIG_RTC_DRV_MAX6902 is not set
> +# CONFIG_RTC_DRV_R9701 is not set
> +# CONFIG_RTC_DRV_RS5C348 is not set
> +# CONFIG_RTC_DRV_DS3234 is not set
> +# CONFIG_RTC_DRV_PCF2123 is not set
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
> +# CONFIG_RTC_DRV_MSM6242 is not set
> +# CONFIG_RTC_DRV_BQ4802 is not set
> +# CONFIG_RTC_DRV_RP5C01 is not set
> +# CONFIG_RTC_DRV_V3020 is not set
> +
> +#
> +# on-CPU RTC drivers
> +#
>  # CONFIG_DMADEVICES is not set
>  # CONFIG_AUXDISPLAY is not set
>  # CONFIG_UIO is not set
> @@ -872,6 +1284,11 @@ CONFIG_RTC_LIB=y
>  # CONFIG_STAGING is not set
>
>  #
> +# CBUS support
> +#
> +# CONFIG_CBUS is not set
> +
> +#
>  # File systems
>  #
>  CONFIG_EXT2_FS=y
> @@ -946,6 +1363,8 @@ CONFIG_MISC_FILESYSTEMS=y
>  # CONFIG_BEFS_FS is not set
>  # CONFIG_BFS_FS is not set
>  # CONFIG_EFS_FS is not set
> +# CONFIG_JFFS2_FS is not set
> +# CONFIG_LOGFS is not set
>  # CONFIG_CRAMFS is not set
>  # CONFIG_SQUASHFS is not set
>  # CONFIG_VXFS_FS is not set
> @@ -972,6 +1391,7 @@ CONFIG_SUNRPC_GSS=y
>  CONFIG_RPCSEC_GSS_KRB5=y
>  # CONFIG_RPCSEC_GSS_SPKM3 is not set
>  # CONFIG_SMB_FS is not set
> +# CONFIG_CEPH_FS is not set
>  # CONFIG_CIFS is not set
>  # CONFIG_NCP_FS is not set
>  # CONFIG_CODA_FS is not set
> @@ -1093,6 +1513,7 @@ CONFIG_DEBUG_INFO=y
>  # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
>  # CONFIG_FAULT_INJECTION is not set
>  # CONFIG_LATENCYTOP is not set
> +# CONFIG_SYSCTL_SYSCALL_CHECK is not set
>  # CONFIG_PAGE_POISONING is not set
>  CONFIG_HAVE_FUNCTION_TRACER=y
>  CONFIG_TRACING_SUPPORT=y
> @@ -1117,7 +1538,9 @@ CONFIG_ARM_UNWIND=y
>  # CONFIG_DEBUG_ERRORS is not set
>  # CONFIG_DEBUG_STACK_USAGE is not set
>  CONFIG_DEBUG_LL=y
> +# CONFIG_EARLY_PRINTK is not set
>  # CONFIG_DEBUG_ICEDCC is not set
> +# CONFIG_OC_ETM is not set
>
>  #
>  # Security options
> @@ -1125,7 +1548,11 @@ CONFIG_DEBUG_LL=y
>  # CONFIG_KEYS is not set
>  # CONFIG_SECURITY is not set
>  # CONFIG_SECURITYFS is not set
> -# CONFIG_SECURITY_FILE_CAPABILITIES is not set
> +# CONFIG_DEFAULT_SECURITY_SELINUX is not set
> +# CONFIG_DEFAULT_SECURITY_SMACK is not set
> +# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
> +CONFIG_DEFAULT_SECURITY_DAC=y
> +CONFIG_DEFAULT_SECURITY=""
>  CONFIG_CRYPTO=y
>
>  #
> --
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
