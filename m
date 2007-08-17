From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [11/17 PATCH] MMC: OMAP: Enabling MMC/SD card support option on
 n800_defconfig to use MMC multislot support.
Date: Fri, 17 Aug 2007 15:02:12 -0400
Message-ID: <46C5F0B4.6070704@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070005060901080008070509"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------070005060901080008070509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Enables MMC/SD card support option on n800_defconfig to use MMC
multislot support.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

--------------070005060901080008070509
Content-Type: text/plain;
	name*0="0011-MMC-OMAP-Enabling-MMC-SD-card-support-on-n800_defconfig.dif";
	name*1="f"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0011-MMC-OMAP-Enabling-MMC-SD-card-support-on-n800_defconfig";
	filename*1=".diff"

Enables MMC/SD card support option on n800_defconfig to use MMC multislot support.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

Index: linux-omap/arch/arm/configs/n800_defconfig
===================================================================
--- linux-omap.orig/arch/arm/configs/n800_defconfig	2007-06-26 16:04:20.000000000 -0400
+++ linux-omap/arch/arm/configs/n800_defconfig	2007-08-17 09:29:34.000000000 -0400
@@ -1,15 +1,18 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.21-rc7-omap1
-# Mon Apr 23 08:46:31 2007
+# Linux kernel version: 2.6.23-rc2-omap1
+# Fri Aug 17 09:29:22 2007
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
 CONFIG_GENERIC_GPIO=y
 CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_MMU=y
 # CONFIG_NO_IOPORT is not set
 CONFIG_GENERIC_HARDIRQS=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 CONFIG_HARDIRQS_SW_RESEND=y
 CONFIG_GENERIC_IRQ_PROBE=y
@@ -23,27 +26,23 @@ CONFIG_VECTORS_BASE=0xffff0000
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
-# Code maturity level options
+# General setup
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
-
-#
-# General setup
-#
 CONFIG_LOCALVERSION=""
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
-# CONFIG_IPC_NS is not set
 CONFIG_SYSVIPC_SYSCTL=y
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
+# CONFIG_USER_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_BLK_DEV_INITRD=y
@@ -62,32 +61,30 @@ CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
-CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-# CONFIG_SLOB is not set
-
-#
-# Loadable module support
-#
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 # CONFIG_KMOD is not set
-
-#
-# Block layer
-#
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
 
 #
 # IO Schedulers
@@ -119,14 +116,16 @@ CONFIG_DEFAULT_IOSCHED="noop"
 # CONFIG_ARCH_NETX is not set
 # CONFIG_ARCH_H720X is not set
 # CONFIG_ARCH_IMX is not set
+# CONFIG_ARCH_IOP13XX is not set
 # CONFIG_ARCH_IOP32X is not set
 # CONFIG_ARCH_IOP33X is not set
-# CONFIG_ARCH_IOP13XX is not set
-# CONFIG_ARCH_IXP4XX is not set
-# CONFIG_ARCH_IXP2000 is not set
 # CONFIG_ARCH_IXP23XX is not set
+# CONFIG_ARCH_IXP2000 is not set
+# CONFIG_ARCH_IXP4XX is not set
 # CONFIG_ARCH_L7200 is not set
+# CONFIG_ARCH_KS8695 is not set
 # CONFIG_ARCH_NS9XXX is not set
+# CONFIG_ARCH_MXC is not set
 # CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
 # CONFIG_ARCH_RPC is not set
@@ -134,6 +133,7 @@ CONFIG_DEFAULT_IOSCHED="noop"
 # CONFIG_ARCH_S3C2410 is not set
 # CONFIG_ARCH_SHARK is not set
 # CONFIG_ARCH_LH7A40X is not set
+# CONFIG_ARCH_DAVINCI is not set
 CONFIG_ARCH_OMAP=y
 
 #
@@ -142,6 +142,7 @@ CONFIG_ARCH_OMAP=y
 CONFIG_ARCH_OMAP_OTG=y
 # CONFIG_ARCH_OMAP1 is not set
 CONFIG_ARCH_OMAP2=y
+# CONFIG_ARCH_OMAP3 is not set
 
 #
 # OMAP Feature Selections
@@ -166,7 +167,6 @@ CONFIG_OMAP_DM_TIMER=y
 CONFIG_OMAP_LL_DEBUG_UART3=y
 CONFIG_OMAP_DSP=y
 # CONFIG_OMAP_DSP_MBCMD_VERBOSE is not set
