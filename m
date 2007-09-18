From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [PATCH 14/14] Update arch/arm/configs/omap_perseus2_730_defconfig
Date: Tue, 18 Sep 2007 13:56:50 -0400
Message-ID: <1190138212658-git-send-email-felipe.lima@indt.org.br>
References: <1190138210438-git-send-email-felipe.lima@indt.org.br>
	<11901382113889-git-send-email-felipe.lima@indt.org.br>
	<11901382111511-git-send-email-felipe.lima@indt.org.br>
	<11901382112392-git-send-email-felipe.lima@indt.org.br>
	<11901382112428-git-send-email-felipe.lima@indt.org.br>
	<1190138211478-git-send-email-felipe.lima@indt.org.br>
	<11901382121172-git-send-email-felipe.lima@indt.org.br>
	<11901382123827-git-send-email-felipe.lima@indt.org.br>
	<11901382123346-git-send-email-felipe.lima@indt.org.br>
	<11901382123807-git-send-email-felipe.lima@indt.org.br>
	<11901382121603-git-send-email-felipe.lima@indt.org.br>
	<11901382122874-git-send-email-felipe.lima@indt.org.br>
	<1190138212298-git-send-email-felipe.lima@indt.org.br>
	<11901382123594-git-send-email-felipe.lima@indt.org.br>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11901382123594-git-send-email-felipe.lima@indt.org.br>
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

Update arch/arm/configs/omap_perseus2_730_defconfig

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---
 arch/arm/configs/omap_perseus2_730_defconfig |  157 +++++++++-----------------
 1 files changed, 55 insertions(+), 102 deletions(-)

diff --git a/arch/arm/configs/omap_perseus2_730_defconfig b/arch/arm/configs/omap_perseus2_730_defconfig
index 69c34e4..b94800c 100644
--- a/arch/arm/configs/omap_perseus2_730_defconfig
+++ b/arch/arm/configs/omap_perseus2_730_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.22-rc4-omap1
-# Sun Jun 10 14:16:35 2007
+# Linux kernel version: 2.6.23-rc6-omap1
+# Tue Sep 18 11:45:12 2007
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -26,26 +26,21 @@ CONFIG_VECTORS_BASE=0xffff0000
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
-# Code maturity level options
+# General setup
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
-
-#
-# General setup
-#
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
-# CONFIG_IPC_NS is not set
 CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
+# CONFIG_USER_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
@@ -79,24 +74,17 @@ CONFIG_SLAB=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-
-#
-# Loadable module support
-#
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
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
@@ -137,6 +125,7 @@ CONFIG_DEFAULT_IOSCHED="cfq"
 # CONFIG_ARCH_L7200 is not set
 # CONFIG_ARCH_KS8695 is not set
 # CONFIG_ARCH_NS9XXX is not set
+# CONFIG_ARCH_MXC is not set
 # CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
 # CONFIG_ARCH_RPC is not set
@@ -153,6 +142,7 @@ CONFIG_ARCH_OMAP=y
 CONFIG_ARCH_OMAP_OTG=y
 CONFIG_ARCH_OMAP1=y
 # CONFIG_ARCH_OMAP2 is not set
+# CONFIG_ARCH_OMAP3 is not set
 
 #
 # OMAP Feature Selections
@@ -171,7 +161,6 @@ CONFIG_OMAP_MPU_TIMER=y
 CONFIG_OMAP_LL_DEBUG_UART1=y
 # CONFIG_OMAP_LL_DEBUG_UART2 is not set
 # CONFIG_OMAP_LL_DEBUG_UART3 is not set
-# CONFIG_OMAP_LL_DEBUG_LCD is not set
 CONFIG_OMAP_SERIAL_WAKE=y
 
 #
@@ -197,6 +186,15 @@ CONFIG_OMAP_ARM_182MHZ=y
 # CONFIG_OMAP_ARM_120MHZ is not set
 # CONFIG_OMAP_ARM_60MHZ is not set
 # CONFIG_OMAP_ARM_30MHZ is not set
+# CONFIG_MACH_OMAP_APOLLON_PLUS is not set
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
@@ -205,6 +203,7 @@ CONFIG_CPU_32=y
 CONFIG_CPU_ARM926T=y
 CONFIG_CPU_32v5=y
 CONFIG_CPU_ABRT_EV5TJ=y
+CONFIG_CPU_PABRT_NOIFAR=y
 CONFIG_CPU_CACHE_VIVT=y
 CONFIG_CPU_COPY_V4WB=y
 CONFIG_CPU_TLB_V4WBI=y
@@ -224,6 +223,7 @@ CONFIG_CPU_CP15_MMU=y
 #
 # Bus support
 #
+# CONFIG_PCI_SYSCALL is not set
 # CONFIG_ARCH_SUPPORTS_MSI is not set
 
 #
@@ -251,6 +251,8 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_SPLIT_PTLOCK_CPUS=4096
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
 CONFIG_LEDS=y
 CONFIG_LEDS_CPU=y
 CONFIG_ALIGNMENT_TRAP=y
