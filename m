From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCHv2 4/4] [OMAP] HTCHERALD: MMC, I2C, HTCPLD and related devices
Date: Tue,  1 Jun 2010 08:41:45 -0700
Message-ID: <1275406905-12200-1-git-send-email-darkstar6262@gmail.com>
References: <1275110887-2918-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48041 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756731Ab0FAPmN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 11:42:13 -0400
Received: by iwn6 with SMTP id 6so849439iwn.19
        for <linux-omap@vger.kernel.org>; Tue, 01 Jun 2010 08:42:12 -0700 (PDT)
In-Reply-To: <1275110887-2918-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linwizard-devel@lists.sf.net, Cory Maccarrone <darkstar6262@gmail.com>

This change adds in MMC and I2C support to the HTC Herald board, as well
as adding the HTCPLD driver for the PLD used on this phone.  It also
adds in the gpio-keys entries for the front directional keys and
selector and the cursor keys on the slide-out keyboard, and gpio-leds
support for the LEDs attached to the htcpld.

The Kconfig was also modified to add 64 GPIOs and IRQs to the default
maximum number of each for the HTC herald.  This is needed because the
HTCPLD chip on this board exposes an additional 32 gpios and 16 irqs
that would not fit in the default limits.

The defconfig has been updated to reflect the changes.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/configs/htcherald_defconfig  |  376 +++++++++++++++++++++++++++++----
 arch/arm/mach-omap1/Kconfig           |    2 +
 arch/arm/mach-omap1/Makefile          |    2 +-
 arch/arm/mach-omap1/board-htcherald.c |  288 ++++++++++++++++++++++++-
 4 files changed, 621 insertions(+), 47 deletions(-)

diff --git a/arch/arm/configs/htcherald_defconfig b/arch/arm/configs/htcherald_defconfig
index e0ef0d1..42deef6 100644
--- a/arch/arm/configs/htcherald_defconfig
+++ b/arch/arm/configs/htcherald_defconfig
@@ -1,13 +1,15 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.32-rc8
-# Sat Dec  5 12:16:24 2009
+# Linux kernel version: 2.6.34
+# Fri May 28 21:34:49 2010
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
 CONFIG_GENERIC_GPIO=y
 CONFIG_GENERIC_TIME=y
+# CONFIG_ARCH_USES_GETTIMEOFFSET is not set
 CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_HAVE_PROC_CPU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_HAVE_LATENCYTOP_SUPPORT=y
@@ -19,6 +21,7 @@ CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_ARCH_HAS_CPUFREQ=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_NEED_DMA_MAP_STATE=y
 CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 CONFIG_VECTORS_BASE=0xffff0000
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
@@ -33,6 +36,13 @@ CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
+CONFIG_HAVE_KERNEL_GZIP=y
+CONFIG_HAVE_KERNEL_LZMA=y
+CONFIG_HAVE_KERNEL_LZO=y
+CONFIG_KERNEL_GZIP=y
+# CONFIG_KERNEL_BZIP2 is not set
+# CONFIG_KERNEL_LZMA is not set
+# CONFIG_KERNEL_LZO is not set
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 CONFIG_SYSVIPC_SYSCTL=y
@@ -46,13 +56,13 @@ CONFIG_SYSVIPC_SYSCTL=y
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
-# CONFIG_GROUP_SCHED is not set
 # CONFIG_CGROUPS is not set
 # CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
@@ -67,6 +77,7 @@ CONFIG_INITRAMFS_SOURCE=""
 CONFIG_RD_GZIP=y
 CONFIG_RD_BZIP2=y
 CONFIG_RD_LZMA=y
+CONFIG_RD_LZO=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
 CONFIG_ANON_INODES=y
@@ -87,10 +98,14 @@ CONFIG_TIMERFD=y
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
 CONFIG_COMPAT_BRK=y
 CONFIG_SLAB=y
@@ -126,14 +141,41 @@ CONFIG_LBDAF=y
 # IO Schedulers
 #
 CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
-# CONFIG_DEFAULT_AS is not set
 # CONFIG_DEFAULT_DEADLINE is not set
 CONFIG_DEFAULT_CFQ=y
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="cfq"
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
+# CONFIG_MUTEX_SPIN_ON_OWNER is not set
 CONFIG_FREEZER=y
 
 #
@@ -144,8 +186,11 @@ CONFIG_MMU=y
 # CONFIG_ARCH_INTEGRATOR is not set
 # CONFIG_ARCH_REALVIEW is not set
 # CONFIG_ARCH_VERSATILE is not set
+# CONFIG_ARCH_VEXPRESS is not set
 # CONFIG_ARCH_AT91 is not set
+# CONFIG_ARCH_BCMRING is not set
 # CONFIG_ARCH_CLPS711X is not set
+# CONFIG_ARCH_CNS3XXX is not set
 # CONFIG_ARCH_GEMINI is not set
 # CONFIG_ARCH_EBSA110 is not set
 # CONFIG_ARCH_EP93XX is not set
@@ -154,7 +199,6 @@ CONFIG_MMU=y
 # CONFIG_ARCH_STMP3XXX is not set
 # CONFIG_ARCH_NETX is not set
 # CONFIG_ARCH_H720X is not set
-# CONFIG_ARCH_NOMADIK is not set
 # CONFIG_ARCH_IOP13XX is not set
 # CONFIG_ARCH_IOP32X is not set
 # CONFIG_ARCH_IOP33X is not set