-CONFIG_OMAP_DSP_TASK_MULTIOPEN=y
 CONFIG_OMAP_DSP_FBEXPORT=y
 # CONFIG_MACH_OMAP_GENERIC is not set
 
@@ -184,9 +184,18 @@ CONFIG_MACH_NOKIA_N800=y
 CONFIG_MACH_OMAP2_TUSB6010=y
 # CONFIG_MACH_OMAP_H4 is not set
 # CONFIG_MACH_OMAP_APOLLON is not set
+# CONFIG_MACH_OMAP_APOLLON_PLUS is not set
 # CONFIG_MACH_OMAP_2430SDP is not set
 
 #
+# Boot options
+#
+
+#
+# Power management
+#
+
+#
 # Processor Type
 #
 CONFIG_CPU_32=y
@@ -194,10 +203,12 @@ CONFIG_CPU_V6=y
 # CONFIG_CPU_32v6K is not set
 CONFIG_CPU_32v6=y
 CONFIG_CPU_ABRT_EV6=y
+CONFIG_CPU_PABRT_NOIFAR=y
 CONFIG_CPU_CACHE_V6=y
 CONFIG_CPU_CACHE_VIPT=y
 CONFIG_CPU_COPY_V6=y
 CONFIG_CPU_TLB_V6=y
+CONFIG_CPU_HAS_ASID=y
 CONFIG_CPU_CP15=y
 CONFIG_CPU_CP15_MMU=y
 
@@ -207,13 +218,14 @@ CONFIG_CPU_CP15_MMU=y
 CONFIG_ARM_THUMB=y
 # CONFIG_CPU_ICACHE_DISABLE is not set
 # CONFIG_CPU_DCACHE_DISABLE is not set
-# CONFIG_CPU_DCACHE_WRITETHROUGH is not set
 # CONFIG_CPU_BPREDICT_DISABLE is not set
 # CONFIG_OUTER_CACHE is not set
 
 #
 # Bus support
 #
+# CONFIG_PCI_SYSCALL is not set
+# CONFIG_ARCH_SUPPORTS_MSI is not set
 
 #
 # PCCARD (PCMCIA/CardBus) support
@@ -223,8 +235,10 @@ CONFIG_ARM_THUMB=y
 #
 # Kernel Features
 #
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
 # CONFIG_PREEMPT is not set
-CONFIG_NO_IDLE_HZ=y
 CONFIG_HZ=128
 CONFIG_AEABI=y
 CONFIG_OABI_COMPAT=y
@@ -239,6 +253,8 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
 CONFIG_LEDS=y
 CONFIG_ALIGNMENT_TRAP=y
 
@@ -282,7 +298,8 @@ CONFIG_BINFMT_ELF=y
 CONFIG_PM=y
 # CONFIG_PM_LEGACY is not set
 # CONFIG_PM_DEBUG is not set
-# CONFIG_PM_SYSFS_DEPRECATED is not set
+CONFIG_PM_SLEEP=y
+CONFIG_SUSPEND=y
 # CONFIG_APM_EMULATION is not set
 
 #
@@ -293,7 +310,6 @@ CONFIG_NET=y
 #
 # Networking options
 #
-# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
@@ -326,10 +342,6 @@ CONFIG_INET_TCP_DIAG=y
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_TCP_MD5SIG is not set
-
-#
-# IP: Virtual Server Configuration
-#
 # CONFIG_IP_VS is not set
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
@@ -346,6 +358,7 @@ CONFIG_NETFILTER_NETLINK=y
 # CONFIG_NETFILTER_NETLINK_QUEUE is not set
 # CONFIG_NETFILTER_NETLINK_LOG is not set
 # CONFIG_NF_CONNTRACK_ENABLED is not set
+# CONFIG_NF_CONNTRACK is not set
 CONFIG_NETFILTER_XTABLES=y
 # CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
 # CONFIG_NETFILTER_XT_TARGET_MARK is not set
@@ -369,6 +382,7 @@ CONFIG_NETFILTER_XTABLES=y
 # CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
 # CONFIG_NETFILTER_XT_MATCH_STRING is not set
 # CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
+# CONFIG_NETFILTER_XT_MATCH_U32 is not set
 # CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
 
 #
