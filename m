From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCHv2 4/4] [OMAP] HTCHERALD: MMC, I2C, HTCPLD and related
	devices
Date: Tue, 1 Jun 2010 08:50:31 -0700
Message-ID: <AANLkTikm9XhZSp2P2qgH13KhoOblgOmbqz4-dbMoioF5@mail.gmail.com>
References: <1275110887-2918-1-git-send-email-darkstar6262@gmail.com>
	<1275406905-12200-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35513 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932122Ab0FAPuw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 11:50:52 -0400
Received: by pvg11 with SMTP id 11so1847223pvg.19
        for <linux-omap@vger.kernel.org>; Tue, 01 Jun 2010 08:50:51 -0700 (PDT)
In-Reply-To: <1275406905-12200-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Tue, Jun 1, 2010 at 8:41 AM, Cory Maccarrone <darkstar6262@gmail.com=
> wrote:
> This change adds in MMC and I2C support to the HTC Herald board, as w=
ell
> as adding the HTCPLD driver for the PLD used on this phone. =C2=A0It =
also
> adds in the gpio-keys entries for the front directional keys and
> selector and the cursor keys on the slide-out keyboard, and gpio-leds
> support for the LEDs attached to the htcpld.
>
> The Kconfig was also modified to add 64 GPIOs and IRQs to the default
> maximum number of each for the HTC herald. =C2=A0This is needed becau=
se the
> HTCPLD chip on this board exposes an additional 32 gpios and 16 irqs
> that would not fit in the default limits.
>
> The defconfig has been updated to reflect the changes.
>
> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
> ---
> =C2=A0arch/arm/configs/htcherald_defconfig =C2=A0| =C2=A0376 ++++++++=
+++++++++++++++++++++----
> =C2=A0arch/arm/mach-omap1/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 =C2=A02 +
> =C2=A0arch/arm/mach-omap1/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 =C2=A02 +-
> =C2=A0arch/arm/mach-omap1/board-htcherald.c | =C2=A0288 +++++++++++++=
+++++++++++-
> =C2=A04 files changed, 621 insertions(+), 47 deletions(-)
>
> diff --git a/arch/arm/configs/htcherald_defconfig b/arch/arm/configs/=
htcherald_defconfig
> index e0ef0d1..42deef6 100644
> --- a/arch/arm/configs/htcherald_defconfig
> +++ b/arch/arm/configs/htcherald_defconfig
> @@ -1,13 +1,15 @@
> =C2=A0#
> =C2=A0# Automatically generated make config: don't edit
> -# Linux kernel version: 2.6.32-rc8
> -# Sat Dec =C2=A05 12:16:24 2009
> +# Linux kernel version: 2.6.34
> +# Fri May 28 21:34:49 2010
> =C2=A0#
> =C2=A0CONFIG_ARM=3Dy
> =C2=A0CONFIG_SYS_SUPPORTS_APM_EMULATION=3Dy
> =C2=A0CONFIG_GENERIC_GPIO=3Dy
> =C2=A0CONFIG_GENERIC_TIME=3Dy
> +# CONFIG_ARCH_USES_GETTIMEOFFSET is not set
> =C2=A0CONFIG_GENERIC_CLOCKEVENTS=3Dy
> +CONFIG_HAVE_PROC_CPU=3Dy
> =C2=A0CONFIG_GENERIC_HARDIRQS=3Dy
> =C2=A0CONFIG_STACKTRACE_SUPPORT=3Dy
> =C2=A0CONFIG_HAVE_LATENCYTOP_SUPPORT=3Dy
> @@ -19,6 +21,7 @@ CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy
> =C2=A0CONFIG_ARCH_HAS_CPUFREQ=3Dy
> =C2=A0CONFIG_GENERIC_HWEIGHT=3Dy
> =C2=A0CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
> +CONFIG_NEED_DMA_MAP_STATE=3Dy
> =C2=A0CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=3Dy
> =C2=A0CONFIG_VECTORS_BASE=3D0xffff0000
> =C2=A0CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
> @@ -33,6 +36,13 @@ CONFIG_LOCK_KERNEL=3Dy
> =C2=A0CONFIG_INIT_ENV_ARG_LIMIT=3D32
> =C2=A0CONFIG_LOCALVERSION=3D""
> =C2=A0CONFIG_LOCALVERSION_AUTO=3Dy
> +CONFIG_HAVE_KERNEL_GZIP=3Dy
> +CONFIG_HAVE_KERNEL_LZMA=3Dy
> +CONFIG_HAVE_KERNEL_LZO=3Dy
> +CONFIG_KERNEL_GZIP=3Dy
> +# CONFIG_KERNEL_BZIP2 is not set
> +# CONFIG_KERNEL_LZMA is not set
> +# CONFIG_KERNEL_LZO is not set
> =C2=A0CONFIG_SWAP=3Dy
> =C2=A0CONFIG_SYSVIPC=3Dy
> =C2=A0CONFIG_SYSVIPC_SYSCTL=3Dy
> @@ -46,13 +56,13 @@ CONFIG_SYSVIPC_SYSCTL=3Dy
> =C2=A0#
> =C2=A0CONFIG_TREE_RCU=3Dy
> =C2=A0# CONFIG_TREE_PREEMPT_RCU is not set
> +# CONFIG_TINY_RCU is not set
> =C2=A0# CONFIG_RCU_TRACE is not set
> =C2=A0CONFIG_RCU_FANOUT=3D32
> =C2=A0# CONFIG_RCU_FANOUT_EXACT is not set
> =C2=A0# CONFIG_TREE_RCU_TRACE is not set
> =C2=A0# CONFIG_IKCONFIG is not set
> =C2=A0CONFIG_LOG_BUF_SHIFT=3D14
> -# CONFIG_GROUP_SCHED is not set
> =C2=A0# CONFIG_CGROUPS is not set
> =C2=A0# CONFIG_SYSFS_DEPRECATED_V2 is not set
> =C2=A0# CONFIG_RELAY is not set
> @@ -67,6 +77,7 @@ CONFIG_INITRAMFS_SOURCE=3D""
> =C2=A0CONFIG_RD_GZIP=3Dy
> =C2=A0CONFIG_RD_BZIP2=3Dy
> =C2=A0CONFIG_RD_LZMA=3Dy
> +CONFIG_RD_LZO=3Dy
> =C2=A0CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
> =C2=A0CONFIG_SYSCTL=3Dy
> =C2=A0CONFIG_ANON_INODES=3Dy
> @@ -87,10 +98,14 @@ CONFIG_TIMERFD=3Dy
> =C2=A0CONFIG_EVENTFD=3Dy
> =C2=A0CONFIG_SHMEM=3Dy
> =C2=A0CONFIG_AIO=3Dy
> +CONFIG_HAVE_PERF_EVENTS=3Dy
> +CONFIG_PERF_USE_VMALLOC=3Dy
>
> =C2=A0#
> =C2=A0# Kernel Performance Events And Counters
> =C2=A0#
> +# CONFIG_PERF_EVENTS is not set
> +# CONFIG_PERF_COUNTERS is not set
> =C2=A0CONFIG_VM_EVENT_COUNTERS=3Dy
> =C2=A0CONFIG_COMPAT_BRK=3Dy
> =C2=A0CONFIG_SLAB=3Dy
> @@ -126,14 +141,41 @@ CONFIG_LBDAF=3Dy
> =C2=A0# IO Schedulers
> =C2=A0#
> =C2=A0CONFIG_IOSCHED_NOOP=3Dy
> -CONFIG_IOSCHED_AS=3Dy
> =C2=A0CONFIG_IOSCHED_DEADLINE=3Dy
> =C2=A0CONFIG_IOSCHED_CFQ=3Dy
> -# CONFIG_DEFAULT_AS is not set
> =C2=A0# CONFIG_DEFAULT_DEADLINE is not set
> =C2=A0CONFIG_DEFAULT_CFQ=3Dy
> =C2=A0# CONFIG_DEFAULT_NOOP is not set
> =C2=A0CONFIG_DEFAULT_IOSCHED=3D"cfq"
> +# CONFIG_INLINE_SPIN_TRYLOCK is not set
> +# CONFIG_INLINE_SPIN_TRYLOCK_BH is not set
> +# CONFIG_INLINE_SPIN_LOCK is not set
> +# CONFIG_INLINE_SPIN_LOCK_BH is not set
> +# CONFIG_INLINE_SPIN_LOCK_IRQ is not set
> +# CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
> +# CONFIG_INLINE_SPIN_UNLOCK is not set
> +# CONFIG_INLINE_SPIN_UNLOCK_BH is not set
> +# CONFIG_INLINE_SPIN_UNLOCK_IRQ is not set
> +# CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
> +# CONFIG_INLINE_READ_TRYLOCK is not set
> +# CONFIG_INLINE_READ_LOCK is not set
> +# CONFIG_INLINE_READ_LOCK_BH is not set
> +# CONFIG_INLINE_READ_LOCK_IRQ is not set
> +# CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
> +# CONFIG_INLINE_READ_UNLOCK is not set
> +# CONFIG_INLINE_READ_UNLOCK_BH is not set
> +# CONFIG_INLINE_READ_UNLOCK_IRQ is not set
> +# CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
> +# CONFIG_INLINE_WRITE_TRYLOCK is not set
> +# CONFIG_INLINE_WRITE_LOCK is not set
> +# CONFIG_INLINE_WRITE_LOCK_BH is not set
> +# CONFIG_INLINE_WRITE_LOCK_IRQ is not set
> +# CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
> +# CONFIG_INLINE_WRITE_UNLOCK is not set
> +# CONFIG_INLINE_WRITE_UNLOCK_BH is not set
> +# CONFIG_INLINE_WRITE_UNLOCK_IRQ is not set
> +# CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
> +# CONFIG_MUTEX_SPIN_ON_OWNER is not set
> =C2=A0CONFIG_FREEZER=3Dy
>
> =C2=A0#
> @@ -144,8 +186,11 @@ CONFIG_MMU=3Dy
> =C2=A0# CONFIG_ARCH_INTEGRATOR is not set
> =C2=A0# CONFIG_ARCH_REALVIEW is not set
> =C2=A0# CONFIG_ARCH_VERSATILE is not set
> +# CONFIG_ARCH_VEXPRESS is not set
> =C2=A0# CONFIG_ARCH_AT91 is not set
> +# CONFIG_ARCH_BCMRING is not set
> =C2=A0# CONFIG_ARCH_CLPS711X is not set
> +# CONFIG_ARCH_CNS3XXX is not set
> =C2=A0# CONFIG_ARCH_GEMINI is not set
> =C2=A0# CONFIG_ARCH_EBSA110 is not set
> =C2=A0# CONFIG_ARCH_EP93XX is not set
> @@ -154,7 +199,6 @@ CONFIG_MMU=3Dy
> =C2=A0# CONFIG_ARCH_STMP3XXX is not set
> =C2=A0# CONFIG_ARCH_NETX is not set
> =C2=A0# CONFIG_ARCH_H720X is not set
> -# CONFIG_ARCH_NOMADIK is not set
> =C2=A0# CONFIG_ARCH_IOP13XX is not set
> =C2=A0# CONFIG_ARCH_IOP32X is not set
> =C2=A0# CONFIG_ARCH_IOP33X is not set
> @@ -162,6 +206,7 @@ CONFIG_MMU=3Dy
> =C2=A0# CONFIG_ARCH_IXP2000 is not set
> =C2=A0# CONFIG_ARCH_IXP4XX is not set
> =C2=A0# CONFIG_ARCH_L7200 is not set
> +# CONFIG_ARCH_DOVE is not set
> =C2=A0# CONFIG_ARCH_KIRKWOOD is not set
> =C2=A0# CONFIG_ARCH_LOKI is not set
> =C2=A0# CONFIG_ARCH_MV78XX0 is not set
> @@ -170,29 +215,38 @@ CONFIG_MMU=3Dy
> =C2=A0# CONFIG_ARCH_KS8695 is not set
> =C2=A0# CONFIG_ARCH_NS9XXX is not set
> =C2=A0# CONFIG_ARCH_W90X900 is not set
> +# CONFIG_ARCH_NUC93X is not set
> =C2=A0# CONFIG_ARCH_PNX4008 is not set
> =C2=A0# CONFIG_ARCH_PXA is not set
> =C2=A0# CONFIG_ARCH_MSM is not set
> +# CONFIG_ARCH_SHMOBILE is not set
> =C2=A0# CONFIG_ARCH_RPC is not set
> =C2=A0# CONFIG_ARCH_SA1100 is not set
> =C2=A0# CONFIG_ARCH_S3C2410 is not set
> =C2=A0# CONFIG_ARCH_S3C64XX is not set
> -# CONFIG_ARCH_S5PC1XX is not set
> +# CONFIG_ARCH_S5P6440 is not set
> +# CONFIG_ARCH_S5P6442 is not set
> +# CONFIG_ARCH_S5PC100 is not set
> +# CONFIG_ARCH_S5PV210 is not set
> =C2=A0# CONFIG_ARCH_SHARK is not set
> =C2=A0# CONFIG_ARCH_LH7A40X is not set
> =C2=A0# CONFIG_ARCH_U300 is not set
> +# CONFIG_ARCH_U8500 is not set
> +# CONFIG_ARCH_NOMADIK is not set
> =C2=A0# CONFIG_ARCH_DAVINCI is not set
> =C2=A0CONFIG_ARCH_OMAP=3Dy
> -# CONFIG_ARCH_BCMRING is not set
> +# CONFIG_PLAT_SPEAR is not set
>
> =C2=A0#
> =C2=A0# TI OMAP Implementations
> =C2=A0#
> +CONFIG_OMAP_GPIO_EXTRA=3D64
> +CONFIG_OMAP_GPIO_EXTRA64=3Dy
> +CONFIG_OMAP_IRQ_EXTRA=3D64
> +CONFIG_OMAP_IRQ_EXTRA64=3Dy
> =C2=A0CONFIG_ARCH_OMAP_OTG=3Dy
> =C2=A0CONFIG_ARCH_OMAP1=3Dy
> -# CONFIG_ARCH_OMAP2 is not set
> -# CONFIG_ARCH_OMAP3 is not set
> -# CONFIG_ARCH_OMAP4 is not set
> +# CONFIG_ARCH_OMAP2PLUS is not set
>
> =C2=A0#
> =C2=A0# OMAP Feature Selections
> @@ -205,10 +259,6 @@ CONFIG_OMAP_MCBSP=3Dy
> =C2=A0# CONFIG_OMAP_MBOX_FWK is not set
> =C2=A0CONFIG_OMAP_MPU_TIMER=3Dy
> =C2=A0# CONFIG_OMAP_32K_TIMER is not set
> -CONFIG_OMAP_LL_DEBUG_UART1=3Dy
> -# CONFIG_OMAP_LL_DEBUG_UART2 is not set
> -# CONFIG_OMAP_LL_DEBUG_UART3 is not set
> -# CONFIG_OMAP_LL_DEBUG_NONE is not set
> =C2=A0CONFIG_OMAP_SERIAL_WAKE=3Dy
> =C2=A0# CONFIG_OMAP_PM_NONE is not set
> =C2=A0CONFIG_OMAP_PM_NOOP=3Dy
> @@ -289,6 +339,7 @@ CONFIG_PREEMPT=3Dy
> =C2=A0CONFIG_HZ=3D100
> =C2=A0CONFIG_AEABI=3Dy
> =C2=A0CONFIG_OABI_COMPAT=3Dy
> +CONFIG_ARCH_HAS_HOLES_MEMORYMODEL=3Dy
> =C2=A0# CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
> =C2=A0# CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
> =C2=A0# CONFIG_HIGHMEM is not set
> @@ -299,12 +350,10 @@ CONFIG_FLATMEM_MANUAL=3Dy
> =C2=A0CONFIG_FLATMEM=3Dy
> =C2=A0CONFIG_FLAT_NODE_MEM_MAP=3Dy
> =C2=A0CONFIG_PAGEFLAGS_EXTENDED=3Dy
> -CONFIG_SPLIT_PTLOCK_CPUS=3D4096
> +CONFIG_SPLIT_PTLOCK_CPUS=3D999999
> =C2=A0# CONFIG_PHYS_ADDR_T_64BIT is not set
> =C2=A0CONFIG_ZONE_DMA_FLAG=3D0
> =C2=A0CONFIG_VIRT_TO_BUS=3Dy
> -CONFIG_HAVE_MLOCK=3Dy
> -CONFIG_HAVE_MLOCKED_PAGE_BIT=3Dy
> =C2=A0# CONFIG_KSM is not set
> =C2=A0CONFIG_DEFAULT_MMAP_MIN_ADDR=3D4096
> =C2=A0CONFIG_LEDS=3Dy
> @@ -317,6 +366,7 @@ CONFIG_ALIGNMENT_TRAP=3Dy
> =C2=A0CONFIG_ZBOOT_ROM_TEXT=3D0x0
> =C2=A0CONFIG_ZBOOT_ROM_BSS=3D0x0
> =C2=A0CONFIG_CMDLINE=3D"mem=3D32M console=3DttyS0,115200 ip=3Ddhcp"
> +# CONFIG_CMDLINE_FORCE is not set
> =C2=A0# CONFIG_XIP_KERNEL is not set
> =C2=A0# CONFIG_KEXEC is not set
>
> @@ -357,6 +407,7 @@ CONFIG_SUSPEND=3Dy
> =C2=A0CONFIG_SUSPEND_FREEZER=3Dy
> =C2=A0# CONFIG_APM_EMULATION is not set
> =C2=A0# CONFIG_PM_RUNTIME is not set
> +CONFIG_PM_OPS=3Dy
> =C2=A0CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
> =C2=A0CONFIG_NET=3Dy
>
> @@ -364,7 +415,6 @@ CONFIG_NET=3Dy
> =C2=A0# Networking options
> =C2=A0#
> =C2=A0CONFIG_PACKET=3Dy
> -# CONFIG_PACKET_MMAP is not set
> =C2=A0CONFIG_UNIX=3Dy
> =C2=A0CONFIG_XFRM=3Dy
> =C2=A0# CONFIG_XFRM_USER is not set
> @@ -408,6 +458,7 @@ CONFIG_DEFAULT_TCP_CONG=3D"cubic"
> =C2=A0# CONFIG_RDS is not set
> =C2=A0# CONFIG_TIPC is not set
> =C2=A0# CONFIG_ATM is not set
> +# CONFIG_L2TP is not set
> =C2=A0# CONFIG_BRIDGE is not set
> =C2=A0# CONFIG_NET_DSA is not set
> =C2=A0# CONFIG_VLAN_8021Q is not set
> @@ -435,17 +486,19 @@ CONFIG_DEFAULT_TCP_CONG=3D"cubic"
> =C2=A0# CONFIG_AF_RXRPC is not set
> =C2=A0CONFIG_WIRELESS=3Dy
> =C2=A0# CONFIG_CFG80211 is not set
> -CONFIG_CFG80211_DEFAULT_PS_VALUE=3D0
> -# CONFIG_WIRELESS_OLD_REGULATORY is not set
> -# CONFIG_WIRELESS_EXT is not set
> =C2=A0# CONFIG_LIB80211 is not set
>
> =C2=A0#
> =C2=A0# CFG80211 needs to be enabled for MAC80211
> =C2=A0#
> +
> +#
> +# Some wireless drivers require a rate control algorithm
> +#
> =C2=A0# CONFIG_WIMAX is not set
> =C2=A0# CONFIG_RFKILL is not set
> =C2=A0# CONFIG_NET_9P is not set
> +# CONFIG_CAIF is not set
>
> =C2=A0#
> =C2=A0# Device Drivers
> @@ -469,6 +522,10 @@ CONFIG_BLK_DEV=3Dy
> =C2=A0# CONFIG_BLK_DEV_COW_COMMON is not set
> =C2=A0CONFIG_BLK_DEV_LOOP=3Dy
> =C2=A0# CONFIG_BLK_DEV_CRYPTOLOOP is not set
> +
> +#
> +# DRBD disabled because PROC_FS, INET or CONNECTOR not selected
> +#
> =C2=A0# CONFIG_BLK_DEV_NBD is not set
> =C2=A0CONFIG_BLK_DEV_RAM=3Dy
> =C2=A0CONFIG_BLK_DEV_RAM_COUNT=3D16
> @@ -478,19 +535,29 @@ CONFIG_BLK_DEV_RAM_SIZE=3D8192
> =C2=A0# CONFIG_ATA_OVER_ETH is not set
> =C2=A0# CONFIG_MG_DISK is not set
> =C2=A0CONFIG_MISC_DEVICES=3Dy
> +# CONFIG_AD525X_DPOT is not set
> +# CONFIG_ICS932S401 is not set
> =C2=A0# CONFIG_ENCLOSURE_SERVICES is not set
> +# CONFIG_ISL29003 is not set
> +# CONFIG_SENSORS_TSL2550 is not set
> +# CONFIG_DS1682 is not set
> =C2=A0# CONFIG_C2PORT is not set
>
> =C2=A0#
> =C2=A0# EEPROM support
> =C2=A0#
> +# CONFIG_EEPROM_AT24 is not set
> +# CONFIG_EEPROM_LEGACY is not set
> +# CONFIG_EEPROM_MAX6875 is not set
> =C2=A0# CONFIG_EEPROM_93CX6 is not set
> +# CONFIG_IWMC3200TOP is not set
> =C2=A0CONFIG_HAVE_IDE=3Dy
> =C2=A0# CONFIG_IDE is not set
>
> =C2=A0#
> =C2=A0# SCSI device support
> =C2=A0#
> +CONFIG_SCSI_MOD=3Dy
> =C2=A0# CONFIG_RAID_ATTRS is not set
> =C2=A0# CONFIG_SCSI is not set
> =C2=A0# CONFIG_SCSI_DMA is not set
> @@ -527,8 +594,7 @@ CONFIG_SMC91X=3Dy
> =C2=A0CONFIG_NETDEV_1000=3Dy
> =C2=A0CONFIG_NETDEV_10000=3Dy
> =C2=A0CONFIG_WLAN=3Dy
> -# CONFIG_WLAN_PRE80211 is not set
> -# CONFIG_WLAN_80211 is not set
> +# CONFIG_HOSTAP is not set
>
> =C2=A0#
> =C2=A0# Enable WiMAX (Networking options) to see the WiMAX drivers
> @@ -548,6 +614,7 @@ CONFIG_WLAN=3Dy
> =C2=A0CONFIG_INPUT=3Dy
> =C2=A0# CONFIG_INPUT_FF_MEMLESS is not set
> =C2=A0# CONFIG_INPUT_POLLDEV is not set
> +# CONFIG_INPUT_SPARSEKMAP is not set
>
> =C2=A0#
> =C2=A0# Userland interfaces
> @@ -557,17 +624,22 @@ CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
> =C2=A0CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
> =C2=A0CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
> =C2=A0# CONFIG_INPUT_JOYDEV is not set
> -# CONFIG_INPUT_EVDEV is not set
> +CONFIG_INPUT_EVDEV=3Dy
> =C2=A0# CONFIG_INPUT_EVBUG is not set
>
> =C2=A0#
> =C2=A0# Input Device Drivers
> =C2=A0#
> =C2=A0CONFIG_INPUT_KEYBOARD=3Dy
> +# CONFIG_KEYBOARD_ADP5588 is not set
> =C2=A0# CONFIG_KEYBOARD_ATKBD is not set
> +# CONFIG_QT2160 is not set
> =C2=A0# CONFIG_KEYBOARD_LKKBD is not set
> -# CONFIG_KEYBOARD_GPIO is not set
> +CONFIG_KEYBOARD_GPIO=3Dy
> +# CONFIG_KEYBOARD_TCA6416 is not set
> =C2=A0# CONFIG_KEYBOARD_MATRIX is not set
> +# CONFIG_KEYBOARD_LM8323 is not set
> +# CONFIG_KEYBOARD_MAX7359 is not set
> =C2=A0# CONFIG_KEYBOARD_NEWTON is not set
> =C2=A0# CONFIG_KEYBOARD_OPENCORES is not set
> =C2=A0# CONFIG_KEYBOARD_STOWAWAY is not set
> @@ -586,6 +658,7 @@ CONFIG_KEYBOARD_OMAP=3Dy
> =C2=A0CONFIG_SERIO=3Dy
> =C2=A0CONFIG_SERIO_SERPORT=3Dy
> =C2=A0# CONFIG_SERIO_RAW is not set
> +# CONFIG_SERIO_ALTERA_PS2 is not set
> =C2=A0# CONFIG_GAMEPORT is not set
>
> =C2=A0#
> @@ -598,6 +671,7 @@ CONFIG_HW_CONSOLE=3Dy
> =C2=A0# CONFIG_VT_HW_CONSOLE_BINDING is not set
> =C2=A0CONFIG_DEVKMEM=3Dy
> =C2=A0# CONFIG_SERIAL_NONSTANDARD is not set
> +# CONFIG_N_GSM is not set
>
> =C2=A0#
> =C2=A0# Serial drivers
> @@ -611,6 +685,9 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
> =C2=A0# Non-8250 serial port support
> =C2=A0#
> =C2=A0CONFIG_SERIAL_CORE=3Dm
> +# CONFIG_SERIAL_TIMBERDALE is not set
> +# CONFIG_SERIAL_ALTERA_JTAGUART is not set
> +# CONFIG_SERIAL_ALTERA_UART is not set
> =C2=A0CONFIG_UNIX98_PTYS=3Dy
> =C2=A0# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
> =C2=A0# CONFIG_LEGACY_PTYS is not set
> @@ -620,7 +697,49 @@ CONFIG_HW_RANDOM=3Dm
> =C2=A0# CONFIG_R3964 is not set
> =C2=A0# CONFIG_RAW_DRIVER is not set
> =C2=A0# CONFIG_TCG_TPM is not set
> -# CONFIG_I2C is not set
> +# CONFIG_RAMOOPS is not set
> +CONFIG_I2C=3Dy
> +CONFIG_I2C_BOARDINFO=3Dy
> +CONFIG_I2C_COMPAT=3Dy
> +CONFIG_I2C_CHARDEV=3Dy
> +# CONFIG_I2C_HELPER_AUTO is not set
> +# CONFIG_I2C_SMBUS is not set
> +
> +#
> +# I2C Algorithms
> +#
> +CONFIG_I2C_ALGOBIT=3Dy
> +# CONFIG_I2C_ALGOPCF is not set
> +# CONFIG_I2C_ALGOPCA is not set
> +
> +#
> +# I2C Hardware Bus support
> +#
> +
> +#
> +# I2C system bus drivers (mostly embedded / system-on-chip)
> +#
> +# CONFIG_I2C_DESIGNWARE is not set
> +CONFIG_I2C_GPIO=3Dy
> +# CONFIG_I2C_OCORES is not set
> +CONFIG_I2C_OMAP=3Dy
> +# CONFIG_I2C_SIMTEC is not set
> +# CONFIG_I2C_XILINX is not set
> +
> +#
> +# External I2C/SMBus adapter drivers
> +#
> +# CONFIG_I2C_PARPORT_LIGHT is not set
> +# CONFIG_I2C_TAOS_EVM is not set
> +
> +#
> +# Other I2C/SMBus bus drivers
> +#
> +# CONFIG_I2C_PCA_PLATFORM is not set
> +# CONFIG_I2C_STUB is not set
> +# CONFIG_I2C_DEBUG_CORE is not set
> +# CONFIG_I2C_DEBUG_ALGO is not set
> +# CONFIG_I2C_DEBUG_BUS is not set
> =C2=A0# CONFIG_SPI is not set
>
> =C2=A0#
> @@ -634,10 +753,16 @@ CONFIG_GPIOLIB=3Dy
> =C2=A0#
> =C2=A0# Memory mapped GPIO expanders:
> =C2=A0#
> +# CONFIG_GPIO_IT8761E is not set
>
> =C2=A0#
> =C2=A0# I2C GPIO expanders:
> =C2=A0#
> +# CONFIG_GPIO_MAX7300 is not set
> +# CONFIG_GPIO_MAX732X is not set
> +# CONFIG_GPIO_PCA953X is not set
> +# CONFIG_GPIO_PCF857X is not set
> +# CONFIG_GPIO_ADP5588 is not set
>
> =C2=A0#
> =C2=A0# PCI GPIO expanders:
> @@ -659,17 +784,70 @@ CONFIG_HWMON=3Dy
> =C2=A0#
> =C2=A0# Native drivers
> =C2=A0#
> +# CONFIG_SENSORS_AD7414 is not set
> +# CONFIG_SENSORS_AD7418 is not set
> +# CONFIG_SENSORS_ADM1021 is not set
> +# CONFIG_SENSORS_ADM1025 is not set
> +# CONFIG_SENSORS_ADM1026 is not set
> +# CONFIG_SENSORS_ADM1029 is not set
> +# CONFIG_SENSORS_ADM1031 is not set
> +# CONFIG_SENSORS_ADM9240 is not set
> +# CONFIG_SENSORS_ADT7411 is not set
> +# CONFIG_SENSORS_ADT7462 is not set
> +# CONFIG_SENSORS_ADT7470 is not set
> +# CONFIG_SENSORS_ADT7475 is not set
> +# CONFIG_SENSORS_ASC7621 is not set
> +# CONFIG_SENSORS_ATXP1 is not set
> +# CONFIG_SENSORS_DS1621 is not set
> =C2=A0# CONFIG_SENSORS_F71805F is not set
> =C2=A0# CONFIG_SENSORS_F71882FG is not set
> +# CONFIG_SENSORS_F75375S is not set
> +# CONFIG_SENSORS_G760A is not set
> +# CONFIG_SENSORS_GL518SM is not set
> +# CONFIG_SENSORS_GL520SM is not set
> =C2=A0# CONFIG_SENSORS_IT87 is not set
> +# CONFIG_SENSORS_LM63 is not set
> +# CONFIG_SENSORS_LM73 is not set
> +# CONFIG_SENSORS_LM75 is not set
> +# CONFIG_SENSORS_LM77 is not set
> +# CONFIG_SENSORS_LM78 is not set
> +# CONFIG_SENSORS_LM80 is not set
> +# CONFIG_SENSORS_LM83 is not set
> +# CONFIG_SENSORS_LM85 is not set
> +# CONFIG_SENSORS_LM87 is not set
> +# CONFIG_SENSORS_LM90 is not set
> +# CONFIG_SENSORS_LM92 is not set
> +# CONFIG_SENSORS_LM93 is not set
> +# CONFIG_SENSORS_LTC4215 is not set
> +# CONFIG_SENSORS_LTC4245 is not set
> +# CONFIG_SENSORS_LM95241 is not set
> +# CONFIG_SENSORS_MAX1619 is not set
> +# CONFIG_SENSORS_MAX6650 is not set
> =C2=A0# CONFIG_SENSORS_PC87360 is not set
> =C2=A0# CONFIG_SENSORS_PC87427 is not set
> +# CONFIG_SENSORS_PCF8591 is not set
> =C2=A0# CONFIG_SENSORS_SHT15 is not set
> +# CONFIG_SENSORS_DME1737 is not set
> +# CONFIG_SENSORS_EMC1403 is not set
> =C2=A0# CONFIG_SENSORS_SMSC47M1 is not set
> +# CONFIG_SENSORS_SMSC47M192 is not set
> =C2=A0# CONFIG_SENSORS_SMSC47B397 is not set
> +# CONFIG_SENSORS_ADS7828 is not set
> +# CONFIG_SENSORS_AMC6821 is not set
> +# CONFIG_SENSORS_THMC50 is not set
> +# CONFIG_SENSORS_TMP102 is not set
> +# CONFIG_SENSORS_TMP401 is not set
> +# CONFIG_SENSORS_TMP421 is not set
> =C2=A0# CONFIG_SENSORS_VT1211 is not set
> +# CONFIG_SENSORS_W83781D is not set
> +# CONFIG_SENSORS_W83791D is not set
> +# CONFIG_SENSORS_W83792D is not set
> +# CONFIG_SENSORS_W83793 is not set
> +# CONFIG_SENSORS_W83L785TS is not set
> +# CONFIG_SENSORS_W83L786NG is not set
> =C2=A0# CONFIG_SENSORS_W83627HF is not set
> =C2=A0# CONFIG_SENSORS_W83627EHF is not set
> +# CONFIG_SENSORS_LIS3_I2C is not set
> =C2=A0# CONFIG_THERMAL is not set
> =C2=A0# CONFIG_WATCHDOG is not set
> =C2=A0CONFIG_SSB_POSSIBLE=3Dy
> @@ -683,14 +861,27 @@ CONFIG_SSB_POSSIBLE=3Dy
> =C2=A0# Multifunction device drivers
> =C2=A0#
> =C2=A0# CONFIG_MFD_CORE is not set
> +# CONFIG_MFD_88PM860X is not set
> =C2=A0# CONFIG_MFD_SM501 is not set
> =C2=A0# CONFIG_MFD_ASIC3 is not set
> =C2=A0# CONFIG_HTC_EGPIO is not set
> =C2=A0# CONFIG_HTC_PASIC3 is not set
> +CONFIG_HTC_I2CPLD=3Dy
> +# CONFIG_TPS65010 is not set
> +# CONFIG_TWL4030_CORE is not set
> =C2=A0# CONFIG_MFD_TMIO is not set
> =C2=A0# CONFIG_MFD_T7L66XB is not set
> =C2=A0# CONFIG_MFD_TC6387XB is not set
> =C2=A0# CONFIG_MFD_TC6393XB is not set
> +# CONFIG_PMIC_DA903X is not set
> +# CONFIG_PMIC_ADP5520 is not set
> +# CONFIG_MFD_MAX8925 is not set
> +# CONFIG_MFD_WM8400 is not set
> +# CONFIG_MFD_WM831X is not set
> +# CONFIG_MFD_WM8350_I2C is not set
> +# CONFIG_MFD_WM8994 is not set
> +# CONFIG_MFD_PCF50633 is not set
> +# CONFIG_AB3100_CORE is not set
> =C2=A0# CONFIG_REGULATOR is not set
> =C2=A0# CONFIG_MEDIA_SUPPORT is not set
>
> @@ -731,7 +922,12 @@ CONFIG_FB_OMAP=3Dy
> =C2=A0# CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
> =C2=A0CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=3D2
> =C2=A0# CONFIG_FB_OMAP_DMA_TUNE is not set
> -# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
> +CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
> +# CONFIG_LCD_CLASS_DEVICE is not set
> +CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
> +# CONFIG_BACKLIGHT_GENERIC is not set
> +# CONFIG_BACKLIGHT_OMAP1 is not set
> +# CONFIG_BACKLIGHT_ADP8860 is not set
>
> =C2=A0#
> =C2=A0# Display device support
> @@ -809,17 +1005,25 @@ CONFIG_USB_ETH=3Dy
> =C2=A0# CONFIG_USB_ETH_RNDIS is not set
> =C2=A0# CONFIG_USB_ETH_EEM is not set
> =C2=A0# CONFIG_USB_GADGETFS is not set
> +# CONFIG_USB_FUNCTIONFS is not set
> =C2=A0# CONFIG_USB_FILE_STORAGE is not set
> +# CONFIG_USB_MASS_STORAGE is not set
> =C2=A0# CONFIG_USB_G_SERIAL is not set
> =C2=A0# CONFIG_USB_MIDI_GADGET is not set
> =C2=A0# CONFIG_USB_G_PRINTER is not set
> =C2=A0# CONFIG_USB_CDC_COMPOSITE is not set
> +# CONFIG_USB_G_NOKIA is not set
> +# CONFIG_USB_G_MULTI is not set
> +# CONFIG_USB_G_HID is not set
> +# CONFIG_USB_G_WEBCAM is not set
>
> =C2=A0#
> =C2=A0# OTG and related infrastructure
> =C2=A0#
> =C2=A0CONFIG_USB_OTG_UTILS=3Dy
> =C2=A0# CONFIG_USB_GPIO_VBUS is not set
> +# CONFIG_ISP1301_OMAP is not set
> +# CONFIG_USB_ULPI is not set
> =C2=A0# CONFIG_NOP_USB_XCEIV is not set
> =C2=A0CONFIG_MMC=3Dy
> =C2=A0# CONFIG_MMC_DEBUG is not set
> @@ -836,13 +1040,36 @@ CONFIG_MMC_BLOCK_BOUNCE=3Dy
> =C2=A0#
> =C2=A0# MMC/SD/SDIO Host Controller Drivers
> =C2=A0#
> -CONFIG_MMC_SDHCI=3Dy
> -CONFIG_MMC_SDHCI_PLTFM=3Dy
> +# CONFIG_MMC_SDHCI is not set
> =C2=A0CONFIG_MMC_OMAP=3Dy
> -# CONFIG_MMC_AT91 is not set
> -# CONFIG_MMC_ATMELMCI is not set
> =C2=A0# CONFIG_MEMSTICK is not set
> -# CONFIG_NEW_LEDS is not set
> +CONFIG_NEW_LEDS=3Dy
> +CONFIG_LEDS_CLASS=3Dy
> +
> +#
> +# LED drivers
> +#
> +# CONFIG_LEDS_PCA9532 is not set
> +CONFIG_LEDS_GPIO=3Dy
> +CONFIG_LEDS_GPIO_PLATFORM=3Dy
> +# CONFIG_LEDS_LP3944 is not set
> +# CONFIG_LEDS_PCA955X is not set
> +# CONFIG_LEDS_BD2802 is not set
> +# CONFIG_LEDS_LT3593 is not set
> +CONFIG_LEDS_TRIGGERS=3Dy
> +
> +#
> +# LED Triggers
> +#
> +CONFIG_LEDS_TRIGGER_TIMER=3Dy
> +CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dy
> +CONFIG_LEDS_TRIGGER_BACKLIGHT=3Dy
> +CONFIG_LEDS_TRIGGER_GPIO=3Dy
> +CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dy
> +
> +#
> +# iptables trigger is under Netfilter config (LED target)
> +#
> =C2=A0# CONFIG_ACCESSIBILITY is not set
> =C2=A0CONFIG_RTC_LIB=3Dy
> =C2=A0CONFIG_RTC_CLASS=3Dy
> @@ -860,6 +1087,25 @@ CONFIG_RTC_INTF_DEV=3Dy
> =C2=A0# CONFIG_RTC_DRV_TEST is not set
>
> =C2=A0#
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
> +# CONFIG_RTC_DRV_S35390A is not set
> +# CONFIG_RTC_DRV_FM3130 is not set
> +# CONFIG_RTC_DRV_RX8581 is not set
> +# CONFIG_RTC_DRV_RX8025 is not set
> +
> +#
> =C2=A0# SPI RTC drivers
> =C2=A0#
>
> @@ -875,7 +1121,9 @@ CONFIG_RTC_INTF_DEV=3Dy
> =C2=A0# CONFIG_RTC_DRV_M48T86 is not set
> =C2=A0# CONFIG_RTC_DRV_M48T35 is not set
> =C2=A0# CONFIG_RTC_DRV_M48T59 is not set
> +# CONFIG_RTC_DRV_MSM6242 is not set
> =C2=A0# CONFIG_RTC_DRV_BQ4802 is not set
> +# CONFIG_RTC_DRV_RP5C01 is not set
> =C2=A0# CONFIG_RTC_DRV_V3020 is not set
>
> =C2=A0#
> @@ -884,10 +1132,6 @@ CONFIG_RTC_INTF_DEV=3Dy
> =C2=A0# CONFIG_DMADEVICES is not set
> =C2=A0# CONFIG_AUXDISPLAY is not set
> =C2=A0# CONFIG_UIO is not set
> -
> -#
> -# TI VLYNQ
> -#
> =C2=A0# CONFIG_STAGING is not set
>
> =C2=A0#
> @@ -936,8 +1180,11 @@ CONFIG_INOTIFY_USER=3Dy
> =C2=A0#
> =C2=A0# DOS/FAT/NT Filesystems
> =C2=A0#
> +CONFIG_FAT_FS=3Dy
> =C2=A0# CONFIG_MSDOS_FS is not set
> -# CONFIG_VFAT_FS is not set
> +CONFIG_VFAT_FS=3Dy
> +CONFIG_FAT_DEFAULT_CODEPAGE=3D437
> +CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
> =C2=A0# CONFIG_NTFS_FS is not set
>
> =C2=A0#
> @@ -959,6 +1206,7 @@ CONFIG_MISC_FILESYSTEMS=3Dy
> =C2=A0# CONFIG_BEFS_FS is not set
> =C2=A0# CONFIG_BFS_FS is not set
> =C2=A0# CONFIG_EFS_FS is not set
> +# CONFIG_LOGFS is not set
> =C2=A0# CONFIG_CRAMFS is not set
> =C2=A0# CONFIG_SQUASHFS is not set
> =C2=A0# CONFIG_VXFS_FS is not set
> @@ -981,6 +1229,7 @@ CONFIG_SUNRPC=3Dy
> =C2=A0# CONFIG_RPCSEC_GSS_KRB5 is not set
> =C2=A0# CONFIG_RPCSEC_GSS_SPKM3 is not set
> =C2=A0# CONFIG_SMB_FS is not set
> +# CONFIG_CEPH_FS is not set
> =C2=A0# CONFIG_CIFS is not set
> =C2=A0# CONFIG_NCP_FS is not set
> =C2=A0# CONFIG_CODA_FS is not set
> @@ -991,7 +1240,46 @@ CONFIG_SUNRPC=3Dy
> =C2=A0#
> =C2=A0# CONFIG_PARTITION_ADVANCED is not set
> =C2=A0CONFIG_MSDOS_PARTITION=3Dy
> -# CONFIG_NLS is not set
> +CONFIG_NLS=3Dy
> +CONFIG_NLS_DEFAULT=3D"iso8859-1"
> +CONFIG_NLS_CODEPAGE_437=3Dy
> +# CONFIG_NLS_CODEPAGE_737 is not set
> +# CONFIG_NLS_CODEPAGE_775 is not set
> +# CONFIG_NLS_CODEPAGE_850 is not set
> +# CONFIG_NLS_CODEPAGE_852 is not set
> +# CONFIG_NLS_CODEPAGE_855 is not set
> +# CONFIG_NLS_CODEPAGE_857 is not set
> +# CONFIG_NLS_CODEPAGE_860 is not set
> +# CONFIG_NLS_CODEPAGE_861 is not set
> +# CONFIG_NLS_CODEPAGE_862 is not set
> +# CONFIG_NLS_CODEPAGE_863 is not set
> +# CONFIG_NLS_CODEPAGE_864 is not set
> +# CONFIG_NLS_CODEPAGE_865 is not set
> +# CONFIG_NLS_CODEPAGE_866 is not set
> +# CONFIG_NLS_CODEPAGE_869 is not set
> +# CONFIG_NLS_CODEPAGE_936 is not set
> +# CONFIG_NLS_CODEPAGE_950 is not set
> +# CONFIG_NLS_CODEPAGE_932 is not set
> +# CONFIG_NLS_CODEPAGE_949 is not set
> +# CONFIG_NLS_CODEPAGE_874 is not set
> +# CONFIG_NLS_ISO8859_8 is not set
> +# CONFIG_NLS_CODEPAGE_1250 is not set
> +# CONFIG_NLS_CODEPAGE_1251 is not set
> +# CONFIG_NLS_ASCII is not set
> +CONFIG_NLS_ISO8859_1=3Dy
> +# CONFIG_NLS_ISO8859_2 is not set
> +# CONFIG_NLS_ISO8859_3 is not set
> +# CONFIG_NLS_ISO8859_4 is not set
> +# CONFIG_NLS_ISO8859_5 is not set
> +# CONFIG_NLS_ISO8859_6 is not set
> +# CONFIG_NLS_ISO8859_7 is not set
> +# CONFIG_NLS_ISO8859_9 is not set
> +# CONFIG_NLS_ISO8859_13 is not set
> +# CONFIG_NLS_ISO8859_14 is not set
> +# CONFIG_NLS_ISO8859_15 is not set
> +# CONFIG_NLS_KOI8_R is not set
> +# CONFIG_NLS_KOI8_U is not set
> +# CONFIG_NLS_UTF8 is not set
> =C2=A0# CONFIG_DLM is not set
>
> =C2=A0#
> @@ -1015,10 +1303,12 @@ CONFIG_DEBUG_MEMORY_INIT=3Dy
> =C2=A0CONFIG_HAVE_FUNCTION_TRACER=3Dy
> =C2=A0CONFIG_TRACING_SUPPORT=3Dy
> =C2=A0# CONFIG_FTRACE is not set
> +# CONFIG_ATOMIC64_SELFTEST is not set
> =C2=A0# CONFIG_SAMPLES is not set
> =C2=A0CONFIG_HAVE_ARCH_KGDB=3Dy
> =C2=A0CONFIG_ARM_UNWIND=3Dy
> =C2=A0# CONFIG_DEBUG_USER is not set
> +# CONFIG_OC_ETM is not set
>
> =C2=A0#
> =C2=A0# Security options
> @@ -1026,7 +1316,11 @@ CONFIG_ARM_UNWIND=3Dy
> =C2=A0# CONFIG_KEYS is not set
> =C2=A0# CONFIG_SECURITY is not set
> =C2=A0# CONFIG_SECURITYFS is not set
> -# CONFIG_SECURITY_FILE_CAPABILITIES is not set
> +# CONFIG_DEFAULT_SECURITY_SELINUX is not set
> +# CONFIG_DEFAULT_SECURITY_SMACK is not set
> +# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
> +CONFIG_DEFAULT_SECURITY_DAC=3Dy
> +CONFIG_DEFAULT_SECURITY=3D""
> =C2=A0CONFIG_CRYPTO=3Dy
>
> =C2=A0#
> @@ -1138,7 +1432,9 @@ CONFIG_LZO_DECOMPRESS=3Dy
> =C2=A0CONFIG_DECOMPRESS_GZIP=3Dy
> =C2=A0CONFIG_DECOMPRESS_BZIP2=3Dy
> =C2=A0CONFIG_DECOMPRESS_LZMA=3Dy
> +CONFIG_DECOMPRESS_LZO=3Dy
> =C2=A0CONFIG_HAS_IOMEM=3Dy
> =C2=A0CONFIG_HAS_IOPORT=3Dy
> =C2=A0CONFIG_HAS_DMA=3Dy
> =C2=A0CONFIG_NLATTR=3Dy
> +CONFIG_GENERIC_ATOMIC64=3Dy
> diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfi=
g
> index b18d7c2..6505109 100644
> --- a/arch/arm/mach-omap1/Kconfig
> +++ b/arch/arm/mach-omap1/Kconfig
> @@ -60,6 +60,8 @@ config MACH_OMAP_HTCWIZARD
> =C2=A0config MACH_HERALD
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bool "HTC Herald"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_OMAP850
> + =C2=A0 =C2=A0 =C2=A0 select OMAP_GPIO_EXTRA64
> + =C2=A0 =C2=A0 =C2=A0 select OMAP_IRQ_EXTRA64
> =C2=A0 =C2=A0 =C2=A0 =C2=A0help
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0HTC Herald smartphone support (AKA =
T-Mobile Wing, ...)
>
> diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makef=
ile
> index ea231c7..bcf15d8 100644
> --- a/arch/arm/mach-omap1/Makefile
> +++ b/arch/arm/mach-omap1/Makefile
> @@ -39,7 +39,7 @@ obj-$(CONFIG_MACH_NOKIA770) =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 +=3D board-nokia770.o
> =C2=A0obj-$(CONFIG_MACH_AMS_DELTA) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 +=3D board-ams-delta.o
> =C2=A0obj-$(CONFIG_AMS_DELTA_FIQ) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0+=3D ams-delta-fiq.o ams-delta-fiq-handler.o
> =C2=A0obj-$(CONFIG_MACH_SX1) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 +=3D board-sx1.o board-sx1-mmc.o
> -obj-$(CONFIG_MACH_HERALD) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0+=3D board-htcherald.o
> +obj-$(CONFIG_MACH_HERALD) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0+=3D board-htcherald.o htc-mmc.o
>
> =C2=A0ifeq ($(CONFIG_ARCH_OMAP15XX),y)
> =C2=A0# Innovator-1510 FPGA
> diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-om=
ap1/board-htcherald.c
> index 8e313b4..fa57ee9 100644
> --- a/arch/arm/mach-omap1/board-htcherald.c
> +++ b/arch/arm/mach-omap1/board-htcherald.c
> @@ -30,6 +30,11 @@
> =C2=A0#include <linux/input.h>
> =C2=A0#include <linux/io.h>
> =C2=A0#include <linux/gpio.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c-gpio.h>
> +#include <linux/htcpld.h>
> +#include <linux/leds.h>
>
> =C2=A0#include <asm/mach-types.h>
> =C2=A0#include <asm/mach/arch.h>
> @@ -39,6 +44,7 @@
> =C2=A0#include <plat/board.h>
> =C2=A0#include <plat/keypad.h>
> =C2=A0#include <plat/usb.h>
> +#include <plat/mmc.h>
>
> =C2=A0#include <mach/irqs.h>
>
> @@ -52,13 +58,121 @@
> =C2=A0#define =C2=A0 =C2=A0 =C2=A0 OMAP_LCDC_CTRL_LCD_EN =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 (1 << 0)
> =C2=A0#define =C2=A0 =C2=A0 =C2=A0 OMAP_LCDC_STAT_DONE =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 << 0)
>
> -static struct omap_lcd_config htcherald_lcd_config __initdata =3D {
> - =C2=A0 =C2=A0 =C2=A0 .ctrl_name =C2=A0 =C2=A0 =C2=A0=3D "internal",
> -};
> +/* GPIO definitions for the power button and keyboard slide switch *=
/
> +#define HTCHERALD_GPIO_POWER 139
> +#define HTCHERALD_GPIO_SLIDE 174
> +#define HTCHERALD_GIRQ_BTNS 141
>
> -static struct omap_board_config_kernel htcherald_config[] __initdata=
 =3D {
> - =C2=A0 =C2=A0 =C2=A0 { OMAP_TAG_LCD, &htcherald_lcd_config },
> -};
> +/* HTCPLD definitions */
> +
> +/*
> + * CPLD Logic
> + *
> +
> +Chip 3 - 0x03
> +
> +Function =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07 6 5 4 =C2=A03 2 =
1 0
> +------------------------------------
> +DPAD light =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x x x x =C2=A0x x x 1
> +SoundDev =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x x x x =C2=A01 x =
x x
> +Screen white =C2=A0 =C2=A0 =C2=A0 =C2=A01 x x x =C2=A0x x x x
> +MMC power on =C2=A0 =C2=A0 =C2=A0 =C2=A0x x x x =C2=A0x 1 x x
> +Happy times (n) =C2=A0 =C2=A0 0 x x x =C2=A0x 1 x x
> +
> +Chip 4 - 0x04
> +
> +Function =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07 6 5 4 =C2=A03 2 =
1 0
> +------------------------------------
> +Keyboard light =C2=A0 =C2=A0 =C2=A0x x x x =C2=A0x x x 1
> +LCD Bright (4) =C2=A0 =C2=A0 =C2=A0x x x x =C2=A0x 1 1 x
> +LCD Bright (3) =C2=A0 =C2=A0 =C2=A0x x x x =C2=A0x 0 1 x
> +LCD Bright (2) =C2=A0 =C2=A0 =C2=A0x x x x =C2=A0x 1 0 x
> +LCD Bright (1) =C2=A0 =C2=A0 =C2=A0x x x x =C2=A0x 0 0 x
> +LCD Off =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x x x x =C2=A00 x =
x x
> +LCD image (fb) =C2=A0 =C2=A0 =C2=A01 x x x =C2=A0x x x x
> +LCD image (white) =C2=A0 0 x x x =C2=A0x x x x
> +Caps lock LED =C2=A0 =C2=A0 =C2=A0 x x 1 x =C2=A0x x x x
> +
> +Chip 5 - 0x05
> +
> +Function =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07 6 5 4 =C2=A03 2 =
1 0
> +------------------------------------
> +Red (solid) =C2=A0 =C2=A0 =C2=A0 =C2=A0 x x x x =C2=A0x 1 x x
> +Red (flash) =C2=A0 =C2=A0 =C2=A0 =C2=A0 x x x x =C2=A0x x 1 x
> +Green (GSM flash) =C2=A0 x x x x =C2=A01 x x x
> +Green (GSM solid) =C2=A0 x x x 1 =C2=A0x x x x
> +Green (wifi flash) =C2=A0x x 1 x =C2=A0x x x x
> +Blue (bt flash) =C2=A0 =C2=A0 x 1 x x =C2=A0x x x x
> +DPAD Int Enable =C2=A0 =C2=A0 1 x x x =C2=A0x x x 0
> +
> +(Combinations of the above can be made for different colors.)
> +The direction pad interrupt enable must be set each time the
> +interrupt is handled.
> +
> +Chip 6 - 0x06
> +
> +Function =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07 6 5 4 =C2=A03 2 =
1 0
> +------------------------------------
> +Vibrator =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x x x x =C2=A01 x =
x x
> +Alt LED =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x x x 1 =C2=A0x x =
x x
> +Screen white =C2=A0 =C2=A0 =C2=A0 =C2=A01 x x x =C2=A0x x x x
> +Screen white =C2=A0 =C2=A0 =C2=A0 =C2=A0x x 1 x =C2=A0x x x x
> +Screen white =C2=A0 =C2=A0 =C2=A0 =C2=A0x 0 x x =C2=A0x x x x
> +Enable kbd dpad =C2=A0 =C2=A0 x x x x =C2=A0x x 0 x
> +Happy Times =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 1 0 x =C2=A0x x 0 x
> +*/
> +
> +/*
> + * HTCPLD GPIO lines start 16 after OMAP_MAX_GPIO_LINES to account
> + * for the 16 MPUIO lines.
> + */
> +#define HTCPLD_GPIO_START_OFFSET =C2=A0 =C2=A0 =C2=A0 (OMAP_MAX_GPIO=
_LINES + 16)
> +#define HTCPLD_IRQ(chip, offset) =C2=A0 =C2=A0 =C2=A0 (OMAP_IRQ_END =
+ 8 * (chip) + (offset))
> +#define HTCPLD_BASE(chip, offset) =C2=A0 =C2=A0 =C2=A0\
> + =C2=A0 =C2=A0 =C2=A0 (HTCPLD_GPIO_START_OFFSET + 8 * (chip) + (offs=
et))
> +
> +#define HTCPLD_GPIO_LED_DPAD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 HTCP=
LD_BASE(0, 0)
> +#define HTCPLD_GPIO_LED_KBD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
HTCPLD_BASE(1, 0)
> +#define HTCPLD_GPIO_LED_CAPS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 HTCP=
LD_BASE(1, 5)
> +#define HTCPLD_GPIO_LED_RED_FLASH =C2=A0 =C2=A0 =C2=A0HTCPLD_BASE(2,=
 1)