@@ -162,6 +206,7 @@ CONFIG_MMU=y
 # CONFIG_ARCH_IXP2000 is not set
 # CONFIG_ARCH_IXP4XX is not set
 # CONFIG_ARCH_L7200 is not set
+# CONFIG_ARCH_DOVE is not set
 # CONFIG_ARCH_KIRKWOOD is not set
 # CONFIG_ARCH_LOKI is not set
 # CONFIG_ARCH_MV78XX0 is not set
@@ -170,29 +215,38 @@ CONFIG_MMU=y
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
-# CONFIG_ARCH_S5PC1XX is not set
+# CONFIG_ARCH_S5P6440 is not set
+# CONFIG_ARCH_S5P6442 is not set
+# CONFIG_ARCH_S5PC100 is not set
+# CONFIG_ARCH_S5PV210 is not set
 # CONFIG_ARCH_SHARK is not set
 # CONFIG_ARCH_LH7A40X is not set
 # CONFIG_ARCH_U300 is not set
+# CONFIG_ARCH_U8500 is not set
+# CONFIG_ARCH_NOMADIK is not set
 # CONFIG_ARCH_DAVINCI is not set
 CONFIG_ARCH_OMAP=y
-# CONFIG_ARCH_BCMRING is not set
+# CONFIG_PLAT_SPEAR is not set
 
 #
 # TI OMAP Implementations
 #
+CONFIG_OMAP_GPIO_EXTRA=64
+CONFIG_OMAP_GPIO_EXTRA64=y
+CONFIG_OMAP_IRQ_EXTRA=64
+CONFIG_OMAP_IRQ_EXTRA64=y
 CONFIG_ARCH_OMAP_OTG=y
 CONFIG_ARCH_OMAP1=y
-# CONFIG_ARCH_OMAP2 is not set
-# CONFIG_ARCH_OMAP3 is not set
-# CONFIG_ARCH_OMAP4 is not set
+# CONFIG_ARCH_OMAP2PLUS is not set
 
 #
 # OMAP Feature Selections
@@ -205,10 +259,6 @@ CONFIG_OMAP_MCBSP=y
 # CONFIG_OMAP_MBOX_FWK is not set
 CONFIG_OMAP_MPU_TIMER=y
 # CONFIG_OMAP_32K_TIMER is not set
-CONFIG_OMAP_LL_DEBUG_UART1=y
-# CONFIG_OMAP_LL_DEBUG_UART2 is not set
-# CONFIG_OMAP_LL_DEBUG_UART3 is not set
-# CONFIG_OMAP_LL_DEBUG_NONE is not set
 CONFIG_OMAP_SERIAL_WAKE=y
 # CONFIG_OMAP_PM_NONE is not set
 CONFIG_OMAP_PM_NOOP=y
@@ -289,6 +339,7 @@ CONFIG_PREEMPT=y
 CONFIG_HZ=100
 CONFIG_AEABI=y
 CONFIG_OABI_COMPAT=y
+CONFIG_ARCH_HAS_HOLES_MEMORYMODEL=y
 # CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
 # CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
 # CONFIG_HIGHMEM is not set
@@ -299,12 +350,10 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_PAGEFLAGS_EXTENDED=y
-CONFIG_SPLIT_PTLOCK_CPUS=4096
+CONFIG_SPLIT_PTLOCK_CPUS=999999
 # CONFIG_PHYS_ADDR_T_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=0
 CONFIG_VIRT_TO_BUS=y
-CONFIG_HAVE_MLOCK=y
-CONFIG_HAVE_MLOCKED_PAGE_BIT=y
 # CONFIG_KSM is not set
 CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
 CONFIG_LEDS=y
@@ -317,6 +366,7 @@ CONFIG_ALIGNMENT_TRAP=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="mem=32M console=ttyS0,115200 ip=dhcp"
+# CONFIG_CMDLINE_FORCE is not set
 # CONFIG_XIP_KERNEL is not set
 # CONFIG_KEXEC is not set
 
@@ -357,6 +407,7 @@ CONFIG_SUSPEND=y
 CONFIG_SUSPEND_FREEZER=y
 # CONFIG_APM_EMULATION is not set
 # CONFIG_PM_RUNTIME is not set
+CONFIG_PM_OPS=y
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 CONFIG_NET=y
 
@@ -364,7 +415,6 @@ CONFIG_NET=y
 # Networking options
 #
 CONFIG_PACKET=y
-# CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
@@ -408,6 +458,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_RDS is not set
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
+# CONFIG_L2TP is not set
 # CONFIG_BRIDGE is not set
 # CONFIG_NET_DSA is not set
 # CONFIG_VLAN_8021Q is not set
@@ -435,17 +486,19 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_AF_RXRPC is not set
 CONFIG_WIRELESS=y
 # CONFIG_CFG80211 is not set
-CONFIG_CFG80211_DEFAULT_PS_VALUE=0
-# CONFIG_WIRELESS_OLD_REGULATORY is not set
-# CONFIG_WIRELESS_EXT is not set
 # CONFIG_LIB80211 is not set
 
 #
 # CFG80211 needs to be enabled for MAC80211
 #
+
+#
+# Some wireless drivers require a rate control algorithm
+#
 # CONFIG_WIMAX is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
+# CONFIG_CAIF is not set
 
 #
 # Device Drivers
@@ -469,6 +522,10 @@ CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
+
+#
+# DRBD disabled because PROC_FS, INET or CONNECTOR not selected
+#
 # CONFIG_BLK_DEV_NBD is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
@@ -478,19 +535,29 @@ CONFIG_BLK_DEV_RAM_SIZE=8192
 # CONFIG_ATA_OVER_ETH is not set
 # CONFIG_MG_DISK is not set
 CONFIG_MISC_DEVICES=y