@@ -392,20 +406,8 @@ CONFIG_IP_NF_TARGET_IDLETIMER=y
 # CONFIG_IP_NF_MANGLE is not set
 # CONFIG_IP_NF_RAW is not set
 # CONFIG_IP_NF_ARPTABLES is not set
-
-#
-# DCCP Configuration (EXPERIMENTAL)
-#
 # CONFIG_IP_DCCP is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
 # CONFIG_IP_SCTP is not set
-
-#
-# TIPC Configuration (EXPERIMENTAL)
-#
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
@@ -451,8 +453,17 @@ CONFIG_BT_HIDP=y
 # CONFIG_BT_HCIBRF6150 is not set
 # CONFIG_BT_HCIH4P is not set
 # CONFIG_BT_HCIVHCI is not set
-# CONFIG_IEEE80211 is not set
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
 CONFIG_WIRELESS_EXT=y
+# CONFIG_MAC80211 is not set
+# CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -467,15 +478,7 @@ CONFIG_FW_LOADER=y
 # CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
 # CONFIG_CONNECTOR is not set
-
-#
-# Memory Technology Devices (MTD)
-#
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
 # CONFIG_MTD_CONCAT is not set
@@ -514,7 +517,6 @@ CONFIG_MTD_CFI_I2=y
 # CONFIG_MTD_RAM is not set
 # CONFIG_MTD_ROM is not set
 # CONFIG_MTD_ABSENT is not set
-# CONFIG_MTD_OBSOLETE_CHIPS is not set
 
 #
 # Mapping drivers for chip access
@@ -538,15 +540,7 @@ CONFIG_MTD_CFI_I2=y
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
-
-#
-# NAND Flash Device Drivers
-#
 # CONFIG_MTD_NAND is not set
-
-#
-# OneNAND Flash Device Drivers
-#
 CONFIG_MTD_ONENAND=y
 # CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
 # CONFIG_MTD_ONENAND_GENERIC is not set
@@ -554,18 +548,11 @@ CONFIG_MTD_ONENAND_OMAP2=y
 CONFIG_MTD_ONENAND_OTP=y
 
 #
-# Parallel port support
+# UBI - Unsorted block images
 #
+# CONFIG_MTD_UBI is not set
 # CONFIG_PARPORT is not set
-
-#
-# Plug and Play support
-#
-# CONFIG_PNPACPI is not set
-
-#
-# Block devices
-#
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
@@ -583,6 +570,7 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+CONFIG_SCSI_DMA=y
 # CONFIG_SCSI_TGT is not set
 # CONFIG_SCSI_NETLINK is not set
 # CONFIG_SCSI_PROC_FS is not set
@@ -604,6 +592,7 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
 # CONFIG_SCSI_SCAN_ASYNC is not set
+CONFIG_SCSI_WAIT_SCAN=m
 
 #
 # SCSI Transports
@@ -611,85 +600,54 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
 # CONFIG_SCSI_ISCSI_ATTRS is not set
-# CONFIG_SCSI_SAS_ATTRS is not set
 # CONFIG_SCSI_SAS_LIBSAS is not set
-
-#
-# SCSI low-level drivers
-#
+CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_ISCSI_TCP is not set
 # CONFIG_SCSI_DEBUG is not set
-
-#
-# Serial ATA (prod) and Parallel ATA (experimental) drivers
-#
 # CONFIG_ATA is not set
-
-#
-# Multi-device support (RAID and LVM)
-#
 # CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
-# CONFIG_FUSION is not set
-
-#
-# IEEE 1394 (FireWire) support
-#
-
-#
-# I2O device support
-#
-
-#
-# Network device support
-#
 CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 CONFIG_TUN=y
-
-#
-# PHY device support
-#
-
-#
-# Ethernet (10 or 100Mbit)
-#
 # CONFIG_NET_ETHERNET is not set
 CONFIG_MII=y
+CONFIG_NETDEV_1000=y
+CONFIG_NETDEV_10000=y
 
 #
-# Ethernet (1000 Mbit)
+# Wireless LAN
 #
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
 
 #
