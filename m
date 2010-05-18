From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/13] omap4: Enable RTC and regulator support
Date: Mon, 17 May 2010 19:42:56 -0700
Message-ID: <20100518024256.21705.28037.stgit@baageli.muru.com>
References: <20100518023707.21705.26205.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59058 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755096Ab0ERCm7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 22:42:59 -0400
In-Reply-To: <20100518023707.21705.26205.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Balaji T K <balajitk@ti.com>

From: Balaji T K <balajitk@ti.com>

This patch enables RTC and regulator support on omap4430 sdp
platform. Also sync up the defconfig with latest kernel

Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap_4430sdp_defconfig |  330 ++++++++++++++++++++++++++++---
 1 files changed, 302 insertions(+), 28 deletions(-)

diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
index a555305..25e8d04 100644
--- a/arch/arm/configs/omap_4430sdp_defconfig
+++ b/arch/arm/configs/omap_4430sdp_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.32
-# Sun Dec  6 23:37:45 2009
+# Linux kernel version: 2.6.34-rc7
+# Wed May 12 12:26:05 2010
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -9,6 +9,7 @@ CONFIG_GENERIC_GPIO=y
 CONFIG_GENERIC_TIME=y
 CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
+CONFIG_HAVE_PROC_CPU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_LOCKDEP_SUPPORT=y
@@ -20,6 +21,7 @@ CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_ARCH_HAS_CPUFREQ=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_NEED_DMA_MAP_STATE=y
 CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 CONFIG_VECTORS_BASE=0xffff0000
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
@@ -33,28 +35,33 @@ CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
+CONFIG_HAVE_KERNEL_GZIP=y
+CONFIG_HAVE_KERNEL_LZO=y
+CONFIG_KERNEL_GZIP=y
+# CONFIG_KERNEL_BZIP2 is not set
+# CONFIG_KERNEL_LZMA is not set
+# CONFIG_KERNEL_LZO is not set
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 CONFIG_SYSVIPC_SYSCTL=y
+# CONFIG_POSIX_MQUEUE is not set
 CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_AUDIT is not set
 
 #
 # RCU Subsystem
 #
 CONFIG_TREE_RCU=y
 # CONFIG_TREE_PREEMPT_RCU is not set
+# CONFIG_TINY_RCU is not set
 # CONFIG_RCU_TRACE is not set
 CONFIG_RCU_FANOUT=32
 # CONFIG_RCU_FANOUT_EXACT is not set
 # CONFIG_TREE_RCU_TRACE is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_GROUP_SCHED=y
-CONFIG_FAIR_GROUP_SCHED=y
-# CONFIG_RT_GROUP_SCHED is not set
-CONFIG_USER_SCHED=y
-# CONFIG_CGROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
 # CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
@@ -64,6 +71,7 @@ CONFIG_INITRAMFS_SOURCE=""
 CONFIG_RD_GZIP=y
 # CONFIG_RD_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
+# CONFIG_RD_LZO is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
 CONFIG_ANON_INODES=y
@@ -85,10 +93,14 @@ CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_AIO=y
+CONFIG_HAVE_PERF_EVENTS=y
+CONFIG_PERF_USE_VMALLOC=y
 
 #
 # Kernel Performance Events And Counters
 #
+# CONFIG_PERF_EVENTS is not set
+# CONFIG_PERF_COUNTERS is not set
 CONFIG_VM_EVENT_COUNTERS=y
 CONFIG_SLUB_DEBUG=y
 CONFIG_COMPAT_BRK=y
@@ -127,14 +139,41 @@ CONFIG_LBDAF=y
 # IO Schedulers
 #
 CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
-CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_DEADLINE is not set
-# CONFIG_DEFAULT_CFQ is not set
+CONFIG_DEFAULT_CFQ=y
 # CONFIG_DEFAULT_NOOP is not set
-CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_DEFAULT_IOSCHED="cfq"
+# CONFIG_INLINE_SPIN_TRYLOCK is not set
+# CONFIG_INLINE_SPIN_TRYLOCK_BH is not set
+# CONFIG_INLINE_SPIN_LOCK is not set
+# CONFIG_INLINE_SPIN_LOCK_BH is not set
+# CONFIG_INLINE_SPIN_LOCK_IRQ is not set
+# CONFIG_INLINE_SPIN_LOCK_IRQSAVE is not set
+# CONFIG_INLINE_SPIN_UNLOCK is not set
+# CONFIG_INLINE_SPIN_UNLOCK_BH is not set
+# CONFIG_INLINE_SPIN_UNLOCK_IRQ is not set
+# CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE is not set
+# CONFIG_INLINE_READ_TRYLOCK is not set
+# CONFIG_INLINE_READ_LOCK is not set
+# CONFIG_INLINE_READ_LOCK_BH is not set
+# CONFIG_INLINE_READ_LOCK_IRQ is not set
+# CONFIG_INLINE_READ_LOCK_IRQSAVE is not set
+# CONFIG_INLINE_READ_UNLOCK is not set
+# CONFIG_INLINE_READ_UNLOCK_BH is not set
+# CONFIG_INLINE_READ_UNLOCK_IRQ is not set
+# CONFIG_INLINE_READ_UNLOCK_IRQRESTORE is not set
+# CONFIG_INLINE_WRITE_TRYLOCK is not set
+# CONFIG_INLINE_WRITE_LOCK is not set
+# CONFIG_INLINE_WRITE_LOCK_BH is not set
+# CONFIG_INLINE_WRITE_LOCK_IRQ is not set
+# CONFIG_INLINE_WRITE_LOCK_IRQSAVE is not set
+# CONFIG_INLINE_WRITE_UNLOCK is not set
+# CONFIG_INLINE_WRITE_UNLOCK_BH is not set
+# CONFIG_INLINE_WRITE_UNLOCK_IRQ is not set
+# CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE is not set
+CONFIG_MUTEX_SPIN_ON_OWNER=y
 # CONFIG_FREEZER is not set
 
 #
@@ -146,6 +185,7 @@ CONFIG_MMU=y
 # CONFIG_ARCH_REALVIEW is not set
 # CONFIG_ARCH_VERSATILE is not set
 # CONFIG_ARCH_AT91 is not set
+# CONFIG_ARCH_BCMRING is not set
 # CONFIG_ARCH_CLPS711X is not set
 # CONFIG_ARCH_GEMINI is not set
 # CONFIG_ARCH_EBSA110 is not set
@@ -155,7 +195,6 @@ CONFIG_MMU=y
 # CONFIG_ARCH_STMP3XXX is not set
 # CONFIG_ARCH_NETX is not set
 # CONFIG_ARCH_H720X is not set
-# CONFIG_ARCH_NOMADIK is not set
 # CONFIG_ARCH_IOP13XX is not set
 # CONFIG_ARCH_IOP32X is not set
 # CONFIG_ARCH_IOP33X is not set
@@ -163,6 +202,7 @@ CONFIG_MMU=y
 # CONFIG_ARCH_IXP2000 is not set
 # CONFIG_ARCH_IXP4XX is not set
 # CONFIG_ARCH_L7200 is not set
+# CONFIG_ARCH_DOVE is not set
 # CONFIG_ARCH_KIRKWOOD is not set
 # CONFIG_ARCH_LOKI is not set
 # CONFIG_ARCH_MV78XX0 is not set
@@ -171,25 +211,32 @@ CONFIG_MMU=y
 # CONFIG_ARCH_KS8695 is not set
 # CONFIG_ARCH_NS9XXX is not set
 # CONFIG_ARCH_W90X900 is not set
+# CONFIG_ARCH_NUC93X is not set
 # CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
 # CONFIG_ARCH_MSM is not set