+# CONFIG_AD525X_DPOT is not set
+# CONFIG_ICS932S401 is not set
 # CONFIG_ENCLOSURE_SERVICES is not set
+# CONFIG_ISL29003 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_DS1682 is not set
 # CONFIG_C2PORT is not set
 
 #
 # EEPROM support
 #
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
+# CONFIG_EEPROM_MAX6875 is not set
 # CONFIG_EEPROM_93CX6 is not set
+# CONFIG_IWMC3200TOP is not set
 CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
 
 #
 # SCSI device support
 #
+CONFIG_SCSI_MOD=y
 # CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
 # CONFIG_SCSI_DMA is not set
@@ -527,8 +594,7 @@ CONFIG_SMC91X=y
 CONFIG_NETDEV_1000=y
 CONFIG_NETDEV_10000=y
 CONFIG_WLAN=y
-# CONFIG_WLAN_PRE80211 is not set
-# CONFIG_WLAN_80211 is not set
+# CONFIG_HOSTAP is not set
 
 #
 # Enable WiMAX (Networking options) to see the WiMAX drivers
@@ -548,6 +614,7 @@ CONFIG_WLAN=y
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
 # CONFIG_INPUT_POLLDEV is not set
+# CONFIG_INPUT_SPARSEKMAP is not set
 
 #
 # Userland interfaces
@@ -557,17 +624,22 @@ CONFIG_INPUT_MOUSEDEV_PSAUX=y
 CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
 CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_EVDEV is not set
+CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_EVBUG is not set
 
 #
 # Input Device Drivers
 #
 CONFIG_INPUT_KEYBOARD=y
+# CONFIG_KEYBOARD_ADP5588 is not set
 # CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_QT2160 is not set
 # CONFIG_KEYBOARD_LKKBD is not set
-# CONFIG_KEYBOARD_GPIO is not set
+CONFIG_KEYBOARD_GPIO=y
+# CONFIG_KEYBOARD_TCA6416 is not set
 # CONFIG_KEYBOARD_MATRIX is not set
+# CONFIG_KEYBOARD_LM8323 is not set
+# CONFIG_KEYBOARD_MAX7359 is not set
 # CONFIG_KEYBOARD_NEWTON is not set
 # CONFIG_KEYBOARD_OPENCORES is not set
 # CONFIG_KEYBOARD_STOWAWAY is not set
@@ -586,6 +658,7 @@ CONFIG_KEYBOARD_OMAP=y
 CONFIG_SERIO=y
 CONFIG_SERIO_SERPORT=y
 # CONFIG_SERIO_RAW is not set
+# CONFIG_SERIO_ALTERA_PS2 is not set
 # CONFIG_GAMEPORT is not set
 
 #
@@ -598,6 +671,7 @@ CONFIG_HW_CONSOLE=y
 # CONFIG_VT_HW_CONSOLE_BINDING is not set
 CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_N_GSM is not set
 
 #
 # Serial drivers
@@ -611,6 +685,9 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 # Non-8250 serial port support
 #
 CONFIG_SERIAL_CORE=m
+# CONFIG_SERIAL_TIMBERDALE is not set
+# CONFIG_SERIAL_ALTERA_JTAGUART is not set
+# CONFIG_SERIAL_ALTERA_UART is not set
 CONFIG_UNIX98_PTYS=y
 # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 # CONFIG_LEGACY_PTYS is not set
@@ -620,7 +697,49 @@ CONFIG_HW_RANDOM=m
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
-# CONFIG_I2C is not set
+# CONFIG_RAMOOPS is not set
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_COMPAT=y
+CONFIG_I2C_CHARDEV=y
+# CONFIG_I2C_HELPER_AUTO is not set
+# CONFIG_I2C_SMBUS is not set
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
+
+#
+# I2C system bus drivers (mostly embedded / system-on-chip)
+#
+# CONFIG_I2C_DESIGNWARE is not set
+CONFIG_I2C_GPIO=y
+# CONFIG_I2C_OCORES is not set
+CONFIG_I2C_OMAP=y
+# CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_XILINX is not set
+
+#
+# External I2C/SMBus adapter drivers
+#
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_TAOS_EVM is not set
+
+#
+# Other I2C/SMBus bus drivers
+#
+# CONFIG_I2C_PCA_PLATFORM is not set
+# CONFIG_I2C_STUB is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
 # CONFIG_SPI is not set
 
 #
@@ -634,10 +753,16 @@ CONFIG_GPIOLIB=y
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
+# CONFIG_GPIO_ADP5588 is not set
 
 #
 # PCI GPIO expanders:
@@ -659,17 +784,70 @@ CONFIG_HWMON=y
 #
 # Native drivers
 #
+# CONFIG_SENSORS_AD7414 is not set
+# CONFIG_SENSORS_AD7418 is not set
+# CONFIG_SENSORS_ADM1021 is not set
+# CONFIG_SENSORS_ADM1025 is not set
+# CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1029 is not set
+# CONFIG_SENSORS_ADM1031 is not set
+# CONFIG_SENSORS_ADM9240 is not set
+# CONFIG_SENSORS_ADT7411 is not set
+# CONFIG_SENSORS_ADT7462 is not set
+# CONFIG_SENSORS_ADT7470 is not set
+# CONFIG_SENSORS_ADT7475 is not set
+# CONFIG_SENSORS_ASC7621 is not set
+# CONFIG_SENSORS_ATXP1 is not set
+# CONFIG_SENSORS_DS1621 is not set
 # CONFIG_SENSORS_F71805F is not set
 # CONFIG_SENSORS_F71882FG is not set
