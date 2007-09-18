From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [PATCH 02/14] Update arch/arm/configs/omap_3430sdp_defconfig
Date: Tue, 18 Sep 2007 13:56:38 -0400
Message-ID: <11901382111511-git-send-email-felipe.lima@indt.org.br>
References: <1190138210438-git-send-email-felipe.lima@indt.org.br>
	<11901382113889-git-send-email-felipe.lima@indt.org.br>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11901382113889-git-send-email-felipe.lima@indt.org.br>
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

 Update arch/arm/configs/omap_3430sdp_defconfig

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---
 arch/arm/configs/omap_3430sdp_defconfig |  149 ++++++++++---------------------
 1 files changed, 48 insertions(+), 101 deletions(-)

diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
index 233cc58..f68ec4b 100644
--- a/arch/arm/configs/omap_3430sdp_defconfig
+++ b/arch/arm/configs/omap_3430sdp_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.22-rc4-omap1
-# Tue Jun 12 19:17:56 2007
+# Linux kernel version: 2.6.23-rc6-omap1
+# Tue Sep 18 11:57:06 2007
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
 CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
+# CONFIG_USER_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
@@ -80,24 +75,17 @@ CONFIG_SLAB=y
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
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
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
@@ -138,6 +126,7 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # CONFIG_ARCH_L7200 is not set
 # CONFIG_ARCH_KS8695 is not set
 # CONFIG_ARCH_NS9XXX is not set
+# CONFIG_ARCH_MXC is not set
 # CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
 # CONFIG_ARCH_RPC is not set
@@ -183,6 +172,15 @@ CONFIG_ARCH_OMAP3430=y
 # OMAP Board Type
 #
 CONFIG_MACH_OMAP_3430SDP=y
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
@@ -208,7 +206,6 @@ CONFIG_ARM_THUMB=y
 # CONFIG_ARM_XENON is not set
 # CONFIG_CPU_ICACHE_DISABLE is not set
 # CONFIG_CPU_DCACHE_DISABLE is not set
-# CONFIG_CPU_L2CACHE_DISABLE is not set
 # CONFIG_CPU_BPREDICT_DISABLE is not set
 CONFIG_HAS_TLS_REG=y
 # CONFIG_OUTER_CACHE is not set
@@ -216,6 +213,7 @@ CONFIG_HAS_TLS_REG=y
 #
 # Bus support
 #
+# CONFIG_PCI_SYSCALL is not set
 # CONFIG_ARCH_SUPPORTS_MSI is not set
 
 #
@@ -244,6 +242,8 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
 # CONFIG_LEDS is not set
 CONFIG_ALIGNMENT_TRAP=y
 
@@ -286,6 +286,7 @@ CONFIG_BINFMT_MISC=y
 # Power management options
 #
 # CONFIG_PM is not set
+CONFIG_SUSPEND_UP_POSSIBLE=y
 
 #
 # Networking
@@ -372,6 +373,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
 # CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -386,10 +388,6 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
 # CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
@@ -463,27 +461,14 @@ CONFIG_MTD_OMAP_NOR=y
 CONFIG_MTD_ONENAND=y
 CONFIG_MTD_ONENAND_VERIFY_WRITE=y
 # CONFIG_MTD_ONENAND_GENERIC is not set
-# CONFIG_MTD_ONENAND_OMAP2 is not set
 # CONFIG_MTD_ONENAND_OTP is not set
 
 #
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
@@ -500,29 +485,21 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
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
@@ -540,10 +517,6 @@ CONFIG_NETDEV_10000=y
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
-
-#
-# ISDN subsystem
-#
 # CONFIG_ISDN is not set
 
 #
@@ -551,6 +524,7 @@ CONFIG_NETDEV_10000=y
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
 
 #
 # Userland interfaces
@@ -613,10 +587,6 @@ CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 # CONFIG_LEGACY_PTYS is not set
-
-#
-# IPMI
-#
 # CONFIG_IPMI_HANDLER is not set
 CONFIG_WATCHDOG=y
 CONFIG_WATCHDOG_NOWAYOUT=y
@@ -629,10 +599,6 @@ CONFIG_HW_RANDOM=y
 # CONFIG_NVRAM is not set
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
-
-#
-# TPM devices
-#
 # CONFIG_TCG_TPM is not set
 # CONFIG_I2C is not set
 
@@ -641,37 +607,18 @@ CONFIG_HW_RANDOM=y
 #
 # CONFIG_SPI is not set
 # CONFIG_SPI_MASTER is not set
-
-#
-# Dallas's 1-wire bus
-#
 # CONFIG_W1 is not set
 # CONFIG_HWMON is not set
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
@@ -688,6 +635,7 @@ CONFIG_DAB=y
 #
 # CONFIG_DISPLAY_SUPPORT is not set
 # CONFIG_VGASTATE is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=m
 # CONFIG_FB is not set
 
 #
@@ -700,16 +648,10 @@ CONFIG_DUMMY_CONSOLE=y
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
@@ -735,17 +677,27 @@ CONFIG_MMC=y
 # MMC/SD Card Drivers
 #
 CONFIG_MMC_BLOCK=y
+CONFIG_MMC_BLOCK_BOUNCE=y
 
 #
 # MMC/SD Host Controller Drivers
 #
 CONFIG_MMC_OMAP=y
+CONFIG_RTC_LIB=y
+# CONFIG_RTC_CLASS is not set
 
 #
-# Real Time Clock
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
 #
-CONFIG_RTC_LIB=y
-# CONFIG_RTC_CLASS is not set
 
 #
 # CBUS support
@@ -862,7 +814,6 @@ CONFIG_RPCSEC_GSS_KRB5=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -952,6 +903,7 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
 CONFIG_DETECT_SOFTLOCKUP=y
+CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
@@ -961,6 +913,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_LOCK_ALLOC is not set
 # CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
@@ -982,10 +935,6 @@ CONFIG_DEBUG_LL=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_ALGAPI=y
 CONFIG_CRYPTO_BLKCIPHER=y
@@ -1023,10 +972,7 @@ CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_TEST is not set
-
-#
-# Hardware crypto devices
-#
+CONFIG_CRYPTO_HW=y
 
 #
 # Library routines
@@ -1036,6 +982,7 @@ CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
 CONFIG_LIBCRC32C=y
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y
-- 
1.5.3.1.91.gd3392
