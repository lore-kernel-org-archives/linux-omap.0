From: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Subject: [PATCH] OMAP: Update n800_defconfig
Date: Fri, 23 Nov 2007 02:38:38 +0200
Message-ID: <1195778318-12008-4-git-send-email-lauri.leukkunen@nokia.com>
References: <1195778318-12008-1-git-send-email-lauri.leukkunen@nokia.com>
	<1195778318-12008-2-git-send-email-lauri.leukkunen@nokia.com>
	<1195778318-12008-3-git-send-email-lauri.leukkunen@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1195778318-12008-3-git-send-email-lauri.leukkunen@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap@vger.kernel.org
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Enable N810 and lzo support for jffs2.

Signed-off-by: Lauri Leukkunen <lauri.leukkunen@nokia.com>
---
 arch/arm/configs/n800_defconfig |  662 ++++++++++++---------------------------
 1 files changed, 196 insertions(+), 466 deletions(-)

diff --git a/arch/arm/configs/n800_defconfig b/arch/arm/configs/n800_defconfig
index 87f6c96..d486cf9 100644
--- a/arch/arm/configs/n800_defconfig
+++ b/arch/arm/configs/n800_defconfig
@@ -1,15 +1,18 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.21-rc7-omap1
-# Mon Apr 23 08:46:31 2007
+# Linux kernel version: 2.6.24-rc3-omap1
+# Fri Nov 23 01:39:09 2007
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
@@ -23,27 +26,28 @@ CONFIG_VECTORS_BASE=0xffff0000
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
+# CONFIG_PID_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
+CONFIG_FAIR_GROUP_SCHED=y
+CONFIG_FAIR_USER_SCHED=y
+# CONFIG_FAIR_CGROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_BLK_DEV_INITRD=y
@@ -62,32 +66,29 @@ CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
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
@@ -119,14 +120,16 @@ CONFIG_DEFAULT_IOSCHED="noop"
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
@@ -134,6 +137,7 @@ CONFIG_DEFAULT_IOSCHED="noop"
 # CONFIG_ARCH_S3C2410 is not set
 # CONFIG_ARCH_SHARK is not set
 # CONFIG_ARCH_LH7A40X is not set
+# CONFIG_ARCH_DAVINCI is not set
 CONFIG_ARCH_OMAP=y
 
 #
@@ -142,10 +146,12 @@ CONFIG_ARCH_OMAP=y
 CONFIG_ARCH_OMAP_OTG=y
 # CONFIG_ARCH_OMAP1 is not set
 CONFIG_ARCH_OMAP2=y
+# CONFIG_ARCH_OMAP3 is not set
 
 #
 # OMAP Feature Selections
 #
+CONFIG_OMAP_DEBUG_SRAM_PATCH=y
 CONFIG_OMAP_RESET_CLOCKS=y
 CONFIG_OMAP_BOOT_TAG=y
 CONFIG_OMAP_BOOT_REASON=y
@@ -166,7 +172,6 @@ CONFIG_OMAP_DM_TIMER=y
 CONFIG_OMAP_LL_DEBUG_UART3=y
 CONFIG_OMAP_DSP=y
 # CONFIG_OMAP_DSP_MBCMD_VERBOSE is not set
-CONFIG_OMAP_DSP_TASK_MULTIOPEN=y
 CONFIG_OMAP_DSP_FBEXPORT=y
 # CONFIG_MACH_OMAP_GENERIC is not set
 
@@ -181,10 +186,20 @@ CONFIG_ARCH_OMAP2420=y
 # OMAP Board Type
 #
 CONFIG_MACH_NOKIA_N800=y
+CONFIG_MACH_NOKIA_N810=y
 CONFIG_MACH_OMAP2_TUSB6010=y
 # CONFIG_MACH_OMAP_H4 is not set
 # CONFIG_MACH_OMAP_APOLLON is not set