> +#define HTCPLD_GPIO_LED_RED_SOLID =C2=A0 =C2=A0 =C2=A0HTCPLD_BASE(2,=
 2)
> +#define HTCPLD_GPIO_LED_GREEN_FLASH =C2=A0 =C2=A0HTCPLD_BASE(2, 3)
> +#define HTCPLD_GPIO_LED_GREEN_SOLID =C2=A0 =C2=A0HTCPLD_BASE(2, 4)
> +#define HTCPLD_GPIO_LED_WIFI =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 HTCP=
LD_BASE(2, 5)
> +#define HTCPLD_GPIO_LED_BT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 HTCPLD_BASE(2, 6)
> +#define HTCPLD_GPIO_LED_VIBRATE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0HTCPLD_BASE(3, 3)
> +#define HTCPLD_GPIO_LED_ALT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
HTCPLD_BASE(3, 4)
> +
> +#define HTCPLD_GPIO_RIGHT_KBD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0HTCP=
LD_BASE(6, 7)
> +#define HTCPLD_GPIO_UP_KBD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 HTCPLD_BASE(6, 6)
> +#define HTCPLD_GPIO_LEFT_KBD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 HTCP=
LD_BASE(6, 5)
> +#define HTCPLD_GPIO_DOWN_KBD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 HTCP=
LD_BASE(6, 4)
> +
> +#define HTCPLD_GPIO_RIGHT_DPAD =C2=A0 =C2=A0 =C2=A0 =C2=A0 HTCPLD_BA=
SE(7, 7)
> +#define HTCPLD_GPIO_UP_DPAD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
HTCPLD_BASE(7, 6)
> +#define HTCPLD_GPIO_LEFT_DPAD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0HTCP=
LD_BASE(7, 5)
> +#define HTCPLD_GPIO_DOWN_DPAD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0HTCP=
LD_BASE(7, 4)
> +#define HTCPLD_GPIO_ENTER_DPAD =C2=A0 =C2=A0 =C2=A0 =C2=A0 HTCPLD_BA=
SE(7, 3)
> +
> +/*
> + * The htcpld chip requires a gpio write to a specific line
> + * to re-enable interrupts after one has occurred.
> + */
> +#define HTCPLD_GPIO_INT_RESET_HI =C2=A0 =C2=A0 =C2=A0 HTCPLD_BASE(2,=
 7)