+# CONFIG_SENSORS_F75375S is not set
+# CONFIG_SENSORS_G760A is not set
+# CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_GL520SM is not set
 # CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_LM63 is not set
+# CONFIG_SENSORS_LM73 is not set
+# CONFIG_SENSORS_LM75 is not set
+# CONFIG_SENSORS_LM77 is not set
+# CONFIG_SENSORS_LM78 is not set
+# CONFIG_SENSORS_LM80 is not set
+# CONFIG_SENSORS_LM83 is not set
+# CONFIG_SENSORS_LM85 is not set
+# CONFIG_SENSORS_LM87 is not set
+# CONFIG_SENSORS_LM90 is not set
+# CONFIG_SENSORS_LM92 is not set
+# CONFIG_SENSORS_LM93 is not set
+# CONFIG_SENSORS_LTC4215 is not set
+# CONFIG_SENSORS_LTC4245 is not set
+# CONFIG_SENSORS_LM95241 is not set
+# CONFIG_SENSORS_MAX1619 is not set
+# CONFIG_SENSORS_MAX6650 is not set
 # CONFIG_SENSORS_PC87360 is not set
 # CONFIG_SENSORS_PC87427 is not set
+# CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_SENSORS_SHT15 is not set
+# CONFIG_SENSORS_DME1737 is not set
+# CONFIG_SENSORS_EMC1403 is not set
 # CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_SMSC47M192 is not set
 # CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_ADS7828 is not set
+# CONFIG_SENSORS_AMC6821 is not set
+# CONFIG_SENSORS_THMC50 is not set
+# CONFIG_SENSORS_TMP102 is not set
+# CONFIG_SENSORS_TMP401 is not set
+# CONFIG_SENSORS_TMP421 is not set
 # CONFIG_SENSORS_VT1211 is not set
+# CONFIG_SENSORS_W83781D is not set
+# CONFIG_SENSORS_W83791D is not set
+# CONFIG_SENSORS_W83792D is not set
+# CONFIG_SENSORS_W83793 is not set
+# CONFIG_SENSORS_W83L785TS is not set
+# CONFIG_SENSORS_W83L786NG is not set
 # CONFIG_SENSORS_W83627HF is not set
 # CONFIG_SENSORS_W83627EHF is not set
+# CONFIG_SENSORS_LIS3_I2C is not set
 # CONFIG_THERMAL is not set
 # CONFIG_WATCHDOG is not set
 CONFIG_SSB_POSSIBLE=y
@@ -683,14 +861,27 @@ CONFIG_SSB_POSSIBLE=y
 # Multifunction device drivers
 #
 # CONFIG_MFD_CORE is not set
+# CONFIG_MFD_88PM860X is not set
 # CONFIG_MFD_SM501 is not set
 # CONFIG_MFD_ASIC3 is not set
 # CONFIG_HTC_EGPIO is not set
 # CONFIG_HTC_PASIC3 is not set
+CONFIG_HTC_I2CPLD=y
+# CONFIG_TPS65010 is not set
+# CONFIG_TWL4030_CORE is not set
 # CONFIG_MFD_TMIO is not set
 # CONFIG_MFD_T7L66XB is not set
 # CONFIG_MFD_TC6387XB is not set
 # CONFIG_MFD_TC6393XB is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_PMIC_ADP5520 is not set
+# CONFIG_MFD_MAX8925 is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM831X is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_WM8994 is not set
+# CONFIG_MFD_PCF50633 is not set
+# CONFIG_AB3100_CORE is not set
 # CONFIG_REGULATOR is not set
 # CONFIG_MEDIA_SUPPORT is not set
 
@@ -731,7 +922,12 @@ CONFIG_FB_OMAP=y
 # CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
 CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
 # CONFIG_FB_OMAP_DMA_TUNE is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+# CONFIG_LCD_CLASS_DEVICE is not set
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+# CONFIG_BACKLIGHT_GENERIC is not set
+# CONFIG_BACKLIGHT_OMAP1 is not set
+# CONFIG_BACKLIGHT_ADP8860 is not set
 
 #
 # Display device support
@@ -809,17 +1005,25 @@ CONFIG_USB_ETH=y
 # CONFIG_USB_ETH_RNDIS is not set
 # CONFIG_USB_ETH_EEM is not set
 # CONFIG_USB_GADGETFS is not set
+# CONFIG_USB_FUNCTIONFS is not set
 # CONFIG_USB_FILE_STORAGE is not set
+# CONFIG_USB_MASS_STORAGE is not set
 # CONFIG_USB_G_SERIAL is not set
 # CONFIG_USB_MIDI_GADGET is not set
 # CONFIG_USB_G_PRINTER is not set
 # CONFIG_USB_CDC_COMPOSITE is not set
+# CONFIG_USB_G_NOKIA is not set
+# CONFIG_USB_G_MULTI is not set
+# CONFIG_USB_G_HID is not set
+# CONFIG_USB_G_WEBCAM is not set
 
 #
 # OTG and related infrastructure
 #
 CONFIG_USB_OTG_UTILS=y
 # CONFIG_USB_GPIO_VBUS is not set
+# CONFIG_ISP1301_OMAP is not set
+# CONFIG_USB_ULPI is not set
 # CONFIG_NOP_USB_XCEIV is not set
 CONFIG_MMC=y
 # CONFIG_MMC_DEBUG is not set