-# CONFIG_MACH_OMAP_2430SDP is not set
+# CONFIG_MACH_OMAP_APOLLON_PLUS is not set
+# CONFIG_MACH_OMAP_2430OSK is not set
+
+#
+# Boot options
+#
+
+#
+# Power management
+#
 
 #
 # Processor Type
@@ -194,10 +209,12 @@ CONFIG_CPU_V6=y
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
 
@@ -207,24 +224,24 @@ CONFIG_CPU_CP15_MMU=y
 CONFIG_ARM_THUMB=y
 # CONFIG_CPU_ICACHE_DISABLE is not set
 # CONFIG_CPU_DCACHE_DISABLE is not set
-# CONFIG_CPU_DCACHE_WRITETHROUGH is not set
 # CONFIG_CPU_BPREDICT_DISABLE is not set
 # CONFIG_OUTER_CACHE is not set
 
 #
 # Bus support
 #
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
+# CONFIG_PCI_SYSCALL is not set
+# CONFIG_ARCH_SUPPORTS_MSI is not set
 # CONFIG_PCCARD is not set
 
 #
 # Kernel Features
 #
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 # CONFIG_PREEMPT is not set
-CONFIG_NO_IDLE_HZ=y
 CONFIG_HZ=128
 CONFIG_AEABI=y
 CONFIG_OABI_COMPAT=y
@@ -236,9 +253,12 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
 CONFIG_LEDS=y
 CONFIG_ALIGNMENT_TRAP=y
 
@@ -282,7 +302,9 @@ CONFIG_BINFMT_ELF=y
 CONFIG_PM=y
 # CONFIG_PM_LEGACY is not set
 # CONFIG_PM_DEBUG is not set
-# CONFIG_PM_SYSFS_DEPRECATED is not set
+CONFIG_PM_SLEEP=y
+CONFIG_SUSPEND_UP_POSSIBLE=y
+CONFIG_SUSPEND=y
 # CONFIG_APM_EMULATION is not set
 
 #
@@ -293,7 +315,6 @@ CONFIG_NET=y
 #
 # Networking options
 #
-# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
@@ -320,16 +341,13 @@ CONFIG_IP_FIB_HASH=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 CONFIG_INET_XFRM_MODE_BEET=y
+# CONFIG_INET_LRO is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
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
@@ -346,6 +364,7 @@ CONFIG_NETFILTER_NETLINK=y
 # CONFIG_NETFILTER_NETLINK_QUEUE is not set
 # CONFIG_NETFILTER_NETLINK_LOG is not set
 # CONFIG_NF_CONNTRACK_ENABLED is not set
+# CONFIG_NF_CONNTRACK is not set
 CONFIG_NETFILTER_XTABLES=y
 # CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
 # CONFIG_NETFILTER_XT_TARGET_MARK is not set
@@ -369,6 +388,8 @@ CONFIG_NETFILTER_XTABLES=y
 # CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
 # CONFIG_NETFILTER_XT_MATCH_STRING is not set
 # CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
+# CONFIG_NETFILTER_XT_MATCH_TIME is not set
+# CONFIG_NETFILTER_XT_MATCH_U32 is not set
 # CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
 
 #
@@ -392,20 +413,8 @@ CONFIG_IP_NF_TARGET_IDLETIMER=y
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
@@ -418,10 +427,6 @@ CONFIG_IP_NF_TARGET_IDLETIMER=y
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
 # CONFIG_NET_SCHED is not set
 
 #
@@ -443,16 +448,21 @@ CONFIG_BT_HIDP=y
 #
 # Bluetooth device drivers
 #
-# CONFIG_BT_HCIUSB is not set
 # CONFIG_BT_HCIUART is not set
-# CONFIG_BT_HCIBCM203X is not set
-# CONFIG_BT_HCIBPA10X is not set
-# CONFIG_BT_HCIBFUSB is not set
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
@@ -461,21 +471,14 @@ CONFIG_WIRELESS_EXT=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
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
@@ -495,6 +498,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
 
 #
 # RAM/ROM/Flash chip drivers