> +#define HTCPLD_GPIO_INT_RESET_LO =C2=A0 =C2=A0 =C2=A0 HTCPLD_BASE(2,=
 0)
> +
> +/* Chip 5 */
> +#define HTCPLD_IRQ_RIGHT_KBD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 HTCP=
LD_IRQ(0, 7)
> +#define HTCPLD_IRQ_UP_KBD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0HTCPLD_IRQ(0, 6)
> +#define HTCPLD_IRQ_LEFT_KBD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
HTCPLD_IRQ(0, 5)
> +#define HTCPLD_IRQ_DOWN_KBD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
HTCPLD_IRQ(0, 4)
> +
> +/* Chip 6 */
> +#define HTCPLD_IRQ_RIGHT_DPAD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0HTCP=
LD_IRQ(1, 7)
> +#define HTCPLD_IRQ_UP_DPAD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 HTCPLD_IRQ(1, 6)
> +#define HTCPLD_IRQ_LEFT_DPAD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 HTCP=
LD_IRQ(1, 5)
> +#define HTCPLD_IRQ_DOWN_DPAD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 HTCP=
LD_IRQ(1, 4)
> +#define HTCPLD_IRQ_ENTER_DPAD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0HTCP=
LD_IRQ(1, 3)
>
> =C2=A0/* Keyboard definition */
>
> @@ -140,6 +254,129 @@ static struct platform_device kp_device =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.resource =C2=A0 =C2=A0 =C2=A0 =3D kp_reso=
urces,
> =C2=A0};
>
> +/* GPIO buttons for keyboard slide and power button */
> +static struct gpio_keys_button herald_gpio_keys_table[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 {BTN_0, =C2=A0HTCHERALD_GPIO_POWER, 1, "POWER"=
, EV_KEY, 1, 20},
> + =C2=A0 =C2=A0 =C2=A0 {SW_LID, HTCHERALD_GPIO_SLIDE, 0, "SLIDE", EV_=
SW, =C2=A01, 20},
> +
> + =C2=A0 =C2=A0 =C2=A0 {KEY_LEFT, =C2=A0HTCPLD_GPIO_LEFT_KBD, =C2=A01=
, "LEFT", =C2=A0EV_KEY, 1, 20},
> + =C2=A0 =C2=A0 =C2=A0 {KEY_RIGHT, HTCPLD_GPIO_RIGHT_KBD, 1, "RIGHT",=
 EV_KEY, 1, 20},
> + =C2=A0 =C2=A0 =C2=A0 {KEY_UP, =C2=A0 =C2=A0HTCPLD_GPIO_UP_KBD, =C2=A0=
 =C2=A01, "UP", =C2=A0 =C2=A0EV_KEY, 1, 20},
> + =C2=A0 =C2=A0 =C2=A0 {KEY_DOWN, =C2=A0HTCPLD_GPIO_DOWN_KBD, =C2=A01=
, "DOWN", =C2=A0EV_KEY, 1, 20},
> +
> + =C2=A0 =C2=A0 =C2=A0 {KEY_LEFT, =C2=A0HTCPLD_GPIO_LEFT_DPAD, =C2=A0=
 1, "DLEFT", =C2=A0EV_KEY, 1, 20},
> + =C2=A0 =C2=A0 =C2=A0 {KEY_RIGHT, HTCPLD_GPIO_RIGHT_DPAD, =C2=A01, "=
DRIGHT", EV_KEY, 1, 20},
> + =C2=A0 =C2=A0 =C2=A0 {KEY_UP, =C2=A0 =C2=A0HTCPLD_GPIO_UP_DPAD, =C2=
=A0 =C2=A0 1, "DUP", =C2=A0 =C2=A0EV_KEY, 1, 20},
> + =C2=A0 =C2=A0 =C2=A0 {KEY_DOWN, =C2=A0HTCPLD_GPIO_DOWN_DPAD, =C2=A0=
 1, "DDOWN", =C2=A0EV_KEY, 1, 20},
> + =C2=A0 =C2=A0 =C2=A0 {KEY_ENTER, HTCPLD_GPIO_ENTER_DPAD, =C2=A01, "=
DENTER", EV_KEY, 1, 20},
> +};
> +
> +static struct gpio_keys_platform_data herald_gpio_keys_data =3D {
> + =C2=A0 =C2=A0 =C2=A0 .buttons =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D herald=
_gpio_keys_table,
> + =C2=A0 =C2=A0 =C2=A0 .nbuttons =C2=A0 =C2=A0 =C2=A0 =3D ARRAY_SIZE(=
herald_gpio_keys_table),
> + =C2=A0 =C2=A0 =C2=A0 .rep =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D 1,
> +};
> +
> +static struct platform_device herald_gpiokeys_device =3D {
> + =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0=3D "gpio-keys",
> + =C2=A0 =C2=A0 =C2=A0 .id =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D -1,
> + =C2=A0 =C2=A0 =C2=A0 .dev =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .platform_data =3D=
 &herald_gpio_keys_data,
> + =C2=A0 =C2=A0 =C2=A0 },
> +};
> +
> +/* LEDs for the Herald. =C2=A0These connect to the HTCPLD GPIO devic=
e. */
> +static struct gpio_led gpio_leds[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 {"dpad", =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, HTCP=
LD_GPIO_LED_DPAD, =C2=A0 =C2=A0 =C2=A0 =C2=A00, 0, LEDS_GPIO_DEFSTATE_O=
=46F},
> + =C2=A0 =C2=A0 =C2=A0 {"kbd", =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, HTCP=
LD_GPIO_LED_KBD, =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0, LEDS_GPIO_DEFSTATE_O=
=46F},
> + =C2=A0 =C2=A0 =C2=A0 {"vibrate", =C2=A0 =C2=A0 NULL, HTCPLD_GPIO_LE=
D_VIBRATE, =C2=A0 =C2=A0 0, 0, LEDS_GPIO_DEFSTATE_OFF},
> + =C2=A0 =C2=A0 =C2=A0 {"green_solid", NULL, HTCPLD_GPIO_LED_GREEN_SO=
LID, 0, 0, LEDS_GPIO_DEFSTATE_OFF},
> + =C2=A0 =C2=A0 =C2=A0 {"green_flash", NULL, HTCPLD_GPIO_LED_GREEN_FL=
ASH, 0, 0, LEDS_GPIO_DEFSTATE_OFF},
> + =C2=A0 =C2=A0 =C2=A0 {"red_solid", =C2=A0 "mmc0", HTCPLD_GPIO_LED_R=
ED_SOLID, 0, 0, LEDS_GPIO_DEFSTATE_OFF},
> + =C2=A0 =C2=A0 =C2=A0 {"red_flash", =C2=A0 NULL, HTCPLD_GPIO_LED_RED=
_FLASH, =C2=A0 0, 0, LEDS_GPIO_DEFSTATE_OFF},
> + =C2=A0 =C2=A0 =C2=A0 {"wifi", =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, HTCP=
LD_GPIO_LED_WIFI, =C2=A0 =C2=A0 =C2=A0 =C2=A00, 0, LEDS_GPIO_DEFSTATE_O=
=46F},
> + =C2=A0 =C2=A0 =C2=A0 {"bt", =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL,=
 HTCPLD_GPIO_LED_BT, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00, 0, LEDS_GPIO_=
DEFSTATE_OFF},
> + =C2=A0 =C2=A0 =C2=A0 {"caps", =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, HTCP=
LD_GPIO_LED_CAPS, =C2=A0 =C2=A0 =C2=A0 =C2=A00, 0, LEDS_GPIO_DEFSTATE_O=
=46F},
> + =C2=A0 =C2=A0 =C2=A0 {"alt", =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, HTCP=
LD_GPIO_LED_ALT, =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0, LEDS_GPIO_DEFSTATE_O=
=46F},
> +};
> +
> +static struct gpio_led_platform_data gpio_leds_data =3D {
> + =C2=A0 =C2=A0 =C2=A0 .leds =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D g=
pio_leds,
> + =C2=A0 =C2=A0 =C2=A0 .num_leds =C2=A0 =C2=A0 =C2=A0 =3D ARRAY_SIZE(=
gpio_leds),
> +};
> +
> +static struct platform_device gpio_leds_device =3D {
> + =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "=
leds-gpio",
> + =C2=A0 =C2=A0 =C2=A0 .id =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D 0,
> + =C2=A0 =C2=A0 =C2=A0 .dev =C2=A0 =C2=A0=3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .platform_data =C2=
=A0=3D &gpio_leds_data,
> + =C2=A0 =C2=A0 =C2=A0 },
> +};
> +
> +/* HTC PLD chips */
> +
> +static struct resource htcpld_resources[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 [0] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .start =C2=A0=3D O=
MAP_GPIO_IRQ(HTCHERALD_GIRQ_BTNS),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .end =C2=A0 =C2=A0=
=3D OMAP_GPIO_IRQ(HTCHERALD_GIRQ_BTNS),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0=3D I=
ORESOURCE_IRQ,
> + =C2=A0 =C2=A0 =C2=A0 },
> +};
> +
> +struct htcpld_chip_platform_data htcpld_chips[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 [0] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .addr =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D 0x03,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .reset =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D 0x04,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .num_gpios =C2=A0 =
=C2=A0 =C2=A0=3D 8,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .gpio_out_base =C2=
=A0=3D HTCPLD_BASE(0, 0),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .gpio_in_base =C2=A0=
 =3D HTCPLD_BASE(4, 0),
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 [1] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .addr =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D 0x04,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .reset =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D 0x8e,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .num_gpios =C2=A0 =
=C2=A0 =C2=A0=3D 8,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .gpio_out_base =C2=
=A0=3D HTCPLD_BASE(1, 0),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .gpio_in_base =C2=A0=
 =3D HTCPLD_BASE(5, 0),
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 [2] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .addr =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D 0x05,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .reset =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D 0x80,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .num_gpios =C2=A0 =
=C2=A0 =C2=A0=3D 8,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .gpio_out_base =C2=
=A0=3D HTCPLD_BASE(2, 0),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .gpio_in_base =C2=A0=
 =3D HTCPLD_BASE(6, 0),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .irq_base =C2=A0 =C2=
=A0 =C2=A0 =3D HTCPLD_IRQ(0, 0),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .num_irqs =C2=A0 =C2=
=A0 =C2=A0 =3D 8,
> + =C2=A0 =C2=A0 =C2=A0 },
> + =C2=A0 =C2=A0 =C2=A0 [3] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .addr =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =3D 0x06,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .reset =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D 0x40,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .num_gpios =C2=A0 =
=C2=A0 =C2=A0=3D 8,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .gpio_out_base =C2=
=A0=3D HTCPLD_BASE(3, 0),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .gpio_in_base =C2=A0=
 =3D HTCPLD_BASE(7, 0),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .irq_base =C2=A0 =C2=