+# CONFIG_ARCH_SHMOBILE is not set
 # CONFIG_ARCH_RPC is not set
 # CONFIG_ARCH_SA1100 is not set
 # CONFIG_ARCH_S3C2410 is not set
 # CONFIG_ARCH_S3C64XX is not set
+# CONFIG_ARCH_S5P6440 is not set
+# CONFIG_ARCH_S5P6442 is not set
 # CONFIG_ARCH_S5PC1XX is not set
+# CONFIG_ARCH_S5PV210 is not set
 # CONFIG_ARCH_SHARK is not set
 # CONFIG_ARCH_LH7A40X is not set
 # CONFIG_ARCH_U300 is not set
+# CONFIG_ARCH_U8500 is not set
+# CONFIG_ARCH_NOMADIK is not set
 # CONFIG_ARCH_DAVINCI is not set
 CONFIG_ARCH_OMAP=y
-# CONFIG_ARCH_BCMRING is not set
 
 #
 # TI OMAP Implementations
 #
 # CONFIG_ARCH_OMAP1 is not set
+CONFIG_ARCH_OMAP2PLUS=y
 # CONFIG_ARCH_OMAP2 is not set
 # CONFIG_ARCH_OMAP3 is not set
 CONFIG_ARCH_OMAP4=y
@@ -205,10 +252,6 @@ CONFIG_OMAP_MCBSP=y
 CONFIG_OMAP_32K_TIMER=y
 CONFIG_OMAP_32K_TIMER_HZ=128
 CONFIG_OMAP_DM_TIMER=y
-# CONFIG_OMAP_LL_DEBUG_UART1 is not set
-# CONFIG_OMAP_LL_DEBUG_UART2 is not set
-CONFIG_OMAP_LL_DEBUG_UART3=y
-# CONFIG_OMAP_LL_DEBUG_NONE is not set
 # CONFIG_OMAP_PM_NONE is not set
 CONFIG_OMAP_PM_NOOP=y
 
@@ -243,13 +286,16 @@ CONFIG_CPU_CP15_MMU=y
 # CONFIG_CPU_BPREDICT_DISABLE is not set
 CONFIG_HAS_TLS_REG=y
 CONFIG_OUTER_CACHE=y
+CONFIG_OUTER_CACHE_SYNC=y
 CONFIG_CACHE_L2X0=y
 CONFIG_ARM_L1_CACHE_SHIFT=5
+CONFIG_CPU_HAS_PMU=y
 # CONFIG_ARM_ERRATA_430973 is not set
 # CONFIG_ARM_ERRATA_458693 is not set
 # CONFIG_ARM_ERRATA_460075 is not set
 CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_GIC=y
+CONFIG_COMMON_CLKDEV=y
 
 #
 # Bus support
@@ -280,6 +326,7 @@ CONFIG_HZ=128
 # CONFIG_THUMB2_KERNEL is not set
 CONFIG_AEABI=y
 CONFIG_OABI_COMPAT=y
+CONFIG_ARCH_HAS_HOLES_MEMORYMODEL=y
 # CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
 # CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
 # CONFIG_HIGHMEM is not set
@@ -294,8 +341,6 @@ CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_PHYS_ADDR_T_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
-CONFIG_HAVE_MLOCK=y
-CONFIG_HAVE_MLOCKED_PAGE_BIT=y
 # CONFIG_KSM is not set
 CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
 # CONFIG_LEDS is not set
@@ -349,28 +394,77 @@ CONFIG_NET=y
 # Networking options
 #
 CONFIG_PACKET=y
+# CONFIG_UNIX is not set
 CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
+# CONFIG_XFRM_STATISTICS is not set
+# CONFIG_NET_KEY is not set
 CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
 CONFIG_IP_FIB_HASH=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
 CONFIG_INET_XFRM_MODE_BEET=y
 CONFIG_INET_LRO=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_RDS is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_NET_DSA is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
+# CONFIG_NET_SCHED is not set
+# CONFIG_DCB is not set
 
 #
 # Network testing
 #
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
 # CONFIG_WIRELESS is not set
