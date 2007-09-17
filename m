From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [PATCH 02/14] ARM: OMAP: Update
	arch/arm/configs/omap_3430sdp_defconfig
Date: Mon, 17 Sep 2007 16:23:09 -0400
Message-ID: <1190060602235-git-send-email-felipe.lima@indt.org.br>
References: <11900606011267-git-send-email-felipe.lima@indt.org.br>
	<11900606021256-git-send-email-felipe.lima@indt.org.br>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11900606021256-git-send-email-felipe.lima@indt.org.br>
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

Update omap_3430sdp_defconfig

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---
 arch/arm/configs/omap_3430sdp_defconfig |  343 +++++++++++++++++++------------
 1 files changed, 209 insertions(+), 134 deletions(-)

diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
index 233cc58..b8afdc8 100644
--- a/arch/arm/configs/omap_3430sdp_defconfig
+++ b/arch/arm/configs/omap_3430sdp_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.22-rc4-omap1
-# Tue Jun 12 19:17:56 2007
+# Linux kernel version: 2.6.23-rc6-omap1
+# Mon Sep 17 15:41:32 2007
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
@@ -57,7 +52,7 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
 CONFIG_UID16=y
-# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 CONFIG_KALLSYMS_EXTRA_PASS=y
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
@@ -151,22 +140,25 @@ CONFIG_ARCH_OMAP=y
 #
 # TI OMAP Implementations
 #
+CONFIG_ARCH_OMAP_OTG=y
 # CONFIG_ARCH_OMAP1 is not set
-# CONFIG_ARCH_OMAP2 is not set
-CONFIG_ARCH_OMAP3=y
+CONFIG_ARCH_OMAP2=y
+# CONFIG_ARCH_OMAP3 is not set
 
 #
 # OMAP Feature Selections
 #
+CONFIG_OMAP_DEBUG_DEVICES=y
 # CONFIG_OMAP_RESET_CLOCKS is not set
 CONFIG_OMAP_BOOT_TAG=y
-CONFIG_OMAP_BOOT_REASON=y
+# CONFIG_OMAP_BOOT_REASON is not set
 # CONFIG_OMAP_COMPONENT_VERSION is not set
 # CONFIG_OMAP_GPIO_SWITCH is not set
 CONFIG_OMAP_MUX=y
 CONFIG_OMAP_MUX_DEBUG=y
 CONFIG_OMAP_MUX_WARNINGS=y
-# CONFIG_OMAP_MCBSP is not set
+# CONFIG_OMAP_STI is not set
+CONFIG_OMAP_MCBSP=y
 # CONFIG_OMAP_MMU_FWK is not set
 # CONFIG_OMAP_MBOX_FWK is not set
 CONFIG_OMAP_MPU_TIMER=y
@@ -176,27 +168,49 @@ CONFIG_OMAP_LL_DEBUG_UART1=y
 # CONFIG_OMAP_LL_DEBUG_UART2 is not set
 # CONFIG_OMAP_LL_DEBUG_UART3 is not set
 CONFIG_OMAP_SERIAL_WAKE=y
-CONFIG_ARCH_OMAP34XX=y
-CONFIG_ARCH_OMAP3430=y
+# CONFIG_OMAP_DSP is not set
+# CONFIG_MACH_OMAP_GENERIC is not set
+
+#
+# OMAP Core Type
+#
+CONFIG_ARCH_OMAP24XX=y
+CONFIG_ARCH_OMAP2420=y
+# CONFIG_ARCH_OMAP2430 is not set
 
 #
 # OMAP Board Type
 #
-CONFIG_MACH_OMAP_3430SDP=y
+# CONFIG_MACH_NOKIA_N800 is not set
+CONFIG_MACH_OMAP_H4=y
+# CONFIG_MACH_OMAP_H4_TUSB is not set
+# CONFIG_MACH_OMAP_H4_OTG is not set
+# CONFIG_MACH_OMAP2_H4_USB1 is not set
+# CONFIG_MACH_OMAP_APOLLON is not set
+# CONFIG_MACH_OMAP_APOLLON_PLUS is not set
+# CONFIG_MACH_OMAP_2430SDP is not set
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
 #
 CONFIG_CPU_32=y
-CONFIG_CPU_32v6K=y
-CONFIG_CPU_V7=y
-CONFIG_CPU_32v7=y
-CONFIG_CPU_ABRT_EV7=y
-CONFIG_CPU_PABRT_IFAR=y
-CONFIG_CPU_CACHE_V7=y
+CONFIG_CPU_V6=y
+# CONFIG_CPU_32v6K is not set
+CONFIG_CPU_32v6=y
+CONFIG_CPU_ABRT_EV6=y
+CONFIG_CPU_PABRT_NOIFAR=y
+CONFIG_CPU_CACHE_V6=y
 CONFIG_CPU_CACHE_VIPT=y
 CONFIG_CPU_COPY_V6=y
