From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Update Nokia N800 defconfig
Date: Fri, 28 Mar 2008 13:04:25 +0200
Message-ID: <20080328110424.GB24896@atomide.com>
References: <1206702037-17668-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51275 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbYC1LE2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 07:04:28 -0400
Content-Disposition: inline
In-Reply-To: <1206702037-17668-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [080328 13:01]:
> This is just "make n800_defconfig" with following manual changes:
> 
> - # CONFIG_DAB is not set (we don't have such a HW...)
> + CONFIG_RADIO_TEA5761=y
> + CONFIG_CBUS_RETU_HEADSET=y

Pushing today.

Tony

> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> ---
>  arch/arm/configs/n800_defconfig |  156 +++++++++++++++++++++++++++++++--------
>  1 files changed, 124 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm/configs/n800_defconfig b/arch/arm/configs/n800_defconfig
> index 4dac8bd..ea687ff 100644
> --- a/arch/arm/configs/n800_defconfig
> +++ b/arch/arm/configs/n800_defconfig
> @@ -1,7 +1,7 @@
>  #
>  # Automatically generated make config: don't edit
> -# Linux kernel version: 2.6.24-omap1
> -# Fri Jan 25 10:16:40 2008
> +# Linux kernel version: 2.6.25-rc6-omap1
> +# Fri Mar 28 10:53:25 2008
>  #
>  CONFIG_ARM=y
>  CONFIG_SYS_SUPPORTS_APM_EMULATION=y
> @@ -21,6 +21,7 @@ CONFIG_RWSEM_GENERIC_SPINLOCK=y
>  # CONFIG_ARCH_HAS_ILOG2_U64 is not set
>  CONFIG_GENERIC_HWEIGHT=y
>  CONFIG_GENERIC_CALIBRATE_DELAY=y
> +CONFIG_ARCH_SUPPORTS_AOUT=y
>  CONFIG_ZONE_DMA=y
>  CONFIG_VECTORS_BASE=0xffff0000
>  CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
> @@ -39,17 +40,23 @@ CONFIG_SYSVIPC_SYSCTL=y
>  CONFIG_POSIX_MQUEUE=y
>  # CONFIG_BSD_PROCESS_ACCT is not set
>  # CONFIG_TASKSTATS is not set
> -# CONFIG_USER_NS is not set
> -# CONFIG_PID_NS is not set
>  # CONFIG_AUDIT is not set
>  # CONFIG_IKCONFIG is not set
>  CONFIG_LOG_BUF_SHIFT=14
>  # CONFIG_CGROUPS is not set
> +CONFIG_GROUP_SCHED=y
>  CONFIG_FAIR_GROUP_SCHED=y
> -CONFIG_FAIR_USER_SCHED=y
> -# CONFIG_FAIR_CGROUP_SCHED is not set
> +# CONFIG_RT_GROUP_SCHED is not set
> +CONFIG_USER_SCHED=y
> +# CONFIG_CGROUP_SCHED is not set
>  CONFIG_SYSFS_DEPRECATED=y
> +CONFIG_SYSFS_DEPRECATED_V2=y
>  # CONFIG_RELAY is not set
> +CONFIG_NAMESPACES=y
> +# CONFIG_UTS_NS is not set
> +# CONFIG_IPC_NS is not set
> +# CONFIG_USER_NS is not set
> +# CONFIG_PID_NS is not set
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_INITRAMFS_SOURCE=""
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> @@ -64,17 +71,26 @@ CONFIG_HOTPLUG=y
>  CONFIG_PRINTK=y
>  CONFIG_BUG=y
>  CONFIG_ELF_CORE=y
> +CONFIG_COMPAT_BRK=y
>  CONFIG_BASE_FULL=y
>  CONFIG_FUTEX=y
>  CONFIG_ANON_INODES=y
>  CONFIG_EPOLL=y
>  CONFIG_SIGNALFD=y
> +CONFIG_TIMERFD=y
>  CONFIG_EVENTFD=y
>  CONFIG_SHMEM=y
>  CONFIG_VM_EVENT_COUNTERS=y
>  CONFIG_SLAB=y
>  # CONFIG_SLUB is not set
>  # CONFIG_SLOB is not set
> +# CONFIG_PROFILING is not set
> +# CONFIG_MARKERS is not set
> +CONFIG_HAVE_OPROFILE=y
> +# CONFIG_KPROBES is not set
> +CONFIG_HAVE_KPROBES=y
> +CONFIG_HAVE_KRETPROBES=y
> +CONFIG_PROC_PAGE_MONITOR=y
>  CONFIG_SLABINFO=y
>  CONFIG_RT_MUTEXES=y
>  # CONFIG_TINY_SHMEM is not set
> @@ -103,6 +119,7 @@ CONFIG_IOSCHED_NOOP=y
>  # CONFIG_DEFAULT_CFQ is not set
>  CONFIG_DEFAULT_NOOP=y
>  CONFIG_DEFAULT_IOSCHED="noop"
> +CONFIG_CLASSIC_RCU=y
>  
>  #
>  # System Type
> @@ -131,6 +148,7 @@ CONFIG_DEFAULT_IOSCHED="noop"
>  # CONFIG_ARCH_KS8695 is not set
>  # CONFIG_ARCH_NS9XXX is not set
>  # CONFIG_ARCH_MXC is not set
> +# CONFIG_ARCH_ORION is not set
>  # CONFIG_ARCH_PNX4008 is not set
>  # CONFIG_ARCH_PXA is not set
>  # CONFIG_ARCH_RPC is not set
> @@ -140,6 +158,7 @@ CONFIG_DEFAULT_IOSCHED="noop"
>  # CONFIG_ARCH_LH7A40X is not set
>  # CONFIG_ARCH_DAVINCI is not set
>  CONFIG_ARCH_OMAP=y
> +# CONFIG_ARCH_MSM7X00A is not set
>  
>  #
>  # TI OMAP Implementations
> @@ -159,8 +178,6 @@ CONFIG_OMAP_BOOT_REASON=y
>  CONFIG_OMAP_COMPONENT_VERSION=y
>  CONFIG_OMAP_GPIO_SWITCH=y
>  # CONFIG_OMAP_MUX is not set
> -CONFIG_OMAP_STI=y
> -CONFIG_OMAP_STI_CONSOLE=y
>  # CONFIG_OMAP_MCBSP is not set
>  CONFIG_OMAP_MMU_FWK=y
>  CONFIG_OMAP_MBOX_FWK=y
> @@ -188,7 +205,6 @@ CONFIG_MACH_NOKIA_N810=y
>  CONFIG_MACH_OMAP2_TUSB6010=y
>  # CONFIG_MACH_OMAP_H4 is not set
>  # CONFIG_MACH_OMAP_APOLLON is not set
> -# CONFIG_MACH_OMAP_APOLLON_PLUS is not set
>  # CONFIG_MACH_OMAP_2430OSK is not set
>  
>  #
> @@ -301,9 +317,10 @@ CONFIG_PM=y
>  # CONFIG_PM_LEGACY is not set
>  # CONFIG_PM_DEBUG is not set
>  CONFIG_PM_SLEEP=y
> -CONFIG_SUSPEND_UP_POSSIBLE=y
>  CONFIG_SUSPEND=y
> +CONFIG_SUSPEND_FREEZER=y
>  # CONFIG_APM_EMULATION is not set
> +CONFIG_ARCH_SUSPEND_POSSIBLE=y
>  
>  #
>  # Networking
> @@ -320,6 +337,7 @@ CONFIG_XFRM=y
>  # CONFIG_XFRM_USER is not set
>  # CONFIG_XFRM_SUB_POLICY is not set
>  # CONFIG_XFRM_MIGRATE is not set
> +# CONFIG_XFRM_STATISTICS is not set
>  # CONFIG_NET_KEY is not set
>  CONFIG_INET=y
>  CONFIG_IP_MULTICAST=y
> @@ -354,33 +372,36 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
>  # CONFIG_NETWORK_SECMARK is not set
>  CONFIG_NETFILTER=y
>  # CONFIG_NETFILTER_DEBUG is not set
> +CONFIG_NETFILTER_ADVANCED=y
>  
>  #
>  # Core Netfilter Configuration
>  #
> -CONFIG_NETFILTER_NETLINK=y
>  # CONFIG_NETFILTER_NETLINK_QUEUE is not set
>  # CONFIG_NETFILTER_NETLINK_LOG is not set
> -# CONFIG_NF_CONNTRACK_ENABLED is not set
>  # CONFIG_NF_CONNTRACK is not set
>  CONFIG_NETFILTER_XTABLES=y
>  # CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
>  # CONFIG_NETFILTER_XT_TARGET_MARK is not set
>  # CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
>  # CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
> +# CONFIG_NETFILTER_XT_TARGET_RATEEST is not set
>  # CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set
>  # CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
>  # CONFIG_NETFILTER_XT_MATCH_DCCP is not set
>  # CONFIG_NETFILTER_XT_MATCH_DSCP is not set
>  # CONFIG_NETFILTER_XT_MATCH_ESP is not set
> +# CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set
>  # CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
>  # CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
>  # CONFIG_NETFILTER_XT_MATCH_MAC is not set
>  # CONFIG_NETFILTER_XT_MATCH_MARK is not set
> +# CONFIG_NETFILTER_XT_MATCH_OWNER is not set
>  # CONFIG_NETFILTER_XT_MATCH_POLICY is not set
>  # CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
>  # CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
>  # CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
> +# CONFIG_NETFILTER_XT_MATCH_RATEEST is not set
>  # CONFIG_NETFILTER_XT_MATCH_REALM is not set
>  # CONFIG_NETFILTER_XT_MATCH_SCTP is not set
>  # CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
> @@ -395,13 +416,10 @@ CONFIG_NETFILTER_XTABLES=y
>  #
>  # CONFIG_IP_NF_QUEUE is not set
>  CONFIG_IP_NF_IPTABLES=y
> -# CONFIG_IP_NF_MATCH_IPRANGE is not set
> -# CONFIG_IP_NF_MATCH_TOS is not set
>  # CONFIG_IP_NF_MATCH_RECENT is not set
>  # CONFIG_IP_NF_MATCH_ECN is not set
>  # CONFIG_IP_NF_MATCH_AH is not set
>  # CONFIG_IP_NF_MATCH_TTL is not set
> -# CONFIG_IP_NF_MATCH_OWNER is not set
>  # CONFIG_IP_NF_MATCH_ADDRTYPE is not set
>  CONFIG_IP_NF_FILTER=y
>  # CONFIG_IP_NF_TARGET_REJECT is not set
> @@ -432,6 +450,7 @@ CONFIG_IP_NF_TARGET_IDLETIMER=y
>  #
>  # CONFIG_NET_PKTGEN is not set
>  # CONFIG_HAMRADIO is not set
> +# CONFIG_CAN is not set
>  # CONFIG_IRDA is not set
>  CONFIG_BT=y
>  CONFIG_BT_L2CAP=y
> @@ -562,11 +581,15 @@ CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_RAM=y
>  CONFIG_BLK_DEV_RAM_COUNT=16
>  CONFIG_BLK_DEV_RAM_SIZE=4096
> -CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
> +# CONFIG_BLK_DEV_XIP is not set
>  # CONFIG_CDROM_PKTCDVD is not set
>  # CONFIG_ATA_OVER_ETH is not set
>  CONFIG_MISC_DEVICES=y
>  # CONFIG_EEPROM_93CX6 is not set
> +CONFIG_OMAP_STI=y
> +CONFIG_OMAP_STI_CONSOLE=y
> +# CONFIG_ENCLOSURE_SERVICES is not set
> +# CONFIG_HAVE_IDE is not set
>  
>  #
>  # SCSI device support
> @@ -620,6 +643,7 @@ CONFIG_TUN=y
>  # CONFIG_VETH is not set
>  # CONFIG_NET_ETHERNET is not set
>  CONFIG_NETDEV_1000=y
> +# CONFIG_E1000E_ENABLED is not set
>  CONFIG_NETDEV_10000=y
>  
>  #
> @@ -640,7 +664,6 @@ CONFIG_PPP_BSDCOMP=y
>  # CONFIG_PPPOL2TP is not set
>  # CONFIG_SLIP is not set
>  CONFIG_SLHC=y
> -# CONFIG_SHAPER is not set
>  # CONFIG_NETCONSOLE is not set
>  # CONFIG_NETPOLL is not set
>  # CONFIG_NET_POLL_CONTROLLER is not set
> @@ -712,7 +735,6 @@ CONFIG_VT_CONSOLE=y
>  CONFIG_HW_CONSOLE=y
>  # CONFIG_VT_HW_CONSOLE_BINDING is not set
>  CONFIG_SERIAL_NONSTANDARD=y
> -# CONFIG_MOXA_SMARTIO is not set
>  # CONFIG_N_HDLC is not set
>  # CONFIG_RISCOM8 is not set
>  # CONFIG_SPECIALIX is not set
> @@ -766,12 +788,10 @@ CONFIG_I2C_OMAP=y
>  #
>  # Miscellaneous I2C Chip support
>  #
> -# CONFIG_SENSORS_DS1337 is not set
> -# CONFIG_SENSORS_DS1374 is not set
>  # CONFIG_DS1682 is not set
>  # CONFIG_SENSORS_EEPROM is not set
>  # CONFIG_SENSORS_PCF8574 is not set
> -# CONFIG_SENSORS_PCA9539 is not set
> +# CONFIG_PCF8575 is not set
>  # CONFIG_SENSORS_PCF8591 is not set
>  # CONFIG_ISP1301_OMAP is not set
>  # CONFIG_TPS65010 is not set
> @@ -810,6 +830,23 @@ CONFIG_SPI_TSC2301=y
>  CONFIG_SPI_TSC2301_AUDIO=y
>  # CONFIG_SPI_SPIDEV is not set
>  # CONFIG_SPI_TLE62X0 is not set
> +CONFIG_HAVE_GPIO_LIB=y
> +
> +#
> +# GPIO Support
> +#
> +# CONFIG_DEBUG_GPIO is not set
> +
> +#
> +# I2C GPIO expanders:
> +#
> +# CONFIG_GPIO_PCA953X is not set
> +# CONFIG_GPIO_PCF857X is not set
> +
> +#
> +# SPI GPIO expanders:
> +#
> +# CONFIG_GPIO_MCP23S08 is not set
>  # CONFIG_W1 is not set
>  # CONFIG_POWER_SUPPLY is not set
>  CONFIG_HWMON=y
> @@ -822,6 +859,7 @@ CONFIG_HWMON=y
>  # CONFIG_SENSORS_ADM1031 is not set
>  # CONFIG_SENSORS_ADM9240 is not set
>  # CONFIG_SENSORS_ADT7470 is not set
> +# CONFIG_SENSORS_ADT7473 is not set
>  # CONFIG_SENSORS_ATXP1 is not set
>  # CONFIG_SENSORS_DS1621 is not set
>  # CONFIG_SENSORS_F71805F is not set
> @@ -850,6 +888,7 @@ CONFIG_HWMON=y
>  # CONFIG_SENSORS_SMSC47M1 is not set
>  # CONFIG_SENSORS_SMSC47M192 is not set
>  # CONFIG_SENSORS_SMSC47B397 is not set
> +# CONFIG_SENSORS_ADS7828 is not set
>  # CONFIG_SENSORS_THMC50 is not set
>  # CONFIG_SENSORS_VT1211 is not set
>  # CONFIG_SENSORS_W83781D is not set
> @@ -857,6 +896,7 @@ CONFIG_HWMON=y
>  # CONFIG_SENSORS_W83792D is not set
>  # CONFIG_SENSORS_W83793 is not set
>  # CONFIG_SENSORS_W83L785TS is not set
> +# CONFIG_SENSORS_W83L786NG is not set
>  # CONFIG_SENSORS_W83627HF is not set
>  # CONFIG_SENSORS_W83627EHF is not set
>  # CONFIG_SENSORS_TSC210X is not set
> @@ -880,26 +920,31 @@ CONFIG_SSB_POSSIBLE=y
>  # Multifunction device drivers
>  #
>  # CONFIG_MFD_SM501 is not set
> +# CONFIG_MFD_ASIC3 is not set
>  
>  #
>  # Multimedia devices
>  #
>  CONFIG_VIDEO_DEV=y
> +CONFIG_VIDEO_V4L2_COMMON=y
>  # CONFIG_VIDEO_V4L1 is not set
>  # CONFIG_VIDEO_V4L1_COMPAT is not set
>  CONFIG_VIDEO_V4L2=y
>  CONFIG_VIDEO_CAPTURE_DRIVERS=y
>  # CONFIG_VIDEO_ADV_DEBUG is not set
>  CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
> +CONFIG_VIDEO_TCM825X=y
>  # CONFIG_VIDEO_VIVI is not set
>  # CONFIG_VIDEO_SAA5246A is not set
>  # CONFIG_VIDEO_SAA5249 is not set
>  # CONFIG_VIDEO_OMAP_CAMERA is not set
>  CONFIG_VIDEO_OMAP2=y
>  CONFIG_RADIO_ADAPTERS=y
> -# CONFIG_RADIO_TEA5761 is not set
> +CONFIG_RADIO_TEA5761=y
>  # CONFIG_DVB_CORE is not set
> -CONFIG_DAB=y
> +CONFIG_VIDEOBUF_GEN=y
> +CONFIG_VIDEOBUF_DMA_SG=y
> +# CONFIG_DAB is not set
>  
>  #
>  # Graphics support
> @@ -1002,6 +1047,10 @@ CONFIG_SND_OMAP24XX_EAC=y
>  #
>  
>  #
> +# ALSA SoC audio for Freescale SOCs
> +#
> +
> +#
>  # Open Sound System
>  #
>  # CONFIG_SOUND_PRIME is not set
> @@ -1057,7 +1106,7 @@ CONFIG_CBUS_RETU_USER=y
>  CONFIG_CBUS_RETU_POWERBUTTON=y
>  CONFIG_CBUS_RETU_RTC=y
>  CONFIG_CBUS_RETU_WDT=y
> -# CONFIG_CBUS_RETU_HEADSET is not set
> +CONFIG_CBUS_RETU_HEADSET=y
>  CONFIG_OMAP_DSP=y
>  # CONFIG_OMAP_DSP_MBCMD_VERBOSE is not set
>  CONFIG_OMAP_DSP_FBEXPORT=y
> @@ -1083,12 +1132,10 @@ CONFIG_FS_MBCACHE=m
>  # CONFIG_XFS_FS is not set
>  # CONFIG_GFS2_FS is not set
>  # CONFIG_OCFS2_FS is not set
> -# CONFIG_MINIX_FS is not set
> -# CONFIG_ROMFS_FS is not set
> +CONFIG_DNOTIFY=y
>  CONFIG_INOTIFY=y
>  CONFIG_INOTIFY_USER=y
>  # CONFIG_QUOTA is not set
> -CONFIG_DNOTIFY=y
>  # CONFIG_AUTOFS_FS is not set
>  # CONFIG_AUTOFS4_FS is not set
>  # CONFIG_FUSE_FS is not set
> @@ -1147,8 +1194,10 @@ CONFIG_JFFS2_CMODE_PRIORITY=y
>  # CONFIG_JFFS2_CMODE_FAVOURLZO is not set
>  # CONFIG_CRAMFS is not set
>  # CONFIG_VXFS_FS is not set
> +# CONFIG_MINIX_FS is not set
>  # CONFIG_HPFS_FS is not set
>  # CONFIG_QNX4FS_FS is not set
> +# CONFIG_ROMFS_FS is not set
>  # CONFIG_SYSV_FS is not set
>  # CONFIG_UFS_FS is not set
>  CONFIG_NETWORK_FILESYSTEMS=y
> @@ -1206,9 +1255,6 @@ CONFIG_NLS_ISO8859_15=y
>  # CONFIG_NLS_KOI8_U is not set
>  CONFIG_NLS_UTF8=y
>  # CONFIG_DLM is not set
> -CONFIG_INSTRUMENTATION=y
> -# CONFIG_PROFILING is not set
> -# CONFIG_MARKERS is not set
>  
>  #
>  # Kernel hacking
> @@ -1243,13 +1289,14 @@ CONFIG_DEBUG_BUGVERBOSE=y
>  # CONFIG_DEBUG_LIST is not set
>  # CONFIG_DEBUG_SG is not set
>  CONFIG_FRAME_POINTER=y
> -CONFIG_FORCED_INLINING=y
>  # CONFIG_BOOT_PRINTK_DELAY is not set
>  # CONFIG_RCU_TORTURE_TEST is not set
> +# CONFIG_BACKTRACE_SELF_TEST is not set
>  # CONFIG_FAULT_INJECTION is not set
>  # CONFIG_SAMPLES is not set
>  CONFIG_DEBUG_USER=y
>  CONFIG_DEBUG_ERRORS=y
> +# CONFIG_DEBUG_STACK_USAGE is not set
>  # CONFIG_DEBUG_LL is not set
>  
>  #
> @@ -1260,7 +1307,52 @@ CONFIG_SECURITY=y
>  # CONFIG_SECURITY_NETWORK is not set
>  # CONFIG_SECURITY_CAPABILITIES is not set
>  # CONFIG_SECURITY_LOWMEM is not set
> -# CONFIG_CRYPTO is not set
> +CONFIG_SECURITY_DEFAULT_MMAP_MIN_ADDR=0
> +CONFIG_CRYPTO=y
> +# CONFIG_CRYPTO_SEQIV is not set
> +# CONFIG_CRYPTO_MANAGER is not set
> +# CONFIG_CRYPTO_HMAC is not set
> +# CONFIG_CRYPTO_XCBC is not set
> +# CONFIG_CRYPTO_NULL is not set
> +# CONFIG_CRYPTO_MD4 is not set
> +# CONFIG_CRYPTO_MD5 is not set
> +# CONFIG_CRYPTO_SHA1 is not set
> +# CONFIG_CRYPTO_SHA256 is not set
> +# CONFIG_CRYPTO_SHA512 is not set
> +# CONFIG_CRYPTO_WP512 is not set
> +# CONFIG_CRYPTO_TGR192 is not set
> +# CONFIG_CRYPTO_GF128MUL is not set
> +# CONFIG_CRYPTO_ECB is not set
> +# CONFIG_CRYPTO_CBC is not set
> +# CONFIG_CRYPTO_PCBC is not set
> +# CONFIG_CRYPTO_LRW is not set
> +# CONFIG_CRYPTO_XTS is not set
> +# CONFIG_CRYPTO_CTR is not set
> +# CONFIG_CRYPTO_GCM is not set
> +# CONFIG_CRYPTO_CCM is not set
> +# CONFIG_CRYPTO_CRYPTD is not set
> +# CONFIG_CRYPTO_DES is not set
> +# CONFIG_CRYPTO_FCRYPT is not set
> +# CONFIG_CRYPTO_BLOWFISH is not set
> +# CONFIG_CRYPTO_TWOFISH is not set
> +# CONFIG_CRYPTO_SERPENT is not set
> +# CONFIG_CRYPTO_AES is not set
> +# CONFIG_CRYPTO_CAST5 is not set
> +# CONFIG_CRYPTO_CAST6 is not set
> +# CONFIG_CRYPTO_TEA is not set
> +# CONFIG_CRYPTO_ARC4 is not set
> +# CONFIG_CRYPTO_KHAZAD is not set
> +# CONFIG_CRYPTO_ANUBIS is not set
> +# CONFIG_CRYPTO_SEED is not set
> +# CONFIG_CRYPTO_SALSA20 is not set
> +# CONFIG_CRYPTO_DEFLATE is not set
> +# CONFIG_CRYPTO_MICHAEL_MIC is not set
> +# CONFIG_CRYPTO_CRC32C is not set
> +# CONFIG_CRYPTO_CAMELLIA is not set
> +# CONFIG_CRYPTO_TEST is not set
> +# CONFIG_CRYPTO_AUTHENC is not set
> +# CONFIG_CRYPTO_LZO is not set
> +CONFIG_CRYPTO_HW=y
>  
>  #
>  # Library routines
> -- 
> 1.5.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