-
+# CONFIG_WIMAX is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -387,17 +481,24 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
 # CONFIG_MTD is not set
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
+
+#
+# DRBD disabled because PROC_FS, INET or CONNECTOR not selected
+#
+# CONFIG_BLK_DEV_NBD is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=16384
 # CONFIG_BLK_DEV_XIP is not set
 # CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
 # CONFIG_MG_DISK is not set
 # CONFIG_MISC_DEVICES is not set
 CONFIG_HAVE_IDE=y
@@ -406,27 +507,65 @@ CONFIG_HAVE_IDE=y
 #
 # SCSI device support
 #
+CONFIG_SCSI_MOD=y
 # CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
 # CONFIG_SCSI_DMA is not set
 # CONFIG_SCSI_NETLINK is not set
 # CONFIG_ATA is not set
 # CONFIG_MD is not set
-# CONFIG_PHONE is not set
 CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+# CONFIG_PHYLIB is not set
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
+# CONFIG_AX88796 is not set
+# CONFIG_SMC91X is not set
+# CONFIG_DM9000 is not set
+# CONFIG_ENC28J60 is not set
+# CONFIG_ETHOC is not set
+# CONFIG_SMC911X is not set
+# CONFIG_SMSC911X is not set
+# CONFIG_DNET is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
+# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
+# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
+# CONFIG_B44 is not set
+# CONFIG_KS8842 is not set
 CONFIG_KS8851=y
+# CONFIG_KS8851_MLL is not set
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set
 # CONFIG_WLAN is not set
 
 #
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
+# CONFIG_WAN is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_ISDN is not set
+# CONFIG_PHONE is not set
+
+#
 # Input device support
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
 # CONFIG_INPUT_POLLDEV is not set
+# CONFIG_INPUT_SPARSEKMAP is not set
 
 #
 # Userland interfaces
@@ -479,8 +618,10 @@ CONFIG_SERIAL_8250_RSA=y
 #
 # Non-8250 serial port support
 #
+# CONFIG_SERIAL_MAX3100 is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_TIMBERDALE is not set
 CONFIG_UNIX98_PTYS=y
 # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 # CONFIG_LEGACY_PTYS is not set
@@ -555,10 +696,17 @@ CONFIG_GPIOLIB=y
 #
 # Memory mapped GPIO expanders:
 #
+# CONFIG_GPIO_IT8761E is not set
 
 #
 # I2C GPIO expanders:
 #
+# CONFIG_GPIO_MAX7300 is not set
+# CONFIG_GPIO_MAX732X is not set
+# CONFIG_GPIO_PCA953X is not set
+# CONFIG_GPIO_PCF857X is not set
+# CONFIG_GPIO_TWL4030 is not set
+# CONFIG_GPIO_ADP5588 is not set
 
 #
 # PCI GPIO expanders:
@@ -567,6 +715,9 @@ CONFIG_GPIOLIB=y
 #
 # SPI GPIO expanders:
 #
+# CONFIG_GPIO_MAX7301 is not set
+# CONFIG_GPIO_MCP23S08 is not set
+# CONFIG_GPIO_MC33880 is not set
 
 #
 # AC97 GPIO expanders:
@@ -576,7 +727,15 @@ CONFIG_GPIOLIB=y
 # CONFIG_HWMON is not set
 # CONFIG_THERMAL is not set
 CONFIG_WATCHDOG=y
+# CONFIG_WATCHDOG_NOWAYOUT is not set
+
+#
+# Watchdog Device Drivers
+#
+# CONFIG_SOFT_WATCHDOG is not set
 CONFIG_OMAP_WATCHDOG=y
+# CONFIG_TWL4030_WATCHDOG is not set
+# CONFIG_MAX63XX_WATCHDOG is not set
 CONFIG_SSB_POSSIBLE=y
 
 #