-CONFIG_CPU_TLB_V7=y
+CONFIG_CPU_TLB_V6=y
 CONFIG_CPU_HAS_ASID=y
 CONFIG_CPU_CP15=y
 CONFIG_CPU_CP15_MMU=y
@@ -205,17 +219,15 @@ CONFIG_CPU_CP15_MMU=y
 # Processor Features
 #
 CONFIG_ARM_THUMB=y
-# CONFIG_ARM_XENON is not set
 # CONFIG_CPU_ICACHE_DISABLE is not set
 # CONFIG_CPU_DCACHE_DISABLE is not set
-# CONFIG_CPU_L2CACHE_DISABLE is not set
 # CONFIG_CPU_BPREDICT_DISABLE is not set
-CONFIG_HAS_TLS_REG=y
 # CONFIG_OUTER_CACHE is not set
 
 #
 # Bus support
 #
+# CONFIG_PCI_SYSCALL is not set
 # CONFIG_ARCH_SUPPORTS_MSI is not set
 
 #
@@ -244,6 +256,8 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
 # CONFIG_LEDS is not set
 CONFIG_ALIGNMENT_TRAP=y
 
@@ -252,7 +266,7 @@ CONFIG_ALIGNMENT_TRAP=y
 #
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="root=/dev/nfs nfsroot=192.168.0.1:/home/user/buildroot ip=192.168.0.2:192.168.0.1:192.168.0.1:255.255.255.0:tgt:eth0:off rw console=ttyS2,115200n8"
+CONFIG_CMDLINE="root=/dev/ram0 rw console=ttyS0,115200n8 initrd=0x80600000,8M ramdisk_size=8192"
 # CONFIG_XIP_KERNEL is not set
 # CONFIG_KEXEC is not set
 
@@ -271,9 +285,7 @@ CONFIG_CMDLINE="root=/dev/nfs nfsroot=192.168.0.1:/home/user/buildroot ip=192.16
 CONFIG_FPE_NWFPE=y
 # CONFIG_FPE_NWFPE_XP is not set
 # CONFIG_FPE_FASTFPE is not set
-CONFIG_VFP=y
-CONFIG_VFPv3=y
-# CONFIG_NEON is not set
+# CONFIG_VFP is not set
 
 #
 # Userspace binary formats
@@ -286,6 +298,7 @@ CONFIG_BINFMT_MISC=y
 # Power management options
 #
 # CONFIG_PM is not set
+CONFIG_SUSPEND_UP_POSSIBLE=y
 
 #
 # Networking
@@ -310,8 +323,8 @@ CONFIG_INET=y
 CONFIG_IP_FIB_HASH=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
+# CONFIG_IP_PNP_BOOTP is not set
+# CONFIG_IP_PNP_RARP is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_ARPD is not set
@@ -360,7 +373,48 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
-# CONFIG_IRDA is not set
+CONFIG_IRDA=y
+
+#
+# IrDA protocols
+#
+CONFIG_IRLAN=y
+CONFIG_IRCOMM=y
+# CONFIG_IRDA_ULTRA is not set
+
+#
+# IrDA options
+#
+# CONFIG_IRDA_CACHE_LAST_LSAP is not set
+# CONFIG_IRDA_FAST_RR is not set
+# CONFIG_IRDA_DEBUG is not set
+
+#
+# Infrared-port device drivers
+#
+
+#
+# SIR device drivers
+#
+# CONFIG_IRTTY_SIR is not set
+
+#
+# Dongle support
+#
+
+#
+# Old SIR device drivers
+#
+# CONFIG_IRPORT_SIR is not set
+
+#
+# Old Serial dongle support
+#
+
+#
+# FIR device drivers
+#
+CONFIG_OMAP_IR=y
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
 
@@ -372,6 +426,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
 # CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -386,10 +441,6 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
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
@@ -460,30 +511,14 @@ CONFIG_MTD_OMAP_NOR=y
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
 # CONFIG_MTD_NAND is not set
-CONFIG_MTD_ONENAND=y
-CONFIG_MTD_ONENAND_VERIFY_WRITE=y
-# CONFIG_MTD_ONENAND_GENERIC is not set
-# CONFIG_MTD_ONENAND_OMAP2 is not set
-# CONFIG_MTD_ONENAND_OTP is not set
+# CONFIG_MTD_ONENAND is not set
 
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
@@ -500,29 +535,21 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
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
@@ -540,10 +567,6 @@ CONFIG_NETDEV_10000=y
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
-
-#
-# ISDN subsystem
-#
 # CONFIG_ISDN is not set
 
 #
@@ -551,6 +574,7 @@ CONFIG_NETDEV_10000=y
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
 
 #
 # Userland interfaces