@@ -836,13 +1040,36 @@ CONFIG_MMC_BLOCK_BOUNCE=y
 #
 # MMC/SD/SDIO Host Controller Drivers
 #
-CONFIG_MMC_SDHCI=y
-CONFIG_MMC_SDHCI_PLTFM=y
+# CONFIG_MMC_SDHCI is not set
 CONFIG_MMC_OMAP=y
-# CONFIG_MMC_AT91 is not set
-# CONFIG_MMC_ATMELMCI is not set
 # CONFIG_MEMSTICK is not set
-# CONFIG_NEW_LEDS is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+
+#
+# LED drivers
+#
+# CONFIG_LEDS_PCA9532 is not set
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_GPIO_PLATFORM=y
+# CONFIG_LEDS_LP3944 is not set
+# CONFIG_LEDS_PCA955X is not set
+# CONFIG_LEDS_BD2802 is not set
+# CONFIG_LEDS_LT3593 is not set
+CONFIG_LEDS_TRIGGERS=y
+
+#
+# LED Triggers
+#
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_BACKLIGHT=y
+CONFIG_LEDS_TRIGGER_GPIO=y
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
+
+#
+# iptables trigger is under Netfilter config (LED target)
+#
 # CONFIG_ACCESSIBILITY is not set
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
@@ -860,6 +1087,25 @@ CONFIG_RTC_INTF_DEV=y
 # CONFIG_RTC_DRV_TEST is not set
 
 #
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
+# CONFIG_RTC_DRV_S35390A is not set
+# CONFIG_RTC_DRV_FM3130 is not set
+# CONFIG_RTC_DRV_RX8581 is not set
+# CONFIG_RTC_DRV_RX8025 is not set
+
+#
 # SPI RTC drivers
 #
 
@@ -875,7 +1121,9 @@ CONFIG_RTC_INTF_DEV=y
 # CONFIG_RTC_DRV_M48T86 is not set
 # CONFIG_RTC_DRV_M48T35 is not set
 # CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_MSM6242 is not set
 # CONFIG_RTC_DRV_BQ4802 is not set
+# CONFIG_RTC_DRV_RP5C01 is not set
 # CONFIG_RTC_DRV_V3020 is not set
 
 #
@@ -884,10 +1132,6 @@ CONFIG_RTC_INTF_DEV=y
 # CONFIG_DMADEVICES is not set
 # CONFIG_AUXDISPLAY is not set
 # CONFIG_UIO is not set
-
-#
-# TI VLYNQ
-#
 # CONFIG_STAGING is not set
 
 #
@@ -936,8 +1180,11 @@ CONFIG_INOTIFY_USER=y
 #
 # DOS/FAT/NT Filesystems
 #
+CONFIG_FAT_FS=y
 # CONFIG_MSDOS_FS is not set
-# CONFIG_VFAT_FS is not set
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
 
 #
@@ -959,6 +1206,7 @@ CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+# CONFIG_LOGFS is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_SQUASHFS is not set
 # CONFIG_VXFS_FS is not set
@@ -981,6 +1229,7 @@ CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
+# CONFIG_CEPH_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
@@ -991,7 +1240,46 @@ CONFIG_SUNRPC=y
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
-# CONFIG_NLS is not set
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=y
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
+CONFIG_NLS_ISO8859_1=y
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
 # CONFIG_DLM is not set
 
 #
@@ -1015,10 +1303,12 @@ CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_HAVE_FUNCTION_TRACER=y
 CONFIG_TRACING_SUPPORT=y
 # CONFIG_FTRACE is not set
+# CONFIG_ATOMIC64_SELFTEST is not set
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 CONFIG_ARM_UNWIND=y
 # CONFIG_DEBUG_USER is not set
+# CONFIG_OC_ETM is not set
 
 #
 # Security options
@@ -1026,7 +1316,11 @@ CONFIG_ARM_UNWIND=y
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
@@ -1138,7 +1432,9 @@ CONFIG_LZO_DECOMPRESS=y
 CONFIG_DECOMPRESS_GZIP=y
 CONFIG_DECOMPRESS_BZIP2=y
 CONFIG_DECOMPRESS_LZMA=y
+CONFIG_DECOMPRESS_LZO=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
 CONFIG_NLATTR=y
+CONFIG_GENERIC_ATOMIC64=y
diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index b18d7c2..6505109 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -60,6 +60,8 @@ config MACH_OMAP_HTCWIZARD
 config MACH_HERALD
 	bool "HTC Herald"
 	depends on ARCH_OMAP850
+	select OMAP_GPIO_EXTRA64
+	select OMAP_IRQ_EXTRA64
 	help
 	  HTC Herald smartphone support (AKA T-Mobile Wing, ...)
 
diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index ea231c7..bcf15d8 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -39,7 +39,7 @@ obj-$(CONFIG_MACH_NOKIA770)		+= board-nokia770.o
 obj-$(CONFIG_MACH_AMS_DELTA)		+= board-ams-delta.o
 obj-$(CONFIG_AMS_DELTA_FIQ)		+= ams-delta-fiq.o ams-delta-fiq-handler.o
 obj-$(CONFIG_MACH_SX1)			+= board-sx1.o board-sx1-mmc.o
-obj-$(CONFIG_MACH_HERALD)		+= board-htcherald.o
+obj-$(CONFIG_MACH_HERALD)		+= board-htcherald.o htc-mmc.o
 
 ifeq ($(CONFIG_ARCH_OMAP15XX),y)
 # Innovator-1510 FPGA
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 8e313b4..fa57ee9 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -30,6 +30,11 @@
 #include <linux/input.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/gpio_keys.h>