@@ -588,15 +747,46 @@ CONFIG_SSB_POSSIBLE=y
 # Multifunction device drivers
 #
 # CONFIG_MFD_CORE is not set
+# CONFIG_MFD_88PM860X is not set
 # CONFIG_MFD_SM501 is not set
 # CONFIG_MFD_ASIC3 is not set
 # CONFIG_HTC_EGPIO is not set
 # CONFIG_HTC_PASIC3 is not set
+# CONFIG_HTC_I2CPLD is not set
+# CONFIG_TPS65010 is not set
+CONFIG_TWL4030_CORE=y
+# CONFIG_TWL4030_POWER is not set
+# CONFIG_TWL4030_CODEC is not set
 # CONFIG_MFD_TMIO is not set
 # CONFIG_MFD_T7L66XB is not set
 # CONFIG_MFD_TC6387XB is not set
 # CONFIG_MFD_TC6393XB is not set
-# CONFIG_REGULATOR is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_PMIC_ADP5520 is not set
+# CONFIG_MFD_MAX8925 is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM831X is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_WM8994 is not set
+# CONFIG_MFD_PCF50633 is not set
+# CONFIG_MFD_MC13783 is not set
+# CONFIG_AB3100_CORE is not set
+# CONFIG_EZX_PCAP is not set
+# CONFIG_AB4500_CORE is not set
+CONFIG_REGULATOR=y
+# CONFIG_REGULATOR_DEBUG is not set
+# CONFIG_REGULATOR_DUMMY is not set
+# CONFIG_REGULATOR_FIXED_VOLTAGE is not set
+# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
+# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
+# CONFIG_REGULATOR_BQ24022 is not set
+# CONFIG_REGULATOR_MAX1586 is not set
+# CONFIG_REGULATOR_MAX8649 is not set
+# CONFIG_REGULATOR_MAX8660 is not set
+CONFIG_REGULATOR_TWL4030=y
+# CONFIG_REGULATOR_LP3971 is not set
+# CONFIG_REGULATOR_TPS65023 is not set
+# CONFIG_REGULATOR_TPS6507X is not set
 # CONFIG_MEDIA_SUPPORT is not set
 
 #
@@ -625,7 +815,72 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_NEW_LEDS is not set
 # CONFIG_ACCESSIBILITY is not set
 CONFIG_RTC_LIB=y
-# CONFIG_RTC_CLASS is not set
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# I2C RTC drivers
+#
+# CONFIG_RTC_DRV_DS1307 is not set
+# CONFIG_RTC_DRV_DS1374 is not set
+# CONFIG_RTC_DRV_DS1672 is not set
+# CONFIG_RTC_DRV_MAX6900 is not set
+# CONFIG_RTC_DRV_RS5C372 is not set
+# CONFIG_RTC_DRV_ISL1208 is not set
+# CONFIG_RTC_DRV_X1205 is not set
+# CONFIG_RTC_DRV_PCF8563 is not set
+# CONFIG_RTC_DRV_PCF8583 is not set
+# CONFIG_RTC_DRV_M41T80 is not set
+# CONFIG_RTC_DRV_BQ32K is not set
+CONFIG_RTC_DRV_TWL4030=y
+# CONFIG_RTC_DRV_S35390A is not set
+# CONFIG_RTC_DRV_FM3130 is not set
+# CONFIG_RTC_DRV_RX8581 is not set
+# CONFIG_RTC_DRV_RX8025 is not set
+
+#
+# SPI RTC drivers
+#
+# CONFIG_RTC_DRV_M41T94 is not set
+# CONFIG_RTC_DRV_DS1305 is not set
+# CONFIG_RTC_DRV_DS1390 is not set
+# CONFIG_RTC_DRV_MAX6902 is not set
+# CONFIG_RTC_DRV_R9701 is not set
+# CONFIG_RTC_DRV_RS5C348 is not set
+# CONFIG_RTC_DRV_DS3234 is not set
+# CONFIG_RTC_DRV_PCF2123 is not set
+
+#
+# Platform RTC drivers
+#
+# CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1286 is not set
+# CONFIG_RTC_DRV_DS1511 is not set
+# CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T35 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_MSM6242 is not set
+# CONFIG_RTC_DRV_BQ4802 is not set
+# CONFIG_RTC_DRV_RP5C01 is not set
+# CONFIG_RTC_DRV_V3020 is not set
+
+#
+# on-CPU RTC drivers
+#
 # CONFIG_DMADEVICES is not set
 # CONFIG_AUXDISPLAY is not set
 # CONFIG_UIO is not set