=A0 =C2=A0 =3D HTCPLD_IRQ(1, 0),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .num_irqs =C2=A0 =C2=
=A0 =C2=A0 =3D 8,
> + =C2=A0 =C2=A0 =C2=A0 },
> +};
> +
> +struct htcpld_core_platform_data htcpld_pfdata =3D {
> + =C2=A0 =C2=A0 =C2=A0 .int_reset_gpio_hi =3D HTCPLD_GPIO_INT_RESET_H=
I,
> + =C2=A0 =C2=A0 =C2=A0 .int_reset_gpio_lo =3D HTCPLD_GPIO_INT_RESET_L=
O,
> + =C2=A0 =C2=A0 =C2=A0 .i2c_adapter_id =C2=A0 =C2=A0=3D 1,
> +
> + =C2=A0 =C2=A0 =C2=A0 .chip =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D htcpld_chips,
> + =C2=A0 =C2=A0 =C2=A0 .num_chip =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 ARRAY_SIZE(htcpld_chips),
> +};
> +
> +static struct platform_device htcpld_device =3D {
> + =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "=
i2c-htcpld",
> + =C2=A0 =C2=A0 =C2=A0 .id =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D -1,
> + =C2=A0 =C2=A0 =C2=A0 .resource =C2=A0 =C2=A0 =C2=A0 =3D htcpld_reso=
urces,
> + =C2=A0 =C2=A0 =C2=A0 .num_resources =C2=A0=3D ARRAY_SIZE(htcpld_res=
ources),
> + =C2=A0 =C2=A0 =C2=A0 .dev =C2=A0 =C2=A0=3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .platform_data =C2=
=A0=3D &htcpld_pfdata,
> + =C2=A0 =C2=A0 =C2=A0 },
> +};
> +
> =C2=A0/* USB Device */
> =C2=A0static struct omap_usb_config htcherald_usb_config __initdata =3D=
 {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.otg =3D 0,
> @@ -150,14 +387,45 @@ static struct omap_usb_config htcherald_usb_con=
fig __initdata =3D {
> =C2=A0};
>
> =C2=A0/* LCD Device resources */
> +static struct omap_lcd_config htcherald_lcd_config __initdata =3D {
> + =C2=A0 =C2=A0 =C2=A0 .ctrl_name =C2=A0 =C2=A0 =C2=A0=3D "internal",
> +};
> +
> +static struct omap_board_config_kernel htcherald_config[] __initdata=
 =3D {
> + =C2=A0 =C2=A0 =C2=A0 { OMAP_TAG_LCD, &htcherald_lcd_config },
> +};
> +
> =C2=A0static struct platform_device lcd_device =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 "lcd_htcherald",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.id =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D -1,
> =C2=A0};
>
> +/* MMC Card */
> +#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
> +static struct omap_mmc_platform_data htc_mmc1_data =3D {
> + =C2=A0 =C2=A0 =C2=A0 .nr_slots =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 1,
> + =C2=A0 =C2=A0 =C2=A0 .switch_slot =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D NULL,
> + =C2=A0 =C2=A0 =C2=A0 .slots[0] =C2=A0 =C2=A0 =C2=A0 =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .ocr_mask =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D MMC_VDD_28_29 | MMC_VDD_30_3=
1 |
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
MMC_VDD_32_33 | MMC_VDD_33_34,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "mmcblk",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .nomux =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .wires =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 4,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .switch_pin =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D -1,
> + =C2=A0 =C2=A0 =C2=A0 },
> +};
> +
> +static struct omap_mmc_platform_data *htc_mmc_data[1];
> +#endif
> +
> +
> +/* Platform devices for the Herald */
> =C2=A0static struct platform_device *devices[] __initdata =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0&kp_device,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0&lcd_device,
> + =C2=A0 =C2=A0 =C2=A0 &htcpld_device,
> + =C2=A0 =C2=A0 =C2=A0 &gpio_leds_device,
> + =C2=A0 =C2=A0 =C2=A0 &herald_gpiokeys_device,
> =C2=A0};
>
> =C2=A0/*
> @@ -278,6 +546,7 @@ static void __init htcherald_init(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_INFO "HTC Herald init.\n");
>
> + =C2=A0 =C2=A0 =C2=A0 /* Do board initialization before we register =
all the devices */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_gpio_init();
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_board_config =3D htcherald_config;
> @@ -288,6 +557,13 @@ static void __init htcherald_init(void)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0htcherald_usb_enable();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_usb_init(&htcherald_usb_config);
> +
> + =C2=A0 =C2=A0 =C2=A0 omap_register_i2c_bus(1, 100, NULL, 0);
> +
> +#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
> + =C2=A0 =C2=A0 =C2=A0 htc_mmc_data[0] =3D &htc_mmc1_data;
> + =C2=A0 =C2=A0 =C2=A0 omap1_init_mmc(htc_mmc_data, 1);
> +#endif
> =C2=A0}
>
> =C2=A0static void __init htcherald_init_irq(void)
> --
> 1.6.0.4
>
>

Er, this patch has an issue, please disregard.  V3 to be submitted shor=
tly.
- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
