From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [PATCH 10/14] Update arch/arm/configs/omap_h4_2420_defconfig
Date: Tue, 18 Sep 2007 13:56:46 -0400
Message-ID: <11901382121603-git-send-email-felipe.lima@indt.org.br>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11901382123807-git-send-email-felipe.lima@indt.org.br>
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

Update arch/arm/configs/omap_h4_2420_defconfig

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---
 arch/arm/configs/omap_h4_2420_defconfig |  358 +++++++++++++-----------------
 1 files changed, 155 insertions(+), 203 deletions(-)

diff --git a/arch/arm/configs/omap_h4_2420_defconfig b/arch/arm/configs/omap_h4_2420_defconfig
index 8ef2d68..5bc8918 100644
--- a/arch/arm/configs/omap_h4_2420_defconfig
+++ b/arch/arm/configs/omap_h4_2420_defconfig
@@ -1,12 +1,18 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20-omap1
-# Sat Feb 17 00:17:16 2007
+# Linux kernel version: 2.6.23-rc6-omap1
+# Tue Sep 18 11:44:58 2007
 #
 CONFIG_ARM=y
+CONFIG_SYS_SUPPORTS_APM_EMULATION=y
+CONFIG_GENERIC_GPIO=y
 CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_MMU=y
+# CONFIG_NO_IOPORT is not set
 CONFIG_GENERIC_HARDIRQS=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 CONFIG_HARDIRQS_SW_RESEND=y
 CONFIG_GENERIC_IRQ_PROBE=y
@@ -15,33 +21,32 @@ CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_ZONE_DMA=y
 CONFIG_VECTORS_BASE=0xffff0000
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
+CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
+# CONFIG_USER_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
@@ -57,32 +62,30 @@ CONFIG_BUG=y
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
@@ -114,13 +117,16 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
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
+# CONFIG_ARCH_NS9XXX is not set
+# CONFIG_ARCH_MXC is not set
 # CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
 # CONFIG_ARCH_RPC is not set
@@ -128,6 +134,7 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # CONFIG_ARCH_S3C2410 is not set
 # CONFIG_ARCH_SHARK is not set
 # CONFIG_ARCH_LH7A40X is not set
+# CONFIG_ARCH_DAVINCI is not set
 CONFIG_ARCH_OMAP=y
 
 #
@@ -136,6 +143,7 @@ CONFIG_ARCH_OMAP=y
 CONFIG_ARCH_OMAP_OTG=y
 # CONFIG_ARCH_OMAP1 is not set
 CONFIG_ARCH_OMAP2=y
+# CONFIG_ARCH_OMAP3 is not set
 
 #
 # OMAP Feature Selections
@@ -151,6 +159,8 @@ CONFIG_OMAP_MUX_DEBUG=y
 CONFIG_OMAP_MUX_WARNINGS=y
 # CONFIG_OMAP_STI is not set
 CONFIG_OMAP_MCBSP=y
+# CONFIG_OMAP_MMU_FWK is not set
+# CONFIG_OMAP_MBOX_FWK is not set
 CONFIG_OMAP_MPU_TIMER=y
 # CONFIG_OMAP_32K_TIMER is not set
 CONFIG_OMAP_DM_TIMER=y
@@ -173,11 +183,20 @@ CONFIG_ARCH_OMAP2420=y
 #
 # CONFIG_MACH_NOKIA_N800 is not set
 CONFIG_MACH_OMAP_H4=y
-# CONFIG_MACH_OMAP_2430SDP is not set
 # CONFIG_MACH_OMAP_H4_TUSB is not set
 # CONFIG_MACH_OMAP_H4_OTG is not set
 # CONFIG_MACH_OMAP2_H4_USB1 is not set
 # CONFIG_MACH_OMAP_APOLLON is not set
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
@@ -187,10 +206,12 @@ CONFIG_CPU_V6=y
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
 
@@ -200,12 +221,14 @@ CONFIG_CPU_CP15_MMU=y
 CONFIG_ARM_THUMB=y
 # CONFIG_CPU_ICACHE_DISABLE is not set
 # CONFIG_CPU_DCACHE_DISABLE is not set
-# CONFIG_CPU_DCACHE_WRITETHROUGH is not set
 # CONFIG_CPU_BPREDICT_DISABLE is not set
+# CONFIG_OUTER_CACHE is not set
 
 #
 # Bus support
 #
+# CONFIG_PCI_SYSCALL is not set
+# CONFIG_ARCH_SUPPORTS_MSI is not set
 
 #
 # PCCARD (PCMCIA/CardBus) support
@@ -215,8 +238,10 @@ CONFIG_ARM_THUMB=y
 #
 # Kernel Features
 #
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
 # CONFIG_PREEMPT is not set