@@ -514,7 +518,6 @@ CONFIG_MTD_CFI_I2=y
 # CONFIG_MTD_RAM is not set
 # CONFIG_MTD_ROM is not set
 # CONFIG_MTD_ABSENT is not set
-# CONFIG_MTD_OBSOLETE_CHIPS is not set
 
 #
 # Mapping drivers for chip access
@@ -538,51 +541,40 @@ CONFIG_MTD_CFI_I2=y
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
 CONFIG_MTD_ONENAND_OMAP2=y
 CONFIG_MTD_ONENAND_OTP=y
+# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
+# CONFIG_MTD_ONENAND_SIM is not set
 
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
 # CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_UB is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
+CONFIG_MISC_DEVICES=y
+# CONFIG_EEPROM_93CX6 is not set
 
 #
 # SCSI device support
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+CONFIG_SCSI_DMA=y
 # CONFIG_SCSI_TGT is not set
 # CONFIG_SCSI_NETLINK is not set
 # CONFIG_SCSI_PROC_FS is not set
@@ -604,6 +596,7 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
 # CONFIG_SCSI_SCAN_ASYNC is not set
+CONFIG_SCSI_WAIT_SCAN=m
 
 #
 # SCSI Transports
@@ -611,85 +604,30 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_SPI_ATTRS is not set
 # CONFIG_SCSI_FC_ATTRS is not set
 # CONFIG_SCSI_ISCSI_ATTRS is not set
-# CONFIG_SCSI_SAS_ATTRS is not set
 # CONFIG_SCSI_SAS_LIBSAS is not set
-
-#
-# SCSI low-level drivers
-#
+# CONFIG_SCSI_SRP_ATTRS is not set
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
+# CONFIG_VETH is not set
 # CONFIG_NET_ETHERNET is not set
-CONFIG_MII=y
-
-#
-# Ethernet (1000 Mbit)
-#
-
-#
-# Ethernet (10000 Mbit)
-#
+CONFIG_NETDEV_1000=y
+CONFIG_NETDEV_10000=y
 
 #
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
+# Wireless LAN
 #
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
 # CONFIG_WAN is not set
 CONFIG_PPP=y
 # CONFIG_PPP_MULTILINK is not set
@@ -700,16 +638,13 @@ CONFIG_PPP_DEFLATE=y
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
@@ -717,6 +652,7 @@ CONFIG_SLHC=y
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
 
 #
 # Userland interfaces
@@ -726,7 +662,6 @@ CONFIG_INPUT_MOUSEDEV=y
 CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
 CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_EVBUG is not set
 
@@ -741,12 +676,14 @@ CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_NEWTON is not set
 # CONFIG_KEYBOARD_STOWAWAY is not set
 # CONFIG_KEYBOARD_OMAP is not set
-# CONFIG_KEYBOARD_GPIO is not set
 CONFIG_KEYBOARD_TSC2301=y
+# CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
 CONFIG_INPUT_TOUCHSCREEN=y
 # CONFIG_TOUCHSCREEN_ADS7846 is not set
+# CONFIG_TOUCHSCREEN_FUJITSU is not set
 # CONFIG_TOUCHSCREEN_GUNZE is not set
 # CONFIG_TOUCHSCREEN_ELO is not set
 # CONFIG_TOUCHSCREEN_MTOUCH is not set
@@ -755,6 +692,8 @@ CONFIG_INPUT_TOUCHSCREEN=y
 # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
 # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
 # CONFIG_TOUCHSCREEN_UCB1400 is not set
+# CONFIG_TOUCHSCREEN_TSC2102 is not set
+# CONFIG_TOUCHSCREEN_TSC210X is not set
 CONFIG_TOUCHSCREEN_TSC2301=y
 # CONFIG_INPUT_MISC is not set
 
@@ -773,7 +712,13 @@ CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
 # CONFIG_VT_HW_CONSOLE_BINDING is not set