@@ -648,9 +903,10 @@ CONFIG_EXT3_FS=y
 CONFIG_JBD=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
-# CONFIG_FS_POSIX_ACL is not set
+CONFIG_FS_POSIX_ACL=y
 # CONFIG_XFS_FS is not set
 # CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
 # CONFIG_BTRFS_FS is not set
 # CONFIG_NILFS2_FS is not set
 CONFIG_FILE_LOCKING=y
@@ -659,7 +915,9 @@ CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 CONFIG_QUOTA=y
+# CONFIG_QUOTA_NETLINK_INTERFACE is not set
 CONFIG_PRINT_QUOTA_WARNING=y
+# CONFIG_QUOTA_DEBUG is not set
 CONFIG_QUOTA_TREE=y
 # CONFIG_QFMT_V1 is not set
 CONFIG_QFMT_V2=y
@@ -708,6 +966,7 @@ CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+# CONFIG_LOGFS is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_SQUASHFS is not set
 # CONFIG_VXFS_FS is not set
@@ -723,7 +982,9 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
+# CONFIG_NFS_V4_1 is not set
 CONFIG_ROOT_NFS=y
+# CONFIG_NFSD is not set
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_NFS_ACL_SUPPORT=y
@@ -731,6 +992,13 @@ CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 CONFIG_SUNRPC_GSS=y
 CONFIG_RPCSEC_GSS_KRB5=y
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CEPH_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
 
 #
 # Partition Types
@@ -793,6 +1061,7 @@ CONFIG_NLS_ISO8859_1=y
 # CONFIG_NLS_KOI8_R is not set
 # CONFIG_NLS_KOI8_U is not set
 # CONFIG_NLS_UTF8 is not set
+# CONFIG_DLM is not set
 
 #
 # Kernel hacking
@@ -847,13 +1116,11 @@ CONFIG_FRAME_POINTER=y
 # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
 # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
 # CONFIG_FAULT_INJECTION is not set
+# CONFIG_SYSCTL_SYSCALL_CHECK is not set
 # CONFIG_PAGE_POISONING is not set
 CONFIG_HAVE_FUNCTION_TRACER=y
 CONFIG_TRACING_SUPPORT=y
 # CONFIG_FTRACE is not set
-# CONFIG_BRANCH_PROFILE_NONE is not set
-# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
-# CONFIG_PROFILE_ALL_BRANCHES is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_KGDB is not set
@@ -862,6 +1129,7 @@ CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_DEBUG_ERRORS is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUG_LL is not set
+# CONFIG_OC_ETM is not set
 
 #
 # Security options
@@ -869,7 +1137,11 @@ CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
 # CONFIG_SECURITYFS is not set
-# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+# CONFIG_DEFAULT_SECURITY_SELINUX is not set
+# CONFIG_DEFAULT_SECURITY_SMACK is not set
+# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
 CONFIG_CRYPTO=y
 
 #
@@ -888,6 +1160,7 @@ CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_MANAGER2=y
 # CONFIG_CRYPTO_GF128MUL is not set
 # CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_PCRYPT is not set
 CONFIG_CRYPTO_WORKQUEUE=y
 # CONFIG_CRYPTO_CRYPTD is not set
 # CONFIG_CRYPTO_AUTHENC is not set
@@ -986,3 +1259,4 @@ CONFIG_DECOMPRESS_GZIP=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y