-# CONFIG_NO_IDLE_HZ is not set
 CONFIG_HZ=100
 CONFIG_AEABI=y
 CONFIG_OABI_COMPAT=y
@@ -230,6 +255,9 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
 # CONFIG_LEDS is not set
 CONFIG_ALIGNMENT_TRAP=y
 
@@ -240,6 +268,7 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/ram0 rw console=ttyS0,115200n8 initrd=0x80600000,8M ramdisk_size=8192"
 # CONFIG_XIP_KERNEL is not set
+# CONFIG_KEXEC is not set
 
 #
 # CPU Frequency scaling
@@ -269,7 +298,7 @@ CONFIG_BINFMT_MISC=y
 # Power management options
 #
 # CONFIG_PM is not set
-# CONFIG_APM is not set
+CONFIG_SUSPEND_UP_POSSIBLE=y
 
 #
 # Networking
@@ -279,14 +308,15 @@ CONFIG_NET=y
 #
 # Networking options
 #
-# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
 # CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
 CONFIG_NET_KEY=y
+# CONFIG_NET_KEY_MIGRATE is not set
 CONFIG_INET=y
 # CONFIG_IP_MULTICAST is not set
 # CONFIG_IP_ADVANCED_ROUTER is not set
@@ -318,20 +348,8 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
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
@@ -398,7 +416,17 @@ CONFIG_IRCOMM=y
 #
 CONFIG_OMAP_IR=y
 # CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -411,16 +439,9 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 # CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
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
 CONFIG_MTD_CONCAT=y
@@ -465,7 +486,6 @@ CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
 # CONFIG_MTD_ROM is not set
 # CONFIG_MTD_ABSENT is not set
-# CONFIG_MTD_OBSOLETE_CHIPS is not set
 
 #
 # Mapping drivers for chip access
@@ -490,29 +510,15 @@ CONFIG_MTD_OMAP_NOR=y
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
 # CONFIG_MTD_ONENAND is not set
 
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
-
-#
-# Block devices
-#
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
@@ -521,7 +527,6 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=16384
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
@@ -530,73 +535,31 @@ CONFIG_BLK_DEV_INITRD=y
 #
 # CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
 # CONFIG_SCSI_NETLINK is not set
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
 # CONFIG_TUN is not set
-
-#
-# PHY device support
-#
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
+CONFIG_NETDEV_1000=y
+CONFIG_NETDEV_10000=y
 
 #
-# Ethernet (1000 Mbit)
-#
-
-#
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
-# CONFIG_NET_RADIO is not set
-
-#
-# Wan interfaces
+# Wireless LAN
 #
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
 # CONFIG_WAN is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
@@ -604,10 +567,6 @@ CONFIG_SMC91X=y
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
-
-#
-# ISDN subsystem
-#
 # CONFIG_ISDN is not set
 
 #
@@ -615,6 +574,7 @@ CONFIG_SMC91X=y
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
 
 #
 # Userland interfaces
@@ -636,8 +596,10 @@ CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_NEWTON is not set
 # CONFIG_KEYBOARD_STOWAWAY is not set
 CONFIG_KEYBOARD_OMAP=y
+# CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
 # CONFIG_INPUT_MISC is not set
 
@@ -676,15 +638,7 @@ CONFIG_SERIAL_CORE=y
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
 
@@ -695,21 +649,12 @@ CONFIG_WATCHDOG_NOWAYOUT=y
 CONFIG_OMAP_WATCHDOG=y
 CONFIG_HW_RANDOM=m
 CONFIG_HW_RANDOM_OMAP=m
-# CONFIG_OMAP_RNG is not set
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
@@ -722,17 +667,20 @@ CONFIG_I2C=y
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
@@ -741,9 +689,10 @@ CONFIG_I2C_OMAP=y
 # CONFIG_TPS65010 is not set
 # CONFIG_SENSORS_TLV320AIC23 is not set
 CONFIG_GPIOEXPANDER_OMAP=y
-CONFIG_MENELAUS=y
 # CONFIG_TWL4030_CORE is not set
 # CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+CONFIG_MENELAUS=y
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
@@ -754,65 +703,61 @@ CONFIG_MENELAUS=y
 #
 # CONFIG_SPI is not set
 # CONFIG_SPI_MASTER is not set
-
-#
-# Dallas's 1-wire bus
-#
 # CONFIG_W1 is not set
-
-#
-# Hardware Monitoring support
-#
 # CONFIG_HWMON is not set
-# CONFIG_HWMON_VID is not set
-
-#
-# Misc devices
-#
-# CONFIG_TIFM_CORE is not set
+CONFIG_MISC_DEVICES=y
+# CONFIG_EEPROM_93CX6 is not set
 
 #