-# CONFIG_SERIAL_NONSTANDARD is not set
+CONFIG_SERIAL_NONSTANDARD=y
+# CONFIG_MOXA_SMARTIO is not set
+# CONFIG_N_HDLC is not set
+# CONFIG_RISCOM8 is not set
+# CONFIG_SPECIALIX is not set
+# CONFIG_RIO is not set
+# CONFIG_STALDRV is not set
 
 #
 # Serial drivers
@@ -791,43 +736,14 @@ CONFIG_SERIAL_CORE=y
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
-CONFIG_WATCHDOG=y
-CONFIG_WATCHDOG_NOWAYOUT=y
-
-#
-# Watchdog Device Drivers
-#
-# CONFIG_SOFT_WATCHDOG is not set
-CONFIG_OMAP_WATCHDOG=y
-
-#
-# USB-based Watchdog Cards
-#
-# CONFIG_USBPCWATCHDOG is not set
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
@@ -840,17 +756,20 @@ CONFIG_I2C=y
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
 
 #
 # Miscellaneous I2C Chip support
 #
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
+# CONFIG_DS1682 is not set
 # CONFIG_SENSORS_EEPROM is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -859,9 +778,10 @@ CONFIG_I2C_OMAP=y
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
@@ -886,32 +806,28 @@ CONFIG_SPI_OMAP24XX=y
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
+# CONFIG_POWER_SUPPLY is not set
 CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
-# CONFIG_SENSORS_ABITUGURU is not set
+# CONFIG_SENSORS_AD7418 is not set
 # CONFIG_SENSORS_ADM1021 is not set
 # CONFIG_SENSORS_ADM1025 is not set
 # CONFIG_SENSORS_ADM1026 is not set
 # CONFIG_SENSORS_ADM1029 is not set
 # CONFIG_SENSORS_ADM1031 is not set
 # CONFIG_SENSORS_ADM9240 is not set
-# CONFIG_SENSORS_ASB100 is not set
+# CONFIG_SENSORS_ADT7470 is not set
 # CONFIG_SENSORS_ATXP1 is not set
 # CONFIG_SENSORS_DS1621 is not set
 # CONFIG_SENSORS_F71805F is not set
-# CONFIG_SENSORS_FSCHER is not set
-# CONFIG_SENSORS_FSCPOS is not set
+# CONFIG_SENSORS_F71882FG is not set
+# CONFIG_SENSORS_F75375S is not set
 # CONFIG_SENSORS_GL518SM is not set
 # CONFIG_SENSORS_GL520SM is not set
 # CONFIG_SENSORS_IT87 is not set
@@ -926,12 +842,16 @@ CONFIG_HWMON=y
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
@@ -940,36 +860,27 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_W83L785TS is not set
 # CONFIG_SENSORS_W83627HF is not set
 # CONFIG_SENSORS_W83627EHF is not set
+# CONFIG_SENSORS_TSC210X is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
+CONFIG_WATCHDOG=y
+CONFIG_WATCHDOG_NOWAYOUT=y
 
 #
-# Misc devices
-#
-
-#
-# Multifunction device drivers
-#
-# CONFIG_MFD_SM501 is not set
-
-#
-# LED devices
+# Watchdog Device Drivers
 #
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=y
+# CONFIG_SOFT_WATCHDOG is not set
+CONFIG_OMAP_WATCHDOG=y
 
 #
-# LED drivers
+# Sonics Silicon Backplane
 #
-# CONFIG_LEDS_OMAP_DEBUG is not set
-# CONFIG_LEDS_OMAP is not set
-CONFIG_LEDS_OMAP_PWM=y
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
 
 #
-# LED Triggers
+# Multifunction device drivers
 #
-CONFIG_LEDS_TRIGGERS=y
-CONFIG_LEDS_TRIGGER_TIMER=y
-CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+# CONFIG_MFD_SM501 is not set
 
 #
 # Multimedia devices