-# Ethernet (10000 Mbit)
-#
-
-#
-# Token Ring devices
-#
-
-#
-# Wireless LAN (non-hamradio)
-#
-CONFIG_NET_RADIO=y
-# CONFIG_NET_WIRELESS_RTNETLINK is not set
-
-#
-# Obsolete Wireless cards support (pre-802.11)
-#
-# CONFIG_STRIP is not set
-# CONFIG_USB_ZD1201 is not set
-# CONFIG_HOSTAP is not set
-
-#
-# Wan interfaces
+# USB Network Adapters
 #
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+CONFIG_USB_RTL8150=y
+# CONFIG_USB_USBNET_MII is not set
+CONFIG_USB_USBNET=y
+CONFIG_USB_NET_CDCETHER=y
+# CONFIG_USB_NET_DM9601 is not set
+# CONFIG_USB_NET_GL620A is not set
+CONFIG_USB_NET_NET1080=y
+CONFIG_USB_NET_PLUSB=y
+# CONFIG_USB_NET_MCS7830 is not set
+CONFIG_USB_NET_RNDIS_HOST=y
+CONFIG_USB_NET_CDC_SUBSET=y
+# CONFIG_USB_ALI_M5632 is not set
+# CONFIG_USB_AN2720 is not set
+CONFIG_USB_BELKIN=y
+CONFIG_USB_ARMLINUX=y
+# CONFIG_USB_EPSON2888 is not set
+# CONFIG_USB_KC2190 is not set
+CONFIG_USB_NET_ZAURUS=y
 # CONFIG_WAN is not set
 CONFIG_PPP=y
 # CONFIG_PPP_MULTILINK is not set
@@ -700,16 +658,13 @@ CONFIG_PPP_DEFLATE=y
 CONFIG_PPP_BSDCOMP=y
 # CONFIG_PPP_MPPE is not set
 # CONFIG_PPPOE is not set
+# CONFIG_PPPOL2TP is not set
 # CONFIG_SLIP is not set
 CONFIG_SLHC=y
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
-
-#
-# ISDN subsystem
-#
 # CONFIG_ISDN is not set
 
 #
@@ -717,6 +672,7 @@ CONFIG_SLHC=y
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
 
 #
 # Userland interfaces
@@ -745,8 +701,10 @@ CONFIG_INPUT_KEYBOARD=y
 CONFIG_KEYBOARD_TSC2301=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
 CONFIG_INPUT_TOUCHSCREEN=y
 # CONFIG_TOUCHSCREEN_ADS7846 is not set
+# CONFIG_TOUCHSCREEN_FUJITSU is not set
 # CONFIG_TOUCHSCREEN_GUNZE is not set
 # CONFIG_TOUCHSCREEN_ELO is not set
 # CONFIG_TOUCHSCREEN_MTOUCH is not set
@@ -755,7 +713,10 @@ CONFIG_INPUT_TOUCHSCREEN=y
 # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
 # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
 # CONFIG_TOUCHSCREEN_UCB1400 is not set
+# CONFIG_TOUCHSCREEN_TSC2102 is not set
+# CONFIG_TOUCHSCREEN_TSC210X is not set
 CONFIG_TOUCHSCREEN_TSC2301=y
+# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
 # CONFIG_INPUT_MISC is not set
 
 #
@@ -791,15 +752,7 @@ CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 # CONFIG_LEGACY_PTYS is not set
-
-#
-# IPMI
-#
 # CONFIG_IPMI_HANDLER is not set
-
-#
-# Watchdog Cards
-#
 CONFIG_WATCHDOG=y
 CONFIG_WATCHDOG_NOWAYOUT=y
 
@@ -815,19 +768,11 @@ CONFIG_OMAP_WATCHDOG=y
 # CONFIG_USBPCWATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_NVRAM is not set
-# CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
-
-#
-# TPM devices
-#
 # CONFIG_TCG_TPM is not set
-
-#
-# I2C support
-#
 CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
 # CONFIG_I2C_CHARDEV is not set
 
 #
@@ -840,17 +785,21 @@ CONFIG_I2C=y
 #
 # I2C Hardware Bus support
 #
+# CONFIG_I2C_GPIO is not set
 # CONFIG_I2C_OCORES is not set
 CONFIG_I2C_OMAP=y
 # CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_TAOS_EVM is not set
 # CONFIG_I2C_STUB is not set
-# CONFIG_I2C_PCA_ISA is not set
+# CONFIG_I2C_TINY_USB is not set
 
 #
 # Miscellaneous I2C Chip support
 #
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
+# CONFIG_DS1682 is not set
 # CONFIG_SENSORS_EEPROM is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -859,9 +808,10 @@ CONFIG_I2C_OMAP=y
 # CONFIG_TPS65010 is not set
 # CONFIG_SENSORS_TLV320AIC23 is not set
 # CONFIG_GPIOEXPANDER_OMAP is not set