@@ -571,6 +595,7 @@ CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_XTKBD is not set
 # CONFIG_KEYBOARD_NEWTON is not set
 # CONFIG_KEYBOARD_STOWAWAY is not set
+CONFIG_KEYBOARD_OMAP=y
 # CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
@@ -613,10 +638,6 @@ CONFIG_SERIAL_CORE=y
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
@@ -625,53 +646,75 @@ CONFIG_WATCHDOG_NOWAYOUT=y
 # Watchdog Device Drivers
 #
 # CONFIG_SOFT_WATCHDOG is not set
-CONFIG_HW_RANDOM=y
+CONFIG_OMAP_WATCHDOG=y
+CONFIG_HW_RANDOM=m
+CONFIG_HW_RANDOM_OMAP=m
 # CONFIG_NVRAM is not set
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+# CONFIG_I2C_CHARDEV is not set
 
 #
-# TPM devices
+# I2C Algorithms
 #
-# CONFIG_TCG_TPM is not set
-# CONFIG_I2C is not set
+# CONFIG_I2C_ALGOBIT is not set
+# CONFIG_I2C_ALGOPCF is not set
+# CONFIG_I2C_ALGOPCA is not set
 
 #
-# SPI support
+# I2C Hardware Bus support
 #
-# CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
+# CONFIG_I2C_GPIO is not set
+# CONFIG_I2C_OCORES is not set
+CONFIG_I2C_OMAP=y
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_TAOS_EVM is not set
+# CONFIG_I2C_STUB is not set
 
 #
-# Dallas's 1-wire bus
+# Miscellaneous I2C Chip support
 #
-# CONFIG_W1 is not set
-# CONFIG_HWMON is not set
+# CONFIG_SENSORS_DS1337 is not set
+# CONFIG_SENSORS_DS1374 is not set
+# CONFIG_DS1682 is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_ISP1301_OMAP is not set
+# CONFIG_TPS65010 is not set
+# CONFIG_SENSORS_TLV320AIC23 is not set
+CONFIG_GPIOEXPANDER_OMAP=y
+# CONFIG_TWL4030_CORE is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+CONFIG_MENELAUS=y
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
 
 #
-# Misc devices
+# SPI support
 #
-# CONFIG_BLINK is not set
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
+# CONFIG_W1 is not set
+# CONFIG_HWMON is not set
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
@@ -688,28 +731,58 @@ CONFIG_DAB=y
 #
 # CONFIG_DISPLAY_SUPPORT is not set
 # CONFIG_VGASTATE is not set
-# CONFIG_FB is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=m
+CONFIG_FB=y
+CONFIG_FIRMWARE_EDID=y
+# CONFIG_FB_DDC is not set
+# CONFIG_FB_CFB_FILLRECT is not set
+# CONFIG_FB_CFB_COPYAREA is not set
+# CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_SYS_FOPS is not set
+CONFIG_FB_DEFERRED_IO=y
+# CONFIG_FB_SVGALIB is not set
+# CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
+# CONFIG_FB_S1D13XXX is not set
+CONFIG_FB_OMAP=y
+# CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
+# CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
+CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
+# CONFIG_FB_VIRTUAL is not set
 
 #
 # Console display driver support
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+# CONFIG_FONTS is not set
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+CONFIG_LOGO=y
+# CONFIG_LOGO_LINUX_MONO is not set
+# CONFIG_LOGO_LINUX_VGA16 is not set
+CONFIG_LOGO_LINUX_CLUT224=y
 
 #
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
@@ -735,17 +808,27 @@ CONFIG_MMC=y
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
@@ -825,13 +908,10 @@ CONFIG_JFFS2_FS_DEBUG=0
 CONFIG_JFFS2_FS_WRITEBUFFER=y
 # CONFIG_JFFS2_SUMMARY is not set
 # CONFIG_JFFS2_FS_XATTR is not set
-CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
 CONFIG_JFFS2_ZLIB=y
 CONFIG_JFFS2_RTIME=y
 # CONFIG_JFFS2_RUBIN is not set
-# CONFIG_JFFS2_CMODE_NONE is not set
-CONFIG_JFFS2_CMODE_PRIORITY=y
-# CONFIG_JFFS2_CMODE_SIZE is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
@@ -862,7 +942,6 @@ CONFIG_RPCSEC_GSS_KRB5=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -952,6 +1031,7 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
 CONFIG_DETECT_SOFTLOCKUP=y
+CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
@@ -961,11 +1041,12 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_LOCK_ALLOC is not set
 # CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
-CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
 CONFIG_FRAME_POINTER=y
@@ -982,10 +1063,6 @@ CONFIG_DEBUG_LL=y
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
@@ -1023,10 +1100,7 @@ CONFIG_CRYPTO_DES=y
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
@@ -1036,6 +1110,7 @@ CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
 CONFIG_LIBCRC32C=y
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y
-- 
1.5.3.1.91.gd3392