@@ -295,7 +297,9 @@ CONFIG_BINFMT_ELF=y
 CONFIG_PM=y
 # CONFIG_PM_LEGACY is not set
 # CONFIG_PM_DEBUG is not set
-# CONFIG_PM_SYSFS_DEPRECATED is not set
+CONFIG_PM_SLEEP=y
+CONFIG_SUSPEND_UP_POSSIBLE=y
+CONFIG_SUSPEND=y
 # CONFIG_APM_EMULATION is not set
 
 #
@@ -383,6 +387,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
 # CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -395,10 +400,6 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
 # CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
@@ -483,20 +484,8 @@ CONFIG_MTD_NAND_IDS=y
 # UBI - Unsorted block images
 #
 # CONFIG_MTD_UBI is not set
-
-#
-# Parallel port support
-#
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
@@ -513,29 +502,21 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 #
 # CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
 # CONFIG_SCSI_NETLINK is not set
 # CONFIG_ATA is not set
-
-#
-# Multi-device support (RAID and LVM)
-#
 # CONFIG_MD is not set
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
 # CONFIG_TUN is not set
 # CONFIG_PHYLIB is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
+# CONFIG_AX88796 is not set
 CONFIG_SMC91X=y
 # CONFIG_DM9000 is not set
 CONFIG_NETDEV_1000=y
@@ -553,10 +534,6 @@ CONFIG_NETDEV_10000=y
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
-
-#
-# ISDN subsystem
-#
 # CONFIG_ISDN is not set
 
 #
@@ -564,6 +541,7 @@ CONFIG_NETDEV_10000=y
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
 
 #
 # Userland interfaces
@@ -628,20 +606,12 @@ CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 # CONFIG_LEGACY_PTYS is not set
-
-#
-# IPMI
-#
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_WATCHDOG is not set
 CONFIG_HW_RANDOM=m
 # CONFIG_NVRAM is not set
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
-
-#
-# TPM devices
-#
 # CONFIG_TCG_TPM is not set
 # CONFIG_I2C is not set
 
@@ -650,46 +620,31 @@ CONFIG_HW_RANDOM=m
 #
 # CONFIG_SPI is not set
 # CONFIG_SPI_MASTER is not set
-
-#
-# Dallas's 1-wire bus
-#
 # CONFIG_W1 is not set
 CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
 # CONFIG_SENSORS_ABITUGURU is not set
+# CONFIG_SENSORS_ABITUGURU3 is not set
 # CONFIG_SENSORS_F71805F is not set
+# CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_PC87360 is not set
 # CONFIG_SENSORS_PC87427 is not set
 # CONFIG_SENSORS_SMSC47M1 is not set
 # CONFIG_SENSORS_SMSC47B397 is not set
 # CONFIG_SENSORS_VT1211 is not set
 # CONFIG_SENSORS_W83627HF is not set
+# CONFIG_SENSORS_W83627EHF is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
-
-#
-# Misc devices
-#
-# CONFIG_BLINK is not set
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
 # CONFIG_NEW_LEDS is not set
 
 #
-# LED drivers
-#
-
-#
-# LED Triggers
-#
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -706,6 +661,7 @@ CONFIG_DAB=y
 #
 # CONFIG_DISPLAY_SUPPORT is not set
 # CONFIG_VGASTATE is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
 # CONFIG_FIRMWARE_EDID is not set
 # CONFIG_FB_DDC is not set
@@ -742,16 +698,10 @@ CONFIG_DUMMY_CONSOLE=y
 # Sound
 #
 # CONFIG_SOUND is not set
-
-#
-# HID Devices
-#
+CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
-
-#
-# USB support
-#
+CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 # CONFIG_USB_ARCH_HAS_EHCI is not set
@@ -770,10 +720,6 @@ CONFIG_USB_ARCH_HAS_OHCI=y
 #
 # CONFIG_USB_GADGET is not set
 # CONFIG_MMC is not set
-
-#
-# Real Time Clock
-#
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_HCTOSYS=y
@@ -790,10 +736,6 @@ CONFIG_RTC_INTF_DEV=y
 # CONFIG_RTC_DRV_TEST is not set
 
 #
-# I2C RTC drivers
-#
-
-#
 # SPI RTC drivers
 #
 
@@ -802,8 +744,10 @@ CONFIG_RTC_INTF_DEV=y
 #
 # CONFIG_RTC_DRV_CMOS is not set
 # CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
 # CONFIG_RTC_DRV_DS1742 is not set
 # CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
 # CONFIG_RTC_DRV_V3020 is not set
 
 #
@@ -812,6 +756,19 @@ CONFIG_RTC_INTF_DEV=y
 CONFIG_RTC_DRV_OMAP=y
 
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
 # CONFIG_CBUS is not set
@@ -910,7 +867,6 @@ CONFIG_SUNRPC=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -952,10 +908,6 @@ CONFIG_FRAME_POINTER=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
 # CONFIG_CRYPTO is not set
 
 #
@@ -966,6 +918,7 @@ CONFIG_BITREVERSE=y
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y
-- 
1.5.3.1.91.gd3392