-CONFIG_MENELAUS=y
 # CONFIG_TWL4030_CORE is not set
 # CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+CONFIG_MENELAUS=y
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
@@ -886,20 +836,17 @@ CONFIG_SPI_OMAP24XX=y
 # CONFIG_SPI_AT25 is not set
 # CONFIG_SPI_TSC2101 is not set
 # CONFIG_SPI_TSC2102 is not set
+# CONFIG_SPI_TSC210X is not set
 CONFIG_SPI_TSC2301=y
 CONFIG_SPI_TSC2301_AUDIO=y
-
-#
-# Dallas's 1-wire bus
-#
+# CONFIG_SPI_SPIDEV is not set
+# CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
-
-#
-# Hardware Monitoring support
-#
 CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
 # CONFIG_SENSORS_ABITUGURU is not set
+# CONFIG_SENSORS_ABITUGURU3 is not set
+# CONFIG_SENSORS_AD7418 is not set
 # CONFIG_SENSORS_ADM1021 is not set
 # CONFIG_SENSORS_ADM1025 is not set
 # CONFIG_SENSORS_ADM1026 is not set
@@ -926,12 +873,16 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_LM87 is not set
 # CONFIG_SENSORS_LM90 is not set
 # CONFIG_SENSORS_LM92 is not set
+# CONFIG_SENSORS_LM93 is not set
 # CONFIG_SENSORS_MAX1619 is not set
+# CONFIG_SENSORS_MAX6650 is not set
 # CONFIG_SENSORS_PC87360 is not set
 # CONFIG_SENSORS_PC87427 is not set
+# CONFIG_SENSORS_DME1737 is not set
 # CONFIG_SENSORS_SMSC47M1 is not set
 # CONFIG_SENSORS_SMSC47M192 is not set
 # CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_THMC50 is not set
 # CONFIG_SENSORS_VT1211 is not set
 # CONFIG_SENSORS_W83781D is not set
 # CONFIG_SENSORS_W83791D is not set
@@ -940,20 +891,15 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_W83L785TS is not set
 # CONFIG_SENSORS_W83627HF is not set
 # CONFIG_SENSORS_W83627EHF is not set
+# CONFIG_SENSORS_TSC210X is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
-
-#
-# Misc devices
-#
+CONFIG_MISC_DEVICES=y
+# CONFIG_EEPROM_93CX6 is not set
 
 #
 # Multifunction device drivers
 #
 # CONFIG_MFD_SM501 is not set
-
-#
-# LED devices
-#
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 
@@ -963,6 +909,7 @@ CONFIG_LEDS_CLASS=y
 # CONFIG_LEDS_OMAP_DEBUG is not set
 # CONFIG_LEDS_OMAP is not set
 CONFIG_LEDS_OMAP_PWM=y
+# CONFIG_LEDS_GPIO is not set
 
 #
 # LED Triggers
@@ -978,48 +925,49 @@ CONFIG_VIDEO_DEV=y
 # CONFIG_VIDEO_V4L1 is not set
 # CONFIG_VIDEO_V4L1_COMPAT is not set
 CONFIG_VIDEO_V4L2=y
-
-#
-# Video Capture Adapters
-#
-
-#
-# Video Capture Adapters
-#
+CONFIG_VIDEO_CAPTURE_DRIVERS=y
 # CONFIG_VIDEO_ADV_DEBUG is not set
 CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
 # CONFIG_VIDEO_SAA5246A is not set
 # CONFIG_VIDEO_SAA5249 is not set
-
-#
-# V4L USB devices
-#
+# CONFIG_TUNER_TEA5761 is not set
+# CONFIG_VIDEO_OMAP_CAMERA is not set
+CONFIG_V4L_USB_DRIVERS=y
 # CONFIG_VIDEO_PVRUSB2 is not set
 # CONFIG_VIDEO_USBVISION is not set