@@ -978,48 +889,36 @@ CONFIG_VIDEO_DEV=y
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
+# CONFIG_VIDEO_VIVI is not set
 # CONFIG_VIDEO_SAA5246A is not set
 # CONFIG_VIDEO_SAA5249 is not set
-
-#
-# V4L USB devices
-#
-# CONFIG_VIDEO_PVRUSB2 is not set
-# CONFIG_VIDEO_USBVISION is not set
 # CONFIG_VIDEO_OMAP_CAMERA is not set
-
-#
-# Radio Adapters
-#
+# CONFIG_VIDEO_OMAP2 is not set
+CONFIG_RADIO_ADAPTERS=y
 # CONFIG_RADIO_TEA5761 is not set
-# CONFIG_USB_DSBR is not set
-
-#
-# Digital Video Broadcasting Devices
-#
-# CONFIG_DVB is not set
-# CONFIG_USB_DABUSB is not set
+# CONFIG_DVB_CORE is not set
+CONFIG_DAB=y
 
 #
 # Graphics support
 #
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
 CONFIG_FB=y
 # CONFIG_FIRMWARE_EDID is not set
 # CONFIG_FB_DDC is not set
-# CONFIG_FB_CFB_FILLRECT is not set
-# CONFIG_FB_CFB_COPYAREA is not set
-# CONFIG_FB_CFB_IMAGEBLIT is not set
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_SYS_FOPS is not set
+CONFIG_FB_DEFERRED_IO=y
 # CONFIG_FB_SVGALIB is not set
 # CONFIG_FB_MACMODES is not set
 # CONFIG_FB_BACKLIGHT is not set
@@ -1027,9 +926,10 @@ CONFIG_FB=y
 # CONFIG_FB_TILEBLITTING is not set
 
 #
-# Frambuffer hardware drivers
+# Frame buffer hardware drivers
 #
 # CONFIG_FB_S1D13XXX is not set
+# CONFIG_FB_VIRTUAL is not set
 CONFIG_FB_OMAP=y
 CONFIG_FB_OMAP_LCDC_EXTERNAL=y
 # CONFIG_FB_OMAP_LCDC_HWA742 is not set
@@ -1038,7 +938,12 @@ CONFIG_FB_OMAP_MANUAL_UPDATE=y
 CONFIG_FB_OMAP_LCD_MIPID=y
 CONFIG_FB_OMAP_BOOTLOADER_INIT=y
 CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=4
-# CONFIG_FB_VIRTUAL is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
 
 #
 # Console display driver support
@@ -1046,10 +951,6 @@ CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=4
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
 # CONFIG_FRAMEBUFFER_CONSOLE is not set
-
-#
-# Logo configuration
-#
 # CONFIG_LOGO is not set
 
 #
@@ -1089,209 +990,45 @@ CONFIG_SND_SUPPORT_OLD_API=y
 CONFIG_SND_OMAP24XX_EAC=y
 
 #
-# USB devices
+# SPI devices
 #
-# CONFIG_SND_USB_AUDIO is not set
 
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
+# CONFIG_HIDRAW is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_MMC is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
 
 #
