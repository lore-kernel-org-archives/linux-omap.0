From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3: RX51: Updated rx51_defconfig
Date: Thu, 6 Aug 2009 10:00:04 +0300
Message-ID: <20090806070003.GD7374@atomide.com>
References: <1246022652-25997-1-git-send-email-ext-roger.quadros@nokia.com> <4A79A432.9040505@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55056 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbZHFHAI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 03:00:08 -0400
Content-Disposition: inline
In-Reply-To: <4A79A432.9040505@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: linux-omap@vger.kernel.org

* Roger Quadros <ext-roger.quadros@nokia.com> [090805 18:25]:
> Tony,
>
>  This will be required to get linux-omap booting on rx51.
> any comments on this?

If you manually edit the patch so you only leave the added parts
needed to boot we should be able to get it in as a fix for the -rc
series ;)

Tony

> cheers,
> -roger
>
> ext Roger Quadros wrote:
>> Added REGULATOR, MMC and updated default CMDLINE. Linux-omap
>> now boots on RX51.
>>
>> Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
>> ---
>>  arch/arm/configs/rx51_defconfig |  294 +++++++++++++++++++++++----------------
>>  1 files changed, 172 insertions(+), 122 deletions(-)
>>
>> diff --git a/arch/arm/configs/rx51_defconfig b/arch/arm/configs/rx51_defconfig
>> index eb2cb31..713d707 100644
>> --- a/arch/arm/configs/rx51_defconfig
>> +++ b/arch/arm/configs/rx51_defconfig
>> @@ -1,7 +1,7 @@
>>  #
>>  # Automatically generated make config: don't edit
>> -# Linux kernel version: 2.6.29-rc8
>> -# Fri Mar 13 15:28:56 2009
>> +# Linux kernel version: 2.6.31-rc1-omap1
>> +# Fri Jun 26 15:20:45 2009
>>  #
>>  CONFIG_ARM=y
>>  CONFIG_SYS_SUPPORTS_APM_EMULATION=y
>> @@ -9,7 +9,6 @@ CONFIG_GENERIC_GPIO=y
>>  CONFIG_GENERIC_TIME=y
>>  CONFIG_GENERIC_CLOCKEVENTS=y
>>  CONFIG_MMU=y
>> -# CONFIG_NO_IOPORT is not set
>>  CONFIG_GENERIC_HARDIRQS=y
>>  CONFIG_STACKTRACE_SUPPORT=y
>>  CONFIG_HAVE_LATENCYTOP_SUPPORT=y
>> @@ -18,13 +17,12 @@ CONFIG_TRACE_IRQFLAGS_SUPPORT=y
>>  CONFIG_HARDIRQS_SW_RESEND=y
>>  CONFIG_GENERIC_IRQ_PROBE=y
>>  CONFIG_RWSEM_GENERIC_SPINLOCK=y
>> -# CONFIG_ARCH_HAS_ILOG2_U32 is not set
>> -# CONFIG_ARCH_HAS_ILOG2_U64 is not set
>>  CONFIG_GENERIC_HWEIGHT=y
>>  CONFIG_GENERIC_CALIBRATE_DELAY=y
>>  CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
>>  CONFIG_VECTORS_BASE=0xffff0000
>>  CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
>> +CONFIG_CONSTRUCTORS=y
>>   #
>>  # General setup
>> @@ -38,6 +36,7 @@ CONFIG_SWAP=y
>>  CONFIG_SYSVIPC=y
>>  CONFIG_SYSVIPC_SYSCTL=y
>>  CONFIG_POSIX_MQUEUE=y
>> +CONFIG_POSIX_MQUEUE_SYSCTL=y
>>  CONFIG_BSD_PROCESS_ACCT=y
>>  # CONFIG_BSD_PROCESS_ACCT_V3 is not set
>>  # CONFIG_TASKSTATS is not set
>> @@ -65,6 +64,9 @@ CONFIG_SYSFS_DEPRECATED_V2=y
>>  # CONFIG_NAMESPACES is not set
>>  CONFIG_BLK_DEV_INITRD=y
>>  CONFIG_INITRAMFS_SOURCE=""
>> +CONFIG_RD_GZIP=y
>> +# CONFIG_RD_BZIP2 is not set
>> +# CONFIG_RD_LZMA is not set
>>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>>  CONFIG_SYSCTL=y
>>  CONFIG_ANON_INODES=y
>> @@ -86,18 +88,30 @@ CONFIG_TIMERFD=y
>>  CONFIG_EVENTFD=y
>>  CONFIG_SHMEM=y
>>  CONFIG_AIO=y
>> +
>> +#
>> +# Performance Counters
>> +#
>>  CONFIG_VM_EVENT_COUNTERS=y
>> +# CONFIG_STRIP_ASM_SYMS is not set
>>  CONFIG_COMPAT_BRK=y
>>  CONFIG_SLAB=y
>>  # CONFIG_SLUB is not set
>>  # CONFIG_SLOB is not set
>>  # CONFIG_PROFILING is not set
>> +# CONFIG_MARKERS is not set
>>  CONFIG_HAVE_OPROFILE=y
>>  CONFIG_KPROBES=y
>>  CONFIG_KRETPROBES=y
>>  CONFIG_HAVE_KPROBES=y
>>  CONFIG_HAVE_KRETPROBES=y
>>  CONFIG_HAVE_CLK=y
>> +
>> +#
>> +# GCOV-based kernel profiling
>> +#
>> +# CONFIG_GCOV_KERNEL is not set
>> +# CONFIG_SLOW_WORK is not set
>>  CONFIG_HAVE_GENERIC_DMA_COHERENT=y
>>  CONFIG_SLABINFO=y
>>  CONFIG_RT_MUTEXES=y
>> @@ -109,8 +123,7 @@ CONFIG_MODULE_FORCE_UNLOAD=y
>>  CONFIG_MODVERSIONS=y
>>  CONFIG_MODULE_SRCVERSION_ALL=y
>>  CONFIG_BLOCK=y
>> -# CONFIG_LBD is not set
>> -# CONFIG_BLK_DEV_IO_TRACE is not set
>> +CONFIG_LBDAF=y
>>  # CONFIG_BLK_DEV_BSG is not set
>>  # CONFIG_BLK_DEV_INTEGRITY is not set
>>  @@ -137,12 +150,14 @@ CONFIG_FREEZER=y
>>  # CONFIG_ARCH_VERSATILE is not set
>>  # CONFIG_ARCH_AT91 is not set
>>  # CONFIG_ARCH_CLPS711X is not set
>> +# CONFIG_ARCH_GEMINI is not set
>>  # CONFIG_ARCH_EBSA110 is not set
>>  # CONFIG_ARCH_EP93XX is not set
>>  # CONFIG_ARCH_FOOTBRIDGE is not set
>> +# CONFIG_ARCH_MXC is not set
>> +# CONFIG_ARCH_STMP3XXX is not set
>>  # CONFIG_ARCH_NETX is not set
>>  # CONFIG_ARCH_H720X is not set
>> -# CONFIG_ARCH_IMX is not set
>>  # CONFIG_ARCH_IOP13XX is not set
>>  # CONFIG_ARCH_IOP32X is not set
>>  # CONFIG_ARCH_IOP33X is not set
>> @@ -151,24 +166,25 @@ CONFIG_FREEZER=y
>>  # CONFIG_ARCH_IXP4XX is not set
>>  # CONFIG_ARCH_L7200 is not set
>>  # CONFIG_ARCH_KIRKWOOD is not set
>> -# CONFIG_ARCH_KS8695 is not set
>> -# CONFIG_ARCH_NS9XXX is not set
>>  # CONFIG_ARCH_LOKI is not set
>>  # CONFIG_ARCH_MV78XX0 is not set
>> -# CONFIG_ARCH_MXC is not set
>>  # CONFIG_ARCH_ORION5X is not set
>> +# CONFIG_ARCH_MMP is not set
>> +# CONFIG_ARCH_KS8695 is not set
>> +# CONFIG_ARCH_NS9XXX is not set
>> +# CONFIG_ARCH_W90X900 is not set
>>  # CONFIG_ARCH_PNX4008 is not set
>>  # CONFIG_ARCH_PXA is not set
>> +# CONFIG_ARCH_MSM is not set
>>  # CONFIG_ARCH_RPC is not set
>>  # CONFIG_ARCH_SA1100 is not set
>>  # CONFIG_ARCH_S3C2410 is not set
>>  # CONFIG_ARCH_S3C64XX is not set
>>  # CONFIG_ARCH_SHARK is not set
>>  # CONFIG_ARCH_LH7A40X is not set
>> +# CONFIG_ARCH_U300 is not set
>>  # CONFIG_ARCH_DAVINCI is not set
>>  CONFIG_ARCH_OMAP=y
>> -# CONFIG_ARCH_MSM is not set
>> -# CONFIG_ARCH_W90X900 is not set
>>   #
>>  # TI OMAP Implementations
>> @@ -177,6 +193,7 @@ CONFIG_ARCH_OMAP_OTG=y
>>  # CONFIG_ARCH_OMAP1 is not set
>>  # CONFIG_ARCH_OMAP2 is not set
>>  CONFIG_ARCH_OMAP3=y
>> +# CONFIG_ARCH_OMAP4 is not set
>>   #
>>  # OMAP Feature Selections
>> @@ -188,6 +205,7 @@ CONFIG_OMAP_MUX=y
>>  CONFIG_OMAP_MUX_DEBUG=y
>>  CONFIG_OMAP_MUX_WARNINGS=y
>>  CONFIG_OMAP_MCBSP=y
>> +# CONFIG_OMAP_MBOX_FWK is not set
>>  # CONFIG_OMAP_MPU_TIMER is not set
>>  CONFIG_OMAP_32K_TIMER=y
>>  CONFIG_OMAP_32K_TIMER_HZ=128
>> @@ -195,19 +213,20 @@ CONFIG_OMAP_DM_TIMER=y
>>  # CONFIG_OMAP_LL_DEBUG_UART1 is not set
>>  # CONFIG_OMAP_LL_DEBUG_UART2 is not set
>>  CONFIG_OMAP_LL_DEBUG_UART3=y
>> -CONFIG_OMAP_SERIAL_WAKE=y
>>  CONFIG_ARCH_OMAP34XX=y
>>  CONFIG_ARCH_OMAP3430=y
>>   #
>>  # OMAP Board Type
>>  #
>> -# CONFIG_MACH_OMAP3_BEAGLE is not set
>> +CONFIG_MACH_NOKIA_RX51=y
>>  # CONFIG_MACH_OMAP_LDP is not set
>> +# CONFIG_MACH_OMAP_3430SDP is not set
>> +# CONFIG_MACH_OMAP3EVM is not set
>> +# CONFIG_MACH_OMAP3_BEAGLE is not set
>>  # CONFIG_MACH_OVERO is not set
>>  # CONFIG_MACH_OMAP3_PANDORA is not set
>> -# CONFIG_MACH_OMAP_3430SDP is not set
>> -CONFIG_MACH_NOKIA_RX51=y
>> +# CONFIG_MACH_OMAP_ZOOM2 is not set
>>   #
>>  # Processor Type
>> @@ -235,7 +254,10 @@ CONFIG_ARM_THUMB=y
>>  # CONFIG_CPU_DCACHE_DISABLE is not set
>>  # CONFIG_CPU_BPREDICT_DISABLE is not set
>>  CONFIG_HAS_TLS_REG=y
>> -# CONFIG_OUTER_CACHE is not set
>> +# CONFIG_ARM_ERRATA_430973 is not set
>> +# CONFIG_ARM_ERRATA_458693 is not set
>> +# CONFIG_ARM_ERRATA_460075 is not set
>> +CONFIG_COMMON_CLKDEV=y
>>   #
>>  # Bus support
>> @@ -259,9 +281,9 @@ CONFIG_PAGE_OFFSET=0xC0000000
>>  CONFIG_HZ=128
>>  CONFIG_AEABI=y
>>  # CONFIG_OABI_COMPAT is not set
>> -CONFIG_ARCH_FLATMEM_HAS_HOLES=y
>>  # CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
>>  # CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
>> +# CONFIG_HIGHMEM is not set
>>  CONFIG_SELECT_MEMORY_MODEL=y
>>  CONFIG_FLATMEM_MANUAL=y
>>  # CONFIG_DISCONTIGMEM_MANUAL is not set
>> @@ -273,16 +295,19 @@ CONFIG_SPLIT_PTLOCK_CPUS=4
>>  # CONFIG_PHYS_ADDR_T_64BIT is not set
>>  CONFIG_ZONE_DMA_FLAG=0
>>  CONFIG_VIRT_TO_BUS=y
>> -CONFIG_UNEVICTABLE_LRU=y
>> +CONFIG_HAVE_MLOCK=y
>> +CONFIG_HAVE_MLOCKED_PAGE_BIT=y
>> +CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
>>  # CONFIG_LEDS is not set
>>  CONFIG_ALIGNMENT_TRAP=y
>> +# CONFIG_UACCESS_WITH_MEMCPY is not set
>>   #
>>  # Boot options
>>  #
>>  CONFIG_ZBOOT_ROM_TEXT=0x0
>>  CONFIG_ZBOOT_ROM_BSS=0x0
>> -CONFIG_CMDLINE="init=/sbin/preinit ubi.mtd=rootfs root=ubi0:rootfs rootfstype=ubifs rootflags=bulk_read,no_chk_data_crc rw console=ttyMTD,log console=tty0"
>> +CONFIG_CMDLINE="init=/sbin/preinit ubi.mtd=rootfs root=ubi0:rootfs rootfstype=ubifs rootflags=bulk_read,no_chk_data_crc rw console=ttyMTD,log console=tty0 console=ttyS2,115200n8"
>>  # CONFIG_XIP_KERNEL is not set
>>  # CONFIG_KEXEC is not set
>>  @@ -329,7 +354,6 @@ CONFIG_NET=y
>>  #
>>  # Networking options
>>  #
>> -CONFIG_COMPAT_NET_DEV_OPS=y
>>  CONFIG_PACKET=y
>>  # CONFIG_PACKET_MMAP is not set
>>  CONFIG_UNIX=y
>> @@ -392,6 +416,7 @@ CONFIG_NETFILTER_XTABLES=m
>>  # CONFIG_NETFILTER_XT_MATCH_DSCP is not set
>>  # CONFIG_NETFILTER_XT_MATCH_ESP is not set
>>  # CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
>> +# CONFIG_NETFILTER_XT_MATCH_HL is not set
>>  # CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set
>>  # CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
>>  # CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
>> @@ -428,6 +453,7 @@ CONFIG_IP_NF_FILTER=m
>>  # CONFIG_IP_NF_TARGET_LOG is not set
>>  # CONFIG_IP_NF_TARGET_ULOG is not set
>>  # CONFIG_IP_NF_MANGLE is not set
>> +# CONFIG_IP_NF_TARGET_TTL is not set
>>  # CONFIG_IP_NF_RAW is not set
>>  # CONFIG_IP_NF_SECURITY is not set
>>  # CONFIG_IP_NF_ARPTABLES is not set
>> @@ -446,6 +472,8 @@ CONFIG_IP_NF_FILTER=m
>>  # CONFIG_LAPB is not set
>>  # CONFIG_ECONET is not set
>>  # CONFIG_WAN_ROUTER is not set
>> +# CONFIG_PHONET is not set
>> +# CONFIG_IEEE802154 is not set
>>  # CONFIG_NET_SCHED is not set
>>  # CONFIG_DCB is not set
>>  @@ -478,16 +506,17 @@ CONFIG_BT_HIDP=m
>>  # CONFIG_BT_HCIBFUSB is not set
>>  # CONFIG_BT_HCIVHCI is not set
>>  # CONFIG_AF_RXRPC is not set
>> -# CONFIG_PHONET is not set
>>  CONFIG_WIRELESS=y
>>  CONFIG_CFG80211=y
>>  # CONFIG_CFG80211_REG_DEBUG is not set
>> -CONFIG_NL80211=y
>> +# CONFIG_CFG80211_DEBUGFS is not set
>>  CONFIG_WIRELESS_OLD_REGULATORY=y
>>  CONFIG_WIRELESS_EXT=y
>>  CONFIG_WIRELESS_EXT_SYSFS=y
>>  # CONFIG_LIB80211 is not set
>>  CONFIG_MAC80211=m
>> +CONFIG_MAC80211_DEFAULT_PS=y
>> +CONFIG_MAC80211_DEFAULT_PS_VALUE=1
>>   #
>>  # Rate control algorithm selection
>> @@ -634,9 +663,12 @@ CONFIG_BLK_DEV_RAM_SIZE=4096
>>  # CONFIG_BLK_DEV_XIP is not set
>>  # CONFIG_CDROM_PKTCDVD is not set
>>  # CONFIG_ATA_OVER_ETH is not set
>> +# CONFIG_MG_DISK is not set
>>  CONFIG_MISC_DEVICES=y
>>  # CONFIG_ICS932S401 is not set
>> +# CONFIG_OMAP_STI is not set
>>  # CONFIG_ENCLOSURE_SERVICES is not set
>> +# CONFIG_ISL29003 is not set
>>  # CONFIG_C2PORT is not set
>>   #
>> @@ -645,6 +677,7 @@ CONFIG_MISC_DEVICES=y
>>  # CONFIG_EEPROM_AT24 is not set
>>  # CONFIG_EEPROM_AT25 is not set
>>  # CONFIG_EEPROM_LEGACY is not set
>> +# CONFIG_EEPROM_MAX6875 is not set
>>  # CONFIG_EEPROM_93CX6 is not set
>>  CONFIG_HAVE_IDE=y
>>  # CONFIG_IDE is not set
>> @@ -668,10 +701,6 @@ CONFIG_BLK_DEV_SD=m
>>  # CONFIG_BLK_DEV_SR is not set
>>  # CONFIG_CHR_DEV_SG is not set
>>  # CONFIG_CHR_DEV_SCH is not set
>> -
>> -#
>> -# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
>> -#
>>  CONFIG_SCSI_MULTI_LUN=y
>>  # CONFIG_SCSI_CONSTANTS is not set
>>  # CONFIG_SCSI_LOGGING is not set
>> @@ -689,8 +718,10 @@ CONFIG_SCSI_WAIT_SCAN=m
>>  CONFIG_SCSI_LOWLEVEL=y
>>  # CONFIG_ISCSI_TCP is not set
>>  # CONFIG_LIBFC is not set
>> +# CONFIG_LIBFCOE is not set
>>  # CONFIG_SCSI_DEBUG is not set
>>  # CONFIG_SCSI_DH is not set
>> +# CONFIG_SCSI_OSD_INITIATOR is not set
>>  # CONFIG_ATA is not set
>>  # CONFIG_MD is not set
>>  CONFIG_NETDEVICES=y
>> @@ -707,8 +738,10 @@ CONFIG_MII=m
>>  CONFIG_SMC91X=m
>>  # CONFIG_DM9000 is not set
>>  # CONFIG_ENC28J60 is not set
>> +# CONFIG_ETHOC is not set
>>  # CONFIG_SMC911X is not set
>>  # CONFIG_SMSC911X is not set
>> +# CONFIG_DNET is not set
>>  # CONFIG_IBM_NEW_EMAC_ZMII is not set
>>  # CONFIG_IBM_NEW_EMAC_RGMII is not set
>>  # CONFIG_IBM_NEW_EMAC_TAH is not set
>> @@ -717,6 +750,7 @@ CONFIG_SMC91X=m
>>  # CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
>>  # CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
>>  # CONFIG_B44 is not set
>> +# CONFIG_KS8842 is not set
>>  # CONFIG_NETDEV_1000 is not set
>>  # CONFIG_NETDEV_10000 is not set
>>  @@ -727,17 +761,20 @@ CONFIG_SMC91X=m
>>  CONFIG_WLAN_80211=y
>>  # CONFIG_LIBERTAS is not set
>>  # CONFIG_LIBERTAS_THINFIRM is not set
>> +# CONFIG_AT76C50X_USB is not set
>>  # CONFIG_USB_ZD1201 is not set
>>  # CONFIG_USB_NET_RNDIS_WLAN is not set
>>  # CONFIG_RTL8187 is not set
>>  # CONFIG_MAC80211_HWSIM is not set
>>  # CONFIG_P54_COMMON is not set
>> -# CONFIG_IWLWIFI_LEDS is not set
>> +# CONFIG_AR9170_USB is not set
>>  # CONFIG_HOSTAP is not set
>>  # CONFIG_B43 is not set
>>  # CONFIG_B43LEGACY is not set
>>  # CONFIG_ZD1211RW is not set
>>  # CONFIG_RT2X00 is not set
>> +# CONFIG_WL12XX is not set
>> +# CONFIG_IWM is not set
>>   #
>>  # Enable WiMAX (Networking options) to see the WiMAX drivers
>> @@ -784,12 +821,18 @@ CONFIG_INPUT_KEYBOARD=y
>>  # CONFIG_KEYBOARD_XTKBD is not set
>>  # CONFIG_KEYBOARD_NEWTON is not set
>>  # CONFIG_KEYBOARD_STOWAWAY is not set
>> +# CONFIG_KEYBOARD_LM8323 is not set
>>  # CONFIG_KEYBOARD_GPIO is not set
>>  # CONFIG_INPUT_MOUSE is not set
>>  # CONFIG_INPUT_JOYSTICK is not set
>>  # CONFIG_INPUT_TABLET is not set
>>  CONFIG_INPUT_TOUCHSCREEN=y
>>  # CONFIG_TOUCHSCREEN_ADS7846 is not set
>> +# CONFIG_TOUCHSCREEN_AD7877 is not set
>> +# CONFIG_TOUCHSCREEN_AD7879_I2C is not set
>> +# CONFIG_TOUCHSCREEN_AD7879_SPI is not set
>> +# CONFIG_TOUCHSCREEN_AD7879 is not set
>> +# CONFIG_TOUCHSCREEN_EETI is not set
>>  # CONFIG_TOUCHSCREEN_FUJITSU is not set
>>  # CONFIG_TOUCHSCREEN_GUNZE is not set
>>  # CONFIG_TOUCHSCREEN_ELO is not set
>> @@ -803,6 +846,7 @@ CONFIG_INPUT_TOUCHSCREEN=y
>>  # CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
>>  # CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
>>  # CONFIG_TOUCHSCREEN_TSC2007 is not set
>> +# CONFIG_TOUCHSCREEN_W90X900 is not set
>>  CONFIG_INPUT_MISC=y
>>  # CONFIG_INPUT_ATI_REMOTE is not set
>>  # CONFIG_INPUT_ATI_REMOTE2 is not set
>> @@ -810,7 +854,9 @@ CONFIG_INPUT_MISC=y
>>  # CONFIG_INPUT_POWERMATE is not set
>>  # CONFIG_INPUT_YEALINK is not set
>>  # CONFIG_INPUT_CM109 is not set
>> +# CONFIG_INPUT_TWL4030_PWRBUTTON is not set
>>  CONFIG_INPUT_UINPUT=m
>> +# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
>>   #
>>  # Hardware I/O ports
>> @@ -841,6 +887,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
>>  #
>>  # Non-8250 serial port support
>>  #
>> +# CONFIG_SERIAL_MAX3100 is not set
>>  CONFIG_SERIAL_CORE=y
>>  CONFIG_SERIAL_CORE_CONSOLE=y
>>  CONFIG_UNIX98_PTYS=y
>> @@ -848,6 +895,7 @@ CONFIG_UNIX98_PTYS=y
>>  # CONFIG_LEGACY_PTYS is not set
>>  # CONFIG_IPMI_HANDLER is not set
>>  CONFIG_HW_RANDOM=m
>> +# CONFIG_HW_RANDOM_TIMERIOMEM is not set
>>  # CONFIG_R3964 is not set
>>  # CONFIG_RAW_DRIVER is not set
>>  # CONFIG_TCG_TPM is not set
>> @@ -863,6 +911,7 @@ CONFIG_I2C_HELPER_AUTO=y
>>  #
>>  # I2C system bus drivers (mostly embedded / system-on-chip)
>>  #
>> +# CONFIG_I2C_DESIGNWARE is not set
>>  # CONFIG_I2C_GPIO is not set
>>  # CONFIG_I2C_OCORES is not set
>>  CONFIG_I2C_OMAP=y
>> @@ -888,8 +937,6 @@ CONFIG_I2C_OMAP=y
>>  # CONFIG_SENSORS_PCF8574 is not set
>>  # CONFIG_PCF8575 is not set
>>  # CONFIG_SENSORS_PCA9539 is not set
>> -# CONFIG_SENSORS_PCF8591 is not set
>> -# CONFIG_SENSORS_MAX6875 is not set
>>  # CONFIG_SENSORS_TSL2550 is not set
>>  # CONFIG_I2C_DEBUG_CORE is not set
>>  # CONFIG_I2C_DEBUG_ALGO is not set
>> @@ -959,6 +1006,7 @@ CONFIG_HWMON=y
>>  # CONFIG_SENSORS_F71805F is not set
>>  # CONFIG_SENSORS_F71882FG is not set
>>  # CONFIG_SENSORS_F75375S is not set
>> +# CONFIG_SENSORS_G760A is not set
>>  # CONFIG_SENSORS_GL518SM is not set
>>  # CONFIG_SENSORS_GL520SM is not set
>>  # CONFIG_SENSORS_IT87 is not set
>> @@ -974,18 +1022,23 @@ CONFIG_HWMON=y
>>  # CONFIG_SENSORS_LM90 is not set
>>  # CONFIG_SENSORS_LM92 is not set
>>  # CONFIG_SENSORS_LM93 is not set
>> +# CONFIG_SENSORS_LTC4215 is not set
>>  # CONFIG_SENSORS_LTC4245 is not set
>> +# CONFIG_SENSORS_LM95241 is not set
>>  # CONFIG_SENSORS_MAX1111 is not set
>>  # CONFIG_SENSORS_MAX1619 is not set
>>  # CONFIG_SENSORS_MAX6650 is not set
>>  # CONFIG_SENSORS_PC87360 is not set
>>  # CONFIG_SENSORS_PC87427 is not set
>> +# CONFIG_SENSORS_PCF8591 is not set
>> +# CONFIG_SENSORS_SHT15 is not set
>>  # CONFIG_SENSORS_DME1737 is not set
>>  # CONFIG_SENSORS_SMSC47M1 is not set
>>  # CONFIG_SENSORS_SMSC47M192 is not set
>>  # CONFIG_SENSORS_SMSC47B397 is not set
>>  # CONFIG_SENSORS_ADS7828 is not set
>>  # CONFIG_SENSORS_THMC50 is not set
>> +# CONFIG_SENSORS_TMP401 is not set
>>  # CONFIG_SENSORS_VT1211 is not set
>>  # CONFIG_SENSORS_W83781D is not set
>>  # CONFIG_SENSORS_W83791D is not set
>> @@ -995,6 +1048,9 @@ CONFIG_HWMON=y
>>  # CONFIG_SENSORS_W83L786NG is not set
>>  # CONFIG_SENSORS_W83627HF is not set
>>  # CONFIG_SENSORS_W83627EHF is not set
>> +# CONFIG_SENSORS_LIS3_SPI is not set
>> +# CONFIG_SENSORS_TSC210X is not set
>> +# CONFIG_SENSORS_OMAP34XX is not set
>>  # CONFIG_HWMON_DEBUG_CHIP is not set
>>  # CONFIG_THERMAL is not set
>>  # CONFIG_THERMAL_HWMON is not set
>> @@ -1006,6 +1062,7 @@ CONFIG_WATCHDOG=y
>>  #
>>  # CONFIG_SOFT_WATCHDOG is not set
>>  CONFIG_OMAP_WATCHDOG=m
>> +# CONFIG_TWL4030_WATCHDOG is not set
>>   #
>>  # USB-based Watchdog Cards
>> @@ -1036,74 +1093,9 @@ CONFIG_TWL4030_CORE=y
>>  # CONFIG_MFD_WM8400 is not set
>>  # CONFIG_MFD_WM8350_I2C is not set
>>  # CONFIG_MFD_PCF50633 is not set
>> -
>> -#
>> -# Multimedia devices
>> -#
>> -
>> -#
>> -# Multimedia core support
>> -#
>> -CONFIG_VIDEO_DEV=m
>> -CONFIG_VIDEO_V4L2_COMMON=m
>> -CONFIG_VIDEO_ALLOW_V4L1=y
>> -CONFIG_VIDEO_V4L1_COMPAT=y
>> -# CONFIG_DVB_CORE is not set
>> -CONFIG_VIDEO_MEDIA=m
>> -
>> -#
>> -# Multimedia drivers
>> -#
>> -# CONFIG_MEDIA_ATTACH is not set
>> -CONFIG_MEDIA_TUNER=m
>> -# CONFIG_MEDIA_TUNER_CUSTOMIZE is not set
>> -CONFIG_MEDIA_TUNER_SIMPLE=m
>> -CONFIG_MEDIA_TUNER_TDA8290=m
>> -CONFIG_MEDIA_TUNER_TDA9887=m
>> -CONFIG_MEDIA_TUNER_TEA5761=m
>> -CONFIG_MEDIA_TUNER_TEA5767=m
>> -CONFIG_MEDIA_TUNER_MT20XX=m
>> -CONFIG_MEDIA_TUNER_XC2028=m
>> -CONFIG_MEDIA_TUNER_XC5000=m
>> -CONFIG_VIDEO_V4L2=m
>> -CONFIG_VIDEO_V4L1=m
>> -CONFIG_VIDEO_CAPTURE_DRIVERS=y
>> -# CONFIG_VIDEO_ADV_DEBUG is not set
>> -# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
>> -CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
>> -# CONFIG_VIDEO_VIVI is not set
>> -# CONFIG_VIDEO_CPIA is not set
>> -# CONFIG_VIDEO_CPIA2 is not set
>> -# CONFIG_VIDEO_SAA5246A is not set
>> -# CONFIG_VIDEO_SAA5249 is not set
>> -# CONFIG_SOC_CAMERA is not set
>> -CONFIG_V4L_USB_DRIVERS=y
>> -# CONFIG_USB_VIDEO_CLASS is not set
>> -# CONFIG_USB_GSPCA is not set
>> -# CONFIG_VIDEO_PVRUSB2 is not set
>> -# CONFIG_VIDEO_EM28XX is not set
>> -# CONFIG_VIDEO_USBVISION is not set
>> -# CONFIG_USB_VICAM is not set
>> -# CONFIG_USB_IBMCAM is not set
>> -# CONFIG_USB_KONICAWC is not set
>> -# CONFIG_USB_QUICKCAM_MESSENGER is not set
>> -# CONFIG_USB_ET61X251 is not set
>> -# CONFIG_VIDEO_OVCAMCHIP is not set
>> -# CONFIG_USB_OV511 is not set
>> -# CONFIG_USB_SE401 is not set
>> -# CONFIG_USB_SN9C102 is not set
>> -# CONFIG_USB_STV680 is not set
>> -# CONFIG_USB_ZC0301 is not set
>> -# CONFIG_USB_PWC is not set
>> -# CONFIG_USB_ZR364XX is not set
>> -# CONFIG_USB_STKWEBCAM is not set
>> -# CONFIG_USB_S2255 is not set
>> -CONFIG_RADIO_ADAPTERS=y
>> -# CONFIG_USB_DSBR is not set
>> -# CONFIG_USB_SI470X is not set
>> -# CONFIG_USB_MR800 is not set
>> -# CONFIG_RADIO_TEA5764 is not set
>> -# CONFIG_DAB is not set
>> +# CONFIG_AB3100_CORE is not set
>> +# CONFIG_EZX_PCAP is not set
>> +# CONFIG_MEDIA_SUPPORT is not set
>>   #
>>  # Graphics support
>> @@ -1132,6 +1124,7 @@ CONFIG_SOUND=y
>>  CONFIG_SND=y
>>  CONFIG_SND_TIMER=y
>>  CONFIG_SND_PCM=y
>> +CONFIG_SND_JACK=y
>>  # CONFIG_SND_SEQUENCER is not set
>>  # CONFIG_SND_MIXER_OSS is not set
>>  # CONFIG_SND_PCM_OSS is not set
>> @@ -1141,6 +1134,11 @@ CONFIG_SND_SUPPORT_OLD_API=y
>>  CONFIG_SND_VERBOSE_PROCFS=y
>>  # CONFIG_SND_VERBOSE_PRINTK is not set
>>  # CONFIG_SND_DEBUG is not set
>> +# CONFIG_SND_RAWMIDI_SEQ is not set
>> +# CONFIG_SND_OPL3_LIB_SEQ is not set
>> +# CONFIG_SND_OPL4_LIB_SEQ is not set
>> +# CONFIG_SND_SBAWE_SEQ is not set
>> +# CONFIG_SND_EMU10K1_SEQ is not set
>>  CONFIG_SND_DRIVERS=y
>>  # CONFIG_SND_DUMMY is not set
>>  # CONFIG_SND_MTPAV is not set
>> @@ -1175,15 +1173,17 @@ CONFIG_USB_HID=m
>>  #
>>  # Special HID drivers
>>  #
>> -CONFIG_HID_COMPAT=y
>>  CONFIG_HID_A4TECH=m
>>  CONFIG_HID_APPLE=m
>>  CONFIG_HID_BELKIN=m
>>  CONFIG_HID_CHERRY=m
>>  CONFIG_HID_CHICONY=m
>>  CONFIG_HID_CYPRESS=m
>> +# CONFIG_HID_DRAGONRISE is not set
>>  CONFIG_HID_EZKEY=m
>> +# CONFIG_HID_KYE is not set
>>  CONFIG_HID_GYRATION=m
>> +# CONFIG_HID_KENSINGTON is not set
>>  CONFIG_HID_LOGITECH=m
>>  # CONFIG_LOGITECH_FF is not set
>>  # CONFIG_LOGIRUMBLEPAD2_FF is not set
>> @@ -1196,14 +1196,16 @@ CONFIG_HID_PETALYNX=m
>>  CONFIG_HID_SAMSUNG=m
>>  CONFIG_HID_SONY=m
>>  CONFIG_HID_SUNPLUS=m
>> -# CONFIG_GREENASIA_FF is not set
>> +# CONFIG_HID_GREENASIA is not set
>> +# CONFIG_HID_SMARTJOYPLUS is not set
>>  # CONFIG_HID_TOPSEED is not set
>> -# CONFIG_THRUSTMASTER_FF is not set
>> -# CONFIG_ZEROPLUS_FF is not set
>> +# CONFIG_HID_THRUSTMASTER is not set
>> +# CONFIG_HID_WACOM is not set
>> +# CONFIG_HID_ZEROPLUS is not set
>>  CONFIG_USB_SUPPORT=y
>>  CONFIG_USB_ARCH_HAS_HCD=y
>>  CONFIG_USB_ARCH_HAS_OHCI=y
>> -# CONFIG_USB_ARCH_HAS_EHCI is not set
>> +CONFIG_USB_ARCH_HAS_EHCI=y
>>  CONFIG_USB=y
>>  CONFIG_USB_DEBUG=y
>>  CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
>> @@ -1226,8 +1228,10 @@ CONFIG_USB_MON=y
>>  # USB Host Controller Drivers
>>  #
>>  # CONFIG_USB_C67X00_HCD is not set
>> +# CONFIG_USB_EHCI_HCD is not set
>>  # CONFIG_USB_OXU210HP_HCD is not set
>>  # CONFIG_USB_ISP116X_HCD is not set
>> +# CONFIG_USB_ISP1760_HCD is not set
>>  # CONFIG_USB_OHCI_HCD is not set
>>  # CONFIG_USB_SL811_HCD is not set
>>  # CONFIG_USB_R8A66597_HCD is not set
>> @@ -1257,11 +1261,11 @@ CONFIG_USB_INVENTRA_DMA=y
>>  # CONFIG_USB_TMC is not set
>>   #
>> -# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may also be needed;
>> +# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
>>  #
>>   #
>> -# see USB_STORAGE Help for more information
>> +# also be needed; see USB_STORAGE Help for more info
>>  #
>>  CONFIG_USB_STORAGE=m
>>  # CONFIG_USB_STORAGE_DEBUG is not set
>> @@ -1303,10 +1307,10 @@ CONFIG_USB_LIBUSUAL=y
>>  # CONFIG_USB_LED is not set
>>  # CONFIG_USB_CYPRESS_CY7C63 is not set
>>  # CONFIG_USB_CYTHERM is not set
>> -# CONFIG_USB_PHIDGET is not set
>>  # CONFIG_USB_IDMOUSE is not set
>>  # CONFIG_USB_FTDI_ELAN is not set
>>  # CONFIG_USB_APPLEDISPLAY is not set
>> +# CONFIG_USB_SISUSBVGA is not set
>>  # CONFIG_USB_LD is not set
>>  # CONFIG_USB_TRANCEVIBRATOR is not set
>>  # CONFIG_USB_IOWARRIOR is not set
>> @@ -1326,6 +1330,7 @@ CONFIG_USB_GADGET_SELECTED=y
>>  # CONFIG_USB_GADGET_OMAP is not set
>>  # CONFIG_USB_GADGET_PXA25X is not set
>>  # CONFIG_USB_GADGET_PXA27X is not set
>> +# CONFIG_USB_GADGET_S3C_HSOTG is not set
>>  # CONFIG_USB_GADGET_S3C2410 is not set
>>  # CONFIG_USB_GADGET_IMX is not set
>>  # CONFIG_USB_GADGET_M66592 is not set
>> @@ -1334,10 +1339,12 @@ CONFIG_USB_GADGET_SELECTED=y
>>  # CONFIG_USB_GADGET_CI13XXX is not set
>>  # CONFIG_USB_GADGET_NET2280 is not set
>>  # CONFIG_USB_GADGET_GOKU is not set
>> +# CONFIG_USB_GADGET_LANGWELL is not set
>>  # CONFIG_USB_GADGET_DUMMY_HCD is not set
>>  CONFIG_USB_GADGET_DUALSPEED=y
>>  CONFIG_USB_ZERO=m
>>  # CONFIG_USB_ZERO_HNPTEST is not set
>> +# CONFIG_USB_AUDIO is not set
>>  # CONFIG_USB_ETH is not set
>>  # CONFIG_USB_GADGETFS is not set
>>  CONFIG_USB_FILE_STORAGE=m
>> @@ -1354,7 +1361,8 @@ CONFIG_USB_OTG_UTILS=y
>>  # CONFIG_USB_GPIO_VBUS is not set
>>  # CONFIG_ISP1301_OMAP is not set
>>  CONFIG_TWL4030_USB=y
>> -CONFIG_MMC=m
>> +# CONFIG_NOP_USB_XCEIV is not set
>> +CONFIG_MMC=y
>>  # CONFIG_MMC_DEBUG is not set
>>  # CONFIG_MMC_UNSAFE_RESUME is not set
>>  @@ -1370,7 +1378,6 @@ CONFIG_MMC_BLOCK_BOUNCE=y
>>  # MMC/SD/SDIO Host Controller Drivers
>>  #
>>  # CONFIG_MMC_SDHCI is not set
>> -# CONFIG_MMC_OMAP is not set
>>  CONFIG_MMC_OMAP_HS=m
>>  # CONFIG_MMC_SPI is not set
>>  # CONFIG_MEMSTICK is not set
>> @@ -1381,9 +1388,14 @@ CONFIG_LEDS_CLASS=m
>>  #
>>  # LED drivers
>>  #
>> +# CONFIG_LEDS_OMAP is not set
>> +# CONFIG_LEDS_OMAP_PWM is not set
>>  # CONFIG_LEDS_PCA9532 is not set
>>  # CONFIG_LEDS_GPIO is not set
>> +# CONFIG_LEDS_LP5521 is not set
>>  # CONFIG_LEDS_PCA955X is not set
>> +# CONFIG_LEDS_DAC124S085 is not set
>> +# CONFIG_LEDS_BD2802 is not set
>>   #
>>  # LED Triggers
>> @@ -1418,6 +1430,7 @@ CONFIG_RTC_DRV_TWL4030=m
>>  # CONFIG_RTC_DRV_S35390A is not set
>>  # CONFIG_RTC_DRV_FM3130 is not set
>>  # CONFIG_RTC_DRV_RX8581 is not set
>> +# CONFIG_RTC_DRV_RX8025 is not set
>>   #
>>  # SPI RTC drivers
>> @@ -1449,17 +1462,32 @@ CONFIG_RTC_DRV_TWL4030=m
>>  # on-CPU RTC drivers
>>  #
>>  # CONFIG_DMADEVICES is not set
>> -# CONFIG_REGULATOR is not set
>> +# CONFIG_AUXDISPLAY is not set
>> +CONFIG_REGULATOR=y
>> +CONFIG_REGULATOR_DEBUG=y
>> +CONFIG_REGULATOR_FIXED_VOLTAGE=y
>> +CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
>> +CONFIG_REGULATOR_USERSPACE_CONSUMER=y
>> +# CONFIG_REGULATOR_BQ24022 is not set
>> +# CONFIG_REGULATOR_MAX1586 is not set
>> +CONFIG_REGULATOR_TWL4030=y
>> +# CONFIG_REGULATOR_LP3971 is not set
>>  # CONFIG_UIO is not set
>>  # CONFIG_STAGING is not set
>>   #
>> +# CBUS support
>> +#
>> +# CONFIG_CBUS is not set
>> +
>> +#
>>  # File systems
>>  #
>>  CONFIG_EXT2_FS=m
>>  # CONFIG_EXT2_FS_XATTR is not set
>>  # CONFIG_EXT2_FS_XIP is not set
>>  CONFIG_EXT3_FS=m
>> +# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
>>  # CONFIG_EXT3_FS_XATTR is not set
>>  # CONFIG_EXT4_FS is not set
>>  CONFIG_JBD=m
>> @@ -1467,10 +1495,12 @@ CONFIG_JBD=m
>>  # CONFIG_REISERFS_FS is not set
>>  # CONFIG_JFS_FS is not set
>>  # CONFIG_FS_POSIX_ACL is not set
>> -CONFIG_FILE_LOCKING=y
>>  # CONFIG_XFS_FS is not set
>> +# CONFIG_GFS2_FS is not set
>>  # CONFIG_OCFS2_FS is not set
>>  # CONFIG_BTRFS_FS is not set
>> +CONFIG_FILE_LOCKING=y
>> +CONFIG_FSNOTIFY=y
>>  CONFIG_DNOTIFY=y
>>  CONFIG_INOTIFY=y
>>  CONFIG_INOTIFY_USER=y
>> @@ -1484,6 +1514,12 @@ CONFIG_QUOTACTL=y
>>  # CONFIG_AUTOFS_FS is not set
>>  # CONFIG_AUTOFS4_FS is not set
>>  CONFIG_FUSE_FS=m
>> +# CONFIG_CUSE is not set
>> +
>> +#
>> +# Caches
>> +#
>> +# CONFIG_FSCACHE is not set
>>   #
>>  # CD-ROM/DVD Filesystems
>> @@ -1537,18 +1573,19 @@ CONFIG_CRAMFS=y
>>  # CONFIG_ROMFS_FS is not set
>>  # CONFIG_SYSV_FS is not set
>>  # CONFIG_UFS_FS is not set
>> +# CONFIG_NILFS2_FS is not set
>>  CONFIG_NETWORK_FILESYSTEMS=y
>>  CONFIG_NFS_FS=m
>>  CONFIG_NFS_V3=y
>>  # CONFIG_NFS_V3_ACL is not set
>>  CONFIG_NFS_V4=y
>> +# CONFIG_NFS_V4_1 is not set
>>  # CONFIG_NFSD is not set
>>  CONFIG_LOCKD=m
>>  CONFIG_LOCKD_V4=y
>>  CONFIG_NFS_COMMON=y
>>  CONFIG_SUNRPC=m
>>  CONFIG_SUNRPC_GSS=m
>> -# CONFIG_SUNRPC_REGISTER_V4 is not set
>>  CONFIG_RPCSEC_GSS_KRB5=m
>>  # CONFIG_RPCSEC_GSS_SPKM3 is not set
>>  # CONFIG_SMB_FS is not set
>> @@ -1636,11 +1673,15 @@ CONFIG_DEBUG_KERNEL=y
>>  CONFIG_DETECT_SOFTLOCKUP=y
>>  # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
>>  CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
>> +CONFIG_DETECT_HUNG_TASK=y
>> +# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
>> +CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
>>  CONFIG_SCHED_DEBUG=y
>>  # CONFIG_SCHEDSTATS is not set
>>  CONFIG_TIMER_STATS=y
>>  # CONFIG_DEBUG_OBJECTS is not set
>>  # CONFIG_DEBUG_SLAB is not set
>> +# CONFIG_DEBUG_KMEMLEAK is not set
>>  # CONFIG_DEBUG_RT_MUTEXES is not set
>>  # CONFIG_RT_MUTEX_TESTER is not set
>>  CONFIG_DEBUG_SPINLOCK=y
>> @@ -1663,7 +1704,6 @@ CONFIG_DEBUG_INFO=y
>>  # CONFIG_DEBUG_LIST is not set
>>  # CONFIG_DEBUG_SG is not set
>>  # CONFIG_DEBUG_NOTIFIERS is not set
>> -CONFIG_FRAME_POINTER=y
>>  # CONFIG_BOOT_PRINTK_DELAY is not set
>>  # CONFIG_RCU_TORTURE_TEST is not set
>>  # CONFIG_RCU_CPU_STALL_DETECTOR is not set
>> @@ -1673,22 +1713,27 @@ CONFIG_FRAME_POINTER=y
>>  # CONFIG_LKDTM is not set
>>  # CONFIG_FAULT_INJECTION is not set
>>  # CONFIG_LATENCYTOP is not set
>> +# CONFIG_PAGE_POISONING is not set
>>  CONFIG_HAVE_FUNCTION_TRACER=y
>> -
>> -#
>> -# Tracers
>> -#
>> +CONFIG_TRACING_SUPPORT=y
>> +CONFIG_FTRACE=y
>>  # CONFIG_FUNCTION_TRACER is not set
>>  # CONFIG_IRQSOFF_TRACER is not set
>>  # CONFIG_SCHED_TRACER is not set
>> -# CONFIG_CONTEXT_SWITCH_TRACER is not set
>> +# CONFIG_ENABLE_DEFAULT_TRACERS is not set
>>  # CONFIG_BOOT_TRACER is not set
>> -# CONFIG_TRACE_BRANCH_PROFILING is not set
>> +CONFIG_BRANCH_PROFILE_NONE=y
>> +# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
>> +# CONFIG_PROFILE_ALL_BRANCHES is not set
>>  # CONFIG_STACK_TRACER is not set
>> -# CONFIG_DYNAMIC_PRINTK_DEBUG is not set
>> +# CONFIG_KMEMTRACE is not set
>> +# CONFIG_WORKQUEUE_TRACER is not set
>> +# CONFIG_BLK_DEV_IO_TRACE is not set
>> +# CONFIG_DYNAMIC_DEBUG is not set
>>  # CONFIG_SAMPLES is not set
>>  CONFIG_HAVE_ARCH_KGDB=y
>>  # CONFIG_KGDB is not set
>> +CONFIG_ARM_UNWIND=y
>>  # CONFIG_DEBUG_USER is not set
>>  # CONFIG_DEBUG_ERRORS is not set
>>  # CONFIG_DEBUG_STACK_USAGE is not set
>> @@ -1704,7 +1749,7 @@ CONFIG_SECURITY=y
>>  # CONFIG_SECURITY_PATH is not set
>>  # CONFIG_SECURITY_FILE_CAPABILITIES is not set
>>  # CONFIG_SECURITY_ROOTPLUG is not set
>> -CONFIG_SECURITY_DEFAULT_MMAP_MIN_ADDR=0
>> +# CONFIG_SECURITY_TOMOYO is not set
>>  CONFIG_CRYPTO=y
>>   #
>> @@ -1719,10 +1764,12 @@ CONFIG_CRYPTO_BLKCIPHER2=y
>>  CONFIG_CRYPTO_HASH=y
>>  CONFIG_CRYPTO_HASH2=y
>>  CONFIG_CRYPTO_RNG2=y
>> +CONFIG_CRYPTO_PCOMP=y
>>  CONFIG_CRYPTO_MANAGER=y
>>  CONFIG_CRYPTO_MANAGER2=y
>>  # CONFIG_CRYPTO_GF128MUL is not set
>>  # CONFIG_CRYPTO_NULL is not set
>> +CONFIG_CRYPTO_WORKQUEUE=y
>>  # CONFIG_CRYPTO_CRYPTD is not set
>>  # CONFIG_CRYPTO_AUTHENC is not set
>>  # CONFIG_CRYPTO_TEST is not set
>> @@ -1791,6 +1838,7 @@ CONFIG_CRYPTO_DES=y
>>  # Compression
>>  #
>>  CONFIG_CRYPTO_DEFLATE=y
>> +# CONFIG_CRYPTO_ZLIB is not set
>>  CONFIG_CRYPTO_LZO=y
>>   #
>> @@ -1798,6 +1846,7 @@ CONFIG_CRYPTO_LZO=y
>>  #
>>  # CONFIG_CRYPTO_ANSI_CPRNG is not set
>>  CONFIG_CRYPTO_HW=y
>> +# CONFIG_BINARY_PRINTF is not set
>>   #
>>  # Library routines
>> @@ -1815,7 +1864,8 @@ CONFIG_ZLIB_INFLATE=y
>>  CONFIG_ZLIB_DEFLATE=y
>>  CONFIG_LZO_COMPRESS=y
>>  CONFIG_LZO_DECOMPRESS=y
>> -CONFIG_PLIST=y
>> +CONFIG_DECOMPRESS_GZIP=y
>>  CONFIG_HAS_IOMEM=y
>>  CONFIG_HAS_IOPORT=y
>>  CONFIG_HAS_DMA=y
>> +CONFIG_NLATTR=y
>