+#include <linux/i2c.h>
+#include <linux/i2c-gpio.h>
+#include <linux/htcpld.h>
+#include <linux/leds.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -39,6 +44,7 @@
 #include <plat/board.h>
 #include <plat/keypad.h>
 #include <plat/usb.h>
+#include <plat/mmc.h>
 
 #include <mach/irqs.h>
 
@@ -52,13 +58,121 @@
 #define       OMAP_LCDC_CTRL_LCD_EN           (1 << 0)
 #define       OMAP_LCDC_STAT_DONE             (1 << 0)
 
-static struct omap_lcd_config htcherald_lcd_config __initdata = {
-	.ctrl_name	= "internal",
-};
+/* GPIO definitions for the power button and keyboard slide switch */
+#define HTCHERALD_GPIO_POWER 139
+#define HTCHERALD_GPIO_SLIDE 174
+#define HTCHERALD_GIRQ_BTNS 141
 
-static struct omap_board_config_kernel htcherald_config[] __initdata = {
-	{ OMAP_TAG_LCD, &htcherald_lcd_config },
-};
+/* HTCPLD definitions */
+
+/*
+ * CPLD Logic
+ *
+
+Chip 3 - 0x03
+
+Function            7 6 5 4  3 2 1 0
+------------------------------------
+DPAD light          x x x x  x x x 1
+SoundDev            x x x x  1 x x x
+Screen white        1 x x x  x x x x
+MMC power on        x x x x  x 1 x x
+Happy times (n)     0 x x x  x 1 x x
+
+Chip 4 - 0x04
+
+Function            7 6 5 4  3 2 1 0
+------------------------------------
+Keyboard light      x x x x  x x x 1
+LCD Bright (4)      x x x x  x 1 1 x
+LCD Bright (3)      x x x x  x 0 1 x
+LCD Bright (2)      x x x x  x 1 0 x
+LCD Bright (1)      x x x x  x 0 0 x
+LCD Off             x x x x  0 x x x
+LCD image (fb)      1 x x x  x x x x
+LCD image (white)   0 x x x  x x x x
+Caps lock LED       x x 1 x  x x x x
+
+Chip 5 - 0x05
+
+Function            7 6 5 4  3 2 1 0
+------------------------------------
+Red (solid)         x x x x  x 1 x x
+Red (flash)         x x x x  x x 1 x
+Green (GSM flash)   x x x x  1 x x x
+Green (GSM solid)   x x x 1  x x x x
+Green (wifi flash)  x x 1 x  x x x x
+Blue (bt flash)     x 1 x x  x x x x
+DPAD Int Enable     1 x x x  x x x 0
+
+(Combinations of the above can be made for different colors.)
+The direction pad interrupt enable must be set each time the
+interrupt is handled.
+
+Chip 6 - 0x06
+
+Function            7 6 5 4  3 2 1 0
+------------------------------------
+Vibrator            x x x x  1 x x x
+Alt LED             x x x 1  x x x x
+Screen white        1 x x x  x x x x
+Screen white        x x 1 x  x x x x
+Screen white        x 0 x x  x x x x
+Enable kbd dpad     x x x x  x x 0 x
+Happy Times         0 1 0 x  x x 0 x
+*/
+
+/*
+ * HTCPLD GPIO lines start 16 after OMAP_MAX_GPIO_LINES to account
+ * for the 16 MPUIO lines.
+ */
+#define HTCPLD_GPIO_START_OFFSET	(OMAP_MAX_GPIO_LINES + 16)
+#define HTCPLD_IRQ(chip, offset)	(OMAP_IRQ_END + 8 * (chip) + (offset))
+#define HTCPLD_BASE(chip, offset)	\
+	(HTCPLD_GPIO_START_OFFSET + 8 * (chip) + (offset))
+
+#define HTCPLD_GPIO_LED_DPAD		HTCPLD_BASE(0, 0)
+#define HTCPLD_GPIO_LED_KBD		HTCPLD_BASE(1, 0)
+#define HTCPLD_GPIO_LED_CAPS		HTCPLD_BASE(1, 5)
+#define HTCPLD_GPIO_LED_RED_FLASH	HTCPLD_BASE(2, 1)
+#define HTCPLD_GPIO_LED_RED_SOLID	HTCPLD_BASE(2, 2)
+#define HTCPLD_GPIO_LED_GREEN_FLASH	HTCPLD_BASE(2, 3)
+#define HTCPLD_GPIO_LED_GREEN_SOLID	HTCPLD_BASE(2, 4)
+#define HTCPLD_GPIO_LED_WIFI		HTCPLD_BASE(2, 5)
+#define HTCPLD_GPIO_LED_BT		HTCPLD_BASE(2, 6)
+#define HTCPLD_GPIO_LED_VIBRATE		HTCPLD_BASE(3, 3)
+#define HTCPLD_GPIO_LED_ALT		HTCPLD_BASE(3, 4)
+
+#define HTCPLD_GPIO_RIGHT_KBD		HTCPLD_BASE(6, 7)
+#define HTCPLD_GPIO_UP_KBD		HTCPLD_BASE(6, 6)
+#define HTCPLD_GPIO_LEFT_KBD		HTCPLD_BASE(6, 5)
+#define HTCPLD_GPIO_DOWN_KBD		HTCPLD_BASE(6, 4)
+
+#define HTCPLD_GPIO_RIGHT_DPAD		HTCPLD_BASE(7, 7)
+#define HTCPLD_GPIO_UP_DPAD		HTCPLD_BASE(7, 6)
+#define HTCPLD_GPIO_LEFT_DPAD		HTCPLD_BASE(7, 5)
+#define HTCPLD_GPIO_DOWN_DPAD		HTCPLD_BASE(7, 4)
+#define HTCPLD_GPIO_ENTER_DPAD		HTCPLD_BASE(7, 3)
+
+/*
+ * The htcpld chip requires a gpio write to a specific line
+ * to re-enable interrupts after one has occurred.
+ */
+#define HTCPLD_GPIO_INT_RESET_HI	HTCPLD_BASE(2, 7)
+#define HTCPLD_GPIO_INT_RESET_LO	HTCPLD_BASE(2, 0)
+
+/* Chip 5 */
+#define HTCPLD_IRQ_RIGHT_KBD		HTCPLD_IRQ(0, 7)
+#define HTCPLD_IRQ_UP_KBD		HTCPLD_IRQ(0, 6)
+#define HTCPLD_IRQ_LEFT_KBD		HTCPLD_IRQ(0, 5)
+#define HTCPLD_IRQ_DOWN_KBD		HTCPLD_IRQ(0, 4)
+
+/* Chip 6 */
+#define HTCPLD_IRQ_RIGHT_DPAD		HTCPLD_IRQ(1, 7)
+#define HTCPLD_IRQ_UP_DPAD		HTCPLD_IRQ(1, 6)
+#define HTCPLD_IRQ_LEFT_DPAD		HTCPLD_IRQ(1, 5)
+#define HTCPLD_IRQ_DOWN_DPAD		HTCPLD_IRQ(1, 4)
+#define HTCPLD_IRQ_ENTER_DPAD		HTCPLD_IRQ(1, 3)
 
 /* Keyboard definition */
 