-# USB support
-#
-CONFIG_USB_ARCH_HAS_HCD=y
-CONFIG_USB_ARCH_HAS_OHCI=y
-# CONFIG_USB_ARCH_HAS_EHCI is not set
-CONFIG_USB=y
-CONFIG_USB_DEBUG=y
-
-#
-# Miscellaneous USB options
-#
-CONFIG_USB_DEVICEFS=y
-CONFIG_USB_DYNAMIC_MINORS=y
-CONFIG_USB_SUSPEND=y
-CONFIG_USB_OTG=y
-CONFIG_USB_OTG_WHITELIST=y
-# CONFIG_USB_OTG_BLACKLIST_HUB is not set
-
-#
-# USB Host Controller Drivers
-#
-# CONFIG_USB_ISP116X_HCD is not set
-# CONFIG_USB_OHCI_HCD is not set
-# CONFIG_USB_SL811_HCD is not set
-CONFIG_USB_MUSB_HDRC=y
-CONFIG_USB_TUSB6010=y
-# CONFIG_USB_MUSB_HOST is not set
-# CONFIG_USB_MUSB_PERIPHERAL is not set
-CONFIG_USB_MUSB_OTG=y
-CONFIG_USB_GADGET_MUSB_HDRC=y
-CONFIG_USB_MUSB_HDRC_HCD=y
-# CONFIG_USB_INVENTRA_FIFO is not set
-# CONFIG_USB_INVENTRA_DMA is not set
-# CONFIG_USB_TI_CPPI_DMA is not set
-CONFIG_USB_TUSB_OMAP_DMA=y
-CONFIG_USB_INVENTRA_HCD_LOGGING=1
-
-#
-# USB Device Class drivers
-#
-# CONFIG_USB_ACM is not set
-# CONFIG_USB_PRINTER is not set
-
-#
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
-#
-
-#
-# may also be needed; see USB_STORAGE Help for more information
-#
-CONFIG_USB_STORAGE=y
-# CONFIG_USB_STORAGE_DEBUG is not set
-# CONFIG_USB_STORAGE_DATAFAB is not set
-# CONFIG_USB_STORAGE_FREECOM is not set
-# CONFIG_USB_STORAGE_DPCM is not set
-# CONFIG_USB_STORAGE_USBAT is not set
-# CONFIG_USB_STORAGE_SDDR09 is not set
-# CONFIG_USB_STORAGE_SDDR55 is not set
-# CONFIG_USB_STORAGE_JUMPSHOT is not set
-# CONFIG_USB_STORAGE_ALAUDA is not set
-# CONFIG_USB_STORAGE_KARMA is not set
-CONFIG_USB_LIBUSUAL=y
-
-#
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
-# USB Imaging devices
-#
-# CONFIG_USB_MDC800 is not set
-# CONFIG_USB_MICROTEK is not set
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
-CONFIG_USB_MON=y
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
-# CONFIG_USB_ADUTUX is not set
-# CONFIG_USB_AUERSWALD is not set
-# CONFIG_USB_RIO500 is not set
-# CONFIG_USB_LEGOTOWER is not set
-# CONFIG_USB_LCD is not set
-# CONFIG_USB_BERRY_CHARGE is not set
-# CONFIG_USB_LED is not set
-# CONFIG_USB_CYPRESS_CY7C63 is not set
-# CONFIG_USB_CYTHERM is not set
-# CONFIG_USB_PHIDGET is not set
-# CONFIG_USB_IDMOUSE is not set
-# CONFIG_USB_FTDI_ELAN is not set
-# CONFIG_USB_APPLEDISPLAY is not set
-# CONFIG_USB_LD is not set
-# CONFIG_USB_TRANCEVIBRATOR is not set
-# CONFIG_USB_IOWARRIOR is not set
-# CONFIG_USB_TEST is not set
-
-#
-# USB DSL modem support
-#
-
-#
-# USB Gadget Support
-#
-CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_DEBUG_FILES=y
-CONFIG_USB_GADGET_SELECTED=y
-# CONFIG_USB_GADGET_NET2280 is not set
-# CONFIG_USB_GADGET_PXA2XX is not set
-# CONFIG_USB_GADGET_GOKU is not set
-# CONFIG_USB_GADGET_LH7A40X is not set
-# CONFIG_USB_GADGET_OMAP is not set
-# CONFIG_USB_GADGET_AT91 is not set
-# CONFIG_USB_GADGET_DUMMY_HCD is not set
-CONFIG_USB_GADGET_DUALSPEED=y
-# CONFIG_USB_ZERO is not set
-CONFIG_USB_ETH=y
-CONFIG_USB_ETH_RNDIS=y
-# CONFIG_USB_GADGETFS is not set
-# CONFIG_USB_FILE_STORAGE is not set
-# CONFIG_USB_G_SERIAL is not set
-# CONFIG_USB_MIDI_GADGET is not set
-
-#
-# MMC/SD Card support
+# LED drivers
 #