-# LED devices
+# Multifunction device drivers
 #
+# CONFIG_MFD_SM501 is not set
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
+# CONFIG_DVB_CORE is not set
+CONFIG_DAB=y
 
 #
-# Digital Video Broadcasting Devices
+# Graphics support
 #
-# CONFIG_DVB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
-# Graphics support
+# Display device support
 #
-CONFIG_FIRMWARE_EDID=y
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_VGASTATE is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
+CONFIG_FIRMWARE_EDID=y
+# CONFIG_FB_DDC is not set
 # CONFIG_FB_CFB_FILLRECT is not set
 # CONFIG_FB_CFB_COPYAREA is not set
 # CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_SYS_FOPS is not set
+CONFIG_FB_DEFERRED_IO=y
+# CONFIG_FB_SVGALIB is not set
 # CONFIG_FB_MACMODES is not set
 # CONFIG_FB_BACKLIGHT is not set
 # CONFIG_FB_MODE_HELPERS is not set
 # CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
 # CONFIG_FB_S1D13XXX is not set
-# CONFIG_FB_VIRTUAL is not set
 CONFIG_FB_OMAP=y
 # CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
-# CONFIG_FB_OMAP_LCD_MIPID is not set
 # CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
 CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
+# CONFIG_FB_VIRTUAL is not set
 
 #
 # Console display driver support
@@ -820,33 +765,24 @@ CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
 # CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
 # CONFIG_FONTS is not set
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
-
-#
-# Logo configuration
-#
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_LOGO_LINUX_CLUT224=y
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
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
-
-#
-# USB support
-#
+# CONFIG_HID_DEBUG is not set
+CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 # CONFIG_USB_ARCH_HAS_EHCI is not set
@@ -864,26 +800,35 @@ CONFIG_USB_ARCH_HAS_OHCI=y
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
+CONFIG_MMC=y
+# CONFIG_MMC_DEBUG is not set
+# CONFIG_MMC_UNSAFE_RESUME is not set
 
 #
-# MMC/SD Card support
+# MMC/SD Card Drivers
 #
-CONFIG_MMC=y
-# CONFIG_MMC_DEBUG is not set
 CONFIG_MMC_BLOCK=y
-CONFIG_MMC_OMAP=y
-# CONFIG_MMC_TIFM_SD is not set
+CONFIG_MMC_BLOCK_BOUNCE=y
 
 #
-# Real Time Clock
+# MMC/SD Host Controller Drivers
 #
+CONFIG_MMC_OMAP=y
 CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
 
 #
-# Synchronous Serial Interfaces (SSI)
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
-# CONFIG_OMAP_TSC2101 is not set
 
 #
 # CBUS support
@@ -989,6 +934,7 @@ CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 CONFIG_SUNRPC_GSS=y
+# CONFIG_SUNRPC_BIND34 is not set
 CONFIG_RPCSEC_GSS_KRB5=y
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -996,7 +942,6 @@ CONFIG_RPCSEC_GSS_KRB5=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -1018,6 +963,7 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_SUN_PARTITION is not set
 # CONFIG_KARMA_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
+# CONFIG_SYSV68_PARTITION is not set
 
 #
 # Native Language Support
@@ -1083,15 +1029,19 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
-CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_DEBUG_SHIRQ is not set
 CONFIG_DETECT_SOFTLOCKUP=y
+CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 CONFIG_DEBUG_MUTEXES=y
-# CONFIG_DEBUG_RWSEMS is not set
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
@@ -1102,6 +1052,7 @@ CONFIG_DEBUG_MUTEXES=y
 CONFIG_FRAME_POINTER=y
 CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
 # CONFIG_DEBUG_USER is not set
 # CONFIG_DEBUG_ERRORS is not set
 CONFIG_DEBUG_LL=y
@@ -1112,10 +1063,6 @@ CONFIG_DEBUG_LL=y
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
@@ -1133,8 +1080,11 @@ CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_GF128MUL is not set
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_CRYPTD is not set
 CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_FCRYPT is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set
 # CONFIG_CRYPTO_SERPENT is not set
@@ -1148,11 +1098,9 @@ CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_DEFLATE is not set
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_TEST is not set
-
-#
-# Hardware crypto devices
-#
+CONFIG_CRYPTO_HW=y
 
 #
 # Library routines
@@ -1160,9 +1108,13 @@ CONFIG_CRYPTO_DES=y
 CONFIG_BITREVERSE=y
 CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
 CONFIG_LIBCRC32C=y
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y
 CONFIG_PLIST=y
-CONFIG_IOMAP_COPY=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
-- 
1.5.3.1.91.gd3392