-# CONFIG_VIDEO_OMAP_CAMERA is not set
-
-#
-# Radio Adapters
-#
+# CONFIG_USB_ET61X251 is not set
+# CONFIG_USB_SN9C102 is not set
+# CONFIG_USB_ZC0301 is not set
+# CONFIG_USB_ZR364XX is not set
+CONFIG_RADIO_ADAPTERS=y
 # CONFIG_RADIO_TEA5761 is not set
 # CONFIG_USB_DSBR is not set
-
-#
-# Digital Video Broadcasting Devices
-#
-# CONFIG_DVB is not set
+# CONFIG_DVB_CORE is not set
+CONFIG_DAB=y
 # CONFIG_USB_DABUSB is not set
 
 #
 # Graphics support
 #
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_VGASTATE is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
 # CONFIG_FIRMWARE_EDID is not set
 # CONFIG_FB_DDC is not set
 # CONFIG_FB_CFB_FILLRECT is not set
 # CONFIG_FB_CFB_COPYAREA is not set
 # CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_SYS_FOPS is not set
+CONFIG_FB_DEFERRED_IO=y
 # CONFIG_FB_SVGALIB is not set
 # CONFIG_FB_MACMODES is not set
 # CONFIG_FB_BACKLIGHT is not set
@@ -1027,7 +975,7 @@ CONFIG_FB=y
 # CONFIG_FB_TILEBLITTING is not set
 
 #
-# Frambuffer hardware drivers
+# Frame buffer hardware drivers
 #
 # CONFIG_FB_S1D13XXX is not set
 CONFIG_FB_OMAP=y
@@ -1046,10 +994,6 @@ CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=4
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
 # CONFIG_FRAMEBUFFER_CONSOLE is not set
-
-#
-# Logo configuration
-#
 # CONFIG_LOGO is not set
 
 #
@@ -1092,26 +1036,33 @@ CONFIG_SND_OMAP24XX_EAC=y
 # USB devices
 #
 # CONFIG_SND_USB_AUDIO is not set
+# CONFIG_SND_USB_CAIAQ is not set
 
 #
-# SoC audio support
+# System on Chip audio support
 #
 # CONFIG_SND_SOC is not set
 
 #
-# Open Sound System
+# SoC Audio support for SuperH
 #
-# CONFIG_SOUND_PRIME is not set
 
 #
-# HID Devices
+# Open Sound System
 #
+# CONFIG_SOUND_PRIME is not set
+CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
 
 #
-# USB support
+# USB Input Devices
 #
+CONFIG_USB_HID=y
+# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_HID_FF is not set
+# CONFIG_USB_HIDDEV is not set
+CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 # CONFIG_USB_ARCH_HAS_EHCI is not set
@@ -1122,8 +1073,10 @@ CONFIG_USB_DEBUG=y
 # Miscellaneous USB options
 #
 CONFIG_USB_DEVICEFS=y
+CONFIG_USB_DEVICE_CLASS=y
 CONFIG_USB_DYNAMIC_MINORS=y
 CONFIG_USB_SUSPEND=y
+# CONFIG_USB_PERSIST is not set
 CONFIG_USB_OTG=y
 CONFIG_USB_OTG_WHITELIST=y
 # CONFIG_USB_OTG_BLACKLIST_HUB is not set
@@ -1134,6 +1087,7 @@ CONFIG_USB_OTG_WHITELIST=y
 # CONFIG_USB_ISP116X_HCD is not set
 # CONFIG_USB_OHCI_HCD is not set
 # CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
 CONFIG_USB_MUSB_HDRC=y
 CONFIG_USB_TUSB6010=y
 # CONFIG_USB_MUSB_HOST is not set
@@ -1174,56 +1128,10 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_LIBUSUAL=y
 
 #
-# USB Input Devices
-#
-CONFIG_USB_HID=y
-# CONFIG_USB_HIDINPUT_POWERBOOK is not set
-# CONFIG_HID_FF is not set
-# CONFIG_USB_HIDDEV is not set
-# CONFIG_USB_AIPTEK is not set
-# CONFIG_USB_WACOM is not set
-# CONFIG_USB_ACECAD is not set
-# CONFIG_USB_KBTAB is not set
-# CONFIG_USB_POWERMATE is not set
-# CONFIG_USB_TOUCHSCREEN is not set
-# CONFIG_USB_YEALINK is not set
-# CONFIG_USB_XPAD is not set
-# CONFIG_USB_ATI_REMOTE is not set
-# CONFIG_USB_ATI_REMOTE2 is not set
-# CONFIG_USB_KEYSPAN_REMOTE is not set
-# CONFIG_USB_APPLETOUCH is not set
-# CONFIG_USB_GTCO is not set
-
-#
 # USB Imaging devices
 #
 # CONFIG_USB_MDC800 is not set
 # CONFIG_USB_MICROTEK is not set