@@ -140,6 +254,129 @@ static struct platform_device kp_device = {
 	.resource	= kp_resources,
 };
 
+/* GPIO buttons for keyboard slide and power button */
+static struct gpio_keys_button herald_gpio_keys_table[] = {
+	{BTN_0,  HTCHERALD_GPIO_POWER, 1, "POWER", EV_KEY, 1, 20},
+	{SW_LID, HTCHERALD_GPIO_SLIDE, 0, "SLIDE", EV_SW,  1, 20},
+
+	{KEY_LEFT,  HTCPLD_GPIO_LEFT_KBD,  1, "LEFT",  EV_KEY, 1, 20},
+	{KEY_RIGHT, HTCPLD_GPIO_RIGHT_KBD, 1, "RIGHT", EV_KEY, 1, 20},
+	{KEY_UP,    HTCPLD_GPIO_UP_KBD,    1, "UP",    EV_KEY, 1, 20},
+	{KEY_DOWN,  HTCPLD_GPIO_DOWN_KBD,  1, "DOWN",  EV_KEY, 1, 20},
+
+	{KEY_LEFT,  HTCPLD_GPIO_LEFT_DPAD,   1, "DLEFT",  EV_KEY, 1, 20},
+	{KEY_RIGHT, HTCPLD_GPIO_RIGHT_DPAD,  1, "DRIGHT", EV_KEY, 1, 20},
+	{KEY_UP,    HTCPLD_GPIO_UP_DPAD,     1, "DUP",    EV_KEY, 1, 20},
+	{KEY_DOWN,  HTCPLD_GPIO_DOWN_DPAD,   1, "DDOWN",  EV_KEY, 1, 20},
+	{KEY_ENTER, HTCPLD_GPIO_ENTER_DPAD,  1, "DENTER", EV_KEY, 1, 20},
+};
+
+static struct gpio_keys_platform_data herald_gpio_keys_data = {
+	.buttons	= herald_gpio_keys_table,
+	.nbuttons	= ARRAY_SIZE(herald_gpio_keys_table),
+	.rep		= 1,
+};
+
+static struct platform_device herald_gpiokeys_device = {
+	.name      = "gpio-keys",
+	.id		= -1,
+	.dev = {
+		.platform_data = &herald_gpio_keys_data,
+	},
+};
+
+/* LEDs for the Herald.  These connect to the HTCPLD GPIO device. */
+static struct gpio_led gpio_leds[] = {
+	{"dpad",        NULL, HTCPLD_GPIO_LED_DPAD,        0, 0, LEDS_GPIO_DEFSTATE_OFF},
+	{"kbd",         NULL, HTCPLD_GPIO_LED_KBD,         0, 0, LEDS_GPIO_DEFSTATE_OFF},
+	{"vibrate",     NULL, HTCPLD_GPIO_LED_VIBRATE,     0, 0, LEDS_GPIO_DEFSTATE_OFF},
+	{"green_solid", NULL, HTCPLD_GPIO_LED_GREEN_SOLID, 0, 0, LEDS_GPIO_DEFSTATE_OFF},
+	{"green_flash", NULL, HTCPLD_GPIO_LED_GREEN_FLASH, 0, 0, LEDS_GPIO_DEFSTATE_OFF},
+	{"red_solid",   "mmc0", HTCPLD_GPIO_LED_RED_SOLID, 0, 0, LEDS_GPIO_DEFSTATE_OFF},
+	{"red_flash",   NULL, HTCPLD_GPIO_LED_RED_FLASH,   0, 0, LEDS_GPIO_DEFSTATE_OFF},
+	{"wifi",        NULL, HTCPLD_GPIO_LED_WIFI,        0, 0, LEDS_GPIO_DEFSTATE_OFF},
+	{"bt",          NULL, HTCPLD_GPIO_LED_BT,          0, 0, LEDS_GPIO_DEFSTATE_OFF},
+	{"caps",        NULL, HTCPLD_GPIO_LED_CAPS,        0, 0, LEDS_GPIO_DEFSTATE_OFF},
+	{"alt",         NULL, HTCPLD_GPIO_LED_ALT,         0, 0, LEDS_GPIO_DEFSTATE_OFF},
+};
+
+static struct gpio_led_platform_data gpio_leds_data = {
+	.leds		= gpio_leds,
+	.num_leds	= ARRAY_SIZE(gpio_leds),
+};
+
+static struct platform_device gpio_leds_device = {
+	.name		= "leds-gpio",
+	.id		= 0,
+	.dev	= {
+		.platform_data	= &gpio_leds_data,
+	},
+};
+
+/* HTC PLD chips */
+
+static struct resource htcpld_resources[] = {
+	[0] = {
+		.start  = OMAP_GPIO_IRQ(HTCHERALD_GIRQ_BTNS),
+		.end    = OMAP_GPIO_IRQ(HTCHERALD_GIRQ_BTNS),
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+struct htcpld_chip_platform_data htcpld_chips[] = {
+	[0] = {
+		.addr		= 0x03,
+		.reset		= 0x04,
+		.num_gpios	= 8,
+		.gpio_out_base	= HTCPLD_BASE(0, 0),
+		.gpio_in_base	= HTCPLD_BASE(4, 0),
+	},
+	[1] = {
+		.addr		= 0x04,
+		.reset		= 0x8e,
+		.num_gpios	= 8,
+		.gpio_out_base	= HTCPLD_BASE(1, 0),
+		.gpio_in_base	= HTCPLD_BASE(5, 0),
+	},
+	[2] = {
+		.addr		= 0x05,
+		.reset		= 0x80,
+		.num_gpios	= 8,
+		.gpio_out_base	= HTCPLD_BASE(2, 0),
+		.gpio_in_base	= HTCPLD_BASE(6, 0),
+		.irq_base	= HTCPLD_IRQ(0, 0),
+		.num_irqs	= 8,
+	},
+	[3] = {
+		.addr		= 0x06,
+		.reset		= 0x40,
+		.num_gpios	= 8,
+		.gpio_out_base	= HTCPLD_BASE(3, 0),
+		.gpio_in_base	= HTCPLD_BASE(7, 0),
+		.irq_base	= HTCPLD_IRQ(1, 0),
+		.num_irqs	= 8,
+	},
+};
+
+struct htcpld_core_platform_data htcpld_pfdata = {
+	.int_reset_gpio_hi = HTCPLD_GPIO_INT_RESET_HI,
+	.int_reset_gpio_lo = HTCPLD_GPIO_INT_RESET_LO,
+	.i2c_adapter_id	   = 1,
+
+	.chip		   = htcpld_chips,
+	.num_chip	   = ARRAY_SIZE(htcpld_chips),
+};
+
+static struct platform_device htcpld_device = {
+	.name		= "i2c-htcpld",
+	.id		= -1,
+	.resource	= htcpld_resources,
+	.num_resources	= ARRAY_SIZE(htcpld_resources),
+	.dev	= {
+		.platform_data	= &htcpld_pfdata,
+	},
+};
+
 /* USB Device */
 static struct omap_usb_config htcherald_usb_config __initdata = {
 	.otg = 0,
@@ -150,14 +387,45 @@ static struct omap_usb_config htcherald_usb_config __initdata = {
 };
 
 /* LCD Device resources */
+static struct omap_lcd_config htcherald_lcd_config __initdata = {
+	.ctrl_name	= "internal",
+};
+
+static struct omap_board_config_kernel htcherald_config[] __initdata = {
+	{ OMAP_TAG_LCD, &htcherald_lcd_config },
+};
+
 static struct platform_device lcd_device = {
 	.name           = "lcd_htcherald",
 	.id             = -1,
 };
 
+/* MMC Card */
+#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
+static struct omap_mmc_platform_data htc_mmc1_data = {
+	.nr_slots                       = 1,
+	.switch_slot                    = NULL,
+	.slots[0]       = {
+		.ocr_mask               = MMC_VDD_28_29 | MMC_VDD_30_31 |
+					  MMC_VDD_32_33 | MMC_VDD_33_34,
+		.name                   = "mmcblk",
+		.nomux                  = 1,
+		.wires                  = 4,
+		.switch_pin             = -1,
+	},
+};
+
+static struct omap_mmc_platform_data *htc_mmc_data[1];
+#endif
+
+
+/* Platform devices for the Herald */
 static struct platform_device *devices[] __initdata = {
 	&kp_device,
 	&lcd_device,
+	&htcpld_device,
+	&gpio_leds_device,
+	&herald_gpiokeys_device,
 };
 
 /*
@@ -278,6 +546,7 @@ static void __init htcherald_init(void)
 {
 	printk(KERN_INFO "HTC Herald init.\n");
 
+	/* Do board initialization before we register all the devices */
 	omap_gpio_init();
 
 	omap_board_config = htcherald_config;
@@ -288,6 +557,13 @@ static void __init htcherald_init(void)
 
 	htcherald_usb_enable();
 	omap_usb_init(&htcherald_usb_config);
+
+	omap_register_i2c_bus(1, 100, NULL, 0);
+
+#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
+	htc_mmc_data[0] = &htc_mmc1_data;
+	omap1_init_mmc(htc_mmc_data, 1);
+#endif
 }
 
 static void __init htcherald_init_irq(void)
-- 
1.6.0.4