-# CONFIG_MMC is not set
+# CONFIG_LEDS_OMAP_DEBUG is not set
+# CONFIG_LEDS_OMAP is not set
+CONFIG_LEDS_OMAP_PWM=y
+# CONFIG_LEDS_GPIO is not set
 
 #
-# Real Time Clock
+# LED Triggers
 #
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
 
@@ -1301,7 +1038,6 @@ CONFIG_RTC_LIB=y
 CONFIG_CBUS=y
 CONFIG_CBUS_TAHVO=y
 CONFIG_CBUS_TAHVO_USER=y
-# CONFIG_CBUS_TAHVO_USB is not set
 CONFIG_CBUS_RETU=y
 CONFIG_CBUS_RETU_USER=y
 CONFIG_CBUS_RETU_POWERBUTTON=y
@@ -1323,7 +1059,6 @@ CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_SECURITY is not set
 # CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=m
-# CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=m
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
@@ -1366,7 +1101,6 @@ CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 # CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
 
 #
@@ -1382,25 +1116,25 @@ CONFIG_RAMFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_FS_DEBUG=0
 CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
 CONFIG_JFFS2_SUMMARY=y
 # CONFIG_JFFS2_FS_XATTR is not set
 CONFIG_JFFS2_COMPRESSION_OPTIONS=y
 CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_LZO=y
 CONFIG_JFFS2_RTIME=y
 # CONFIG_JFFS2_RUBIN is not set
 # CONFIG_JFFS2_CMODE_NONE is not set
 CONFIG_JFFS2_CMODE_PRIORITY=y
 # CONFIG_JFFS2_CMODE_SIZE is not set
+# CONFIG_JFFS2_CMODE_FAVOURLZO is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
+CONFIG_NETWORK_FILESYSTEMS=y
 # CONFIG_NFS_FS is not set
 # CONFIG_NFSD is not set
 # CONFIG_SMB_FS is not set
@@ -1408,17 +1142,12 @@ CONFIG_JFFS2_CMODE_PRIORITY=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
 
 #
 # Partition Types
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
-
-#
-# Native Language Support
-#
 CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
 CONFIG_NLS_CODEPAGE_437=y
@@ -1459,21 +1188,16 @@ CONFIG_NLS_ISO8859_15=y
 # CONFIG_NLS_KOI8_R is not set
 # CONFIG_NLS_KOI8_U is not set
 CONFIG_NLS_UTF8=y
-
-#
-# Distributed Lock Manager
-#
 # CONFIG_DLM is not set
-
-#
-# Profiling support
-#
+CONFIG_INSTRUMENTATION=y
 # CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
 
 #
 # Kernel hacking
 #
 CONFIG_PRINTK_TIME=y
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
@@ -1481,8 +1205,8 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
-CONFIG_LOG_BUF_SHIFT=14
 CONFIG_DETECT_SOFTLOCKUP=y
+CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
@@ -1490,6 +1214,9 @@ CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
@@ -1497,10 +1224,13 @@ CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
 CONFIG_FRAME_POINTER=y
 CONFIG_FORCED_INLINING=y
+# CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_FAULT_INJECTION is not set
+# CONFIG_SAMPLES is not set
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_ERRORS=y
 # CONFIG_DEBUG_LL is not set
@@ -1512,12 +1242,7 @@ CONFIG_DEBUG_ERRORS=y
 CONFIG_SECURITY=y
 # CONFIG_SECURITY_NETWORK is not set
 # CONFIG_SECURITY_CAPABILITIES is not set
-# CONFIG_SECURITY_ROOTPLUG is not set
 # CONFIG_SECURITY_LOWMEM is not set
-
-#
-# Cryptographic options
-#
 # CONFIG_CRYPTO is not set
 
 #
@@ -1526,10 +1251,15 @@ CONFIG_SECURITY=y
 CONFIG_BITREVERSE=y
 CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
-- 
1.5.3.4