-
-#
-# USB Network Adapters
-#
-# CONFIG_USB_CATC is not set
-# CONFIG_USB_KAWETH is not set
-# CONFIG_USB_PEGASUS is not set
-CONFIG_USB_RTL8150=y
-# CONFIG_USB_USBNET_MII is not set
-CONFIG_USB_USBNET=y
-CONFIG_USB_NET_CDCETHER=y
-# CONFIG_USB_NET_DM9601 is not set
-# CONFIG_USB_NET_GL620A is not set
-CONFIG_USB_NET_NET1080=y
-CONFIG_USB_NET_PLUSB=y
-# CONFIG_USB_NET_MCS7830 is not set
-CONFIG_USB_NET_RNDIS_HOST=y
-CONFIG_USB_NET_CDC_SUBSET=y
-# CONFIG_USB_ALI_M5632 is not set
-# CONFIG_USB_AN2720 is not set
-CONFIG_USB_BELKIN=y
-CONFIG_USB_ARMLINUX=y
-# CONFIG_USB_EPSON2888 is not set
-# CONFIG_USB_KC2190 is not set
-CONFIG_USB_NET_ZAURUS=y
 CONFIG_USB_MON=y
 
 #
@@ -1266,13 +1174,18 @@ CONFIG_USB_MON=y
 # USB Gadget Support
 #
 CONFIG_USB_GADGET=y
+# CONFIG_USB_GADGET_DEBUG is not set
 CONFIG_USB_GADGET_DEBUG_FILES=y
 CONFIG_USB_GADGET_SELECTED=y
+# CONFIG_USB_GADGET_AMD5536UDC is not set
+# CONFIG_USB_GADGET_FSL_USB2 is not set
 # CONFIG_USB_GADGET_NET2280 is not set
 # CONFIG_USB_GADGET_PXA2XX is not set
+# CONFIG_USB_GADGET_M66592 is not set
 # CONFIG_USB_GADGET_GOKU is not set
 # CONFIG_USB_GADGET_LH7A40X is not set
 # CONFIG_USB_GADGET_OMAP is not set
+# CONFIG_USB_GADGET_S3C2410 is not set
 # CONFIG_USB_GADGET_AT91 is not set
 # CONFIG_USB_GADGET_DUMMY_HCD is not set
 CONFIG_USB_GADGET_DUALSPEED=y
@@ -1283,19 +1196,37 @@ CONFIG_USB_ETH_RNDIS=y
 # CONFIG_USB_FILE_STORAGE is not set
 # CONFIG_USB_G_SERIAL is not set
 # CONFIG_USB_MIDI_GADGET is not set
+CONFIG_MMC=y
+# CONFIG_MMC_DEBUG is not set
+# CONFIG_MMC_UNSAFE_RESUME is not set
 
 #
-# MMC/SD Card support
+# MMC/SD Card Drivers
 #
-# CONFIG_MMC is not set
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_BLOCK_BOUNCE=y
 
 #
-# Real Time Clock
+# MMC/SD Host Controller Drivers
 #
+CONFIG_MMC_OMAP=y
 CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
 
 #
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
 # CBUS support
 #
 CONFIG_CBUS=y
@@ -1408,7 +1339,6 @@ CONFIG_JFFS2_CMODE_PRIORITY=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -1481,8 +1411,8 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
-CONFIG_LOG_BUF_SHIFT=14
 CONFIG_DETECT_SOFTLOCKUP=y
+CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
@@ -1490,6 +1420,9 @@ CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
@@ -1514,10 +1447,6 @@ CONFIG_SECURITY=y
 # CONFIG_SECURITY_CAPABILITIES is not set
 # CONFIG_SECURITY_ROOTPLUG is not set
 # CONFIG_SECURITY_LOWMEM is not set
-
-#
-# Cryptographic options
-#
 # CONFIG_CRYPTO is not set
 
 #
@@ -1526,10 +1455,13 @@ CONFIG_SECURITY=y
 CONFIG_BITREVERSE=y
 CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y

--------------070005060901080008070509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070005060901080008070509--
